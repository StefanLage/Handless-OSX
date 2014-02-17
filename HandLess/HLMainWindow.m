//
//  HLMainWindow.m
//  HandLess
//
//  Created by Stefan Lage on 21/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import "HLMainWindow.h"

@interface HLMainWindow ()

@end

@implementation HLMainWindow

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
        _dashboard = [[HLDashboardViewController alloc] initWithNibName:@"HLDashboardViewController" bundle:nil];
        _navigationController = [[HLNavigationController alloc] initWithRootViewController:self.dashboard];
        //[self.window setContentView:self.dashboard.view];
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    [self.window setViewsNeedDisplay:YES];
    [self.window.contentView replaceSubview:[[self.window.contentView subviews] objectAtIndex:0] with:self.dashboard.view];
}


- (void)windowDidBecomeMain:(NSNotification *)notification
{
    static BOOL shouldGoFullScreen = YES;
    if (shouldGoFullScreen) {
        if (!([self.window styleMask] & NSFullScreenWindowMask))
            [self.window toggleFullScreen:nil];
        shouldGoFullScreen = NO;
    }
}

- (BOOL)canBecomeKeyWindow{
    return NO;
}

@end
