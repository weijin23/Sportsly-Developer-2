//
//  LoginPageViewController.h
//  Social
//
//  Created by Mindpace on 20/08/13.
//
//



@interface LoginPageViewController : BaseVC<UIScrollViewDelegate,UITextFieldDelegate>
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
-(void)parseLikeAndComments:(NSArray*)arr;


- (IBAction)facebookLoginAction:(id)sender;
-(void)sessionStateOpen:(id)notiobject;
-(void)loginWithFacebook:(NSString*)emailstr :(NSString*)fstname :(NSString*)lastname :(NSString*)fid;


- (IBAction)backtof:(id)sender;


-(void)parseLastTenPrimary:(NSArray*)arrays;
-(void)parseLastTenPlayer:(NSArray*)arrays;

-(void)parseLastUpdateEvent:(NSArray*)arrays;
-(void)parseLastDeleteEvent:(NSArray*)arrays;

@end
