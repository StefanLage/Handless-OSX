//
//  NSNavigationController.h
//  HandLess
//
//  Created by Stefan Lage on 21/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>

@class HLViewController;

@interface NSNavigationController : NSResponder{
    CATransition *transition;
}

@property (nonatomic, strong) HLViewController *rootViewController;
@property (nonatomic, strong) NSMutableArray *viewControllerStack;

- (id)initWithRootViewController:(HLViewController*)rootViewController;
- (NSView*)view;
- (void)pushViewController:(HLViewController*)viewController;
- (HLViewController*)popViewController;

@end
