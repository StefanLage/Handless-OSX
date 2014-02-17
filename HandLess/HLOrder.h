//
//  HLOrders.h
//  socket
//
//  Created by Stefan Lage on 12/02/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLOrder : NSObject

@property (strong, nonatomic) NSString *identifier;
@property (strong ,nonatomic) NSString *status;
@property (strong, nonatomic) NSArray *products;

@end
