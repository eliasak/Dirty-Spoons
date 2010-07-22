//
//  Restaurant.m
//  FoodViolations
//
//  Created by Godfrey Nolan on 7/21/10.
//  Copyright 2010 RIIS LLC. All rights reserved.
//

#import "Restaurant.h"


@implementation Restaurant

@synthesize Name=_name;
@synthesize Address=_address;
//@synthesize ZipCode=_zipCode;
@synthesize Date=_date;
@synthesize Latitude=_latitude;
@synthesize Longitude=_longitude;

-(id) initWithName:(NSString*)name address:(NSString*) address date:(NSString*) date latitude:(NSString*) latitude longitude:(NSString*) longitude;
{
	self = [super init];
	
	if( self) {
		_name = name;
		_address = address;
		_date = date;
		_latitude = latitude;
		_longitude = longitude;
	}
	
	return self;
}

-(bool) isMappable
{
	NSLog(@"%s : function has NOT been implemented", __func__);
	return TRUE;
}

-(bool) hasCriticalIncidents
{
	NSLog(@"%s : function has NOT been implemented", __func__);
	return self.numberOfIncidents > 3;
}

-(int) numberOfIncidents
{
	NSLog(@"%s : function has NOT been implemented", __func__);
	return (int)(rand() % 5);
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
	return [NSString stringWithFormat:@"%d number of violations and test faf asdfasdfa dafads", self.numberOfIncidents];
}


- (void)dealloc {
	NSLog(@"%s", __func__);

	[_name dealloc];
	[_address dealloc];
	//[_zipCode dealloc];
	[_date dealloc];
	[_latitude dealloc];
	[_longitude dealloc];

    [super dealloc];

}

@end
