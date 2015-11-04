//
//  GroupChatCell.h
//  Wall
//
//  Created by Sukhamoy on 26/05/14.
//
//

#import <UIKit/UIKit.h>

@interface GroupChatCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *userSlectedBtn;

@property (strong, nonatomic) IBOutlet UIImageView *profilePicture;
@property (strong, nonatomic) IBOutlet UILabel *playerName;
+(id)messageCell;

@end
