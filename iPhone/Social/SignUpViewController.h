//
//  SignUpViewController.h
//  Social
//
//  Created by Mindpace on 21/08/13.
//
//



@interface SignUpViewController : BaseVC<UIScrollViewDelegate,UITextFieldDelegate>
{
    CGRect kb;
    CGRect af;
    CGSize svos;
    CGPoint point;
}

@property (strong, nonatomic) IBOutlet UIImageView *avatarimavw;

@property (strong, nonatomic) IBOutlet UIView *signUpView;
@property (strong, nonatomic) IBOutlet UIScrollView *signUpScroll;

@property (strong, nonatomic) IBOutlet UIView *userView;
@property (strong, nonatomic) IBOutlet UITextField *emailTxt;
@property (strong, nonatomic) IBOutlet UITextField *passwrdTxt;

@property (strong, nonatomic) IBOutlet UITextField *firstName;

@property (strong, nonatomic) IBOutlet UITextField *lastName;

- (IBAction)signInAction:(id)sender;


@property (strong, nonatomic) IBOutlet UIView *avatarView;
@property (strong, nonatomic) IBOutlet UIButton *srchPhoto;
@property (strong, nonatomic) IBOutlet UIButton *signUp;
@property (nonatomic,assign) BOOL isSelectedImage;
- (IBAction)signUpBtn:(id)sender;
- (IBAction)uploadPhoto:(id)sender;
- (IBAction)crosstapped:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *crossbT;
@property (strong, nonatomic) IBOutlet UITextField *retypePassword;
-(void)requestForTableViewFooterLoading:(int)index;


-(void)hideHudViewHereLoginFinish;

@property (strong, nonatomic) IBOutlet UIView *popupAlertVw;
@property (strong, nonatomic) IBOutlet UIView *popupBackVw;
@property (strong, nonatomic) IBOutlet UILabel *popupAlertLbl;
- (IBAction)popupAlertTapped:(id)sender;




@end
