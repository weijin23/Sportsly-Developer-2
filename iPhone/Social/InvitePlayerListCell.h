//
//  InvitePlayerListCell.h
//  Wall
//
//  Created by Sukhamoy on 21/11/13.
//
//

#import <UIKit/UIKit.h>

@interface InvitePlayerListCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *editBtn;
@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageVw;
@property (strong, nonatomic) IBOutlet UILabel *playerNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *playerStatusLbl;
@property (strong, nonatomic) IBOutlet UIButton *callBtn;
@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet UIImageView *imgVwBig;
@property (strong, nonatomic) IBOutlet UIImageView *imgVwSmall;
@property (strong, nonatomic) IBOutlet UILabel *lblNumber;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) IBOutlet UILabel *lblAdminType;

+(id)inviteCell;

@end
