//
//  HLView.m
//  HandLess
//
//  Created by Stefan Lage on 23/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import "HLView.h"

@implementation HLView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [[NSColor blueColor] setFill];
    NSRectFill(dirtyRect);
    [super drawRect:dirtyRect];
}

@end
