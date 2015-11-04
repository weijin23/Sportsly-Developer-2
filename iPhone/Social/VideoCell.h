//
//  VideoCell.h
//  Wall
//
//  Created by Sukhamoy on 11/12/13.
//
//

#import <UIKit/UIKit.h>

@interface VideoCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIView *backView;

@property (retain, nonatomic) IBOutlet UIImageView *videoThumImv;
@property (retain, nonatomic) IBOutlet UILabel *titleLbl;
+(id)customCell;

@end
