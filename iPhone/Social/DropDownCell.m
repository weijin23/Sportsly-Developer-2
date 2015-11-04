//
//  DropDownCell.m
//  Wall
//
//  Created by Sukhamoy on 18/12/13.
//
//

#import "DropDownCell.h"

@implementation DropDownCell

+(id)customCell{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil] objectAtIndex:0];
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void)dealloc {
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
