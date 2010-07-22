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

@interface ViolationDetailViewController : UIViewController <CLLocationManagerDelegate> {
	// CLLocationManager *locationManager;
	MKMapView *restaurantMapView;
	NSDictionary *restaurant;
	IBOutlet UITextField *restaurantNameTextField;
	IBOutlet UITextView *restaurantAddressTextView;
	IBOutlet UITextField *restaurantDateTextField;
	IBOutlet UITextField *restaurantLevelTextField;
	IBOutlet UITextView *restaurantDescTextView;

}

@property (nonatomic, retain) IBOutlet MKMapView *restaurantMapView;
// @property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) NSDictionary *restaurant;
@property (nonatomic, retain) UITextField *restaurantNameTextField, *restaurantLevelTextField, *restaurantDateTextField;
@property (nonatomic, retain) UITextView *restaurantDescTextView, *restaurantAddressTextView;

@end
