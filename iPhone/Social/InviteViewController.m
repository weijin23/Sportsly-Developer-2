//
//  InviteViewController.m
//  Wall
//
//  Created by Sukhamoy on 21/11/13.
//
//
#import "SaveTeamViewController.h"
#import "InviteViewController.h"
#import "InvitePlayerListViewController.h"
#import "SaveTeamViewController.h"
#import "TeamMaintenanceVC.h"
#import "CenterViewController.h"
#import "InvitePlayerListCell.h"
#import "InviteCell.h"
@interface InviteViewController ()<UITextViewDelegate>
@end

@implementation InviteViewController
@synthesize selectEdTeamIndex;
@synthesize selectedIdList;
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
    
    
    [self setStatusBarStyleOwnApp:0];

    self.acceptdeImage=[UIImage imageNamed:@"accepted_image"];
    self.inviteSelectedImage=[UIImage imageNamed:@"invite_selected_image.png"];
    self.reminderImage=[UIImage imageNamed:@"invite_send.png"];
    self.declinedImage=[UIImage imageNamed:@"decile_image.png"];
    self.noResponeImage=[UIImage imageNamed:@"reminder_send.png"];
    
    @autoreleasepool{
        
        NSString *tmpphno=[[[self.appDelegate.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"creator_phno"] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if(tmpphno && (![tmpphno isEqualToString:@""]))
        self.inviteMessage=[NSString stringWithFormat:TEAMINVITECONTENT,[[self.appDelegate.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"team_name"],[[self.appDelegate.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"team_sport"]];
    else
        self.inviteMessage=[NSString stringWithFormat:TEAMINVITECONTENTEX,[[self.appDelegate.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"team_name"],[[self.appDelegate.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"team_sport"]];
    }
    
    NSLog(@"TeamInviteContent=%@----%@",[[self.appDelegate.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"team_name"],[[self.appDelegate.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"team_id"]);
    
    
    self.selectedIdList=nil;
    
    
    int alertFlag=0;
    
    self.selectedInvitePlayer=[[NSMutableArray alloc] init];
    
    for (int i=0; i< [[[self.appDelegate.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"player_details"] count]; i++){
        
        [self.selectedInvitePlayer addObject:@"0"];
        
        if (![[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"player_details"] objectAtIndex:i ] objectForKey:@"invites"] isEqualToString:PENDING])
        {
            alertFlag=1;
            
        }
        
    }

    
    for (int i=0; i< [[[self.appDelegate.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"player_details"] count]; i++){
        if (![[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"player_details"] objectAtIndex:i ] objectForKey:@"invites"] isEqualToString:PENDING])
        {
            alertFlag=1;
            break;
        }
        
    }
    

    if (!alertFlag)
    {
        
        //self.custmLbl.text=@"Team admin can select players to \"invite\" or \"remind\" and then click \"Send Invites\" at bottom";
        self.custmLbl.text=@"Send team invite to players by clicking on each player or select all. Then click  Send Invite at bottom";
        
        [self showAlertViewCustom];

    }
}


-(void)showAlertViewCustom
{
    self.popupalertvw.hidden=NO;
    self.popupalertvwback.hidden=NO;
}

- (IBAction)selectedAllplayer:(UIButton*)sender {
    
    
    if ([sender isSelected]) {
        
        [sender setSelected:NO];
        for (int i=0; i<self.selectedInvitePlayer.count; i++) {
            
            [self.selectedInvitePlayer replaceObjectAtIndex:i withObject:@"0"];
        }
        
    }else{
        [sender setSelected:YES];
        for (int i=0; i<self.selectedInvitePlayer.count; i++) {
            
            if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"player_details"] objectAtIndex:i] objectForKey:@"invites"] isEqualToString:@"Accept"] || [[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"player_details"] objectAtIndex:i] objectForKey:@"invites"] isEqualToString:@"Decline"]) {
                
                 [self.selectedInvitePlayer replaceObjectAtIndex:i withObject:@"0"];
            }else{
                
                 [self.selectedInvitePlayer replaceObjectAtIndex:i withObject:@"1"];
            }
            
          }
        
    }
    
    [self.inviteTbl reloadData];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
    
    [self inviteSubmit:sender];

    
}

- (IBAction)back:(id)sender{
    
   
    //[self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (IBAction)inviteSubmit:(id)sender {
    
    self.selectedIdList=nil;
    for (int i=0; i< self.selectedInvitePlayer.count; i++) {
        if ([[self.selectedInvitePlayer objectAtIndex:i] intValue]) {
            
            if ( !self.selectedIdList) {
                
                self.selectedIdList=[NSString stringWithFormat:@"%@",[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"player_details"] objectAtIndex:i] objectForKey:@"player_id"]];
                
                
            }else{
                
                self.selectedIdList=[NSString stringWithFormat:@"%@,%@",self.selectedIdList,[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"player_details"] objectAtIndex:i] objectForKey:@"player_id"]];
            }
            
        }
    }
    
    if (!self.selectedIdList)
    {
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Please select at least one player to invite" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
        return;

    }
  
    
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    
    [command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"team_id"] forKey:@"team_id"];
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
    
    NSString *str=(NSString*)aData;
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
                  
                        
                        
                        for (int i=0; i<[[[self.appDelegate.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"player_details"] count]; i++) {
                            
                             NSString *pid=[[NSString alloc] initWithFormat:@"%@", [[[[self.appDelegate.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"player_details"] objectAtIndex:i] objectForKey: @"player_id"]] ;
                            
                            if([playerid isEqualToString:pid])
                            {
                                
                                [[[[self.appDelegate.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"player_details"] objectAtIndex:i ] setObject:NORESPONSE forKey:@"invites"];
                                
                                break;
                            }

                            
                        }
                  
                    
                    }
                    
                    
                   
                    
                }
                else
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                    [alert show];
                }
            }
            
           // [self showHudAlert:@"Invite sent"];
            self.custmLbl.text=@"Team invite(s) have been sent";
            [self showAlertViewCustom];
            //[self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
        }
        
        /*self.custmLbl.text=@"Team invite(s) have been sent";
        [self showAlertViewCustom];*/
       // [self showHudAlert:@"Invite sent"];
        //[self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];

        return;
    }
}


-(void)hideHudViewHere{
    [self hideHudView];
    [self dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark - TableViewDataSourace

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[[self.appDelegate.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"player_details"] count];
    
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
    
    InviteCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell=[InviteCell inviteCell];
      
    }
    
    [self configureCell:cell atIndexPath:indexPath andTableView:tableView];
    return cell;
    
    
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath andTableView:(UITableView*)tableview
{
    
    InviteCell *inviteCell=(InviteCell*)cell;
    
    inviteCell.playerNameLbl.text=[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"player_details"] objectAtIndex:indexPath.row] objectForKey:@"player_name"];
    
    
    
    if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"player_details"] objectAtIndex:indexPath.row ] objectForKey:@"invites"] isEqualToString:@"Accept"]) {
        
        inviteCell.statusLbl2.textColor=[self colorWithHexString:@"33CC66"];
        inviteCell.statusLbl2.text=@"Accepted";
        inviteCell.statusImageVw.image=self.acceptdeImage;
        inviteCell.statuslbl.text=@"";
        
    }else if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"player_details"] objectAtIndex:indexPath.row ] objectForKey:@"invites"] isEqualToString:@"Decline"]){
        
        
        inviteCell.statusLbl2.textColor=[UIColor redColor];
        inviteCell.statusLbl2.text=@"Declined";
        inviteCell.statusImageVw.image=self.declinedImage;
        inviteCell.statuslbl.text=@"";

        
        
    } else if( [[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"player_details"] objectAtIndex:indexPath.row ] objectForKey:@"invites"] isEqualToString:MAYBE] ){
        
      
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

        
        
    }else if([[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"player_details"] objectAtIndex:indexPath.row ] objectForKey:@"invites"] isEqualToString:NORESPONSE]   ){
        
        
        if (self.selectedInvitePlayer) {
            
            if ([[self.selectedInvitePlayer objectAtIndex:indexPath.row] integerValue]) {
                
                inviteCell.statusImageVw.hidden=NO;
                inviteCell.statuslbl.textColor=[UIColor colorWithRed:50.0/255.0 green:134.0/255.0 blue:203.0/255.0 alpha:1.0];
                inviteCell.statuslbl.text=@"Reminder will be sent";
                inviteCell.statusImageVw.image=self.inviteSelectedImage;
                inviteCell.statusLbl2.text=@"";
                
                
            }else{
                
                inviteCell.statusLbl2.textColor=[UIColor blackColor];
                inviteCell.statusLbl2.text=@"No Response \nSend Reminder?";
                inviteCell.statusImageVw.image=self.noResponeImage;
                inviteCell.statusImageVw.hidden=YES;
                inviteCell.statuslbl.text=@"";
                
                
                
            }
        }
        
        
        
    }
    else if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"player_details"] objectAtIndex:indexPath.row ] objectForKey:@"invites"] isEqualToString:PENDING]){
        
      
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
    
    NSString *imgUrl= [NSString stringWithFormat:@"%@%@",IMAGELINK,[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"player_details"] objectAtIndex:indexPath.row ] objectForKey:@"ProfileImage"]];
    
    if (![[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"player_details"] objectAtIndex:indexPath.row ] objectForKey:@"ProfileImage"] isEqualToString:@""]) {
        
        [inviteCell.profileImageVw applyPhotoFrame];
        [inviteCell.profileImageVw setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:self.noImage];
    }else{
         [inviteCell.profileImageVw cleanPhotoFrame];
    }
    
    
}



#pragma mark - TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"player_details"] objectAtIndex:indexPath.row ] objectForKey:@"invites"] isEqualToString:NORESPONSE]  ||  [[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"player_details"] objectAtIndex:indexPath.row ] objectForKey:@"invites"] isEqualToString:MAYBE] ){
        
        if (self.selectedInvitePlayer) {
            
            if ([[self.selectedInvitePlayer objectAtIndex:indexPath.row] integerValue]) {
                
                [self.selectedInvitePlayer replaceObjectAtIndex:indexPath.row withObject:@"0"];
                
            }else{
                
                
                [self.selectedInvitePlayer replaceObjectAtIndex:indexPath.row withObject:@"1"];
                
            }
        }
        [tableView reloadData];

    }
    
    if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"player_details"] objectAtIndex:indexPath.row ] objectForKey:@"invites"] isEqualToString:PENDING]){
        
        
        if (self.selectedInvitePlayer) {
            
            if ([[self.selectedInvitePlayer objectAtIndex:indexPath.row] integerValue]) {
                
                [self.selectedInvitePlayer replaceObjectAtIndex:indexPath.row withObject:@"0"];
                
            }else{
          
                
                [self.selectedInvitePlayer replaceObjectAtIndex:indexPath.row withObject:@"1"];
                
            }
        }
        [tableView reloadData];

    }
    
}



- (IBAction)popuptapped:(id)sender {
    self.popupalertvw.hidden=YES;
    self.popupalertvwback.hidden=YES;
   
    
    if([self.custmLbl.text isEqualToString:@"Team invite(s) have been sent"])
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
