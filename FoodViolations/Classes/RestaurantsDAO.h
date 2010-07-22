//
//  RestaurantsDAO.h
//  FoodViolations
//
//  Created by Godfrey Nolan on 7/20/10.
//  Copyright 2010 RIIS LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RestaurantsDAO : NSObject {
	NSString*	CurrentRestaurantName;	// debug testing

	@private NSArray* _allRestaurants;
	@private NSString* _filterText;
}

//
// Properties
@property (nonatomic, retain) NSString* CurrentRestaurantName;
@property (readonly, retain) NSArray* AllRestaurants;			// returns all loaded restaurants
@property (readonly, retain) NSArray* FilteredRestaurants;	// returns a subset of allRestaurants after the filter has been applied
@property (nonatomic, retain) NSString* FilterText;


//
// Messages
+ (RestaurantsDAO*) GetInstance;	// get singleton dao


@end
