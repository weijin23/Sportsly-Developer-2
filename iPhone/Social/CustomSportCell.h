//
//  CustomSportCell.h
//  Wall
//
//  Created by Mindpace on 20/05/14.
//
//

#import <UIKit/UIKit.h>

@interface CustomSportCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *sportImage;
@property (strong, nonatomic) IBOutlet UILabel *sportLbl;
+(id)customCell;

@end
