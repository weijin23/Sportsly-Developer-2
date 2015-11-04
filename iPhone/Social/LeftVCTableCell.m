//
//  SelectImageCell.m
//  RealEstate
//
//  Created by Mindpace on 09/04/13.
//  Copyright (c) 2013 Mindpace. All rights reserved.
//

#import "LeftVCTableCell.h"


@implementation LeftVCTableCell
@synthesize leftimav,detailslab1,backGroundvw;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



@end
