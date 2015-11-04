//
//  TeamMaintenanceVC.m
//  Social
//
//  Created by Animesh@Mindpace on 09/09/13.
//
//
#import "CenterViewController.h"
#import "SelectContact.h"
#import "LeftViewController.h"
#import "HomeVC.h"
#import "CustomMailViewController.h"
#import "AddAFriend.h"
#import "TeamDetailsViewController.h"
#import "AddAFriendListCell.h"
#import "SaveTeamViewController.h"
#import "SelectContact.h"
@interface AddAFriend ()

@end

@implementation AddAFriend
@synthesize tbllView,msgLabel,JSONDATAarr,JSONDATAImages,tickimage,nontickimage,teamNames,teamIds,sendEmailId,teamId,strofbody,currentrow,selectedRow,selectContact,sendEmailName;
int row,mode;


-(void)viewDidUnload
{
   

    [self setPicker:nil];
    [super viewDidUnload];
    self.msgLabel=nil;
    self.tbllView=nil;
}


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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(totalTeamListUpdated:) name:TOTALTEAMLISTUPDATED object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageUpdated:) name:TEAMLISTINGIMAGELOADED object:nil];
    // Do any additional setup after loading the view from its nib.
    self.topview.backgroundColor=appDelegate.barGrayColor;
    //self.view.backgroundColor=appDelegate.backgroundPinkColor;
    
    
    @autoreleasepool
    {
        self.tickimage=[UIImage imageNamed:@"box with tick mark.png"];
        self.nontickimage=[UIImage imageNamed:@"transparent box.png"];
    }
    
    
    storeCreatedRequests=[[NSMutableArray alloc] init];

}

- (void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self name:HANDLERECEIVEDMEMORYWARNING object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TEAMLISTINGIMAGELOADED object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TOTALTEAMLISTUPDATED object:nil];
}

-(void)resetData
{
    NSMutableArray *marray=[[NSMutableArray alloc] init];
      NSMutableArray *marray1=[[NSMutableArray alloc] init];
    
    
    self.teamNames=marray;
    self.teamIds=marray1;
    
    marray=nil;
    marray1=nil;
    
    self.selectedRow=0;
     if(JSONDATAarr && JSONDATAarr.count>0)
     {
     [self.picker reloadAllComponents];
     [self.picker selectRow:self.selectedRow inComponent:0 animated:NO];
     }
}

- (IBAction)doneTapped:(id)sender
{
    
     self.selectedRow=self.currentrow;
    [self.teamNames removeAllObjects];
    [self.teamIds removeAllObjects];
    NSString *teamname=[[self.JSONDATAarr objectAtIndex:self.selectedRow] objectForKey:@"team_name"];
    NSString *teamid=[[NSString alloc] initWithFormat:@"%@",[[self.JSONDATAarr objectAtIndex:self.selectedRow] objectForKey:@"team_id"] ];
    
    
    
    if([teamid isEqualToString:@""])
    {
        for(int i=0;i<=(self.JSONDATAarr.count-2) ;i++)
        {
            NSDictionary *dic =[self.JSONDATAarr objectAtIndex:i];
            
           // [self.teamIds addObject:[dic objectForKey:@"team_id"]];
            [self.teamNames addObject:[dic objectForKey:@"team_name"]];
        }
    }
    else
    {
    [self.teamIds addObject:teamid];
    [self.teamNames addObject:teamname];
    }
    
    
    
    if(self.teamNames.count>0 /*&& self.teamIds.count>0*/)
    {

        
        NSString *teamList=[[[[NSString stringWithFormat:@"%@",self.teamNames] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]] stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        teamList=[teamList stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        
           /*NSString *teamListIds=[[[[NSString stringWithFormat:@"%@",self.teamIds] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]] stringByReplacingOccurrencesOfString:@" " withString:@""];;*/
     //   NSLog(@"teamList=%@,teamListIds=%@",teamList,teamListIds);
        
        NSString *s1=@"";
        
         if(self.teamNames.count>1 /*&& self.teamIds.count>1*/)
             s1=@"s";
        
        NSString *body=nil;
      //Ch  NSString *name=   [NSString stringWithFormat:@"%@ %@",[appDelegate.aDef objectForKey:FIRSTNAME],[appDelegate.aDef objectForKey:LASTNAME]];
        
        if(![appDelegate.leftVC.userNameLbl.text isEqualToString:@""])
            
            body= @"";/*Ch[NSString stringWithFormat:@"Hi,\n\nI'd like to invite you to join team%@, %@ on MyGameWall (%@)\n\n%@",s1,teamList,APPURL,name];*/
        
        else
            body= @""; /*Ch[NSString stringWithFormat:@"Hi,\n\nI'd like to invite you to join team%@, %@ on MyGameWall (%@)",s1,teamList,APPURL];*/
        
        
        //self.teamId=teamListIds;
        self.strofbody=body;
        if(self.teamNames.count>1)
            [ [self.selectContact custompopuplabInvite] setText:[NSString stringWithFormat:@"Invite %@ (%@) to All Teams?",self.sendEmailName,self.sendEmailId]];
        else
        {
            if ([self.sendEmailName isEqualToString:@""]) {
                [[self.selectContact custompopuplabInvite] setText:[NSString stringWithFormat:@"Invite %@ %@ to %@?",self.sendEmailName,self.sendEmailId,[self.teamNames firstObject]]];
            }
            else
                [[self.selectContact custompopuplabInvite] setText:[NSString stringWithFormat:@"Invite %@ (%@) to %@?",self.sendEmailName,self.sendEmailId,[self.teamNames firstObject]]];  // 21/7/14
        }
        [self.selectContact showAlertViewCustomInvite:@"Friend invite has been sent" ];
        
        [self.selectContact hideAddAFriendNative];
        //[self sendToServer];
    }
    else
    {
        [self showAlertMessage:@"Please select atleast one team." title:@""];
    }
    
    
}


-(void)sendToServer
{
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"user_id"];
    
      NSLog(@"addAFriendVC.sendEmailId22=%@",self.sendEmailId);
      [command setObject:self.sendEmailId forKey:@"email_id"];
    
    
    [command setObject:@"" forKey:@"text"];
    
   // NSArray *ar=[self.teamId componentsSeparatedByString:@","];
    
    [command setObject:self.teamIds forKey:@"team_id"];
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    [self.selectContact showHudView:@"Connecting..."];
    [self showNativeHudView];
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    
    
    self.requestDic=command;
    [appDelegate sendRequestFor:INVITEFRIENDS from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
}




-(void)notifyRequesterWithData:(id) aData :(id)aData1
{
    
    [self.selectContact hideHudView];
    [self hideNativeHudView];
    
    if([aData isKindOfClass:[ConnectionManager class]])
    {
        ConnectionManager *aR=(ConnectionManager*)aData;
        if([aR.requestSingleId isEqualToString:INVITEFRIENDS])
        {
            
        }
        return;
    }
    
    NSString *str=(NSString*)aData;
    
    NSLog(@"Data=%@",str);
 
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
                
                // [ [self.selectContact custompopuplab] setText:@"Friend invite has been sent"];  // 21/7/14
                if(self.teamIds.count==1 && self.teamNames.count==1)
                {
                if(![[aDict objectForKey:@"invite_send"] isEqualToString:@""])
                {
                    [self.selectContact showAlertViewCustom:[NSString stringWithFormat:@"%@ is invited to %@",self.sendEmailId,[self.teamNames objectAtIndex:0]]];
                    
                }
                else if(![[aDict objectForKey:@"invite_not_send"] isEqualToString:@""])
                {
                    
                     //[ [self.selectContact custompopuplab] setText:[NSString stringWithFormat:@"%@ already got an invite for %@",self.sendEmailId,[self.teamNames objectAtIndex:0] ]];
                     //[ self.selectContact showAlertForNotSending:[NSString stringWithFormat:@"Friend invite not sent. %@ is either part of %@ or received an invite from %@",self.sendEmailId,[self.teamNames objectAtIndex:0],[self.teamNames objectAtIndex:0]]];
                    [ self.selectContact showAlertForNotSending:[NSString stringWithFormat:@"%@ has already received an invite from this team. He can view %@ timeline",self.sendEmailId,[self.teamNames objectAtIndex:0]]];
                    
                    
                    
                    
                }
                    else
                    {
                        [self hideHudViewHere];
                    }
                }
                else
                {
                    if([[aDict objectForKey:@"invite_send"] isEqualToString:@""])
                    {
                        //[ [self.selectContact custompopuplab] setText:[NSString stringWithFormat:@"%@ already got an invite for all the teams",self.sendEmailId]];
                        [ self.selectContact showAlertForNotSending:[NSString stringWithFormat:@"Friend invite not sent. %@ is already part of all the selected teams or received invite from all these teams",self.sendEmailId ]];
                    }
                    else
                    {
                        [self hideHudViewHere];
                    }

                }
                
                
                
               // [self.selectContact showAlertViewCustom:@"Friend invite has been sent" ]; // 21/7/14
               // [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
                self.requestDic=nil;
                
              
                
            }
            else
            {
                [self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
            }
        }
    }
    
     
}

-(void)hideHudViewHereOnly{
    [self.selectContact hideAddAFriendNative];
}

-(void)hideHudViewHere
{
    [self.selectContact hideHudView];
   
    [self. selectContact resetInHide];
     [self.selectContact hideAddAFriendNative];
    
    
//    [appDelegate.navigationControllerAddAFriend.view setHidden:YES];
//    
//    [self.selectContact requestServerData];  //// 18//03/2015 AD
    
    //[self performSelector:@selector(getUserListings) withObject:nil afterDelay:0.0];
    //[appDelegate.centerViewController showNavController:appDelegate.navigationController];   ///// 9/03/2015 AD
    
  //  [((UIViewController*)self.selectContact).navigationController popViewControllerAnimated:YES];
}

-(void)hideHudViewHereFinished
{
    
    
    [self hideHudView];
}

- (IBAction)cancelTapped:(id)sender
{
   
   // [self.navigationController dismissViewControllerAnimated:YES completion:nil ];
  //      [self.navigationController.view setHidden:YES];
   //[self.navigationController popViewControllerAnimated:YES];
    [self.selectContact hideAddAFriendNative];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
   
//    mode=0;
//    
    [self loadTeamData];
    
}



-(void)totalTeamListUpdated:(id)sender
{
    
    HomeVC *hvc=(HomeVC*)[sender object];
    
    NSMutableArray *marr=[[NSMutableArray alloc] init];
    
    self.JSONDATAarr=marr;
    [self resetData];
    
    NSDictionary *dicv=nil;
     
    for(int i=0;i<hvc.dataArrayUpButtons.count;i++)
    {
        
       //id isSecondary=[[hvc.dataArrayUpCoachDetails objectAtIndex:i] objectForKey:SECONDARYUSERSENDERID];
        
        //BOOL m=[[hvc.dataArrayUpIsCreated objectAtIndex:i] integerValue];
        
        
        
        /*if(!isSecondary)
        {*/
            
            /*if(!m)
            {*/
        if([[hvc.dataArrayUpInvites objectAtIndex:i] isEqualToString:@"Accept"])
        {
            
            if(![[hvc.dataArrayUpCoachDetails objectAtIndex:i] objectForKey:SECONDARYUSERSENDERID])
            
            {
        dicv=[[NSDictionary alloc] initWithObjectsAndKeys:[hvc.dataArrayUpButtons objectAtIndex:i],@"team_name", [hvc.dataArrayUpButtonsIds objectAtIndex:i],@"team_id",nil ];
              [JSONDATAarr addObject:dicv];
            }
        }
            //}
        //}
      
        
    }
    
    self.tbllView.hidden=NO;
    self.msgLabel.hidden=YES;
   marr=[[NSMutableArray alloc] init];
    self.JSONDATAImages=marr;
  
    
    for(int i=0;i<hvc.dataArrayUpButtons.count;i++)
    {
         //id isSecondary=[[hvc.dataArrayUpCoachDetails objectAtIndex:i] objectForKey:SECONDARYUSERSENDERID];
        
          //BOOL m=[[hvc.dataArrayUpIsCreated objectAtIndex:i] integerValue];
        
        /*if(!isSecondary)
        {*/
            /*if(!m)
            {*/
       
        if([[hvc.dataArrayUpInvites objectAtIndex:i] isEqualToString:@"Accept"])
        {
            if(![[hvc.dataArrayUpCoachDetails objectAtIndex:i] objectForKey:SECONDARYUSERSENDERID])
                
            {
        [self.JSONDATAImages addObject:[hvc.dataArrayUpImages objectAtIndex:i]];
            }
        }
            //}
        //}
    }
    
    if(self.JSONDATAarr.count>0)
    {
        if(self.JSONDATAarr.count!=1)
        {
        dicv=[[NSDictionary alloc] initWithObjectsAndKeys:@"All Teams",@"team_name", @"",@"team_id",nil ];
        [JSONDATAarr addObject:dicv];
        }
        
      [self.tbllView reloadData];
    }
    else
    {
    self.tbllView.hidden=YES;
    self.msgLabel.hidden=NO;
    self.msgLabel.text=@"No Team Found.";
    }
    
    
}



- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	NSLog(@"Row : %d and Col %d ",row,component);
    
    
    
    
    self.currentrow = row;
    
    
    
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}


-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    
    
    
        return self.JSONDATAarr.count;
   
    
}
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
  
        return [[self.JSONDATAarr objectAtIndex:row] objectForKey:@"team_name"];
   
    
    
    // return [self.arrPickerItems5 objectAtIndex:row];
    
}




-(void)loadTeamData
{
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    [command setObject:[self.appDelegate.aDef objectForKey:LoggedUserID] forKey:@"coach_id"];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
 //   [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    
    // [appDelegate sendRequestFor:TEAM_LISTING from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
    [self sendRequestForTeamData:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];

}


-(void)sendRequestForTeamData:(NSDictionary*)dic
{
    // NSString *str=POST;
    
    NSURL* url = [NSURL URLWithString:TEAM_LISTING_LINK];
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
    [aRequest setDidFinishSelector:@selector(requestFinished:)];
    [aRequest setDidFailSelector:@selector(requestFailed:)];
    
    [aRequest startAsynchronous];
    
}


- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    [self.selectContact hideHudView];
    [self hideNativeHudView];
    NSString *str=[request responseString];
    
    NSLog(@"Data=%@",str);
    
    
    if(str)
    
        {
            SBJsonParser *parser=[[SBJsonParser alloc] init];
            id res = [parser objectWithString:str];
            if ([res isKindOfClass:[NSDictionary class]])
            {
                NSDictionary* aDict = (NSDictionary*) res;
                // aDict=[aDict objectForKey:@"responseData"];
                NSString *message=[aDict objectForKey:@"message"];
                
                if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
                {
                    self.tbllView.hidden=NO;
                    self.msgLabel.hidden=YES;
                    
                    self.JSONDATAarr=[NSMutableArray arrayWithArray:[[aDict objectForKey:@"response"] objectForKey:@"team_list"]];
                     [self resetData];
                    
                    NSMutableArray *marr=[[NSMutableArray alloc] init];
                    self.JSONDATAImages=marr;
                    for(NSDictionary *dic in self.JSONDATAarr )
                    {
                        ImageInfo *userImainfo=  [[ImageInfo alloc] initWithSourceURL:[NSURL URLWithString:[ NSString stringWithFormat:@"%@%@", TEAM_LOGO_URL,[dic objectForKey:@"team_logo"] ]]];
                        [self.JSONDATAImages addObject:userImainfo];
                        
                    }
                    
                    [self.tbllView reloadData];
                    
                }
                else
                {
                    self.tbllView.hidden=YES;
                    self.msgLabel.hidden=NO;
                    self.msgLabel.text=message;
                }
            }
        }
}


- (void)requestFailed:(ASIHTTPRequest *)request
{
    [self.selectContact hideHudView];
    [self hideNativeHudView];
	NSLog(@"Error receiving dataImage : %@ ",[request.error description]);
	//[self showAlertMessage:CONNFAILMSG];//ChAfter
    
    
	
}



-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
 
}

/*-(void)notifyRequesterWithData:(id) aData :(id)aData1
{
    
    [self hideHudView];
    [self hideNativeHudView];
    
    if([aData isKindOfClass:[ConnectionManager class]])
    {
        ConnectionManager *aR=(ConnectionManager*)aData;
        
        if (mode==0)
        {
            if([aR.requestSingleId isEqualToString:TEAM_LISTING])
            {
            
            }
        }
        
        if (mode==1)
        {
            if([aR.requestSingleId isEqualToString:DELETE_TEAM])
            {
                
            }
        }
        
        return;
    }
    
    
    NSString *str=(NSString*)aData;
    
    NSLog(@"JSONData=%@",str);
    
    
    if (mode==0)
    {
        if (str)
        {
            SBJsonParser *parser=[[SBJsonParser alloc] init];
            id res = [parser objectWithString:str];
        if ([res isKindOfClass:[NSDictionary class]])
        {
            NSDictionary* aDict = (NSDictionary*) res;
            // aDict=[aDict objectForKey:@"responseData"];
            NSString *message=[aDict objectForKey:@"message"];
            
            if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
            {
                self.tbllView.hidden=NO;
                self.msgLabel.hidden=YES;
                
                self.JSONDATAarr=[NSMutableArray arrayWithArray:[[aDict objectForKey:@"response"] objectForKey:@"team_list"]];
                
                
                NSMutableArray *marr=[[NSMutableArray alloc] init];
                self.JSONDATAImages=marr;
                for(NSDictionary *dic in self.JSONDATAarr )
                {
                    ImageInfo *userImainfo=  [[ImageInfo alloc] initWithSourceURL:[NSURL URLWithString:[ NSString stringWithFormat:@"%@%@", TEAM_LOGO_URL,[dic objectForKey:@"team_logo"] ]]];
                    [self.JSONDATAImages addObject:userImainfo];
                   
                }
                
                [self.tbllView reloadData];
                
            }
            else
            {
                self.tbllView.hidden=YES;
                self.msgLabel.hidden=NO;
                self.msgLabel.text=message;
            }
        }
    }
    }
    if (mode==1)
    {
        if (str)
        {
            SBJsonParser *parser=[[SBJsonParser alloc] init];
            id res = [parser objectWithString:str];
            if ([res isKindOfClass:[NSDictionary class]])
            {
                NSDictionary* aDict = (NSDictionary*) res;
                // aDict=[aDict objectForKey:@"responseData"];
                NSString *message=[aDict objectForKey:@"message"];
                NSLog(@"%@",message);
                
                if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
                { 
                    
                    [self.JSONDATAarr removeObjectAtIndex:row];
                    
                    [self.tbllView reloadData];
                    
                }
                else
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Operation failed." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                    [alert show];
                }
            }
        }
    }
}*/





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"numberOfRowsInSectionAddFriend==%i",section);
    
    return [self.JSONDATAarr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    /* if(indexPath.row==0)
     {
     return 174.0;
     }
     else if(indexPath.row==25)
     {
     return 140.0;
     }
     else
     {*/
    
    
    return 38;
    //}
    
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AddAFriendListCell";
    
    AddAFriendListCell *cell = [self.tbllView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = (AddAFriendListCell *)[AddAFriendListCell cellFromNibNamed:CellIdentifier];
        
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}



- (void)delBtnTapped:(UIButton*)sender
{
    mode=1;
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    row=sender.tag;
    [command setObject:[NSString stringWithFormat:@"%@", [[self.JSONDATAarr objectAtIndex:row] objectForKey:@"team_id"] ] forKey:@"team_id"];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    [self.selectContact showHudView:@"Connecting..."];
    [self showNativeHudView];
    
    [appDelegate sendRequestFor:DELETE_TEAM from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
}

- (void)imageUpdated:(NSNotification *)notif
{
    
    
    
    NSNumber * info = [notif object];
    
    
        int row = [info intValue];
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        
        NSLog(@"ADDFImage for indexpath %i updated", indexPath.row);
          NSLog(@"ADDAFRIENDVC1reloadRows");
        [self.tbllView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
      NSLog(@"ADDAFRIENDVC2reloadRows");
    
}


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
      NSLog(@"ADDAFRIENDVCellConfigureCall");
    NSString *teamId1=[[self.JSONDATAarr objectAtIndex:indexPath.row] objectForKey:@"team_id"];
    
    AddAFriendListCell *cell1=(AddAFriendListCell*)cell;
    
    cell1.teamName.text=[[self.JSONDATAarr objectAtIndex:indexPath.row] objectForKey:@"team_name"];
   // cell1.sport.text=[[self.JSONDATAarr objectAtIndex:indexPath.row] objectForKey:@"team_sport"];
    
 // if( ![[[self.JSONDATAarr objectAtIndex:indexPath.row] objectForKey:@"team_logo"] isEqualToString:@""])
//  {
     ImageInfo * info1 = [self.JSONDATAImages objectAtIndex:indexPath.row];
      
      if(info1.image)
      {
          [cell1.posted setImage:info1.image   ];
          cell1.posted.hidden=NO;
          cell1.acindviewposted.hidden=YES;
          [cell1.acindviewposted stopAnimating];
          
      }
      else
      {
        //  cell1.acindviewposted.hidden=NO;
        //  cell1.posted.hidden=YES;
         // [cell1.acindviewposted startAnimating];
           cell1.posted.image=[UIImage imageNamed:@"no_image.png"];
           cell1.acindviewposted.hidden=YES;
          info1.notificationName=TEAMLISTINGIMAGELOADED;
          info1.notifiedObject=[NSNumber numberWithInt:indexPath.row];
          
        if(!info1.isProcessing)
          [info1 getImage];
      }
      

//  }
//  else
//  {
//      cell1.posted.hidden=NO;
//      cell1.acindviewposted.hidden=YES;
//      [cell1.acindviewposted stopAnimating];
//      cell1.posted.image=[UIImage imageNamed:@"no_image.png"];
//      
//      
//      
//      
//      
//  }
    cell1.delBtn.hidden=YES;
   /* cell1.delBtn.tag=indexPath.row;
    [cell1.delBtn addTarget:self action:@selector(delBtnTapped:) forControlEvents:UIControlEventTouchUpInside];*/
    //   cell1.leftimav.backgroundColor=lightbluecolor;
    /*  if(indexPath.row%2)
     cell1.frntvw.backgroundColor=graycolor;
     else
     cell1.frntvw.backgroundColor=lightgraycolor;*/
    
    [cell1.layer setCornerRadius:3.0f];
    [cell1.layer setMasksToBounds:YES];
    
    cell1.selectionStyle=UITableViewCellSelectionStyleNone;
    
    [cell1.btCheck addTarget:self action:@selector(checkTapped:) forControlEvents:UIControlEventTouchUpInside];
    
   if( [self.teamIds containsObject:teamId1 ])
   {
       [cell1.btCheck setImage:self.tickimage forState:UIControlStateNormal];
   }
   else
   {
       [cell1.btCheck setImage:self.nontickimage forState:UIControlStateNormal];
   }
    
    
    
}


-(void)checkTapped:(id)sender
{
    UIButton *bt=(UIButton*)sender;
    
    
    AddAFriendListCell *flistCell=(AddAFriendListCell*) bt.superview.superview;
    
    NSIndexPath *indexPath=[self.tbllView indexPathForCell:flistCell];
    
    NSString *teamname=   [[self.JSONDATAarr objectAtIndex:indexPath.row] objectForKey:@"team_name"];
    NSString *teamid=   [[NSString alloc] initWithFormat:@"%@",  [[self.JSONDATAarr objectAtIndex:indexPath.row] objectForKey:@"team_id"] ];
    
    
    if([[flistCell.btCheck imageForState:UIControlStateNormal] isEqual:self.nontickimage])
    {
        [flistCell.btCheck setImage:self.tickimage forState:UIControlStateNormal];
        
        if( ![self.teamIds containsObject:teamid ])
        {
            [self.teamIds addObject:teamid];
        }
        
        if( ![self.teamNames containsObject:teamname])
        {
            [self.teamNames addObject:teamname];
        }
    }
    else
    {
        [flistCell.btCheck setImage:self.nontickimage forState:UIControlStateNormal];
        
        if( [self.teamIds containsObject:teamid ])
        {
            [self.teamIds removeObject:teamid];
        }
        
        if( [self.teamNames containsObject:teamname ])
        {
            [self.teamNames removeObject:teamname];
        }
    }
    
    
}



-(IBAction)AddTeam:(UIButton*)sender
{
    /*TeamDetailsViewController *addTeam=[[TeamDetailsViewController alloc]initWithNibName:@"TeamDetailsViewController" bundle:nil];
    [self.navigationController pushViewController:addTeam animated:YES];
    [addTeam release];*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
