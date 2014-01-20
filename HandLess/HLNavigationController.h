//
//  HLNavigationController.h
//  HandLess
//
//  Created by Stefan Lage on 20/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class HLViewController;

@interface HLNavigationController : NSResponder

@property (nonatomic, strong) HLViewController *rootViewController;
@property (nonatomic, strong) NSMutableArray *viewControllerStack;

- (id)initWithRootViewController:(HLViewController*)rootViewController;
- (NSView*)view;
- (void)pushViewController:(HLViewController*)viewController;
- (HLViewController*)popViewController;

@end
