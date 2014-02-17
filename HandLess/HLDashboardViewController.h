//
//  HLDashboardViewController.h
//  HandLess
//
//  Created by Stefan Lage on 21/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import "HLViewController.h"
#import "HLNewOrderViewController.h"
#import "HLDashboardView.h"
#import "HLMenuViewController.h"

@interface HLDashboardViewController : HLViewController <HLLeapControllerDelegate>{
    HLDashboardView *dashView;
    float mid;
    BOOL needCreate;
    HLMenuView *menuView;
}

@end
