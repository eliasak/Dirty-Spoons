//
//  RootViewController.h
//  FoodViolations
//
//  Created by Godfrey Nolan on 5/22/10.
//  Copyright RIIS LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController {
//	NSMutableArray* restaurants;
	NSArray* restaurants;
	
	IBOutlet UISearchBar *searchBar;
	
	IBOutlet UITableView* tableView;
}
//@property (nonatomic, retain) NSMutableArray* restaurants;
@property (nonatomic, retain) NSArray* restaurants;
@property (nonatomic, retain) UITableView* tableView;

- (void) searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar;
- (void) searchBarTextDidEndEditing:(UISearchBar *)theSearchBar;
-(void) searchBar_DoneClicked:(id)sender;
-(void) searchBarSearchButtonClicked:(id)sender;

@end
 