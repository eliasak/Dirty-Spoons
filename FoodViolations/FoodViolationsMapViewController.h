//
//  FoodViolationsMapViewController.h
//  FoodViolations
//
//  Created by Godfrey Nolan on 7/16/10.
//  Copyright 2010 RIIS LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface FoodViolationsMapViewController : UIViewController {
	IBOutlet MKMapView *restaurantsMapView;

	IBOutlet UILabel *debugText;
	IBOutlet UIToolbar*	toolBarBottom;
	IBOutlet UIBarButtonItem *mapButton;
	IBOutlet UIBarButtonItem *searchButton;
	IBOutlet UIBarButtonItem *aboutButton;
}

@property (retain, nonatomic) UILabel *debugText;

@property (retain, nonatomic) UIToolbar* toolBarBottom;

@property (retain, nonatomic) UIBarButtonItem *mapButton;
-(IBAction)mapButtonPressed:(id) sender;

@property (retain, nonatomic) UIBarButtonItem *searchButton;
-(IBAction)searchButtonPressed:(id) sender;

@property (retain, nonatomic) UIBarButtonItem *aboutButton;
-(IBAction)aboutButtonPressed:(id) sender;

@property (nonatomic, retain) MKMapView *restaurantsMapView;

@end
