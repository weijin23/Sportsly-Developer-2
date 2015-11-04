//
//  RosterCell.m
//  Wall
//
//  Created by Sukhamoy on 12/11/13.
//
//

#import "RosterCell.h"

@implementation RosterCell

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
- (void)dealloc
{
    self.detailslabTime=nil;
    self.leftimav=nil;
    self.detailslabName=nil;
    self.detailslabField=nil;
    
    self.backgroundStatusView=nil;
    [_rosterBtn release];
    [_rosterImageView release];
    [super dealloc];
}

@end
