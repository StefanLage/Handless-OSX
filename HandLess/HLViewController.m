//
//  HLViewController.m
//  HandLess
//
//  Created by Stefan Lage on 20/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import "HLViewController.h"

@interface HLViewController ()

@end

@implementation HLViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)viewDidLoad{}
- (void)viewWillAppear{}
- (void)viewWillDisappear{}
- (void)viewDidAppear{}
- (void)viewDidDisappear{}

#pragma mark - HLLeapController delegate
-(void)leapController:(HLLeapController*)leap didFail:(NSError*)error{
}

-(void)leapController:(HLLeapController*)leap didSwipe:(LeapSwipe)swipe{
}

-(void)leapController:(HLLeapController*)leap updatePosition:(CGPoint)newPoint{
}

-(void)leapController:(HLLeapController*)leap didTapScreen:(LeapScreenTapGesture*)tap{
}

@end
