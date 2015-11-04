//
//  SelectImageCell.h
//  RealEstate
//
//  Created by Mindpace on 09/04/13.
//  Copyright (c) 2013 Mindpace. All rights reserved.
//


#import "BaseTableCell.h"

@interface LeftVCTableCell : BaseTableCell
//@property (retain, nonatomic) IBOutlet UIView *frntvw;

@property(nonatomic,strong) IBOutlet UILabel* detailslab1;
@property(nonatomic,strong) IBOutlet UIImageView *leftimav;
@property(nonatomic,strong) IBOutlet UIView *backGroundvw;
//@property(nonatomic,retain) IBOutlet UIButton* bt1;
@end
