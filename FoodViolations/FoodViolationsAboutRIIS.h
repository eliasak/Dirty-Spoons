//
//  FoodViolationsAboutRIIS.h
//  FoodViolations
//
//  Created by Godfrey Nolan on 7/19/10.
//  Copyright 2010 RIIS LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FoodViolationsAboutRIIS : UIViewController {
	IBOutlet UIButton *okButton;
	IBOutlet UILabel *okButtonLabel;
}

@property (retain, nonatomic) UIButton *okButton;
-(IBAction)okButtonPressed:(id) sender;

@property (retain, nonatomic) UILabel *okButtonLabel;

@end
