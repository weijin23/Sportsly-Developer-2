//
//  InvitePlayerListCell.m
//  Wall
//
//  Created by Sukhamoy on 21/11/13.
//
//

#import "InvitePlayerListCell.h"

@implementation InvitePlayerListCell

+(id)inviteCell{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return [[[NSBundle mainBundle] loadNibNamed:@"InvitePlayerListCell_iPad" owner:self options:nil] objectAtIndex:0];
    }
    else{
        return [[[NSBundle mainBundle] loadNibNamed:@"InvitePlayerListCell" owner:self options:nil] objectAtIndex:0];
    }
   // return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil] objectAtIndex:0];
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

}

- (void)dealloc {
  
  
    [super dealloc];
}
@end
