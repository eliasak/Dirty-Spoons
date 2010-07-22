//
//  RestaurantsDAO.m
//  FoodViolations
//
//  Created by Godfrey Nolan on 7/20/10.
//  Copyright 2010 RIIS LLC. All rights reserved.
//

#import "RestaurantsDAO.h"
#import "Restaurant.h"


@implementation RestaurantsDAO

static RestaurantsDAO *sharedSingleton = nil;

//
// Properties
@synthesize CurrentRestaurantName;
@synthesize AllRestaurants = _allRestaurants;
@synthesize FilterText = _filterText;
NSString* _currentFilterText;
NSArray* _restaurantsFiltered;

-(NSArray*) FilteredRestaurants
{
	return [[[self GetRestaurantsFiltered] copy] autorelease];
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
	NSLog(@"%s : loading ALL restaurants", __func__);
	_allRestaurants = [self GetRestaurantsAll];
		
	return self;
}

-(NSArray*) GetRestaurantsAll
{
	NSString *path = [[NSBundle mainBundle] pathForResource:@"RestaurantArray" ofType:@"plist"];
	NSArray *tmpArray = [[NSArray alloc] initWithContentsOfFile:path];

	return tmpArray;
}

-(NSArray*) GetRestaurantsFiltered
{
	// if filter is empty return all restaurants
	if ( [_filterText length] < 1 ) {
		NSLog(@"%s : DEBUG: filterText < 1", __func__);
		return _allRestaurants;
	} else	if( [_filterText caseInsensitiveCompare:_currentFilterText] == NSOrderedSame ) {
		// if filter is same as what was already filtered, return current filter set
		NSLog(@"%s : DEBUG: filterText == currentFilterText", __func__);
		return _restaurantsFiltered;	
	} else {
		NSLog(@"%s : DEBUG: filterText using %@", __func__, _filterText);
		// filter and create new array of restaurants
		NSMutableArray *tmpArray = [[NSMutableArray alloc] init];

		for(int i = 0; i <5; i++)
		{
			[tmpArray addObject:[_allRestaurants objectAtIndex:i]];
 		}
		
		_currentFilterText = _filterText;
		
		return [[tmpArray copy] autorelease];
	
//		for(Restaurant r in _allRestaurants) {
//			if( [r.Name isEqualToString:@"Dish"] )
//				[tmpArray arrayByAddingObject:r];
//		}
	}
}


- (void)dealloc {
	NSLog(@"%s : WARNING: dealloc RestaurantsDAO should only occur when app is deallocated", __func__);
    [super dealloc];
}


@end
