//
//  PrimaryMemeberViewController.m
//  Wall
//
//  Created by Sukhamoy on 11/04/14.
//
//

#import "PrimaryMemeberViewController.h"
#import "ChatViewController.h"
#import "CenterViewController.h"
#import "InvitePlayerListCell.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "TeamMaintenanceVC.h"

@interface PrimaryMemeberViewController ()<MFMailComposeViewControllerDelegate>

@end

@implementation PrimaryMemeberViewController
@synthesize commonImage;

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
       
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNavigationControllerUpdated:) name:SHOWNAVIGATIONCONTROLLERPRIMARYMEMBER object:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SHOWNAVIGATIONCONTROLLERPRIMARYMEMBER object:nil];
    
}



-(void)setIntialized{
    
    self.count=0;
    [self setStatusBarStyleOwnApp:0];
    self.titleLbl.text=[NSString stringWithFormat:@"%@'s Members",[self.playerDict objectForKey:@"player_name"]];
    
    if (![[self.playerDict objectForKey:@"Email2"] isEqualToString:@""]) {
        self.count++;
    }
    
    if (![[self.playerDict objectForKey:@"Email3"] isEqualToString:@""]) {
        self.count++;
    }
    
    if (self.count==0) {
        
        self.noPrimaryVw.hidden=NO;
        self.primaryLbl.text=@"No Optional contact info available. Please have team admin update it. This screen will display optional contacts such as mom, dad, etc";
        
    }else{
          self.noPrimaryVw.hidden=YES;
    }
    
    [self.tblVw reloadData];
    
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
        self.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_arrow.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleLeftPanel:)];
    }
    
    
    self.appDelegate.centerViewController.navigationItem.title=[NSString stringWithFormat:@"%@'s Members",[self.playerDict objectForKey:@"player_name"]];
    
    appDelegate.centerViewController.navigationItem.leftBarButtonItem=self.leftBarButtonItem;
    appDelegate.centerViewController.navigationItem.rightBarButtonItem=nil;
    
    
    
    [self setStatusBarStyleOwnApp:1];
    
}

-(void)toggleLeftPanel:(id)sender
{
    [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerTeamMaintenance];
    TeamMaintenanceVC *teamVc=  (TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0];
    teamVc.isShowFristTime=NO;
}





#pragma mark - NavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SHOWNAVIGATIONCONTROLLER object:nil];
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}



#pragma mark - PlayerOption

-(IBAction)OptionAction:(UIButton*)sender{
    
    self.selectedIndex=sender.tag;
    
    if (self.selectedIndex==0) {
        
        if ([[self.playerDict objectForKey:@"Email2"] isEqualToString:[appDelegate.aDef objectForKey:EMAIL]]) {
            
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Sorry but there is no point in talking to yourself" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
        }else{
            
            UIActionSheet *action=[[UIActionSheet alloc] initWithTitle:[self.playerDict objectForKey:@"Name2"] delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Call",@"Email",@"Message",nil];
            action.tintColor=[UIColor blackColor];
            [action showInView:self.appDelegate.centerViewController.view];
        }
        
      
        
    }else{
        
        if ([[self.playerDict objectForKey:@"Email3"] isEqualToString:[appDelegate.aDef objectForKey:EMAIL]]) {
            
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Sorry but there is no point in talking to yourself" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
            
        }else{
            UIActionSheet *action=[[UIActionSheet alloc] initWithTitle:[self.playerDict objectForKey:@"Name3"] delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Call",@"Email",@"Message",nil];
            action.tintColor=[UIColor blackColor];
            [action showInView:self.appDelegate.centerViewController.view];
        }
        
       

        
    }
   
    
}

#pragma mark - ActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==0) {
        [self smstoPlayer:nil];
        
    }else if (buttonIndex==1){
        
        [self mailtoPlayer:nil];
        
    }else if (buttonIndex==2){
        
        [self chattoPlayer:nil];
    }
    
}

#pragma mark - Conversation To Player

-(IBAction)mailtoPlayer:(UIButton*)sender{
    
    if (self.selectedIndex==0) {
        
        [self sendMail:nil :[self.playerDict objectForKey:@"Email2"]];
        
    }else{
        
        [self sendMail:nil :[self.playerDict objectForKey:@"Email3"]];
        
    }
    
    
    
    
}
-(IBAction)chattoPlayer:(UIButton*)sender{
    
    
    NSString *reciverId=nil;
    
    ChatViewController *fVC=[[ChatViewController alloc] initWithNibName:@"ChatViewController" bundle:nil];
    
    fVC.groupId=@"";

    if (self.selectedIndex==0) {
        
        if (![[self.playerDict objectForKey:@"UserID2"] isEqualToString:[appDelegate.aDef objectForKey:LoggedUserID]]) {
            
            fVC.reciverUserId=[self.playerDict objectForKey:@"UserID2"];
            fVC.reciverName= [self.playerDict objectForKey:@"Name2"];
            reciverId=[self.playerDict objectForKey:@"UserID2"];
        }
        
    }else{
        
        if (![[self.playerDict objectForKey:@"UserID3"] isEqualToString:[appDelegate.aDef objectForKey:LoggedUserID]]) {
            
            fVC.reciverUserId=[self.playerDict objectForKey:@"UserID3"];
            fVC.reciverName= [self.playerDict objectForKey:@"Name3"];
            reciverId=[self.playerDict objectForKey:@"UserID3"];
        }
        
    }
    
    fVC.isList=1;
    
    if (reciverId) {
        
        [self.appDelegate.centerViewController presentViewControllerForModal:fVC];
        
    }
    
    
}

-(IBAction)smstoPlayer:(UIButton*)sender{
    
    
    if (self.selectedIndex==0) {
        
        if (![self.playerDict objectForKey:@"ph_no2"] || ![[self.playerDict objectForKey:@"ph_no2"] isEqualToString:@"0"]) {
            
            [self callNumber:[self.playerDict objectForKey:@"ph_no2"]];
            
        }else{
            
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"No phone numbers available – please contact team admin" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        
    }else{
        if (![self.playerDict objectForKey:@"ph_no3"] || ![[self.playerDict objectForKey:@"ph_no3"] isEqualToString:@"0"]) {
            
            [self callNumber:[self.playerDict objectForKey:@"ph_no3"]];
            
        }else{
            
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"No phone numbers available – please contact team admin" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
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
       // [cell.callBtn addTarget:self action:@selector(OptionAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    //cell.callBtn.hidden=YES;
    cell.callBtn.userInteractionEnabled=NO;
    [cell.callBtn setImage:self.commonImage forState:UIControlStateNormal];
    if (indexPath.row==0) {
        
        if ([[self.playerDict objectForKey:@"Email2"] isEqualToString:[appDelegate.aDef objectForKey:EMAIL]]) {
            cell.backView.backgroundColor=[UIColor colorWithRed:234.0/255.0 green:232.0/255.0 blue:235.0/255.0 alpha:1.0];
            cell.userInteractionEnabled=NO;
        }
        cell.playerNameLbl.text=[self.playerDict objectForKey:@"Name2"];
        
        NSString *imgUrl= [NSString stringWithFormat:@"%@%@",IMAGELINK,[self.playerDict objectForKey:@"ProfileImage2"]];
        
        if ([[self.playerDict objectForKey:@"ProfileImage2"] isEqualToString:@""]) {
            [cell.profileImageVw applyPhotoFrame];
            [cell.profileImageVw setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:self.noImage];
        }else{
            [cell.profileImageVw cleanPhotoFrame];
        }
        cell.callBtn.tag=0;
       /* if ([[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach2_status"] isEqualToString:@"Accept"]) {
            
            
            [cell.callBtn setImage:self.acceptdeImage forState:UIControlStateNormal];
            
            
        }else if ([[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach2_status"] isEqualToString:NORESPONSE]){
            
            
            [cell.callBtn setImage:self.noResponeImage forState:UIControlStateNormal];
            
            
        }*/
        
    }else{
        if ([[self.playerDict objectForKey:@"Email3"] isEqualToString:[appDelegate.aDef objectForKey:EMAIL]]) {
            cell.backgroundColor=[UIColor colorWithRed:234.0/255.0 green:232.0/255.0 blue:235.0/255.0 alpha:1.0];
            cell.userInteractionEnabled=NO;
        }
        cell.playerNameLbl.text=[self.playerDict objectForKey:@"Name3"];
        
        NSString *imgUrl= [NSString stringWithFormat:@"%@%@",IMAGELINK,[self.playerDict objectForKey:@"ProfileImage3"]];
        
        if ([[self.playerDict objectForKey:@"ProfileImage3"] isEqualToString:@""]) {
            [cell.profileImageVw applyPhotoFrame];
            [cell.profileImageVw setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:self.noImage];
        }else{
            [cell.profileImageVw cleanPhotoFrame];
        }
        cell.callBtn.tag=1;
        
       /* if ([[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach2_status"] isEqualToString:@"Accept"]) {
            
            
            [cell.callBtn setImage:self.acceptdeImage forState:UIControlStateNormal];
            
            
        }else if ([[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"coach2_status"] isEqualToString:NORESPONSE]){
            
            
            [cell.callBtn setImage:self.noResponeImage forState:UIControlStateNormal];
            
            
        } */ //// AD 15th june

    }
    
    
    return cell;
    
    
}

#pragma mark - TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //// 9/10/14  ///////
    
    self.selectedIndex=indexPath.row;
    
    
    if (self.selectedIndex==0) {
        
        if ([[self.playerDict objectForKey:@"Email2"] isEqualToString:[appDelegate.aDef objectForKey:EMAIL]]) {
            
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Sorry but there is no point in talking to yourself" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
        }else{
            
            UIActionSheet *action=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Call",@"Email",@"Message",nil];
            action.tintColor=[UIColor blackColor];
            [action showInView:self.appDelegate.centerViewController.view];
        }
        
        
        
    }else{
        
        if ([[self.playerDict objectForKey:@"Email3"] isEqualToString:[appDelegate.aDef objectForKey:EMAIL]]) {
            
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Sorry but there is no point in talking to yourself" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
            
        }else{
            UIActionSheet *action=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Call",@"Email",@"Message",nil];
            action.tintColor=[UIColor blackColor];
            [action showInView:self.appDelegate.centerViewController.view];
        }
        
        
        
        
    }
    
}




@end
