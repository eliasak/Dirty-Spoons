//
//  Restaurant.m
//  FoodViolations
//
//  Created by Godfrey Nolan on 7/21/10.
//  Copyright 2010 RIIS LLC. All rights reserved.
//

#import "Restaurant.h"
#import "Violation.h"


@implementation Restaurant

@synthesize ID=_id;
@synthesize Name=_name;
@synthesize Address=_address;
//@synthesize ZipCode=_zipCode;
@synthesize Phone=_phone;
@synthesize Latitude=_latitude;
@synthesize Longitude=_longitude;
@synthesize Violations=_violations;

-(id) initWithName:(NSString*)name address:(NSString*) address phone:(NSString*) phone latitude:(NSString*) latitude longitude:(NSString*) longitude RestaurantID:(int) RestaurantID
{
	self = [super init];
	
	if( self) {
		_id = RestaurantID;
		_name = name;
		_address = address;
		_phone = phone;
		_latitude = latitude;
		_longitude = longitude;
	}
	
	return self;
}

-(bool) IsMappable
{
//	NSLog(@"%s", __func__);
	
	return ( [_latitude length] > 0 && [_longitude length] > 0 );
}

-(bool) HasCriticalIncidents
{
//	NSLog(@"%s", __func__);
	
	return ([self NumberOfCriticalIncidents] > 0);
}

-(int) NumberOfCriticalIncidents;
{
//	NSLog(@"%s", __func__);
	
	if( _violations == nil )
		return 0;
	else {
		int i = 0;
		for(Violation* v in _violations)
			if( [v IsCritical] )
				i++;
		
		return i;
	}
}

-(int) NumberOfNonCriticalIncidents;
{
//	NSLog(@"%s", __func__);
	
	if( _violations == nil )
		return 0;
	else {
		int i = 0;
		for(Violation* v in _violations)
			if( ![v IsCritical] )
				i++;
		
		return i;
	}
}


//
// Implement MKAnnotation
-(CLLocationCoordinate2D) coordinate
{
	CLLocationCoordinate2D lc;// = [[CLLocationCoordinate2D alloc] init];
	lc.latitude = [_latitude doubleValue];
	lc.longitude = [_longitude doubleValue];
	
	return lc;	
}

-(NSString*) title
{
	return _name;
}

-(NSString*) subtitle
{
	return [NSString stringWithFormat:@"%d critical and %d non critical violations", [self NumberOfCriticalIncidents], [self NumberOfNonCriticalIncidents]];
}


- (void)dealloc {
	NSLog(@"%s", __func__);

	[_name dealloc];
	[_address dealloc];
	//[_zipCode dealloc];
	[_phone dealloc];
	[_latitude dealloc];
	[_longitude dealloc];
	
	[_violations dealloc];

    [super dealloc];

}

@end
