//
//  HLLeapController.h
//  HandLess
//
//  Created by Stefan Lage on 18/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LeapObjectiveC.h"

// Protocols definition
@protocol HLLeapControllerDelegate;

// Type of Swipe -> Direction to be more specific
typedef enum LeapSwipe {
    LEAP_SWIPE_LEFT     = 0,
    LEAP_SWIPE_TOP      = 1,
    LEAP_SWIPE_RIGHT    = 2,
    LEAP_SWIPE_BOTTOM   = 3
} LeapSwipe;

/*
 *  HLLeapController
 */
@interface HLLeapController : NSObject <LeapListener>{
    LeapController *controller;
    LeapSwipeGesture *lastSwipeGesture;
}
// Properties
@property (strong, nonatomic) id<HLLeapControllerDelegate> delegate;
// Contructors
-(id)initWithDelegate:(id<HLLeapControllerDelegate>)delegate;

@end

/*
 *  HLLeapController Delegate
 */
@protocol HLLeapControllerDelegate <NSObject>

-(void)leapController:(HLLeapController*)leap didFail:(NSError*)error;
-(void)leapController:(HLLeapController*)leap didSwipe:(LeapSwipe)swipe;

@end