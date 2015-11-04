//
//  CustomcellCell.m
//  TestContact
//
//  Created by Sukhamoy on 18/11/13.
//  Copyright (c) 2013 Sukhamoy. All rights reserved.
//

#import "CustomcellCell.h"

@implementation CustomcellCell

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
    [_deletBtn release];
    [_dropDownlist release];
    [_title release];
    [_textField release];
    [_editBtn release];
    [_delBtn release];
    [super dealloc];
}
@end
