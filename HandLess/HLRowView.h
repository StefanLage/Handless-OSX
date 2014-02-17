//
//  HLRowView.h
//  HandLess
//
//  Created by Stefan Lage on 14/02/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface HLRowView : NSTableRowView

@property (strong, nonatomic) NSColor *bkColor;
@property (strong, nonatomic) NSTextField *textfield;
-(id) initWithFrame:(NSRect)frame color:(NSColor*)color title:(NSString*)title;

@end
