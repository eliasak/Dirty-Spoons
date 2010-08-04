//
//  OakGovChallenge_FoodViolationsAppDelegate.m
//  OakGovChallenge_FoodViolations
//
//  Created by Godfrey Nolan on 7/26/10.
//  Copyright RIIS LLC 2010. All rights reserved.
//

#import "OakGovChallenge_FoodViolationsAppDelegate.h"


@implementation OakGovChallenge_FoodViolationsAppDelegate

@synthesize window;
@synthesize tabBarController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Add the tab bar controller's current view as a subview of the window
    [window addSubview:tabBarController.view];
    [window makeKeyAndVisible];

	return YES;
}


/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/


- (void)dealloc {
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

