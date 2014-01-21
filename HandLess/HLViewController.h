//
//  HLViewController.h
//  HandLess
//
//  Created by Stefan Lage on 20/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class HLNavigationController;

@interface HLViewController : NSViewController
@property (nonatomic, weak) HLNavigationController *navigationController;

- (void)viewDidLoad;
- (void)viewWillAppear;
- (void)viewWillDisappear;
- (void)viewDidAppear;
- (void)viewDidDisappear;

@end
