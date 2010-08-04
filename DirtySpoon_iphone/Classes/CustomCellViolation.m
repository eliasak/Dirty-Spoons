//
//  CustomCellViolation.m
//  OakGovChallenge_FoodViolations
//
//  Created by Godfrey Nolan on 7/30/10.
//  Copyright 2010 RIIS LLC. All rights reserved.
//

#import "CustomCellViolation.h"

@implementation CustomCellViolation

@synthesize type;
@synthesize date;
@synthesize description;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end
