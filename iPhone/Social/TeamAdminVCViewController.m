//
//  TeamAdminVCViewController.m
//  Wall
//
//  Created by Sukhamoy on 12/04/14.
//
//

#import "TeamAdminVCViewController.h"
#import "InvitePlayerListCell.h"
#import "ChatViewController.h"
#import "CenterViewController.h"
#import "TeamMaintenanceVC.h"
#import "TeamDetailsViewController.h"
#import "AddAdminViewController.h"
#import "SpectatorViewController.h"

@interface TeamAdminVCViewController ()

@end

@implementation TeamAdminVCViewController
@synthesize admin,acceptdeImage,noResponeImage;

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
    if (self.isiPad) {
        NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:20], UITextAttributeFont, nil];
        [self.segmnetCtrl setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    }
    if(self.isiPad){
        self.acceptdeImage=[UIImage imageNamed:@"accept_invite_ipad.png"];
        self.noResponeImage=[UIImage imageNamed:@"not_response_admn_ipad.png"];
    }
    else{
        self.acceptdeImage=[UIImage imageNamed:@"accept_invite.png"];
        self.noResponeImage=[UIImage imageNamed:@"not_response_admn.png"];
    }

}

-(void)viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:animated];
    [self.segmnetCtrl setSelectedSegmentIndex:2];
    NSLog(@"Segment Details :%d",self.segmnetCtrl.selectedSegmentIndex);
    
    [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] showRightButton:0];
    
    
    //For Admin  One Details
     self.count=0;
    
    if (![[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_name"] isEqualToString:@""]) {
        
        self.count++;
        
    }
    if (![[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_name2"] isEqualToString:@""]) {
        
        if (![[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach2_status"] isEqualToString:@"Decline"]) {
        
            self.count++;
        }
        
    }

    [self.tblVw reloadData];
    
     if ([[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach_id"]] || [[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach_id2"]]) {
         
         //self.addAdminBtn.hidden=NO;
         self.admin=YES;
        // _viewMessage.frame=CGRectMake(_viewMessage.frame.origin.x, self.view.bounds.size.height - 73, _viewMessage.frame.size.width, _viewMessage.frame.size.height);
         
     }else{
        
         self.addAdminBtn.hidden=YES;
         self.admin=NO;
        // _viewMessage.frame=CGRectMake(_viewMessage.frame.origin.x, self.view.bounds.size.height - 30, _viewMessage.frame.size.width, _viewMessage.frame.size.height);
     }
    
    [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] setSegmentIndex:self.segmnetCtrl.selectedSegmentIndex adminCount:self.count isAdmin:self.admin];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segmentValueChange:(id)sender {
  
    NSLog(@"Segment Details :%d",self.segmnetCtrl.selectedSegmentIndex);
    UISegmentedControl *segment=(UISegmentedControl*)sender;
    [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] setSegmentIndex:self.segmnetCtrl.selectedSegmentIndex adminCount:self.count isAdmin:self.admin];
    if (segment.selectedSegmentIndex==0) {
        
        [self TeamDetails:sender];
        
    }else if (segment.selectedSegmentIndex==1){
        
        [self playerDetails:sender];
        
    }else if (segment.selectedSegmentIndex==2){
        
        
        
    }
    else{
        [self spectorDetails:sender];
    }
}



#pragma  mark - Toggle
- (IBAction)TeamDetails:(id)sender {
    
     [self.navigationController popToRootViewControllerAnimated:NO];
   
    
}

- (IBAction)playerDetails:(id)sender {
    
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        
        if ([vc isKindOfClass:[SaveTeamViewController class]]) {
            [self.navigationController popToViewController:vc animated:NO];
            return;
        }
    }
    
    SaveTeamViewController *teamView=[[SaveTeamViewController alloc]initWithNibName:@"SaveTeamViewController" bundle:nil];
    teamView.itemno=self.selectedTeamIndex;
    teamView.editMode=YES;
    teamView.isInvite=0;
    teamView.selectedTeamIndex=self.selectedTeamIndex;
    teamView.isTeamView=NO;
    [self.navigationController pushViewController:teamView animated:NO];
    
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

- (IBAction)addAdmin:(id)sender {
    
    if(self.count<2){
        
        
        if (self.appDelegate.JSONDATAarr && self.appDelegate.JSONDATAarr.count>0)
        {
            
            [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] setSegmentIndex:self.segmnetCtrl.selectedSegmentIndex adminCount:self.count isAdmin:self.admin];
            [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] toggleRightPanel:sender];
        }
        else
        {
            [self showAlertMessage:@"You need to belong to a team as a player to invite friends."];
        }
        
        
    /*AddAdminViewController *addAdmin=[[AddAdminViewController alloc] initWithNibName:@"AddAdminViewController" bundle:nil];
    addAdmin.selectedTeamIndex=self.selectedTeamIndex;
    addAdmin.isAddAdmin=YES;
    addAdmin.selectedAddmin=self.count;
    [self.appDelegate.centerViewController presentViewControllerForModal:addAdmin];
        */
    }else{
        
       // “Only two Admin per team
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Sorry, only two admin allowed per team" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
    }

}


-(void)LongPress:(UILongPressGestureRecognizer*)gesture{
    
    if ([[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach_id"]]) {
        
        if (gesture.state == UIGestureRecognizerStateBegan) {
            
            UIView *vw;
            InvitePlayerListCell*cell1;
            if(appDelegate.isIos7){
                vw=(UIView*)[[[gesture.view superview] superview] superview];
                cell1=(InvitePlayerListCell*)[[[gesture.view superview] superview]superview];
                cell1.cancelBtn.hidden=NO;
            }
            else if(appDelegate.isIos8)
            {
                vw=(UIView*)[[gesture.view superview] superview];
                cell1=(InvitePlayerListCell*)[[gesture.view superview] superview];
                cell1.cancelBtn.hidden=NO;
            }
            else
            {
                vw=(UIView*)[gesture.view superview];
                cell1=(InvitePlayerListCell*)[gesture.view superview];
                cell1.cancelBtn.hidden=NO;
            }
            if (self.isiPad) {
                vw.frame=CGRectMake(-154, vw.frame.origin.y,vw.frame.size.width + 154,vw.frame.size.height);
                
            }
            else{
                vw.frame=CGRectMake(-115, vw.frame.origin.y,vw.frame.size.width + 115,vw.frame.size.height);
            }
            
          //  vw.frame=CGRectMake(-115, 0,vw.frame.size.width + 115,vw.frame.size.height);
        }
    }
    
}


- (IBAction)deletePlayer:(UIButton*)sender
{
    
    UIActionSheet *action=[[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Remove",nil];
    action.tag=1002;
    [action showInView:appDelegate.centerViewController.view];
    
}


- (IBAction)deleteAdminToTeam:(id)sender {
    
    
    NSMutableDictionary *cludDict=[NSMutableDictionary dictionary];
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"team_id"] forKey:@"team_id"];
    [command setObject:@"N" forKey:@"delete_logo"];
    
    
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach_id"] forKey:@"coach_id"];
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"team_name"] forKey:@"team_name"];
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"team_sport"] forKey:@"team_sport"];
    
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"club_id"] forKey:@"club_id"];
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"league_id"] forKey:@"league_id"];
    
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"team_zipcode"] forKey:@"team_zipcode"];
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"field_name"] forKey:@"field_name"];
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"age_group"] forKey:@"age_group"];
    
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"team_gender"] forKey:@"team_gender"];
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"uniform_color"] forKey:@"uniform_color"];
    [command setObject:[self.appDelegate.dateFormatM stringFromDate:[NSDate date]] forKey:@"adddate"];
    self.requestDic=command;
    
    
    
    [cludDict setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"club_name"] forKey:@"club"];
    [cludDict setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"league_name"] forKey:@"league"];
    
    
    [cludDict setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"club_url"] forKey:@"club_url"];
    [cludDict setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"league_url"] forKey:@"league_url"];
    
    //ADDMIN One Info
    
    
    
        [command setObject:@"" forKey:@"creator_name2"];
        [command setObject:@"" forKey:@"creator_email2"];
        [command setObject:@"" forKey:@"creator_phno2"];
        
   
        
        [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_name"] forKey:@"creator_name"];
        [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_email"] forKey:@"creator_email"];
        [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_phno"] forKey:@"creator_phno"];
        
    
    
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    NSString *jsonCommand = [writer stringWithObject:command];
    NSString *jsonClub=[writer stringWithObject:cludDict];
    
    
    
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    
    [appDelegate sendRequestFor:EDIT_TEAM from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam",jsonClub,@"requestParam1", nil]];
}


-(void)notifyRequesterWithData:(id) aData :(id)aData1{
    
    [self hideHudView];
    [self hideNativeHudView];
    NSString *str=(NSString*)aData;
    NSLog(@"JSONData=%@",str);
    
    
        SBJsonParser *parser=[[SBJsonParser alloc] init];
        
        id res = [parser objectWithString:str];
        
        if ([res isKindOfClass:[NSDictionary class]])
        {
            NSDictionary* aDict = (NSDictionary*) res;
            NSString *message=[aDict objectForKey:@"message"];
            NSLog(@"%@",message);
            
            if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"]){
                
                
                
                [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:@"" forKey:@"creator_name2"];
                [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:@"" forKey:@"creator_email2"];
                [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] setObject:@"" forKey:@"creator_phno2"];
                
                self.count--;
                [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] setSegmentIndex:self.segmnetCtrl.selectedSegmentIndex adminCount:self.count isAdmin:self.admin];
                [self.tblVw reloadData];
            }
        }
    
    
}



-(IBAction)editPlayer:(UIButton*)sender{
    
    AddAdminViewController *addAdmin=[[AddAdminViewController alloc] initWithNibName:@"AddAdminViewController" bundle:nil];
    addAdmin.selectedTeamIndex=self.selectedTeamIndex;
    addAdmin.isAddAdmin=NO;
    addAdmin.selectedAddmin=1;
    [self.appDelegate.centerViewController presentViewControllerForModal:addAdmin];
    
    
}

-(void)cancelEditPlayer:(UIButton *)sender{
    
    [self.tblVw reloadData];
}

#pragma mark - PlayerOption

-(IBAction)OptionAction:(UIButton*)sender{
    ////  change code 21/8/14  ////
    
    //self.selectedIndex=sender.tag;
    if ([[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach_id"]]) {
        
        
        
        /////////////////ADDDEBNEW
       /* AddAdminViewController *addAdmin=[[AddAdminViewController alloc] initWithNibName:@"AddAdminViewController" bundle:nil];
        addAdmin.selectedTeamIndex=self.selectedTeamIndex;
        addAdmin.isAddAdmin=NO;
        addAdmin.selectedAddmin=sender.tag;
        [self.appDelegate.centerViewController presentViewControllerForModal:addAdmin];*/
        
        UIActionSheet *action=[[UIActionSheet alloc] initWithTitle:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_name2"] delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Call",@"Email",@"Message",nil];
        action.tag=1001;
        [action showInView:self.appDelegate.centerViewController.view];
        
        //////////////////
        
    }
    

/*    self.selectedIndex=sender.tag;
    if (self.selectedIndex==0) {
        
        if (![[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach_id"] isEqualToString:[appDelegate.aDef objectForKey:LoggedUserID]]) {
            UIActionSheet *action=[[UIActionSheet alloc] initWithTitle:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_name"] delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Call",@"Email",@"Message",nil];
            action.tag=1001;
            
            [action showInView:self.appDelegate.centerViewController.view];
        }
        
    }else{
        
         if (![[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach_id2"] isEqualToString:[appDelegate.aDef objectForKey:LoggedUserID]]) {
             
            UIActionSheet *action=[[UIActionSheet alloc] initWithTitle:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_name2"] delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Call",@"Email",@"Message",nil];
            action.tag=1001;
            [action showInView:self.appDelegate.centerViewController.view];
         }
        
    }*/
   
    
}

#pragma mark - ActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (actionSheet.tag==1001) {
        if (buttonIndex==0) {
            [self calltoPlayer:nil];
            
        }else if (buttonIndex==1){
            
            [self mailtoPlayer:nil];
            
        }else if (buttonIndex==2){
            
            [self chattoPlayer:nil];
        }
        
    }else if (actionSheet.tag==1002){
        
        if (buttonIndex==0) {
            
            [self deleteAdminToTeam:nil];
        }
    }
    
}

#pragma mark - Conversation To Player

-(IBAction)mailtoPlayer:(UIButton*)sender{
    if (self.selectedIndex==0) {
        
        [self sendMail:nil :[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_email"]];
        
    }else{
        
        [self sendMail:nil :[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_email2"]];
        
    }
}

-(IBAction)chattoPlayer:(UIButton*)sender{
    
    
    NSString *reciverId=nil;
    
    ChatViewController *fVC=[[ChatViewController alloc] initWithNibName:@"ChatViewController" bundle:nil];
    fVC.groupId=@"";
    
    if (self.selectedIndex==0) {
        
        
        fVC.reciverUserId=[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach_id"];
        fVC.reciverName= [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_name"];
        reciverId=[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach_id"];
        
    }else{
        
        
        fVC.reciverUserId=[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach_id2"];
        fVC.reciverName= [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_name2"];
        reciverId=[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach_id2"];
    }
    
    
    fVC.isList=1;
    
    if (reciverId) {
        
        [self.appDelegate.centerViewController presentViewControllerForModal:fVC];
        
    }
    
    
}

-(IBAction)calltoPlayer:(UIButton*)sender{
    //Subhasish..23th March
    
    if (self.selectedIndex==0) {
        
        if ([[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_phno"] length] >0) {
            
            [self callNumber:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_phno"]];
            
        }else{
            
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"No phone number available" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
            
        }
    }else{
        
        if ([[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_phno2"] length] >0) {
            
            [self callNumber:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_phno2"]];
            
        }else{
            
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"No phone number available" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
            
        }
    }
}


#pragma mark - TableViewDataSourace

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.count;
    
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
        [cell.callBtn addTarget:self action:@selector(OptionAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.deleteBtn addTarget:self action:@selector(deletePlayer:) forControlEvents:UIControlEventTouchUpInside];
        [cell.editBtn addTarget:self action:@selector(editPlayer:) forControlEvents:UIControlEventTouchUpInside];
        [cell.cancelBtn addTarget:self action:@selector(cancelEditPlayer:) forControlEvents:UIControlEventTouchUpInside];
    }
    cell.imgVwBig.hidden=YES;
    cell.callBtn.userInteractionEnabled=NO;
    cell.cancelBtn.hidden=YES;
    cell.lblNumber.text=[NSString stringWithFormat:@"%ld",indexPath.row+1];
    CGRect r=  cell.imgVwBig.frame;
    if (self.isiPad) {
        r.origin.x=660;
    }
    else
        r.origin.x=254;
    cell.imgVwBig.frame=r;
    [cell.callBtn setImage:[UIImage imageNamed:@"call_big.png"] forState:UIControlStateNormal];
    
    if (indexPath.row==0) {
        //[cell.callBtn setImage:self.acceptdeImage forState:UIControlStateNormal];
        
        cell.callBtn.tag=indexPath.row;
        cell.playerNameLbl.text=[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_name"];
        
        
        //Subhasish..16th March
        NSString *adminType = [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"type"];
        if (adminType && [adminType length]>0) {
            //Yes. It is
            cell.playerStatusLbl.text = [adminType stringByReplacingCharactersInRange:NSMakeRange(0,1)
                                                                      withString:[[adminType substringToIndex:1] capitalizedString]];
        }
        else{
            //No
        }
        NSString *imgUrl= [NSString stringWithFormat:@"%@%@",IMAGELINK,[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"Coach_ProfileImage"]];
        
         [cell.profileImageVw cleanPhotoFrame];
        
        NSLog(@"string %@",[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_img"]);
        if ((![[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"Coach_ProfileImage"] isEqualToString:@""]) && [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"Coach_ProfileImage"]) {
            
            [cell.profileImageVw applyPhotoFrame];
            [cell.profileImageVw setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:self.noImage];
            
        }else{
            
            [cell.profileImageVw setImage:self.noImage];

        }
        
        
        
        
        
        ///////////////ADDDEBNEW
        
        
        if (![[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach_id"] isEqualToString:[appDelegate.aDef objectForKey:LoggedUserID]]) {
           // cell.imgVwBig.hidden=YES;
            cell.callBtn.hidden=YES;
            CGRect r=  cell.imgVwBig.frame;
            if (self.isiPad) {
                r.origin.x+=55;
            }
            else
                r.origin.x+=30;
            cell.imgVwBig.frame=r;
            
        }
        
             
        ///////////////
        
        
    }else{
        
        cell.callBtn.tag=indexPath.row;
        UILongPressGestureRecognizer *lpg1 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(LongPress:)];
        [cell.backView addGestureRecognizer:lpg1];
        
        cell.playerNameLbl.text=[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_name2"];
       // cell.playerStatusLbl.text=[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach2_status"];
        
        NSString *adminType = [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"type2"];
        if (adminType && [adminType length]>0) {
            //Yes. It is
            cell.playerStatusLbl.text = [adminType stringByReplacingCharactersInRange:NSMakeRange(0,1)
                                                                        withString:[[adminType substringToIndex:1] capitalizedString]];
        }        
        NSString *imgUrl= [NSString stringWithFormat:@"%@%@",IMAGELINK,[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach2_img"]];
        [cell.profileImageVw cleanPhotoFrame];

        if ((![[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach2_img"] isEqualToString:@""])  && [[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach2_img"]) {
            
            [cell.profileImageVw applyPhotoFrame];
            [cell.profileImageVw setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:self.noImage];
            
        }else{
            [cell.profileImageVw setImage:self.noImage];
        }
        
        
        
        ///////////////ADDDEBNEW
        
        if ([[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach_id2"] isEqualToString:[appDelegate.aDef objectForKey:LoggedUserID]]) {
            
           //cell.callBtn.hidden=YES;
        }
        
        
        
        
        
    }
    
    return cell;
    
    
}

#pragma mark - TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.selectedIndex=indexPath.row;
    if (self.selectedIndex==0) {
        
        if (![[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach_id"] isEqualToString:[appDelegate.aDef objectForKey:LoggedUserID]]) {
            
            UIActionSheet *action=[[UIActionSheet alloc] initWithTitle:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_name"] delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Call",@"Email",@"Message",nil];
            action.tag=1001;
            
            [action showInView:self.appDelegate.centerViewController.view];
        }
        else{
            NSLog(@"you can not call your own no");
        }
        
    }else{
        
        if (![[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach_id2"] isEqualToString:[appDelegate.aDef objectForKey:LoggedUserID]]) {
            
            UIActionSheet *action=[[UIActionSheet alloc] initWithTitle:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"creator_name2"] delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Call",@"Email",@"Message",nil];
            action.tag=1001;
            [action showInView:self.appDelegate.centerViewController.view];
        }
        else{
            
            NSLog(@"you can not call your own no");
        }
        
    }
}

@end
