//
//  HLViewController.h
//  HandLess
//
//  Created by Stefan Lage on 20/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HLLeapController.h"

@class NSNavigationController;

@interface HLViewController : NSViewController <NSCoding, HLLeapControllerDelegate>
@property (nonatomic, weak) NSNavigationController *navigationController;

- (void)viewDidLoad;
- (void)viewWillAppear;
- (void)viewWillDisappear;
- (void)viewDidAppear;
- (void)viewDidDisappear;

@end
