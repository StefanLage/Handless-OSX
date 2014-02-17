//
//  HLMenuView.h
//  HandLess
//
//  Created by Stefan Lage on 23/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface HLMenuView : NSView
@property(strong, nonatomic) NSTableView *tableView;
//@property(strong, nonatomic) HLtestView *tableView;
@property(strong, nonatomic) NSButton *createOrder;
@end
