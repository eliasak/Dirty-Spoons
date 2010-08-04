//
//  OakGovChallenge_FoodViolationsAppDelegate.h
//  OakGovChallenge_FoodViolations
//
//  Created by Godfrey Nolan on 7/26/10.
//  Copyright RIIS LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OakGovChallenge_FoodViolationsAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
