//
//  RootViewController.m
//  FoodViolations
//
//  Created by Godfrey Nolan on 5/22/10.
//  Copyright RIIS LLC 2010. All rights reserved.
//

#import "RootViewController.h"
#import "ViolationDetailViewController.h"
#import "FoodViolationsMapViewController.h"
#import "FoodViolationTabs.h"
#import "RestaurantConstants.h"
#import "RestaurantsDAO.h";
#import "Restaurant.h";

@implementation RootViewController

@synthesize restaurants;
@synthesize tableView;


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
//	NSLog(@"%s", __func__);
    [super viewDidLoad];

	RestaurantsDAO* rsdao = [RestaurantsDAO GetInstance];
	self.restaurants = rsdao.FilteredRestaurants;
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//	NSLog(@"%s", __func__);

    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//	NSLog(@"%s", __func__);

    return [self.restaurants count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
	Restaurant* r = [self.restaurants objectAtIndex:indexPath.row];
	cell.textLabel.text = r.Name;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void) GoToRestaurantDetailView {
	
	  ViolationDetailViewController *violationDetailViewController = [[ViolationDetailViewController alloc] 
																	initWithNibName:@"ViolationDetailViewController" 
																	bundle:nil];

	[self.navigationController pushViewController:violationDetailViewController animated:YES];
	[violationDetailViewController release];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	RestaurantsDAO* rsdao = [RestaurantsDAO GetInstance];

	rsdao.CurrentRestaurant = ((Restaurant*)[self.restaurants objectAtIndex:indexPath.row]);

	[self GoToRestaurantDetailView];

}


- (void) FilterRestaurants {
	
	RestaurantsDAO* rsdao = [RestaurantsDAO GetInstance];

	rsdao.FilterText = searchBar.text;

	self.restaurants = rsdao.FilteredRestaurants;

	[searchBar resignFirstResponder];
	
	[self.tableView reloadData];

}

//#pragma mark UISearchBarDelegate
//- (void)searchBarTextDidBeginEditing:(UISearchBar *)sBar
//{
//	// only show the status bar’s cancel button while in edit mode
//	searchBar.showsCancelButton = YES;
//	searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
//	// flush the previous search content
////	[tableData removeAllObjects];
//}
//
//- (void)searchBarTextDidEndEditing:(UISearchBar *)sBar
//{
//	searchBar.showsCancelButton = NO;
//}

-(void) searchBar_DoneClicked:(id)sender
{	
	[self FilterRestaurants];
}

- (void) searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar
{
	//Add the done button.
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
							initWithBarButtonSystemItem:UIBarButtonSystemItemDone
							target:self action:@selector(searchBar_DoneClicked:)] autorelease];
	
}

- (void) searchBarTextDidEndEditing:(UISearchBar *)theSearchBar
{

	[self FilterRestaurants];

//	[searchBar resignFirstResponder];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {

	[self FilterRestaurants];

	[searchBar resignFirstResponder];
}

-(void)ViewRestaurantDetail
{

	// Go to detail page
	[self GoToRestaurantDetailView];	
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[restaurants release];
    [super dealloc];
}


@end

