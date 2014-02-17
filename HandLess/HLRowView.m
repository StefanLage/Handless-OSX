//
//  HLRowView.m
//  HandLess
//
//  Created by Stefan Lage on 14/02/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import "HLRowView.h"

@implementation HLRowView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        _textfield = [[NSTextField alloc] initWithFrame:frame];
        [_textfield setAlignment:NSCenterTextAlignment];
        _textfield.bezeled         = NO;
        _textfield.editable        = NO;
        _textfield.drawsBackground = YES;
        [self addSubview:self.textfield];
    }
    return self;
}

-(id) initWithFrame:(NSRect)frame color:(NSColor*)color title:(NSString*)title{
    self = [super initWithFrame:frame];
    if (self) {        
        _bkColor = color;
        _textfield = [[NSTextField alloc] initWithFrame:NSMakeRect(frame.origin.x, frame.size.height/2 - 15, frame.size.width, frame.size.height)];
        [_textfield setAlignment:NSCenterTextAlignment];
        _textfield.bezeled         = NO;
        _textfield.editable        = NO;
        _textfield.drawsBackground = NO;
        [self setBackgroundColor:self.bkColor];
        [_textfield.cell setTitle:title];
        [_textfield setFont:[NSFont fontWithName:@"Menlo" size:20]];
        [_textfield setTextColor:[NSColor whiteColor]];
        [self addSubview:self.textfield];
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

-(void)drawSelectionInRect:(NSRect)dirtyRect{
    [self setBackgroundColor:[NSColor colorWithRed:MAX([self.bkColor redComponent] - 0.2, 0.0)
                                             green:MAX([self.bkColor greenComponent] - 0.2, 0.0)
                                              blue:MAX([self.bkColor blueComponent] - 0.2, 0.0)
                                             alpha:1.0]];
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if(selected)
        [self setBackgroundColor:[NSColor colorWithRed:MAX([self.bkColor redComponent] - 0.2, 0.0)
                                                           green:MAX([self.bkColor greenComponent] - 0.2, 0.0)
                                                            blue:MAX([self.bkColor blueComponent] - 0.2, 0.0)
                                                           alpha:1.0]];
    else
        [self setBackgroundColor:self.bkColor];
}

@end
