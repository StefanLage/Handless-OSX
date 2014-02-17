//
//  HLDashboardView.m
//  HandLess
//
//  Created by Stefan Lage on 21/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import "HLDashboardView.h"

#define highlightColor      [NSColor colorWithRed:0.45 green:0.81 blue:0.13 alpha:1]

@implementation HLDashboardView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        float width = [Singleton manager].mainWindow.window.frame.size.width/2;
        float height = [Singleton manager].mainWindow.window.frame.size.height/2;
        int sideButton = 277;
        
        NSLog(@"test %f", height/2 - sideButton/2);
        
        // Initialization code here.
        //_createOrder = [[NSButton alloc] initWithFrame:CGRectMake(width/2 - sideButton/2, height/2, 277, 277)];
        _createOrder = [[NSButton alloc] initWithFrame:CGRectMake(width - sideButton/2, height - sideButton/2, 277, 277)];
        
        _cancelOrder = [[NSButton alloc] initWithFrame:CGRectMake(3*width/2 - sideButton/2, height/2, 277, 277)];
        // Set Titles
        [self.createOrder setTitle:@"New Order"];
        [self.cancelOrder setTitle:@"Cancel Order"];
        // Set Font
        NSFontManager *fontManager = [NSFontManager sharedFontManager];
        NSFont *verdana = [fontManager fontWithFamily:@"Verdana"
                                                  traits:NSBoldFontMask
                                                  weight:0
                                                    size:27];
        [self.createOrder setFont:verdana];
        [self.cancelOrder setFont:verdana];
        
        // by default selecte createOrder
        [self highlightButton:YES];
        [self addSubview:self.createOrder];
        //[self addSubview:self.cancelOrder];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	// set any NSColor for filling, say white:
    [[NSColor whiteColor] setFill];
    NSRectFill(dirtyRect);
    [super drawRect:dirtyRect];
}

-(void)highlightButton:(BOOL)create{
    if(create){
        [[self.createOrder cell] setBackgroundColor:highlightColor];
        [[self.cancelOrder cell] setBackgroundColor:[NSColor whiteColor]];
    }else{
        [[self.cancelOrder cell] setBackgroundColor:highlightColor];
        [[self.createOrder cell] setBackgroundColor:[NSColor whiteColor]];
    }
}

@end
