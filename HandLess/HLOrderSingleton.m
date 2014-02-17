//
//  HLOrderSingleton.m
//  HandLess
//
//  Created by Stefan Lage on 22/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import "HLOrderSingleton.h"

static HLOrderSingleton *unique = nil;

@implementation HLOrderSingleton

+(HLOrderSingleton*) order{
    @synchronized(self){
        if(unique == nil)
            unique = [[HLOrderSingleton alloc] init];
    }
    return unique;
}

@end
