//
//  HLBeverageViewController.h
//  HandLess
//
//  Created by Stefan Lage on 28/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import "HLOrderViewController.h"
#import "HLMenuView.h"

@interface HLBeverageViewController : HLOrderViewController <HLSocketDelegate>{
    BOOL lock;
}

@property (strong, nonatomic) HLMenuView *beverageView;

@end
