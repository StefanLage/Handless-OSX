//
//  HLDashboardView.h
//  HandLess
//
//  Created by Stefan Lage on 21/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface HLDashboardView : NSView

@property(strong, nonatomic) NSButton *createOrder;
@property(strong, nonatomic) NSButton *cancelOrder;
-(void)highlightButton:(BOOL)create;
@end
