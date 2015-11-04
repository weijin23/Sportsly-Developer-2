//
//  CellComment.h
//
//  Created by Piyali on 17/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableCell.h"

@interface RightVCTableCell : BaseTableCell


@property (retain, nonatomic) IBOutlet UIImageView *sportImage1;
@property (retain, nonatomic) IBOutlet UIImageView *sportImage2;

@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *acindviewuser;


@property(nonatomic,retain) IBOutlet UIImageView *userima;


@property (retain, nonatomic) IBOutlet UIView *separetorView;

//////////
@property(nonatomic,retain) IBOutlet UILabel *userName;
@property(nonatomic,retain) IBOutlet UILabel  *cmnts;
@property(nonatomic,retain) IBOutlet UIImageView *imastatus_firstvw;
@property(nonatomic,retain) IBOutlet UIImageView *imastatus_secondvw;
@property (retain, nonatomic) IBOutlet UIButton *chatButton;
@property (retain, nonatomic) IBOutlet UIView *backView;
@property (retain, nonatomic) IBOutlet UIButton *mailButton;
@property (retain, nonatomic) IBOutlet UIButton *phoneButton;
@property (strong, nonatomic) IBOutlet UIImageView *chatImage;

@end
