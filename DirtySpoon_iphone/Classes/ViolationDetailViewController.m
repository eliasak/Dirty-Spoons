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
#import "Violation.h";
#import "CustomCellViolation.h"

@implementation ViolationDetailViewController
@synthesize restaurant;
@synthesize restaurantAddressTextView;


@synthesize restaurantPhoneNumber;
@synthesize countCriticalViolations;
@synthesize countNonCriticalViolations;

@synthesize showCritical;	// toggled to show critical violations or not
@synthesize showNonCritical;	// toggled to show non-critical violations or not

@synthesize violations;


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	// initialize what to show
	showCritical  = TRUE;
	showNonCritical = TRUE;
	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void) viewWillAppear:(BOOL)animated {

	//	
	RestaurantsDAO* rsdao = [RestaurantsDAO GetInstance];

	self.title = rsdao.CurrentRestaurant.Name;
	 
	restaurantAddressTextView.text = rsdao.CurrentRestaurant.Address;
	
	restaurantPhoneNumber.text = rsdao.CurrentRestaurant.Phone;
	
	countCriticalViolations.text = [NSString stringWithFormat:@"%d", [rsdao.CurrentRestaurant NumberOfCriticalIncidents]];
	countNonCriticalViolations.text = [NSString stringWithFormat:@"%d", [rsdao.CurrentRestaurant NumberOfNonCriticalIncidents]];
}


@synthesize criticalFilterButton;
-(IBAction)criticalFilterButtonPressed:(id) sender
{	
	showCritical = TRUE;
	criticalFilterButton.selected = !showCritical;   // when selected is true button shows as dimmed
	
	showNonCritical = FALSE;
	nonCriticalFilterButton.selected = !showNonCritical;
	
	[self.violations reloadData];
}


@synthesize nonCriticalFilterButton;
-(IBAction)nonCriticalFilterButtonPressed:(id) sender
{
	showCritical = FALSE;
	criticalFilterButton.selected = !showCritical;	// when selected is true button shows as dimmed
	
	showNonCritical = TRUE;
	nonCriticalFilterButton.selected = !showNonCritical;
	
	[self.violations reloadData];
}


@synthesize phoneNumberButton;
-(IBAction)phoneNumberButtonPressed:(id) sender
{	
	RestaurantsDAO* rsdao = [RestaurantsDAO GetInstance];	
	
	NSString *phoneStr = [[NSString alloc] initWithFormat:@"tel:%@",rsdao.CurrentRestaurant.Phone];
	NSURL *phoneURL = [[NSURL alloc] initWithString:phoneStr];
	[[UIApplication sharedApplication] openURL:phoneURL];
	
	[phoneStr release];
	[phoneURL release];
}

#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	int totalViolations = 0;
	
	if( showCritical )
		totalViolations += [[RestaurantsDAO GetInstance].CurrentRestaurant NumberOfCriticalIncidents];

	if( showNonCritical )
		totalViolations += [[RestaurantsDAO GetInstance].CurrentRestaurant NumberOfNonCriticalIncidents];

	return totalViolations;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	RestaurantsDAO* rsdao = [RestaurantsDAO GetInstance];
	
	static NSString *CellIdentifier = @"violationCell";
    
    //UITableViewCell
	CustomCellViolation *cell = (CustomCellViolation*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil){
		
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CustomCellViolation" owner:nil options:nil];
		
		for(id currentObject in topLevelObjects)
		{
			if([currentObject isKindOfClass:[CustomCellViolation class]])
			{
				cell = (CustomCellViolation *)currentObject;
				break;
			}
		}
	}
    
	
	//
	
	//
	// Let's find the correct violation depending on if there is a filter to show only critical or non-critical violations
	Violation* v;
	if( showCritical && !showNonCritical) {
		// return the indexPath.row'th critical violation in violations array
		//   note can/should be refactored into Restaurant class
		int criticalCount = 0;
		for(int i = 0; i < [rsdao.CurrentRestaurant.Violations count]; i++ ) {
			if( [[rsdao.CurrentRestaurant.Violations objectAtIndex:i] IsCritical] ) {
				if(criticalCount == indexPath.row) {
					v =[rsdao.CurrentRestaurant.Violations objectAtIndex:i];
				}
				criticalCount ++;
			}			
		}
	} else if( !showCritical && showNonCritical) {
		// return the indexPath.row'th nonCritical violation in violations array
		//   note can/should be refactored with above into Restaurant class
		int nonCriticalCount = 0;
		for(int i = 0; i < [rsdao.CurrentRestaurant.Violations count]; i++ ) {
			if( ![[rsdao.CurrentRestaurant.Violations objectAtIndex:i] IsCritical] ) {
				if(nonCriticalCount == indexPath.row) {
					v =[rsdao.CurrentRestaurant.Violations objectAtIndex:i];
				}
				nonCriticalCount ++;
			}			
		}		
	} else {	
		// showCritical && showNonCritical 
		v =[rsdao.CurrentRestaurant.Violations objectAtIndex:indexPath.row];
	}

	
	[[cell type] setText:v.Type];
	if( [v IsCritical] ) {
		[[cell type] setTextColor:[UIColor redColor]];
	} else {
		[[cell type] setTextColor:[UIColor greenColor]];
	}

	[[cell description] setText:v.Description];
	
	[[cell date] setText:[NSDate stringFromDate:v.Date withFormat:[NSDate dateFormatString]]];

    return cell;
}

#pragma mark -
#pragma mark Table view delegate


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
//	NSLog(@"%s", __func__);
	
//	[restaurantAddressTextView release];
//	[restaurant release];
//	[restaurantAddressTextView release];
//	[restaurantPhoneNumber release];
//	[countCriticalViolations release];
//	[countNonCriticalViolations release];
//	[violations release];
	
    [super dealloc];
}


@end
