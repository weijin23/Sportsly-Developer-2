//
//  FeedBackViewController.m
//  Wall
//
//  Created by Sukhamoy on 02/01/14.
//
//
#import "CenterViewController.h"
#import "FeedBackViewController.h"

@interface FeedBackViewController ()

@end

@implementation FeedBackViewController
@synthesize testMsg,keyboardToolbar,keyboardToolbarView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(keyboardDidShow:)
     name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification
                                               object:nil];
    
    self.feedBacktextView.textColor=appDelegate.veryLightGrayColor;
    //svos=self.scrollView.contentSize;
   
    point=CGPointMake(0,0);
    af=[[UIScreen mainScreen] applicationFrame];
    
    self.emailTxt.text=[appDelegate.aDef objectForKey:EMAIL];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNavigationControllerUpdated:) name:SHOWNAVIGATIONCONTROLLERFEEDBACK object:nil];
    
    
    
    
    if(keyboardToolbar == nil && keyboardToolbarView==nil)
    {
        if (self.isiPad) {
            keyboardToolbarView=[[UIView alloc] initWithFrame:CGRectMake(0, 412, 768, 44)];
            
            if(appDelegate.isIos7)
                keyboardToolbarView.backgroundColor=[UIColor clearColor];
            else
                keyboardToolbarView.backgroundColor=[UIColor clearColor];
            keyboardToolbarView.alpha=0.8;
            
            keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,768,44)];
        }
        else{
            keyboardToolbarView=[[UIView alloc] initWithFrame:CGRectMake(0, 412, 320, 44)];
            
            if(appDelegate.isIos7)
                keyboardToolbarView.backgroundColor=[UIColor clearColor];
            else
                keyboardToolbarView.backgroundColor=[UIColor clearColor];
            keyboardToolbarView.alpha=0.8;
            
            keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
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
        [keyboardToolbar setItems:items];
        [keyboardToolbar setAlpha:1.0];
        
        
        [keyboardToolbarView addSubview:keyboardToolbar];
	}

 
}


-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SHOWNAVIGATIONCONTROLLERFEEDBACK object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
     
                                                    name:UIKeyboardDidHideNotification object:nil];
    
}

#pragma mark - NavigationControllerUpdate
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
        self.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"wallleftslide.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleLeftPanel:)];
    }
    
    if(!self.rightBarButtonItem)
    {
        self.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"new_message.png"] style:UIBarButtonItemStylePlain target:self action:@selector(messageToplayer:)];
    }
    
    self.appDelegate.centerViewController.navigationItem.title=@"Feedback";
    appDelegate.centerViewController.navigationItem.leftBarButtonItem=self.leftBarButtonItem;
    
    appDelegate.centerViewController.navigationItem.rightBarButtonItem=nil;
    
    
    [self setStatusBarStyleOwnApp:1];
    
}

-(void)toggleLeftPanel:(id)sender
{
    if([self.emailTxt isFirstResponder])
        [self.emailTxt resignFirstResponder];
    if([self.passwordTxt isFirstResponder])
        [self.passwordTxt resignFirstResponder];
    if([self.feedBacktextView isFirstResponder])
        [self.feedBacktextView resignFirstResponder];
    [appDelegate.slidePanelController showLeftPanelAnimated:YES];
    
}





#pragma mark - NavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SHOWNAVIGATIONCONTROLLERFEEDBACK object:nil];
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

-(void)firstTime
{
    self.feedBacktextView.text=@"Write comments here";
    self.feedBacktextView.textColor=self.appDelegate.veryLightGrayColor;
    
    self.emailTxt.text=[appDelegate.aDef objectForKey:EMAIL];
    self.passwordTxt.text=@"";
   
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)cancelAction:(id)sender {
    if([self.emailTxt isFirstResponder])
        [self.emailTxt resignFirstResponder];
    if([self.passwordTxt isFirstResponder])
        [self.passwordTxt resignFirstResponder];
    if([self.feedBacktextView isFirstResponder])
        [self.feedBacktextView resignFirstResponder];
    
    
    [self enableSlidingAndShowTopBar];
    
      [self.navigationController.view setHidden:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setFeedBacktextView:nil];
    [self setEmailTxt:nil];
    [self setPasswordTxt:nil];
    [super viewDidUnload];
}

- (IBAction)okAlertMessege:(id)sender {
    
    self.viewTranpernt.hidden=YES;
    self.viewAlert.hidden=YES;
    self.feedBacktextView.text=@"";
    [appDelegate.slidePanelController showLeftPanelAnimated:YES];
}

- (IBAction)sendAction:(id)sender
{
    
    ///////////////////////////
    
    if([self.emailTxt isFirstResponder])
        [self.emailTxt resignFirstResponder];
    if([self.feedBacktextView isFirstResponder])
        [self.feedBacktextView resignFirstResponder];
    NSString *errorstr=@"";
    NSString *tmp=[[self.emailTxt text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    
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
    
    
    
    tmp=[[self.feedBacktextView text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    
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
    [command setObject:self.emailTxt.text forKey:@"email"];
    [command setObject:self.feedBacktextView.text forKey:@"text"];
    
    NSString *str=[appDelegate.aDef objectForKey:FIRSTNAME];
    if (str.length>0) {
        if ([[appDelegate.aDef objectForKey:LASTNAME] length]>0) {
            
            str=[str stringByAppendingFormat:@" %@",[appDelegate.aDef objectForKey:LASTNAME]];
        }
    }
    else
        str=[appDelegate.aDef objectForKey:LASTNAME];
    [command setObject:str forKey:@"name"];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    
    NSURL* url = [NSURL URLWithString:FEEDBACKLINK];
    
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

-(void)notifyRequesterWithData:(id) aData :(id)aData1
{
    
    [self hideHudView];
    [self hideNativeHudView];
    
    if([aData isKindOfClass:[ConnectionManager class]])
    {
        ConnectionManager *aR=(ConnectionManager*)aData;
        if([aR.requestSingleId isEqualToString:FEEDBACK])
        {
            
        }
        
        return;
    }
    
    
    NSString *str=(NSString*)aData;
    
    NSLog(@"Data=%@",str);
    
    ConnectionManager *aR=(ConnectionManager*)aData1;
    if([aR.requestSingleId isEqualToString:FEEDBACK])
    {
        
        
        
        if (str)
        {
            SBJsonParser *parser=[[SBJsonParser alloc] init];
            
            id res = [parser objectWithString:str];
            if ([res isKindOfClass:[NSDictionary class]])
            {
                NSDictionary* aDict = (NSDictionary*) res;
                // aDict=[aDict objectForKey:@"responseData"];
                
                
                if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
                {
                    
                    
                    [self showHudAlert:[aDict objectForKey:@"message"]];
                    [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
                }
                
                
            }
        }
    }
}



/*- (IBAction)sendAction:(id)sender
{
    
    ///////////////////////////
    
    if([self.emailTxt isFirstResponder])
        [self.emailTxt resignFirstResponder];
    if([self.passwordTxt isFirstResponder])
        [self.passwordTxt resignFirstResponder];
    if([self.feedBacktextView isFirstResponder])
        [self.feedBacktextView resignFirstResponder];
    NSString *errorstr=@"";
   NSString *tmp=[[self.emailTxt text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    
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
    
    tmp=[[self.passwordTxt text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    int flag=0;
    
    if ([tmp  isEqualToString:@""] )
    {
        
        
        if(errorstr.length==0)
            errorstr=@"Please enter password.";
        
        
        flag++;
    }
   
    tmp=[[self.feedBacktextView text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
   
    
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
    
    
   ////////////////////////////
    
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    SKPSMTPMessage *testMsg1 = [[SKPSMTPMessage alloc] init];
    
    self.testMsg=testMsg1;
    
    testMsg1=nil;
    testMsg.fromEmail =self.emailTxt.text;
    
    testMsg.toEmail =FEEDBACKEMAIL;
   // testMsg.bccEmail = [defaults objectForKey:@"bccEmal"];
    
  NSString *relayHost=  [[NSString alloc] initWithFormat:@"smtp.%@", [[self.emailTxt.text componentsSeparatedByString:@"@"] objectAtIndex:1] ];
    
    testMsg.relayHost = relayHost;
    
    testMsg.requiresAuth = 1;//[[defaults objectForKey:@"requiresAuth"] boolValue];
    
   if (testMsg.requiresAuth) {
        testMsg.login = self.emailTxt.text;
        
        testMsg.pass =self.passwordTxt.text;
        
    }
    
    testMsg.wantsSecure =1; //[[defaults objectForKey:@"wantsSecure"] boolValue]; // smtp.gmail.com doesn't work without TLS!
    
    
    testMsg.subject = @"Feedback of Sportsly";
    //testMsg.bccEmail = @"testbcc@test.com";
    
    // Only do this for self-signed certs!
    // testMsg.validateSSLChain = NO;
    testMsg.delegate = self;
    
    NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey,
                               self.feedBacktextView.text,kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    
    */
 
   /* NSString *vcfPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"vcf"];
    NSData *vcfData = [NSData dataWithContentsOfFile:vcfPath];
    
    NSDictionary *vcfPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/directory;\r\n\tx-unix-mode=0644;\r\n\tname=\"test.vcf\"",kSKPSMTPPartContentTypeKey,
                             @"attachment;\r\n\tfilename=\"test.vcf\"",kSKPSMTPPartContentDispositionKey,[vcfData encodeBase64ForData],kSKPSMTPPartMessageKey,@"base64",kSKPSMTPPartContentTransferEncodingKey,nil];*/
    
   /* testMsg.parts = [NSArray arrayWithObjects:plainPart,nil];
    
    
   
    [self showHudView:@"Connecting..."];
    [self performSelector:@selector(sendEmail) withObject:nil afterDelay:2.0];
    
    
}*/


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
    
    
   
    
    [self.feedBacktextView resignFirstResponder];
    
    //self.scrollView.contentSize=svos;
   // self.scrollView.contentOffset=point;
    
}



- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([self.feedBacktextView.textColor isEqual:appDelegate.veryLightGrayColor])
    {
    self.feedBacktextView.text=@"";
    self.feedBacktextView.textColor=self.blackcolor;
    }
    
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    CGRect rect = keyboardToolbarView.frame;
    
    
    
    //rect.origin.y = 204;
    float ym=150;
    
  
    
    if(appDelegate.isIphone5)
        rect.origin.y = ym+88;
    else
        rect.origin.y = ym;
    if (self.isiPad) {
        rect.origin.y = ym+496;
    }
    
    
    keyboardToolbarView.frame = rect;
    
    //NSLog(@"Toolbar Frame=%f,%f,%f,%f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
    
    [self.view addSubview:keyboardToolbarView];
    [UIView commitAnimations];
    
    //[self moveScrollView:textView];
    
    
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self hideKeyTool];
    
    if([self.feedBacktextView.text isEqualToString:@""])
    {
        self.feedBacktextView.text=@"Write comments here";
        self.feedBacktextView.textColor=appDelegate.veryLightGrayColor;
    }
   // self.scrollView.contentOffset=point;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}



-(void)hideKeyTool
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    CGRect rect = keyboardToolbarView.frame;
    rect.origin.y = 372;
    keyboardToolbarView.frame = rect;
    [keyboardToolbarView removeFromSuperview];
    [UIView commitAnimations];
}


-(void)sendEmail
{
    
   // [testMsg send];
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    [command setObject:self.emailTxt.text forKey:@"email"];
    [command setObject:self.feedBacktextView.text forKey:@"text"];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    
    NSURL* url = [NSURL URLWithString:CHATURLLINK];
    
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

- (void)messageSent:(SKPSMTPMessage *)message
{
     [self hideHudView];
   // [message release];
   // self.textView.text  = @"Yay! Message was sent.";
    //NSLog(@"delegate - message sent");
    [self showHudAlert:@"Email Sent."];
    
    [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:0.0];
   
   
}
-(void)hideHudViewHere
{
    [self hideHudView];
    [self showAlertMessage:@"Feedback mail successfully send"] ;
    //[self firstTime];
}
- (void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error
{
     [self hideHudView];
    //self.textView.text = [NSString stringWithFormat:@"Darn! Error: %@, %@", [error code], [error localizedDescription]];
    //self.textView.text = [NSString stringWithFormat:@"Darn! Error!\n%i: %@\n%@", [error code], [error localizedDescription], [error localizedRecoverySuggestion]];
   // [message release];
    
    //NSLog(@"delegate - error(%d): %@", [error code], [error localizedDescription]);
     [self showAlertMessage:@"Email sending failed."];
}



@end
