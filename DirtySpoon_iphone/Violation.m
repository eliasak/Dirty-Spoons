//
//  Violation.m
//  OakGovChallenge_FoodViolations
//
//  Created by Godfrey Nolan on 7/28/10.
//  Copyright 2010 RIIS LLC. All rights reserved.
//

#import "Violation.h"


@implementation Violation

@synthesize Type = _type;
@synthesize Date = _date;
@synthesize Description = _description;


//
// METHODS / MESSAGES
//
-(id) initWithType:(NSString*)iType Date:(NSDate*) iDate Description:(NSString*) iDescription
{
	self = [super init];
	
	if(self) {
		_type = iType;
		_date = iDate;
		_description = iDescription;
	}
	
	return self;
}


-(bool)IsCritical
{
	//
	// If there is a "non" in the text, return false
	if( [_type rangeOfString:@"non" options:NSCaseInsensitiveSearch].length > 0 )
		return FALSE;
	else
		return TRUE;
}


@end
