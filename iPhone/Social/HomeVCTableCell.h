//
//  CellComment.h
//
//  Created by Piyali on 17/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableCell.h"

@interface HomeVCTableCell : BaseTableCell


@property(nonatomic,strong) IBOutlet UIActivityIndicatorView *acindviewuser;
@property(nonatomic,strong) IBOutlet UIActivityIndicatorView *acindviewposted;

@property(nonatomic,strong) IBOutlet UIImageView *userima;
@property(nonatomic,strong) IBOutlet UIImageView *posted;
@property(nonatomic,strong) IBOutlet UIActivityIndicatorView *acindviewsecondary;

@property(nonatomic,strong) IBOutlet UIImageView *userimasecondary;

@property(nonatomic,strong) IBOutlet UIImageView *videoplayimavw;
@property(nonatomic,strong) IBOutlet UIImageView *commentImage;
@property(nonatomic,strong) IBOutlet UIImageView *likeImage;
@property(nonatomic,strong) IBOutlet UIButton *commentbt;
@property(nonatomic,strong) IBOutlet UIButton *likebt;
@property(nonatomic,strong) IBOutlet UIButton *closebt;
@property(nonatomic,strong) IBOutlet UIButton *profileimabt;
@property(nonatomic,strong) IBOutlet UIButton *viewCommentsbt;
@property(nonatomic,strong) IBOutlet UIButton *viewLikesbt;
@property(nonatomic,strong) IBOutlet UILabel *likeslab;
@property(nonatomic,strong) IBOutlet UILabel  *cmntslab;
@property(nonatomic,strong) IBOutlet UILabel *likeorunlikelab;
//////////
@property(nonatomic,strong) IBOutlet UILabel *likecountlab;
@property(nonatomic,strong) IBOutlet UILabel  *cmnts;
@property(nonatomic,strong) IBOutlet UILabel *commentcountlab;
@property(nonatomic,strong) IBOutlet UILabel  *playerlab;
@property(nonatomic,strong) IBOutlet UILabel *playernamelab;
@property(nonatomic,strong) IBOutlet UILabel  *postedonlab;
@property(nonatomic,strong) IBOutlet UILabel *postedondatelab;
@property(nonatomic,strong) IBOutlet UIView *mainContainer;
@property(nonatomic,strong) IBOutlet UIView *subContainer;

@property(nonatomic,strong) IBOutlet UIImageView *likeslabima;
@property(nonatomic,strong) IBOutlet UIImageView *commentslabima;
@end
