//
//  MessageCell.h
//  Wall
//
//  Created by Mindpace on 30/01/14.
//
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *profilePicture;
@property (strong, nonatomic) IBOutlet UILabel *playerName;
+(id)messageCell;

@end
