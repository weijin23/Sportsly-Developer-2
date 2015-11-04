//
//  ReciverCell.h
//  Wall
//
//  Created by Sukhamoy on 10/04/14.
//
//

#import <UIKit/UIKit.h>

@interface ReciverCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImageVw;
@property (weak, nonatomic) IBOutlet UIImageView *revArrowImage;
@property (weak, nonatomic) IBOutlet UIView *recvrbgVw;
@property (weak, nonatomic) IBOutlet UILabel *recvMsgLbl;
@property (strong, nonatomic) IBOutlet UILabel *recvDateLbl;
@property (strong, nonatomic) IBOutlet UILabel *nameLbl;

+(id)ReciverCustomCell;

@end
