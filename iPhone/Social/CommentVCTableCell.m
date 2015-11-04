//
//  CommentVCTableCell.m
//  Wall
//
//  Created by Sukhamoy Hazra on 13/09/13.
//
//

#import "CommentVCTableCell.h"

@implementation CommentVCTableCell
@synthesize userimg,acindviewuser,postedByLbl,postedOnLbl,commntsLbl,userprofimabt,separator;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        //     [self.userName setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:12]];
        
        //      self.cmnts.font = [UIFont fontWithName:@"MyriadPro" size:11];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


@end
