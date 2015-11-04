//
//  EventPlayerCell.m
//  Wall
//
//  Created by Mindpace on 27/11/13.
//
//

#import "EventPlayerCell.h"

@implementation EventPlayerCell
@synthesize userName,imastatus_firstvw,profileimavw,statusNameLab;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
/*- (void)dealloc
{
    self.imastatus_firstvw=nil;
    self.userName=nil;
    [super dealloc];
}*/

@end
