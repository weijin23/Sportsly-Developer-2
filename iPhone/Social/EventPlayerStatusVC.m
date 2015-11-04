//
//  EventPlayerStatusVC.m
//  Wall
//
//  Created by Mindpace on 22/01/14.
//
//
#import "PlayerListViewController.h"
#import "ToDoByEventsVC.h"
#import "EventCalendarViewController.h"
#import "CalendarViewController.h"
#import "EventPlayerStatusVC.h"
#import "CenterViewController.h"
#import "InviteCell.h"
@interface EventPlayerStatusVC ()

@end

@implementation EventPlayerStatusVC

@synthesize acceptdeImage,
inviteSelectedImage,
inviteDeselectedImage,
declinedImage,
noResponeImage,
mayBeImage,playerIds,dataArray,eventId,eventTeamId,flagEventSelect,tickimage,nontickimage,headerTitle,isFromAttendance;
@synthesize normalImage;
//@synthesize isAdminInvite;

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusUpdated:) name:VIEWEVENTSTATUS object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(eventStatusUpdated:) name:VIEWEVENTSTATUS object:nil];
    // Do any additional setup after loading the view from its nib.
    //  self.view.backgroundColor=appDelegate.backgroundPinkColor;
    // self.topview.backgroundColor=appDelegate.barGrayColor;
    //self.isAdminInvite=NO;
    if(self.headerTitle)
    {
        self.mylab1.text=self.headerTitle;
    }
    
    @autoreleasepool {
        
        
        
        [self setStatusBarStyleOwnApp:0];
        
        /*
         self.acceptdeImage=[UIImage imageNamed:@"accepted_image.png"];
         self.inviteSelectedImage=[UIImage imageNamed:@"invite_selected_image.png"];
         self.reminderImage=[UIImage imageNamed:@"invite_send.png"];
         self.declinedImage=[UIImage imageNamed:@"decile_image.png"];
         self.noResponeImage=[UIImage imageNamed:@"reminder_send.png"];
         
         self.tickimage=[UIImage imageNamed:@"graytick.png"];
         self.nontickimage=[UIImage imageNamed:@"graynontick.png"];
         */
        if (self.isiPad) {
            self.acceptdeImage=[UIImage imageNamed:@"accept_invite_ipad.png"];
            self.inviteSelectedImage=[UIImage imageNamed:@"invite_player_ipad.png"];
            self.normalImage=[UIImage imageNamed:@"invite_player_ipad.png"];
            self.declinedImage=[UIImage imageNamed:@"declined_image_ipad.png"];
            self.noResponeImage=[UIImage imageNamed:@"not_response_ipad.png"];
            self.mayBeImage=[UIImage imageNamed:@"maybe_invite_ipad.png"];
        }
        else{
            self.acceptdeImage=[UIImage imageNamed:@"accept_invite.png"];
            self.inviteSelectedImage=[UIImage imageNamed:@"invite_player.png"];
            self.normalImage=[UIImage imageNamed:@"invite_player.png"];
            self.declinedImage=[UIImage imageNamed:@"declined_image.png"];
            self.noResponeImage=[UIImage imageNamed:@"not_response.png"];
            self.mayBeImage=[UIImage imageNamed:@"maybe_invite.png"];
        }
        //self.noResponeTickImage=[UIImage imageNamed:@"not_response_tick.png"];
        
        self.helveticaFont=  [UIFont fontWithName:@"Helvetica" size:14.0];
        
    }
    
    NSMutableArray *marray=[[NSMutableArray alloc] init];
    NSMutableArray *marray1=[[NSMutableArray alloc] init];
    
    
    self.playerIds=marray;
    self.dataArray=marray1;
    
    marray=nil;
    marray1=nil;
    
    
    //    [self showHudView:@"Connecting..."];
    //    [self showNativeHudView];
    
    [self performSelector:@selector(getPlayerListings) withObject:nil afterDelay:0.0];
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:VIEWEVENTSTATUS object:nil];
}


-(void)showAlertViewCustom
{
    self.popupalertvw.hidden=NO;
    self.popupalertvwback.hidden=NO;
}

- (IBAction)popuptapped:(UIButton *)sender
{

    self.popupalertvw.hidden=YES;
    self.popupalertvwback.hidden=YES;
    self.popupEventalertvw.hidden=YES;
    if (sender.tag) {
        [self tobBarAction:sender];
    }
//    else
//        [self hideHudViewHere];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [self setStatusBarStyleOwnApp:0];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
      [self setStatusBarStyleOwnApp:1];
}


-(void)getPlayerListings
{
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    [command setObject:self.eventTeamId forKey:@"team_id"];
    
    [command setObject:self.eventId forKey:@"event_id"];
    
    
  
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
  
    
    self.requestDic=command;
   // [appDelegate sendRequestFor:VIEWEVENTSTATUS from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
    
    SingleRequest *sinReq=[[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:VIEWEVENTSTATUSLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
    self.sinReq2=sinReq;
    
    [self.storeCreatedRequests addObject:self.sinReq2];
    sinReq.notificationName=VIEWEVENTSTATUS;
   
    [sinReq startRequest];

}





-(void)invitePlayerToServer
{
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    
  /*  NSString *playerId=[[NSString stringWithFormat:@"%@",self.playerIds ] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]];
    
    playerId=[playerId stringByReplacingOccurrencesOfString:@" " withString:@""];
     playerId=[playerId stringByReplacingOccurrencesOfString:@"\n" withString:@""];*/
    
 
    [command setObject:self.playerIds forKey:@"player_id"];
    
    [command setObject:self.eventId forKey:@"event_id"];
    
    
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
       NSLog(@"SelectedPlayerId=%@",jsonCommand);
    
    
    self.requestDic=command;
    [appDelegate sendRequestFor:SENDADDEVENTPUSH from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
}




- (void)statusUpdated:(NSNotification *)notif
{
    [self hideNativeHudView];
       [self hideHudView];
    SingleRequest *sReq=(SingleRequest*)[notif object];
    
    @autoreleasepool {
        
        
        if([sReq.notificationName isEqualToString:VIEWEVENTSTATUS])
        {
            if(sReq.responseData)
            {
                
                if (sReq.responseString)
                {
                    NSString *str=sReq.responseString;
                    
                    
                    self.msgLabel.hidden=NO;
                    self.noplayersimgvw.hidden=NO;
                    self.tbllView.hidden=YES;
                    self.viewSelectAll.hidden=YES;
                    self.viewMsg.hidden=YES;
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
                                
                                /* [self showHudAlert:[aDict objectForKey:@"message"]];
                                 [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];*/
                                self.requestDic=nil;
                                
                                
                                
                                aDict=[aDict objectForKey:@"response"];
                                
                                self.dataArray=[aDict objectForKey:@"ViewEventStatus"];
                                
                                
                                if(self.dataArray.count>0)
                                {
                                    [self setTableAndSelectView];
                                    self.tbllView.hidden=NO;
                                    self.viewSelectAll.hidden=NO;
                                    self.viewMsg.hidden=NO;
                                    
                                    self.selectedInvitePlayer=[[NSMutableArray alloc] init];
                                    
                                    for (int i=0; i< self.dataArray.count; i++){
                                        
                                        [self.selectedInvitePlayer addObject:@"0"];
                                    }
                                    
                                    
                                    [self.tbllView reloadData];
                                    
                                    BOOL fl=0;
                                    for(NSDictionary *selDic in self.dataArray)
                                    {
                                        
                                        
                                        
                                        if(([[selDic  objectForKey:@"EventStatus"] isEqualToString:NORESPONSE] /*||  [[selDic  objectForKey:@"EventStatus"] isEqualToString:MAYBE] */||  [[selDic  objectForKey:@"EventStatus"] isEqualToString:PENDING]))
                                        {
                                            fl=1;
                                            
                                            break;
                                        }
                                    }
                                    
                                    
                                    if(fl==0)
                                    {
                                        [self hideAllRelatedViews];
                                    }
                                    self.msgLabel.hidden=YES;
                                    self.noplayersimgvw.hidden=YES;
                                    
                                }
                                else
                                {
                                    [self hideAllRelatedViews];
                                }
                                
                                
                            }
                            else
                            {
                                [self hideAllRelatedViews];
                                //[self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
                            }
                        }
                        else
                        {
                            [self hideAllRelatedViews];
                            //[self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
                        }
                    }
                    
                    
                    
                    
                }
                else
                {
                    [self hideAllRelatedViews];
                }
                
            }
            else
            {
                [self hideAllRelatedViews];
            }
        }
    }
}

-(void)setTableAndSelectView{
    
    
    
        self.viewSelectAll.hidden=YES;
    
        if (self.isiPad) {
            if (self.selectedInvitePlayer.count==1) {
                self.tbllView.frame=CGRectMake(0,104, 768, self.view.bounds.size.height - 100);
                
            }
            else{
                self.tbllView.frame=CGRectMake(0,154, 768, self.view.bounds.size.height - 150);
            }
        }
        else{
            if (self.selectedInvitePlayer.count==1) {
                if (self.appDelegate.isIphone5) {
                    
                    self.tbllView.frame=CGRectMake(0, 64, 320,self.view.bounds.size.height - 66);
                    
                    
                }else{
                    self.tbllView.frame=CGRectMake(0, 64,320,self.view.bounds.size.height - 66);
                    
                }
            }
            else{
                if (self.appDelegate.isIphone5) {
                    
                    self.tbllView.frame=CGRectMake(0, 103, 320, self.view.bounds.size.height - 116);
                    
                }else{
                    
                    
                    self.tbllView.frame=CGRectMake(0, 81, 320, self.view.bounds.size.height - 116);
                    
                }
            }
        }
        
   
    
}


-(void)notifyRequesterWithData:(id) aData :(id)aData1
{
    
    [self hideHudView];
    [self hideNativeHudView];
    
    
    
    
    if([aData isKindOfClass:[ConnectionManager class]])
    {
        ConnectionManager *aR=(ConnectionManager*)aData;
        if([aR.requestSingleId isEqualToString:VIEWEVENTSTATUS])
        {
            [self hideAllRelatedViews];
        }
        else if([aR.requestSingleId isEqualToString:SENDADDEVENTPUSH])
        {
            
        }
        
        return;
    }
    
    
    NSString *str=(NSString*)aData;
    
    NSLog(@"Data=%@",str);
    
    
    ConnectionManager *aR=(ConnectionManager*)aData1;
    
    if([aR.requestSingleId isEqualToString:VIEWEVENTSTATUS])
    {
        
        self.msgLabel.hidden=NO;
        self.noplayersimgvw.hidden=NO;
        self.tbllView.hidden=YES;
        self.viewSelectAll.hidden=YES;
        self.viewMsg.hidden=YES;
        
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
                    
                    /* [self showHudAlert:[aDict objectForKey:@"message"]];
                     [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];*/
                    self.requestDic=nil;
                    
                    
                    
                    aDict=[aDict objectForKey:@"response"];
                    
                    self.dataArray=[aDict objectForKey:@"ViewEventStatus"];
                    
                    
                    if(self.dataArray.count>0)
                    {
                        
                        self.tbllView.hidden=NO;
                        self.viewSelectAll.hidden=NO;
                        self.viewMsg.hidden=NO;
                        
                        self.selectedInvitePlayer=[[NSMutableArray alloc] init];
                        
                        for (int i=0; i< self.dataArray.count; i++){
                            
                            [self.selectedInvitePlayer addObject:@"0"];
                        }
                        
                        
                        [self.tbllView reloadData];
                        
                        BOOL fl=0;
                        for(NSDictionary *selDic in self.dataArray)
                        {
                            
                            
                            
                            if(([[selDic  objectForKey:@"EventStatus"] isEqualToString:NORESPONSE] /*||  [[selDic  objectForKey:@"EventStatus"] isEqualToString:MAYBE] */||  [[selDic  objectForKey:@"EventStatus"] isEqualToString:PENDING]))
                            {
                                fl=1;
                                
                                break;
                            }
                        }
                        
                        
                        if(fl==0)
                        {
                            [self hideAllRelatedViews];
                        }
                        self.msgLabel.hidden=YES;
                        self.noplayersimgvw.hidden=YES;
                        
                    }
                    else
                    {
                        [self hideAllRelatedViews];
                    }
                    
                    
                }
                else
                {
                    [self hideAllRelatedViews];
                    //[self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
                }
            }
            else
            {
                [self hideAllRelatedViews];
                //[self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
            }
        }
        
        
    }
   /* else if([aR.requestSingleId isEqualToString:EVENTINVITESTATUS])
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
                    
                    
                    NSString *message=nil;
                    if([[self.requestDic objectForKey:@"Status"] isEqualToString:@"Accept"])
                    {
                       // [self saveToDeviceCalendar:dataEvent];
                        
                        message=@"Event Accepted";
                    }
                                        
                    //self.isFromPushBadge=1;
                    //[self showHudAlert:message];
                    //[self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
                    
                    
                    
                    
                    self.requestDic=nil;
                    
                    [self hideHudViewHere];
                    self.isAdminInvite=NO;
                    [self performSelector:@selector(getPlayerListings) withObject:nil afterDelay:2.0];
                    //[self showAlertViewCustom];
                }
                else
                {
                    [self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
                }
            }
        }
        
        
    }*/
    else
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
                    
                    /*[self showHudAlert:@"Invite sent"];
                     [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];*/
                    
                    //Subhasish..16th March
                   /* self.requestDic=nil;
                    if (self.isAdminInvite==YES) {
                        [self performSelector:@selector(acceptEventInvite) withObject:nil afterDelay:2.0];
                    }
                    else{
                        [self performSelector:@selector(getPlayerListings) withObject:nil afterDelay:2.0];
                    }*/
                    self.requestDic=nil;
                    [self performSelector:@selector(getPlayerListings) withObject:nil afterDelay:2.0];
                    [self showAlertViewCustom];
                    
                }
                else
                {
                    [self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
                }
            }
        }        
    }
    
}



-(void)hideAllRelatedViews
{
    self.sendbt.hidden=YES;
    self.selectallbt.hidden=YES;
//    self.viewSelectAll.hidden=YES;
    self.selectAllEvent.hidden=YES;
//    self.viewMsg.hidden=YES;
    
    self.msgLabel.hidden=NO;
    self.noplayersimgvw.hidden=NO;
}


-(void)hideHudViewHere
{
    [self hideHudView];
    
   // [self.navigationController popViewControllerAnimated:YES];
    [self dismissModal];
    
    
    
    
    
    if(!isFromAttendance)
    {
    EventCalendarViewController *eVC=(EventCalendarViewController*) [appDelegate.navigationControllerCalendar.viewControllers objectAtIndex:0];
    [appDelegate.navigationControllerCalendar popToRootViewControllerAnimated:NO];
    
    
    self.appDelegate.centerViewController.isShowMainCalendarFirstScreeen=0;
    eVC.eventheaderlab.text=CREATETEAMEVENTINVITATION;
    eVC.isMonth=0;
    eVC.custompopuptopselectionvw.hidden=YES;
    eVC.custompopupbottomvw.hidden=YES;
    eVC.topSegCntrl.selectedSegmentIndex=eVC.isMonth;
    eVC.callistvc.fetchFirstDate=nil;
    eVC.callistvc.fetchLastDate=nil;
    eVC.callistvc.selTeamId=nil;
    eVC.callistvc.selplayerId=nil;
    eVC.callistvc.selShowByStatus=0;
    eVC.callistvc.isSelShowByStatus=0;
    eVC.callistvc.fetchedResultsController=nil;
    [eVC.callistvc loadTable];
    eVC.calvc.view.hidden=YES;
    eVC.callistvc.view.hidden=NO;
    eVC.downarrowfilterimavw.hidden=NO;
    eVC.downarrowfilterbt.hidden=NO;
    
    
    
    [eVC.calvc.monthView reloadData];

    
    
    [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerCalendar];
    
   
    
    PlayerListViewController *player=[[PlayerListViewController alloc] initWithNibName:@"PlayerListViewController" bundle:nil];
   
    player.eventId=self.eventId;
    player.teamId=self.eventTeamId;
    [appDelegate.navigationControllerCalendar pushViewController:player animated:YES];
    }
    else
    {
        
         PlayerListViewController *pVC=(PlayerListViewController*) [appDelegate.navigationControllerCalendar.viewControllers lastObject];
        
        
        [pVC teamPlayerList];
        
    }
   
}







- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
    
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
    /*static NSString *CellIdentifier = @"InvitePlayerCell";
    
    InviteCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell=[InviteCell inviteCell];
        
    }
    
    [self configureCell:cell atIndexPath:indexPath andTableView:tableView];
    return cell;*/
    
    
    static NSString *CellIdentifier = @"InvitePlayerCell";
    
    InvitePlayerListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell=[InvitePlayerListCell inviteCell];
        //[cell.callBtn addTarget:self action:@selector(invitePlayerAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.callBtn.userInteractionEnabled=NO;
    }
    
    [self configureCell:cell atIndexPath:indexPath andTableView:tableView];
    return cell;

    
}

///////  07/03/2015  //////////
/*
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath andTableView:(UITableView*)tableview
{
    
   InviteCell *inviteCell=(InviteCell*)cell;
     NSDictionary *selDic=[self.dataArray objectAtIndex:indexPath.row];
   
    
        inviteCell.playerNameLbl.text=[selDic objectForKey:@"player_name"];
    
        
        if ([[selDic  objectForKey:@"EventStatus"] isEqualToString:@"Accept"])
        {
            
            inviteCell.statusLbl2.textColor=[self colorWithHexString:@"33CC66"];
            inviteCell.statusLbl2.text=@"Accepted";
            inviteCell.statusImageVw.image=self.acceptdeImage;
            inviteCell.statuslbl.text=@"";

            
        }else if ([[selDic  objectForKey:@"EventStatus"] isEqualToString:@"Decline"]){
            
            
            
            inviteCell.statusLbl2.textColor=[UIColor blackColor];
            inviteCell.statusLbl2.text=@"Declined";
            inviteCell.statusImageVw.image=self.declinedImage;
            inviteCell.statuslbl.text=@"";
            

            
            
        } else if(  [[selDic  objectForKey:@"EventStatus"] isEqualToString:MAYBE] ){
            
            if (self.selectedInvitePlayer) {
                
                if (self.selectedInvitePlayer) {
                    
                    if ([[self.selectedInvitePlayer objectAtIndex:indexPath.row] integerValue]) {
                        
                        inviteCell.statusImageVw.hidden=NO;
                        inviteCell.statuslbl.textColor=[UIColor colorWithRed:50.0/255.0 green:134.0/255.0 blue:203.0/255.0 alpha:1.0];
                        inviteCell.statuslbl.text=@"Reminder will be sent";
                        inviteCell.statusImageVw.image=self.inviteSelectedImage;
                        inviteCell.statusLbl2.text=@"";
                        
                        
                    }else{
                        
                        inviteCell.statusLbl2.textColor=[UIColor blackColor];
                        inviteCell.statusLbl2.text=@"Maybe                    Send Reminder?";
                        inviteCell.statusImageVw.image=self.noResponeImage;
                        inviteCell.statusImageVw.hidden=YES;
                        inviteCell.statuslbl.text=@"";
                        
                        
                        
                    }
              }
            
           }
        }
        else if([[selDic  objectForKey:@"EventStatus"] isEqualToString:NORESPONSE]  ){
            
            if (self.selectedInvitePlayer) {
                
                if (self.selectedInvitePlayer) {
                    
                    if ([[self.selectedInvitePlayer objectAtIndex:indexPath.row] integerValue]) {
                        
                        inviteCell.statusImageVw.hidden=NO;
                        inviteCell.statuslbl.textColor=[UIColor colorWithRed:50.0/255.0 green:134.0/255.0 blue:203.0/255.0 alpha:1.0];
                        inviteCell.statuslbl.text=@"Reminder will be sent";
                        inviteCell.statusImageVw.image=self.inviteSelectedImage;
                        inviteCell.statusLbl2.text=@"";
                        
                        
                    }else{
                        
                        inviteCell.statusLbl2.textColor=[UIColor blackColor];
                        inviteCell.statusLbl2.text=@"No Response                     Send Reminder?";
                        inviteCell.statusImageVw.image=self.noResponeImage;
                        inviteCell.statusImageVw.hidden=YES;
                        inviteCell.statuslbl.text=@"";
                        
                        
                        
                    }
                }
                
            }
        }
        else if ([[selDic  objectForKey:@"EventStatus"] isEqualToString:PENDING]  )
        {
            
                if (self.selectedInvitePlayer) {
                    
                    if ([[self.selectedInvitePlayer objectAtIndex:indexPath.row] integerValue]) {
                        
                        inviteCell.statusImageVw.hidden=NO;
                        inviteCell.statuslbl.textColor=[UIColor colorWithRed:50.0/255.0 green:134.0/255.0 blue:203.0/255.0 alpha:1.0];
                        inviteCell.statuslbl.text=@"Invite will be sent";
                        inviteCell.statusImageVw.image=self.inviteSelectedImage;
                        inviteCell.statusLbl2.text=@"";
                        
                    }else{
                        inviteCell.statusLbl2.textColor=[UIColor redColor];
                        inviteCell.statusLbl2.text=@"Send Invite?";
                        inviteCell.statusImageVw.hidden=YES;
                        inviteCell.statusImageVw.image=self.reminderImage;
                        inviteCell.statuslbl.text=@"";
                        
                        
                    }
            }
            
        }
    
    NSString *imgUrl= [NSString stringWithFormat:@"%@%@",IMAGELINK,[selDic objectForKey:@"ProfileImage"]];
       [inviteCell.profileImageVw cleanPhotoFrame];
    if (![[selDic objectForKey:@"ProfileImage"] isEqualToString:@""]) {
        
        [inviteCell.profileImageVw applyPhotoFrame];
        [inviteCell.profileImageVw setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:self.noImage];
        
    }else{
     
        [inviteCell.profileImageVw setImage:self.noImage];
    }
 
    
    
    
    
    
}
*/

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath andTableView:(UITableView*)tableview
{
    
    InvitePlayerListCell*cell1=(InvitePlayerListCell*)cell;
    
    cell1.callBtn.tag=indexPath.row;
    cell1.lblNumber.text=[NSString stringWithFormat:@"%d.",indexPath.row+1];
    NSDictionary *selDic=[self.dataArray objectAtIndex:indexPath.row];
    cell1.playerNameLbl.text=[selDic objectForKey:@"player_name"];
    
    NSString *imgUrl= [NSString stringWithFormat:@"%@%@",IMAGELINK,[selDic objectForKey:@"ProfileImage"]];
    [cell1.profileImageVw cleanPhotoFrame];
    if (![[selDic objectForKey:@"ProfileImage"] isEqualToString:@""]) {
        
        [cell1.profileImageVw applyPhotoFrame];
        [cell1.profileImageVw setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:self.noImage];
        
    }else{
        
        [cell1.profileImageVw setImage:self.noImage];
    }
    
    /////////  04/03/2015 ///////
    
    
    if ([[selDic  objectForKey:@"EventStatus"] isEqualToString:@"Accept"]) {
        
        
        [cell1.callBtn setImage:self.acceptdeImage forState:UIControlStateNormal];
        cell1.callBtn.userInteractionEnabled=NO;
        
    }else if ([[selDic  objectForKey:@"EventStatus"] isEqualToString:@"Decline"]){
        
        
        [cell1.callBtn setImage:self.declinedImage forState:UIControlStateNormal];
        cell1.callBtn.userInteractionEnabled=NO;
        
        
    } else if( [[selDic  objectForKey:@"EventStatus"] isEqualToString:MAYBE] ){
        
        
       /* if (self.selectedInvitePlayer) {
            
            if ([[self.selectedInvitePlayer objectAtIndex:indexPath.row] integerValue]) {
                
                //[cell1.callBtn setImage:self.inviteSelectedImage forState:UIControlStateNormal];
                [cell1.callBtn setImage:self.mayBeImage forState:UIControlStateNormal];
                
            }else{*/
                
                [cell1.callBtn setImage:self.mayBeImage forState:UIControlStateNormal];
                cell1.callBtn.userInteractionEnabled=NO;
                
                
//            }
//        }
        
        
        
    }else if([[selDic  objectForKey:@"EventStatus"] isEqualToString:NORESPONSE]   ){
        
        
        if (self.selectedInvitePlayer) {
            
            if ([[self.selectedInvitePlayer objectAtIndex:indexPath.row] integerValue]) {
                
                //[cell1.callBtn setImage:self.inviteSelectedImage forState:UIControlStateNormal];
                [cell1.callBtn setImage:self.noResponeImage forState:UIControlStateNormal];
                
                
            }else{
                
                [cell1.callBtn setImage:self.noResponeImage forState:UIControlStateNormal];
                
                
                
            }
        }
        
        
        
    }
    else if ([[selDic  objectForKey:@"EventStatus"] isEqualToString:PENDING]){
        
        
        if (self.selectedInvitePlayer) {
            
            if ([[self.selectedInvitePlayer objectAtIndex:indexPath.row] integerValue]) {
                
                [cell1.callBtn setImage:self.normalImage forState:UIControlStateNormal];
                
            }else{
                [cell1.callBtn setImage:self.normalImage forState:UIControlStateNormal];
                
                
            }
        }
        
    }
}

/////////////// AD //////////



#pragma mark - TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
      NSDictionary *selDic=[self.dataArray objectAtIndex:indexPath.row];
    
  if([[selDic  objectForKey:@"EventStatus"] isEqualToString:NORESPONSE] /*||  [[selDic  objectForKey:@"EventStatus"] isEqualToString:MAYBE]*/ ){
        
        if (self.selectedInvitePlayer) {
            
            if ([[self.selectedInvitePlayer objectAtIndex:indexPath.row] integerValue]) {
                
                [self.selectedInvitePlayer replaceObjectAtIndex:indexPath.row withObject:@"0"];
                
            }else{
                
                
                [self.selectedInvitePlayer replaceObjectAtIndex:indexPath.row withObject:@"1"];
                
            }
        }
       // [tableView reloadData];
        
    }
    
   if ([[selDic  objectForKey:@"EventStatus"] isEqualToString:PENDING]  ){
        
        
        if (self.selectedInvitePlayer) {
            
            if ([[self.selectedInvitePlayer objectAtIndex:indexPath.row] integerValue]) {
                
                [self.selectedInvitePlayer replaceObjectAtIndex:indexPath.row withObject:@"0"];
                
            }else{
                
                
                [self.selectedInvitePlayer replaceObjectAtIndex:indexPath.row withObject:@"1"];
                
            }
        }
       // [tableView reloadData];
        
    }
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag=1;
    [self tobBarAction:btn];
    
}






- (IBAction)selectAllEventAction:(id)sender
{
     if(!flagEventSelect)
    {
        int i=0;
        
        for(NSDictionary *selDic in self.dataArray)
        {
            NSString *playerId=   [selDic objectForKey:@"player_id"];
            
            
            
            if([[selDic  objectForKey:@"EventStatus"] isEqualToString:NORESPONSE] /*||  [[selDic  objectForKey:@"EventStatus"] isEqualToString:MAYBE] */)
            {
                
                //            if( ![self.playerIds containsObject:playerId ])
                //            {
                //                [self.playerIds addObject:playerId];
                //            }
                
                [self.selectedInvitePlayer replaceObjectAtIndex:i withObject:@"1"];
                
                
            }
            else if ([[selDic  objectForKey:@"EventStatus"] isEqualToString:PENDING]  )
            {
                
                //            if( ![self.playerIds containsObject:playerId ])
                //            {
                //                [self.playerIds addObject:playerId];
                //            }
                [self.selectedInvitePlayer replaceObjectAtIndex:i withObject:@"1"];
                
            }
            
            i++;
        }
        
        
        flagEventSelect=1;
        
        [self.selectAllEvent setImage:self.tickimage forState:UIControlStateNormal];
        
    }
    else
    {
        
        int i=0;
        for(NSDictionary *selDic in self.dataArray)
        {
            NSString *playerId=   [selDic objectForKey:@"player_id"];
            
            
            
            if([[selDic  objectForKey:@"EventStatus"] isEqualToString:NORESPONSE]/* ||  [[selDic  objectForKey:@"EventStatus"] isEqualToString:MAYBE] */)
            {
                
                //                if( [self.playerIds containsObject:playerId ])
                //                {
                //                    [self.playerIds removeObject:playerId];
                //                }
                
                [self.selectedInvitePlayer replaceObjectAtIndex:i withObject:@"0"];
            }
            else if ([[selDic  objectForKey:@"EventStatus"] isEqualToString:PENDING]  )
            {
                //                if( [self.playerIds containsObject:playerId ])
                //                {
                //                    [self.playerIds removeObject:playerId];
                //                }
                [self.selectedInvitePlayer replaceObjectAtIndex:i withObject:@"0"];
            }
            i++;
        }
        
        
        flagEventSelect=0;
        
        [self.selectAllEvent setImage:self.nontickimage forState:UIControlStateNormal];
        
        
    }
    
    
    
    
    [self showAlertForInvite];
    
    //[self.tbllView reloadData];
    
    
    
}

-(void)showAlertForInvite{
    
    self.popupalertvwback.hidden=NO;
    self.popupEventalertvw.hidden=NO;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}








- (IBAction)tobBarAction:(id)sender
{
    
    int tag=[sender tag];
    
    if(tag==0)
    {
        //[self.navigationController popViewControllerAnimated:YES];
        [self dismissModal];
        [self dismissModalEventInvte];
    }
    else if(tag==1)
    {
        self.playerIds=nil;
        self.playerIds=[[NSMutableArray alloc] init];
        NSMutableArray *playerUserIds=[[NSMutableArray alloc] init];
        for (int i=0; i<self.selectedInvitePlayer.count; i++) {
            
             if ([[self.selectedInvitePlayer objectAtIndex:i] integerValue]) {
                 
                 [self.playerIds addObject:[NSNumber numberWithInt:[[[self.dataArray objectAtIndex:i] objectForKey:@"player_id"] intValue] ]];
                 [playerUserIds addObject:[[self.dataArray objectAtIndex:i] objectForKey:@"user_id"]];
                 
             }
            
        }
       /* self.isAdminInvite=NO;
        for (int i=0; i<playerUserIds.count; i++) {
            if ([[playerUserIds objectAtIndex:i] isEqualToString:[self.appDelegate.aDef objectForKey:LoggedUserID]]) {
                self.isAdminInvite=YES;
                break;
            }
        }*/
        
        if(self.playerIds.count>0)
        {
            
            [self showHudView:@"Connecting..."];
            [self showNativeHudView];
            [self performSelector:@selector(invitePlayerToServer) withObject:nil afterDelay:0.0];

        }
        else
        {
           // [self showAlertMessage:@"Please select atleast one player."];
        }
        
    }
    
    
    
}
/*-(void)acceptEventInvite{
    
    
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    [command setObject:[self.appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];//[appDelegate.aDef objectForKey:LoggedUserID]
    [command setObject:@"Accept" forKey:@"Status"];
    [command setObject:self.eventId forKey:@"event_id"];
    
//    if(![[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:playerId])
//        [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"Primary_UserID"];
//    else
        [command setObject:@"" forKey:@"Primary_UserID"];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    
    
    self.requestDic=command;
    [appDelegate sendRequestFor:EVENTINVITESTATUS from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
    

}*/
@end
