//
//  ViolationDetailViewController.h
//  FoodViolations
//
//  Created by Godfrey Nolan on 5/22/10.
//  Copyright 2010 RIIS LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ViolationDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {

	NSDictionary *restaurant;
	IBOutlet UITextView *restaurantAddressTextView;

	IBOutlet UILabel * restaurantPhoneNumber;
	IBOutlet UILabel * countCriticalViolations;
	IBOutlet UILabel * countNonCriticalViolations;
	
	IBOutlet UIButton* criticalFilterButton;
	IBOutlet UIButton* nonCriticalFilterButton;
	IBOutlet UIButton * phoneNumberButton;
	
	bool showCritical;
	bool showNonCritical;

	IBOutlet UITableView* violations;
}

@property (nonatomic, retain) NSDictionary *restaurant;

@property (nonatomic, retain) UITextView *restaurantAddressTextView;

@property (nonatomic, retain) UILabel * restaurantPhoneNumber;
@property (nonatomic, retain) UILabel * countCriticalViolations;
@property (nonatomic, retain) UILabel * countNonCriticalViolations;

@property (nonatomic, retain) UIButton* criticalFilterButton;
-(IBAction)criticalFilterButtonPressed:(id) sender;

@property (nonatomic, retain) UIButton* nonCriticalFilterButton;
-(IBAction)nonCriticalFilterButtonPressed:(id) sender;

@property (nonatomic, retain) UIButton * phoneNumberButton;
-(IBAction)phoneNumberButtonPressed:(id) sender;

@property (nonatomic) bool showCritical;
@property (nonatomic) bool showNonCritical;

@property (nonatomic, retain) UITableView* violations;

@end
