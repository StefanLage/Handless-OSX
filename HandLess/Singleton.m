//
//  Singleton.m
//  HandLess
//
//  Created by Stefan Lage on 21/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import "Singleton.h"
#import "HLAppDelegate.h"

static Singleton *unique = nil;

@implementation Singleton

+(Singleton*)manager{
    @synchronized(self){
        if(unique == nil)
            unique = [[Singleton alloc] init];
    }
    return unique;
}

-(HLNavigationController*)navigationController{
    return [[(HLAppDelegate *)[NSApp delegate] mainWindow] navigationController];
}

-(HLMainWindow*)mainWindow{
    return [(HLAppDelegate *)[NSApp delegate] mainWindow];
}

@end
