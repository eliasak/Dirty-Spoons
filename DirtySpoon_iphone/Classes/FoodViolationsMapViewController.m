//
//  FoodViolationsMapViewController.m
//  FoodViolations
//
//  Created by Godfrey Nolan on 7/16/10.
//  Copyright 2010 RIIS LLC. All rights reserved.
//

#import "FoodViolationsMapViewController.h"
#import "ViolationDetailViewController.h"
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
@synthesize toolBar;


- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	CLLocationCoordinate2D mapCenter;
	
	//
	RestaurantsDAO* rsdao = [RestaurantsDAO GetInstance];
	
	[rsdao UpdateCurrentLocation];
	
	MKCoordinateSpan mapSpan;
	MKCoordinateRegion mapRegion;
	
	mapSpan.latitudeDelta = 0.003;
	mapSpan.longitudeDelta = 0.003;
	
	//
	// Make current restaurant the current location OTHERWISE make the real current location it 
	if(rsdao.CurrentRestaurant != nil) {
		mapRegion.center = rsdao.CurrentRestaurant.coordinate; //mapCenter;

//		mapSpan.latitudeDelta = 0.003;
//		mapSpan.longitudeDelta = 0.003;
	} else {
		mapRegion.center = rsdao.CurrentLocation;

//		mapSpan.latitudeDelta = 0.5;
//		mapSpan.longitudeDelta = 0.5;
	}
	mapRegion.span = mapSpan;

	
	self.restaurantsMapView.region = mapRegion;
	self.restaurantsMapView.mapType = MKMapTypeStandard;

	//
	// Plot all restaurants on the map	
	for( Restaurant* r in rsdao.AllRestaurants) {
		[self.restaurantsMapView addAnnotation:r];			
	}

	//
	// Godfrey - should we hardcode the RIIS or OakGov office and phone numbers?
		//	Restaurant* r2 = [[Restaurant alloc] initWithName:@"RestTwo" address:@"noAddress" date:@"Today" latitude:@"42.5630" longitude:@"-83.1103"];
		//	[self.restaurantsMapView addAnnotation:r2];

}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(Restaurant *) annotation{
	int postag = 0;
	
	MKPinAnnotationView *annView=[[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"] autorelease];

	//
	if( [annotation HasCriticalIncidents] )
		annView.pinColor = MKPinAnnotationColorRed;
	else
		annView.pinColor = MKPinAnnotationColorGreen;
	
	//
	UIButton *myDetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
	myDetailButton.frame = CGRectMake(0, 0, 23, 23);
	myDetailButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	myDetailButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	
	// Set the image for the button
	[myDetailButton setImage:[UIImage imageNamed:@"button_right.png"] forState:UIControlStateNormal];
	[myDetailButton addTarget:self action:@selector(showLinks:) forControlEvents:UIControlEventTouchUpInside]; 
	
	postag = annotation.ID;
	myDetailButton.tag  = postag;
		
	// Set the button as the callout view
	annView.rightCalloutAccessoryView = myDetailButton;
	
	annView.animatesDrop=TRUE;
	annView.canShowCallout = YES;
	annView.calloutOffset = CGPointMake(-5, 5);
	return annView;
}

- (IBAction)showLinks:(id)sender
{
	int nrButtonPressed = ((UIButton *)sender).tag;
	
	self.tabBarController.selectedIndex = 1;		// go to second tab page (aka Search)

	// 
	// We are going to check which view is loaded in tab 0 (either the  RootViewController or ViolationDetailViewController) and
	// and we will make sure the Detail view is loaded with the correct restaurant that is selected
	//   YES, there is probably a better place for this code, like the NavigationController, but since we're using the default Nav
	//   controller that the TabBarController instanciates for tab 0, we'll put the code here for now ;)

	NSString* currentRView = [[(UINavigationController*)self.tabBarController.selectedViewController visibleViewController] nibName];
	
	// load selected restaurant as "current restaurant"
	RestaurantsDAO* rsdao = [RestaurantsDAO GetInstance];
	rsdao.CurrentRestaurant = [rsdao FindRestaurantWithID:nrButtonPressed];
	
	// make sure detail screen is showing
	if( [currentRView rangeOfString:@"RootViewController" options:NSCaseInsensitiveSearch].length > 0 ) {
		// need detail view
		ViolationDetailViewController *violationDetailViewController = [[ViolationDetailViewController alloc] 
																		initWithNibName:@"ViolationDetailViewController" 
																		bundle:nil];
		[(UINavigationController*)self.tabBarController.selectedViewController pushViewController:violationDetailViewController animated:YES];
		[violationDetailViewController release];
	} // else detailView is already loaded
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);

 }
*/

@synthesize showAllButton;
-(IBAction) showAllButtonPressed:(id) sender
{
//	NSLog(@"%s", __func__);
		
	[self RemoveAnnotations];

	[self ShowAllRestaurants];
}

@synthesize criticalButton;
-(IBAction)criticalButtonPressed:(id) sender
{
//	NSLog(@"%s", __func__);
	
	RestaurantsDAO* rsdao = [RestaurantsDAO GetInstance];
	
	[self RemoveAnnotations];
	
	for( Restaurant* r in rsdao.AllRestaurants) {
		if( [r HasCriticalIncidents] )
			[self.restaurantsMapView addAnnotation:r];			
	}
}

@synthesize nonCriticalButton;
-(IBAction)nonCriticalButtonPressed:(id) sender
{
//	NSLog(@"%s", __func__);

	RestaurantsDAO* rsdao = [RestaurantsDAO GetInstance];

	[self RemoveAnnotations];

	for( Restaurant* r in rsdao.AllRestaurants) {
		if( ![r HasCriticalIncidents] )
			[self.restaurantsMapView addAnnotation:r];			
	}
}

-(void)RemoveAnnotations 
{
//	NSLog(@"%s", __func__);

	for( int i = 0; i < [[self.restaurantsMapView annotations] count]; i++ ) {
		[self.restaurantsMapView removeAnnotations:[self.restaurantsMapView annotations]];
	}
}

-(void) ShowAllRestaurants
{
//	NSLog(@"%s", __func__);
	
	RestaurantsDAO* rsdao = [RestaurantsDAO GetInstance];
	
	[self RemoveAnnotations];
	
	for( Restaurant* r in rsdao.AllRestaurants) {
		[self.restaurantsMapView addAnnotation:r];			
	}
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
	[toolBar dealloc];
	[restaurantsMapView dealloc];
    [super dealloc];
}


@end
