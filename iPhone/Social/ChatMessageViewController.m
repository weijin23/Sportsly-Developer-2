//
//  ChatMessageViewController.m
//  Wall
//
//  Created by Mindpace on 18/01/14.
//
//

#import "ChatMessageViewController.h"
#import "ChatMessageCell.h"
#import "UIImageView+AFNetworking.h"
#import "ChatViewController.h"
#import "CenterViewController.h"
#import "RightViewController.h"
#import "MessageVC.h"
#import "HomeVC.h"
#import "GroupMessageViewController.h"

@interface ChatMessageViewController ()

@end

@implementation ChatMessageViewController
@synthesize pendingMessage;
@synthesize userAllTeam,myAllFriend;
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
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nilDelegate:) name:CENTERVIEWONTROLLERSETNIL object:nil];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(groupChatUpdated:) name:GROUPMESSAGENOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNavigationControllerUpdated:) name:SHOWNAVIGATIONCONTROLLERCHATMESSAGE object:nil];
    [self.delegate didChangeNumberMessage:[NSString stringWithFormat:@"%d",self.appDelegate.allPendingMessage.count]];
    self.navigationController.delegate=self;
    if(self.isiPad)
        self.timeFont=[UIFont fontWithName:@"Helvetica" size:15.0];
    else
        self.timeFont=[UIFont fontWithName:@"Helvetica" size:10.0];
    
   }

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
 //   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNavigationControllerUpdated:) name:SHOWNAVIGATIONCONTROLLERCHATMESSAGE object:nil];
  
    
    [self getAllUserDetailsFoRUser];
    [self getUpdatedRegisterUserListing];
    
    if (self.appDelegate.allPendingMessage.count>0) {
        
        
        self.noMessageView.hidden=YES;
       // [self filterDuplicateUser];
        
    }else{
        
        if (appDelegate.messageUserList.count>0) {
            
            self.noMessageView.hidden=YES;
            
        }else{
            self.noMessageView.hidden=NO;
            
        }
        
        NSLog(@"frame %@",NSStringFromCGRect(self.view.bounds));
        
    }
    [self.messageListTable reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SHOWNAVIGATIONCONTROLLERCHATMESSAGE object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:GROUPMESSAGENOTIFICATION object:nil];
    
    
[[NSNotificationCenter defaultCenter] removeObserver:self name:CENTERVIEWONTROLLERSETNIL object:nil];
}


-(void)nilDelegate:(id)sender
{
    self.delegate=nil;
    
   
}

- (void)viewDidUnload {
    
    [self setMessageListTable:nil];
    [super viewDidUnload];
    
}
#pragma mark - ClassMethod

- (IBAction)back:(id)sender{
    
    [self.navigationController.view setHidden:YES];
    [appDelegate.centerViewController showNavController:appDelegate.navigationController];

}
- (IBAction)groupMessage:(id)sender {
    if (self.appDelegate.myFriendList.count>0){
        GroupMessageViewController *group=[[GroupMessageViewController alloc] initWithNibName:@"GroupMessageViewController" bundle:nil];
        [self.appDelegate.centerViewController presentViewControllerForModal:group];
        
    }
    else{
        self.viewTransparent.hidden=NO;
        self.viewAlert.hidden=NO;
    }
}

- (IBAction)singleMessage:(id)sender {
    
    MessageVC *messageVc=[[MessageVC alloc] initWithNibName:@"MessageVC" bundle:nil];
    [self.appDelegate.centerViewController presentViewControllerForModal:messageVc];
}

-(void)refreshChatMessageList{
    
    [self.delegate didChangeNumberMessage:[NSString stringWithFormat:@"%d",self.appDelegate.allPendingMessage.count]];
   
    if (self.appDelegate.allPendingMessage.count>0) {
        
        
        self.noMessageView.hidden=YES;
        [self filterDuplicateUser];

        
    }else{
        
       
        if (appDelegate.messageUserList.count>0) {
            
            self.noMessageView.hidden=YES;
            
        }else{
            
           self.noMessageView.hidden=NO;

        }
        
        [self filterDuplicateUser];

        
    }
    
}

-(void)filterDuplicateUser{
    
    if (self.getFilterUser) {
        
        self.getFilterUser=nil;
        self.getFilterUser=[[NSMutableArray alloc] init];
        
    }else{
        
        self.getFilterUser=[[NSMutableArray alloc] init];
    }
    
   
    
    if (self.appDelegate.allPendingMessage.count) {
        
        NSMutableArray *selectedIndex=[[NSMutableArray alloc] init];
        self.noMessageView.hidden=YES;
        
        [self.getFilterUser addObjectsFromArray:self.appDelegate.messageUserList];
        
        for (int i=0; i<self.appDelegate.allPendingMessage.count; i++) {
          
            NSString *reciverId=nil;
            NSString *groupId=nil;
            
            if(![[[self.appDelegate.allPendingMessage objectAtIndex:i] valueForKey:@"group_id"] isEqualToString:@""]){
                
                groupId=[[self.appDelegate.allPendingMessage objectAtIndex:i] valueForKey:@"group_id"];
                reciverId=@"";
                
            }else{
                
                reciverId=[[self.appDelegate.allPendingMessage objectAtIndex:i] valueForKey:@"sender"];
                groupId=@"";
            }
            
            
            
            for (int j=0; j<self.appDelegate.messageUserList.count; j++) {
                
                NSLog(@"message user list %@",self.appDelegate.messageUserList);
                NSLog(@"message user list user id %@",[[self.appDelegate.messageUserList objectAtIndex:j] valueForKey:@"UserID"]);

                
                if (![[[self.appDelegate.messageUserList objectAtIndex:j] valueForKey:@"group_id"] isEqualToString:@""] && ![groupId isEqualToString:@""]) {
                    
                    
                    if ([[[self.appDelegate.messageUserList objectAtIndex:j] valueForKey:@"group_id"] integerValue]==[groupId  integerValue]) {
                        
                        [selectedIndex addObject:[self.appDelegate.messageUserList objectAtIndex:j]];
                        break;
                        
                    }


                }
                
              else if ([[[self.appDelegate.messageUserList objectAtIndex:j] valueForKey:@"group_id"] isEqualToString:@""]) {
                  
                  if (![reciverId isEqualToString:@""]) {
                      
                      if ([[[self.appDelegate.messageUserList objectAtIndex:j] valueForKey:@"UserID"] integerValue]==[reciverId  integerValue]) {
                          
                          [selectedIndex addObject:[self.appDelegate.messageUserList objectAtIndex:j]];
                          break;
                          
                      }
                  }
                  

                }
                
            }
            
        }
        
        NSLog(@" selected index %@",selectedIndex);
        
        [self.getFilterUser removeObjectsInArray:selectedIndex];

      
        
    }
   else
   {
       
       [self.getFilterUser addObjectsFromArray:self.appDelegate.messageUserList];
       
       if (self.getFilterUser.count>0) {
           
           self.noMessageView.hidden=YES;
           
       }else{
           
           
            self.noMessageView.hidden=NO;

        }
           
       
    }
   
    [self.messageListTable reloadData];
}

- (IBAction)messageToplayer:(id)sender {
    
//    if (appDelegate.centerVC.dataArrayUpButtonsIds.count>0) {
//        
//        if (self.appDelegate.myFriendList.count>0) {
//            
//            MessageVC *messageVc=[[MessageVC alloc] initWithNibName:@"MessageVC" bundle:nil];
//            [self.appDelegate.centerViewController presentViewControllerForModal:messageVc];
//            
//        }else{
//            
//        }
//        
//    }else{
////        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"MyGameWall" message:@"You need to be part of a team to send message" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
////        [alert show];
//    }
   
  }

#pragma mark - GroupCahtMessage

-(void)collectDataForGroupChat:(NSString*)groupId
{
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    NSDictionary *command=  [NSDictionary dictionaryWithObjectsAndKeys:groupId,@"group_id",[appDelegate.aDef objectForKey:LoggedUserID],@"UserID",nil];
    NSString *jsonCommand = [writer stringWithObject:command];
    
    NSLog(@"RequestParamJSON=%@=====%@",jsonCommand,command);
    
    SingleRequest *sinReq=[[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:GROUPCHATMESSAGELINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
    // self.sinReq1=sinReq;
    // [self.storeCreatedRequests addObject:self.sinReq1];
    sinReq.notificationName=GROUPMESSAGENOTIFICATION;
    [sinReq startRequest];
    
}


-(void)groupChatUpdated:(id)sender
{
    
    SingleRequest *sReq=(SingleRequest*)[sender object];
    if([sReq.notificationName isEqualToString:GROUPMESSAGENOTIFICATION])
    {
        if(sReq.responseData)
        {
            
            if (sReq.responseString)
            {
                SBJsonParser *parser=[[SBJsonParser alloc] init];
                
                id res = [parser objectWithString:sReq.responseString];
                if ([res isKindOfClass:[NSDictionary class]])
                {
                    NSDictionary* aDict = (NSDictionary*) res;
                    if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
                    {
                        
                        NSLog(@"group message details %@",aDict);
                        if (self.appDelegate.allPendingMessage) {
                            
                            NSPredicate *predicated=[NSPredicate predicateWithFormat:@"group_id='%@'",[[aDict objectForKey:@"group_message_details"] valueForKey:@"group_id"]];
                            NSArray *arr=[self.appDelegate.allPendingMessage filteredArrayUsingPredicate:predicated];
                            if (arr.count==0) {
                                
                                  [self.appDelegate.allPendingMessage addObject:[aDict objectForKey:@"group_message_details"]];
                                
                            }else{
                                [self.appDelegate.allPendingMessage removeObjectsInArray:arr];
                                [self.appDelegate.allPendingMessage addObject:[aDict objectForKey:@"group_message_details"]];
                            }
                          
                            
                        }else{
                            self.appDelegate.allPendingMessage=[[NSMutableArray alloc] init];
                            [self.appDelegate.allPendingMessage addObject:[aDict objectForKey:@"group_message_details"]];
                        }
                        
                        [self refreshChatMessageList];

                    }
                    else
                    {
                        
                    }
                    
                }
                
            }
        }
        else
        {
            
            
        }
    }
    else
    {
        
    }
    
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
       // self.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_arrow.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleLeftPanel:)];
        self.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"wallleftslide.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleLeftPanel:)];
    }
    
    if(!self.rightBarButtonItem)
    {
        self.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"new_message.png"] style:UIBarButtonItemStylePlain target:self action:@selector(groupMessage:)];
        //appDelegate.centerViewController.navigationItem.rightBarButtonItem=self.rightBarButtonItem;
    }
    
    self.appDelegate.centerViewController.navigationItem.title=@"Messages";
    appDelegate.centerViewController.navigationItem.leftBarButtonItem=self.leftBarButtonItem;
    
    [self setRightBarButton];
    
    
    [self setStatusBarStyleOwnApp:1];
    
    //// AD...iAd
    self.adBanner.delegate = self;
    self.adBanner.alpha = 0.0;
    self.canDisplayBannerAds=YES;
    ////
    
}

-(void)toggleLeftPanel:(id)sender
{
    /////  change message to roster  18/02/2015 /////
    
   // [appDelegate.slidePanelController showLeftPanelAnimated:YES];
    
    [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationController];
    
    self.appDelegate.centerViewController.timelineimavw.image=self.appDelegate.centerViewController.timelineimasel;
    self.appDelegate.centerViewController.fsttablab.textColor=self.appDelegate.themeCyanColor;
    
    ///////////////////////
}


-(void)setRightBarButton
{
    
    if(self.navigationController.view.hidden==NO)
    {
        if([[self.navigationController.viewControllers lastObject] isMemberOfClass:[self class]])
        {
            
            if (self.appDelegate.myFriendList.count>0){
                
                self.myMessageView.hidden=YES;
                appDelegate.centerViewController.navigationItem.rightBarButtonItem=self.rightBarButtonItem;
            }else{
                appDelegate.centerViewController.navigationItem.rightBarButtonItem=self.rightBarButtonItem;
                self.myMessageView.hidden=YES;
                
            }
        }
    }
}


#pragma mark - NavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SHOWNAVIGATIONCONTROLLERCHATMESSAGE object:nil];
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}


#pragma mark - UserDetails

-(void)getAllUserDetailsFoRUser{
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    
    [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
    //    [command setObject:@"0" forKey:@"start"];
    //     [command setObject:@"20" forKey:@"limit"];
    //    [command setObject:@"" forKey:@"search"];
    
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    //[self showHudView:@"Connecting..."];
    [self showNativeHudView];
    
    NSURL* url = [NSURL URLWithString:USERLISTLINK];
    
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
    // [self hideActiveIndicatorOwnPost];
    [self hideNativeHudView];
    [self hideHudView];
    
    NSString *str=[request responseString];
    NSLog(@"Data=%@",str);
    
    
    if (str)
    {
        SBJsonParser *parser=[[SBJsonParser alloc] init];
        
        id res = [parser objectWithString:str];
        if ([res isKindOfClass:[NSDictionary class]])
        {
            NSDictionary* aDict = (NSDictionary*) res;
            
            NSMutableArray *userList=[[NSMutableArray alloc] init];
            
            NSArray *group=[[[aDict objectForKey:@"response"] objectForKey:@"user_details"] objectForKey:@"group_chat"];
            NSArray *single=[[[aDict objectForKey:@"response"] objectForKey:@"user_details"] objectForKey:@"single_chat"];
            
            if (group) {
                for (int i=0; i<group.count; i++) {
                    
                    NSMutableDictionary *dict=[[group objectAtIndex:i] mutableCopy];
                    
                    NSDate *dd= [appDelegate.dateFormatFullOriginalComment dateFromString:[dict objectForKey:@"adddate"]];
                    [dict setObject:dd forKey:@"adddate"];
                    [userList addObject:dict];
                }
 
            }
            
            if (single) {
                for (int i=0; i<single.count; i++) {
                    
                    NSMutableDictionary *dict=[[single objectAtIndex:i] mutableCopy];
                    NSDate *dd= [appDelegate.dateFormatFullOriginalComment dateFromString:[dict objectForKey:@"adddate"]];
                    [dict setObject:dd forKey:@"adddate"];
                    [userList addObject:dict];

                }
            }

            NSSortDescriptor *sortDescriptor=[NSSortDescriptor sortDescriptorWithKey:@"adddate" ascending:NO];
            
            self.appDelegate.messageUserList=[userList sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
            NSLog(@"message user list %@", self.appDelegate.messageUserList);
            
            [self filterDuplicateUser];
        }
    }
    
    
	
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    
    [self hideNativeHudView];
    [self hideHudView];
	//[self showAlertMessage:CONNFAILMSG];ChAfter
	
}


#pragma mark - GetRegisterUserListing

-(void)getUpdatedRegisterUserListing{
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    [command setObject:[self.appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
    [command setObject:@"2" forKey:@"case"];
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    NSString *jsonCommand = [writer stringWithObject:command];
    [self showNativeHudView];
    [self sendRequestForTeamData:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];

}


-(void)sendRequestForTeamData:(NSDictionary*)dic
{
    
    NSURL* url = [NSURL URLWithString:TEAMROSTERLINK];
    
    ASIFormDataRequest *aRequest=  [[ASIFormDataRequest alloc ] initWithURL:url];
    self.myFormRequest1=aRequest;
    [self.storeCreatedRequests addObject:self.myFormRequest1];
    [aRequest setShouldContinueWhenAppEntersBackground:YES];
    
    [aRequest setDelegate:self];
    [aRequest setValidatesSecureCertificate:NO];
    [ASIFormDataRequest setShouldThrottleBandwidthForWWAN:YES];
    
    
    if([[dic allKeys] count]>0)
    {
        
        
        for(int i=0;i<[[dic allKeys] count];i++)
        {
            NSLog(@"RequestParam=%@",[[dic allKeys] objectAtIndex:i]);
            
            if([[dic objectForKey:[[dic allKeys] objectAtIndex:i]] isKindOfClass:[NSData class]])
            {
                [aRequest setPostFormat:ASIMultipartFormDataPostFormat];
                [aRequest addRequestHeader:@"Content-Type" value:@"multipart/form-data"];
                
                
                if([[[dic allKeys] objectAtIndex:i] isEqualToString:@"video"])
                {
                    [aRequest addData:[dic objectForKey:[[dic allKeys] objectAtIndex:i]] withFileName:@"user" andContentType:@"video/*" forKey:[[dic allKeys] objectAtIndex:i]];
                }
                else
                {
                    [aRequest addData:[dic objectForKey:[[dic allKeys] objectAtIndex:i]] withFileName:@"user.jpg" andContentType:@"image/*" forKey:[[dic allKeys] objectAtIndex:i]];
                    
                }
            }
            else
            {
                NSLog(@"RequestParam=%@ and Key=%@",[dic objectForKey:[[dic allKeys] objectAtIndex:i]],[[dic allKeys] objectAtIndex:i]);
                [aRequest addPostValue:[dic objectForKey:[[dic allKeys] objectAtIndex:i]] forKey:[[dic allKeys] objectAtIndex:i]];
                
                
            }
            
            
        }
        
        
    }
    [aRequest setDidFinishSelector:@selector(RegisterUserRequestFinished:)];
    [aRequest setDidFailSelector:@selector(RegisterUserRequestFailed:)];
    
    [aRequest startAsynchronous];
    
}


- (void)RegisterUserRequestFinished:(ASIHTTPRequest *)request
{
    
    [self hideNativeHudView];
    NSString *str=[request responseString];
    
    NSLog(@"Data=%@",str);
    
    
    if(str)
        
    {
        SBJsonParser *parser=[[SBJsonParser alloc] init];
        
        id res = [parser objectWithString:str];
        if ([res isKindOfClass:[NSDictionary class]  ])
        {
            NSDictionary* aDict = (NSDictionary*) res;
            
            
           self.userAllTeam=[NSMutableArray arrayWithArray:[[[aDict objectForKey:@"response"] objectForKey:@"users_team"] objectForKey:@"team_list"]];
            
            NSLog(@"user team list Message %@", self.userAllTeam);
            
            /// get friendlist
            
            self.myAllFriend=[[NSMutableArray alloc] init];
            
            
            if (!self.appDelegate.myFriendList) {
                
                self.appDelegate.myFriendList=[[NSMutableArray alloc] init];
            }else{
                [self.appDelegate.myFriendList removeAllObjects];
                [self.myAllFriend removeAllObjects];
            }
            
            
            
            for (int j=0;j< self.userAllTeam.count;j++) {
                
                
                
                NSDictionary *dict=[self.userAllTeam objectAtIndex:j];
                NSMutableDictionary *coachDict=[[NSMutableDictionary alloc] init];
                [coachDict setObject:[dict objectForKey:@"creator_name"] forKey:@"player_name"];
                [coachDict setObject:[dict objectForKey:@"coach_id"] forKey:@"UserID"];
                [coachDict setObject:[dict objectForKey:@"Coach_ProfileImage"] forKey:@"ProfileImage"];
                
                if (j==0) {
                    
                    if (![[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[dict objectForKey:@"coach_id"]]){
                        
                        [self.myAllFriend  addObject:coachDict];
                    }
                    
                }else{
                    
                    if (![[[self.userAllTeam objectAtIndex:j] valueForKeyPath:@"coach_id"] isEqualToString:[[self.userAllTeam objectAtIndex:j - 1] valueForKeyPath:@"coach_id"]]){
                        
                        if (![[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[dict objectForKey:@"coach_id"]]){
                            
                            [self.myAllFriend  addObject:coachDict];
                        }
                        
                    }
                    
                }
                
                
                ////// coach 2
                
                
                if ([dict objectForKey:@"coach_id2"] && ![[dict objectForKey:@"coach_id2"] isEqualToString:@""] && ![[dict objectForKey:@"creator_name2"] isEqualToString:@""]) {
                    
                    NSMutableDictionary *coachDict2=[[NSMutableDictionary alloc] init];
                    [coachDict2 setObject:[dict objectForKey:@"creator_name2"] forKey:@"player_name"];
                    [coachDict2 setObject:[dict objectForKey:@"coach_id2"] forKey:@"UserID"];
                    [coachDict2 setObject:[dict objectForKey:@"coach2_img"] forKey:@"ProfileImage"];
                    
                    
                    if (j==0) {
                        
                        if (![[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[dict objectForKey:@"coach_id2"]]){
                            
                            [self.myAllFriend  addObject:coachDict2];
                        }
                        
                    }else{
                        
                        if (![[[self.userAllTeam objectAtIndex:j] valueForKeyPath:@"coach_id2"] isEqualToString:[[self.userAllTeam objectAtIndex:j - 1] valueForKeyPath:@"coach_id2"]]){
                            
                            if (![[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[dict objectForKey:@"coach_id2"]]){
                                
                                [self.myAllFriend  addObject:coachDict2];
                            }
                            
                        }
                        
                    }

                }
              
                
                
                NSArray * filterPlayer=[dict objectForKey:@"player_details"];
                NSPredicate *sPredicate = [NSPredicate predicateWithFormat:@"UserID!='0'"];
                
                filterPlayer= [NSMutableArray arrayWithArray:[filterPlayer
                                                              filteredArrayUsingPredicate:sPredicate]];
                
                for (int i=0; i<filterPlayer.count; i++) {
                    
                    if (![[[filterPlayer objectAtIndex:i] objectForKey:@"UserID"] isEqualToString:@""] && ![[[filterPlayer objectAtIndex:i] objectForKey:@"player_name"] isEqualToString:@""]) {
                    
                        NSMutableDictionary *playerDict=[[NSMutableDictionary alloc] init];
                        [playerDict setObject:[[filterPlayer objectAtIndex:i] objectForKey:@"player_name"] forKey:@"player_name"];
                        [playerDict setObject:[[filterPlayer objectAtIndex:i] objectForKey:@"UserID"] forKey:@"UserID"];
                        [playerDict setObject:[[filterPlayer objectAtIndex:i] objectForKey:@"ProfileImage"] forKey:@"ProfileImage"];
                        
                        if (![[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[[filterPlayer objectAtIndex:i] objectForKey:@"UserID"]]){
                            
                            [self.myAllFriend  addObject:playerDict];
                        }
                    }
                    
                    if (![[[filterPlayer objectAtIndex:i] objectForKey:@"UserID2"] isEqualToString:@""] && ![[[filterPlayer objectAtIndex:i] objectForKey:@"Name2"] isEqualToString:@""]) {
                        
                        NSMutableDictionary *playerDict=[[NSMutableDictionary alloc] init];
                        [playerDict setObject:[[filterPlayer objectAtIndex:i] objectForKey:@"Name2"] forKey:@"player_name"];
                        [playerDict setObject:[[filterPlayer objectAtIndex:i] objectForKey:@"UserID2"] forKey:@"UserID"];
                        [playerDict setObject:[[filterPlayer objectAtIndex:i] objectForKey:@"ProfileImage2"] forKey:@"ProfileImage"];
                        
                        if (![[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[[filterPlayer objectAtIndex:i] objectForKey:@"UserID2"]]){
                            [self.myAllFriend  addObject:playerDict];
                        }
                        
                        
                        
                    }
                    
                    if (![[[filterPlayer objectAtIndex:i] objectForKey:@"UserID3"] isEqualToString:@""] && ![[[filterPlayer objectAtIndex:i] objectForKey:@"Name3"] isEqualToString:@""]) {
                        
                        NSMutableDictionary *playerDict=[[NSMutableDictionary alloc] init];
                        [playerDict setObject:[[filterPlayer objectAtIndex:i] objectForKey:@"Name3"] forKey:@"player_name"];
                        [playerDict setObject:[[filterPlayer objectAtIndex:i] objectForKey:@"UserID3"] forKey:@"UserID"];
                        [playerDict setObject:[[filterPlayer objectAtIndex:i] objectForKey:@"ProfileImage3"] forKey:@"ProfileImage"];
                        
                        if (![[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[[filterPlayer objectAtIndex:i] objectForKey:@"UserID3"]]){
                            
                            [self.myAllFriend  addObject:playerDict];
                        }
                        
                        
                        
                    }
                    
                    
                    ///secondary player details
                    
                    if (![[[filterPlayer objectAtIndex:i] objectForKey:@"secondary_player"] isKindOfClass:[NSNull class]]) {
                        
                      NSArray  *secondaryPlayer =[[filterPlayer objectAtIndex:i] objectForKey:@"secondary_player"];
                        
                        for (int k=0; k<secondaryPlayer.count; k++) {
                            
                            
                            if ([[secondaryPlayer objectAtIndex:k] respondsToSelector:@selector(objectForKey:)]) {
                                
                            if (![[[secondaryPlayer objectAtIndex:k] objectForKey:@"UserID"] isEqualToString:@""] && ![[[secondaryPlayer objectAtIndex:k] objectForKey:@"player_name"] isEqualToString:@""]) {
                                
                                NSMutableDictionary *playerDict=[[NSMutableDictionary alloc] init];
                                [playerDict setObject:[[secondaryPlayer objectAtIndex:k] objectForKey:@"player_name"] forKey:@"player_name"];
                                [playerDict setObject:[[secondaryPlayer objectAtIndex:k] objectForKey:@"UserID"] forKey:@"UserID"];
                                [playerDict setObject:[[secondaryPlayer objectAtIndex:k] objectForKey:@"ProfileImage"] forKey:@"ProfileImage"];
                                
                                if (![[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[[secondaryPlayer objectAtIndex:k] objectForKey:@"UserID"]]){
                                    
                                    [self.myAllFriend  addObject:playerDict];
                                }
                            }
                                
                                if (![[[secondaryPlayer objectAtIndex:k] objectForKey:@"UserID2"] isEqualToString:@""]&& ![[[secondaryPlayer objectAtIndex:k] objectForKey:@"Name2"] isEqualToString:@""]) {
                                    
                                    NSMutableDictionary *playerDict=[[NSMutableDictionary alloc] init];
                                    [playerDict setObject:[[secondaryPlayer objectAtIndex:k] objectForKey:@"Name2"] forKey:@"player_name"];
                                    [playerDict setObject:[[secondaryPlayer objectAtIndex:k] objectForKey:@"UserID2"] forKey:@"UserID"];
                                    [playerDict setObject:[[secondaryPlayer objectAtIndex:k] objectForKey:@"ProfileImage2"] forKey:@"ProfileImage"];
                                    
                                    if (![[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[[secondaryPlayer objectAtIndex:k] objectForKey:@"UserID2"]]){
                                        [self.myAllFriend  addObject:playerDict];
                                    }
                                    
                                    
                                    
                                }
                                
                                if (![[[secondaryPlayer objectAtIndex:k] objectForKey:@"UserID3"] isEqualToString:@""] && ![[[secondaryPlayer objectAtIndex:k] objectForKey:@"Name3"] isEqualToString:@""]) {
                                    
                                    NSMutableDictionary *playerDict=[[NSMutableDictionary alloc] init];
                                    [playerDict setObject:[[secondaryPlayer objectAtIndex:k] objectForKey:@"Name3"] forKey:@"player_name"];
                                    [playerDict setObject:[[secondaryPlayer objectAtIndex:k] objectForKey:@"UserID3"] forKey:@"UserID"];
                                    [playerDict setObject:[[secondaryPlayer objectAtIndex:k] objectForKey:@"ProfileImage3"] forKey:@"ProfileImage"];
                                    
                                    if (![[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[[secondaryPlayer objectAtIndex:k] objectForKey:@"UserID3"]]){
                                        
                                        [self.myAllFriend  addObject:playerDict];
                                    }
                                    
                                    
                                    
                                }
                            }
                            
                        }
                        
                     
                            
                        }
                        
                    
                  

                    
                }
                
                NSArray * filterSecondaryPlayer=[dict objectForKey:@"Secondary_Players"];
                for (int i=0; i<filterSecondaryPlayer.count; i++) {
                    
                    if (![[[filterSecondaryPlayer objectAtIndex:i] objectForKey:@"UserID"] isEqualToString:@""] && ![[[filterSecondaryPlayer objectAtIndex:i] objectForKey:@"user_name"] isEqualToString:@""]) {
                        
                        NSMutableDictionary *playerDict=[[NSMutableDictionary alloc] init];
                        [playerDict setObject:[[filterSecondaryPlayer objectAtIndex:i] objectForKey:@"user_name"] forKey:@"player_name"];
                        [playerDict setObject:[[filterSecondaryPlayer objectAtIndex:i] objectForKey:@"UserID"] forKey:@"UserID"];
                        [playerDict setObject:[[filterSecondaryPlayer objectAtIndex:i] objectForKey:@"ProfileImage"] forKey:@"ProfileImage"];
                        
                        if (![[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[[filterSecondaryPlayer objectAtIndex:i] objectForKey:@"UserID"]]){
                            
                            [self.myAllFriend  addObject:playerDict];
                        }
                    }
                }
                
            }
            
            NSLog(@"Total Friend list%@",self.myAllFriend);
            
//            NSSortDescriptor *alphaSort = [NSSortDescriptor sortDescriptorWithKey:@"player_name" ascending:YES];
//            self.myAllFriend= [[ self.myAllFriend   sortedArrayUsingDescriptors:[NSArray arrayWithObject:alphaSort]] mutableCopy];
            
            for (int i=0; i<self.myAllFriend.count; i++) {
                
                if (i==0) {
                    
                    [self.appDelegate.myFriendList addObject:[self.myAllFriend objectAtIndex:i]];
                    
                }else{
                    
                    int flag=1;
                    
                    for (int j=0; j<self.appDelegate.myFriendList.count; j++) {
                        
                        if ([[[self.myAllFriend objectAtIndex:i] objectForKey:@"UserID"] isEqualToString:[[self.appDelegate.myFriendList objectAtIndex: j] objectForKey:@"UserID"]]){
                            
                            flag=0;
                            break;
                            
                        }
                        
                    }
                    
                    if (flag) {
                        
                        [self.appDelegate.myFriendList addObject:[self.myAllFriend objectAtIndex:i]];
                    }
                    
                    
                }
                
            }
            NSLog(@"my friend list %@",self.appDelegate.myFriendList);
            NSSortDescriptor *alphaSort = [NSSortDescriptor sortDescriptorWithKey:@"player_name" ascending:YES];
            self.appDelegate.myFriendList= [[ self.appDelegate.myFriendList   sortedArrayUsingDescriptors:[NSArray arrayWithObject:alphaSort]] mutableCopy];
           
            /*if (self.appDelegate.myFriendList.count>0){
                appDelegate.centerViewController.navigationItem.rightBarButtonItem=self.rightBarButtonItem;
                //self.myMessageView.hidden=NO;
                
            }else{
                appDelegate.centerViewController.navigationItem.rightBarButtonItem=nil;
                self.myMessageView.hidden=YES;
                
            }*/
            
        }
    }
}


- (void)RegisterUserRequestFailed:(ASIHTTPRequest *)request
{
    [self hideNativeHudView];
	NSLog(@"Error receiving dataImage : %@ ",[request.error description]);
	//[self showAlertMessage:CONNFAILMSG];ChAfter
    
}




#pragma mark - TableViewDelegate Datasourace
#pragma mark - UITableViewDatasourace

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.getFilterUser.count!=0 || self.appDelegate.allPendingMessage.count!=0) {
        return 2;
    }{
        return 0;
    }
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
        return self.appDelegate.allPendingMessage.count;

    }else{
        
        return self.getFilterUser.count;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isiPad) {
        return 70.0;
    }
    return 50.0f;
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"ChatMessageCell";
    
    ChatMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell=[ChatMessageCell chatMessageCustomCell];
        cell.backView.layer.cornerRadius=3.0f;
        cell.dateLbl.textColor=self.lightgraycolor;
        cell.dateLbl.font= self.timeFont;
        tableView.separatorColor=self.lightgraycolor;
    }
    //cell.messageLbl.text=[[self.messageList objectAtIndex:indexPath.row] valueForKey:@"message"];
  
    
    if (indexPath.section==0) {
        
        cell.backView.backgroundColor=[self colorWithHexString:@"F6F6F6"];
        
        cell.statusImageView.hidden=YES;
        NSString *imgUrl= [NSString stringWithFormat:@"%@%@",IMAGELINK,[[self.appDelegate.allPendingMessage objectAtIndex:indexPath.row] valueForKey:@"ProfileImage"]];
        [cell.profileImage cleanPhotoFrame];

         if ([[[self.appDelegate.allPendingMessage objectAtIndex:indexPath.row] valueForKey:@"group_id"] isEqualToString:@""]) {
        
            if ((![[[self.appDelegate.allPendingMessage objectAtIndex:indexPath.row] valueForKey:@"ProfileImage"] isEqualToString:@""]) && [[self.appDelegate.allPendingMessage objectAtIndex:indexPath.row] valueForKey:@"ProfileImage"] ) {
                
                  [cell.profileImage applyPhotoFrame];
                  [cell.profileImage setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:self.noImage];
                
            }else{
                [cell.profileImage setImage:self.noImage];
            }
        
         }else{
             [cell.profileImage setImage:self.noImage];

         }
      
        
        int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
        
        NSDate *datetime=   [[self.appDelegate.dateFormatFullOriginalComment dateFromString:[[self.appDelegate.allPendingMessage objectAtIndex:indexPath.row] valueForKey:@"adddate"]] dateByAddingTimeInterval:difftime] ;
        
        cell.nameLbl.text=[[self.appDelegate.allPendingMessage objectAtIndex:indexPath.row] valueForKey:@"sender_name"];
       
        
        cell.messageLbl.text=[[self.appDelegate.allPendingMessage objectAtIndex:indexPath.row] valueForKey:@"message"];
        
       
//        cell.dateLbl.text=[self getDateTimeForHistoryWithoutDate:datetime ];
        cell.dateLbl.text=[self getDateForHistoryWithoutDate:datetime ];
        

    }else{
       
         cell.backView.backgroundColor=[UIColor whiteColor];
        cell.statusImageView.hidden=YES;
        cell.nameLbl.text=[[[self.getFilterUser objectAtIndex:indexPath.row] valueForKey:@"Name"] stringByReplacingOccurrencesOfString:@"," withString:@", "];
        
        NSString *imgUrl= [NSString stringWithFormat:@"%@%@",IMAGELINK,[[self.getFilterUser objectAtIndex: indexPath.row]  valueForKey:@"ProfileImage"]];
        
          [cell.profileImage cleanPhotoFrame];
        
        
        
        if ((![[[self.getFilterUser objectAtIndex: indexPath.row]  valueForKey:@"ProfileImage"] isEqualToString:@""]) && [[self.getFilterUser objectAtIndex: indexPath.row]  valueForKey:@"ProfileImage"]) {
            
            
            [cell.profileImage applyPhotoFrame];
            [cell.profileImage setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:self.noImage];
            
        }else{
            [cell.profileImage setImage:self.noImage];
        }
        
        if ([[[self.getFilterUser objectAtIndex: indexPath.row]  valueForKey:@"chat_type"] isEqualToString:@"group"]) {
            [cell.profileImage setImage:[UIImage imageNamed:@"group_chat.png"]];
        }

        
        cell.messageLbl.text=[[self.getFilterUser objectAtIndex:indexPath.row] valueForKey:@"last_message"];
        
        if (![[[self.getFilterUser objectAtIndex:indexPath.row] valueForKey:@"sender"] isEqualToString:[appDelegate.aDef objectForKey:LoggedUserID]]) {
            cell.messageLbl.textColor=[UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0];
        }
               
        int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
        
        NSString *str=[self.appDelegate.dateFormatFullOriginalComment stringFromDate:[[self.getFilterUser objectAtIndex:indexPath.row] valueForKey:@"adddate"]];
        
        NSDate *datetime=   [[self.appDelegate.dateFormatFullOriginalComment dateFromString:str] dateByAddingTimeInterval:difftime] ;
        
        if ([str isEqualToString:@""]) {
            
            cell.dateLbl.text=@"";
            
        }else{
            
//            cell.dateLbl.text=[self getDateTimeForHistoryWithoutDate:datetime ];
            cell.dateLbl.text=[self getDateForHistoryWithoutDate:datetime ];
        }

    }
    
    return cell;
}

#pragma mark - UITableViewDelgate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        
        ChatViewController *fVC=[[ChatViewController alloc] initWithNibName:@"ChatViewController" bundle:nil];
        
        if ([[[self.appDelegate.allPendingMessage objectAtIndex:indexPath.row] valueForKey:@"group_id"] isEqualToString:@""]) {
            
              fVC.reciverUserId=[[self.appDelegate.allPendingMessage objectAtIndex:indexPath.row] valueForKey:@"sender"];
              fVC.groupId=[[self.appDelegate.allPendingMessage objectAtIndex:indexPath.row] valueForKey:@"group_id"];
        }else{
            
            fVC.reciverUserId=[[self.appDelegate.allPendingMessage objectAtIndex:indexPath.row] valueForKey:@"group_member"];
            fVC.groupId=[[self.appDelegate.allPendingMessage objectAtIndex:indexPath.row] valueForKey:@"group_id"];
        }

        
        fVC.reciverName= [[self.appDelegate.allPendingMessage objectAtIndex:indexPath.row] valueForKey:@"sender_name"];
        
        fVC.isList=1;
        [self.appDelegate.centerViewController presentViewControllerForModal:fVC];

        
        
        [self.appDelegate.allPendingMessage removeObjectAtIndex:indexPath.row];
        [self.delegate didChangeNumberMessage:[NSString stringWithFormat:@"%d",self.appDelegate.allPendingMessage.count]];
    }else{
        
        ChatViewController *fVC=[[ChatViewController alloc] initWithNibName:@"ChatViewController" bundle:nil];
        
        if ([[[self.getFilterUser objectAtIndex:indexPath.row] valueForKey:@"group_id"] isEqualToString:@""]){
            
             fVC.reciverUserId=[[self.getFilterUser objectAtIndex:indexPath.row] valueForKey:@"UserID"];
             fVC.groupId=[[self.getFilterUser objectAtIndex:indexPath.row] valueForKey:@"group_id"];
             fVC.phoneNumber=[[self.getFilterUser objectAtIndex:indexPath.row] valueForKey:@"ContactNo"];
             fVC.emailId=[[self.getFilterUser objectAtIndex:indexPath.row] valueForKey:@"Email"];
            
        }else{
            
            fVC.reciverUserId=[[self.getFilterUser objectAtIndex:indexPath.row] valueForKey:@"group_member"];
            fVC.groupId=[[self.getFilterUser objectAtIndex:indexPath.row] valueForKey:@"group_id"];
        }
        //Subhasish..16th March
        fVC.reciverName=[[[self.getFilterUser objectAtIndex:indexPath.row] valueForKey:@"Name"] stringByReplacingOccurrencesOfString:@"," withString:@", "];
        
         [self.appDelegate.centerViewController presentViewControllerForModal:fVC];

    }
    
}

-(NSString *)getDateForHistoryWithoutDate:(NSDate *)cdate
{
    
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    
    [formatter setTimeZone:ctimezone];
    
    [formatter setDateFormat:@"dd MMM"];
    
    NSDateFormatter *formatter1=[[NSDateFormatter alloc] init];
    
    [formatter1 setTimeZone:ctimezone];
    
    [formatter1 setDateFormat:@"hh:mm a"];
    
    NSString *s=[[NSString alloc] initWithFormat:@"%@",[formatter stringFromDate:cdate]];
    
    [calender setTimeZone:ctimezone];
    /*NSDateComponents *weekdayComponents = [calender components:(NSWeekdayCalendarUnit) fromDate:cdate];
     NSInteger todayDayNum = [weekdayComponents weekday];
     
     NSArray *weekdays=[[NSArray alloc] initWithObjects:@"",@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday",nil];*/
    
    
    
    NSString *str=s;
    
    
    
    return str;
    
}

- (IBAction)alertDone:(id)sender{
    
    self.viewTransparent.hidden=YES;
    self.viewAlert.hidden=YES;
}

#pragma mark - AdBannerViewDelegate method implementation

-(void)bannerViewWillLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad Banner will load ad.");
}


-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad Banner did load ad.");
    
    // Show the ad banner.
    [UIView animateWithDuration:0.5 animations:^{
        self.adBanner.alpha = 1.0;
    }];
}


-(BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave{
    NSLog(@"Ad Banner action is about to begin.");
    
    //self.pauseTimeCounting = YES;
    
    return YES;
}


-(void)bannerViewActionDidFinish:(ADBannerView *)banner{
    NSLog(@"Ad Banner action did finish");
    
    //self.pauseTimeCounting = NO;
}


-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    NSLog(@"Unable to show ads. Error: %@", [error localizedDescription]);
    
    // Hide the ad banner.
    [UIView animateWithDuration:0.5 animations:^{
        self.adBanner.alpha = 0.0;
    }];
}



@end
