//
//  HLBeverageViewController.m
//  HandLess
//
//  Created by Stefan Lage on 28/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import "HLBeverageViewController.h"
#import "HLRowView.h"

@interface HLBeverageViewController ()

@end

@implementation HLBeverageViewController

@synthesize beverageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        float width = [Singleton manager].mainWindow.window.frame.size.width/3;
        float height = [Singleton manager].mainWindow.window.frame.size.height;
        beverageView = [[HLMenuView alloc] initWithFrame:CGRectMake(width, 0, width, height)];
        [self.beverageView.tableView setDataSource:self];
        [self.beverageView.tableView setDelegate:self];
        [self.beverageView.tableView setIntercellSpacing:NSMakeSize(0, 0)];
    }
    return self;
}

-(void)loadView{
    if(self.dataSource == nil)
        self.dataSource = [[NSMutableDictionary alloc] init];
    [self getData];
    [self setView:beverageView];
    [self.beverageView.tableView reloadData];
}

-(void)getData{
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return self.dataSource.count;
}
- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex{
    NSTextField *textfield = [[NSTextField alloc]initWithFrame:NSMakeRect(0, 0, aTableView.frame.size.width, 20)];
    HLProduct *prod = [self.dataSource objectForKey:[NSNumber numberWithInt:(int)rowIndex]];
    [textfield.cell setTitle:prod.name];
    return textfield;
}
-(NSView*)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
   return [super tableView:tableView viewForTableColumn:tableColumn row:row];
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification{
    [super tableViewSelectionDidChange:notification];
}

-(CGFloat) tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    return 100;
}

-(NSCell*)tableView:(NSTableView *)tableView dataCellForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    NSLog(@"dataCellForTableColumn");
    return nil;
}


-(void)leapController:(HLLeapController*)leap didSwipe:(LeapSwipe)swipe{
    NSInteger index = 0;
    NSIndexSet *indexSet;
    switch (swipe) {
        case LEAP_SWIPE_LEFT:
            NSLog(@"LEFT");
            if([self.delegate respondsToSelector:@selector(didUnSwipe:)]){
                [self.beverageView.tableView deselectRow:lastHighligthed];
                [self.delegate didUnSwipe:self];
            }
            break;
        case LEAP_SWIPE_UP:
            NSLog(@"UP");
            index = [self.beverageView.tableView selectedRow] - 1;
            indexSet = [NSIndexSet indexSetWithIndex:index];
            break;
        case LEAP_SWIPE_RIGHT:
            NSLog(@"RIGHT");
            break;
        case LEAP_SWIPE_DOWN:
            NSLog(@"DOWN");
            index = [self.beverageView.tableView selectedRow] + 1;
            indexSet = [NSIndexSet indexSetWithIndex:index];
            break;
    }
}

-(void)leapController:(HLLeapController *)leap didTapScreen:(LeapScreenTapGesture *)tap{
    [[Singleton manager].navigationController setLeapDelegate:nil];
    // get menu
    HLProduct *prod = [self.dataSource objectForKey:[NSNumber numberWithInteger:lastHighligthed]];
    [[HLOrderSingleton order] setIB:[NSNumber numberWithInteger:lastHighligthed]];
    [[HLOrderSingleton order] setBeverage:prod];
    if([self.delegate respondsToSelector:@selector(didSwipe:)])
        [self.delegate didSwipe:self];
}

-(void)leapController:(HLLeapController*)leap updatePosition:(CGPoint)newPoint{}

-(void)leapController:(HLLeapController*)leap updatePosition:(CGPoint)newPoint position:(float)position velocity:(float)velocity{
    if(!lastPoint.initialized){
        lastPoint.initialized = YES;
        lastPoint.point = newPoint;
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
        [self.beverageView.tableView selectRowIndexes:indexSet byExtendingSelection:NO];
    }else{
        if(velocity > 3){
            if(!lock){
                NSInteger index = [self.beverageView.tableView rowAtPoint:newPoint];
                NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:index];
                [self.beverageView.tableView selectRowIndexes:indexSet byExtendingSelection:NO];
                // update last point
                lastPoint.point = newPoint;
            }
        }else{
            lock = YES;
            [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(stopLock) userInfo:nil repeats:NO];
        }
    }
}

-(void)stopLock{
    lock = NO;
}

-(void)setDisable{
    [self.beverageView setAcceptsTouchEvents:NO];
    [self.beverageView setAlphaValue:.5];
    [self.beverageView setHidden:YES];
}

@end
