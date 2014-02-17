//
//  HLOrderViewController.h
//  HandLess
//
//  Created by Stefan Lage on 23/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HLSocket.h"

typedef struct{
    CGPoint point;
    BOOL initialized;
} LastPoint;

@protocol HLOrderViewControllerDelegate;

@interface HLOrderViewController : HLViewController <NSTableViewDataSource, NSTableViewDelegate>{
    LastPoint lastPoint;
    NSInteger lastHighligthed;
}

@property (strong, nonatomic) NSMutableDictionary *dataSource;
@property (strong, nonatomic) NSTableView *tableView;
@property (strong, nonatomic) id<HLOrderViewControllerDelegate> delegate;

-(void)getData;
-(void)saveData;
-(void)setDisable;
-(NSColor*)colorForIndex:(NSInteger) index;

@end

@protocol HLOrderViewControllerDelegate <NSObject>

-(void)didSwipe:(HLOrderViewController*)controller;
-(void)didUnSwipe:(HLOrderViewController*)controller;

@end
