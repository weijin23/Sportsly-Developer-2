//
//  MyTableView.m
//  Wall
//
//  Created by Sukhamoy on 13/02/14.
//
//

#import "MyTableView.h"

@implementation MyTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(BOOL) allowsHeaderViewsToFloat{
    return NO;
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
