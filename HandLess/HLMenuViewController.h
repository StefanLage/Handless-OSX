//
//  HLMenuViewController.h
//  HandLess
//
//  Created by Stefan Lage on 23/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import "HLOrderViewController.h"
#import "HLMenuView.h"

@interface HLMenuViewController : HLOrderViewController <HLSocketDelegate>{
    float lastPosition;
    NSInteger lastIndex;
    BOOL lock;
}

@property (strong, nonatomic) HLMenuView *menuView;
@end
