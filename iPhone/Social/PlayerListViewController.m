//
//  PlayerListViewController.m
//  Wall
//
//  Created by Sukhamoy on 12/11/13.
//
//
#import "EventPlayerStatusVC.h"
#import "EventPlayerCell.h"
#import "CenterViewController.h"
#import "PlayerListViewController.h"
//#import "RightVCTableData.h"
//#import "RightVCTableCell.h"
#import "PlayerDetails.h"
#import "HomeVC.h"
@interface PlayerListViewController ()

@end

@implementation PlayerListViewController
@synthesize dataArray,questionmarkimage,rightmarkimage,crossmarkimage,eventId,teamId,maybeQuestionmarkImage,dataArray1,strTitle;

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
    // Do any additional setup after loading the view from its nib.
   // self.topview.backgroundColor=appDelegate.barGrayColor;
   // self.view.backgroundColor=appDelegate.backgroundPinkColor;
    
    self.dataArray=[[NSMutableArray alloc] init];

    @autoreleasepool {
        
        if (self.isiPad) {
            self.tickImage=[UIImage imageNamed:@"accepted_image_invite_ipad.png"];//acceptinvite.png
            self.crossImage=[UIImage imageNamed:@"decile_image_invite_ipad.png"];//declineinvite.png
            self.questionmarkImage=[UIImage imageNamed:@"reminder_send_invite_ipad.png"];
            self.maybeQuestionmarkImage=[UIImage imageNamed:@"maybe_image_invite_ipad.png"];
        }
        else{
            //            self.tickImage=[UIImage imageNamed:@"accepted_image.png"];//acceptinvite.png
            //            self.crossImage=[UIImage imageNamed:@"decile_image.png"];//declineinvite.png
            self.tickImage=[UIImage imageNamed:@"accepted_image_invite.png"];//acceptinvite.png
            self.crossImage=[UIImage imageNamed:@"decile_image_invite.png"];//declineinvite.png
            self.questionmarkImage=[UIImage imageNamed:@"reminder_send_invite.png"];
            self.maybeQuestionmarkImage=[UIImage imageNamed:@"maybe_image_invite.png"];
        }
    }
    
   /* @autoreleasepool
    {
        
        self.tickImage=[UIImage imageNamed:@"accepted_image.png"];//acceptinvite.png
        self.questionmarkImage=[UIImage imageNamed:@"reminder_send.png"];//noresponsemaybe.png
        self.crossImage=[UIImage imageNamed:@"decile_image.png"];//declineinvite.png
        self.maybeQuestionmarkImage=[UIImage imageNamed:@"invite_send.png"];//maybeinvite.png
    }*/
    
    [self teamPlayerList];
    
    
    //self.sendbt.hidden=YES;
    
    int indx=0;
    NSArray *arrTeamId= self.appDelegate.centerVC.dataArrayUpButtonsIds;
    for (int i=0; i<arrTeamId.count; i++) {
        if ([self.teamId isEqualToString:[arrTeamId objectAtIndex:i]]) {
            indx=i;
            break;
        }
    }
    NSNumber *number= [self.appDelegate.centerVC.dataArrayUpIsCreated objectAtIndex:indx];
    if ([number boolValue]==0) {
        self.sendbt.hidden=YES;
        self.viewMessage.hidden=YES;
    }
    else {
        
        self.sendbt.hidden=NO;
        self.viewMessage.hidden=NO;
    }
    
    
    UIFont *font = [UIFont systemFontOfSize:9.0];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:NSFontAttributeName];
    [self.segControl setTitleTextAttributes:attributes
                                    forState:UIControlStateNormal];
}



-(void)showNavigationBarButtons
{
    
    if(!self.leftBarButtonItem)
    {
        self.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backwhite.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleLeftPanel:)];
    }
    
    if(!self.rightBarButtonItem)
    {
        //self.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"eventfilter.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleRightPanel:)];
    }
    
    
    //appDelegate.centerViewController.navigationItem.title=@"Invitees";
   // appDelegate.centerViewController.navigationItem.titleView=nil;
    
    //appDelegate.centerViewController.navigationItem.title=@"Players Attending";
    
    
    appDelegate.centerViewController.navigationItem.title=self.strTitle;  //// 16/01/15
    // appDelegate.centerViewController.navigationItem.titleView=nil;
    
    appDelegate.centerViewController.navigationItem.leftBarButtonItem=self.leftBarButtonItem;
    
    appDelegate.centerViewController.navigationItem.rightBarButtonItem=self.rightBarButtonItem;
    
    
    [self setStatusBarStyleOwnApp:1];
    
}

-(void)toggleLeftPanel:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)toggleRightPanel:(id)sender
{
    
    
    
    
    
    
}



-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
      
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
     [[NSNotificationCenter defaultCenter] removeObserver:self name:HANDLERECEIVEDMEMORYWARNING object:nil];
    [_tableView release];
  //  [dataArray release];
//    self.questionmarkimage=nil;
//    self.rightmarkimage=nil;
//    self.crossmarkimage=nil;
    [super dealloc];
}

-(void)teamPlayerList{
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    [command setObject:self.eventId forKey:@"event_id"];
    [command setObject:self.teamId forKey:@"team_id"];
    
   
    
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    [writer release];
    
    
    [self showNativeHudView];
    
    [self sendRequestForTeamData:jsonCommand];
    
}
-(void)sendRequestForTeamData:(NSString*)dic
{
   
    
    NSURL* url = [NSURL URLWithString:VIEWEVENTSTATUSLINK];
    ASIFormDataRequest *aRequest=  [ASIFormDataRequest requestWithURL:url];
    [aRequest setShouldContinueWhenAppEntersBackground:YES];
    
    [aRequest setDelegate:self];
    [aRequest setValidatesSecureCertificate:NO];
    [ASIFormDataRequest setShouldThrottleBandwidthForWWAN:YES];
    
    [aRequest addPostValue:dic forKey:@"requestParam"];
    [aRequest setDidFinishSelector:@selector(requestFinished:)];
    [aRequest setDidFailSelector:@selector(requestFailed:)];
    
    [aRequest startAsynchronous];
    
    
}


- (void)requestFinished:(ASIHTTPRequest *)request
{
    
   
    [self hideNativeHudView];
    NSString *str=[request responseString];
    
    NSLog(@"Data=%@",str);
    
    
    self.noplayersvw.hidden=NO;
    self.sendbt.hidden=YES;
    self.viewMessage.hidden=YES;
    
    if(str)
        
    {
        SBJsonParser *parser=[[SBJsonParser alloc] init];
        
        id res = [parser objectWithString:str];
        [parser release];
        if ([res isKindOfClass:[NSDictionary class]])
        {
            NSDictionary* aDict = (NSDictionary*) res;
            
         
            
            if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
            {
                
                
                
                aDict=[aDict objectForKey:@"response"];
                
                self.dataArray1=[aDict objectForKey:@"ViewEventStatus"];
                
                if(dataArray1.count>0)
                {
                    //self.segControl.hidden=NO;
                    
                    @autoreleasepool {
                        
                        
                        
                        self.dataArray=self.dataArray1;//(NSMutableArray*)[dataArray1 filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"EventStatus==%@",@"Accept"]];
                    }
                    
                    if(dataArray.count>0)
                    {
                        self.noplayersvw.hidden=YES;
                        
                        int indx=0;
                        NSArray *arrTeamId= self.appDelegate.centerVC.dataArrayUpButtonsIds;
                        for (int i=0; i<arrTeamId.count; i++) {
                            if ([self.teamId isEqualToString:[arrTeamId objectAtIndex:i]]) {
                                indx=i;
                                break;
                            }
                        }
                        NSNumber *number= [self.appDelegate.centerVC.dataArrayUpIsCreated objectAtIndex:indx];
                        if ([number boolValue]==0) {
                            self.sendbt.hidden=YES;
                            self.viewMessage.hidden=YES;
                        }
                        else{
                            self.sendbt.hidden=NO;
                            self.viewMessage.hidden=NO;
                        }
                        
                    }
                    else
                    {
                        self.noplayersvw.hidden=NO;
                         self.sendbt.hidden=YES;
                        self.viewMessage.hidden=YES;
                    }
                    
                }
                else
                {
                      @autoreleasepool {
                          
                          self.dataArray=[NSMutableArray array];
                      }
                    
                    self.noplayersvw.hidden=NO;
                     self.sendbt.hidden=YES;
                    self.viewMessage.hidden=YES;
                }
                
                
                
                
                
              // self.dataArray=[[[aDict objectForKey:@"response"] objectForKey:@"event_details"] objectForKey:@"player_details"];
                
                self.tableView.delegate=self;
                self.tableView.dataSource=self;
                [self.tableView reloadData];
                
            }
        }
    }
}



            







- (void)requestFailed:(ASIHTTPRequest *)request
{
   
    [self hideNativeHudView];
	NSLog(@"Error receiving dataImage : %@ ",[request.error description]);
	//[self showAlertMessage:CONNFAILMSG];ChAfter
     self.noplayersvw.hidden=NO;
     self.sendbt.hidden=YES;
    self.viewMessage.hidden=YES;
	
}

- (IBAction)settingsbTapped:(id)sender
{
    
    [self.appDelegate.centerViewController showNavController:appDelegate.navigationControllerSettings];
}


#pragma mark - TableViewDataSorace

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count] ;//+ 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.isiPad)
        return 60.0;
    
    return 50.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EventPlayerCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier]; ;
    
    
    
    if (cell == nil)
    {
                          
        cell =[EventPlayerCell cellFromNibNamed:@"EventPlayerCell"];
        cell.layer.cornerRadius=3.0;
        cell.layer.masksToBounds=YES;
    }
    
        
    [self configureCell:cell atIndexPath:indexPath andTableView:tableView];
    
        
    return cell;
       
}



- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath andTableView:(UITableView*)tableview
{
    
    
            
    EventPlayerCell *cell1=(EventPlayerCell*)cell;
    
    [cell1.profileimavw cleanPhotoFrame];
   

                   
    cell1.selectionStyle=UITableViewCellSelectionStyleNone;
    
           
        @autoreleasepool
        {
            
            if(![[[self.dataArray objectAtIndex:indexPath.row ] valueForKey:PROFILEIMAGE] isEqualToString:@""])
            {
            [cell1.profileimavw setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGELINKTHUMB,[[self.dataArray objectAtIndex:indexPath.row ] valueForKey:PROFILEIMAGE]]] placeholderImage:self.noImage];
             [cell1.profileimavw applyPhotoFrame];
            }
            else
            {
                [cell1.profileimavw setImage:self.noImage];
            }
        }
        
        
        cell1.userName.text=[[self.dataArray objectAtIndex:indexPath.row ] valueForKey:@"player_name"];
        
          cell1.imastatus_firstvw.hidden=NO;
        cell1.statusNameLab.hidden=YES;
        if ([[[self.dataArray objectAtIndex:indexPath.row ] valueForKey:@"EventStatus"] isEqualToString:@"Pending"]) {
            cell1.imastatus_firstvw.image=self.questionmarkImage;
            
        }else if ([[[self.dataArray objectAtIndex:indexPath.row ] valueForKey:@"EventStatus"] isEqualToString:@"Decline"]){
            cell1.imastatus_firstvw.image=self.crossImage;
            cell1.imastatus_firstvw.hidden=NO;
            
            
        }else if ([[[self.dataArray objectAtIndex:indexPath.row ] valueForKey:@"EventStatus"] isEqualToString:@"Accept"]){
            
            cell1.imastatus_firstvw.image=self.tickImage;
              cell1.imastatus_firstvw.hidden=NO;
        }
        else if ([[[self.dataArray objectAtIndex:indexPath.row ] valueForKey:@"EventStatus"] isEqualToString:@"Maybe"]){
            
            cell1.imastatus_firstvw.image=self.maybeQuestionmarkImage;
            cell1.imastatus_firstvw.hidden=NO;
            

        }
        else if ([[[self.dataArray objectAtIndex:indexPath.row ] valueForKey:@"EventStatus"] isEqualToString:NORESPONSE]){
            
            cell1.imastatus_firstvw.image=self.questionmarkImage;
            cell1.imastatus_firstvw.hidden=NO;

        }

    
    
          
      
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (indexPath.row==0) {
//        
//        
//    }else{
//        if ([[appDelegate.centerVC.dataArrayUpIsCreated objectAtIndex:appDelegate.centerVC.lastSelectedTeam] integerValue]) {
//            PlayerDetails *details=[[PlayerDetails alloc] initWithNibName:@"PlayerDetails" bundle:nil];
//            
//            details.dataArray=self.dataArray;
//            details.selectedPlayer=indexPath.row - 1;
//            [self.navigationController pushViewController:details animated:YES];
//            
//            [details release];
//            
//        } else{
//            [self sendSMS:[[self.dataArray objectAtIndex:indexPath.row -1]  objectForKey:@"ph_no"] :nil];
//            
//        }
//
//    }
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)segAction:(UISegmentedControl*)sender
{
    
    
    
    @autoreleasepool
    {
        
    
    if(sender.selectedSegmentIndex==0)
    {
         self.dataArray=(NSMutableArray*)[dataArray1 filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"EventStatus==%@",@"Accept"]];
    }
    else if(sender.selectedSegmentIndex==1)
    {
         self.dataArray=(NSMutableArray*)[dataArray1 filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"EventStatus==%@",@"Maybe"]];
    }
    else if(sender.selectedSegmentIndex==2)
    {
         self.dataArray=(NSMutableArray*)[dataArray1 filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"EventStatus==%@",@"Decline"]];
    }
    else if(sender.selectedSegmentIndex==3)
    {
         self.dataArray=(NSMutableArray*)[dataArray1 filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"EventStatus==%@",NORESPONSE]];
    }
    else if(sender.selectedSegmentIndex==4)
    {
         self.dataArray=(NSMutableArray*)[dataArray1 filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"EventStatus==%@",@"Pending"]];
    }
    }
   
    if(dataArray.count>0)
    {
         self.noplayersvw.hidden=YES;
        
        int indx=0;
        NSArray *arrTeamId= self.appDelegate.centerVC.dataArrayUpButtonsIds;
        for (int i=0; i<arrTeamId.count; i++) {
            if ([self.teamId isEqualToString:[arrTeamId objectAtIndex:i]]) {
                indx=i;
                break;
            }
        }
        NSNumber *number= [self.appDelegate.centerVC.dataArrayUpIsCreated objectAtIndex:indx];
        if ([number boolValue]==0) {
            self.sendbt.hidden=YES;
            self.viewMessage.hidden=YES;
        }
        else{
            self.sendbt.hidden=NO;
            self.viewMessage.hidden=NO;
        }
         //self.sendbt.hidden=NO;
    }
    else
    {
        self.noplayersvw.hidden=NO;
         self.sendbt.hidden=YES;
        self.viewMessage.hidden=YES;
    }
    
    [self.tableView reloadData];
    
}



- (IBAction)sendInviteAction:(id)sender
{
    
    
    
    EventPlayerStatusVC *player=[[EventPlayerStatusVC alloc] initWithNibName:@"EventPlayerStatusVC" bundle:nil];
    player.isFromAttendance=1;
    player.eventId=self.eventId;
    player.eventTeamId=self.teamId;
    
    
    self.isModallyPresentFromCenterVC=1;
    [self showModal:player];
    
}
@end
