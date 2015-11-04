//
//  PlayerCell.h
//  Wall
//
//  Created by Sukhamoy on 25/11/13.
//
//

#import <UIKit/UIKit.h>

@interface PlayerCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *titleLbl;
@property (retain, nonatomic) IBOutlet UILabel *relationLbl;
@property (retain, nonatomic) IBOutlet UIImageView *iconImageView;
+(id)playerCell;
@property (retain, nonatomic) IBOutlet UIView *separetorView;

@end
