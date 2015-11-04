//
//  LoginPageViewController.m
//  Social
//
//  Created by Mindpace on 20/08/13.
//
//
#import "HomeVC.h"
#import "SignUpViewController.h"
#import "ForgotPasswordViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Invite.h"
@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController
@synthesize userView,emailTxt,passwrdTxt,signIn,signUp,forgotPassword;
@synthesize loginScroll,loginView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    @autoreleasepool {
        
    
    if(appDelegate.isIphone5)
        self.topimav.image=[UIImage imageNamed:@"bg-login_640_1136lat.png"];
    }

//    [self.loginScroll addSubview:self.loginView];
//    loginScroll.contentSize=self.loginView.frame.size;
    
    [self.userView.layer setCornerRadius:3.0f];
    [self.userView.layer setMasksToBounds:YES];
    
   /* CGRect frEmail=self.emailTxt.frame;
    frEmail.size.height=40;
    self.emailTxt.frame=frEmail;
    
    CGRect frPass=self.passwrdTxt.frame;
    frPass.size.height=40;
    self.passwrdTxt.frame=frPass;*/
    
    //self.loginScroll. contentSize=CGSizeMake(320,560);
    svos= self.loginScroll.contentSize;
    point=CGPointMake(0,0);
    af=[[UIScreen mainScreen] applicationFrame];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.emailTxt becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
    [self.emailTxt resignFirstResponder];
}
-(void)resetVC
{
    self.emailTxt.text=@"";
    self.passwrdTxt.text=@"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidUnload
{
     [super viewDidUnload];
    [self setUserView:nil];

    [self setEmailTxt:nil];
    [self setPasswrdTxt:nil];
    
    [self setSignIn:nil];
    [self setForgotPassword:nil];
    [self setSignUp:nil];
    
    [self setLoginView:nil];
    [self setLoginScroll:nil];
    
   
}

-(void)moveScrollView:(UIView *)theView
{
    CGFloat vcy=theView.superview.center.y;
    
    CGFloat fsh=af.size.height;
    CGFloat sa=0.0;
    if(isiPhone5)
        sa=vcy-fsh/2.7;
    else
        sa=vcy-fsh/3.6;
    
    if(sa<0)
        sa=0;
    
    self.loginScroll.contentSize=CGSizeMake(af.size.width,af.size.height+kb.size.height);
    NSLog(@"%f-%f-%f,%f",self.loginScroll.contentSize.height,af.size.height,kb.size.height,sa);
    [ self.loginScroll setContentOffset:CGPointMake(0,sa) animated:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self moveScrollView:textField];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    self.loginScroll.contentSize=svos;
    self.loginScroll.contentOffset=point;
    
    return YES;
}

- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (IBAction)signUpBtn:(id)sender
{
   
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)signInBtn:(id)sender
{
    if([self.emailTxt isFirstResponder])
        [self.emailTxt resignFirstResponder];
    self.loginScroll.contentSize=svos;
    self.loginScroll.contentOffset=point;
    
    NSString* tmp=nil;
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    
    
    NSString *errorstr=@"";
     NSString *errorstrtitle=@"";
    tmp=[[self.emailTxt text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    
    if (![tmp isEqualToString:@""])
    {
        if(![self validEmail:tmp])
        {
              if(errorstr.length==0)
            errorstr =@"Please enter the email you used when you signed up";
            
            
            if(errorstrtitle.length==0)
                errorstrtitle =@"Incorrect Email";
        }
        
    }
    else
    {
          if(errorstr.length==0)
        errorstr=@"Please enter email";
        
    }
    
    [command setObject:tmp forKey:@"Email"];
    
    
    
    
    if([errorstr length]>INITIALERRORSTRINGLENGTH)
    {
        
       
         if(errorstrtitle.length==0)
        [self showAlertMessage:errorstr title:@""];
        else
             [self showAlertMessage:errorstr title:errorstrtitle];
        return;
    }
    
    
  
    
    
    self.requestDic=command;
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    
        [appDelegate sendRequestFor:FORGOTPASSWORD from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
}

-(void)notifyRequesterWithData:(id) aData :(id)aData1
{
    
    [self hideHudView];
    [self hideNativeHudView];
    
    if([aData isKindOfClass:[ConnectionManager class]])
    {
        ConnectionManager *aR=(ConnectionManager*)aData;
        if([aR.requestSingleId isEqualToString:FORGOTPASSWORD])
        {
            
        }
        return;
    }
    
    
    NSString *str=(NSString*)aData;
    
    NSLog(@"Data=%@",str);
    
    
   
        
        if (str)
        {
            SBJsonParser *parser=[[SBJsonParser alloc] init];
            id res = [parser objectWithString:str];
            if ([res isKindOfClass:[NSDictionary class]])
            {
                NSDictionary* aDict = (NSDictionary*) res;
               // aDict=[aDict objectForKey:@"responseData"];
                NSString *message=[aDict objectForKey:@"message"];
                
                if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
                {
                     
                    
                   
                    
                    
                    UIAlertView *al=[[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
                    [al show];
//                    [self showHudAlert:message];
//                    [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
                   
                    self.requestDic=nil;
                }
                else if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"2"])
                {
                    
                    [self showAlertMessage:@"Your account is not yet activate.Please check your email and activate your account or contact Sportsly admin." title:PRODUCT_NAME];
                }
                else
                {
                    if([[aDict objectForKey:@"message"] isEqualToString:@"Email-Id you entered is incorrect."])
                    [self showAlertMessage:@"Email does not exist" title:PRODUCT_NAME];
                }
            }
        }
        
    
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
      [self.navigationController popViewControllerAnimated:YES];
}

-(void)hideHudViewHere
{
    [self hideHudView];
    [self.navigationController popViewControllerAnimated:YES];
}



- (IBAction)passwrdRcvrBtn:(id)sender
{
    
}

@end
