//
//  HLLeapController.m
//  HandLess
//
//  Created by Stefan Lage on 18/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import "HLLeapController.h"

@implementation HLLeapController

-(id)initWithDelegate:(id<HLLeapControllerDelegate>)delegate{
    self = [super init];
    if(self) {
        self.delegate = delegate;
        controller = [[LeapController alloc] init];
        [controller addListener:self];
    }
    return self;
}


#pragma mark - SampleListener Callbacks

- (void)onInit:(NSNotification *)notification
{
    NSLog(@"Initialized");
}

// Enable only SWIPE GESTURES
- (void)onConnect:(NSNotification *)notification
{
    NSLog(@"Connected");
    LeapController *aController = (LeapController *)[notification object];
    [aController enableGesture:LEAP_GESTURE_TYPE_CIRCLE enable:NO];
    [aController enableGesture:LEAP_GESTURE_TYPE_KEY_TAP enable:NO];
    [aController enableGesture:LEAP_GESTURE_TYPE_SCREEN_TAP enable:NO];
    [aController enableGesture:LEAP_GESTURE_TYPE_SWIPE enable:YES];
}

- (void)onDisconnect:(NSNotification *)notification
{
    //Note: not dispatched when running in a debugger.
    NSLog(@"Disconnected %@", [notification object]);
}

- (void)onExit:(NSNotification *)notification
{
    NSLog(@"Exited");
}

- (void)onFrame:(NSNotification *)notification
{
    LeapController *aController = (LeapController *)[notification object];
    // Get the most recent frame and report some basic information
    LeapFrame *frame = [aController frame:0];
    if ([[frame hands] count] == 1 && [[frame fingers] count] == 1) {
        NSArray *gestures = [frame gestures:nil];
        for (int g = 0; g < [gestures count]; g++) {
            LeapGesture *gesture = [gestures objectAtIndex:g];
            switch (gesture.type) {
                case LEAP_GESTURE_TYPE_SWIPE: {
                    LeapSwipeGesture *swipeGesture = (LeapSwipeGesture *)gesture;
                    NSLog(@"Swipe id: %d, %@, position: %@, direction: %@, speed: %f",
                        swipeGesture.id, [HLLeapController stringForState:swipeGesture.state],
                        swipeGesture.position, swipeGesture.direction, swipeGesture.speed);
                    break;
                }
                default:
                    NSLog(@"Unknown gesture type");
                    break;
            }
        }
    }
}

- (void)onFocusGained:(NSNotification *)notification
{
    NSLog(@"Focus Gained");
}

- (void)onFocusLost:(NSNotification *)notification
{
    NSLog(@"Focus Lost");
}

+ (NSString *)stringForState:(LeapGestureState)state
{
    switch (state) {
        case LEAP_GESTURE_STATE_INVALID:
            return @"STATE_INVALID";
        case LEAP_GESTURE_STATE_START:
            return @"STATE_START";
        case LEAP_GESTURE_STATE_UPDATE:
            return @"STATE_UPDATED";
        case LEAP_GESTURE_STATE_STOP:
            return @"STATE_STOP";
        default:
            return @"STATE_INVALID";
    }
}


@end
