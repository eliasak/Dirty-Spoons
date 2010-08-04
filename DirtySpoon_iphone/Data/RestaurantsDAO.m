//
//  RestaurantsDAO.m
//  FoodViolations
//
//  Created by Godfrey Nolan on 7/20/10.
//  Copyright 2010 RIIS LLC. All rights reserved.
//

#import "RestaurantsDAO.h"
#import "Restaurant.h"
#import "Violation.h"
#import "RestaurantConstants.h"


@implementation RestaurantsDAO

static RestaurantsDAO *sharedSingleton = nil;

//
// Properties
@synthesize CurrentLocation = _currentLocation;

@synthesize CurrentRestaurant = _currentRestaurant;
@synthesize FilterText = _filterText;

NSString* _currentFilterText;
NSArray* _restaurantsFiltered;

-(NSArray*) AllRestaurants
{
	return [[_allRestaurants copy] autorelease];		// readonly property
}

-(NSArray*) FilteredRestaurants
{
	return [[[self GetRestaurantsFiltered] copy] autorelease];		// readonly property
}


//
// Methods/Messages
+ (RestaurantsDAO*) GetInstance {

	@synchronized(self) {
		if (sharedSingleton == nil) {
			sharedSingleton = [[RestaurantsDAO alloc] init];
			//NSLog(@"Instantiate Singleton RestaurantsDAO %s", __func__);
		}
	}
	return sharedSingleton;
}

+ (id) allocWithZone:(NSZone *) zone {
	@synchronized(self) {
		if (sharedSingleton == nil) {
			sharedSingleton = [super allocWithZone:zone];
			return sharedSingleton;
		}
	}
	return nil;
}

-(id) init
{
	self = [super init];
	
	// load the restaurants
	_allRestaurants = [self GetRestaurantsAll];

	// hard code location to Ferndale, MI
	_currentLocation.latitude = 42.4607;
	_currentLocation.longitude = -83.12434;
	
	return self;
}

-(NSArray*) GetRestaurantsAll
{
	//
	//
	if([_allRestaurants length] > 0 )
		return _allRestaurants;
	  
	//
	//
	NSString *path = [[NSBundle mainBundle] pathForResource:@"RestaurantArray" ofType:@"plist"];
	NSArray *restaurantsPList = [[NSArray alloc] initWithContentsOfFile:path];
	
	NSMutableArray* restaurants = [[[NSMutableArray alloc] init] retain];

	Restaurant* r;
	Violation* v;
	NSMutableArray* tmpViolations;
	
	int i = 0;
	for(NSDictionary* rRow in restaurantsPList) {

		r = [[Restaurant alloc] initWithName:[rRow objectForKey:NAME_KEY]
									 address:[rRow objectForKey:ADDRESS_KEY]
										phone:[rRow objectForKey:PHONE_KEY]
									latitude:[rRow objectForKey:LAT_KEY]
								   longitude:[rRow objectForKey:LONG_KEY]
								RestaurantID:i++] ;
		
		// read in violations
		tmpViolations = [[NSMutableArray alloc] init];
		for(NSDictionary* vRow in [rRow objectForKey:VIOLATIONS_KEY])
		{
			v = [[Violation alloc] initWithType:[vRow objectForKey:VTYPE_KEY]
										    Date:[vRow objectForKey:VDATE_KEY]
								     Description:[vRow objectForKey:VDESCRIPTION_KEY] ] ;

			[tmpViolations addObject:v];
		}
		r.Violations = [[tmpViolations copy] retain];	// will copy to NSArray
		
		//
		// Add restaurant
		[restaurants addObject:r];
	}
		
	return restaurants; // _allRestaurants;
}

-(NSArray*) GetRestaurantsFiltered
{
	// if filter is empty return all restaurants
	if ( [_filterText length] < 1 ) {
		return _allRestaurants;
	} else	if( [_filterText caseInsensitiveCompare:_currentFilterText] == NSOrderedSame ) {
		// if filter is same as what was already filtered, return current filterered set
		return _restaurantsFiltered;	
	} else {

		// filter and create new array of restaurants
		NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithCapacity:[_allRestaurants count]];

		for(Restaurant* r in _allRestaurants) {
			if( [r.Name rangeOfString:_filterText options:NSCaseInsensitiveSearch].length > 0 ) {
				[tmpArray addObject:r];
			}
		}
		
		_restaurantsFiltered = [[tmpArray copy] autorelease];
		_currentFilterText = [_filterText copy];
		
		return _restaurantsFiltered;
		}
}


-(Restaurant*)FindRestaurantWithID:(int) rID
{
	for(Restaurant* r in _allRestaurants) {
		if( r.ID== rID ) {
			return r;
		}
	}

	return nil;
}


//
// Starts updating the location
-(void)UpdateCurrentLocation 
{	
NSLog(@"%s : Function NEEDS to be implemented. Stub is hardcoded to set Ferndale, MI as the current location", __func__);

	//
	// Uncomment the next 4 lines so that the app turns on GPS and sets _currentLocation
//	locationManager = [[CLLocationManager alloc] init];
//	locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
//	locationManager.delegate = self;
//	[locationManager startUpdatingLocation];

}

// location api delegate
-(void)locationManager:(CLLocationManager *) manager
   didUpdateToLocation:(CLLocation *) newLocation
		  fromLocation:(CLLocation *) oldLocation 
{
//	NSLog(@"%s : MyLocation updated: %@", __func__, newLocation);
	
	_currentLocation = newLocation.coordinate;
	
	[locationManager stopUpdatingLocation];
}

// location api delegate
-(void)locationManager:(CLLocationManager *) manager
	  didFailWithError:(NSError *) error 
{
//	NSLog(@"%s : Failed to update MyLocation:% @", __func__, error);

	[locationManager stopUpdatingLocation];
}


- (void)dealloc {
	NSLog(@"%s : WARNING: dealloc RestaurantsDAO should only occur when app is deallocated", __func__);
    [super dealloc];
}


@end
