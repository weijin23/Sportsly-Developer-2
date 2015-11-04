//
//  ChatCell.h
//  Wall
//
//  Created by Mindpace on 17/01/14.
//
//

#import <UIKit/UIKit.h>

@interface ChatCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *messageLbl;
@property (strong, nonatomic) IBOutlet UIView *backGrounDview;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImage;
+(id)chatCustomCell;

@end
