//
//  ClubLeagueCell.m
//  Wall
//
//  Created by Sukhamoy on 04/12/13.
//
//

#import "ClubLeagueCell.h"

@implementation ClubLeagueCell


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

- (void)dealloc {
    [_teamName release];
    [_clubName release];
    [_leagugeName release];
    [_leagugeBtn release];
    [_clubBtn release];
    [_backView release];
    [super dealloc];
}
- (IBAction)leagugeBtn:(id)sender {
}
@end
