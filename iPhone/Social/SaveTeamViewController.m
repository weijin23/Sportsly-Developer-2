//
//  SaveTeamViewController.m
//  Social
//
//  Created by Mindpace on 28/08/13.

#import "SelectContact.h"
#import "SaveTeamViewController.h"
#import "TeamDetailsViewController.h"
#import "PlayerListCell.h"
#import <AddressBookUI/AddressBookUI.h>
#import "PlayerViewController.h"
#import "InvitePlayerListCell.h"
#import "InviteViewController.h"
#import "ClubViewController.h"
#import "InvitePlayerListViewController.h"
#import "HomeVC.h"
#import "EventEditViewController.h"
#import "CenterViewController.h"
#import "EventCalendarViewController.h"
#import "ToDoByEventsVC.h"
#import "TeamMaintenanceVC.h"
#import "ChatViewController.h"
#import "PrimaryMemeberViewController.h"
#import "TeamAdminVCViewController.h"
#import "SpectatorViewController.h"

@interface SaveTeamViewController ()

@end

@implementation SaveTeamViewController

@synthesize teamScroll,teamDetailsVC,playerView,isSelectedImage,originalImage;
@synthesize teamNameLabel,tblView,editMode,addPlayerBtn;
@synthesize itemno;
@synthesize noimage;
@synthesize btnTapped,selectedContact;
@synthesize selectedTeamIndex;
@synthesize moreFiledAddCount;
@synthesize cludId,leagugeId;
@synthesize selectedInvitePlayer,cludLeageInfo;
int mode,playerMode,pickerSelect;
@synthesize inviteDeselectedImage,inviteSelectedImage,acceptdeImage;
@synthesize isTeamView,isInvite,selectedPlayer;

@synthesize normalImage,inviteMessage,selectedIdList,noResponeTickImage,admin,mayBeImage;//,isAdminInvite;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.isAdminInvite=NO;
    if (self.isiPad) {
        NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:20], UITextAttributeFont, nil];
        [self.segmentContr setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(realoadPlayerTable:) name:TEAMINVITESTATUSACCEPTEDFORCOACH object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tapAdminSegControl:) name:NOTIFYADMINTAPSEGCONTROL object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tapRosterSegControl:) name:NOTIFYROSTERTAPSEGCONTROL object:nil];
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userListUpdatedForAccept:) name:TEAMINVITESTATUSBYPUSH object:nil];
    //self.view.backgroundColor=appDelegate.backgroundPinkColor;
    //self.topview.backgroundColor=appDelegate.barGrayColor;
    
    if (!([[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"coach_id"]] || [[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"coach_id2"]]))
    {
        self.hardPressLab.hidden=YES;
        
        CGRect r= self.leftHardView.frame;
        r.origin.x=81;
        self.leftHardView.frame=r;
    }
    else
    {
        self.hardPressLab.hidden=NO;
        
        CGRect r= self.leftHardView.frame;
        r.origin.x=32;
        self.leftHardView.frame=r;
    }
    
    
    
   // [appDelegate createLocationManager];        /// AD 1st july
    
    self.noimage=  [UIImage imageNamed:@"no_image.png"];
    
//    NSLog(@"Save Team [self showAllSporstlyUsers];");
//    [self showAllSporstlyUsers];
    
    
    if(self.isiPad){
        self.acceptdeImage=[UIImage imageNamed:@"accept_invite_ipad.png"];
        self.inviteSelectedImage=[UIImage imageNamed:@"invite_player_ipad.png"];
        self.normalImage=[UIImage imageNamed:@"invite_player_ipad.png"];
        self.declinedImage=[UIImage imageNamed:@"declined_image_ipad.png"];
        self.noResponeImage=[UIImage imageNamed:@"not_response_ipad.png"];
        self.noResponeTickImage=[UIImage imageNamed:@"not_response_tick.png"];
        self.mayBeImage=[UIImage imageNamed:@"maybe_invite_ipad.png"];
    }
    else{
        self.acceptdeImage=[UIImage imageNamed:@"accept_invite.png"];
        self.inviteSelectedImage=[UIImage imageNamed:@"invite_player.png"];
        self.normalImage=[UIImage imageNamed:@"invite_player.png"];
        self.declinedImage=[UIImage imageNamed:@"declined_image.png"];
        self.noResponeImage=[UIImage imageNamed:@"not_response.png"];
        self.noResponeTickImage=[UIImage imageNamed:@"not_response_tick.png"];
        self.mayBeImage=[UIImage imageNamed:@"maybe_invite.png"];
    }
    
    self.addPlayerBtn.layer.cornerRadius=3.0f;
    [self.addPlayerBtn.layer setMasksToBounds:YES];
    
    @autoreleasepool{
        
        NSString *tmpphno=[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"creator_phno"] stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        if(tmpphno && (![tmpphno isEqualToString:@""]))
            self.inviteMessage=[NSString stringWithFormat:TEAMINVITECONTENT,[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"team_name"],[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"team_sport"]];
        else
            self.inviteMessage=[NSString stringWithFormat:TEAMINVITECONTENTEX,[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"team_name"],[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"team_sport"]];
    }

    self.selectedInvitePlayer=[[NSMutableArray alloc] init];
    
    for (int i=0; i< [[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] count]; i++){
        
        [self.selectedInvitePlayer addObject:@"0"];
        
    }
    
  
    @autoreleasepool {
        
        self.questionmarkimage=[UIImage imageNamed:@"q-mark"];
        self.crossmarkimage=[UIImage imageNamed:@"cross mark"];
        self.rightmarkimage=[UIImage imageNamed:@"right mark"];
        self.maybeQuestionmarkImage=[UIImage imageNamed:@"maybe-event.png"];
        
    }
    

}


- (void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self name:HANDLERECEIVEDMEMORYWARNING object:nil];
      [[NSNotificationCenter defaultCenter] removeObserver:self name:TEAMINVITESTATUSACCEPTEDFORCOACH object:nil];
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:TEAMINVITESTATUSBYPUSH object:nil];
    
    self.selectedContact=nil;
    self.originalImage=nil;
    self.noimage=nil;
   
    self.teamScroll=nil;
    self.playerView=nil;
      
    self.teamNameLabel=nil;
    self.tblView=nil;
    self.teamDetailsVC=nil;
    
    [_inviteAction release];
    [_inviteBtn release];
    
    [super dealloc];
}

- (void)viewDidUnload
{
  
    self.teamScroll=nil;
    self.playerView=nil;
   
    self.addPlayerBtn=nil;
    self.teamNameLabel=nil;
    self.tblView=nil;

    
    [self setTeamTrackerView:nil];
    [self setSendBtn:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //// AD...iAd
    self.adBanner.delegate = self;
    self.adBanner.alpha = 0.0;
    self.canDisplayBannerAds=YES;
    ////
    
    [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] showRightButton:0];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageUpdated:) name:TEAM_LOGO_NOTIFICATION object:nil];
    
    [self.segmentContr setSelectedSegmentIndex:1];
//    [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] setSegmentIndex:self.segmentContr.selectedSegmentIndex adminCount:0 isAdmin:NO];
    
    NSLog(@"Segment Details :%d",self.segmentContr.selectedSegmentIndex);

    self.isShowStatus=0;
    self.inviteAction.hidden=NO;
    self.teamTrackerView.hidden=NO;
    self.inviteAction.hidden=NO;
    self.sendBtn.hidden=YES;
    self.cancelBtn.hidden=YES;
    self.separetorView.hidden=NO;
    
    
    [self showAddTeamMessage];
    
    int responseCount=0;
    self.selectedInvitePlayer=[[[NSMutableArray alloc] init] autorelease];
        
    for (int i=0; i< [[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] count]; i++){
        
            [self.selectedInvitePlayer addObject:@"0"];
        
        
        if([[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:i] objectForKey:@"invites"] isEqualToString:NORESPONSE] || [[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:i] objectForKey:@"invites"] isEqualToString:PENDING] ){
            
            responseCount++;
        }
    }

    self.selectedPlayerId=nil;
    if ([self.appDelegate.JSONDATAarr count]==1) {
        
        
        if ([[[self.appDelegate.JSONDATAarr objectAtIndex:0] objectForKey:@"player_details"] count]==1) {
            appDelegate.aDef=[NSUserDefaults standardUserDefaults];
            if(![appDelegate.aDef objectForKey:ISFIRSTTIMEPLAYER])
            {
                self.custmLbl.text=@"Congratulations, player has been added. Now go ahead and invite the player.";
                self.popupalertvw.hidden=NO;
                self.popupalertvwBack.hidden=NO;
                [appDelegate setUserDefaultValue:@"1" ForKey:ISFIRSTTIMEPLAYER];
            }
        }
    }
    
    if ([[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] count]) {
        
        
        
        self.noPlayerView.hidden=YES;
        [self refreshPlayerDetails];
        //self.invitePlayerBtn.enabled=YES;
        self.noplaerVw.hidden=YES;

    }else{
        
//        self.custmLbl.text=@"Add player info. You can also update from your contacts.";
//        [self showAlertViewCustom];
        
        self.buttonView.hidden=YES;
        self.noPlayerView.hidden=NO;
        self.invitePlayerBtn.enabled=NO;
        [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] setSegmentIndex:self.segmentContr.selectedSegmentIndex adminCount:0 isAdmin:NO];
        self.admin=NO;
    }

    
    if ([[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"coach_id"]] || [[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"coach_id2"]]) {
        
        //if ([[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] count]){
            self.admin=YES;
            [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] setSegmentIndex:self.segmentContr.selectedSegmentIndex adminCount:0 isAdmin:YES];
        //}
//            self.buttonView.hidden=NO;
        
        self.viewTopSelectall.hidden=NO;
        self.viewInviteMessage.hidden=NO;
        if (self.isiPad) {
            self.noResponeImage=[UIImage imageNamed:@"not_response_ipad.png"];
            self.normalImage=[UIImage imageNamed:@"invite_player_ipad.png"];
            if (responseCount<2/*self.selectedInvitePlayer.count==1*/) {
              //  self.tblView.frame=CGRectMake(0, 59, 768, self.view.bounds.size.height - 140);  //// iAd 8/05
                self.tblView.frame=CGRectMake(0, 59, 768, self.view.bounds.size.height - 150);
                self.viewTopSelectall.hidden=YES;
                //self.viewInviteMessage.hidden=NO;
            }
            else{
               // self.tblView.frame=CGRectMake(0, 111, 768, self.view.bounds.size.height - 190); //// iAd 8/05
                self.tblView.frame=CGRectMake(0, 111, 768, self.view.bounds.size.height - 200);
                self.viewMessage.frame=CGRectMake(0,827, self.viewMessage.frame.size.width, self.viewMessage.frame.size.height);
            }
        }
        else{
            self.noResponeImage=[UIImage imageNamed:@"not_response.png"];
            self.normalImage=[UIImage imageNamed:@"invite_player.png"];
            if (responseCount<2/*self.selectedInvitePlayer.count==1*/) {
                self.tblView.frame=CGRectMake(0, 42, 320, self.view.bounds.size.height - 77);
                self.viewTopSelectall.hidden=YES;
            }
            else{
                if (self.appDelegate.isIphone5) {
                    
                  //  self.tblView.frame=CGRectMake(0, 81, 320, self.view.bounds.size.height - 116); //// iAd 8/05
                    self.tblView.frame=CGRectMake(0, 81, 320, self.view.bounds.size.height - 126);
                    self.viewMessage.frame=CGRectMake(0, 352-11, 320, 17);
                    
                }else{
                    
                    
                  //  self.tblView.frame=CGRectMake(0, 81, 320, self.view.bounds.size.height - 116); //// iAd 8/05
                    self.tblView.frame=CGRectMake(0, 81, 320, self.view.bounds.size.height - 126);
                    self.viewMessage.frame=CGRectMake(0,352-61, 320, 17);
                    
                }
            }
            
            
        }

        
    }else{
        
        self.viewTopSelectall.hidden=YES;
        self.viewInviteMessage.hidden=YES;
        self.buttonView.hidden=YES;
        [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] setSegmentIndex:self.segmentContr.selectedSegmentIndex adminCount:0 isAdmin:NO];
        self.admin=NO;
        
        if (self.isiPad) {
            self.noResponeImage=[UIImage imageNamed:@"pending_invite_ipad.png"];
            self.normalImage=[UIImage imageNamed:@"pending_invite_ipad.png"];
            
            // self.tblView.frame=CGRectMake(0,59, 768, self.view.bounds.size.height - 100); //// iAd 8/05
            self.tblView.frame=CGRectMake(0,59, 768, self.view.bounds.size.height - 110);
            self.viewMessage.frame=CGRectMake(0,827+90, self.viewMessage.frame.size.width, self.viewMessage.frame.size.height);
        }
        else{
            self.noResponeImage=[UIImage imageNamed:@"pending_invite.png"];
            self.normalImage=[UIImage imageNamed:@"pending_invite.png"];
            if (self.appDelegate.isIphone5) {
                
               // self.tblView.frame=CGRectMake(0, 42, 320,self.view.bounds.size.height - 66);  //// iAd 8/05
                self.tblView.frame=CGRectMake(0, 42, 320,self.view.bounds.size.height - 76);
                self.viewMessage.frame=CGRectMake(0,353-11+50, 320, 17);
                
                
            }else{
               // self.tblView.frame=CGRectMake(0, 42,320,self.view.bounds.size.height - 66); //// iAd 8/05
                self.tblView.frame=CGRectMake(0, 42,320,self.view.bounds.size.height - 76);
                self.viewMessage.frame=CGRectMake(0,353-61+50, 320, 17);
                
            }
        }

 
        
    }

    
}

-(void)showAddTeamMessage{
    
    if (self.isCheckMsg==1) {
        
    }
    
//    self.imageViewAddTeamMsg.hidden=NO;
//    [self performSelector:@selector(hideAddTeamMessage) withObject:self afterDelay:2.0];
    
}
-(void)hideAddTeamMessage{
    self.imageViewAddTeamMsg.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}



#pragma mark - Get Respone


-(void)notifyRequesterWithData:(id) aData :(id)aData1
{
    
    [self hideHudView]; 
    [self hideNativeHudView];
    
    if([aData isKindOfClass:[ConnectionManager class]])
    {
        ConnectionManager *aR=(ConnectionManager*)aData;
        
        
        if([aR.requestSingleId isEqualToString:INVITEPLAYERS])
        {
            return;
        }
        
        
    }
    
    if([aData isKindOfClass:[ConnectionManager class]])
    {
        ConnectionManager *aR=(ConnectionManager*)aData;
        
        if(mode==3)
        {
            if([aR.requestSingleId isEqualToString:DELELTE_PLAYER])
            {
                
            }
        }
        return;

    }
    
    NSString *str=(NSString*)aData;
    NSLog(@"JSONData=%@",str);
    ConnectionManager *aR=(ConnectionManager*)aData1;
    NSLog(@"JSONData=%@",str);
    /////////
    
    if([aR.requestSingleId isEqualToString:INVITEPLAYERS])
    {
        if (str)
        {
            SBJsonParser *parser=[[SBJsonParser alloc] init];
            
            id res = [parser objectWithString:str];
            
            if ([res isKindOfClass:[NSDictionary class]])
            {
                NSDictionary* aDict = (NSDictionary*) res;
                NSString *message=[aDict objectForKey:@"message"];
                NSLog(@"%@",message);
                
                if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"] || [[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"2"] || [[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"0"])
                {
                    NSLog(@"InviteStatus=%@",[aDict objectForKey:@"status"]);
                    
                    
                    
                    NSArray *playerisarrays=[self.selectedIdList componentsSeparatedByString:@","];
                    
                    
                    for(NSString *playerid in playerisarrays)
                    {
                        
                        
                        
                        for (int i=0; i<[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] count]; i++) {
                            
                            NSString *pid=[[NSString alloc] initWithFormat:@"%@", [[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:i] objectForKey: @"player_id"]] ;
                            
                            if([playerid isEqualToString:pid])
                            {
                                
                                [[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:i ] setObject:NORESPONSE forKey:@"invites"];
                                
                                break;
                            }
                            
                            
                        }
                        
                        
                    }
                    
                   /* if (self.isAdminInvite==YES) {
                        [self teamInviteAccept];
                    }*/
                    
                    
                }
                else
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                    [alert show];
                }
            }
            
            // [self showHudAlert:@"Invite sent"];
            self.custmLbl.text=@"Team invite has been sent";
            [self showAlertViewCustom];
            
            
            
            //[self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
        }
        [self.tblView reloadData];
        /*self.custmLbl.text=@"Team invite(s) have been sent";
         [self showAlertViewCustom];*/
        // [self showHudAlert:@"Invite sent"];
        //[self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
        
        return;
    }

    
    if(mode==3)
    {
        if (str)
        {
            SBJsonParser *parser=[[SBJsonParser alloc] init];
            
            id res = [parser objectWithString:str];
            
            [parser release];
            if ([res isKindOfClass:[NSDictionary class]])
            {
                NSDictionary* aDict = (NSDictionary*) res;
                NSString *message=[aDict objectForKey:@"message"];
                NSLog(@"%@",message);
                
                if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
                {
                    
                    [[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] removeObjectAtIndex:self.selectedPlayer];
                   /* if ([self.appDelegate.JSONDATAarr count]==1) {
                        
                        
                        if ([[[self.appDelegate.JSONDATAarr objectAtIndex:0] objectForKey:@"player_details"] count]==1) {
                            
                        }
                    }*/
                   
                    [self.tblView reloadData];
                    
                }
                
                else
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Operation failed." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                }
            }
        }
    }
}

#pragma mark - RefreshPlayeView

-(void)realoadPlayerTable:(id)sender
{
    [self.tblView reloadData];
}

- (IBAction)showPlayerStatus:(id)sender {
    
    if (self.isShowStatus) {
        
        self.isShowStatus=0;
        self.inviteAction.hidden=NO;
        self.sendBtn.hidden=YES;
        self.cancelBtn.hidden=YES;
        self.separetorView.hidden=NO;
        self.addPlayerBtn.hidden=NO;
        self.invitePlayerBtn.hidden=NO;

    }else{
        
        NSArray* playerDetailsList=[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"];
        NSPredicate *sPredicate = [NSPredicate predicateWithFormat: @"invites='NoResp' OR invites='Maybe' OR invites='Pending'" ];
        
        playerDetailsList = [NSMutableArray arrayWithArray:[playerDetailsList
                                                        filteredArrayUsingPredicate:sPredicate]];
        
        
        if (playerDetailsList.count) {
            
            self.isShowStatus=1;
            self.inviteAction.hidden=YES;
            self.sendBtn.hidden=NO;
            self.cancelBtn.hidden=NO;
            self.separetorView.hidden=YES;
            
        }else{
            
            self.isShowStatus=1;
            self.inviteAction.hidden=YES;
            self.sendBtn.hidden=YES;
            self.addPlayerBtn.hidden=YES;
            self.invitePlayerBtn.hidden=YES;
            self.cancelBtn.hidden=NO;
            self.separetorView.hidden=YES;
        }
       

    }
    
    self.selectedInvitePlayer=[[[NSMutableArray alloc] init] autorelease];
    
    for (int i=0; i< [[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] count]; i++){
        
        [self.selectedInvitePlayer addObject:@"0"];
    }
    
    self.selectedPlayerId=nil;
    
    [self.tblView reloadData];
}




-(void)refreshPlayerDetails{
    

        
        if ([[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] count]>0) {
            
            self.tblView.hidden=NO;
            self.viewInviteMessage.hidden=NO;
            
            [self.inviteAction setTitle:@"Edit" forState:UIControlStateNormal];
            
            self.inviteAction.hidden=NO;
            
           
            self.teamTrackerView.hidden=NO;
            
            self.selectedInvitePlayer=[[[NSMutableArray alloc] init] autorelease];
            
            for (int i=0; i< [[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] count]; i++){
                
                [self.selectedInvitePlayer addObject:@"0"];
            }
                  
            self.tblView.allowsSelection=YES;
          
            if (self.isShowStatus){
                
                self.inviteAction.hidden=YES;
                self.sendBtn.hidden=NO;
                
            }else{
                
                self.inviteAction.hidden=NO;
                self.sendBtn.hidden=YES;
            }
            
            [self.tblView reloadData];
            
            ////////////////ADDDEB
            self.invitePlayerBtn.enabled=YES;
            ////////////////

        }else{
            
            [self.tblView reloadData];
            self.noPlayerView.hidden=NO;
            self.playerView.hidden=NO;
            self.inviteAction.hidden=NO;
//            self.custmLbl.text=@"Add player info. You can also update from your contacts.";
//            [self showAlertViewCustom];
            
            PlayerViewController *player=[[PlayerViewController alloc] initWithNibName:@"PlayerViewController" bundle:nil];
            player.selectedTeamIndex=itemno;
            player.playerMode=0;
            player.isNoPlayer=1;
            //[self.navigationController pushViewController:player animated:YES];
            [self.appDelegate.centerViewController presentViewControllerForModal:player];
            //[player release];
           
        }
    
    [self setEditing:NO animated:NO];
    
    }



-(void)populateField:(Contacts*)contact
{
    self.selectedContact=contact;
    NSLog(@"selectedContact=%@",selectedContact);
        
}

- (IBAction)segmentValueChange:(id)sender {
    
    NSLog(@"Segment Details :%d",self.segmentContr.selectedSegmentIndex);
    [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] setSegmentIndex:(int)self.segmentContr.selectedSegmentIndex adminCount:0 isAdmin:self.admin];
    
    UISegmentedControl *segment=(UISegmentedControl*)sender;
    if (segment.selectedSegmentIndex==0) {
        
        [self TeamDetails:sender];
        
    }else if (segment.selectedSegmentIndex==1){
        
        
    }else if (segment.selectedSegmentIndex==2){
        [self AddminTapp:sender];
    }
    else{
        [self spectorDetails:sender];
    }
}


- (void)tapAdminSegControl:(id)sender
{
    
    if(self.segmentContr.selectedSegmentIndex==2)
    {
        for (UIViewController *vc in self.navigationController.viewControllers) {
            
            if ([vc isKindOfClass:[TeamAdminVCViewController class]]) {
                
                return;
            }
        }
    }
    [self.segmentContr setSelectedSegmentIndex:2];
    
    NSLog(@"Segment Details :%d",self.segmentContr.selectedSegmentIndex);
    [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] setSegmentIndex:self.segmentContr.selectedSegmentIndex adminCount:0 isAdmin:self.admin];
    //[self AddminTapp:sender];
    
}
- (void)tapRosterSegControl:(id)sender
{
    
    [self.segmentContr setSelectedSegmentIndex:1];
    NSLog(@"Segment RosterSave :%d",self.segmentContr.selectedSegmentIndex);
}

#pragma  mark - Toggle
- (IBAction)TeamDetails:(id)sender {
    
    
//    TeamDetailsViewController *addTeam=[[TeamDetailsViewController alloc]initWithNibName:@"TeamDetailsViewController" bundle:nil];
//    addTeam.selectedTeamIndex=self.selectedTeamIndex;
//    [self.navigationController pushViewController:addTeam animated:NO];
    
    [self.navigationController popToRootViewControllerAnimated:NO];
    
}

-(IBAction)AddminTapp:(id)sender{
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        
        if ([vc isKindOfClass:[TeamAdminVCViewController class]]) {
            [self.navigationController popToViewController:vc animated:NO];
            return;
        }
    }
    
    TeamAdminVCViewController *adminVC=[[TeamAdminVCViewController alloc] initWithNibName:@"TeamAdminVCViewController" bundle:nil];
    adminVC.selectedTeamIndex=self.selectedTeamIndex;
    [self.navigationController pushViewController:adminVC animated:NO];
    
    
}

-(void)spectorDetails:(id)sender{
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        
        if ([vc isKindOfClass:[SpectatorViewController class]]) {
            [self.navigationController popToViewController:vc animated:NO];
            return;
        }
    }
    
    SpectatorViewController *teamView=[[SpectatorViewController alloc]initWithNibName:@"SpectatorViewController" bundle:nil];
    teamView.itemno=self.selectedTeamIndex;
    //    teamView.editMode=YES;
    //    teamView.isInvite=0;
    //    teamView.selectedTeamIndex=self.selectedTeamIndex;
    //    teamView.isTeamView=NO;
    [self.navigationController pushViewController:teamView animated:NO];
}


-(IBAction)addPlayer:(id)sender
{
    
    if (self.appDelegate.JSONDATAarr && self.appDelegate.JSONDATAarr.count>0)
    {
        BOOL adminValue;
        if ([[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"coach_id"]] || [[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"coach_id2"]])
            adminValue=YES;
        else
            adminValue=NO;
        [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] setSegmentIndex:(int)self.segmentContr.selectedSegmentIndex adminCount:0 isAdmin:adminValue];
        [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] toggleRightPanel:sender];
    }
    else
    {
        [self showAlertMessage:@"You need to belong to a team as a player to invite friends."];
    }
    
   /*
    PlayerViewController *player=[[PlayerViewController alloc] initWithNibName:@"PlayerViewController" bundle:nil];
    player.selectedTeamIndex=itemno;
    NSLog(@"item no :%d",itemno);
    player.playerMode=0;
   // [self.navigationController pushViewController:player animated:YES];
    [self.appDelegate.centerViewController presentViewControllerForModal:player];

    //[player release];
    */
    
}


#pragma mark - TableViewDataSourace

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return [[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] count];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isiPad) {
        return 70;
    }
    return 50;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"InvitePlayerCell";
    
    InvitePlayerListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell=[InvitePlayerListCell inviteCell];
        [cell.callBtn addTarget:self action:@selector(invitePlayerAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.deleteBtn addTarget:self action:@selector(deletePlayer:) forControlEvents:UIControlEventTouchUpInside];
        [cell.editBtn addTarget:self action:@selector(editPlayer:) forControlEvents:UIControlEventTouchUpInside];
        [cell.cancelBtn addTarget:self action:@selector(cancelEditPlayer:) forControlEvents:UIControlEventTouchUpInside];
        
        UILongPressGestureRecognizer *lpg1 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(LongPress:)];
        [cell.backView addGestureRecognizer:lpg1];
        
        }
    
     [self configureCell:cell atIndexPath:indexPath andTableView:tableView];
     return cell;
   
    
}


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath andTableView:(UITableView*)tableview
{
    
    InvitePlayerListCell*cell1=(InvitePlayerListCell*)cell;
        cell1.cancelBtn.hidden=YES;
        cell1.callBtn.tag=indexPath.row;
        cell1.deleteBtn.tag=indexPath.row;
        cell1.editBtn.tag=indexPath.row;
        cell1.backView.tag=indexPath.row;
        cell1.lblNumber.text=[NSString stringWithFormat:@"%d.",indexPath.row+1];
    [cell1.callBtn setImage:self.normalImage forState:UIControlStateNormal];
    cell1.playerNameLbl.textColor=[UIColor blackColor];
    
    
    
        if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:indexPath.row ] objectForKey:@"invites"] isEqualToString:@"Accept"]) {
            
            cell1.playerNameLbl.text=[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:indexPath.row] objectForKey:@"player_name"];
            //cell1.playerNameLbl.textColor=[UIColor colorWithRed:0.0/255.0 green:154.0/255.0 blue:215.0/255.0 alpha:1.0];
            [cell1.callBtn setImage:self.acceptdeImage forState:UIControlStateNormal];
            
        }
        else if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:indexPath.row ] objectForKey:@"invites"] isEqualToString:@"Decline"]){
            
            
            cell1.playerNameLbl.text=[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:indexPath.row ] objectForKey:@"player_name"];
            [cell1.callBtn setImage:self.declinedImage forState:UIControlStateNormal];
            
            
        }
        else if([[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:indexPath.row ] objectForKey:@"invites"] isEqualToString:NORESPONSE]  ||  [[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:indexPath.row ] objectForKey:@"invites"] isEqualToString:MAYBE] ){
            
            cell1.playerNameLbl.text=[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:indexPath.row ] objectForKey:@"player_name"];
            [cell1.callBtn setImage:self.noResponeImage forState:UIControlStateNormal];
            
            
        }else if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:indexPath.row ] objectForKey:@"invites"] isEqualToString:PENDING])
        {
            
            cell1.playerNameLbl.text=[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:indexPath.row ] objectForKey:@"player_name"];
            [cell1.callBtn setImage:self.noResponeImage forState:UIControlStateNormal];
            
        }
        
    NSString *imgUrl= [NSString stringWithFormat:@"%@%@",IMAGELINK,[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:indexPath.row ] objectForKey:@"ProfileImage"]];
      [cell1.profileImageVw cleanPhotoFrame];
    
    [cell1.profileImageVw setImage:self.noImage];
    if (![[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:indexPath.row ] objectForKey:@"ProfileImage"] isEqualToString:@""] && [[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:indexPath.row ] objectForKey:@"ProfileImage"]) {
        [cell1.profileImageVw applyPhotoFrame];
         [cell1.profileImageVw setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:self.noImage];
    }else{
      
    }
   
    
    /////////  04/03/2015 ///////
    
    
    if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:indexPath.row ] objectForKey:@"invites"] isEqualToString:@"Accept"]) {
        
        
        [cell1.callBtn setImage:self.acceptdeImage forState:UIControlStateNormal];
        cell1.callBtn.userInteractionEnabled=NO;
        
    }else if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:indexPath.row ] objectForKey:@"invites"] isEqualToString:@"Decline"]){
        
        
        [cell1.callBtn setImage:self.declinedImage forState:UIControlStateNormal];
        cell1.callBtn.userInteractionEnabled=NO;
        
        
    } else if( [[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:indexPath.row ] objectForKey:@"invites"] isEqualToString:MAYBE] ){
        
        /*if (self.selectedInvitePlayer) {
            
            if ([[self.selectedInvitePlayer objectAtIndex:indexPath.row] integerValue]) {
                
                //[cell1.callBtn setImage:self.inviteSelectedImage forState:UIControlStateNormal];
                [cell1.callBtn setImage:self.mayBeImage forState:UIControlStateNormal];
                
            }else{*/
                
                [cell1.callBtn setImage:self.mayBeImage forState:UIControlStateNormal];
                
                cell1.callBtn.userInteractionEnabled=NO;
                
            //}
        //}
        
        
        
    }else if([[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:indexPath.row ] objectForKey:@"invites"] isEqualToString:NORESPONSE]   ){
        
        cell1.callBtn.userInteractionEnabled=YES;
        if (self.selectedInvitePlayer) {
            
            if ([[self.selectedInvitePlayer objectAtIndex:indexPath.row] integerValue]) {
                
                //[cell1.callBtn setImage:self.inviteSelectedImage forState:UIControlStateNormal];
                [cell1.callBtn setImage:self.noResponeImage forState:UIControlStateNormal];
                
                
            }else{
                
                [cell1.callBtn setImage:self.noResponeImage forState:UIControlStateNormal];
                
                
                
            }
        }
        
        
        
    }
    else if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:indexPath.row ] objectForKey:@"invites"] isEqualToString:PENDING]){
        
        cell1.callBtn.userInteractionEnabled=YES;
        if (self.selectedInvitePlayer) {
            
            if ([[self.selectedInvitePlayer objectAtIndex:indexPath.row] integerValue]) {
                
                [cell1.callBtn setImage:self.normalImage forState:UIControlStateNormal];
                
            }else{
                [cell1.callBtn setImage:self.normalImage forState:UIControlStateNormal];
                
                
            }
        }
        
        
    }

    
    if ([[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"coach_id"]] || [[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"coach_id2"]]) {
        
       
    }
    else{
         [cell1.callBtn setImage:[UIImage imageNamed:@"call_big.png"] forState:UIControlStateNormal];
        cell1.callBtn.userInteractionEnabled=NO;
    }
    /////////////// AD //////////
    
    
    
    
}


//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
//   
//          
//    return UITableViewCellEditingStyleDelete;
//    
//}

#pragma mark - TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //// 21/8/14  ///////
    
    self.selectedPlayer=indexPath.row;
    
    if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:self.selectedPlayer] objectForKey:@"Email1"] isEqualToString:[appDelegate.aDef objectForKey:EMAIL]]) {
        
        
      /*  UIActionSheet *action=[[UIActionSheet alloc] initWithTitle:[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex: self.selectedPlayer] objectForKey:@"player_name"] delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Alternate Contacts",nil];*/
        
        UIActionSheet *action=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Alternate Contacts",nil];
        action.tag=indexPath.row;
        [action showInView:appDelegate.centerViewController.view];
        
    }else{
        
        UIActionSheet *action=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Alternate Contacts",@"Call",@"Email",@"Message",nil];
        action.tag=indexPath.row;
        [action showInView:appDelegate.centerViewController.view];
    }
    
   /* if([[appDelegate.navigationControllerPrimaryMemeber.viewControllers lastObject] isMemberOfClass:[PrimaryMemeberViewController class]]){
        PrimaryMemeberViewController *primary=(PrimaryMemeberViewController*)[appDelegate.navigationControllerPrimaryMemeber.viewControllers objectAtIndex:0];
        
        primary.playerDict=[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:indexPath.row ];
        
        [primary setIntialized];
    }
    [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerPrimaryMemeber];

*/
    
}








- (IBAction)addMore:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)LongPress:(UILongPressGestureRecognizer*)gesture{
    
    if ([[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"coach_id"]] || [[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"coach_id2"]]) {
        
        if (gesture.state == UIGestureRecognizerStateBegan) {
            
            // changed on 6th October
          
            UIView *vw;
            InvitePlayerListCell*cell1;
            if(appDelegate.isIos7){
               vw=(UIView*)[[[gesture.view superview] superview] superview];
                cell1=(InvitePlayerListCell*)[[[gesture.view superview] superview]superview];
                cell1.cancelBtn.hidden=NO;
            }
            else if(appDelegate.isIos8){
                vw=(UIView*)[[gesture.view superview] superview] ;
                cell1=(InvitePlayerListCell*)[[gesture.view superview] superview];
                cell1.cancelBtn.hidden=NO;
            }
            else{
                vw=(UIView*)[gesture.view superview];
                cell1=(InvitePlayerListCell*)[gesture.view superview];
                cell1.cancelBtn.hidden=NO;
            }
            
            //vw.frame=CGRectMake(-115, 0,vw.frame.size.width + 115,vw.frame.size.height);
            if (self.isiPad) {
                vw.frame=CGRectMake(-154, vw.frame.origin.y,vw.frame.size.width + 154,vw.frame.size.height);
                
            }
            else{
                vw.frame=CGRectMake(-115, vw.frame.origin.y,vw.frame.size.width + 115,vw.frame.size.height);
            }
        }
    }
    
}


- (IBAction)deletePlayer:(UIButton*)sender
{
    
//    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Are you sure want to delete" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Okay", nil];
//    alert.tag=sender.tag;
//    [alert show];
//    [alert release];
    
    self.selectedPlayer=sender.tag;
    UIActionSheet *action=[[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Remove",nil];
    action.tag=9999;
    [action showInView:appDelegate.centerViewController.view];

}


-(IBAction)editPlayer:(UIButton*)sender{
    
    PlayerViewController *player=[[PlayerViewController alloc] initWithNibName:@"PlayerViewController" bundle:nil];
    player.selectedTeamIndex=itemno;
    player.selectedPlayerIndex=sender.tag;
    player.playerMode=1;
    [self.appDelegate.centerViewController presentViewControllerForModal:player];
    //[player release];
    

    
}

-(void)cancelEditPlayer:(UIButton *)sender{
    
    [self.tblView reloadData];
}
#pragma mark - PlayerOption

-(IBAction)OptionAction:(int)sender{
    //// 21/8/14  ///////
    
    NSMutableDictionary *playerDict=[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:sender ];
    int count=0;
    if (![[playerDict objectForKey:@"Email2"] isEqualToString:@""]) {
        count++;
    }
    
    if (![[playerDict objectForKey:@"Email3"] isEqualToString:@""]) {
        count++;
    }
    if (count==0) {
        
        self.custmLbl.text=[NSString stringWithFormat:@"Sorry, %@ does not have any Alternate Contacts",[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:self.selectedPlayer] objectForKey:@"Email_Rel1"]];
        self.popupalertvwBack.hidden=NO;
        self.popupalertvw.hidden=NO;
        return;
        
    }
    
    if([[appDelegate.navigationControllerPrimaryMemeber.viewControllers lastObject] isMemberOfClass:[PrimaryMemeberViewController class]]){
        PrimaryMemeberViewController *primary=(PrimaryMemeberViewController*)[appDelegate.navigationControllerPrimaryMemeber.viewControllers objectAtIndex:0];
        
        primary.playerDict=[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:sender ];
        
        
        if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:sender ] objectForKey:@"invites"] isEqualToString:@"Accept"]) {
            
            primary.commonImage= self.acceptdeImage;

        }else if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:sender] objectForKey:@"invites"] isEqualToString:@"Decline"]){
            primary.commonImage= self.declinedImage;
            
        
        } else if( [[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:sender] objectForKey:@"invites"] isEqualToString:MAYBE] ){
            primary.commonImage= self.mayBeImage;
        
        }else if([[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:sender] objectForKey:@"invites"] isEqualToString:NORESPONSE]   ){
            primary.commonImage= self.noResponeImage;
        }
        else if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:sender ] objectForKey:@"invites"] isEqualToString:PENDING]){
            primary.commonImage= self.normalImage;
        }
        
        
        if ([[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"coach_id"]] || [[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"coach_id2"]]) {
            
            
        }
        else{
            primary.commonImage=[UIImage imageNamed:@"call_big.png"];
        }
        
        
        
        [primary setIntialized];
    }
    [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerPrimaryMemeber];
    
    
    /*
     
     if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:indexPath.row ] objectForKey:@"invites"] isEqualToString:@"Accept"]) {
     
     
     [cell1.callBtn setImage:self.acceptdeImage forState:UIControlStateNormal];
     }else if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:indexPath.row ] objectForKey:@"invites"] isEqualToString:@"Decline"]){
     
     
     [cell1.callBtn setImage:self.declinedImage forState:UIControlStateNormal];
     } else if( [[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:indexPath.row ] objectForKey:@"invites"] isEqualToString:MAYBE] ){
     [cell1.callBtn setImage:self.mayBeImage forState:UIControlStateNormal];
     }else if([[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:indexPath.row ] objectForKey:@"invites"] isEqualToString:NORESPONSE]   ){
     [cell1.callBtn setImage:self.noResponeImage forState:UIControlStateNormal];
     else if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:indexPath.row ] objectForKey:@"invites"] isEqualToString:PENDING]){
     [cell1.callBtn setImage:self.normalImage forState:UIControlStateNormal];
     
     */
    
    
    
   /* self.selectedPlayer=sender.tag;
    
    if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:self.selectedPlayer] objectForKey:@"Email1"] isEqualToString:[appDelegate.aDef objectForKey:EMAIL]]) {
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Sorry but there is no point in talking to yourself" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
    }else{
        
        UIActionSheet *action=[[UIActionSheet alloc] initWithTitle:[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex: self.selectedPlayer] objectForKey:@"player_name"] delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Call",@"Email",@"Message",nil];
        action.tag=1001;
        [action showInView:appDelegate.centerViewController.view];
    }*/
   
    
}

#pragma mark - ActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
   
    if (actionSheet.tag==9999){
        
        if (buttonIndex==0) {
            mode=3;
            NSMutableDictionary *command = [NSMutableDictionary dictionary];
            
            [command setObject:[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:self.selectedPlayer] objectForKey:@"player_id"]  forKey:@"player_id"];
            
            SBJsonWriter *writer = [[SBJsonWriter alloc] init];
            
            NSString *jsonCommand = [writer stringWithObject:command];
            
            [writer release];
            
            [self showHudView:@"Connecting..."];
            [self showNativeHudView];
            
            [appDelegate sendRequestFor:DELELTE_PLAYER from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
        }
        
    }
    
    else {
        if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:self.selectedPlayer] objectForKey:@"Email1"] isEqualToString:[appDelegate.aDef objectForKey:EMAIL]]) {
            if (buttonIndex==0){
                
                [self OptionAction:actionSheet.tag];
            }
        }
        else{
            if (buttonIndex==0) {
                [self OptionAction:actionSheet.tag];

            }else if (buttonIndex==1){
                
                [self smstoPlayer:nil];
                
            }else if (buttonIndex==2){
                [self mailtoPlayer:nil];

            }
            else if (buttonIndex==3){
                [self chattoPlayer:nil];

            }
        }
        
        
        

    }
    
}

#pragma mark - Conversation To Player

-(IBAction)mailtoPlayer:(UIButton*)sender{
    
    
    [self sendMail:nil :[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:self.selectedPlayer] objectForKey:@"Email1"]];
        
    
    
}
-(IBAction)chattoPlayer:(UIButton*)sender{
    
    
    if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:self.selectedPlayer] objectForKey:@"UserID"] isEqualToString:@"0"]) {
        
        self.custmLbl.text=[NSString stringWithFormat:@"Sorry, %@ has not yet registered with sportsly",[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:self.selectedPlayer] objectForKey:@"Email_Rel1"]];
        self.popupalertvwBack.hidden=NO;
        self.popupalertvw.hidden=NO;
        return;
    }
    
     NSString *reciverId=nil;
     
    ChatViewController *fVC=[[ChatViewController alloc] initWithNibName:@"ChatViewController" bundle:nil];
    fVC.groupId=@"";

    if (![[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:self.selectedPlayer] objectForKey:@"UserID"] isEqualToString:[appDelegate.aDef objectForKey:LoggedUserID]]) {
        
        fVC.reciverUserId=[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:self.selectedPlayer] objectForKey:@"UserID"];
        fVC.reciverName= [[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:self.selectedPlayer] objectForKey:@"player_name"];
         reciverId=[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:self.selectedPlayer] objectForKey:@"UserID"];
     }
     
    fVC.isList=1;
    
    if (reciverId) {
        
        [self.appDelegate.centerViewController presentViewControllerForModal:fVC];

    }
    
    
}

-(IBAction)smstoPlayer:(UIButton*)sender{
    
    
        if (![[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:self.selectedPlayer] objectForKey:@"ph_no"] || ![[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:self.selectedPlayer] objectForKey:@"ph_no"] isEqualToString:@"0"]) {
            
            [self callNumber:[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:self.selectedPlayer] objectForKey:@"ph_no"]];
            
        }else{
           
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"No phone numbers available – please contact team admin" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        
    
    
    
    
}






#pragma mark - Inviteplayer

- (IBAction)invitePlayer:(id)sender {
    
    
        InviteViewController *invite=[[InviteViewController alloc] initWithNibName:@"InviteViewController" bundle:nil];
        invite.selectEdTeamIndex=self.selectedTeamIndex;
        [self.appDelegate.centerViewController presentViewControllerForModal:invite];
        [invite release];
    
   
}

/// Not use ///
- (IBAction)playerDetailsTaped:(id)sender{
    
}

- (IBAction)saveTeam:(id)sender{
    
}

- (IBAction)back:(id)sender{
    
}

- (IBAction)cacelInviteAction:(id)sender{
}
- (IBAction)inviteBTapped:(id)sender{
}
/// This Are ///

////////   04/03/2015  ///////

- (IBAction)selectedAllplayer:(id)sender {
    
    
    /*if ([self.selectedBtn isSelected]) {
        
        [sender setSelected:NO];
        self.btnInvitePlayer.hidden=YES;
        for (int i=0; i<self.selectedInvitePlayer.count; i++) {
            
            [self.selectedInvitePlayer replaceObjectAtIndex:i withObject:@"0"];
        }
        
    }else{*/
    if ([[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach_id"] isEqualToString:[appDelegate.aDef objectForKey:LoggedUserID]] || [[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach_id2"] isEqualToString:[appDelegate.aDef objectForKey:LoggedUserID]]) {
        //[self.selectedBtn setSelected:YES];
        self.btnInvitePlayer.hidden=YES;
        for (int i=0; i<self.selectedInvitePlayer.count; i++) {
            
            if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:i] objectForKey:@"invites"] isEqualToString:NORESPONSE] || [[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:i] objectForKey:@"invites"] isEqualToString:PENDING]) {
                
                [self.selectedInvitePlayer replaceObjectAtIndex:i withObject:@"1"];
            }else{
                
                [self.selectedInvitePlayer replaceObjectAtIndex:i withObject:@"0"];
            }
            
        }
        [self showAlertForInvite];
    }
    
//    }
    
    //[self.tblView reloadData];
//    [self showAlertForInvite];
    
}
-(void)showAlertForInvite{
    
    self.popupalertvwBack.hidden=NO;
    self.popupinvitealertvw.hidden=NO;
    
}
- (IBAction)inviteSubmit:(id)sender {
    
    self.selectedIdList=nil;
    for (int i=0; i< self.selectedInvitePlayer.count; i++) {
        if ([[self.selectedInvitePlayer objectAtIndex:i] intValue]) {
            
            if ( !self.selectedIdList) {
                
                self.selectedIdList=[NSString stringWithFormat:@"%@",[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:i] objectForKey:@"player_id"]];
                
                
                
            }else{
                
                self.selectedIdList=[NSString stringWithFormat:@"%@,%@",self.selectedIdList,[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:i] objectForKey:@"player_id"]];
                
                
            }
           /* if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:i] objectForKey:@"UserID"] isEqualToString:[self.appDelegate.aDef objectForKey:LoggedUserID]]) {
                self.isAdminInvite=YES;
            }
            if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:i] objectForKey:@"UserID2"] isEqualToString:[self.appDelegate.aDef objectForKey:LoggedUserID]]) {
                self.isAdminInvite=YES;
            }
            if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:i] objectForKey:@"UserID3"] isEqualToString:[self.appDelegate.aDef objectForKey:LoggedUserID]]) {
                self.isAdminInvite=YES;
            }*/
        }
    }
    
    if (!self.selectedIdList)
    {
        
       /* UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Please select at least one player to invite" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];*/
        return;
        
    }
    
    
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"team_id"] forKey:@"team_id"];
    [command setObject:[self.appDelegate.aDef  objectForKey:LoggedUserID] forKey:@"coach_id"];
    
    
    [command setObject:self.inviteMessage forKey:@"text"];
    [command setObject:self.selectedIdList forKey:@"player_id"];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    // [writer release];
    
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    
    [appDelegate sendRequestFor:INVITEPLAYERS from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
    
}

- (IBAction)popuptapped:(id)sender {
    
    UIButton *btn=(UIButton *)sender;
    if (btn.tag==1) {
        [self inviteSubmit:sender];
    }
    
    
    self.popupalertvw.hidden=YES;
    self.popupinvitealertvw.hidden=YES;
    self.popupalertvwBack.hidden=YES;
}

-(void)invitePlayerAction:(UIButton *)sender{
    
    if ([[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach_id"] isEqualToString:[appDelegate.aDef objectForKey:LoggedUserID]] || [[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach_id2"] isEqualToString:[appDelegate.aDef objectForKey:LoggedUserID]]) {
        
        
        
        if([[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:sender.tag ] objectForKey:@"invites"] isEqualToString:NORESPONSE] /* ||  [[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:sender.tag ] objectForKey:@"invites"] isEqualToString:MAYBE] */){
            
            if (self.selectedInvitePlayer) {
                
                if ([[self.selectedInvitePlayer objectAtIndex:sender.tag] integerValue]) {
                    
                    [self.selectedInvitePlayer replaceObjectAtIndex:sender.tag withObject:@"0"];
                    
                }else{
                    
                    
                    [self.selectedInvitePlayer replaceObjectAtIndex:sender.tag withObject:@"1"];
                    
                }
            }
            //[self.tblView reloadData];
            
            
        }
        
        if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:sender.tag] objectForKey:@"invites"] isEqualToString:PENDING]){
            
            
            if (self.selectedInvitePlayer) {
                
                if ([[self.selectedInvitePlayer objectAtIndex:sender.tag] integerValue]) {
                    
                    [self.selectedInvitePlayer replaceObjectAtIndex:sender.tag withObject:@"0"];
                    
                }else{
                    
                    
                    [self.selectedInvitePlayer replaceObjectAtIndex:sender.tag withObject:@"1"];
                    
                }
            }
            [tblView reloadData];
            
        }
        [self inviteSubmit:sender];
        
    }
    self.btnInvitePlayer.hidden=YES;
  /*  for (int i=0; i<self.selectedInvitePlayer.count; i++) {
        if ([[self.selectedInvitePlayer objectAtIndex:i] integerValue]) {
            
            self.btnInvitePlayer.hidden=YES;
            
        }
    }*/
    
}


-(void)showAlertViewCustom
{
    self.popupalertvw.hidden=NO;
    self.popupalertvwBack.hidden=NO;
}


-(void)teamInviteAccept{
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    
    
        [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
    
        [command setObject:@"" forKey:@"Primary_UserID"];
    
    
    [command setObject:@"Accept" forKey:@"invites"];
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] valueForKey:@"team_id"] forKey:@"team_id"];
    [command setObject:@"0" forKey:@"start"];
    [command setObject:DEFAULTLIMIT forKey:@"limit"];
    [command setObject:@"" forKey:@"view"];
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    
    [self showNativeHudView];
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    
    
    self.requestDic=command;
    
    
    SingleRequest *sinReq=nil;
    sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:TEAMINVITESTATUSLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
    self.sinReq1=sinReq;
    [self.storeCreatedRequests addObject:self.sinReq1];
    sinReq.notificationName=TEAMINVITESTATUSBYPUSH;
    [self showHudView:@"Connecting..."];
    [sinReq startRequest];
}


-(void)checkForInviteAllBtn{
    int responseCount=0;
    
    for (int i=0; i<[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] count]; i++) {
        if([[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:i] objectForKey:@"invites"] isEqualToString:NORESPONSE] || [[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] objectAtIndex:i] objectForKey:@"invites"] isEqualToString:PENDING] ){
            
            responseCount++;
        }
    }
    /*if (responseCount>1) {
        <#statements#>
    }*/
}



///////////  AD  //////////////



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
    
    // self.pauseTimeCounting = NO;
}


-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    NSLog(@"Unable to show ads. Error: %@", [error localizedDescription]);
    
    // Hide the ad banner.
    [UIView animateWithDuration:0.5 animations:^{
        self.adBanner.alpha = 0.0;
    }];
}




@end
