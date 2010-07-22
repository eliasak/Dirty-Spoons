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
#import "RestaurantConstants.h"
#import "RestaurantsDAO.h";

@implementation RootViewController

@synthesize restaurants;
@synthesize tableView;


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
//	//NSMutableArray* tmpArray = [[NSMutableArray alloc] initWithObjects:@"Ali Baba Gyros", @"Doozy's", @"The Green Gateau", nil];
//	NSString *path = [[NSBundle mainBundle] pathForResource:@"RestaurantArray" ofType:@"plist"];
//	NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
// 	self.restaurants = tmpArray;
//	[tmpArray release];							

	RestaurantsDAO* rsdao = [RestaurantsDAO GetInstance];
	self.restaurants = rsdao.FilteredRestaurants;

	NSLog(@"%s : DEBUG", __func__);

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
	NSLog(@"%s : DEBUG", __func__);

    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSLog(@"%s : DEBUG", __func__);

    return [self.restaurants count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"%s : DEBUG", __func__);
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
	cell.textLabel.text = [[self.restaurants objectAtIndex:indexPath.row] objectForKey:NAME_KEY];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//	ViolationDetailViewController *violationDetailViewController = [[ViolationDetailViewController alloc] 
//																	initWithNibName:@"ViolationDetailViewController" 
//																	bundle:nil];
//
//	violationDetailViewController.restaurant = [self.restaurants objectAtIndex:indexPath.row];
//	[self.navigationController pushViewController:violationDetailViewController animated:YES];
//	[violationDetailViewController release];

	RestaurantsDAO* rsdao = [RestaurantsDAO GetInstance];
	rsdao.CurrentRestaurantName = [[self.restaurants objectAtIndex:indexPath.row] objectForKey:NAME_KEY];

	
	FoodViolationsMapViewController *foodViolationsMapViewController = [[FoodViolationsMapViewController alloc] 
																	initWithNibName:@"FoodViolationsMapViewController"
																	bundle:nil];
	[self.navigationController pushViewController:foodViolationsMapViewController animated:YES];
	[foodViolationsMapViewController release];
	
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
	 
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
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
//	FoodViolationsMapViewController *foodViolationsMapViewController = [[FoodViolationsMapViewController alloc] 
//																		initWithNibName:@"FoodViolationsMapViewController"
//																		bundle:nil];
//	[self.navigationController pushViewController:foodViolationsMapViewController animated:YES];
//	[foodViolationsMapViewController release];
	

	RestaurantsDAO* rsdao = [RestaurantsDAO GetInstance];

	rsdao.FilterText = searchBar.text;
	self.restaurants = rsdao.FilteredRestaurants;

	searchBar.text = [@"DONE: " stringByAppendingString: searchBar.text];

	[searchBar resignFirstResponder];
	
//	letUserSelectRow = YES;
//	searching = NO;
//	self.navigationItem.rightBarButtonItem = nil;
//	self.tableView.scrollEnabled = YES;
//	
	[self.tableView reloadData];
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
	searchBar.text = [@"ENDEDIT: " stringByAppendingString: searchBar.text];

	[searchBar resignFirstResponder];
	
	//	letUserSelectRow = YES;
	//	searching = NO;
	self.navigationItem.rightBarButtonItem = nil;
	self.tableView.scrollEnabled = YES;
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {

	searchBar.text = [@"SEARCH: " stringByAppendingString: searchBar.text];

	[searchBar resignFirstResponder];
	
	//	letUserSelectRow = YES;
	//	searching = NO;
	self.navigationItem.rightBarButtonItem = nil;
	self.tableView.scrollEnabled = YES;
	
	[self.tableView reloadData];
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

