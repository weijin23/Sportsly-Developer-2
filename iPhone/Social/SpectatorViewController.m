//
//  SpectatorViewController.m
//  Wall
//
//  Created by User on 11/06/15.
//
//

#import "SpectatorViewController.h"
#import "TeamMaintenanceVC.h"
#import "SaveTeamViewController.h"
#import "TeamAdminVCViewController.h"
#import "InvitePlayerListCell.h"
#import "SelectContact.h"
#import "CenterViewController.h"
#import "ChatViewController.h"

@interface SpectatorViewController ()

@end

@implementation SpectatorViewController
@synthesize selectedTeamIndex,admin,itemno;
@synthesize acceptdeImage,declineImage,noResponeImage;
@synthesize selectedSpectator;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.isiPad) {
        NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:20], UITextAttributeFont, nil];
        [self.segmentContr setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    }
    if(self.isiPad){
        self.acceptdeImage=[UIImage imageNamed:@"accept_invite_ipad.png"];
        self.noResponeImage=[UIImage imageNamed:@"not_response_admn_ipad.png"];
        self.declineImage=[UIImage imageNamed:@"declined_image_ipad.png"];
    }
    else{
        self.acceptdeImage=[UIImage imageNamed:@"accept_invite.png"];
        self.noResponeImage=[UIImage imageNamed:@"not_response_admn.png"];
        self.declineImage=[UIImage imageNamed:@"declined_image.png"];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSLog(@"Segment Details for reload data :");
    
    //// AD...iAd
    self.adBanner.delegate = self;
    self.adBanner.alpha = 0.0;
    self.canDisplayBannerAds=YES;
    ////
    
    [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] showRightButton:0];
    [self.segmentContr setSelectedSegmentIndex:3];
    [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] setSegmentIndex:(int)self.segmentContr.selectedSegmentIndex adminCount:0 isAdmin:YES];
    [self.tableSpectator reloadData];
    if ([[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach_id"]] || [[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach_id2"]]) {
        self.admin=YES;
        
    }else{
        self.admin=NO;
    }
    
    NSArray *arr=[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"friend_list"];
    if (arr.count>0) {
        self.viewNoPlayer.hidden=YES;
    }
    
}

- (IBAction)popupTapped:(id)sender {
    
    self.popupAlertBck.hidden=YES;
    self.popupAlertVw.hidden=YES;
}

- (IBAction)segmentValueChange:(id)sender {
    
    NSLog(@"Segment Details :%d",self.segmentContr.selectedSegmentIndex);
    [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] setSegmentIndex:(int)self.segmentContr.selectedSegmentIndex adminCount:0 isAdmin:self.admin];
    
    UISegmentedControl *segment=(UISegmentedControl*)sender;
    if (segment.selectedSegmentIndex==0) {
        
        [self teamDetailsTapedSpector:sender];
        
    }else if (segment.selectedSegmentIndex==1){
        
        [self playerDetailsTapedSpector:sender];
        
    }else if (segment.selectedSegmentIndex==2){
        [self AddminTappTapedSpector:sender];
    }
    else{
        
    }
}

- (IBAction)addSpectators:(id)sender {
    
    if (self.appDelegate.JSONDATAarr && self.appDelegate.JSONDATAarr.count>0)
    {
       /* SelectContact *selContactNew=[[SelectContact alloc] initWithNibName:@"SelectContact" bundle:nil];
        [self.navigationController pushViewController:selContactNew animated:YES];
        selContactNew.selectedTeamId=[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"team_id"];
        [selContactNew resetData];*/
        
        [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] setSegmentIndex:(int)self.segmentContr.selectedSegmentIndex adminCount:0 isAdmin:self.admin];
        [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] toggleRightPanel:sender];
    }
    else
    {
        [self showAlertMessage:@"You need to belong to a team as a player to invite friends."];
    }
    
}

- (IBAction)teamDetailsTapedSpector:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:NO];
}
- (IBAction)playerDetailsTapedSpector:(id)sender {
    
    
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

-(IBAction)AddminTappTapedSpector:(id)sender{
    
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

#pragma mark - TableViewDataSourace

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
   // return [[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"player_details"] count];
    NSArray *arr=[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"friend_list"];
    
    return [arr count];
    
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
        
    }
    
    [self configureCell:cell atIndexPath:indexPath andTableView:tableView];
    return cell;
    
    
}


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath andTableView:(UITableView*)tableview
{
    
    InvitePlayerListCell*cell1=(InvitePlayerListCell*)cell;
    cell1.cancelBtn.hidden=YES;
    cell1.callBtn.hidden=YES;
    cell1.callBtn.tag=indexPath.row;
    cell1.deleteBtn.tag=indexPath.row;
    cell1.editBtn.tag=indexPath.row;
    cell1.backView.tag=indexPath.row;
    cell1.lblNumber.text=[NSString stringWithFormat:@"%ld.",indexPath.row+1];
    //[cell1.callBtn setImage:self.normalImage forState:UIControlStateNormal];
    cell1.playerNameLbl.textColor=[UIColor blackColor];
    
    cell1.playerNameLbl.text=[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"friend_list"] objectAtIndex:indexPath.row] objectForKey:@"Name"];
    
    NSString *imgUrl= [NSString stringWithFormat:@"%@%@",IMAGELINK,[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"friend_list"] objectAtIndex:indexPath.row ] objectForKey:@"ProfileImage"]];
    [cell1.profileImageVw cleanPhotoFrame];
    
    [cell1.profileImageVw setImage:self.noImage];
    if (![[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"friend_list"] objectAtIndex:indexPath.row ] objectForKey:@"ProfileImage"] isEqualToString:@""] && [[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"friend_list"] objectAtIndex:indexPath.row ] objectForKey:@"ProfileImage"]) {
        [cell1.profileImageVw applyPhotoFrame];
        [cell1.profileImageVw setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:self.noImage];
    }
    
    if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"friend_list"] objectAtIndex:indexPath.row ] objectForKey:@"status"] isEqualToString:@"Accept"]) {
        
        
        [cell1.callBtn setImage:self.acceptdeImage forState:UIControlStateNormal];
        
        
    }else if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"friend_list"] objectAtIndex:indexPath.row ] objectForKey:@"status"] isEqualToString:NORESPONSE]){
        
        
        [cell1.callBtn setImage:self.noResponeImage forState:UIControlStateNormal];
        
        
    }
    else if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"friend_list"] objectAtIndex:indexPath.row ] objectForKey:@"status"] isEqualToString:@"Decline"]){
        
        
        [cell1.callBtn setImage:self.declineImage forState:UIControlStateNormal];
        
        
    }
    
}


#pragma mark - TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //// 21/8/14  ///////
    
    self.selectedSpectator=(int)indexPath.row;
    
    if (![[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"friend_list"] objectAtIndex:self.selectedSpectator] objectForKey:@"email_id"] isEqualToString:[appDelegate.aDef objectForKey:LoggedUserID]]) {
        
        NSArray *ar=[[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"friend_list"] objectAtIndex:self.selectedSpectator] objectForKey:@"sender_name"] componentsSeparatedByString:@" "];
        NSString *str=[@"" stringByAppendingFormat:@"%@'s spectator",[ar firstObject]];
        
        UIActionSheet *action=[[UIActionSheet alloc] initWithTitle:str delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Call",@"Email",@"Message",nil];
        action.tag=1001;
        
        [action showInView:self.appDelegate.centerViewController.view];
    }
    else{
        NSLog(@"you can not call your own no");
    }
    
}

#pragma mark - ActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==0) {
        [self calltoPlayer:nil];
        
    }else if (buttonIndex==1){
        
        [self mailtoPlayer:nil];
        
    }else if (buttonIndex==2){
        
        [self chattoPlayer:nil];
    }
    
    
}


#pragma mark - Conversation To Player

-(IBAction)mailtoPlayer:(UIButton*)sender{
   // if (self.selectedSpectator==0) {
        
        [self sendMail:nil :[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"friend_list"] objectAtIndex:self.selectedSpectator] objectForKey:@"email_id"]];
        
  
}

-(IBAction)chattoPlayer:(UIButton*)sender{
    
    if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"friend_list"] objectAtIndex:self.selectedSpectator] objectForKey:@"UserID"] isEqualToString:@"0"]) {
        
        self.lblPopupCstm.text=[NSString stringWithFormat:@"Sorry, %@ has not yet registered with sportsly",[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"friend_list"] objectAtIndex:self.selectedSpectator] objectForKey:@"email_id"]];
        self.popupAlertBck.hidden=NO;
        self.popupAlertVw.hidden=NO;
        return;
    }
    
    NSString *reciverId=nil;
    
    ChatViewController *fVC=[[ChatViewController alloc] initWithNibName:@"ChatViewController" bundle:nil];
    fVC.groupId=@"";
    
    
        
        fVC.reciverUserId=[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"friend_list"] objectAtIndex:self.selectedSpectator] objectForKey:@"UserID"];
        fVC.reciverName= [[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"friend_list"] objectAtIndex:self.selectedSpectator] objectForKey:@"Name"];
        reciverId=[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"friend_list"] objectAtIndex:self.selectedSpectator] objectForKey:@"UserID"];
        
    
    fVC.isList=1;
    
    if (reciverId) {
        
        [self.appDelegate.centerViewController presentViewControllerForModal:fVC];
        
    }
    
    
}

-(IBAction)calltoPlayer:(UIButton*)sender{
    //Subhasish..23th March
    
    
    
    if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"friend_list"] objectAtIndex:self.selectedSpectator] objectForKey:@"ContactNo"] length] >0 && ![[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"friend_list"] objectAtIndex:self.selectedSpectator] objectForKey:@"ContactNo"] isEqualToString:@"0"]) {
        
        [self callNumber:[[[[self.appDelegate.JSONDATAarr objectAtIndex:itemno] objectForKey:@"friend_list"] objectAtIndex:self.selectedSpectator] objectForKey:@"ContactNo"]];
        
    }else{
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"No phone number available" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
        
    }
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
