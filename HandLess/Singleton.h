//
//  Singleton.h
//  HandLess
//
//  Created by Stefan Lage on 21/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HLNavigationController.h"
#import "HLLeapController.h"
#import "HLMainWindow.h"

@interface Singleton : NSObject

+(Singleton*)manager;
-(HLNavigationController*)navigationController;
-(HLMainWindow*)mainWindow;

@end
