//
//  HLNavigationController.h
//  HandLess
//
//  Created by Stefan Lage on 20/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSNavigationController.h"
#import "HLLeapController.h"

@interface HLNavigationController : NSNavigationController{
    HLLeapController *leap;
}
-(void)setLeapDelegate:(HLViewController*) viewController;
- (void)pushViewController:(HLViewController*)viewController delegate:(BOOL)delegate;
@end
