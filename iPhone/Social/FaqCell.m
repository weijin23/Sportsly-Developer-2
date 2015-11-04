//
//  FaqCell.m
//  Wall
//
//  Created by Sukhamoy on 17/04/14.
//
//

#import "FaqCell.h"

@implementation FaqCell

+(id)customCell{
    
   // return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil] objectAtIndex:0];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return [[[NSBundle mainBundle] loadNibNamed:@"FaqCell_iPad" owner:self options:nil] objectAtIndex:0];
    }
    else{
        return [[[NSBundle mainBundle] loadNibNamed:@"FaqCell" owner:self options:nil] objectAtIndex:0];
    }
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
