//
//  HLNewOrderViewController.h
//  HandLess
//
//  Created by Stefan Lage on 21/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import "HLViewController.h"
#import "HLMenuViewController.h"
#import "HLBeverageViewController.h"
#import "HLDessertViewController.h"

@interface HLNewOrderViewController : HLViewController <HLOrderViewControllerDelegate, HLSocketDelegate>{
    
}

@property (strong, nonatomic) NSProgressIndicator *progress;
@property (strong, nonatomic) NSMutableDictionary *dataSourceMenu;
@property (strong, nonatomic) NSMutableDictionary *dataSourceBeverage;
@property (strong, nonatomic) NSMutableDictionary *dataSourceDessert;
@property (strong, nonatomic) HLMenuViewController *menu;
@property (strong, nonatomic) HLBeverageViewController *beverage;
@property (strong, nonatomic) HLDessertViewController *dessert;

@end
