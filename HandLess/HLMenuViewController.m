//
//  HLMenuViewController.m
//  HandLess
//
//  Created by Stefan Lage on 23/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import "HLMenuViewController.h"
#import "HLRowView.h"

@interface HLMenuViewController ()

@end

@implementation HLMenuViewController

@synthesize menuView;

-(id)init{
    self = [super init];
    if(self){
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        float width = [Singleton manager].mainWindow.window.frame.size.width/3;
        float height = [Singleton manager].mainWindow.window.frame.size.height;
        menuView = [[HLMenuView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        [self.menuView.tableView setDataSource:self];
        [self.menuView.tableView setDelegate:self];
        [self.menuView.tableView setIntercellSpacing:NSMakeSize(0, 0)];
        lastHighligthed = -1;
    }
    return self;
}

-(void)loadView{
    if(self.dataSource == nil)
        self.dataSource = [[NSMutableDictionary alloc] init];
    [self setView:menuView];
    [[Singleton manager].navigationController setLeapDelegate:self];
}

-(void)getData{
    //[[HLSocket socket] getProducts];
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    NSLog(@"count %lu", (unsigned long)self.dataSource.count);
    return self.dataSource.count;
}
- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex{
    NSLog(@"qsdqsdqsdqsdqsdqsd");
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
   // NSInteger index = 0;
    //NSIndexSet *indexSet;
    if(lock){
        /*switch (swipe) {
            case LEAP_SWIPE_LEFT:
                NSLog(@"LEFT");
                [self.menuView.tableView deselectRow:[self.menuView.tableView selectedRow]];
                //[self.navigationController
                //[self switchSubViews:self.orderView];
                [[Singleton manager].navigationController setLeapDelegate:nil];
                [[HLOrderSingleton order] setMenu:[self.dataSource objectForKey:[NSNumber numberWithInteger:[self.menuView.tableView selectedRow]]]];
                if([self.delegate respondsToSelector:@selector(didSwipe:)]){
                    [self.delegate didSwipe:self];
                }*//*
                break;
            case LEAP_SWIPE_UP:
                NSLog(@"UP");
                index = [self.menuView.tableView selectedRow] - 1;
                indexSet = [NSIndexSet indexSetWithIndex:index];
                [self.menuView.tableView selectRowIndexes:indexSet byExtendingSelection:NO];
                break;
            case LEAP_SWIPE_RIGHT:
                NSLog(@"HEYEHEHEEH");
                [self.menuView.tableView deselectRow:[self.menuView.tableView selectedRow]];
                [[Singleton manager].navigationController setLeapDelegate:nil];
                // get menu
                [[HLOrderSingleton order] setMenu:[self.dataSource objectForKey:[NSNumber numberWithInteger:[self.menuView.tableView selectedRow]]]];
                if([self.delegate respondsToSelector:@selector(didSwipe:)]){
                    [self.delegate didSwipe:self];
                }*//*
                break;
            case LEAP_SWIPE_DOWN:
                NSLog(@"DOWN");
                index = [self.menuView.tableView selectedRow] + 1;
                indexSet = [NSIndexSet indexSetWithIndex:index];
                [self.menuView.tableView selectRowIndexes:indexSet byExtendingSelection:NO];
                break;
        }*/
    }
}

-(void)leapController:(HLLeapController *)leap didTapScreen:(LeapScreenTapGesture *)tap{
    //[self.menuView.tableView deselectRow:[self.menuView.tableView selectedRow]];
    [[Singleton manager].navigationController setLeapDelegate:nil];
    // get menu
    HLProduct *prod = [self.dataSource objectForKey:[NSNumber numberWithInteger:lastHighligthed]];
    [[HLOrderSingleton order] setMenu:prod];
    if([self.delegate respondsToSelector:@selector(didSwipe:)]){
        [self.delegate didSwipe:self];
    }
}

-(void)leapController:(HLLeapController*)leap updatePosition:(CGPoint)newPoint{
    /*NSInteger index=0;
    if(!lastPoint.initialized){
        lastPoint.initialized = YES;
        lastPoint.point = newPoint;
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
        [self.menuView.tableView selectRowIndexes:indexSet byExtendingSelection:NO];
    }else{
        float nY = newPoint.y;
        float lY = lastPoint.point.y;
        NSLog(@"new y1: %f y2: %f", nY, lY);
        
        
        // lastY + 10 < Y -> go up
        if(lY + 100 < nY){
            index = [self.menuView.tableView selectedRow] - 1;
        }
        // lastY - 10 > Y -> go down
        else if(lY - 100 > nY){
            index = [self.menuView.tableView selectedRow] + 1;
        }
        // lastY + 10 > Y > lastY - 10 -> don't move
        else {
            index = [self.menuView.tableView selectedRow];
            NSLog(@"JE SUIS LA %ld", (long)index);
        }
        
        // Now we can check if we need to move or not
        if(lY + 10 < nY){
            if([self.tableView selectedRow] > 0)
                index = [self.tableView selectedRow] - 1;
        }else if (lY - 10 > nY){
            if([self.tableView selectedRow] <= 0)
                index = [self.tableView selectedRow] + 1;
        }*/
        
        /*if([self.tableView selectedRow] > 0){
            index = [self.tableView selectedRow] - 1;
        }
        }else if (lY - 10 > nY){
            if([self.tableView selectedRow] <= 0){
                index = [self.tableView selectedRow] + 1;
        }*/
        /*NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:index];
        [self.menuView.tableView selectRowIndexes:indexSet byExtendingSelection:NO];
        // update last point
        lastPoint.point = newPoint;*/
    //}
}

-(void)leapController:(HLLeapController*)leap updatePosition:(CGPoint)newPoint position:(float)position velocity:(float)velocity{
    /*NSInteger index=0;
    if(velocity > 90){
        if(position > lastPosition + 10)
            index = [self.menuView.tableView selectedRow] - 1;
        else if(position < lastPosition - 10)
            index = [self.menuView.tableView selectedRow] + 1;
        else
            index = [self.menuView.tableView selectedRow];
        NSLog(@"pos: %f last: %f", position, lastPosition);
    }else{
        index = [self.menuView.tableView selectedRow];
    }
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:index];
    [self.menuView.tableView selectRowIndexes:indexSet byExtendingSelection:NO];
    // update last point
    lastPosition = position;*/

    if(!lastPoint.initialized){
        lastPoint.initialized = YES;
        lastPoint.point = newPoint;
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
        
        [self.menuView.tableView selectRowIndexes:indexSet byExtendingSelection:NO];
        [[HLOrderSingleton order] setIM:[NSNumber numberWithInteger:0]];
    }else{
        float nY = newPoint.y;
        float lY = lastPoint.point.y;
        if(velocity > 3){
            if(!lock){
                NSInteger index = [self.menuView.tableView rowAtPoint:newPoint];
                NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:index];
                [self.menuView.tableView selectRowIndexes:indexSet byExtendingSelection:NO];
                [[HLOrderSingleton order] setIM:[NSNumber numberWithInteger:index]];
                // update last point
                lastPoint.point = newPoint;
                lastIndex = index;
                NSLog(@"new y1: %f y2: %f index:%ld", nY, lY, [self.tableView selectedRow]);
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
    [self.menuView setAcceptsTouchEvents:NO];
    [self.menuView setAlphaValue:.5];
    [self.menuView setHidden:YES];
}

@end
