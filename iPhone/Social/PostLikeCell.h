//
//  PostLikeCell.h
//  Wall
//
//  Created by Sukhamoy on 26/12/13.
//
//

#import <UIKit/UIKit.h>

@interface PostLikeCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet UIImageView *proileImageView;
@property (strong, nonatomic) IBOutlet UILabel *playername;
@property (strong, nonatomic) IBOutlet UILabel *time;
+(id)customCell;

@end
