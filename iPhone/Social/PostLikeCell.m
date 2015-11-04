//
//  PostLikeCell.m
//  Wall
//
//  Created by Sukhamoy on 26/12/13.
//
//

#import "PostLikeCell.h"

@implementation PostLikeCell


+(id)customCell{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil] objectAtIndex:0];
}

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

/*- (void)dealloc {
    [_proileImageView release];
    [_playername release];
    [_backView release];
    [super dealloc];
}*/
@end
