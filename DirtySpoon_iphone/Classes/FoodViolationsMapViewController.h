//
//  FoodViolationsMapViewController.h
//  FoodViolations
//
//  Created by Godfrey Nolan on 7/16/10.
//  Copyright 2010 RIIS LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>

@interface FoodViolationsMapViewController : UIViewController <MKMapViewDelegate> {
	IBOutlet MKMapView *restaurantsMapView;
	
	IBOutlet UIToolbar*	toolBar;
	IBOutlet UIBarButtonItem *showAllButton;
	IBOutlet UIBarButtonItem *criticalButton;
	IBOutlet UIBarButtonItem *nonCriticalButton;
}

@property (retain, nonatomic) UIToolbar* toolBar;

@property (retain, nonatomic) UIBarButtonItem *showAllButton;
-(IBAction)showAllButtonPressed:(id) sender;

@property (retain, nonatomic) UIBarButtonItem *criticalButton;
-(IBAction)criticalButtonPressed:(id) sender;

@property (retain, nonatomic) UIBarButtonItem *nonCriticalButton;
-(IBAction)nonCriticalButtonPressed:(id) sender;

@property (nonatomic, retain) MKMapView *restaurantsMapView;

@end
