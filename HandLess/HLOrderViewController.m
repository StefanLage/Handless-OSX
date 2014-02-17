//
//  HLOrderViewController.m
//  HandLess
//
//  Created by Stefan Lage on 23/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import "HLOrderViewController.h"
#import "HLRowView.h"

@interface HLOrderViewController ()

@end

@implementation HLOrderViewController

-(id)init{
    self = [super init];
    if(self){
        _dataSource = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        
    }
    return self;
}

-(void)getData{
    if(self.tableView)
       [self.tableView reloadData];
}
-(void)saveData{}
-(void)setDisable{}

-(NSColor*)colorForIndex:(NSInteger) index {
    NSUInteger itemCount = self.dataSource.count - 1;
    float val = ((float)index / (float)itemCount) * 0.6;
    return [NSColor colorWithRed: 1.0 green:val blue: 0.0 alpha:1.0];
}

-(NSView*)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    HLProduct *prod = [self.dataSource objectForKey:[NSNumber numberWithInt:(int)row]];
    return [[HLRowView alloc] initWithFrame:NSMakeRect(0, 0, tableView.frame.size.width, 100)
                                      color:[self colorForIndex:row]
                                      title:prod.name];
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification{
    NSTableView *tableView = notification.object;
    if(lastHighligthed != -1)
        // release last one
        [[tableView viewAtColumn:0 row:lastHighligthed makeIfNecessary:NO] setSelected:NO];
    // selected new one
    NSInteger selectedRowNumber = [tableView selectedRow];
    [[tableView viewAtColumn:0 row:selectedRowNumber makeIfNecessary:NO]  setSelected:YES];
    lastHighligthed = selectedRowNumber;
}

@end
