//
//  ChatMessageCell.h
//  Wall
//
//  Created by Mindpace on 18/01/14.
//
//

#import <UIKit/UIKit.h>

@interface ChatMessageCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet UILabel *messageLbl;
@property (strong, nonatomic) IBOutlet UILabel *dateLbl;
+(id)chatMessageCustomCell;
@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet UILabel *nameLbl;
@property (strong, nonatomic) IBOutlet UIImageView *statusImageView;

@end
