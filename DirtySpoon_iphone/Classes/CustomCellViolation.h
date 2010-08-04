//
//  CustomCellViolation.h
//  OakGovChallenge_FoodViolations
//
//  Created by Godfrey Nolan on 7/30/10.
//  Copyright 2010 RIIS LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomCellViolation : UITableViewCell {
	IBOutlet UILabel* type;
	IBOutlet UILabel* date;
	IBOutlet UILabel* description;
}

@property (nonatomic, retain) IBOutlet UILabel* type;
@property (nonatomic, retain) IBOutlet  UILabel* date;
@property (nonatomic, retain) IBOutlet UILabel* description;

@end
