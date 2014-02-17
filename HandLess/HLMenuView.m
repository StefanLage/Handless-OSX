//
//  HLMenuView.m
//  HandLess
//
//  Created by Stefan Lage on 23/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import "HLMenuView.h"

@implementation HLMenuView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _tableView = [[NSTableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        //[self.tableView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _createOrder = [[NSButton alloc] initWithFrame:CGRectMake(0, frame.size.height-277, 277, 277)];
        // Set Titles
        [self.createOrder setTitle:@"New Order"];
        // Set Font
        NSFontManager *fontManager = [NSFontManager sharedFontManager];
        NSFont *verdana = [fontManager fontWithFamily:@"Verdana"
                                               traits:NSBoldFontMask
                                               weight:0
                                                 size:27];
        [self.createOrder setFont:verdana];
        // by default selecte createOrder
        //[self addSubview:self.createOrder];
        //[self addSubview:self.tableView];
        NSScrollView * tableContainer = [[NSScrollView alloc] initWithFrame:NSMakeRect(0, 0, frame.size.width, frame.size.height)];
        // create columns for our table
        NSTableColumn * column1 = [[NSTableColumn alloc] initWithIdentifier:@"Col1"];
        [column1 setWidth:frame.size.width];
        [column1 setEditable:NO];
        // generally you want to add at least one column to the table view.
        [self.tableView addTableColumn:column1];
        [self.tableView setHeaderView:nil];
        // embed the table view in the scroll view, and add the scroll view
        // to our window.
        [tableContainer setHasVerticalScroller:NO];
        [tableContainer setHasHorizontalScroller:NO];
        [tableContainer setDocumentView:self.tableView];
        [self addSubview:tableContainer];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [[NSColor redColor] setFill];
    NSRectFill(dirtyRect);
    [super drawRect:dirtyRect];
}

@end
