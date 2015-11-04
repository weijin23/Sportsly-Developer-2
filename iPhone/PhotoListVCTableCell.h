//
//  PhotoMainVCTableCell.h
//  Social
//
//  Created by Sukhamoy Hazra on 26/09/13.
//
//

#import <UIKit/UIKit.h>
#import "BaseTableCell.h"
@interface PhotoListVCTableCell : BaseTableCell

@property (retain, nonatomic) IBOutlet UIButton *btn1;
@property (retain, nonatomic) IBOutlet UIButton *btn2;
@property (retain, nonatomic) IBOutlet UIButton *btn3;
@property (retain, nonatomic) IBOutlet UIButton *btn4;

@property (retain, nonatomic) IBOutlet UIButton *crossBtn1;
@property (retain, nonatomic) IBOutlet UIButton *crossBtn2;
@property (retain, nonatomic) IBOutlet UIButton *crossBtn3;
@property (retain, nonatomic) IBOutlet UIButton *crossBtn4;

@property (retain, nonatomic) IBOutlet UIView *vw1;
@property (retain, nonatomic) IBOutlet UIView *vw2;
@property (retain, nonatomic) IBOutlet UIView *vw3;
@property (retain, nonatomic) IBOutlet UIView *vw4;


@property (retain, nonatomic) IBOutlet UIImageView *playimage1;
@property (retain, nonatomic) IBOutlet UIImageView *playimage2;
@property (retain, nonatomic) IBOutlet UIImageView *playimage3;
@property (retain, nonatomic) IBOutlet UIImageView *playimage4;


- (IBAction)longPressAction:(id)sender;
- (IBAction)longPressAction1:(id)sender;
- (IBAction)longPressAction2:(id)sender;
- (IBAction)longPressAction3:(id)sender;

@end
