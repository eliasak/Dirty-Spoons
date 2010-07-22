//
//  FoodViolationsAppDelegate.m
//  FoodViolations
//
//  Created by Godfrey Nolan on 5/22/10.
//  Copyright RIIS LLC 2010. All rights reserved.
//

#import "FoodViolationsAppDelegate.h"
#import "RootViewController.h"


@implementation FoodViolationsAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    // Override point for customization after app launch    
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
	return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

