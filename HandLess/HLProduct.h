//
//  HLProduct.h
//  socket
//
//  Created by Stefan Lage on 11/02/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLProduct : NSObject

@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *price;
@property (strong, nonatomic) NSString *category;

@end
