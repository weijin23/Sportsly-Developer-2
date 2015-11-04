//
//  CustomSportCell.m
//  Wall
//
//  Created by Mindpace on 20/05/14.
//
//

#import "CustomSportCell.h"

@implementation CustomSportCell

+(id)customCell{
    
    if (!UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return [[[NSBundle mainBundle] loadNibNamed:@"CustomSportCell" owner:self options:nil] objectAtIndex:0];
    }
    else{
        return [[[NSBundle mainBundle] loadNibNamed:@"CustomSportCell_iPad" owner:self options:nil] objectAtIndex:0];
    }
    
    //return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil] objectAtIndex:0];
}
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
