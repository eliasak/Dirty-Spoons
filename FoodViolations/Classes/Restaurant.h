//
//  Restaurant.h
//  FoodViolations
//
//  Created by Godfrey Nolan on 7/21/10.
//  Copyright 2010 RIIS LLC. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface Restaurant : NSObject <MKAnnotation> {
	@private NSString* _name;
	@private NSString* _address;
	//@private NSString* _zipCode;
	@private NSString* _date;
	@private NSString* _latitude;
	@private NSString* _longitude;
	
	//
	// Food Incidents array
}

@property (nonatomic,retain) NSString* Name;
@property (nonatomic,retain) NSString* Address;
//@property (nonatomic,retain) NSString* ZipCode;
@property (nonatomic,retain) NSString* Date;
@property (nonatomic,retain) NSString* Latitude;
@property (nonatomic,retain) NSString* Longitude;

-(id) initWithName:(NSString*)name address:(NSString*) address date:(NSString*) date latitude:(NSString*) latitude longitude:(NSString*) longitude;

-(bool) isMappable;

-(bool) hasCriticalIncidents;

-(int) numberOfIncidents;

#pragma mark -
#pragma mark MapKit Annotation Protocol
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
-(NSString*) title;
-(NSString*) subtitle;

@end
