//
//  HLSocket.h
//  HandLess
//
//  Created by Stefan Lage on 09/02/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HLProduct.h"
#import "HLOrder.h"

@protocol HLSocketDelegate;

@interface HLSocket : NSObject <NSStreamDelegate>{
    NSInputStream *inputStream;
    NSOutputStream *outputStream;
}

+(HLSocket*)socket;

@property (strong, nonatomic) id<HLSocketDelegate> delegate;
// Get datas
-(void)getProducts;
-(void)getProduct:(NSString*)identifier;
-(void)getOrders;
-(void)getOrder:(NSString*)identifier;
// Send data
-(void)addOrder:(NSArray*)products;
-(void)updateOrder:(NSString*)identifier status:(NSString*)status;
@end


@protocol HLSocketDelegate <NSObject>

@optional
// Get datas
-(void)didGetProducts:(NSArray*)products;
-(void)didGetProduct:(HLProduct*)product;
-(void)didGetOrders:(NSArray*)orders;
-(void)didGetOrder:(HLOrder*)order;
// Send data
-(void)didOrdered:(BOOL)value;
-(void)didUpdateOrder:(BOOL)value;

@end
