//
//  HLDessertViewController.m
//  HandLess
//
//  Created by Stefan Lage on 28/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import "HLDessertViewController.h"

@interface HLDessertViewController ()

@end

@implementation HLDessertViewController

@synthesize dessertView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        float width = [Singleton manager].mainWindow.window.frame.size.width/3;
        float height = [Singleton manager].mainWindow.window.frame.size.height;
        dessertView = [[HLMenuView alloc] initWithFrame:CGRectMake(2*width, 0, width, height)];
        [self.dessertView.tableView setDataSource:self];
        [self.dessertView.tableView setDelegate:self];
        [self.dessertView.tableView setIntercellSpacing:NSMakeSize(0, 0)];
    }
    return self;
}

-(void)loadView{
    if(self.dataSource == nil)
        self.dataSource = [[NSMutableDictionary alloc] init];
    //[self getData];
    [self setView:dessertView];
    [self.dessertView.tableView reloadData];
}

-(void)getData{
    // Get from the server
    [self.dataSource setObject:@"Biere"     forKey:[NSNumber numberWithInt:0]];
    [self.dataSource setObject:@"Vin Rouge" forKey:[NSNumber numberWithInt:1]];
    [self.dataSource setObject:@"Coke"      forKey:[NSNumber numberWithInt:2]];
    [self.dataSource setObject:@"Ice Tea"   forKey:[NSNumber numberWithInt:3]];
    [self.dataSource setObject:@"Orangina"  forKey:[NSNumber numberWithInt:4]];
    [self.dataSource setObject:@"Oasis"     forKey:[NSNumber numberWithInt:5]];
    [self.dataSource setObject:@"Vin Blanc" forKey:[NSNumber numberWithInt:6]];
    [self.dataSource setObject:@"Cafe"      forKey:[NSNumber numberWithInt:7]];
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    NSLog(@"count %lu", (unsigned long)self.dataSource.count);
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

-(CGFloat) tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    return 100;
}

-(NSCell*)tableView:(NSTableView *)tableView dataCellForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    NSLog(@"dataCellForTableColumn");
    return nil;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification{
    [super tableViewSelectionDidChange:notification];
}


-(void)leapController:(HLLeapController*)leap didSwipe:(LeapSwipe)swipe{
    NSInteger index = 0;
    NSIndexSet *indexSet;
    //if(lock){
        switch (swipe) {
            case LEAP_SWIPE_LEFT:
                NSLog(@"LEFT");
                //[self.navigationController
                /*//[self switchSubViews:self.orderView];
                 [[Singleton manager].navigationController setLeapDelegate:nil];
                 [[HLOrderSingleton order] setMenu:[self.dataSource objectForKey:[NSNumber numberWithInteger:[self.beverageView.tableView selectedRow]]]];
                 [self.beverageView.tableView deselectRow:[self.beverageView.tableView selectedRow]];
                 if([self.delegate respondsToSelector:@selector(didSwipe:)]){
                 [self.delegate didSwipe:self];
                 }*/
                if([self.delegate respondsToSelector:@selector(didUnSwipe:)]){
                    [self.dessertView.tableView deselectRow:lastHighligthed];
                    [self.delegate didUnSwipe:self];
                }
                break;
            case LEAP_SWIPE_UP:
                NSLog(@"UP");
                index = [self.dessertView.tableView selectedRow] - 1;
                indexSet = [NSIndexSet indexSetWithIndex:index];
                [self.dessertView.tableView selectRowIndexes:indexSet byExtendingSelection:NO];
                break;
            case LEAP_SWIPE_RIGHT:
                NSLog(@"HEYEHEHEEH");
                /*[[Singleton manager].navigationController setLeapDelegate:nil];
                 // get menu
                 [[HLOrderSingleton order] setMenu:[self.dataSource objectForKey:[NSNumber numberWithInteger:[self.beverageView.tableView selectedRow]]]];
                 [self.beverageView.tableView deselectRow:[self.beverageView.tableView selectedRow]];
                 if([self.delegate respondsToSelector:@selector(didSwipe:)]){
                 [self.delegate didSwipe:self];
                 }*/
                break;
            case LEAP_SWIPE_DOWN:
                NSLog(@"DOWN");
                index = [self.dessertView.tableView selectedRow] + 1;
                indexSet = [NSIndexSet indexSetWithIndex:index];
                [self.dessertView.tableView selectRowIndexes:indexSet byExtendingSelection:NO];
                break;
        }
    //}
}

-(void)leapController:(HLLeapController *)leap didTapScreen:(LeapScreenTapGesture *)tap{
    [[Singleton manager].navigationController setLeapDelegate:nil];
    // get menu
    HLProduct *prod = [self.dataSource objectForKey:[NSNumber numberWithInteger:lastHighligthed]];
    [[HLOrderSingleton order] setID:[NSNumber numberWithInteger:[self.dessertView.tableView selectedRow]]];
    [[HLOrderSingleton order] setDessert:prod];
    if([self.delegate respondsToSelector:@selector(didSwipe:)])
        [self.delegate didSwipe:self];
}

-(void)leapController:(HLLeapController*)leap updatePosition:(CGPoint)newPoint{}

-(void)leapController:(HLLeapController*)leap updatePosition:(CGPoint)newPoint position:(float)position velocity:(float)velocity{
    if(!lastPoint.initialized){
        lastPoint.initialized = YES;
        lastPoint.point = newPoint;
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
        [self.dessertView.tableView selectRowIndexes:indexSet byExtendingSelection:NO];
    }else{
        float nY = newPoint.y;
        float lY = lastPoint.point.y;
        if(velocity > 3){
            if(!lock){
                NSInteger index = [self.dessertView.tableView rowAtPoint:newPoint];
                NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:index];
                [self.dessertView.tableView selectRowIndexes:indexSet byExtendingSelection:NO];
                // update last point
                lastPoint.point = newPoint;
                NSLog(@"new y1: %f y2: %f", nY, lY);
            }
        }else{
            NSLog(@"STOPPPPPPP");
            lock = YES;
            [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(stopLock) userInfo:nil repeats:NO];
        }
    }
}

-(void)stopLock{
    lock = NO;
}

-(void)setDisable{
    [self.dessertView setAcceptsTouchEvents:NO];
    [self.dessertView setAlphaValue:.5];
    [self.dessertView setHidden:YES];
}

@end
