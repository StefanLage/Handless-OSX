//
//  HLCellView.m
//  HandLess
//
//  Created by Stefan Lage on 27/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import "HLCellView.h"

@implementation HLCellView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        NSTextField *textfield = [[NSTextField alloc]initWithFrame:frame];
        [textfield setBackgroundColor:[NSColor clearColor]];
        [textfield.cell setBackgroundColor:[NSColor clearColor]];
        self.textField = textfield;
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
