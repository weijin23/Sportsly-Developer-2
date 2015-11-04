//
//  InviteCell.m
//  Wall
//
//  Created by Sukhamoy on 10/04/14.
//
//

#import "InviteCell.h"

@implementation InviteCell

+(id)inviteCell{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return [[[NSBundle mainBundle] loadNibNamed:@"InviteCell_iPad" owner:self options:nil] objectAtIndex:0];
    }
    else{
        return [[[NSBundle mainBundle] loadNibNamed:@"InviteCell" owner:self options:nil] objectAtIndex:0];
    }
    //return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil] objectAtIndex:0];
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

@end
