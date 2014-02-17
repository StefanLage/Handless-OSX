//
//  HLAppDelegate.h
//  HandLess
//
//  Created by Stefan Lage on 18/01/14.
//  Copyright (c) 2014 Stefan Lage. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HLDashboardViewController.h"
#import "HLNavigationController.h"
#import "HLMainWindow.h"

@interface HLAppDelegate : NSObject <NSApplicationDelegate>{
    HLLeapController *leap;
}

@property (assign) IBOutlet NSWindow *window;
@property (readonly, strong, nonatomic) HLMainWindow *mainWindow;
@property (readonly, strong, nonatomic) HLNavigationController *navigationController;
@property (readonly, strong, nonatomic) HLDashboardViewController *dashboard;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (readonly, strong, nonatomic) NSWindowController *mainDashboard;

- (IBAction)saveAction:(id)sender;

@end
