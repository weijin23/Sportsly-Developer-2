//
//  EventCell.m
//  Social
//
//  Created by Sukhamoy Hazra on 26/08/13.
//
//

#import "EventPushCell.h"

@implementation EventPushCell
@synthesize detailslabField,detailslabName,detailslabTime,leftimav,backgroundStatusView;

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
