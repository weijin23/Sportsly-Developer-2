//
//  PlayerListCell.h
//  Social
//
//  Created by Animesh@Mindpace on 10/09/13.
//
//

#import <UIKit/UIKit.h>
#import "SaveTeamViewController.h"

@interface PlayerListCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *title;
@property (retain, nonatomic) IBOutlet UIButton *delBtn;
@property (retain, nonatomic) IBOutlet UIButton *editBtn;
@property (retain, nonatomic) IBOutlet UITextField *addMinNameText;
@property (retain, nonatomic) IBOutlet UITextField *addMinEmailText;
@property (retain, nonatomic) IBOutlet UITextField *addMinPhoneText;
@property (retain, nonatomic) IBOutlet UIView *rowSeparator;
@property (retain, nonatomic) IBOutlet UIButton *addressBookBtn;
@property (retain, nonatomic) IBOutlet UITextField *lastName;

+(id)customCell;




@end
