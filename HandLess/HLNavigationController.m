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
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        leap = [[HLLeapController alloc] initWithDelegate:rootViewController];
    }
    return self;
}

// Return view on top of the stack
- (NSView*)view{
    return [super view];
}

-(NSView *)mainView{
    return [[self view] superview];
}

// Add viewController to the top of the stack
// TODO - Add animation using an arg like "animated:(BOOL)animated"
- (void)pushViewController:(HLViewController*)viewController{
    [super pushViewController:viewController];
}

- (void)pushViewController:(HLViewController*)viewController delegate:(BOOL)delegate{
    [super pushViewController:viewController];
    if(delegate)
        [leap setDelegate:viewController];
}

// Return to penultimate viewController
// TODO - Add animation using an arg like "animated:(BOOL)animated"
- (HLViewController*)popViewController{
    HLViewController *topViewController = [super popViewController];
    [leap setDelegate:topViewController];
    return topViewController;
}

// Add last view in frontView of its parent
- (void)addTopView
{
    // Get last controller in the stack
    HLViewController *top = [self.viewControllerStack objectAtIndex:[self.viewControllerStack count] - 1];
    HLMainWindow *main = [[Singleton manager]mainWindow];
    [main.window.contentView addSubview:top.view];
}

-(void)setLeapDelegate:(HLViewController*) viewController{
    leap.delegate = viewController;
}

@end
