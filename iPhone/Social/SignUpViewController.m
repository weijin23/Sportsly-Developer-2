//
//  SignUpViewController.m
//  Social
//
//  Created by Mindpace on 21/08/13.
//
//

//#import "SBJsonWriter.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "HomeVC.h"
#import "CenterViewController.h"
#import "SignUpViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "VerificationViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController
@synthesize userView,avatarView,emailTxt,passwrdTxt,srchPhoto,signUp;
@synthesize signUpScroll,signUpView,isSelectedImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}







-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
    [self.firstName becomeFirstResponder];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
  
    
    [self.emailTxt resignFirstResponder];
    [self.firstName resignFirstResponder];
     [self.lastName resignFirstResponder];
     [self.passwrdTxt resignFirstResponder];
     [self.retypePassword resignFirstResponder];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    @autoreleasepool {
        
        
        if(appDelegate.isIphone5)
            self.topimav.image=[UIImage imageNamed:@"bg-login_640_1136lat.png"];
    }
    
    
    
    isSelectedImage=0;
//    [self.signUpScroll addSubview:self.signUpView];
//    signUpScroll.contentSize=self.signUpView.frame.size;
   
    [self.userView.layer setCornerRadius:3.0f];
    [self.userView.layer setMasksToBounds:YES];
    
   /* CGRect frEmail=self.emailTxt.frame;
    frEmail.size.height=40;
    self.emailTxt.frame=frEmail;
    
    CGRect frPass=self.passwrdTxt.frame;
    frPass.size.height=40;
    self.passwrdTxt.frame=frPass;*/
    
    [self.avatarView.layer setCornerRadius:8.0f];
    [self.avatarView.layer setMasksToBounds:YES];
    
   // self.signUpScroll. contentSize=CGSizeMake(320,560);
    svos= self.signUpScroll.contentSize;
    point=CGPointMake(0,0);
    af=[[UIScreen mainScreen] applicationFrame];

}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidUnload
{
    [self setRetypePassword:nil];
      [super viewDidUnload];
    [self setAvatarView:nil];
    [self setSrchPhoto:nil];
    [self setSignUpView:nil];
    [self setSignUpScroll:nil];
    self.userView=nil;
    self.emailTxt=nil;
    self.passwrdTxt=nil;
    self.signUp=nil;
    [self setAvatarimavw:nil];
  
}

-(void)moveScrollView:(UIView *)theView
{
    CGFloat vcy=theView.superview.center.y;
    
    CGFloat fsh=af.size.height;
    CGFloat sa=0.0;
    if(isiPhone5)
        sa=vcy-fsh/3.0;
    else
        sa=vcy-fsh/4.5;
    
    if(sa<0)
        sa=0;
    
    self.signUpScroll.contentSize=CGSizeMake(af.size.width,af.size.height+kb.size.height);
    NSLog(@"%f-%f-%f,%f",self.signUpScroll.contentSize.height,af.size.height,kb.size.height,sa);
    [ self.signUpScroll setContentOffset:CGPointMake(0,sa) animated:YES];
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
    
    self.signUpScroll.contentSize=svos;
    self.signUpScroll.contentOffset=point;
    
    return YES;
}

- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    int tag=[theTextField tag];
    
    
    NSCharacterSet *myCharSet;
    
    
    if(tag==1|tag==2)
    {
    myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ "];
    for (int i = 0; i < [string length]; i++)
    {
        unichar c = [string characterAtIndex:i];
        if (![myCharSet characterIsMember:c])
        {
            return NO;
        }
    }
    }
    
    
    if (theTextField!=self.emailTxt) {
        
        if (theTextField.text.length<=15) {
            
            NSString *resultingString = [theTextField.text stringByReplacingCharactersInRange: range withString: string];
            NSCharacterSet *whitespaceSet = [NSCharacterSet whitespaceCharacterSet];
            if  ([resultingString rangeOfCharacterFromSet:whitespaceSet].location == NSNotFound)
            {
                return YES;
            }
            else
            {
                return NO;
            }

        }
    }
    
    
    
    
    return YES;
    
    
    
   
}


- (IBAction)uploadPhoto:(id)sender
{
    [self takeImage];
}

- (IBAction)crosstapped:(id)sender
{
    
    isSelectedImage=0;
    self.avatarimavw.image=self.noImage;
       self.crossbT.hidden=YES;
}

- (IBAction)sendVerificationEmail:(id)sender
{
    VerificationViewController *fp=[[VerificationViewController alloc] initWithNibName:@"VerificationViewController" bundle:nil];
    
    
    [self.navigationController pushViewController:fp animated:YES];
}

- (IBAction)signUpBtn:(id)sender
{
    if([self.firstName isFirstResponder])
        [self.firstName resignFirstResponder];
    if([self.lastName isFirstResponder])
        [self.lastName resignFirstResponder];
    if([self.emailTxt isFirstResponder])
    [self.emailTxt resignFirstResponder];
     if([self.passwrdTxt isFirstResponder])
     [self.passwrdTxt resignFirstResponder];
     if([self.retypePassword isFirstResponder])
     [self.retypePassword resignFirstResponder];
    
    self.signUpScroll.contentSize=svos;
    self.signUpScroll.contentOffset=point;
    
    NSString* tmp=nil;
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    
   
    NSString *errorstr=@"";
    
    tmp=[[self.firstName text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([tmp isEqualToString:@""])
    {
       // [errorstr appendString:@"\nPlease enter first name."];
        if(errorstr.length==0)
            errorstr=@"Please enter first name.";
        
    }
    
    [command setObject:tmp forKey:@"FirstName"];
    
    tmp=[[self.lastName text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([tmp isEqualToString:@""])
    {
       // [errorstr appendString:@"\nPlease enter last name."];
        
        if(errorstr.length==0)
            errorstr=@"Please enter last name.";
        
    }
    
      [command setObject:tmp forKey:@"LastName"];
    
    tmp=[[self.emailTxt text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  
   
  
   
    
    
    if (![tmp isEqualToString:@""])
    {
        if(![self validEmail:tmp])
        {
           if(errorstr.length==0)
           errorstr= @"The email id is invalid.";
            
        }
        
    }
    else
    {
        if(errorstr.length==0)
         errorstr=@"Please enter email id.";
       
    }
    
    [command setObject:tmp forKey:@"Email"];
    
    
    NSString *pass=nil;
    
    tmp=[[self.passwrdTxt text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    pass=tmp;
    int flag=0;
    
    if ([tmp  isEqualToString:@""] )
    {
        
        
         if(errorstr.length==0)
        errorstr=@"Please enter password.";
   
        
        flag++;
    }
    else
    {
        if ([tmp length  ]<6 )
        {
            
            
              if(errorstr.length==0)
            errorstr= @"The password must be atleast 6 characters long.";
           
            flag++;
        }
    }
      
    [command setObject:tmp forKey:@"Password"];
    
    
    
    
    
    tmp=[[self.retypePassword text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    flag=0;
    
    if ([tmp  isEqualToString:@""] )
    {
        
        
        if(errorstr.length==0)
            errorstr=@"Please enter confirm password.";
        
        
        flag++;
    }
    else
    {
        if (![tmp isEqualToString:pass] )
        {
            
            
            if(errorstr.length==0)
                errorstr= @"Passwords do not match.";
            
            flag++;
        }
    }
    
    
    if([errorstr length]>INITIALERRORSTRINGLENGTH)
    {
        
        [self showAlertMessage:errorstr title:PRODUCT_NAME];
        return;
    }
    
       [command setObject:[appDelegate.aDef objectForKey:UDID] forKey:@"IMEI"];
     [command setObject:@"N" forKey:@"reg_type"];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    if(isSelectedImage==1)
        [appDelegate sendRequestFor:SIGNUP from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam",UIImageJPEGRepresentation(self.avatarimavw.image,0.1),@"ProfileImage", nil]];
    else
        [appDelegate sendRequestFor:SIGNUP from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
}


-(void)notifyRequesterWithData:(id) aData :(id)aData1
{
    
    [self hideHudView];
    [self hideNativeHudView];
    
    if([aData isKindOfClass:[ConnectionManager class]])
    {
        ConnectionManager *aR=(ConnectionManager*)aData;
        if([aR.requestSingleId isEqualToString:SIGNUP])
        {
          
        }
        if([aR.requestSingleId isEqualToString:LOGIN])
        {
            
        }
        return;
    }
    
    
    NSString *str=(NSString*)aData;
    
    NSLog(@"Data=%@",str);
    
    ConnectionManager *aR=(ConnectionManager*)aData1;
    if([aR.requestSingleId isEqualToString:SIGNUP])
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
                    
              //      NSString *deviceToken=[self.appDelegate.aDef objectForKey:DEVICE_TOKEN];
              //      NSString *userId=[aDict objectForKey:@"UserID"];
                    
               //CH     [self.appDelegate sendDeviceToServerDeviceToken:deviceToken UserId:userId CheckStatus:0];
                    
                    [self showHudAlert:[aDict objectForKey:@"message"]];
                    [self performSelector:@selector(hideHudViewHereForLogin) withObject:nil afterDelay:2.0];
//                  [self showAlertMessage:[aDict objectForKey:@"A verification mail has been sent to your email account. Please click on the link to activate this account registered"] title:@""];
//                    [self.navigationController popViewControllerAnimated:YES];
                  
                }
                else
                {
                    if([[aDict objectForKey:@"message"] isEqualToString:@"Email id is already registered. Please use another email."])
                    {
                    [self showHudAlert:@"Email id is already registered."];
                    [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
                    }
                    else
                    {
                    [self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
                    }
                }
            }
        }
        
        

        
    }
    else if([aR.requestSingleId isEqualToString:LOGIN])
    {
        
        
        
        @autoreleasepool {
            
            
            
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
                        
                        //
                        
                        [appDelegate setUserDefaultValue:@"1" ForKey:ISLOGIN];
                        
                        [appDelegate setUserDefaultValue:[NSString stringWithFormat:@"%@", [aDict objectForKey:@"new_login"]] ForKey:NEWLOGIN];
                        
                        NSLog(@"%@ %@",[NSString stringWithFormat:@"%@", [aDict objectForKey:@"new_login"]],[appDelegate.aDef objectForKey:NEWLOGIN]);
                        
                        aDict=[aDict objectForKey:@"response"];
                        aDict=[aDict objectForKey:@"user_details"];
                        
                        
                        
                        
                        
                        
                        NSString  *  tmp=[[self.passwrdTxt text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        
                        [appDelegate saveAllUserDataFirstName:[aDict objectForKey:FIRSTNAME] LastName:[aDict objectForKey:LASTNAME] Address:[aDict objectForKey:ADDRESS] Email:[aDict objectForKey:EMAIL] Password:tmp ContactNo:[aDict objectForKey:CONTACTNO ] PrimaryEmail1:[aDict objectForKey:PRIMARYEMAIL1 ] PrimaryEmail2:[aDict objectForKey:PRIMARYEMAIL2 ] SecondaryEmail1:[aDict objectForKey:SECONDARYEMAIL1 ] SecondaryEmail2:[aDict objectForKey:SECONDARYEMAIL2 ] SecondaryEmail3:[aDict objectForKey:SECONDARYEMAIL3 ] SecondaryEmail4:[aDict objectForKey:SECONDARYEMAIL4 ] SecondaryEmail5:[aDict objectForKey:SECONDARYEMAIL5 ] SecondaryEmail6:[aDict objectForKey:SECONDARYEMAIL6 ] ProfileImage:nil teamNotification:[aDict objectForKey:TEAMNTIFICATION ] friendNotification:[aDict objectForKey:FRIENDNOTIFICATION ] eventNotification:[aDict objectForKey:EVENTNOTIFICATION ] messageNotification:[aDict objectForKey:MESSAGENOTIFICATION ] teamNotificationEmail:[aDict objectForKey:TEAMNOTIFICATIONEMAIL ] friendNotificationEmail:[aDict objectForKey:FRIENDNOTIFICATIONEMAIL ] eventNotificationEmail:[aDict objectForKey:EVENTNOTIFICATIONEMAIL ] messageNotificationEmail:[aDict objectForKey:MESSAGENOTIFICATIONEMAIL ]];
                        
                        //////////////////
                        if([self.requestDic objectForKey:@"ISFACEBOOK" ] && [[self.requestDic objectForKey:@"ISFACEBOOK" ] isEqualToString:@"1"])
                        {
                            [appDelegate setUserDefaultValue:@"1" ForKey:ISLOGINWITHFACEBOOK];
                            
                            
                            
                            if([[aDict objectForKey:@"ProfileImage"] isEqualToString:@""])
                            {
                                ///////////
                                NSString *proflink=[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=square",[self.requestDic objectForKey:@"ID" ]];
                                NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:proflink]];
                                NSURLResponse * response = nil;
                                NSError * error = nil;
                                NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
                                                                      returningResponse:&response
                                                                                  error:&error];
                                
                                if (error == nil)
                                {
                                    
                                    appDelegate.faceBookImageData=data;
                                }
                                
                                
                                
                                
                                ///////////
                            }
                        }
                        ///////////////////
                        [appDelegate setUserDefaultValue:[aDict objectForKey:@"UserID"] ForKey:LoggedUserID];
                        
                        
                        
                        [appDelegate setUserDefaultValue:[aDict objectForKey:@"deviceToken"] ForKey:LoggedUserDeviceTokenStatus];
                        
                        if(![[aDict objectForKey:@"ProfileImage"] isEqualToString:@""])
                            [appDelegate setUserDefaultValue:[aDict objectForKey:@"ProfileImage"] ForKey:USERPROFILEURL];
                        
                        
                        
                        
                        ////////////////////////////
                        
                         NSArray *admindetails=[aDict objectForKey:@"admin_details"];
                        NSArray *playerdetails=[aDict objectForKey:@"player_details"];
                        NSArray *teamdetails=[aDict objectForKey:@"team_list"];
                        NSArray *lastTenInvites=[aDict objectForKey:@"last_ten_invites"];
                        NSArray *tendeleteevents=[aDict objectForKey:@"last_ten_delete_events"];
                        NSArray *tenupdateevents=[aDict objectForKey:@"last_ten_update_events"];
                        NSArray *tenplayerteamresponse=[aDict objectForKey:@"player_last_ten_invites"];
                        NSArray *tenprimaryteamresponse=[aDict objectForKey:@"primary_last_ten_invites"];
                        NSArray *tenplayerteameventresponse=[aDict objectForKey:@"player_last_ten_events_invite"];
                        NSArray *tenprimaryteameventresponse=[aDict objectForKey:@"primary_last_ten_events_invite"];
                         NSArray *tencoachteameventresponse=[aDict objectForKey:@"coach_last_ten_events_invite"];
                        
                          NSArray *adminresponse=[aDict objectForKey:ADMINLASTTENRESPONSE];
                        
                        if(teamdetails.count>0)
                        {
                            [appDelegate setUserDefaultValue:@"1" ForKey:ISEXISTOWNTEAM];
                        }
                        else
                        {
                            if([appDelegate.aDef objectForKey:ISEXISTOWNTEAM])
                                [appDelegate removeUserDefaultValueForKey:ISEXISTOWNTEAM];
                        }
                        
                        NSArray *messageList=[aDict objectForKey:@"message_details"];
                        
                        [self.appDelegate savependingMessage:messageList];
                        
                        
                        NSArray *invitefriendnotificationdetails=[aDict objectForKey:@"invitefrnd_push_notification"];
                        NSArray *primaryplayerdetails=[aDict objectForKey:@"primary_player_details"];
                        
                        
                        
                        
                        
                        
                        [self.appDelegate.centerVC parseAndSaveTeam:admindetails:playerdetails :teamdetails :invitefriendnotificationdetails:primaryplayerdetails];
                        
                        NSArray *teamIds=[appDelegate.aDef objectForKey:ARRAYIDS];
                        
                        
                        /* for(NSDictionary* dic in notificationdetails)
                         {
                         
                         //if([dic objectForKey:@"Like_user_id"])
                         // [self.appDelegate savePushDataForLike:dic :[dic objectForKey:@"message"]];
                         //else if([dic objectForKey:@"cmnt_user_id"])
                         // [self.appDelegate savePushDataForComment:dic :[dic objectForKey:@"message"]];
                         
                         
                         
                         //[[NSNotificationCenter defaultCenter] postNotificationName:LIKECOMMENTARRAYDATAFROMLOGIN object:notificationdetails];
                         }*/
                        NSString *notnumberstr=@"0";
                        if(![[aDict objectForKey:@"notification"] objectForKey:@"blank"])
                        {
                            
                            NSLog(@"notification");
                            
                            NSArray *notificationdetails=[[aDict objectForKey:@"notification"] objectForKey:@"notification_array"];
                            
                            notnumberstr=[[NSString alloc] initWithFormat:@"%@",[[aDict objectForKey:@"notification"] objectForKey:@"countunview"]];
                            
                            
                            [self parseLikeAndComments:notificationdetails];
                        }
                        
                        appDelegate.allHistoryLikesCounts=[notnumberstr longLongValue];
                        [appDelegate setUserDefaultValue:[NSNumber numberWithLongLong:appDelegate.allHistoryLikesCounts] ForKey:ALLHISTORYLIKECOUNTS ];
                        
                        
                        
                        for(NSDictionary* dic in admindetails)
                        {
                            if([[dic objectForKey:@"invites"] isEqualToString:NORESPONSE] /*|| [[dic objectForKey:@"invites"] isEqualToString:@"Decline"]*/)
                            {
                                Invite *invite=(Invite*)  [self objectOfTypeAdminInvite:INVITE forTeam1:[NSString stringWithFormat:@"%@", [dic objectForKey:@"team_id"] ] andManObjCon:self.managedObjectContext];
                                
                                
                                
                                
                                if(!invite)
                                {
                                    invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
                                    invite.teamName=[dic objectForKey:@"team_name"];
                                    invite.teamId=[NSString stringWithFormat:@"%@", [dic objectForKey:@"team_id"] ];
                                    invite.creatorEmail=[dic objectForKey:@"creator_email"];
                                    
                                    if([dic objectForKey:TEAMSPORTKEY])
                                        invite.teamSport=[dic objectForKey:TEAMSPORTKEY];
                                    
                                    invite.creatorName=[dic objectForKey:@"creator_name"];
                                    invite.creatorPhno=[dic objectForKey:@"creator_phno"];
                                    /*if([dic objectForKey:@"invite_text"] && (![[dic objectForKey:@"invite_text"] isEqualToString:@""]))
                                     invite.message=[dic objectForKey:@"invite_text"];*///[NSString stringWithFormat:@"Team invite from %@",invite.teamName];
                                    invite.type=[NSNumber numberWithInt:14];
                                    
                                    /////////////
                                    if([dic objectForKey:@"adddate"])
                                    {
                                        int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                                        
                                        NSDate *datetime=   [[appDelegate.dateFormatFullOriginalComment dateFromString:[dic objectForKey:@"adddate"]] dateByAddingTimeInterval:difftime]  ;
                                        
                                        
                                        invite.datetime=datetime;
                                    }
                                    
                                    
                                    
                                   if( [[dic objectForKey:@"invites"] isEqualToString:@"Decline"])
                                      invite.inviteStatus=[[NSNumber alloc] initWithInteger:2];
                                       else
                                    invite.inviteStatus=[[NSNumber alloc] initWithInteger:0];
                                    
                                    
                                    
                                    if([dic objectForKey:@"creator_img"])
                                        invite.senderProfileImage=[dic objectForKey:@"creator_img"];
                                    else
                                        invite.senderProfileImage=@"";
                                    
                                    invite.userId=[dic objectForKey:@"creator_id"];
                                    
                                    //////////////////
                                    
                                    
                                    [appDelegate saveContext];
                                }
                                
                                
                            }
                            
                            
                        }

                        
                        if([[appDelegate.aDef objectForKey:TEAMNTIFICATION] isEqualToString:@"Y"])
                        {
                        for(NSDictionary* dic in playerdetails)
                        {
                            if([[dic objectForKey:@"invites"] isEqualToString:NORESPONSE])
                            {
                                Invite *invite=(Invite*)  [self objectOfTypeInvite:INVITE forTeam1:[NSString stringWithFormat:@"%@", [dic objectForKey:@"team_id"] ] andManObjCon:self.managedObjectContext];
                                
                                
                                
                                
                                if(!invite)
                                {
                                    invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
                                    invite.teamName=[dic objectForKey:@"team_name"];
                                    invite.teamId=[NSString stringWithFormat:@"%@", [dic objectForKey:@"team_id"] ];
                                    invite.creatorEmail=[dic objectForKey:@"creator_email"];
                                    
                                    if([dic objectForKey:TEAMSPORTKEY])
                                        invite.teamSport=[dic objectForKey:TEAMSPORTKEY];
                                    
                                    invite.creatorName=[dic objectForKey:@"creator_name"];
                                    invite.creatorPhno=[dic objectForKey:@"creator_phno"];
                                    if([dic objectForKey:@"invite_text"] && (![[dic objectForKey:@"invite_text"] isEqualToString:@""]))
                                        invite.message=[dic objectForKey:@"invite_text"];//[NSString stringWithFormat:@"Team invite from %@",invite.teamName];
                                    invite.type=[NSNumber numberWithInt:0];
                                    
                                    /////////////
                                    if([dic objectForKey:@"adddate"])
                                    {
                                        int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                                        
                                        NSDate *datetime=   [[appDelegate.dateFormatFullOriginalComment dateFromString:[dic objectForKey:@"adddate"]] dateByAddingTimeInterval:difftime]  ;
                                        
                                        
                                        invite.datetime=datetime;
                                    }
                                    invite.inviteStatus=[[NSNumber alloc] initWithInteger:0];
                                    
                                    
                                    
                                    if([dic objectForKey:@"creator_img"])
                                        invite.senderProfileImage=[dic objectForKey:@"creator_img"];
                                    else
                                        invite.senderProfileImage=@"";
                                    
                                    
                                    
                                    //////////////////
                                    
                                    
                                    [appDelegate saveContext];
                                }
                                
                                
                            }
                            
                            
                        }
                        }
                        
                        
                        
                        if([[appDelegate.aDef objectForKey:TEAMNTIFICATION] isEqualToString:@"Y"])
                        {
                        
                        for(NSDictionary* dic in primaryplayerdetails)
                        {
                            
                            
                            int flag=1;
                            
                            
                            
                            for(NSString *str in teamIds)
                            {
                                if([str isEqualToString: [NSString stringWithFormat:@"%@", [dic objectForKey:@"team_id"] ] ])
                                {
                                    flag=0;
                                }
                            }
                            
                            
                            if(flag==1)
                            {
                                if([[dic objectForKey:@"invites"] isEqualToString:NORESPONSE])
                                {
                                    Invite *invite=(Invite*)  [self objectOfTypeInvite:INVITE forTeam1:[NSString stringWithFormat:@"%@", [dic objectForKey:@"team_id"] ] andManObjCon:self.managedObjectContext];
                                    
                                    
                                    
                                    
                                    if(!invite)
                                    {
                                        invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
                                        invite.teamName=[dic objectForKey:@"team_name"];
                                        invite.teamId=[NSString stringWithFormat:@"%@", [dic objectForKey:@"team_id"] ];
                                        invite.creatorEmail=[dic objectForKey:@"creator_email"];
                                        if([dic objectForKey:TEAMSPORTKEY])
                                            invite.teamSport=[dic objectForKey:TEAMSPORTKEY];
                                        invite.creatorName=[dic objectForKey:@"creator_name"];
                                        invite.creatorPhno=[dic objectForKey:@"creator_phno"];
                                        
                                        if([dic objectForKey:@"invite_text"] && (![[dic objectForKey:@"invite_text"] isEqualToString:@""]))
                                            invite.message=[dic objectForKey:@"invite_text"];//[NSString stringWithFormat:@"Team invite from %@",invite.teamName];
                                        invite.type=[NSNumber numberWithInt:0];
                                        
                                        
                                        
                                        
                                        invite.userId=[dic objectForKey:@"user_id"];
                                        
                                        
                                        /////////////
                                        if([dic objectForKey:@"adddate"])
                                        {
                                            int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                                            
                                            NSDate *datetime=   [[appDelegate.dateFormatFullOriginalComment dateFromString:[dic objectForKey:@"adddate"]] dateByAddingTimeInterval:difftime]  ;
                                            
                                            
                                            invite.datetime=datetime;
                                        }
                                        invite.inviteStatus=[[NSNumber alloc] initWithInteger:0];
                                        if([dic objectForKey:@"creator_img"])
                                            invite.senderProfileImage=[dic objectForKey:@"creator_img"];
                                        else
                                            invite.senderProfileImage=@"";
                                        
                                        
                                        //////////////////
                                        [appDelegate saveContext];
                                    }
                                    
                                    
                                }
                            }
                            
                        }
                        
                        }
                        
                        
                        
                        
                        if([[appDelegate.aDef objectForKey:FRIENDNOTIFICATION] isEqualToString:@"Y"])
                        {
                        for(NSDictionary* dic in invitefriendnotificationdetails)
                        {
                            NSArray *namearr= [[dic objectForKey:@"message"] componentsSeparatedByString:APPURL];
                            
                            NSString *contentMessage=@"A Friend";
                            
                            if(namearr.count>1)
                                contentMessage= [namearr objectAtIndex:1];
                            
                            
                            
                            
                            NSDictionary *teamDetails=[dic objectForKey:@"team_details"];
                            
                            
                            int flag=1;
                            
                            
                            
                            for(NSString *str in teamIds)
                            {
                                if([str isEqualToString: [NSString stringWithFormat:@"%@", [teamDetails objectForKey:@"team_id"] ] ])
                                {
                                    flag=0;
                                }
                            }
                            
                            if(flag==1)
                            {
                                
                                if([[dic objectForKey:@"status"] isEqualToString:NORESPONSE])
                                {
                                    
                                    
                                    Invite *invite=(Invite*)  [self objectOfTypeInvite:INVITE forTeam1:[NSString stringWithFormat:@"%@", [teamDetails objectForKey:@"team_id"] ] /*forUpdate:4*/ andManObjCon:self.managedObjectContext];
                                    
                                    //ch
                                    
                                    
                                    if(!invite)
                                    {
                                        invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
                                        invite.teamName=[teamDetails objectForKey:@"team_name"];
                                        invite.teamId=[NSString stringWithFormat:@"%@", [teamDetails objectForKey:@"team_id"] ];
                                        invite.creatorEmail=@"";//[dic objectForKey:@"creator_email"];
                                        invite.creatorName=@"";//[dic objectForKey:@"creator_name"];
                                        invite.creatorPhno=@"";//[dic objectForKey:@"creator_phno"];
                                        invite.message=[NSString stringWithFormat:@"Friend invite from %@",invite.teamName];
                                        
                                        NSString *sendername=[contentMessage stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                                        
                                        NSString *body=nil;
                                        if(![sendername isEqualToString:@""])
                                        {
                                            // body= [[NSString alloc] initWithFormat:@"%@ has invited you to join his team, %@, wall on SidelineHeroes.\n\n%@",sendername,invite.teamName,APPURL];
                                            body= [NSString stringWithFormat:@"Hi,\n\nI'd like to invite you to join team, %@ on Sportsly (%@)\n\n%@",invite.teamName,APPURL,sendername];
                                        }
                                        else
                                        {
                                            //body=  [[NSString alloc] initWithFormat:@"A Coach has invited you to join his team, %@, wall on SidelineHeroes.\n\n%@",invite.teamName,APPURL];
                                            body=  [NSString stringWithFormat:@"Hi,\n\nI'd like to invite you to join team, %@ on Sportsly (%@)",invite.teamName,APPURL];
                                        }
                                        
                                        invite.contentMessage=body;
                                        body=nil;
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        invite.type=[NSNumber numberWithInt:4];
                                        
                                        NSLog(@"SecondaryIdLogIn=%@",[dic objectForKey:@"id"]);
                                        
                                        invite.postId=[dic objectForKey:@"id"];
                                        
                                        ////////
                                        int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                                        
                                        NSDate *datetime=   [[appDelegate.dateFormatFullOriginalComment dateFromString:[dic objectForKey:@"datetime"]] dateByAddingTimeInterval:difftime]  ;
                                        
                                        
                                        invite.datetime=datetime;
                                        
                                        
                                        if([teamDetails objectForKey:TEAMSPORTKEY])
                                            invite.teamSport=[teamDetails objectForKey:TEAMSPORTKEY];
                                        invite.inviteStatus=[[NSNumber alloc] initWithInteger:0];
                                        
                                       
                                        ////////
                                        
                                        if([[dic objectForKey:@"admin_type2"] isEqualToString:@"Y"])
                                        {
                                            invite.senderName=[teamDetails objectForKey:@"creator_name"];
                                            invite.senderProfileImage=[teamDetails objectForKey:@"creator_img"];
                                            invite.userId=[teamDetails objectForKey:@"coach_id"];
                                        }
                                        else
                                        {
                                            invite.senderName=[dic objectForKey:@"user_name"];
                                            invite.senderProfileImage=[dic objectForKey:PROFILEIMAGE];
                                            invite.userId=[dic objectForKey:SECONDARYUSERSENDERID];
                                        }
                                        [appDelegate saveContext];
                                    }
                                    
                                    
                                    
                                }
                                
                            }
                            
                        }
                        }
                        //////Last Ten Invites
                        
                        for(NSDictionary* dic in lastTenInvites)
                        {
                            //  [NSString stringWithFormat:@"%@", [dic objectForKey:@"p_id"] ]
                            
                            if([[dic objectForKey:@"inv"] isEqualToString:@"Accept"] ||
                               [[dic objectForKey:@"inv"] isEqualToString:@"Decline"] ||
                               [[dic objectForKey:@"inv"] isEqualToString:@"Maybe"])
                            {
                                
                                
                                Invite *invite=(Invite*)  [self objectOfTypeInviteTeamResponse:INVITE forTeam:[dic objectForKey:@"p_id"] andManObjCon:self.managedObjectContext];
                                
                                if(!invite)
                                {
                                    invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
                                    invite.teamName=[dic objectForKey:@"t_n"];
                                    invite.teamId=[NSString stringWithFormat:@"%@", [dic objectForKey:@"t_id"] ];
                                    
                                    invite.playerId=[dic objectForKey:@"p_id"];
                                    invite.playerName=[dic objectForKey:@"a_n"];
                                    invite.profImg=[[NSString alloc] initWithFormat:@"%@%@",IMAGELINKTHUMB,[dic objectForKey:@"a_img"]];
                                    invite.type=[NSNumber numberWithInt:7];
                                    ////////
                                    int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                                    
                                    NSDate *datetime=   [[appDelegate.dateFormatFullOriginalComment dateFromString:[dic objectForKey:@"a_dt"]] dateByAddingTimeInterval:difftime]  ;
                                    
                                    
                                    invite.datetime=datetime;
                                    
                                    invite.viewStatus=[[NSNumber alloc] initWithBool:[[dic objectForKey:@"coach_view_inv"] boolValue]];
                                    
                                    if([[dic objectForKey:@"inv"] isEqualToString:@"Accept"])
                                        invite.inviteStatus=[[NSNumber alloc] initWithInt:1 ];
                                    else if([[dic objectForKey:@"inv"] isEqualToString:@"Decline"])
                                        invite.inviteStatus=[[NSNumber alloc] initWithInt:2 ];
                                    else if([[dic objectForKey:@"inv"] isEqualToString:@"Maybe"])
                                        invite.inviteStatus=[[NSNumber alloc] initWithInt:3 ];
                                    
                                    [appDelegate saveContext];
                                    
                                }
                                
                            }
                            
                        }
                        
                        
                        
                        
                        
                        
                        
                        //                    NSMutableArray
                        //                    appDelegate.eventsTempStoreArr=
                        for(NSDictionary* dic in teamdetails)
                        {
                            [self.appDelegate addEventsAfterLogin:[dic objectForKey:@"event_details"]:1:nil:nil:nil:0:0:0:0];
                        }
                        
                        for(NSDictionary* dic in admindetails)
                        {
                            [self.appDelegate addEventsAfterLogin:[dic objectForKey:@"event_details"]:1:nil:nil:nil:0:1:0:0];
                        }
                        
                        for(NSDictionary* dic in playerdetails)
                        {
                            if(!([[dic objectForKey:@"invites"] isEqualToString:PENDING] /*|| [[dic objectForKey:@"invites"] isEqualToString:NORESPONSE]*/ || [[dic objectForKey:@"invites"] isEqualToString:@"Decline"]))
                            {
                                
                                if([[dic objectForKey:@"invites"] isEqualToString:@"Maybe"])
                                    [self.appDelegate addEventsAfterLogin:[dic objectForKey:@"event_details"]:0:[dic objectForKey:@"player_name"]:[dic objectForKey:@"player_id"]:[dic objectForKey:@"user_id"]:1:0:1:0];
                                else
                                    [self.appDelegate addEventsAfterLogin:[dic objectForKey:@"event_details"]:0:[dic objectForKey:@"player_name"]:[dic objectForKey:@"player_id"]:[dic objectForKey:@"user_id"]:0:0:1:0];
                            }
                        }
                        
                        for(NSDictionary* dic in primaryplayerdetails)
                        {
                            if(!([[dic objectForKey:@"invites"] isEqualToString:PENDING] /*|| [[dic objectForKey:@"invites"] isEqualToString:NORESPONSE]*/ || [[dic objectForKey:@"invites"] isEqualToString:@"Decline"]))
                            {
                                
                                if([[dic objectForKey:@"invites"] isEqualToString:@"Maybe"])
                                    [self.appDelegate addEventsAfterLogin:[dic objectForKey:@"event_details"]:0:[dic objectForKey:@"player_name"]:[dic objectForKey:@"player_id"]:[dic objectForKey:@"user_id"]:1:0:1:0];
                                else
                                    [self.appDelegate addEventsAfterLogin:[dic objectForKey:@"event_details"]:0:[dic objectForKey:@"player_name"]:[dic objectForKey:@"player_id"]:[dic objectForKey:@"user_id"]:0:0:1:0];
                                
                            }
                        }
                        ////////////////////////////////////////////////
                        /*
                         
                         ////////////////////////////////////////////////
                         
                         
                         */
                        
                        
                        
                        
                        [self parseLastUpdateEvent:tenupdateevents];
                        [self parseLastDeleteEvent:tendeleteevents];
                        [self parseLastTenPlayer:tenplayerteamresponse];
                        [self parseLastTenPrimary:tenprimaryteamresponse];
                        [self parseLastTenEventPlayer:tenplayerteameventresponse];
                        [self parseLastTenEventPrimary:tenprimaryteameventresponse];
                         [self parseLastTenEventCoach:tencoachteameventresponse];
                        
                        [self parseLastTenAdminStatusResponse:adminresponse];
                        
                        ////////////////////////////////////////////////
                        
                      
                        
                        
                        ////////////////////////////
                        
                        /*if([[appDelegate.aDef objectForKey:LoggedUserDeviceTokenStatus] isEqualToString:@"No"] || [[appDelegate.aDef objectForKey:LoggedUserDeviceTokenStatus] isEqualToString:@"N"] || [[appDelegate.aDef objectForKey:LoggedUserDeviceTokenStatus] isEqualToString:@"NO"])
                         {*/
                        NSString *deviceToken=[self.appDelegate.aDef objectForKey:DEVICE_TOKEN];
                        NSString *userId=[aDict objectForKey:@"UserID"];
                        
                        if(deviceToken)
                        {
                            [self.appDelegate sendDeviceToServerDeviceToken:deviceToken UserId:userId CheckStatus:0];
                        }
                        else
                        {
                            [self.appDelegate registerForGetttingDTForPushNotificationServiceStatus:1];
                        }
                        
                        // }
                        
                        
                        
                        
                        
                        /*[self showHudAlert:@"Login Successful"];
                        [self performSelector:@selector(hideHudViewHereLoginFinish) withObject:nil afterDelay:2.0];*/
                        
                        [self hideHudViewHereLoginFinish];
                        self.requestDic=nil;
                    }
                    else
                    {
                        
                        if([[aDict objectForKey:@"message"] isEqualToString:@"Unregistered user."])
                            [self showAlertMessage:@"Login failed.  Invalid username or password. Please try again"];
                        else
                            [self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
                    }
                }
            }
            
        }
        
        
        
        
    }
    
       
    
    
    
    
    
}


-(void)hideHudViewHereLoginFinish
{
    /*[self hideHudView];
    
    [appDelegate.leftVC view];
    [self.appDelegate.leftVC loadVC];
    [self.appDelegate.rightVC loadVC];
    // [self.appDelegate.centerVC loadVC];
    
    [self.appDelegate.centerViewController setBarBlue];
    self.appDelegate.slidePanelController.centerPanel =appDelegate.navigationControllerCenter;//(UIViewController*)self.appDelegate.centerViewController;
    
    
    [self setStatusBarStyleOwnApp:1];
    [self.appDelegate addRootVC:self.appDelegate.slidePanelController ];
    
    appDelegate.navigationControllerCenter.navigationBarHidden=NO;
    [self resetVC];
    
    
    
    [self.navigationController popViewControllerAnimated:NO];*/
    
     ///////////////  18/7/2014  /////////////
    
    [self hideHudView];
    NSLog(@"%@",appDelegate.aDef);
    [appDelegate.leftVC view];
    [self.appDelegate.leftVC loadVC];
    [self.appDelegate.rightVC loadVC];
    // [self.appDelegate.centerVC loadVC];
    [self.appDelegate createAndSetAllCenterNavController];
    [self.appDelegate.centerViewController setBarBlue];
    // self.appDelegate.slidePanelController.centerPanel =appDelegate.navigationControllerCenter;//(UIViewController*)self.appDelegate.centerViewController;
    ////  17/7/2014
    
    [self setStatusBarStyleOwnApp:1];
    [self.appDelegate addRootVC:self.appDelegate.slidePanelController ];
    
    appDelegate.navigationControllerCenter.navigationBarHidden=NO;
}

-(void)resetVC
{
    self.emailTxt.text=@"";
    self.passwrdTxt.text=@"";
    self.firstName.text=@"";
    self.lastName.text=@"";
    self.avatarimavw.image=self.noImage;
    isSelectedImage=0;
    self.crossbT.hidden=YES;;
}



-(void)hideHudViewHere
{
    [self hideHudView];
    [self.navigationController popViewControllerAnimated:YES];
    [self resetVC];
  
}


-(void)hideHudViewHereForLogin
{
    [self hideHudView];
//    [self showAlertMessage:[NSString stringWithFormat:@"Please activate verification link at %@. Be sure to check your spam folder and add us to your contacts",self.emailTxt.text]] ;
//    [self.navigationController popViewControllerAnimated:YES];
    self.popupAlertVw.hidden = NO;
    self.popupBackVw.hidden = NO;
    self.popupAlertLbl.text = [NSString stringWithFormat:@"Please activate verification link at %@",self.emailTxt.text];
    
   /*
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    [command setObject:self.emailTxt.text forKey:@"Username"];
    [command setObject:self.passwrdTxt.text forKey:@"Password"];
    [command setObject:[appDelegate.aDef objectForKey:UDID] forKey:@"IMEI"];
    self.requestDic=command;
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    
    [appDelegate sendRequestFor:LOGIN from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];*/
}










- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    isSelectedImage=1;
    if([info objectForKey:UIImagePickerControllerEditedImage])
     self.avatarimavw.image=[info objectForKey:UIImagePickerControllerEditedImage];
    else
       self.avatarimavw.image=[info objectForKey:UIImagePickerControllerOriginalImage];
    
    
      self.crossbT.hidden=NO;
     [self dismissModal];
}





- (IBAction)signInAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)popupAlertTapped:(UIButton *)sender {
    
    if (sender.tag==0) {
        sender.tag=1;
        NSMutableAttributedString *hintText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Please be sure to check your SPAM folder and add admin@sportsly.co to your contacts"]];
        
        [hintText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:16.0f], NSForegroundColorAttributeName:[UIColor colorWithRed:61.0/255.0 green:148.0/255.0 blue:212.0/255.0 alpha:1.0]} range:NSMakeRange(29, 4)];
        
        //Rest of text
        [hintText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:16.0f]} range:NSMakeRange(33, hintText.length - 33)];
        
        [self.popupAlertLbl setAttributedText:hintText];
        return;
//        Please be sure to check your spam folder and add admin@sportsly.co to your contacts
    }
    sender.tag=0;
    self.popupAlertVw.hidden = YES;
    self.popupBackVw.hidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)viewTapped:(id)sender
{
    [self.firstName resignFirstResponder];
    [self.lastName resignFirstResponder];
    [self.emailTxt resignFirstResponder];
    [self.passwrdTxt resignFirstResponder];
    [self.retypePassword resignFirstResponder];
}


@end
