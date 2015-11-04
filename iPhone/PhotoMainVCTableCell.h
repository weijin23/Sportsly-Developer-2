//
//  PhotoMainVCTableCell.h
//  Social
//
//  Created by Sukhamoy Hazra on 26/09/13.
//
//

#import <UIKit/UIKit.h>
#import "BaseTableCell.h"
#import "PhotoMainVC.h"
@interface PhotoMainVCTableCell : BaseTableCell<UITextFieldDelegate>


@property (retain, nonatomic) IBOutlet UILabel *lbl1;
@property (retain, nonatomic) IBOutlet UILabel *lbl2;
@property (retain, nonatomic) IBOutlet UILabel *lbl3;
@property (retain, nonatomic) IBOutlet UIButton *crossBtn1;
@property (retain, nonatomic) IBOutlet UIButton *crossBtn2;
@property (retain, nonatomic) IBOutlet UIButton *crossBtn3;
@property (retain, nonatomic) IBOutlet UITextField *txt1;
@property (retain, nonatomic) IBOutlet UITextField *txt2;
@property (retain, nonatomic) IBOutlet UITextField *txt3;
@property (retain, nonatomic) IBOutlet UIImageView *playimage1;
@property (retain, nonatomic) IBOutlet UIImageView *playimage2;
@property (retain, nonatomic) IBOutlet UIImageView *playimage3;
@property (retain, nonatomic) IBOutlet UIImageView *playimage4;
@property (nonatomic,retain) PhotoMainVC *pmvc;




@property (retain, nonatomic) IBOutlet UIButton *btn1;
@property (retain, nonatomic) IBOutlet UIButton *btn2;
@property (retain, nonatomic) IBOutlet UIButton *btn3;
@property (retain, nonatomic) IBOutlet UIButton *btn4;
@property (retain, nonatomic) IBOutlet UIImageView *imgFrm1;
@property (retain, nonatomic) IBOutlet UIImageView *imgFrm2;
@property (retain, nonatomic) IBOutlet UIImageView *imgFrm3;
@property (retain, nonatomic) IBOutlet UIImageView *imgFrm4;
@property (retain, nonatomic) IBOutlet UIView *vw1;
@property (retain, nonatomic) IBOutlet UIView *vw2;
@property (retain, nonatomic) IBOutlet UIView *vw3;
@property (retain, nonatomic) IBOutlet UIView *vw4;
@property (retain, nonatomic) IBOutlet UIView *upvw1;
@property (retain, nonatomic) IBOutlet UIView *upvw2;
@property (retain, nonatomic) IBOutlet UIView *upvw3;
@property (retain, nonatomic) IBOutlet UIView *upvw4;
@property (retain, nonatomic) IBOutlet UIImageView *editBtn1;
@property (retain, nonatomic) IBOutlet UIImageView *editBtn2;
@property (retain, nonatomic) IBOutlet UIImageView *editBtn3;
@property (retain, nonatomic) IBOutlet UIImageView *editBtn4;


@end
