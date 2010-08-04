//
//  RestaurantsDAO.h
//  FoodViolations
//
//  Created by Godfrey Nolan on 7/20/10.
//  Copyright 2010 RIIS LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Restaurant.h"

@interface RestaurantsDAO : NSObject <CLLocationManagerDelegate> {

	@private Restaurant* _currentRestaurant;		// currently selected/viewing restaurant
	@private NSArray* _allRestaurants;
	@private NSString* _filterText;
	
	CLLocationManager* locationManager;

	@private CLLocationCoordinate2D _currentLocation;		// struct
}

//
// Properties
@property (nonatomic, retain) Restaurant* CurrentRestaurant;
@property (readonly, retain) NSArray* AllRestaurants;			// returns all loaded restaurants
@property (readonly, retain) NSArray* FilteredRestaurants;	// returns a subset of allRestaurants after the filter has been applied
@property (nonatomic, retain) NSString* FilterText;

@property (nonatomic, retain) CLLocationManager* locationManager;

@property (nonatomic, readonly) CLLocationCoordinate2D CurrentLocation;

//
// Messages
+ (RestaurantsDAO*) GetInstance;	// get singleton dao

-(void)UpdateCurrentLocation;		// start pinging for location... this drains the battery, will stop after/if updated
-(Restaurant*)FindRestaurantWithID:(int) rID;

@end
