//
//  FoodViolationsAboutRIIS.h
//  FoodViolations
//
//  Created by Godfrey Nolan on 7/19/10.
//  Copyright 2010 RIIS LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FoodViolationsAboutRIIS : UIViewController {
	IBOutlet UIButton *riisButton;

	IBOutlet UIButton *oakgovButton;
}

@property (retain, nonatomic) UIButton *riisButton;
-(IBAction)riisButtonPressed:(id) sender;

@property (retain, nonatomic) UIButton *oakgovButton;
-(IBAction)oakgovButtonPressed:(id) sender;

@end
