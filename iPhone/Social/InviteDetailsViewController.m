//
//  InviteDetailsViewController.m
//  Wall
//
//  Created by Mindpace on 26/09/13.
//
//
#import "CenterViewController.h"
#import "HomeVC.h"
#import "InviteDetailsViewController.h"

@interface InviteDetailsViewController ()

@end

@implementation InviteDetailsViewController
@synthesize newinvite;
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
    
    if(newinvite.type.intValue==0)
    {
        
        /*if(newinvite.message)
            self.textVw.text=[[NSString alloc] initWithFormat:TEAMINVITECONTENTSHOWROW,[appDelegate.aDef objectForKey:FIRSTNAME],newinvite.creatorName,newinvite.teamName,IPHONEAPPSTORE,GOOGLEPLAYSTORE,newinvite.creatorName,newinvite.creatorEmail,newinvite.creatorPhno];//newinvite.message;
        else*/
        @autoreleasepool {
            NSString *tmpphno=[newinvite.creatorPhno stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        
        if(tmpphno && (![tmpphno isEqualToString:@""]))
            self.textVw.text=[[NSString alloc] initWithFormat:TEAMINVITECONTENTSHOWROW,newinvite.creatorName,newinvite.teamName,newinvite.teamSport];
        else
             self.textVw.text=[[NSString alloc] initWithFormat:TEAMINVITECONTENTSHOWROWEX,newinvite.creatorName,newinvite.teamName,newinvite.teamSport];
        }
    }
    else
    {
        
        self.textVw.text=newinvite.contentMessage;
    }
   // self.view.backgroundColor=appDelegate.backgroundPinkColor;
    self.topview.backgroundColor=appDelegate.barGrayColor;
    
    self.textVw.layer.cornerRadius=8.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backf:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    //[self.view removeFromSuperview];
}

- (IBAction)bTapped:(id)sender
{
    int tag=[sender tag];
    
    NSString *str=nil;
    
    if(tag==1)
    {
        str=@"Accept";
    }
    else if(tag==2)
    {
          str=@"Decline";
    }
    else if(tag==3)
    {
        str=@"Maybe";
    }
   
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    
    
    if(newinvite.type.intValue==0)
    {
        
        if(newinvite.userId)
        [command setObject:newinvite.userId forKey:@"UserID"];
        else
    [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
        
    [command setObject:str forKey:@"invites"];
    [command setObject:newinvite.teamId forKey:@"team_id"];
    [command setObject:@"0" forKey:@"start"];
    [command setObject:DEFAULTLIMIT forKey:@"limit"];
         [command setObject:@"" forKey:@"view"];
    }
    else
    {
         [command setObject:str forKey:@"status"];
         [command setObject:newinvite.postId forKey:@"id"];
         [command setObject:newinvite.teamId forKey:@"team_id"];
    }
    
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    
    
    self.requestDic=command;
    
    
    
    
    if(newinvite.type.intValue==0)
        [appDelegate sendRequestFor:TEAMINVITESTATUS from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
    else
        [appDelegate sendRequestFor:INVITEFRIENDSSTATUS from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
}



-(void)notifyRequesterWithData:(id) aData :(id)aData1
{
    
    [self hideHudView];
    [self hideNativeHudView];
    
    if([aData isKindOfClass:[ConnectionManager class]])
    {
        ConnectionManager *aR=(ConnectionManager*)aData;
        if([aR.requestSingleId isEqualToString:TEAMINVITESTATUS])
        {
            
        }
        else if([aR.requestSingleId isEqualToString:INVITEFRIENDSSTATUS])
        {
            
        }
        return;
    }
    
    
    NSString *str=(NSString*)aData;
    
    NSLog(@"Data=%@",str);
    ConnectionManager *aR=(ConnectionManager*)aData1;

    
    if(![aR.requestSingleId isEqualToString:INVITEFRIENDSSTATUS])
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
                
                [self showHudAlert:[aDict objectForKey:@"message"]];
                [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
             
                
                
                
                
               
                
                if([[self.requestDic objectForKey:@"invites"] isEqualToString:@"Accept"])
                
                self.newinvite.inviteStatus=[[NSNumber alloc] initWithInt:1 ];
              else  if([[self.requestDic objectForKey:@"invites"] isEqualToString:@"Decline"])
                    
                    self.newinvite.inviteStatus=[[NSNumber alloc] initWithInt:2 ];
               else if([[self.requestDic objectForKey:@"invites"] isEqualToString:@"Maybe"])
                    
                    self.newinvite.inviteStatus=[[NSNumber alloc] initWithInt:3 ];
               
                
                
              
                [appDelegate saveContext];
                
                aDict=[aDict objectForKey:@"response"];
                aDict=[aDict objectForKey:@"team_details"];
                
               NSMutableDictionary *micdic=[NSMutableDictionary dictionaryWithObjectsAndKeys:[aDict objectForKey:CREATORNAME],CREATORNAME,[aDict objectForKey:CREATORPHNO],CREATORPHNO,[aDict objectForKey:CREATOREMAIL],CREATOREMAIL, nil];
                
                
                NSString *teamSportN=@"";
                
                if(self.newinvite.teamSport)
                teamSportN=self.newinvite.teamSport;
                
                [appDelegate.centerVC updateArrayByAddingOneTeam:[aDict objectForKey:@"team_name"] :[NSString stringWithFormat:@"%@", [aDict objectForKey:@"team_id"] ] :[self.requestDic objectForKey:@"invites"] :[NSNumber numberWithInt:0] :[ NSString stringWithFormat:@"%@%@", TEAM_LOGO_URL,[aDict objectForKey:@"team_logo"] ]:[aDict objectForKey:@"status_update"] :appDelegate.arrItems:micdic:teamSportN];
                
              
                
                
                /////////////////////////////////
                
               /* NSArray *teamUpdateListing=[ aDict objectForKey:@"team_update_listing"];
                
                for(NSDictionary *diction in teamUpdateListing)
                {
                    
                    Invite *invite=(Invite*)  [self objectOfTypeInvite:INVITE forTeam:[aDict objectForKey:@"team_id"] forUpdate:3 forUpdateId:[diction objectForKey:@"update_id"] andManObjCon:self.managedObjectContext];
                    if(!invite)
                    {
                        NSLog(@"InInviteFriendStatusInUpdate");
                        
                        invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
                        
                        
                        
                        invite.teamName=[aDict objectForKey:@"team_name"];//[ aDict objectForKey:@"team_name"];
                        invite.teamId=[aDict objectForKey:@"team_id"];//[NSString stringWithFormat:@"%@", [ aDict objectForKey:@"team_id"] ];
                        invite.message=[diction objectForKey:@"status_update"];//[NSString stringWithFormat:@"New status update for %@ team",invite.teamName];
                        invite.type=[NSNumber numberWithInt:3];
                        
                        invite.postId=[diction objectForKey:@"update_id"];
                        invite.inviteStatus=[NSNumber numberWithInt:[[diction objectForKey:@"view_status"] integerValue]];
                        
                        
                        int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                        
                        NSDate *datetime=   [[appDelegate.dateFormatFullOriginalComment dateFromString:[diction objectForKey:@"adddate"]] dateByAddingTimeInterval:difftime]  ;
                        invite.datetime=datetime;
                        invite.senderProfileImage=[ [NSString alloc] initWithFormat:@"%@%@", TEAM_LOGO_URL,[ aDict objectForKey:@"team_logo"] ];
                        
                    }
                    
                    
                    
                    
                }
                
                
                */
                
                
                [appDelegate saveContext];
                
                

                
                
                
                
                
                
                
                
                
                
               ///////////////////////////////////
                NSArray *eventDetails=[aDict objectForKey:@"event_details"];
                NSArray *playerDetails=[aDict objectForKey:@"player_details"];
                
                NSDictionary *playerinfo=nil;
                if(playerDetails.count)
                    playerinfo= [playerDetails objectAtIndex:0];
                
                
                if([[self.requestDic objectForKey:@"invites"] isEqualToString:@"Accept"] || [[self.requestDic objectForKey:@"invites"] isEqualToString:@"Maybe"])
                {
                    if([[self.requestDic objectForKey:@"invites"] isEqualToString:@"Maybe"])
                        [self.appDelegate addEventsAfterLogin:eventDetails:0:[playerinfo objectForKey:@"player_name"]:[playerinfo objectForKey:@"player_id"]:[self.requestDic objectForKey:@"UserID"]:1:0:1:0];
                    else
                        [self.appDelegate addEventsAfterLogin:eventDetails:0:[playerinfo objectForKey:@"player_name"]:[playerinfo objectForKey:@"player_id"]:[self.requestDic objectForKey:@"UserID"]:0:0:1:0];
                    
                }
//                if(arraynames.count>0 && arrayids.count>0)
//                {
//                    [appDelegate.centerVC addTeamListing:arraynames :arrayids:arrayStatus];
//                    
//                    
//                   /* UIButton *bt=nil;
//                    
//                    if((appDelegate.centerVC.dataArrayUpButtons.count-1)==0)
//                    {
//                        bt=appDelegate.centerVC.buttonfirstinscroll;
//                    }
//                    else
//                    {
//                        bt=(UIButton*)[appDelegate.centerVC.menuupscrollview viewWithTag:(appDelegate.centerVC.dataArrayUpButtons.count-1)];
//                    }
//                    
//                    [appDelegate.centerVC upBtapped:bt];*/
//                    
//                    
//                    
//                    int tag=(appDelegate.centerVC.dataArrayUpButtons.count-1);
//                    
//                    
//                    /////
//                    for(id v in self.appDelegate.centerVC.menuupscrollview.subviews)
//                    {
//                        if([v isMemberOfClass:[UIButton class]])
//                        {
//                            UIButton *bt=(UIButton*)v;
//                            if(tag==[v tag])
//                            {
//                                [bt setTitleColor:self.redcolor forState:UIControlStateNormal];
//                                
//                                appDelegate.centerVC.lastSelectedTeam=tag;
//                                
//                               // [self sendRequestForTeamWall];
//                                
//                            }
//                            else
//                            {
//                                [bt setTitleColor:self.darkgraycolor forState:UIControlStateNormal];
//                            }
//                        }
//                    }
//                 
//               
//
//               
//                    
//                    [self.appDelegate.centerVC resetPostView];
//                    if([[self.requestDic objectForKey:@"invites"] isEqualToString:@"Accept"])
//                       [self.appDelegate.centerVC enablepost];
//                    else
//                     [self.appDelegate.centerVC disablepost];
//                    
//                    
//                    
//                    ////
//                }
                
                [appDelegate.centerViewController showNavController:appDelegate.navigationController];
            }
            else
            {
                [self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
            }
        }
    }
    }
    else
    {
        
        
        
        
        if (str)
        {
            SBJsonParser *parser=[[SBJsonParser alloc] init];
            id res = [parser objectWithString:str];
            if ([res isKindOfClass:[NSDictionary class]])
            {
                NSDictionary* aDict = (NSDictionary*) res;
                if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
                {
                    
                    [self showHudAlert:[aDict objectForKey:@"message"]];
                    [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
                    
                    
                 
                    aDict=[aDict objectForKey:@"TeamDetails"];
                    
                    
                    NSNumber *frresstatus=nil;
                    
                    if( [[self.requestDic objectForKey:@"status"] isEqualToString:@"Accept"])
                    {
                        frresstatus=[[NSNumber alloc] initWithBool:1];
                    }
                    else
                    {
                        frresstatus=[[NSNumber alloc] initWithBool:0];
                    }

                    
                    
                    
                    NSMutableDictionary *micdic=[NSMutableDictionary dictionaryWithObjectsAndKeys:frresstatus,SECONDARYUSERSENDERID, nil];//[NSMutableDictionary dictionaryWithObjectsAndKeys:[aDict objectForKey:CREATORNAME],CREATORNAME,[aDict objectForKey:CREATORPHNO],CREATORPHNO,[aDict objectForKey:CREATOREMAIL],CREATOREMAIL, nil];
                       NSString *teamSportN=@"";
                    if([aDict objectForKey:@"team_sport"])
                   teamSportN= [aDict objectForKey:@"team_sport"];
                    
                    
                    [appDelegate.centerVC updateArrayByAddingOneTeam:newinvite.teamName :newinvite.teamId:[self.requestDic objectForKey:@"status"] :[NSNumber numberWithInt:0] :[ NSString stringWithFormat:@"%@%@", TEAM_LOGO_URL,[aDict objectForKey:@"team_logo"] ]:[aDict objectForKey:@"status_update"] :[NSMutableArray array]:micdic:teamSportN];
                    
                    
                    [appDelegate.managedObjectContext deleteObject:self.newinvite];
                    [appDelegate saveContext];
                    
                    
                    
                    
                    [appDelegate.centerViewController showNavController:appDelegate.navigationController];
                }
                else
                {
                    [self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
                }
            }
        }

        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
}


-(void)hideHudViewHere
{

    [self.navigationController popViewControllerAnimated:YES];
  // [self.view removeFromSuperview];
    
}

- (void)viewDidUnload
{
    self.textVw=nil;
    [super viewDidUnload];
}
@end
