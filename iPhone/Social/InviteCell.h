//
//  InviteCell.h
//  Wall
//
//  Created by Sukhamoy on 10/04/14.
//
//

#import <UIKit/UIKit.h>

@interface InviteCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *profileImageVw;
@property (strong, nonatomic) IBOutlet UILabel *playerNameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *statusImageVw;
@property (weak, nonatomic) IBOutlet UILabel *statuslbl;
@property (strong, nonatomic) IBOutlet UILabel *statusLbl2;

+(id)inviteCell;

@end
