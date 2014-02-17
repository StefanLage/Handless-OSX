//
//  HLNewOrderViewController.m
//  HandLess
//
//  Created by Stefan Lage on 21/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import "HLNewOrderViewController.h"
#import "HLDashboardViewController.h"
#import "HLView.h"
#import "HLAppDelegate.h"

@interface HLNewOrderViewController (){
    HLDashboardViewController *dashboard;
}

@end

@implementation HLNewOrderViewController

@synthesize menu, beverage, dessert;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        menu = [[HLMenuViewController alloc] initWithNibName:@"HLMenuViewController" bundle:nil];
        menu.delegate = self;

        beverage = [[HLBeverageViewController alloc] initWithNibName:@"HLBeverageViewController" bundle:nil];
        beverage.delegate = self;
        
        dessert = [[HLDessertViewController alloc] initWithNibName:@"HLDessertViewController" bundle:nil];
        dessert.delegate = self;
        //menu.view setS
        [[HLSocket socket] setDelegate:self];
        [[HLSocket socket] getProducts];
    }
    return self;
}

-(void)loadView{
    [self setView:[[HLView alloc] initWithFrame:CGRectMake(0, 0, [Singleton manager].mainWindow.window.frame.size.width, [Singleton manager].mainWindow.window.frame.size.height)]];
    [self.view addSubview:self.menu.view];
    [self.view addSubview:self.beverage.view];
    [self.view addSubview:self.dessert.view];
    [[Singleton manager].navigationController setLeapDelegate:self.menu];
}

-(void)didSwipe:(HLOrderViewController*)controller{
    if(controller == menu){
        NSLog(@"Menu : %@", [HLOrderSingleton order].menu);
        [[Singleton manager].navigationController setLeapDelegate:beverage];
        //[menu setDisable];
    }
    else if(controller == beverage){
        NSLog(@"Beverage");
        [[Singleton manager].navigationController setLeapDelegate:dessert];
    }
    else if(controller == dessert){
        NSDictionary *prod_menu = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects: [HLOrderSingleton order].menu.identifier, [NSNumber numberWithInt:1], nil]
                                                              forKeys:[NSArray arrayWithObjects: @"id", @"quantity", nil]];
        NSDictionary *prod_beverage = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects: [HLOrderSingleton order].beverage.identifier, [NSNumber numberWithInt:1], nil]
                                                                  forKeys:[NSArray arrayWithObjects: @"id", @"quantity", nil]];
        NSDictionary *prod_dessert = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects: [HLOrderSingleton order].dessert.identifier, [NSNumber numberWithInt:1], nil]
                                                                 forKeys:[NSArray arrayWithObjects: @"id", @"quantity", nil]];
        NSArray *arr = @[prod_menu, prod_beverage, prod_dessert];
        [[HLSocket socket] addOrder:arr];
        [[[Singleton manager] navigationController] pushViewController:[[HLDashboardViewController alloc] initWithNibName:@"HLDashboardViewController" bundle:nil] delegate:YES];
    }
}

-(void)didUnSwipe:(HLOrderViewController *)controller{
    if(controller == beverage){
        [[Singleton manager].navigationController setLeapDelegate:menu];
    }
    else if(controller == dessert){
        [[Singleton manager].navigationController setLeapDelegate:beverage];
    }
}

#pragma Socket Delegate
-(void)didGetProducts:(NSArray*)products{
    if(self.dataSourceMenu == nil)
        self.dataSourceMenu = [[NSMutableDictionary alloc] init];
    if(self.dataSourceBeverage == nil)
        self.dataSourceBeverage = [[NSMutableDictionary alloc] init];
    if(self.dataSourceDessert == nil)
        self.dataSourceDessert = [[NSMutableDictionary alloc] init];
    if(products && products.count > 0){
        int iM = 0;
        int iB = 0;
        int iD = 0;
        for (HLProduct *product in products){
            if([product.category isEqualToString:MENU]){
                [self.dataSourceMenu setObject:product forKey:[NSNumber numberWithInt:iM]];
                iM++;
            }
            else if([product.category isEqualToString:BEVERAGE]){
                [self.dataSourceBeverage setObject:product forKey:[NSNumber numberWithInt:iB]];
                iB++;
            }
            else if([product.category isEqualToString:DESSERT]){
                [self.dataSourceDessert setObject:product forKey:[NSNumber numberWithInt:iD]];
                iD++;
            }
        }
        if(self.dataSourceMenu.count > 0){
            [self.menu setDataSource:self.dataSourceMenu];
            [self.menu.menuView.tableView reloadData];
        }
        if(self.dataSourceBeverage.count > 0){
            [self.beverage setDataSource:self.dataSourceBeverage];
            [self.beverage.beverageView.tableView reloadData];
        }
        if(self.dataSourceDessert.count > 0){
            [self.dessert setDataSource:self.dataSourceDessert];
            [self.dessert.dessertView.tableView reloadData];
        }
    }
}

@end
