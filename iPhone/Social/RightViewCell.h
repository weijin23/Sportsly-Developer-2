//
//  RightViewCell.h
//  Wall
//
//  Created by Sukhamoy on 30/12/13.
//
//

#import <UIKit/UIKit.h>

@interface RightViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dateLbl;
@property (strong, nonatomic) IBOutlet UIImageView *statusImageView;

@property (strong, nonatomic) IBOutlet UILabel *msgLbl;
@property (retain, nonatomic) IBOutlet UIImageView *profileImageView;
@property (retain, nonatomic) IBOutlet UILabel *nameLbl;
+(id)rightCell;

@end
