//
//  TeamListCell.m
//  Social
//
//  Created by Animesh@Mindpace on 10/09/13.
//
//

#import "AddAFriendListCell.h"


@implementation AddAFriendListCell
@synthesize teamName,delBtn,sport,posted,acindviewposted,mainBackgroundVw,btCheck;


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
