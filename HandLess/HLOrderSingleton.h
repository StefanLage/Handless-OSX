//
//  HLOrderSingleton.h
//  HandLess
//
//  Created by Stefan Lage on 22/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLOrderSingleton : NSObject

@property (strong, nonatomic) HLProduct *menu;
@property (strong, nonatomic) HLProduct *beverage;
@property (strong, nonatomic) HLProduct *dessert;

@property (strong, nonatomic) NSNumber *iM;
@property (strong, nonatomic) NSNumber *iB;
@property (strong, nonatomic) NSNumber *iD;

+(HLOrderSingleton*) order;

@end
