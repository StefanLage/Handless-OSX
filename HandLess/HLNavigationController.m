//
//  HLNavigationController.m
//  HandLess
//
//  Created by Stefan Lage on 20/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import "HLNavigationController.h"
#import "HLAppDelegate.h"
#import "HLViewController.h"

@implementation HLNavigationController

- (id)initWithRootViewController:(HLViewController *)rootViewController{
    self = [super init];
    if (self) {
        self.rootViewController = rootViewController;
        self.rootViewController.navigationController = self;
        self.viewControllerStack = [[NSMutableArray alloc] initWithObjects:self.rootViewController, nil];
    }
    return self;
}

// Return view on top of the stack
- (NSView*)view{
    HLViewController *topController = [self.viewControllerStack objectAtIndex:[self.viewControllerStack count] - 1];
    return topController.view;
}

// Add viewController to the top of the stack
// TODO - Add animation using an arg like "animated:(BOOL)animated"
- (void)pushViewController:(HLViewController*)viewController{
    if (viewController) {
        [self removeTopView];
        [self.viewControllerStack addObject:viewController];
        viewController.navigationController = self;
        [self addTopView];
    }
}

// Return to penultimate viewController
// TODO - Add animation using an arg like "animated:(BOOL)animated"
- (HLViewController*)popViewController{
    HLViewController *topViewController = [self.viewControllerStack objectAtIndex:[self.viewControllerStack count] - 1];
    [self removeTopView];
    [self.viewControllerStack removeLastObject];
    [self addTopView];
    return topViewController;
}

// Remove top view to its parent
- (void)removeTopView
{
    HLViewController *topController = [self.viewControllerStack objectAtIndex:[self.viewControllerStack count] - 1];
    [topController.view removeFromSuperview];
}

// Add last view in frontView of its parent
- (void)addTopView
{
    // Get last controller in the stack
    HLViewController *top = [self.viewControllerStack objectAtIndex:[self.viewControllerStack count] - 1];
    HLAppDelegate *appDelegate = (HLAppDelegate*)[NSApp delegate];
    [appDelegate.window.contentView addSubview:top.view];
}
@end
