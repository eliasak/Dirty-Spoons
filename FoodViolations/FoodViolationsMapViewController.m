//
//  FoodViolationsMapViewController.m
//  FoodViolations
//
//  Created by Godfrey Nolan on 7/16/10.
//  Copyright 2010 RIIS LLC. All rights reserved.
//

#import "FoodViolationsMapViewController.h"
#import "RootViewController.h"
#import "FoodViolationsAboutRIIS.h"
#import "RestaurantsDAO.h";
#import "Restaurant.h";


@implementation FoodViolationsMapViewController

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

@synthesize restaurantsMapView;

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	CLLocationCoordinate2D mapCenter;
	// CLLocation *curPos = self.locationManager.location;
	
	mapCenter.latitude = (double) 42.5636;		// [[restaurant objectForKey:LAT_KEY] doubleValue];
	mapCenter.longitude = (double) -83.1108;	// [[restaurant objectForKey:LONG_KEY] doubleValue];
	
	MKCoordinateSpan mapSpan;
	mapSpan.latitudeDelta = 0.003;
	mapSpan.longitudeDelta = 0.003;
	
	MKCoordinateRegion mapRegion;
	mapRegion.center = mapCenter;
	mapRegion.span = mapSpan;
	
	//annotation = [[AddressAnnotation alloc] initWithCoordinate:mapCenter];
	//[self.restaurantMapView addAnnotation:annotation];
	
	self.restaurantsMapView.region = mapRegion;
	self.restaurantsMapView.mapType = MKMapTypeStandard;
	
	Restaurant* r = [[Restaurant alloc] initWithName:@"RestOne" address:@"noAddress" date:@"Today" latitude:@"42.5635" longitude:@"-83.1107"];
	[self.restaurantsMapView addAnnotation:r];

	Restaurant* r2 = [[Restaurant alloc] initWithName:@"RestTwo" address:@"noAddress" date:@"Today" latitude:@"42.5630" longitude:@"-83.1103"];
	[self.restaurantsMapView addAnnotation:r2];

//	restaurantNameTextField.text = [restaurant objectForKey:NAME_KEY];
//	restaurantAddressTextView.text = [restaurant objectForKey:ADDRESS_KEY];
//	restaurantDateTextField.text = [restaurant objectForKey:DATE_KEY];
//	restaurantLevelTextField.text = [restaurant objectForKey:LEVEL_KEY];
//	restaurantDescTextView.text = [restaurant objectForKey:DESCRIPTION_KEY];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

@synthesize searchButton;
@synthesize debugText;

-(IBAction) searchButtonPressed:(id) sender
{
		debugText.text = @"Search Pressed";
	RestaurantsDAO* rsdao = [RestaurantsDAO GetInstance];

	debugText.text = rsdao.CurrentRestaurantName;
	
	[self viewWillAppear:TRUE];

//	[self.navigationController popToRootViewControllerAnimated:YES]; //pushViewController:rootViewController animated:YES];
	
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
	NSLog(@"%s", __func__);
    [super dealloc];
}


@end
