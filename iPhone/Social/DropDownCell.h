//
//  DropDownCell.h
//  Wall
//
//  Created by Sukhamoy on 18/12/13.
//
//

#import <UIKit/UIKit.h>

@interface DropDownCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *title;
@property (retain, nonatomic) IBOutlet UIButton *delBtn;
@property (retain, nonatomic) IBOutlet UIButton *editBtn;
@property (retain, nonatomic) IBOutlet UITextField *addMinNameText;
@property (retain, nonatomic) IBOutlet UITextField *addMinEmailText;
@property (retain, nonatomic) IBOutlet UITextField *addMinPhoneText;
@property (retain, nonatomic) IBOutlet UIView *rowSeparator;
@property (retain, nonatomic) IBOutlet UIButton *addressBookBtn;


+(id)customCell;

@end
