//
//  BuySellCell.h
//  Wall
//
//  Created by Sukhamoy on 31/12/13.
//
//

#import <UIKit/UIKit.h>

@interface BuySellCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *priceLbl;
@property (retain, nonatomic) IBOutlet UILabel *itemNameLbl;
@property (retain, nonatomic) IBOutlet UIView *backView;
@property (retain, nonatomic) IBOutlet UIImageView *itemImageView;
+(id)buyCell;

@end
