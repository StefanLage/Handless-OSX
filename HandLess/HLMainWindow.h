//
//  HLMainWindow.h
//  HandLess
//
//  Created by Stefan Lage on 21/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HLDashboardViewController.h"

@interface HLMainWindow : NSWindowController

@property (strong, nonatomic) HLDashboardViewController *dashboard;
@property (strong, nonatomic) HLNavigationController *navigationController;

@end
