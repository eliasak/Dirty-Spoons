//
//  FoodViolationTabs.m
//  FoodViolations
//
//  Created by Godfrey Nolan on 7/26/10.
//  Copyright 2010 RIIS LLC. All rights reserved.
//

#import "FoodViolationTabs.h"


@implementation FoodViolationTabs

@synthesize tabBarController;
@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    // Override point for customization after app launch    
	
	[window addSubview:[tabBarController view]];
    [window makeKeyAndVisible];
	return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[tabBarController release];
	[window release];
	[super dealloc];
}

@end
