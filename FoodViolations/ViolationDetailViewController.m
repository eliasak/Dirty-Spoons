//
//  ViolationDetailViewController.m
//  FoodViolations
//
//  Created by Godfrey Nolan on 5/22/10.
//  Copyright 2010 RIIS LLC. All rights reserved.
//

#import "ViolationDetailViewController.h"
#import "RestaurantConstants.h"
#import "FoodViolationsAboutRIIS.h"
#import "FoodViolationsMapViewController.h"
#import "RestaurantsDAO.h";
#import "Restaurant.h";

@implementation ViolationDetailViewController
@synthesize restaurant, restaurantNameTextField, restaurantAddressTextView, restaurantLevelTextField, restaurantDateTextField, restaurantDescTextView, restaurantMapView;


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void) viewWillAppear:(BOOL)animated {
	
	RestaurantsDAO* rsdao = [RestaurantsDAO GetInstance];

	restaurantNameTextField.text = rsdao.CurrentRestaurant.Name;
	restaurantAddressTextView.text = rsdao.CurrentRestaurant.Address;
	restaurantDateTextField.text = rsdao.CurrentRestaurant.Date;
	restaurantLevelTextField.text = @"<incident level>";
	restaurantDescTextView.text = @"<incident description>";
	
//	[super viewWillAppear:animated];
//	CLLocationCoordinate2D mapCenter;
	// CLLocation *curPos = self.locationManager.location;
		
//	mapCenter.latitude = [[restaurant objectForKey:LAT_KEY] doubleValue];
//	mapCenter.longitude = [[restaurant objectForKey:LONG_KEY] doubleValue];
//	
//	
//	MKCoordinateSpan mapSpan;
//	mapSpan.latitudeDelta = 0.003;
//	mapSpan.longitudeDelta = 0.003;
//	
//	MKCoordinateRegion mapRegion;
//	mapRegion.center = mapCenter;
//	mapRegion.span = mapSpan;
	
	//annotation = [[AddressAnnotation alloc] initWithCoordinate:mapCenter];
	//[self.restaurantMapView addAnnotation:annotation];
	
//	self.restaurantMapView.region = mapRegion;
//	self.restaurantMapView.mapType = MKMapTypeStandard;
	
	
//	restaurantNameTextField.text = [restaurant objectForKey:NAME_KEY];
//	restaurantAddressTextView.text = [restaurant objectForKey:ADDRESS_KEY];
//	restaurantDateTextField.text = [restaurant objectForKey:DATE_KEY];
//	restaurantLevelTextField.text = [restaurant objectForKey:LEVEL_KEY];
//	restaurantDescTextView.text = [restaurant objectForKey:DESCRIPTION_KEY];

	
}

@synthesize searchButton;
-(IBAction) searchButtonPressed:(id) sender
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}

@synthesize aboutButton;
-(IBAction)aboutButtonPressed:(id) sender
{
	FoodViolationsAboutRIIS *foodViolationsAboutRIIS = [[FoodViolationsAboutRIIS alloc]
														initWithNibName:@"FoodViolationsAboutRIIS"
														bundle:nil];
	
	[self.navigationController presentModalViewController:foodViolationsAboutRIIS animated:YES];
	[foodViolationsAboutRIIS release];
}

@synthesize mapButton;
-(IBAction)mapButtonPressed:(id) sender
{
	FoodViolationsMapViewController *foodViolationsMapViewController = [[FoodViolationsMapViewController alloc]
														initWithNibName:@"FoodViolationsMapViewController"
														bundle:nil];
	
	[self.navigationController presentModalViewController:foodViolationsMapViewController animated:YES];
	[FoodViolationsMapViewController release];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	// [violation release];
	[restaurantMapView release];
	[restaurantNameTextField release];
	[restaurantAddressTextView release];
	[restaurantDateTextField release];
	[restaurantLevelTextField release];
	[restaurantDescTextView release];
    [super dealloc];
}


@end
