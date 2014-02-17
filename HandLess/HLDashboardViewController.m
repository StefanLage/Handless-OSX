//
//  HLDashboardViewController.m
//  HandLess
//
//  Created by Stefan Lage on 21/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import "HLDashboardViewController.h"
#import "HLNewOrderViewController.h"
#import "HLMenuViewController.h"

@interface HLDashboardViewController (){
    HLNewOrderViewController *nw;
}

@end

@implementation HLDashboardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
        needCreate = YES;
    return self;
}

-(void)loadView{
    dashView = [[HLDashboardView alloc] initWithFrame:NSMakeRect(0, 0, 1440, 900)];
    [self setView:dashView];
    [dashView.createOrder setAction:@selector(newOrder)];
    [dashView.createOrder setTarget:self];
}

-(CGFloat) midScreen{
    //[self.view addSubview:dashView];
    if(mid == 0)
        mid = [Singleton manager].mainWindow.window.frame.size.width / 2;
    return mid;
}


#pragma mark - HLLeapController delegate
-(void)leapController:(HLLeapController*)leap didFail:(NSError*)error{
    NSLog(@"error %@", [error description]);
}

-(void)leapController:(HLLeapController*)leap didSwipe:(LeapSwipe)swipe{
    switch (swipe) {
        case LEAP_SWIPE_LEFT:
            NSLog(@"LEFT");
            break;
        case LEAP_SWIPE_UP:
            NSLog(@"UP");
            break;
        case LEAP_SWIPE_RIGHT:
            NSLog(@"RIGHT");
            break;
        case LEAP_SWIPE_DOWN:
            NSLog(@"DOWN");
            break;
    }
}

-(void)leapController:(HLLeapController*)leap updatePosition:(CGPoint)newPoint{
    NSLog(@"lol");
    float xPosition = newPoint.x;
    if(xPosition < [self midScreen])
        // left part -> NEW ORDER
        needCreate = YES;
    else
        // right part -> CANCEL ORDER
        needCreate = NO;
    [dashView highlightButton:needCreate];
}

-(void)leapController:(HLLeapController*)leap didTapScreen:(LeapScreenTapGesture*)tap{
    if(needCreate){
        nw = [[HLNewOrderViewController alloc] initWithNibName:@"HLNewOrderViewController" bundle:nil];
        [[[Singleton manager] navigationController] pushViewController:nw];
        needCreate = NO;
    }
    else{
        
    }
}

-(void)newOrder{
    nw = [[HLNewOrderViewController alloc] initWithNibName:@"HLNewOrderViewController" bundle:nil];
    [[[Singleton manager] navigationController] pushViewController:nw];
    needCreate = NO;
}

@end
