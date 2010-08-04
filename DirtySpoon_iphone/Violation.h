//
//  Violation.h
//  OakGovChallenge_FoodViolations
//
//  Created by Godfrey Nolan on 7/28/10.
//  Copyright 2010 RIIS LLC. All rights reserved.
//


@interface Violation : NSObject {
	@private NSString* _type;
	@private NSDate* _date;
	@private NSString* _description;
}

//
//
@property (nonatomic, retain) NSString* Type;
@property (nonatomic, retain) NSDate* Date;
@property (nonatomic, retain) NSString* Description;


//
//
-(id) initWithType:(NSString*)iType Date:(NSDate*) iDate Description:(NSString*) iDescription;

-(bool)IsCritical;

@end
