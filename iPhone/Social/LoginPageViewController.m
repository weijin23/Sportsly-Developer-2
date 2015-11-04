//
//  LoginPageViewController.m
//  Social
//
//  Created by Mindpace on 20/08/13.
//
//
#import "CenterViewController.h"
#import "MainInviteVC.h"
#import "LikeCommentData.h"
#import "HomeVC.h"
#import "SignUpViewController.h"
#import "LoginPageViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Invite.h"
#import "ForgotPasswordViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "LikesAndCommentsVC.h"
@interface LoginPageViewController ()

@end

@implementation LoginPageViewController
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
- (IBAction)backtof:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
      [self setStatusBarStyleOwnApp:0];
    
    
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
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionStateOpen:) name:SESSIONSTATEOPEN object:nil];
    
    
    [self.emailTxt becomeFirstResponder];
   
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   // [[NSNotificationCenter defaultCenter] removeObserver:self name:SESSIONSTATEOPEN object:nil];
    
      [self.emailTxt resignFirstResponder];
     [self.passwrdTxt resignFirstResponder];
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
    SignUpViewController *svc=[[SignUpViewController alloc]initWithNibName:@"SignUpViewController" bundle:nil];
    
    [self.navigationController pushViewController:svc animated:YES];
}

- (IBAction)signInBtn:(id)sender
{
    if([self.emailTxt isFirstResponder])
        [self.emailTxt resignFirstResponder];
    if([self.passwrdTxt isFirstResponder])
        [self.passwrdTxt resignFirstResponder];
    
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
            //errorstr =@"The email is invalid";
            errorstr =@"This email is not a registered account";
         
            if(errorstrtitle.length==0)
                errorstrtitle =@"";
           
        }
        
    }
    else
    {
          if(errorstr.length==0)
        errorstr=@"Please enter email";
        
    }
    
    [command setObject:tmp forKey:@"Username"];
    
    tmp=[[self.passwrdTxt text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    int flag=0;
    
    if ([tmp  isEqualToString:@""] )
    {
        
        
          if(errorstr.length==0)
        errorstr=@"Please enter password";
        
        
        flag++;
    }
    else
    {
        if ([tmp length  ]<6 )
        {
            
         
              if(errorstr.length==0)    
            errorstr=@"The password must be at least 6 characters long";
            
            flag++;
        }
    }
       
    
    
    [command setObject:tmp forKey:@"Password"];
    
    
    if([errorstr length]>INITIALERRORSTRINGLENGTH)
    {
        if(errorstrtitle.length==0)
            [self showAlertMessage:errorstr title:@""];
            else
                [self showAlertMessage:errorstr title:errorstrtitle];
        
        return;
    }
    
    
    [command setObject:[appDelegate.aDef objectForKey:UDID] forKey:@"IMEI"];
    [command setObject:@"N" forKey:@"reg_type"];
    
    self.requestDic=command;
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    
        [appDelegate sendRequestFor:LOGIN from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
}

-(void)notifyRequesterWithData:(id) aData :(id)aData1
{
    
    [self hideHudView];
    [self hideNativeHudView];
    
    if([aData isKindOfClass:[ConnectionManager class]])
    {
        ConnectionManager *aR=(ConnectionManager*)aData;
        if([aR.requestSingleId isEqualToString:LOGIN])
        {
            
        }
        return;
    }
    
    
    NSString *str=(NSString*)aData;
    
    NSLog(@"Dataaa=%@",str);
    
    
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
                    
                   ////ADDDEB
                    [appDelegate createEventStore];
                   //////
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
                    
                    NSArray *admindetails=[aDict objectForKey:@"admin_details"];//For Admin2
                    NSArray *playerdetails=[aDict objectForKey:@"player_details"];//For Player
                    NSArray *teamdetails=[aDict objectForKey:@"team_list"];////For Admin1
                    NSArray *lastTenInvites=[aDict objectForKey:@"last_ten_invites"];//For Coach
                    
                    NSArray *tendeleteevents=[aDict objectForKey:@"last_ten_delete_events"];// -Player or Primary
                    NSArray *tenupdateevents=[aDict objectForKey:@"last_ten_update_events"];// -Player or Primary
                    NSArray *tenplayerteamresponse=[aDict objectForKey:@"player_last_ten_invites"];// -Player
                    NSArray *tenprimaryteamresponse=[aDict objectForKey:@"primary_last_ten_invites"];// -Primary
                    
                    
                    NSArray *tenplayerteameventresponse=[aDict objectForKey:@"player_last_ten_events_invite"];// -Player
                    NSArray *tenprimaryteameventresponse=[aDict objectForKey:@"primary_last_ten_events_invite"];// Primary
                     NSArray *tencoachteameventresponse=[aDict objectForKey:@"coach_last_ten_events_invite"];//For Coach
                    
                    
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

                    
                    NSArray *invitefriendnotificationdetails=[aDict objectForKey:@"invitefrnd_push_notification"];//For Friend(Secondary User)
                    
                    
                      NSArray *primaryplayerdetails=[aDict objectForKey:@"primary_player_details"];//For Primary Player Details
                    
                    
                    
                
                    
                    
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
                    
                    
                    [self parseLikeAndComments:notificationdetails];//For Likes and Comment
                    }
                    
                    appDelegate.allHistoryLikesCounts=[notnumberstr longLongValue];
                      [appDelegate setUserDefaultValue:[NSNumber numberWithLongLong:appDelegate.allHistoryLikesCounts] ForKey:ALLHISTORYLIKECOUNTS ];
                    
                    
                    
                    
                    
   ///////////////////////////////////////////////////////////////////////////////////////////////////////////
                    
                    
                    
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
                        
                        
                        
                        if([teamDetails respondsToSelector:@selector(allKeys)])
                        {
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
                    }
                    
                    
 ////////////////////////////////////////////////////////////////////////////////////////////////////////////                   
                    
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
                    
                    
                    
                    
                    
                    [self showHudAlert:@"Login Successful"];
                    [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
                   
                    self.requestDic=nil;
                }
                else
                {
                    
                    if([[aDict objectForKey:@"message"] isEqualToString:@"Unregistered user."])
                      [self showAlertMessage:@"Login failed.  Invalid username or password. Please try again"];
                        else
                    [self showAlertMessage:[aDict objectForKey:@"message"] title:@"Login Failed"];
                }
            }
        }
        
    }
    
        
        
    
    
    
    
    
    
    
    
}



/*- (IBAction)facebookLoginAction:(id)sender
{
    
    
    if (![[FBSession activeSession] isOpen])
    {
        [appDelegate openSessionWithAllowLoginUI:YES];
    }
    else
    {
        [self sessionStateOpen:nil];
    }
    
    
    
    
    
  //  [FBRequestConnection startWithGraphPath:<#(NSString *)#> parameters:<#(NSDictionary *)#> HTTPMethod:<#(NSString *)#> completionHandler:<#^(FBRequestConnection *connection, id result, NSError *error)handler#>];
    
    //[FBRequest requestWithGraphPath:<#(NSString *)#> parameters:<#(NSDictionary *)#> HTTPMethod:<#(NSString *)#>];
}

-(void)sessionStateOpen:(id)notiobject
{
    
    
    
    
    
    if ([[FBSession activeSession] isOpen])
    {
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    [self performSelector:@selector(fetchingUserData) withObject:nil afterDelay:0.0];
    }
    
    
}

-(void)fetchingUserData
{
    
    [[FBRequest requestForMe] startWithCompletionHandler:
     ^(FBRequestConnection *connection,
       NSDictionary<FBGraphUser> *user,
       NSError *error) {
         [self hideHudView];
         [self hideNativeHudView];
         if (error)
         {
             [self showAlertMessage:@"Connection Failure! \nTry Again."];
         }
         else
         {
             
             NSString *email=  [user objectForKey:@"email"];
             
             
             if(([user objectForKey:@"first_name"] && (![[user objectForKey:@"first_name"] isEqualToString:@""])) &&  ([user objectForKey:@"last_name"] && (![[user objectForKey:@"last_name"] isEqualToString:@""])) )
                 [self loginWithFacebook:email :[user objectForKey:@"first_name"] :[user objectForKey:@"last_name"]:[user objectForKey:@"id"]];
             else if([user objectForKey:@"first_name"] && (![[user objectForKey:@"first_name"] isEqualToString:@""]))
             [self loginWithFacebook:email :[user objectForKey:@"first_name"] :@"":[user objectForKey:@"id"]];
             else if([user objectForKey:@"last_name"] && (![[user objectForKey:@"last_name"] isEqualToString:@""]))
                 [self loginWithFacebook:email :@"" :[user objectForKey:@"last_name"]:[user objectForKey:@"id"]];
             else
                   [self loginWithFacebook:email :@"" :@"":[user objectForKey:@"id"]];
             
         }
     }];
}




-(void)loginWithFacebook:(NSString*)emailstr :(NSString*)fstname :(NSString*)lastname :(NSString*)fid
{
    
    NSLog(@"loginWithFacebook=%@----%@-----%@",emailstr,fstname,lastname);
    
   
    if(![appDelegate.aDef objectForKey:ISLOGIN])
    {
   // NSString* tmp=nil;
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    
    
       
    [command setObject:emailstr forKey:@"Username"];
    
       
    
    
    //[command setObject:@"" forKey:@"Password"];
    
    
  
    
    
    [command setObject:[appDelegate.aDef objectForKey:UDID] forKey:@"IMEI"];
    
  
    
      [command setObject:fstname forKey:@"FirstName"];
          [command setObject:lastname forKey:@"LastName"];
    self.requestDic=command;
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    [command setObject:fid forKey:@"ID"];
    [command setObject:@"1" forKey:@"ISFACEBOOK"];
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    
    [appDelegate sendRequestFor:LOGIN from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam1", nil]];
    }
}

- (IBAction)backtof:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
*/

/*{
    
    Invite *dataEvent=nil;
    Invite *anObj = nil;
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:EVENTUNREAD inManagedObjectContext:self.managedObjectContext]];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"(eventId==%@) AND (userId==%@) AND (type==%i)",eId,[self.aDef objectForKey:LoggedUserID],5]];
    
    NSArray* ar =nil;
    ar= [self.managedObjectContext executeFetchRequest:request error:nil];
    if ([ar count]>=1)
    {
        anObj= (Invite *) [ar objectAtIndex:0];
    }
    
    
    dataEvent=anObj;
    
    ///////
    
    
    if(!dataEvent)
    {
        
        
        Invite   *eventvar = nil;
        eventvar= (Invite *)[NSEntityDescription insertNewObjectForEntityForName:EVENTUNREAD inManagedObjectContext:self.managedObjectContext];
}*/

-(void)hideHudViewHere
{
   /* [self hideHudView];
    
    [appDelegate.leftVC view];
    [self.appDelegate.leftVC loadVC];
    [self.appDelegate.rightVC loadVC];
     // [self.appDelegate.centerVC loadVC];
    
     [self.appDelegate.centerViewController setBarBlue];
    self.appDelegate.slidePanelController.centerPanel =appDelegate.navigationControllerCenter;//(UIViewController*)self.appDelegate.centerViewController;
    
    
    [self setStatusBarStyleOwnApp:1];
    [self.appDelegate addRootVC:self.appDelegate.slidePanelController ];
    
    appDelegate.navigationControllerCenter.navigationBarHidden=NO;
    [self resetVC];*/
    
    //////////   18/7/2014  ////////////////////
    
    [self hideHudView];
    NSLog(@"%@",appDelegate.aDef);
    [appDelegate.leftVC view];
    [self.appDelegate.leftVC loadVC];
    [self.appDelegate.rightVC loadVC];
    // [self.appDelegate.centerVC loadVC];
    
    [self.appDelegate createAndSetAllCenterNavController];   ////  17/7/2014
    
    [self.appDelegate.centerViewController setBarBlue];
    // self.appDelegate.slidePanelController.centerPanel =appDelegate.navigationControllerCenter;//(UIViewController*)self.appDelegate.centerViewController;
    
    [self setStatusBarStyleOwnApp:1];
    [self.appDelegate addRootVC:self.appDelegate.slidePanelController ];
    
    appDelegate.navigationControllerCenter.navigationBarHidden=NO;
    
        
}



- (IBAction)passwrdRcvrBtn:(id)sender
{
    ForgotPasswordViewController *fp=[[ForgotPasswordViewController alloc] initWithNibName:@"ForgotPasswordViewController" bundle:nil];
    
    
    [self.navigationController pushViewController:fp animated:YES];
}

- (IBAction)viewTapped:(id)sender
{
    [self.emailTxt resignFirstResponder];
    [self.passwrdTxt resignFirstResponder];
}

@end
