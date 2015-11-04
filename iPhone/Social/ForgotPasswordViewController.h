//
//  LoginPageViewController.h
//  Social
//
//  Created by Mindpace on 20/08/13.
//
//



@interface ForgotPasswordViewController : BaseVC<UIScrollViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    CGRect kb;
    CGRect af;
    CGSize svos;
    CGPoint point;
}

@property (strong, nonatomic) IBOutlet UIScrollView *loginScroll;

@property (strong, nonatomic) IBOutlet UIView *loginView;
@property (strong, nonatomic) IBOutlet UIView *userView;
@property (strong, nonatomic) IBOutlet UITextField *emailTxt;
@property (strong, nonatomic) IBOutlet UITextField *passwrdTxt;
@property (strong, nonatomic) IBOutlet UIButton *signIn;
@property (strong, nonatomic) IBOutlet UIButton *signUp;
@property (strong, nonatomic) IBOutlet UIButton *forgotPassword;

- (IBAction)signUpBtn:(id)sender;
- (IBAction)signInBtn:(id)sender;
- (IBAction)passwrdRcvrBtn:(id)sender;

@end
