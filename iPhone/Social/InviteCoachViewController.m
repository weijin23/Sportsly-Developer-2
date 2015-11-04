//
//  InviteCoachViewController.m
//  Wall
//
//  Created by User on 16/02/15.
//
//

#import "CenterViewController.h"
#import "InviteCoachViewController.h"

@interface InviteCoachViewController ()

@end

@implementation InviteCoachViewController
@synthesize strName;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //self.txtViewComment.textColor=appDelegate.veryLightGrayColor;
    if (self.isiPad)
        self.scrollCoach.contentSize=CGSizeMake(self.scrollCoach.frame.size.width,890);
    else
        self.scrollCoach.contentSize=CGSizeMake(self.scrollCoach.frame.size.width, 800);
    
    self.strName=[appDelegate.aDef objectForKey:FIRSTNAME];
    if ([[appDelegate.aDef objectForKey:LASTNAME] length]>0) {
        if ([self.strName length]>0)
            self.strName=[self.strName stringByAppendingFormat:@" %@",[appDelegate.aDef objectForKey:LASTNAME]];
        else
            self.strName=[appDelegate.aDef objectForKey:LASTNAME];
    }
    
    self.txtViewComment.text=[NSString stringWithFormat:@"Thanks,\n%@\n",self.strName];
    //svos=self.scrollView.contentSize;
    
    point=CGPointMake(0,0);
    af=[[UIScreen mainScreen] applicationFrame];
    
    self.txtYourEmail.text=[appDelegate.aDef objectForKey:EMAIL];
    self.txtCoachEmail.text=@"";
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(keyboardDidShow:)
     name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification
                                               object:nil];
    
    if(self.keyboardToolbar == nil && self.keyboardToolbarView==nil)
    {
        if (self.isiPad) {
            self.keyboardToolbarView=[[UIView alloc] initWithFrame:CGRectMake(0, 412, 768, 44)];
            
            if(appDelegate.isIos7)
                self.keyboardToolbarView.backgroundColor=[UIColor clearColor];
            else
                self.keyboardToolbarView.backgroundColor=[UIColor clearColor];
            self.keyboardToolbarView.alpha=0.8;
            
            self.keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,768,44)];
        }
        else{
            self.keyboardToolbarView=[[UIView alloc] initWithFrame:CGRectMake(0, 412, 320, 44)];
            
            if(appDelegate.isIos7)
                self.keyboardToolbarView.backgroundColor=[UIColor clearColor];
            else
                self.keyboardToolbarView.backgroundColor=[UIColor clearColor];
            self.keyboardToolbarView.alpha=0.8;
            
            self.keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
        }
        
        //        if(!appDelegate.isIos7)
        //keyboardToolbar.barStyle = UIBarStyleBlackOpaque;
        
        
        
        // UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(dissmissCanKeyboard:)];
        // cancel.tag=0;
        
        UIBarButtonItem *fspace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        
        UIBarButtonItem *done =[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(dissmissCanKeyboard:)];
        done.tintColor=[UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0];
        done.tag=1;
        
        NSArray *items = [[NSArray alloc] initWithObjects:/*cancel,*/fspace ,done, nil];
        [self.keyboardToolbar setItems:items];
        [self.keyboardToolbar setAlpha:1.0];
        
        
        [self.keyboardToolbarView addSubview:self.keyboardToolbar];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*#pragma mark - NavigationControllerUpdate
-(void)showNavigationControllerUpdated:(id)sender
{
    
    
    if(self.navigationController.view.hidden==NO)
    {
        if([[self.navigationController.viewControllers lastObject] isMemberOfClass:[self class]])
        {
            [self showNavigationBarButtons];
            
            
        }
        else
        {
            [[self.navigationController.viewControllers lastObject] showNavigationBarButtons];
        }
    }
    
    
}


-(void)showNavigationBarButtons
{
    
    if(!self.leftBarButtonItem)
    {
        //self.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"wallleftslide.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleLeftPanel:)];
    }
    
    if(!self.rightBarButtonItem)
    {
        self.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"new_message.png"] style:UIBarButtonItemStylePlain target:self action:@selector(cancelCoachInvite:)];
    }
    
    self.appDelegate.centerViewController.navigationItem.title=@"Invite Your Coach";
    appDelegate.centerViewController.navigationItem.rightBarButtonItem=self.leftBarButtonItem;
    
    appDelegate.centerViewController.navigationItem.leftBarButtonItem=nil;
    
    
    [self setStatusBarStyleOwnApp:1];
    
}

-(void)toggleLeftPanel:(id)sender
{
    if([self.txtYourEmail isFirstResponder])
        [self.txtYourEmail resignFirstResponder];
    if([self.txtCoachEmail isFirstResponder])
        [self.txtCoachEmail resignFirstResponder];
    if([self.txtViewComment isFirstResponder])
        [self.txtViewComment resignFirstResponder];
    [appDelegate.slidePanelController showLeftPanelAnimated:YES];
    
}





#pragma mark - NavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SHOWNAVIGATIONCONTROLLERFEEDBACK object:nil];
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}*/

-(void)firstTime
{
    self.txtViewComment.text=@"Write comments here";
    self.txtViewComment.textColor=self.appDelegate.veryLightGrayColor;
    
    self.txtYourEmail.text=[appDelegate.aDef objectForKey:EMAIL];
    self.txtCoachEmail.text=@"";
    
}

- (IBAction)sendYourCoachInvite:(id)sender {
    
    ///////////////////////////
    
    if([self.txtYourEmail isFirstResponder])
        [self.txtYourEmail resignFirstResponder];
    if([self.txtCoachEmail isFirstResponder])
        [self.txtCoachEmail resignFirstResponder];
    if([self.txtViewComment isFirstResponder])
        [self.txtViewComment resignFirstResponder];
    NSString *errorstr=@"";
    NSString *tmp=[[self.txtYourEmail text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (![tmp isEqualToString:@""])
    {
        if(![self validEmail:tmp])
        {
            if(errorstr.length==0)
                errorstr =@"The email id is invalid.";
            
        }
        
    }
    else
    {
        if(errorstr.length==0)
            errorstr=@"Please enter email id.";
        
    }
    
    
    tmp=[[self.txtCoachEmail text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSArray *arr=[tmp componentsSeparatedByString:@","];
    for (int i=0; i<arr.count; i++) {
        
        NSString *tmpEmail=[arr objectAtIndex:i];
        if (![tmpEmail isEqualToString:@""])
        {
            if(![self validEmail:tmpEmail])
            {
                if(errorstr.length==0)
                    errorstr =@"The email id is invalid.";
                
            }
            
        }
        else
        {
            if(errorstr.length==0)
                errorstr=@"Please enter email id.";
            
        }
    }
    
   /* if (![tmp isEqualToString:@""])
    {
        if(![self validEmail:tmp])
        {
            if(errorstr.length==0)
                errorstr =@"The email id is invalid.";
            
        }
        
    }
    else
    {
        if(errorstr.length==0)
            errorstr=@"Please enter email id.";
        
    }*/
    
    
    
    tmp=[[self.txtViewComment text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    
    if ([tmp  isEqualToString:@""] )
    {
        
        
        if(errorstr.length==0)
            errorstr=@"Please enter feedback.";
        
        
        
    }
    
    
    
    if([errorstr length]>INITIALERRORSTRINGLENGTH)
    {
        
        [self showAlertMessage:errorstr title:@""];
        return;
    }
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    
    [command setObject:arr forKey:@"to"];
    //[command setObject:self.txtCoachEmail.text forKey:@"to"];
    [command setObject:self.txtYourEmail.text forKey:@"from"];
    [command setObject:self.txtViewComment.text forKey:@"text"];
    [command setObject:self.strName forKey:@"name"];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    
    NSURL* url = [NSURL URLWithString:INVITEMAILLINK];
    
    ASIFormDataRequest *aRequest=  [[ASIFormDataRequest alloc] initWithURL:url] ;
    self.myFormRequest1=aRequest;
    [self.storeCreatedRequests addObject:self.myFormRequest1];
    
    
    [aRequest setShouldContinueWhenAppEntersBackground:YES];
    
    [aRequest setDelegate:self];
    
    [aRequest setValidatesSecureCertificate:NO];
    [ASIFormDataRequest setShouldThrottleBandwidthForWWAN:YES];
    [aRequest addPostValue:jsonCommand forKey:@"requestParam"];
    
    [aRequest setDidFinishSelector:@selector(requestFinished:)];
    [aRequest setDidFailSelector:@selector(requestFailed:)];
    [aRequest startAsynchronous];
    
    /* [self showHudView:@"Connecting..."];
     [self showNativeHudView];
     NSLog(@"RequestParamJSON=%@",jsonCommand);
     
     
     [appDelegate sendRequestFor:FEEDBACK from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
     
     
     //[self showHudView:@"Connecting..."];
     //[self performSelector:@selector(sendEmail) withObject:nil afterDelay:2.0];
     */
    
}

- (IBAction)cancelCoachInvite:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"Data Received in Connection Manager.... %@ ",[request responseString]);
    [self hideNativeHudView];
    [self hideHudView];
    
    NSString *str=[request responseString];
    NSLog(@"Data=%@",str);
    
    self.viewTranpernt.hidden=NO;
    self.viewAlert.hidden=NO;
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    
    [self hideNativeHudView];
    [self hideHudView];
    //[self showAlertMessage:CONNFAILMSG];ChAfter
    
}
-(void) keyboardDidShow:(NSNotification *) notification
{
    
    NSDictionary* info = [notification userInfo];
    
    NSValue *aValue =
    [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    [aValue getValue:&kb];
    
}

-(void) keyboardDidHide:(NSNotification *) notification
{
    
}

-(void)dissmissCanKeyboard:(id)sender
{
    //int tag=[sender tag];
    
    
    
    
    [self.txtViewComment resignFirstResponder];
    
    //self.scrollView.contentSize=svos;
    // self.scrollView.contentOffset=point;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([self.txtViewComment.textColor isEqual:appDelegate.veryLightGrayColor])
    {
        self.txtViewComment.text=@"";
        self.txtViewComment.textColor=self.blackcolor;
    }
    
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    CGRect rect = self.keyboardToolbarView.frame;
    
    
    
    //rect.origin.y = 204;
    float ym=210;
    
    
    
    if(appDelegate.isIphone5)
        rect.origin.y = ym+88;
    else
        rect.origin.y = ym;
    if (self.isiPad) {
        rect.origin.y = ym+496;
    }
    
    
    self.keyboardToolbarView.frame = rect;
    
    //NSLog(@"Toolbar Frame=%f,%f,%f,%f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
    
    [self.view addSubview:self.keyboardToolbarView];
    [UIView commitAnimations];
    
    //[self moveScrollView:textView];
    
    
    
}
/*- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self hideKeyTool];
    
    if([self.txtViewComment.text isEqualToString:@""])
    {
        self.txtViewComment.text=@"Write comments here";
        self.txtViewComment.textColor=appDelegate.veryLightGrayColor;
    }
    // self.scrollView.contentOffset=point;
}*/

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}


-(void)hideKeyTool
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    CGRect rect = self.keyboardToolbarView.frame;
    rect.origin.y = 372;
    self.keyboardToolbarView.frame = rect;
    [self.keyboardToolbarView removeFromSuperview];
    [UIView commitAnimations];
}
@end
