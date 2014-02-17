//
//  HLLeapController.m
//  HandLess
//
//  Created by Stefan Lage on 18/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import "HLLeapController.h"

@implementation HLLeapController

-(id)init{
    self = [super init];
    if(self) {
        controller = [[LeapController alloc] init];
        [controller addListener:self];
    }
    return self;
}

-(id)initWithDelegate:(id<HLLeapControllerDelegate>)delegate{
    self = [super init];
    if(self) {
        self.delegate = delegate;
        controller = [[LeapController alloc] init];
        [controller addListener:self];
    }
    return self;
}


#pragma mark - LeapListener Callbacks

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
    [aController enableGesture:LEAP_GESTURE_TYPE_SCREEN_TAP enable:YES];
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
    if ([[frame hands] count] == 1 && [[frame fingers] count] > 0) {
        NSArray *gestures = [frame gestures:nil];
        LeapFinger *finger = [[frame fingers] objectAtIndex:0];
        if([gestures count] >= 1){
            for (int g = 0; g < 1; g++) {
                LeapGesture *gesture = [gestures objectAtIndex:g];
                switch (gesture.type) {
                    case LEAP_GESTURE_TYPE_SWIPE: {
                        LeapSwipeGesture *swipeGesture = (LeapSwipeGesture *)gesture;
                        if(swipeGesture.state == LEAP_GESTURE_STATE_STOP)
                            [self identifyKindOfSwipe:swipeGesture.startPosition last:swipeGesture.position];
                        break;
                    }
                    case LEAP_GESTURE_TYPE_SCREEN_TAP: {
                        LeapScreenTapGesture *tapGesture = (LeapScreenTapGesture *)gesture;
                        if(tapGesture.state == LEAP_GESTURE_STATE_STOP){
                            if([self.delegate respondsToSelector:@selector(leapController:didTapScreen:)]){
                                [self.delegate leapController:self didTapScreen:tapGesture];
                            }
                        }
                        //[self identifyKindOfSwipe:tapGesture.startPosition last:swipeGesture.position];
                        break;
                    }
                    default:
                        NSLog(@"Unknown gesture");
                        break;
                }
            }
        }
        if([finger isValid] && [[frame.pointables objectAtIndex:0] isValid]){
            [self updateFingerPosition:[frame.pointables objectAtIndex:0] finger:finger];
            /*if([self.delegate respondsToSelector:@selector(leapController:updatePosition:)])
                [self.delegate leapController:self position:[finger tipPosition].magnitude velocity:[finger tipVelocity].magnitude];*/
            NSLog(@"tipPosition: %f,\t tipVelocity: %f", [finger tipPosition].magnitude, [finger tipVelocity].magnitude);
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

#pragma mark - HLLeapController

/* 
 * Identify in which direction go the swipe
 *
 *      startPosition->X > lastPosition->X ? LEFT : RIGHT
 *      startPosition->Y > lastPosition->Y ? DOWN : UP
 *
 */
-(void)identifyKindOfSwipe:(LeapVector*)startPosition last:(LeapVector*)lastPosition{
    LeapSwipe swipe;
    // Calculate what kind swipe it is
    // Compare start position to last one
    float xDiff = startPosition.x - lastPosition.x;
    float yDiff = startPosition.y - lastPosition.y;
    // Be sure to have positives numbers
    if(xDiff < 0)
        xDiff *= -1;
    if(yDiff < 0)
        yDiff *= -1;
    // What kind of swipe ?
    if(xDiff > yDiff)
        // -> LEFT OR RIGHT SWIPE
        swipe = (startPosition.x > lastPosition.x) ? LEAP_SWIPE_LEFT : LEAP_SWIPE_RIGHT;
    else
        // -> UP OR DOWN SWIPE
        swipe = (startPosition.y > lastPosition.y) ? LEAP_SWIPE_DOWN : LEAP_SWIPE_UP;
    // Inform delegate about this gesture
    if([self.delegate respondsToSelector:@selector(leapController:didSwipe:)]){
        [self.delegate leapController:self didSwipe:swipe];
    }
}

/*
 * Calculate the new position of the object pointing the screen
 * We get its position in terms of the Window's app size and the LeapPointable object
 *
 */
-(void)updateFingerPosition:(LeapPointable*)pointable finger:(LeapFinger*)finger{
    // Get estimated position where the finger is pointed
    NSArray *screens = controller.locatedScreens;
    LeapScreen *screen = [screens closestScreenHit:pointable];
    // Get app's size
    LeapVector *normalizedCoordinates = [screen intersect:pointable normalize:YES clampRatio:2.0];
    // Calculate the position of the point in terms of Windows's app size
    float xPixel = (normalizedCoordinates.x * 480);
    float yPixel = (normalizedCoordinates.y * (-1800));
    CGPoint point = CGPointMake(xPixel, yPixel);
    
    // Inform listener of its new position
    if([self.delegate respondsToSelector:@selector(leapController:updatePosition:position:velocity:)])
        //[self.delegate leapController:self updatePosition:point];
        [self.delegate leapController:self
                       updatePosition:point
                             position:[finger tipPosition].magnitude
                             velocity:[finger tipVelocity].magnitude];

}

/*-(void)updateFingerPosition:(LeapPointable*)pointable{
    // Get estimated position where the finger is pointed
    NSArray *screens = controller.locatedScreens;
    LeapScreen *screen = [screens closestScreenHit:pointable];
    // Get app's size
    CGSize size = [(NSWindow*)[[[NSApplication sharedApplication] windows] objectAtIndex:0] frame].size;
    LeapVector *normalizedCoordinates = [screen intersect:pointable normalize:YES clampRatio:2.0];
    // Calculate the position of the point in terms of Windows's app size
    float xPixel = (normalizedCoordinates.x * 480);
    float yPixel = (normalizedCoordinates.y * 900);
    CGPoint point = CGPointMake(xPixel, yPixel);
    // Inform listener of its new position
    if([self.delegate respondsToSelector:@selector(leapController:updatePosition:)])
        [self.delegate leapController:self updatePosition:point];
}*/

@end
