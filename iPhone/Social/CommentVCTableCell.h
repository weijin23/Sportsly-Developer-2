//
//  CommentVCTableCell.h
//  Wall
//
//  Created by Sukhamoy Hazra on 13/09/13.
//
//

#import <UIKit/UIKit.h>
#import "BaseTableCell.h"

@interface CommentVCTableCell : BaseTableCell

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *acindviewuser;
@property (strong, nonatomic) IBOutlet UIImageView *userimg;
@property (strong, nonatomic) IBOutlet UILabel *postedByLbl;
@property (strong, nonatomic) IBOutlet UILabel *postedOnLbl;
@property (strong, nonatomic) IBOutlet UILabel *commntsLbl;
@property (strong, nonatomic) IBOutlet UIButton *userprofimabt;
@property (strong, nonatomic) IBOutlet UIView *separator;
@end
