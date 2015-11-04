//
//  SettingsViewController.m
//  Social
//
//  Created by Mindpace on 09/09/13.
//
//
#import "CenterViewController.h"
#import "HomeVC.h"
#import "SettingsViewController.h"
#import "LeftViewController.h"
#import "UIImage+FixRotation.h"
#import "HFImageEditorViewController.h"



@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize settingsScroll,settingsFirstView,settingsSecondView,settingsThirdView,settingsForthView;
@synthesize fnameTxt,lnameTxt,emailTxt,phoneTxt;
@synthesize pEmail1Txt,pEmail2Txt;
@synthesize sEmail1Txt,sEmail2Txt,sEmail3Txt,sEmail4Txt,sEmail5Txt,sEmail6Txt;
@synthesize oldPswdTxt,nwPswdTxt,reNwPswdTxt;
@synthesize activeField,isSelectedImage,isSelectedChPass;

@synthesize eventEmailNotifaction,eventPushNotifaction;
@synthesize teamEmailNotifaction,teamPushNotifaction;
@synthesize friendEmailNotification,friendPushNotification;
@synthesize messageEmailNotifaction,messagePushNotifaction;


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
    
    @autoreleasepool {
        
    
        self.backgroundColorGrey=[UIColor colorWithPatternImage:[UIImage imageNamed:@"faq_header_bg.png"] ];
    }
    self.view.backgroundColor=self.backgroundColorGrey;
    
    if (self.isiPad) {
        self.settingsScroll.contentSize=CGSizeMake(320,1320);
    }
    else{
        self.settingsScroll.contentSize=CGSizeMake(320,700);
    }
    svos= self.settingsScroll.contentSize;
    af=[[UIScreen mainScreen] applicationFrame];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNavigationControllerUpdated:) name:SHOWNAVIGATIONCONTROLLERSETTINGS object:nil];
    
}
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SHOWNAVIGATIONCONTROLLERSETTINGS object:nil];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if([appDelegate.aDef objectForKey:ISLOGINWITHFACEBOOK])
    {
        self.chPassView.hidden=NO;
        self.passContView.hidden=YES;
        
        self.settingsScroll.contentSize=self.settingsScroll.frame.size;
    }
    //Subhasish..23th March

    //associate Done button with phoneTxt
    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                  style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(doneClicked)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    self.phoneTxt.inputAccessoryView = keyboardDoneButtonView;
    
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
        self.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveSettings:)];
    }
    
    self.appDelegate.centerViewController.navigationItem.title=@"Settings";
    appDelegate.centerViewController.navigationItem.leftBarButtonItem=self.leftBarButtonItem;
    
    appDelegate.centerViewController.navigationItem.rightBarButtonItem=self.rightBarButtonItem;
    
    
    [self setStatusBarStyleOwnApp:1];
    
}

-(void)toggleLeftPanel:(id)sender
{
    [self.view endEditing:YES];
    [appDelegate.slidePanelController showLeftPanelAnimated:YES];
    
}


#pragma mark - NavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SHOWNAVIGATIONCONTROLLERSETTINGS object:nil];
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

#pragma mark - Populateddata

-(void)populateData
{
    
    if([appDelegate.aDef objectForKey:FIRSTNAME])
        self.fnameTxt.text=[appDelegate.aDef objectForKey:FIRSTNAME];
    else
        self.fnameTxt.text=@"";
    
    if([appDelegate.aDef objectForKey:LASTNAME])
        self.lnameTxt.text=[appDelegate.aDef objectForKey:LASTNAME];
    else
        self.lnameTxt.text=@"";

    
    if([appDelegate.aDef objectForKey:EMAIL])
        self.emailTxt.text=[appDelegate.aDef objectForKey:EMAIL];
    else
        self.emailTxt.text=@"";
    
    //Subhasish..23th March
    if([appDelegate.aDef objectForKey:CONTACTNO] && [[appDelegate.aDef objectForKey:CONTACTNO] integerValue]!=0)
        self.phoneTxt.text=[appDelegate.aDef objectForKey:CONTACTNO];
    else
        self.phoneTxt.text=@"";
    
    if([appDelegate.aDef objectForKey:PRIMARYEMAIL1])
        self.pEmail1Txt.text=[appDelegate.aDef objectForKey:PRIMARYEMAIL1];
    else
        self.pEmail1Txt.text=@"";
    
    
    if([appDelegate.aDef objectForKey:PRIMARYEMAIL2])
        self.pEmail2Txt.text= [appDelegate.aDef objectForKey:PRIMARYEMAIL2];
    else
        self.pEmail2Txt.text=@"";
    
    if([appDelegate.aDef objectForKey:SECONDARYEMAIL1])
        self.sEmail1Txt.text  =[appDelegate.aDef objectForKey:SECONDARYEMAIL1];
    else
        self.sEmail1Txt.text=@"";
    
    
    if([appDelegate.aDef objectForKey:SECONDARYEMAIL2])
        self.sEmail2Txt.text =[appDelegate.aDef objectForKey:SECONDARYEMAIL2];
    else
        self.sEmail2Txt.text=@"";
    
    
    if([appDelegate.aDef objectForKey:SECONDARYEMAIL3])
        self.sEmail3Txt.text =[appDelegate.aDef objectForKey:SECONDARYEMAIL3];
    else
        self.sEmail3Txt.text=@"";
    
    
    if([appDelegate.aDef objectForKey:SECONDARYEMAIL4])
        self.sEmail4Txt.text =[appDelegate.aDef objectForKey:SECONDARYEMAIL4];
    else
        self.sEmail4Txt.text=@"";
    
    
    if([appDelegate.aDef objectForKey:SECONDARYEMAIL5])
        self.sEmail5Txt.text =[appDelegate.aDef objectForKey:SECONDARYEMAIL5];
    else
        self.sEmail5Txt.text=@"";
    
    
    if([appDelegate.aDef objectForKey:SECONDARYEMAIL6])
        self.sEmail6Txt.text =[appDelegate.aDef objectForKey:SECONDARYEMAIL6];
    else
        self.sEmail6Txt.text=@"";
    ////////////////////////////////////////////////////////////////
    
    //// event notification /////
    
    if ([[appDelegate.aDef objectForKey:EVENTNOTIFICATIONEMAIL] isEqualToString:@"Y"]) {
        
        self.eventEmailNotifaction=@"Y";
        self.eventInviteEmailSwh.on=YES;
        
    }else{
        
        self.eventEmailNotifaction=@"N";
        self.eventInviteEmailSwh.on=NO;
        
    }
    
    if ([[appDelegate.aDef objectForKey:EVENTNOTIFICATION] isEqualToString:@"Y"]) {
        
        self.eventPushNotifaction=@"Y";
        self.eventInvitePushSwh.on=YES;
        
    }else{
        
        self.eventPushNotifaction=@"N";
        self.eventInvitePushSwh.on=NO;
        
    }

    
    
    
    //// team notification /////
    
    
    if ([[appDelegate.aDef objectForKey:TEAMNOTIFICATIONEMAIL] isEqualToString:@"Y"]) {
       
        self.teamEmailNotifaction=@"Y";
        self.teamInviteEmailSwh.on=YES;
        
    }else{
        
        self.teamEmailNotifaction=@"N";
        self.teamInviteEmailSwh.on=NO;

    }
    
    if ([[appDelegate.aDef objectForKey:TEAMNTIFICATION] isEqualToString:@"Y"]) {
        
        self.teamPushNotifaction=@"Y";
        self.teamInvitePushSwh.on=YES;
        
    }else{
        
        self.teamPushNotifaction=@"N";
        self.teamInvitePushSwh.on=NO;
        
    }

    
    ///// friend notification //////
    
    
    if ([[appDelegate.aDef objectForKey:FRIENDNOTIFICATIONEMAIL] isEqualToString:@"Y"])
    {
        self.friendInviteEmailSwh.on=YES;
        self.friendEmailNotification=@"Y";
        
    }
    else
    {
        self.friendInviteEmailSwh.on=NO;
        self.friendEmailNotification=@"N";
        
    }
    
    if ([[appDelegate.aDef objectForKey:FRIENDNOTIFICATION] isEqualToString:@"Y"])
    {
        self.friendInvitePushSwh.on=YES;
        self.friendPushNotification=@"Y";
        
    }
    else
    {
        self.friendInvitePushSwh.on=NO;
        self.friendPushNotification=@"N";
        
    }

    ////// message notification //////
    
    
    if ([[appDelegate.aDef objectForKey:MESSAGENOTIFICATIONEMAIL] isEqualToString:@"Y"])
    {
        self.messageEmailSwh.on=YES;
        self.messageEmailNotifaction=@"Y";
        
    }
    else
    {
        self.messageEmailSwh.on=NO;
        self.messageEmailNotifaction=@"N";
        
    }
    
    if ([[appDelegate.aDef objectForKey:MESSAGENOTIFICATION] isEqualToString:@"Y"])
    {
        self.messagePushSwh.on=YES;
        self.messagePushNotifaction=@"Y";
        
    }
    else
    {
        self.messagePushSwh.on=NO;
        self.messagePushNotifaction=@"N";
        
    }

    
    
    /////////////////////////////////////////////////////////////////
    
    self.oldPswdTxt.text=@"";
    self.nwPswdTxt.text=@"";
    self.reNwPswdTxt.text=@"";
}



-(void)moveScrollView:(UIView *)theView
{
    CGFloat vcy=theView.center.y+theView.superview.frame.origin.y;
    
    CGFloat fsh=af.size.height;
    CGFloat sa=0.0;
    if (self.isiPad) {
        sa=vcy-fsh/2.2;
    }
    else{
        if(isiPhone5)
            sa=vcy-fsh/3.2;
        else
            sa=vcy-fsh/5.2;
    }
//    else
//        sa=vcy-fsh/9.2;
    
    if(sa<0)
        sa=0;
    
    self.settingsScroll.contentSize=CGSizeMake(af.size.width,af.size.height+kb.size.height);
    //NSLog(@"%f-%f-%f,%f",self.settingsScroll.contentSize.height,af.size.height,kb.size.height,sa);
    [self.settingsScroll setContentOffset:CGPointMake(0,sa) animated:YES];
}



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    [self moveScrollView:textField];
    
     point=self.settingsScroll.contentOffset;
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.settingsScroll.contentSize = svos;
    [self.settingsScroll setContentOffset:CGPointMake(0,0) animated:YES];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (self.isiPad) {
        self.settingsScroll.contentSize=CGSizeMake(320,1200);
    }
    else{
        self.settingsScroll.contentSize=CGSizeMake(320,650);
    }
    //self.settingsScroll.contentSize=CGSizeMake(320,650);;
    
    return YES;
}

- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    
    if (theTextField==self.fnameTxt || theTextField==self.lnameTxt ) {
        
        if (theTextField.text.length<=15) {
            NSString *resultingString = [theTextField.text stringByReplacingCharactersInRange: range withString: string];
            NSCharacterSet *whitespaceSet = [NSCharacterSet whitespaceCharacterSet];
            if  ([resultingString rangeOfCharacterFromSet:whitespaceSet].location == NSNotFound)
            {
                return YES;
            }  else  {
                return NO;
            }
            
        }else{
            return NO;
        }
        
    }
    
    return YES;
}

-(void)doneClicked{
    [self.phoneTxt resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)changePhoto:(id)sender
{
    self.isModallyPresentFromCenterVC=1;
    [self takeImage];
}

#pragma mark - EventInviteNotification

- (IBAction)eventInvitePushValueChange:(id)sender {
    
    if (self.eventInvitePushSwh.on) {
        
        self.eventPushNotifaction=@"Y";
        
    }else{
        
        self.eventPushNotifaction=@"N";
        
    }
    
}

- (IBAction)eventInviteEmailValueChange:(id)sender {
    
    if (self.eventInviteEmailSwh.on) {
        
        self.eventEmailNotifaction=@"Y";
        
    }else{
        
        self.eventEmailNotifaction=@"N";
        
    }
}


#pragma mark - FriendInviteNotification

- (IBAction)friendInvitePushValueChange:(id)sender {
    
    if (self.friendInvitePushSwh.on) {
        
        self.friendPushNotification=@"Y";
        
    }else{
        
        self.friendPushNotification=@"N";
        
    }
}

- (IBAction)friendInviteEmailValueChange:(id)sender {
    
    if (self.friendInviteEmailSwh.on) {
        
        self.friendEmailNotification=@"Y";
        
    }else{
        
        self.friendEmailNotification=@"N";
        
    }

}

#pragma mark - TeamInviteNotification

- (IBAction)teamInvitePushValueChange:(id)sender {
    
    if (self.teamInvitePushSwh.on) {
        
        self.teamPushNotifaction=@"Y";
        
    }else{
        
        self.teamPushNotifaction=@"N";
    }
}

- (IBAction)teamInviteEmailValueChange:(id)sender {
    
    if (self.teamInviteEmailSwh.on) {
        
        self.teamEmailNotifaction=@"Y";
        
    }else{
        
        self.teamEmailNotifaction=@"N";
    }

}


#pragma mark - MessagesNotification

- (IBAction)messagePushValueChange:(id)sender {
    
    if (self.messagePushSwh.on) {
        
        self.messagePushNotifaction=@"Y";
        
    }else{
        
        self.messagePushNotifaction=@"N";
    }
}

- (IBAction)messageEmailValueChange:(id)sender {
    
    if (self.messageEmailSwh.on) {
        
        self.messageEmailNotifaction=@"Y";
        
    }else{
        
        self.messageEmailNotifaction=@"N";
    }
}





- (IBAction)saveSettings:(id)sender
{
    
    [self.fnameTxt resignFirstResponder];
    [self.lnameTxt resignFirstResponder];
    [self.emailTxt resignFirstResponder];
    [self.phoneTxt resignFirstResponder];
    [self.oldPswdTxt resignFirstResponder];
    [self.nwPswdTxt resignFirstResponder];
    [self.reNwPswdTxt resignFirstResponder];


    
    NSString* tmp=nil;
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    
    
    NSString *errorstr=@"";
    
    
    tmp=[[self.emailTxt text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (![tmp isEqualToString:@""])
    {
        if(![self validEmail:tmp])
        {
            
            if(errorstr.length==0)
                errorstr=@"The email is invalid";
            
        }
        
    }
    else
    {
        
        if(errorstr.length==0)
            errorstr=@"Please enter email";
        
    }
    
    [command setObject:tmp forKey:EMAIL];
    [command setObject:self.phoneTxt.text forKey:CONTACTNO];
    
    
    
    if([[self.oldPswdTxt text] isEqualToString:@""] && [[self.nwPswdTxt text] isEqualToString:@""] && [[self.reNwPswdTxt text] isEqualToString:@""])
        
    {
        
    }
    else
    {
    
    
   
    tmp=[[self.oldPswdTxt text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *oldPass=tmp;
    
    int flag=0;
    
    if ([tmp  isEqualToString:@""] )
    {
        
        
        //[self showAlertMessage:@"Please enter Password."];
        if(errorstr.length==0)
            errorstr=@"Please enter Password";
        // return;
        
        flag++;
    }
    else if ([tmp length  ]<6 )
    {
            
            
            //[self showAlertMessage:@"The password must be atleast 6 characters long."];
          if(errorstr.length==0)
            errorstr=@"The password must be at least 6 characters long";
            //  return;
            flag++;
    }
    
    else if (![tmp  isEqualToString:[appDelegate.aDef objectForKey:PASSWORD]] )
    {
        
        
        //[self showAlertMessage:@"Please enter Password."];
          if(errorstr.length==0)
        errorstr=@"Old Password does not match";
        // return;
        
        flag++;
    }
    
    
   
    
    
    
    if(!flag)
    {
        tmp=[[self.nwPswdTxt text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        /*if ([tmp  isEqualToString:@""] )
         {
         
         
         // [self showAlertMessage:@"Please enter Confirm Password."];
         [errorstr appendString:@"\nPlease enter Confirm Password"];
         // return;
         }*/
        
        if (![[[self.reNwPswdTxt text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] ] isEqualToString:tmp] )
        {
            
            
            // [self showAlertMessage:@"Confirm Password does not match."];
              if(errorstr.length==0)
            errorstr=@"Passwords do not match";
            // return;
        }
        else if([[[self.reNwPswdTxt text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] ] isEqualToString:@""] && [tmp isEqualToString:@""])
        {
              if(errorstr.length==0)
             errorstr=@"New Password can't be left blank";
        }
        else if ([tmp length  ]<6 )
        {
              if(errorstr.length==0)
            errorstr =@"New password must be at least 6 characters long";
        }
        else if([oldPass isEqualToString:tmp])
        {
              if(errorstr.length==0)
              errorstr =@"Both Old and New password can't be same";
        }
        
        //[command setObject:tmp forKey:@"re_password"];
         [command setObject:tmp forKey:PASSWORD];
    }
    
    
    
    
    }
    
    
        
    
    [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];

    
    tmp=[[self.fnameTxt text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if (![tmp isEqualToString:@""])
    {
           [command setObject:tmp forKey:FIRSTNAME];
    }
    else
    {
          [command setObject:@"" forKey:FIRSTNAME];
    }
    
       tmp=[[self.lnameTxt text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (![tmp isEqualToString:@""])
    {
        [command setObject:tmp forKey:LASTNAME];
    }
    else
    {
        [command setObject:@"" forKey:LASTNAME];
    }
    
    tmp=[[self.pEmail1Txt text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (![tmp isEqualToString:@""])
    {
        if(![self validEmail:tmp])
        {
            
           // [errorstr appendString:@"\nPlease enter valid primary email id 1."];
            
        }
        else
        {
             [command setObject:tmp forKey:PRIMARYEMAIL1];
        }
        
    }
    else
    {
        [command setObject:@"" forKey:PRIMARYEMAIL1];
    }
   
    
    tmp=[[self.pEmail2Txt text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (![tmp isEqualToString:@""])
    {
        if(![self validEmail:tmp])
        {
            
           // [errorstr appendString:@"\nPlease enter valid primary email id 2."];
            
        }
        else
        {
            [command setObject:tmp forKey:PRIMARYEMAIL2];
        }
        
    }
    else
    {
        [command setObject:@"" forKey:PRIMARYEMAIL2];
    }

    
    tmp=[[self.sEmail1Txt text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (![tmp isEqualToString:@""])
    {
        if(![self validEmail:tmp])
        {
            
           // [errorstr appendString:@"\nPlease enter valid secondary email id 1."];
            
        }
        else
        {
            [command setObject:tmp forKey:SECONDARYEMAIL1];
        }
        
    }
    else
    {
        [command setObject:@"" forKey:SECONDARYEMAIL1];
    }
    
    
    tmp=[[self.sEmail2Txt text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (![tmp isEqualToString:@""])
    {
        if(![self validEmail:tmp])
        {
            
            //[errorstr appendString:@"\nPlease enter valid secondary email id 2."];
            
        }
        else
        {
            [command setObject:tmp forKey:SECONDARYEMAIL2];
        }
        
    }
    else
    {
        [command setObject:@"" forKey:SECONDARYEMAIL2];
    }
    
    
    tmp=[[self.sEmail3Txt text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (![tmp isEqualToString:@""])
    {
        if(![self validEmail:tmp])
        {
            
           // [errorstr appendString:@"\nPlease enter valid secondary email id 3."];
            
        }
        else
        {
            [command setObject:tmp forKey:SECONDARYEMAIL3];
        }
        
    }
    else
    {
        [command setObject:@"" forKey:SECONDARYEMAIL3];
    }
    
    tmp=[[self.sEmail4Txt text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (![tmp isEqualToString:@""])
    {
        if(![self validEmail:tmp])
        {
            
           // [errorstr appendString:@"\nPlease enter valid secondary email id 4."];
            
        }
        else
        {
            [command setObject:tmp forKey:SECONDARYEMAIL4];
        }
        
    }
    else
    {
        [command setObject:@"" forKey:SECONDARYEMAIL4];
    }
    
    tmp=[[self.sEmail5Txt text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (![tmp isEqualToString:@""])
    {
        if(![self validEmail:tmp])
        {
            
            //[errorstr appendString:@"\nPlease enter valid secondary email id 5."];
            
        }
        else
        {
            [command setObject:tmp forKey:SECONDARYEMAIL5];
        }
        
    }
    else
    {
        [command setObject:@"" forKey:SECONDARYEMAIL5];
    }
    
    tmp=[[self.sEmail6Txt text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (![tmp isEqualToString:@""])
    {
        if(![self validEmail:tmp])
        {
            
            //[errorstr appendString:@"\nPlease enter valid secondary email id 6."];
            
        }
        else
        {
            [command setObject:tmp forKey:SECONDARYEMAIL6];
        }
        
    }
    else
    {
        [command setObject:@"" forKey:SECONDARYEMAIL6];
    }
    

    [command setObject:@"N" forKey:@"delete_image"];
    
    [command setObject:self.eventEmailNotifaction forKey:EVENTNOTIFICATIONEMAIL];
    [command setObject:self.eventPushNotifaction forKey:EVENTNOTIFICATION];

    
    [command setObject:self.teamEmailNotifaction forKey:TEAMNOTIFICATIONEMAIL];
    [command setObject:self.teamPushNotifaction forKey:TEAMNTIFICATION];

    [command setObject:self.friendEmailNotification forKey:FRIENDNOTIFICATIONEMAIL];
    [command setObject:self.friendPushNotification forKey:FRIENDNOTIFICATION];

    
    [command setObject:self.messageEmailNotifaction forKey:MESSAGENOTIFICATIONEMAIL];
    [command setObject:self.messagePushNotifaction forKey:MESSAGENOTIFICATION];

    
    if([errorstr length]>INITIALERRORSTRINGLENGTH)
    {
        
        [self showAlertMessage:errorstr title:@""];
        return;
    }
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    
    self.requestDic=command;
    
    [appDelegate sendRequestFor:PROFILEEDIT from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
    
    
    
}





-(void)notifyRequesterWithData:(id) aData :(id)aData1
{
    
    [self hideHudView];
    [self hideNativeHudView];
    
    if([aData isKindOfClass:[ConnectionManager class]])
    {
        ConnectionManager *aR=(ConnectionManager*)aData;
        if([aR.requestSingleId isEqualToString:PROFILEEDIT])
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
            
            
            if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
            {
//                 [appDelegate saveAllUserDataFirstName:[self.requestDic objectForKey:FIRSTNAME] LastName:[self.requestDic objectForKey:LASTNAME] Address:[self.requestDic objectForKey:ADDRESS] Email:[self.requestDic objectForKey:EMAIL] Password:[self.requestDic objectForKey:PASSWORD] ContactNo:[self.requestDic objectForKey:CONTACTNO] PrimaryEmail1:[self.requestDic objectForKey:PRIMARYEMAIL1] PrimaryEmail2:[self.requestDic objectForKey:PRIMARYEMAIL2] SecondaryEmail1:[self.requestDic objectForKey:SECONDARYEMAIL1] SecondaryEmail2:[self.requestDic objectForKey:SECONDARYEMAIL2] SecondaryEmail3:[self.requestDic objectForKey:SECONDARYEMAIL3] SecondaryEmail4:[self.requestDic objectForKey:SECONDARYEMAIL4] SecondaryEmail5:[self.requestDic objectForKey:SECONDARYEMAIL5] SecondaryEmail6:[self.requestDic objectForKey:SECONDARYEMAIL6] ProfileImage:nil teamNotification: [self.requestDic objectForKey:TEAMNTIFICATION]friendNotification:[self.requestDic objectForKey:FRIENDNOTIFICATION]];
                
                [appDelegate saveAllUserDataFirstName:[self.requestDic objectForKey:FIRSTNAME] LastName:[self.requestDic objectForKey:LASTNAME] Address:[self.requestDic objectForKey:ADDRESS] Email:[self.requestDic objectForKey:EMAIL] Password:[self.requestDic objectForKey:PASSWORD] ContactNo:[self.requestDic objectForKey:CONTACTNO] PrimaryEmail1:[self.requestDic objectForKey:PRIMARYEMAIL1] PrimaryEmail2:[self.requestDic objectForKey:PRIMARYEMAIL2] SecondaryEmail1:[self.requestDic objectForKey:SECONDARYEMAIL1] SecondaryEmail2:[self.requestDic objectForKey:SECONDARYEMAIL2] SecondaryEmail3:[self.requestDic objectForKey:SECONDARYEMAIL3] SecondaryEmail4:[self.requestDic objectForKey:SECONDARYEMAIL4] SecondaryEmail5:[self.requestDic objectForKey:SECONDARYEMAIL5] SecondaryEmail6:[self.requestDic objectForKey:SECONDARYEMAIL6] ProfileImage:nil teamNotification:[self.requestDic objectForKey:TEAMNTIFICATION] friendNotification:[self.requestDic objectForKey:FRIENDNOTIFICATION] eventNotification:[self.requestDic objectForKey:EVENTNOTIFICATION] messageNotification:[self.requestDic objectForKey:MESSAGENOTIFICATION] teamNotificationEmail:[self.requestDic objectForKey:TEAMNOTIFICATIONEMAIL] friendNotificationEmail:[self.requestDic objectForKey:FRIENDNOTIFICATIONEMAIL] eventNotificationEmail:[self.requestDic objectForKey:EVENTNOTIFICATIONEMAIL] messageNotificationEmail:[self.requestDic objectForKey:MESSAGENOTIFICATIONEMAIL]];
                
                
                /////////Set Profile name leftview
                appDelegate.leftVC.userNameLbl.text=[NSString stringWithFormat:@"%@ %@",[appDelegate.aDef objectForKey:FIRSTNAME],[appDelegate.aDef objectForKey:LASTNAME]];
                
                self.oldPswdTxt.text=@"";
                self.nwPswdTxt.text=@"";
                self.reNwPswdTxt.text=@"";
                
                [self showHudAlert:[aDict objectForKey:@"message"]];
               

                [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
                self.requestDic=nil;

            }
            else
            {
                [self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
            }
        }
    }
    
    
    
}

-(void)hideHudViewHere
{
    [self hideHudView];

    
}



-(void)viewDidUnload
{
    [self setSettingsFirstView:nil];
    [self setSettingsSecondView:nil];
    [self setSettingsThirdView:nil];
    [self setSettingsForthView:nil];
    
    [self setSettingsScroll:nil];
    
    [self setFnameTxt:nil];
    [self setLnameTxt:nil];
    [self setEmailTxt:nil];
    
    [self setPEmail1Txt:nil];
    [self setPEmail2Txt:nil];
    
    [self setSEmail1Txt:nil];
    [self setSEmail2Txt:nil];
    [self setSEmail3Txt:nil];
    [self setSEmail4Txt:nil];
    [self setSEmail5Txt:nil];
    [self setSEmail6Txt:nil];
    
    [self setOldPswdTxt:nil];
    [self setNwPswdTxt:nil];
    [self setReNwPswdTxt:nil];
    [self setNotificationView:nil];
    
    [super viewDidUnload];
}



@end
