//
//  FoodViolationTabs.h
//  FoodViolations
//
//  Created by Godfrey Nolan on 7/26/10.
//  Copyright 2010 RIIS LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FoodViolationTabs : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	IBOutlet UITabBarController* tabBarController;
}
@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic,retain) UITabBarController* tabBarController;
@end
