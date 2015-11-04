//
//  SetScheduleCell.m
//  FoodTruckTracker
//
//  Created by Piyali on 17/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RightVCTableCell.h"


@implementation RightVCTableCell

@synthesize userName,cmnts,acindviewuser,userima,imastatus_firstvw,imastatus_secondvw;

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

-(void)dealloc
{
    ///////
    self.userima=nil;
   
   
    self.acindviewuser=nil;
   
    self.cmnts=nil;
    
    /////////////
    self.imastatus_firstvw=nil;
    self.imastatus_secondvw=nil;
    self.userName=nil;;
    [_sportImage1 release];
    [_sportImage2 release];

    [_mailButton release];
    [_phoneButton release];
    [_chatButton release];
    [super dealloc];
}

@end
