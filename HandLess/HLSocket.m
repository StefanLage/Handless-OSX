//
//  HLSocket.m
//  HandLess
//
//  Created by Stefan Lage on 09/02/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import "HLSocket.h"

#define GET_PRODUCTS        @"getProducts"
#define GET_PRODUCT         @"getProduct"
#define GET_ORDERS          @"getOrders"
#define GET_ORDER           @"getOrder"
#define ADD_ORDER           @"addOrder"
#define UPDATE_ORDER        @"updateOrder"

static HLSocket *unique = nil;

@implementation HLSocket

+(HLSocket*)socket{
    @synchronized(self){
        if(unique == nil)
            unique = [[HLSocket alloc] init];
    }
    return unique;
}

-(id)init{
    self = [super init];
    if(self){
        // Open connection
        [self initNetworkCommunication];
        [inputStream setDelegate:self];
        [outputStream setDelegate:self];
        // Run LOOP
        [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2.0]];
        // Open connections
        [inputStream open];
        [outputStream open];
    }
    return self;
}

- (void)initNetworkCommunication {
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"fabrique-web.fr", 9225, &readStream, &writeStream);
    inputStream = (__bridge NSInputStream *)readStream;
    outputStream = (__bridge NSOutputStream *)writeStream;
}


- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
    switch (streamEvent) {
		case NSStreamEventOpenCompleted:
			NSLog(@"Stream opened");
			break;
		case NSStreamEventHasBytesAvailable:
            sleep(0);
            uint8_t buffer[1000*1024];
            NSInteger len;
            while ([inputStream hasBytesAvailable]) {
                len = [inputStream read:buffer maxLength:sizeof(buffer)];
                if (len > 0) {
                    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[NSData dataWithBytes:buffer length:len] options:0 error:nil];
                    if([json[@"event"] isEqualToString:GET_PRODUCTS]){
                        if([self.delegate respondsToSelector:@selector(didGetProducts:)])
                            [self.delegate didGetProducts:[self sortProducts:json]];
                    }
                    else if([json[@"event"] isEqualToString:GET_ORDERS]){
                        if([self.delegate respondsToSelector:@selector(didGetProducts:)])
                            [self.delegate didGetOrders:[self sortOrders:json]];
                    }
                    else if([json[@"event"] isEqualToString:GET_PRODUCT]){
                        if([self.delegate respondsToSelector:@selector(didGetProduct:)])
                            [self.delegate didGetProduct:[self sortProduct:json[@"data"]]];
                    }
                    else if([json[@"event"] isEqualToString:GET_ORDER]){
                        if([self.delegate respondsToSelector:@selector(didGetProducts:)])
                            [self.delegate didGetOrder:[self sortOrder:json[@"data"]]];
                    }
                    else if([json[@"event"] isEqualToString:ADD_ORDER]){
                        if([self.delegate respondsToSelector:@selector(didGetProducts:)])
                            [self.delegate didOrdered:[self isOrdered_Updated:json]];
                    }
                    else if([json[@"event"] isEqualToString:UPDATE_ORDER]){
                        if([self.delegate respondsToSelector:@selector(didGetProducts:)])
                            [self.delegate didUpdateOrder:[self isOrdered_Updated:json]];
                    }
                    else{
                        NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
                        if (nil != output)
                            NSLog(@"server said: %@", output);
                    }
                }
            }
			break;
		case NSStreamEventErrorOccurred:
			NSLog(@"Can not connect to the host!");
			break;
		case NSStreamEventEndEncountered:
            [theStream close];
            [theStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
			break;
		default:
			NSLog(@"Unknown event");
	}
}

#pragma Get datas

// Get all products
-(void)getProducts{
    NSDictionary *query = @{
                            @"entity" : @"product",
                            @"event" : @"getProducts"
                            };
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:query
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
	[outputStream write:[jsonData bytes] maxLength:[jsonData length]];
}

-(void)getProduct:(NSString*)identifier{
    NSDictionary *query = @{
                            @"entity" : @"product",
                            @"event" : @"getProducts",
                            @"productId" : identifier
                            };
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:query
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
	[outputStream write:[jsonData bytes] maxLength:[jsonData length]];
}

// Get all orders
-(void)getOrders{
    NSDictionary *query = @{
                            @"entity" : @"order",
                            @"event" : @"getOrders"
                            };
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:query
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
	[outputStream write:[jsonData bytes] maxLength:[jsonData length]];
}

-(void)getOrder:(NSString*)identifier{
    NSDictionary *query = @{
                            @"entity" : @"order",
                            @"event" : @"getOrder",
                            @"orderId" : identifier
                            };
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:query
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
	[outputStream write:[jsonData bytes] maxLength:[jsonData length]];
}

#pragma Send datas

-(void)addOrder:(NSArray*)products{
    if(!products || products.count == 0)
        return;
    NSDictionary *query = @{
                            @"entity" : @"order",
                            @"event" : @"getOrder",
                            @"data" : products
                            };
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:query
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
	[outputStream write:[jsonData bytes] maxLength:[jsonData length]];
}

-(void)updateOrder:(NSString*)identifier status:(NSString*)status{
    NSDictionary *data = @{
                           @"orderId" : identifier,
                           @"status" : status
                           };
    NSDictionary *query = @{
                           @"entity" : @"order",
                           @"event" : @"updateOrder",
                           @"data" : data
                           };
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:query
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
	[outputStream write:[jsonData bytes] maxLength:[jsonData length]];
}

-(BOOL)isOrdered_Updated:(NSDictionary*)json{
    if (json != nil){
        if(json[@"success"] == [NSNumber numberWithBool:YES])
            return YES;
        else
            return NO;
    }
    return NO;
}


#pragma Sort datas

// Get All Products
-(NSMutableArray*)sortProducts:(NSDictionary*)json{
    NSMutableArray *result;
    if (json != nil){
        result = [[NSMutableArray alloc] init];
        for (NSDictionary *product in json[@"data"]){
            HLProduct *pr = [self sortProduct:product];
            [result addObject:pr];
        }
        NSLog(@"cc %lu", (unsigned long)result.count);
    }
    return result;
}

// Get Product X
-(HLProduct *)sortProduct:(NSDictionary*)json{
    HLProduct *product;
    if (json != nil){
        product = [[HLProduct alloc] init];
        [product setIdentifier: json[@"_id"]];
        [product setName: json[@"name"]];
        [product setCategory: json[@"category"]];
        [product setPrice: json[@"price"]];
    }
    return product;
}

// Get All Orders
-(NSMutableArray*)sortOrders:(NSDictionary*)json{
    NSLog(@"server said: %@", json);
    NSMutableArray *result;
    if (json != nil){
        result = [[NSMutableArray alloc] init];
        for (NSDictionary *order in json[@"data"])
            [result addObject:[self sortOrder:order]];
    }
    return result;
}

// Get Order X
-(HLOrder*)sortOrder:(NSDictionary*)json{
    HLOrder *order;
    NSMutableArray *products;
    if (json != nil){
        order = [[HLOrder alloc] init];
        products = [[NSMutableArray alloc] init];
        [order setIdentifier: json[@"data"][@"_id"]];
        [order setStatus:json[@"data"][@"status"]];
        for(NSDictionary *product in json[@"data"][@"products"]){
            HLProduct *new_product = [[HLProduct alloc] init];
            [new_product setIdentifier: product[@"_id"]];
            NSDictionary * prod = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects: new_product, product[@"quantity"], nil]
                                                              forKeys:[NSArray arrayWithObjects: @"product", @"quantity", nil]];
            [products addObject:prod];
        }
        [order setProducts:products];
    }
    return  order;
}

@end

