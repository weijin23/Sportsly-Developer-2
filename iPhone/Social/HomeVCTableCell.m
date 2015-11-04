//
//  SetScheduleCell.m
//  FoodTruckTracker
//
//  Created by Piyali on 17/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HomeVCTableCell.h"


@implementation HomeVCTableCell

@synthesize cmnts,acindviewuser,acindviewposted,userima,posted;
@synthesize likebt,commentbt,closebt,likecountlab,commentcountlab,mainContainer,subContainer,acindviewsecondary,userimasecondary,playerlab,playernamelab,commentImage,likeImage,postedonlab,postedondatelab,likeorunlikelab,likeslab,cmntslab,profileimabt,viewCommentsbt,viewLikesbt,videoplayimavw,likeslabima,commentslabima;

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


@end
