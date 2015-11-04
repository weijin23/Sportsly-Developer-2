//
//  PlayerListCell.m
//  Social
//
//  Created by Animesh@Mindpace on 10/09/13.
//
//

#import "PlayerListCell.h"

@implementation PlayerListCell

+(id)customCell{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return [[[NSBundle mainBundle] loadNibNamed:@"PlayerListCell_iPad" owner:self options:nil] objectAtIndex:0];
    }
    else{
        return [[[NSBundle mainBundle] loadNibNamed:@"PlayerListCell" owner:self options:nil] objectAtIndex:0];
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

-(void)dealloc
{
    [_title release];
    [_editBtn release];
    [_delBtn release];
    [_addMinNameText release];
    [_addMinEmailText release];
    [_addMinPhoneText release];
    [_rowSeparator release];
    [_addressBookBtn release];
    [super dealloc];
}


@end
