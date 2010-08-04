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
	@private int _id;
	@private NSString* _name;
	@private NSString* _address;
	//@private NSString* _zipCode;
	@private NSString* _phone;
	@private NSString* _latitude;
	@private NSString* _longitude;
	
	//
	// Food Incidents array
	@private NSArray* _violations;
}

@property int ID;
@property (nonatomic,retain) NSString* Name;
@property (nonatomic,retain) NSString* Address;
//@property (nonatomic,retain) NSString* ZipCode;
@property (nonatomic,retain) NSString* Phone;
@property (nonatomic,retain) NSString* Latitude;
@property (nonatomic,retain) NSString* Longitude;
@property (nonatomic,retain) NSArray* Violations;

-(id) initWithName:(NSString*)name address:(NSString*) address phone:(NSString*) phone latitude:(NSString*) latitude longitude:(NSString*) longitude RestaurantID:(int) RestaurantID;

-(bool) IsMappable;

-(bool) HasCriticalIncidents;

-(int) NumberOfCriticalIncidents;
-(int) NumberOfNonCriticalIncidents;

#pragma mark -
#pragma mark MapKit Annotation Protocol
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
-(NSString*) title;
-(NSString*) subtitle;

@end
