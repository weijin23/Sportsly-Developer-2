//
//  PlayerCell.m
//  Wall
//
//  Created by Sukhamoy on 25/11/13.
//
//

#import "PlayerCell.h"

@implementation PlayerCell


+(id)playerCell{
    
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

- (void)dealloc {
    [_titleLbl release];
    [_relationLbl release];
    [_iconImageView release];
    [super dealloc];
}
@end
