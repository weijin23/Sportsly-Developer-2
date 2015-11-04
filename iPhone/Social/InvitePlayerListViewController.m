//
//  InvitePlayerListViewController.m
//  Wall
//
//  Created by Sukhamoy on 21/11/13.
//
//

#import "InvitePlayerListViewController.h"
#import "SaveTeamViewController.h"
#import "TeamDetailsViewController.h"
#import "EventEditViewController.h"
@interface InvitePlayerListViewController ()

@end

@implementation InvitePlayerListViewController
@synthesize itemno,editMode,selectedTeamIndex;
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
   
   // self.view.backgroundColor=appDelegate.backgroundPinkColor;
    self.topview.backgroundColor=appDelegate.barGrayColor;
    
    self.playerDetailsBtn.layer.cornerRadius=3.0f;
    [self.playerDetailsBtn.layer setMasksToBounds:YES];
    
    self.teamDetailSbtn.layer.cornerRadius=3.0f;
    [self.teamDetailSbtn.layer setMasksToBounds:YES];
    
    self.createEventBtn.layer.cornerRadius=3.0f;
    [self.createEventBtn.layer setMasksToBounds:YES];
    
    self.inviteBtn.layer.cornerRadius=3.0f;
    [self.inviteBtn.layer setMasksToBounds:YES];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.teamNameLbl.text=[[self.appDelegate.JSONDATAarr objectAtIndex:self.selectedTeamIndex] objectForKey:@"team_name"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
     [[NSNotificationCenter defaultCenter] removeObserver:self name:HANDLERECEIVEDMEMORYWARNING object:nil];
    [_teamDetailSbtn release];
    [_playerDetailsBtn release];
    [_createEventBtn release];
    [_inviteBtn release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTeamNameLbl:nil];
    [super viewDidUnload];
}

#pragma mark - ClassMethod
- (IBAction)done:(id)sender {
    
}

- (IBAction)cancel:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES ];
    
    
}

- (IBAction)teamDetails:(id)sender {
    
    TeamDetailsViewController *addTeam=[[TeamDetailsViewController alloc]initWithNibName:@"TeamDetailsViewController" bundle:nil];
    addTeam.selectedTeamIndex=self.selectedTeamIndex;
    [self.navigationController pushViewController:addTeam animated:YES];
}
- (IBAction)playerDetails:(id)sender {
    
    SaveTeamViewController *teamView=[[SaveTeamViewController alloc]initWithNibName:@"SaveTeamViewController" bundle:nil];
    teamView.itemno=self.itemno;
    teamView.editMode=YES;
    teamView.isInvite=0;
    teamView.selectedTeamIndex=self.selectedTeamIndex;
    teamView.isTeamView=NO;
    [self.navigationController pushViewController:teamView animated:YES];
}

- (IBAction)createEvent:(id)sender {
    
    EventEditViewController *eVc=[[EventEditViewController alloc] initWithNibName:@"EventEditViewController" bundle:nil];
    eVc.mode=1;
    eVc.defaultDate=[NSDate date];
    self.isModallyPresentFromCenterVC=1;
    [self showModal:eVc];
}

- (IBAction)inviteTracker:(id)sender {
    
    UIActionSheet *inviteAction=  [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Create Event",@"Track Event Invite",@"Track Team Invite",nil];
    [inviteAction showInView:self.view];
    [inviteAction release];

}
#pragma mark - ActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if([actionSheet isEqual:self.camActionSheet])
    {
        [super actionSheet:actionSheet clickedButtonAtIndex:buttonIndex];
        return;
    }
    
    
    NSString *choice = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([choice isEqualToString:@"Track Event Invite"]) {
        
        
        
    }else if([choice isEqualToString:@"Track Team Invite"]){
        
        SaveTeamViewController *teamView=[[SaveTeamViewController alloc]initWithNibName:@"SaveTeamViewController" bundle:nil];
        teamView.itemno=self.itemno;
        teamView.editMode=YES;
        teamView.isInvite=1;
        teamView.selectedTeamIndex=self.selectedTeamIndex;
        teamView.isTeamView=NO;
        [self.navigationController pushViewController:teamView animated:YES];
        
    }else if ([choice isEqualToString:@"Create Event"]){
        
    }
}

@end
