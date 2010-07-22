//
//  FoodViolationsAppDelegate.h
//  FoodViolations
//
//  Created by Godfrey Nolan on 5/22/10.
//  Copyright RIIS LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodViolationsAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

