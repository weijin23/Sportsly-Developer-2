//
//  FirstLoginViewController.m
//  Wall
//
//  Created by Mindpace on 14/04/14.
//
//
#import <Social/Social.h>
#import "RightViewController.h"
#import "LeftViewController.h"
#import "HomeVC.h"
#import "CenterViewController.h"
#import "SignUpViewController.h"
#import "LoginPageViewController.h"
#import "FirstLoginViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface FirstLoginViewController ()

@end

@implementation FirstLoginViewController
@synthesize isFacebook;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionStateOpen:) name:SESSIONSTATEOPEN object:nil];
    
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionStateOpenExtended:) name:SESSIONSTATEOPENEXTENDED object:nil];
   
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SESSIONSTATEOPEN object:nil];
    
      [[NSNotificationCenter defaultCenter] removeObserver:self name:SESSIONSTATEOPENEXTENDED object:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[self.tellAFriendBtn layer] setBorderWidth:1.0f];
    [[self.tellAFriendBtn layer] setCornerRadius:5.0f];
    [self.tellAFriendBtn.layer setBorderColor:[[UIColor colorWithRed:61.0/255.0 green:142.0/255.0 blue:212.0/255.0 alpha:1.0] CGColor]];
    
    
        [self setStatusBarStyleOwnApp:0];
    
    //// facebook sdk change 8th july
   /* if (self.isFacebook==1) {
        if (![[FBSession activeSession] isOpen])
        {
            [appDelegate openSessionWithAllowLoginUI:YES];
        }
        else
        {
            [self sessionStateOpen:nil];
        }
    }*/
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observeProfileChange:) name:FBSDKProfileDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observeTokenChange:) name:FBSDKAccessTokenDidChangeNotification object:nil];
    
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginAction:(id)sender
{
    if([sender tag]==1)
    {
    
        LoginPageViewController *loginViewController=[[LoginPageViewController alloc] initWithNibName:@"LoginPageViewController" bundle:nil];
        [self.navigationController pushViewController:loginViewController animated:YES];
    }
}

- (IBAction)signUpAction:(id)sender
{
    SignUpViewController *svc=[[SignUpViewController alloc]initWithNibName:@"SignUpViewController" bundle:nil];
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

- (IBAction)tellAFriendAction:(id)sender
{
    Class mailclass = (NSClassFromString(@"MFMailComposeViewController"));
    
    if (mailclass)
    {
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        
        mc.mailComposeDelegate = self;
        
        mc.navigationBar.tintColor = [UIColor colorWithRed:64.0/255.0 green:144.0/255.0 blue:219.0/255.0 alpha:1.0];
        NSString *msgSub=@"Check out the Sportsly App";
        
        
        NSString *msg1 = @"Hi,";
        NSString *msg2 = @"I just downloaded the Sportsly app and I think you should too! It will be a great way to organize and plan our team activities and provide:";
        NSString *msg3 = @"• An easy interface to create a team and add roster";
        NSString *msg4 = @"• Send game invites and track attendance";
        NSString *msg5 = @"• Wall to share team moments";
        NSString *msg6 = @"• Create lasting memories of team photos and videos";
        NSString *msg7 = @"Please download using the below links.";
        
        
        [mc setSubject:[NSString stringWithFormat:@"%@",msgSub]]; //
        NSString *strApp=@"https://itunes.apple.com/gb/app/sportsly-lets-play/id843696027?mt=8";
        NSString *strGoogle=@"https://play.google.com/store/apps/details?id=co.sportsly";
        NSString *UrlStr=[NSString stringWithFormat:@"<html><script language=\"javascript\">\
                          var timeout;\
                          function onDocumentLoaded() {\
                          var start = new Date();\
                          setTimeout(function() {\
                          if (new Date() - start > 2000) {\
                          return;\
                          }\
                          window.location = 'http://your-installation.url';\
                          }, 1000);\
                          }\
                          </script><body><p></p><p><a onClick=\"onDocumentLoaded()\" href='%@'>iTunes App Store</a></p><p><a onClick=\"onDocumentLoaded()\" href='\n%@'>Google Play Store</a></p></body>\
                          </html>",strApp,strGoogle];
        
        
        
        
        
        [mc setMessageBody:[NSString stringWithFormat:@"%@<br /><br />%@<br /><br />%@<br />%@<br />%@<br />%@<br /><br />%@<br />%@ ",msg1,msg2,msg3,msg4,msg5,msg6,msg7,UrlStr] isHTML:YES];
        
        
        
        [mc setToRecipients:nil];
        
        if([mailclass canSendMail])
        {
            [self presentViewController:mc animated:YES completion:nil];
            
        }
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    UIAlertView *mailAlert;
    switch (result)
    {
            
        case MFMailComposeResultCancelled:
        {
            NSLog(@"Mail cancelled");
            break;
        }
        case MFMailComposeResultSaved:
        {
            NSLog(@"Mail saved");
            mailAlert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Mail saved." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [mailAlert show];
            break;
        }
        case MFMailComposeResultSent:
        {
            NSLog(@"Mail sent");
            mailAlert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Mail sent." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            break;
        }
        case MFMailComposeResultFailed:
        {
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            mailAlert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Mail sent failure." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [mailAlert show];
            break;
        }
        default:
            break;
    }
    
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}


- (IBAction)facebookLoginAction:(id)sender
{
    //// facebook sdk change 8th july
    /*
    if (![[FBSession activeSession] isOpen])
    {
        [(AppDelegate*)[[UIApplication sharedApplication] delegate] openSessionWithAllowLoginUI:YES];
    }
    else
    {
        [self sessionStateOpen:nil];
    }*/
    
    if ([FBSDKAccessToken currentAccessToken])
    {
        [self observeProfileChange:nil];
    }
    else
    {
        NSString *requiredPermission = @"email";//, @"user_friends" ];
        
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logInWithReadPermissions:@[requiredPermission]
                                handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                    if (error)
                                    {
                                        // Process error
                                        //[self RemoveUserDefaultValueForKey:USERID];
                                    }
                                    else if (result.isCancelled)
                                    {
                                        // Handle cancellations
                                        //[self RemoveUserDefaultValueForKey:USERID];
                                    }
                                    else
                                    {
                                        // If you ask for multiple permissions at once, you
                                        // should check if specific permissions missing
                                        if ([result.grantedPermissions containsObject:requiredPermission])
                                        {
                                            // Do work
                                            
                                        }
                                    }
                                }];
    }
   
}

//// facebook sdk change 8th july
/*
-(void)getEmailIdForFacebookLogin:(ACAccount*)account
{
    
    
    
    [self showHudView:@"Connecting..."];
    
    
    NSURL *meurl = [NSURL URLWithString:@"https://graph.facebook.com/me"];
    
    SLRequest *merequest = [SLRequest requestForServiceType:SLServiceTypeFacebook
                                              requestMethod:SLRequestMethodGET
                                                        URL:meurl
                                                 parameters:nil];
    
    merequest.account = account;
    
    [merequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        [self hideHudView];
        
        NSString *meDataString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@", meDataString);
        if (error == nil && ((NSHTTPURLResponse *)urlResponse).statusCode == 200) {
            NSError *deserializationError;
            NSDictionary *userData = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&deserializationError];
            
            if (userData != nil && deserializationError == nil) {
                
                
                NSString *email = userData[@"email"];
                NSLog(@"%@", email);
                
                
                
                
               // [appDelegate facebookLoginForNativefacebookEmail:@"" facebookid:[[NSString alloc] initWithFormat:@"%@", [facebookAccount valueForKeyPath:@"properties.uid"]] facebookname:[facebookAccount valueForKeyPath:@"properties.ACPropertyFullName"]];
               NSArray *ar= [[account valueForKeyPath:@"properties.ACPropertyFullName"] componentsSeparatedByString:@" "];
                
                if(ar.count>1)
                [self loginWithFacebook:email :[ar objectAtIndex:0] :[ar objectAtIndex:1]:[[NSString alloc] initWithFormat:@"%@", [account valueForKeyPath:@"properties.uid"]]];
                else if(ar.count>0)
                    [self loginWithFacebook:email :[ar objectAtIndex:0] :@"":[[NSString alloc] initWithFormat:@"%@", [account valueForKeyPath:@"properties.uid"]]];
                else
                    [self loginWithFacebook:email :@"" :@"":[[NSString alloc] initWithFormat:@"%@", [account valueForKeyPath:@"properties.uid"]]];
                
            }
            else
            {
                [self showAlertMessage:@"Facebook Email-id not found"];
            }
        }
        else
        {
            [self showAlertMessage:@"Facebook Email-id not found"];
        }
        
        
    }];
}

///////////////////////////////

-(void)sessionStateOpen:(id)notiobject
{
    
    
    if(appDelegate.isFromAlbumForVideoPost)
    {
        return;
    }
    
    
    /////////////Created on 20/9/14
    if ([[FBSession activeSession] isOpen])
    {
        [self showHudView:@"Connecting..."];
        [self showNativeHudView];
        [self performSelector:@selector(fetchingUserData) withObject:nil afterDelay:0.0];
    }
    
}

-(void)sessionStateOpenExtended:(id)notiobject
{
    if(appDelegate.isFromAlbumForVideoPost)
    {
        return;
    }
    
  
    
    if ([[FBSession activeSession] isOpen])
    {
        [self showHudView:@"Connecting..."];
        [self showNativeHudView];
        [self performSelector:@selector(fetchingUserData) withObject:nil afterDelay:0.0];
    }
    
}

-(void)requestVideoPost
{
    NSArray* permissions = [[NSArray alloc] initWithObjects:
                            @"publish_stream", nil];
    
    [[FBSession activeSession] requestNewPublishPermissions:permissions defaultAudience:FBSessionDefaultAudienceEveryone completionHandler:^(FBSession *session, NSError *error) {
        
     
        
    }];
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
*/

#pragma mark - Facebook Observations

- (void)observeProfileChange:(NSNotification *)notfication
{
    if ([FBSDKProfile currentProfile])
    {
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"picture.type(large), email, first_name, last_name"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error)
             {
                 NSLog(@"fetched user:%@", result);
                 
                 NSString *fbID = [NSString stringWithFormat:@"%@",result[@"id"]];
                 NSString *fbEmailID = nil;
                 if (result[@"email"] == nil)
                 {
                     fbEmailID = @"";
                 }
                 else
                 {
                     fbEmailID = [NSString stringWithFormat:@"%@",result[@"email"]];
                 }
                 
                 NSString *fbFirstName = [NSString stringWithFormat:@"%@",result[@"first_name"]];
                 NSString *fbLastName = [NSString stringWithFormat:@"%@",result[@"last_name"]];
                 NSString *fbProfileImageLink = [NSString stringWithFormat:@"%@",result[@"picture"][@"data"][@"url"]];
                 
                 [self loginWithFacebook:fbEmailID :fbFirstName :fbLastName :fbID :fbProfileImageLink];
                 
             }
             else
             {
                 NSLog(@"FBError: %@",error);
             }
             
         }];
    }
}

- (void)observeTokenChange:(NSNotification *)notfication
{
    if (![FBSDKAccessToken currentAccessToken])
    {
        
    }
    else
    {
        [self observeProfileChange:nil];
    }
}


- (void)loginWithFacebook:(NSString *)emailstr :(NSString *)fstname :(NSString *)lastname :(NSString *)fid :(NSString *)profileImageLink
{
    
    NSLog(@"loginWithFacebook=%@----%@-----%@-----%@------%@",emailstr, fstname, lastname, fid, profileImageLink);
    
    
    if(![appDelegate.aDef objectForKey:ISLOGIN])
    {
        // NSString* tmp=nil;
        
        NSMutableDictionary *command = [NSMutableDictionary dictionary];
        
        [command setObject:emailstr forKey:@"Username"];
        [command setObject:[appDelegate.aDef objectForKey:UDID] forKey:@"IMEI"];
        [command setObject:@"F" forKey:@"reg_type"];
        [command setObject:fstname forKey:@"FirstName"];
        [command setObject:lastname forKey:@"LastName"];
        [command setObject:fid forKey:@"ID"];
        [command setObject:profileImageLink forKey:@"ProfileImage"];
        
        self.requestDic = command;
        
        
        SBJsonWriter *writer = [[SBJsonWriter alloc] init];
        
        NSString *jsonCommand = [writer stringWithObject:command];
        
        [command setObject:@"1" forKey:@"ISFACEBOOK"];
        [self showHudView:@"Connecting..."];
        [self showNativeHudView];
        NSLog(@"RequestParamJSON=%@",jsonCommand);
        
        
        [appDelegate sendRequestFor:LOGIN from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam1", nil]];
    }
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
    
    NSLog(@"Data=%@",str);
    
    ConnectionManager *aR=(ConnectionManager*)aData1;
    if([aR.requestSingleId isEqualToString:LOGIN])
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
                        
                        //ADDDEB
                        [appDelegate createEventStore];
                        //////
                        [appDelegate setUserDefaultValue:@"1" ForKey:ISLOGIN];
                        
                        [appDelegate setUserDefaultValue:[NSString stringWithFormat:@"%@", [aDict objectForKey:@"new_login"]] ForKey:NEWLOGIN];
                        
                        NSLog(@"%@ %@",[NSString stringWithFormat:@"%@", [aDict objectForKey:@"new_login"]],[appDelegate.aDef objectForKey:NEWLOGIN]);
                        
                        aDict=[aDict objectForKey:@"response"];
                        aDict=[aDict objectForKey:@"user_details"];
                        
                        
                        
                        NSString  *  tmp=@"";//[[self.passwrdTxt text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        
                    
                        
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
                        
                        
                        
                        
                        
                        [self showHudAlert:@"Login Successful"];
                         [self performSelector:@selector(hideHudViewHereLoginFinish) withObject:nil afterDelay:2.0];
                        
                       // [self hideHudViewHereLoginFinish];
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
    
    [self.appDelegate createAndSetAllCenterNavController];   ////  17/7/2014
    
    [self.appDelegate.centerViewController setBarBlue];
    // self.appDelegate.slidePanelController.centerPanel =appDelegate.navigationControllerCenter;//(UIViewController*)self.appDelegate.centerViewController;
    
    [self setStatusBarStyleOwnApp:1];
    [self.appDelegate addRootVC:self.appDelegate.slidePanelController ];
    
    appDelegate.navigationControllerCenter.navigationBarHidden=NO;
}


@end
