//
//  TeamPlayerViewController.m
//  Wall
//
//  Created by Sukhamoy on 09/12/13.
//
//

#import "TeamPlayerViewController.h"
#import "RightVCTableCell.h"
#import "PlayerDetails.h"
#import "UIImageView+AFNetworking.h"
#import "ChatViewController.h"
#import "CenterViewController.h"
@interface TeamPlayerViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TeamPlayerViewController
@synthesize myAllFriend;


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
  //  self.view.backgroundColor=appDelegate.backgroundPinkColor;
    self.topview.backgroundColor=appDelegate.barGrayColor;
    self.playerListTable.separatorColor=[UIColor lightGrayColor];
    
    self.sportname=[NSArray arrayWithObjects:@"Badminton",@"Baseball",@"Basketball",@"Bicycling",@"Chess",@"Cricket",@"Field hockey",@"Fishing",@"Football",@"Ice hockey",@"Kayaking",@"Lacrosse",@"Picnic",@"Reunion",@"Rowing",@"Running",@"Skiing",@"Soccer",@"Table Tennis",@"Tennis",@"Volleyball",@"Walking",nil];
    self.msgLbl.hidden=YES;
    self.selectedRow=0;
    
    NSMutableArray *marr=[[NSMutableArray alloc] init];
    self.storeCreatedRequests=marr;
    [marr release];
    marr=nil;
    [self getAllTemaDetailsFoeUser];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
     [[NSNotificationCenter defaultCenter] removeObserver:self name:HANDLERECEIVEDMEMORYWARNING object:nil];
    [_playerListTable release];
    [_pickerView release];
    [_picker release];
    [super dealloc];
}


- (void)viewDidUnload {
    [self setMsgLbl:nil];
    [self setTeamNameLbl:nil];
    [self setSportLogoImage:nil];
    [self setTeamLogoImage:nil];
    [self setCallPopUp:nil];
    [self setPhoneNoLbl:nil];
    [super viewDidUnload];
}
#pragma mark - GetTeamDetails For USer
-(void)getAllTemaDetailsFoeUser{
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
          
    [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
    [command setObject:@"1" forKey:@"case"];

    NSLog(@"user id %@",[appDelegate.aDef objectForKey:LoggedUserID]);
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];

    NSString *jsonCommand = [writer stringWithObject:command];
    
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    
    NSURL* url = [NSURL URLWithString:TEAMROSTERLINK];

    ASIFormDataRequest *aRequest=  [[ASIFormDataRequest alloc] initWithURL:url] ;
    self.myFormRequest1=aRequest;
    [self.storeCreatedRequests addObject:aRequest];

    [self.storeCreatedRequests addObject:self.myFormRequest1];
    
    
    [aRequest setShouldContinueWhenAppEntersBackground:YES];
    
    [aRequest setDelegate:self];
    
    [aRequest setValidatesSecureCertificate:NO];
    [ASIFormDataRequest setShouldThrottleBandwidthForWWAN:YES];
    [aRequest addPostValue:jsonCommand forKey:@"requestParam"];
    
    [aRequest setDidFinishSelector:@selector(requestFinished:)];
    [aRequest setDidFailSelector:@selector(requestFailed:)];
    
    [aRequest startAsynchronous];

    [self.storeCreatedRequests addObject:self.myFormRequest1];

}

- (void)requestFinished:(ASIHTTPRequest *)request
{
	NSLog(@"Data Received in Connection Manager.... %@ ",[request responseString]);
    // [self hideActiveIndicatorOwnPost];
    [self hideNativeHudView];
    [self hideHudView];
    
    NSString *str=[request responseString];
    NSLog(@"Data=%@",str);
    self.allTeamList=nil;
    self.groupDict=nil;

    
    if (str)
    {
        SBJsonParser *parser=[[SBJsonParser alloc] init];
        
        id res = [parser objectWithString:str];
        if ([res isKindOfClass:[NSDictionary class]])
        {
            
            NSDictionary* aDict = (NSDictionary*) res;
            self.allTeamList=[[[aDict objectForKey:@"response"] objectForKey:@"users_team"] objectForKey:@"team_list"];
            self.saveAllTeam=self.allTeamList;
            
            if(self.allTeamList.count>0)
            {
                
                if(self.allTeamList.count==1){
                    
                    self.teamRosterFilterImageView.hidden=YES;
                    self.teamRosterBtn.hidden=YES;
                    self.teamRosterLbl.hidden=YES;
                    
                }else{
                    
                    self.teamRosterFilterImageView.hidden=NO;
                    self.teamRosterBtn.hidden=NO;
                    self.teamRosterLbl.hidden=NO;

                }
                
                
            self.playerListTable.hidden=NO;
            NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                                initWithKey:@"team_name"  ascending:YES];
                
            NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
                
           self.allTeamList = [self.allTeamList sortedArrayUsingDescriptors:sortDescriptors];
            
            NSArray * playerDetails=[[self.allTeamList objectAtIndex:0] valueForKey:@"player_details"];
            NSPredicate *sPredicate = [NSPredicate predicateWithFormat: @"UserID!='0' AND invites!='Decline'" ];
            
            playerDetails = [NSMutableArray arrayWithArray:[playerDetails
                                                        filteredArrayUsingPredicate:sPredicate]];
            [[self.allTeamList objectAtIndex:0] setObject:playerDetails forKey:@"player_details"];
           
            self.groupDict=[self.allTeamList objectAtIndex:0];
                
            NSString *imgUrl= [NSString stringWithFormat:@"%@%@",TEAM_LOGO_URL,[self.groupDict valueForKey:@"team_logo"]];
            [self.teamLogoImage setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:self.teamNoImage];
            self.teamNameLbl.text=[self.groupDict valueForKey:@"team_name"];
            self.sportLogoImage.image=[self getSportImage:[self.groupDict valueForKey:@"team_sport"]];
            
            // [self groupByCoach];
            self.playerListTable.hidden=NO;
            self.msgLbl.hidden=YES;

            [self.playerListTable reloadData];
                
            }else{
                self.msgLbl.hidden=NO;
                self.playerListTable.hidden=YES;
                self.teamRosterFilterImageView.hidden=YES;
                self.teamRosterBtn.hidden=YES;
                self.teamRosterLbl.hidden=YES;
                self.teamNameLbl.text=@"";
                [self.playerListTable reloadData];

            }
        }else{
            self.msgLbl.hidden=NO;
            self.playerListTable.hidden=YES;
            self.teamRosterFilterImageView.hidden=YES;
            self.teamRosterBtn.hidden=YES;
            self.teamRosterLbl.hidden=YES;
            self.teamNameLbl.text=@"";
            [self.playerListTable reloadData];

        }
        
    }else{
        
        [self.playerListTable reloadData];

        
    }
    
    
	
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    
    
    [self hideNativeHudView];
    [self hideHudView];
	//[self showAlertMessage:CONNFAILMSG];ChAfter
	
}


#pragma mark - PickerView 

- (IBAction)filterDataUsingTeam:(id)sender
{
    
    if (self.allTeamList.count)
    {
        
        self.pickerView.hidden=NO;
        [self.view bringSubviewToFront:self.pickerView];
        
        [self.picker reloadAllComponents];
    }
    
  
}

- (IBAction)pickerCancel:(id)sender {
    
    self.pickerView.hidden=YES;

}

- (IBAction)pickerDone:(id)sender {
    
    self.pickerView.hidden=YES;
    NSArray * playerDetails=[[self.allTeamList objectAtIndex:self.selectedRow] valueForKey:@"player_details"];
    NSPredicate *sPredicate = [NSPredicate predicateWithFormat: @"invites='Accept'" ];
    
    playerDetails = [NSMutableArray arrayWithArray:[playerDetails
                                                    filteredArrayUsingPredicate:sPredicate]];
    [[self.allTeamList objectAtIndex:self.selectedRow] setObject:playerDetails forKey:@"player_details"];

    self.groupDict=[self.allTeamList objectAtIndex:self.selectedRow];
    
    NSString *imgUrl= [NSString stringWithFormat:@"%@%@",TEAM_LOGO_URL,[self.groupDict valueForKey:@"team_logo"]];
    [self.teamLogoImage setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:self.teamNoImage];
    self.teamNameLbl.text=[self.groupDict valueForKey:@"team_name"];
    self.sportLogoImage.image=[self getSportImage:[self.groupDict valueForKey:@"team_sport"]];
    [self.playerListTable reloadData];

}
#pragma mark -PickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedRow=row;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return self.allTeamList.count;

}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    
        if (!view){
            
            view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35, 3, 245, 24)];
            label.backgroundColor = [UIColor clearColor];
            [view addSubview:label];
            
            UIImageView *flagView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 24, 24)];
            flagView.contentMode = UIViewContentModeScaleToFill;
            [view addSubview:flagView];
            
            [label release];
            [flagView release];
            [view autorelease];
            
            
        }
        [(UILabel *)(view.subviews)[0] setText:[[self.allTeamList objectAtIndex:row] valueForKey:@"team_name"]];
       // [(UIImageView *)(view.subviews)[1] setImage:[self.allTeamList objectAtIndex:row]];
        return view;
    
}
#pragma mark - SportImage
-(UIImage*)getSportImage:(NSString *)sportName{
    
    int getIndex=0;
    for (int i=0;i<self.sportname.count;i++) {
        
        if ([[self.sportname objectAtIndex:i] isEqualToString:sportName]) {
            getIndex=i;
            break;
        }
    }
    
    return [self.sportsImageArr objectAtIndex:getIndex];
}

#pragma mark - Conversation To Player

-(IBAction)mailtoPlayer:(UIButton*)sender{
    
    
    RightVCTableCell *selectedCell=(RightVCTableCell*)[[sender superview] superview];
    NSIndexPath * selectedIndexPath=[self.playerListTable indexPathForCell:selectedCell];
    
//     if (![[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[self.groupDict valueForKey:@"coach_id"]]){
    
        if (selectedIndexPath.row==0) {
            
            [self sendMail:nil :[self.groupDict valueForKey:@"creator_email"]];

        }else{
              [self sendMail:nil :[[[self.groupDict valueForKey:@"player_details"] objectAtIndex:selectedIndexPath.row -1]  valueForKey:@"Email1"]];
        }
         
//     }else{
//        
//        [self sendMail:nil :[[[self.groupDict valueForKey:@"player_details"] objectAtIndex:selectedIndexPath.row ]  valueForKey:@"Email1"]];
//
//    }

    
}
/*-(IBAction)chattoPlayer:(UIButton*)sender{
    
    
    RightVCTableCell *selectedCell=(RightVCTableCell*)[[sender superview] superview];
    NSIndexPath * selectedIndexPath=[self.playerListTable indexPathForCell:selectedCell];
    
    ChatViewController *fVC=(ChatViewController*)[appDelegate.navigationControllerChat.viewControllers objectAtIndex:0];
    NSString *reciverId=nil;
    
//     if (![[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[self.groupDict valueForKey:@"coach_id"]]){
    
        if (selectedIndexPath.row==0) {
            
            if (![[self.groupDict valueForKey:@"coach_id"] isEqualToString:[appDelegate.aDef objectForKey:LoggedUserID]]) {
                
                fVC.reciverUserId=[self.groupDict valueForKey:@"coach_id"];
                reciverId=[self.groupDict valueForKey:@"coach_id"];
                fVC.reciverName= [self.groupDict valueForKey:@"creator_name"];
                fVC.reciverProfileImage=[NSString stringWithFormat:@"%@%@",IMAGELINK,[self.groupDict valueForKey:@"Coach_ProfileImage"]];

            }
        }else{
                
                if (![[[[self.groupDict valueForKey:@"player_details"] objectAtIndex:selectedIndexPath.row -1] valueForKey:@"player_id"] isEqualToString:[appDelegate.aDef objectForKey:LoggedUserID]]) {
                    
                    fVC.reciverUserId=[[[self.groupDict valueForKey:@"player_details"] objectAtIndex:selectedIndexPath.row -1] valueForKey:@"UserID"];
                    reciverId=[[[self.groupDict valueForKey:@"player_details"] objectAtIndex:selectedIndexPath.row -1] valueForKey:@"UserID"];
                    fVC.reciverName= [[[self.groupDict valueForKey:@"player_details"] objectAtIndex:selectedIndexPath.row -1] valueForKey:@"player_name"];
                    fVC.reciverProfileImage=[NSString stringWithFormat:@"%@%@",IMAGELINK,[[[self.groupDict valueForKey:@"player_details"] objectAtIndex:selectedIndexPath.row - 1] valueForKey:@"ProfileImage"]];
                }

            }
        
//    }else{
//        
//        if (![[[[self.groupDict valueForKey:@"player_details"] objectAtIndex:selectedIndexPath.row ] valueForKey:@"player_id"] isEqualToString:[appDelegate.aDef objectForKey:LoggedUserID]]) {
//            
//           fVC.reciverUserId=[[[self.groupDict valueForKey:@"player_details"] objectAtIndex:selectedIndexPath.row ] valueForKey:@"UserID"];
//            reciverId=[[[self.groupDict valueForKey:@"player_details"] objectAtIndex:selectedIndexPath.row ] valueForKey:@"UserID"];
//            fVC.reciverName= [[[self.groupDict valueForKey:@"player_details"] objectAtIndex:selectedIndexPath.row ] valueForKey:@"player_name"];
//            fVC.reciverProfileImage=[NSString stringWithFormat:@"%@%@",IMAGELINK,[[[self.groupDict valueForKey:@"player_details"] objectAtIndex:selectedIndexPath.row] valueForKey:@"ProfileImage"]];
//        }
//    }
    
    
    [fVC disableRedTopBar];
    
    //[adF resetData];
    fVC.isList=1;
    
    [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerChat];
    
    if (reciverId) {
        [(ChatViewController*)[self.appDelegate.navigationControllerChat.viewControllers objectAtIndex:0]getMessageListforSender:[self.appDelegate.aDef valueForKey:LoggedUserID] andReciver:reciverId];
       // [[(ChatViewController*)self.appDelegate.navigationControllerChat.viewControllers object] getMessageListforSender:[self.appDelegate.aDef valueForKey:LoggedUserID] andReciver:reciverId];

    }
    
}*/

-(IBAction)smstoPlayer:(UIButton*)sender{
    
    RightVCTableCell *selectedCell=(RightVCTableCell*)[[sender superview] superview];
    NSIndexPath * selectedIndexPath=[self.playerListTable indexPathForCell:selectedCell];
    
    self.phoneNoLbl.text=[self.groupDict valueForKey:@"creator_phno"];
    
   // if (![[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[self.groupDict valueForKey:@"coach_id"]]){
    
        if (selectedIndexPath.row==0) {
            
            if (![[self.groupDict  objectForKey:@"creator_phno"] isEqualToString:@""] && ![[self.groupDict  objectForKey:@"creator_phno"] isEqualToString:@"0"]) {
                
                self.phoneNoImageView.hidden=NO;
                 self.phoneNoLbl.text=[self.groupDict valueForKey:@"creator_phno"];
            }else{
                self.phoneNoImageView.hidden=YES;
                self.phoneNoLbl.text=@"No Phone # available, please update player information. in Team Admin";
            }

           
            self.nameLabel.text=[NSString stringWithFormat:@"%@ (Coach)",[self.groupDict valueForKey:@"creator_name"]];
            NSString *imgUrl= [NSString stringWithFormat:@"%@%@",IMAGELINK,[self.groupDict valueForKey:@"Coach_ProfileImage"]];
            [self.calProfileImage setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:self.noImage];


            
        }else{
            
            self.nameLabel.text=[NSString stringWithFormat:@"%@",[[[self.groupDict valueForKey:@"player_details"] objectAtIndex:selectedIndexPath.row - 1] valueForKey:@"player_name"]];
            
             if (![[[[self.groupDict valueForKey:@"player_details"] objectAtIndex:selectedIndexPath.row - 1]  valueForKey:@"ph_no"] isEqualToString:@""] && ![[[[self.groupDict valueForKey:@"player_details"] objectAtIndex:selectedIndexPath.row - 1]  valueForKey:@"ph_no"] isEqualToString:@"0"]) {
                 
                 self.phoneNoImageView.hidden=NO;
                  self.phoneNoLbl.text=[[[self.groupDict valueForKey:@"player_details"] objectAtIndex:selectedIndexPath.row - 1]  valueForKey:@"ph_no"];
             }else{
                 self.phoneNoImageView.hidden=YES;
                 self.phoneNoLbl.text=@"No Phone # available, please update player information. in Team Admin";
             }
           
            NSString *imgUrl= [NSString stringWithFormat:@"%@%@",IMAGELINK,[[[self.groupDict valueForKey:@"player_details"] objectAtIndex:selectedIndexPath.row - 1] valueForKey:@"ProfileImage"]];
            [self.calProfileImage setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:self.noImage];
        }
//    }
//    else{
//        
//        self.nameLabel.text=[NSString stringWithFormat:@"%@",[[[self.groupDict valueForKey:@"player_details"] objectAtIndex:selectedIndexPath.row] valueForKey:@"player_name"]];
//        
//          if (![[[[self.groupDict valueForKey:@"player_details"] objectAtIndex:selectedIndexPath.row]  valueForKey:@"ph_no"] isEqualToString:@""] && ![[[[self.groupDict valueForKey:@"player_details"] objectAtIndex:selectedIndexPath.row]  valueForKey:@"ph_no"] isEqualToString:@"0"]) {
//              
//              self.phoneNoLbl.text=[[[self.groupDict valueForKey:@"player_details"] objectAtIndex:selectedIndexPath.row]  valueForKey:@"ph_no"];
//              self.phoneNoImageView.hidden=NO;
//
//              
//          }else{
//              
//              self.phoneNoImageView.hidden=YES;
//              self.phoneNoLbl.text=@"No Phone # available, please update player information. in Team Admin";
//          }
//        
//        NSString *imgUrl= [NSString stringWithFormat:@"%@%@",IMAGELINK,[[[self.groupDict valueForKey:@"player_details"] objectAtIndex:selectedIndexPath.row] valueForKey:@"ProfileImage"]];
//        [self.calProfileImage setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:self.noImage];
//        
//    }
    
    //self.callPopUp.frame=CGRectMake(self.callPopUp.frame.origin.x, self.callPopUp.frame.origin.y, self.callPopUp.frame.size.width, self.callPopUp.frame.size.height + 88);
    self.callPopUp.frame=self.view.bounds;
    [self.view addSubview:self.callPopUp];
    
}


- (IBAction)callToNumber:(UIButton*)sender {
    
    [self callNumber:self.phoneNoLbl.text];
    [self.callPopUp removeFromSuperview];

    
}

- (IBAction)touchDetected:(id)sender {
    
    [self.callPopUp removeFromSuperview];
    
}


#pragma mark - TableViewDelegate && DataSorce

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    // return self.allTeamList.count;
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    //if (![[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[self.groupDict valueForKey:@"coach_id"]]) {
        
        return  [[self.groupDict valueForKey:@"player_details"] count] + 1;
        
//    }else{
//        return  [[self.groupDict valueForKey:@"player_details"] count];
//        
//    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 38.0f;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *CellIdentifier = @"RightVCTableCell";
    UITableViewCell *cell = [self.playerListTable dequeueReusableCellWithIdentifier:CellIdentifier]; ;
    
    if (cell == nil)
    {
        
        cell =[RightVCTableCell cellFromNibNamed:@"RightVCTableCell"];
        cell.backgroundView.layer.cornerRadius=3.0f;
        [cell.backgroundView.layer setMasksToBounds:YES];
    
    }
    
    
    [self configureCell:cell atIndexPath:indexPath andTableView:tableView];
    
    
    return cell;
    
    
    
    
}
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath andTableView:(UITableView*)tableview{
    
    
    RightVCTableCell *cell1=(RightVCTableCell*)cell;
    
    [cell1.mailButton addTarget:self action:@selector(mailtoPlayer:) forControlEvents:UIControlEventTouchUpInside];
    [cell1.phoneButton addTarget:self action:@selector(smstoPlayer:) forControlEvents:UIControlEventTouchUpInside];
    [cell1.chatButton addTarget:self action:@selector(chattoPlayer:) forControlEvents:UIControlEventTouchUpInside];
    
    cell1.userName.textColor=[UIColor darkGrayColor];
    
    
//    if (![[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[self.groupDict valueForKey:@"coach_id"]]) {
    
        if (indexPath.row==0) {
            
            cell1.userName.font=[UIFont fontWithName:@"Helvetica" size:14.0];
            
            if ([[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[self.groupDict valueForKey:@"coach_id"]]) {
                
                cell1.userName.text=[NSString stringWithFormat:@"%@ (Coach)",[self.groupDict valueForKey:@"creator_name"]];
                
                cell1.mailButton.hidden=YES ;
                cell1.phoneButton.hidden=YES;
                cell1.chatButton.hidden=YES;
                
                cell1.sportImage1.hidden=YES;
                cell1.sportImage2.hidden=YES;
                cell1.chatImage.hidden=YES;
                
            }else{
                
                cell1.userName.text=[NSString stringWithFormat:@"%@ (Coach)",[self.groupDict valueForKey:@"creator_name"]];
                
                cell1.mailButton.hidden=NO ;
                cell1.phoneButton.hidden=NO;
                cell1.chatButton.hidden=NO;
                
                cell1.sportImage1.hidden=NO;
                cell1.sportImage2.hidden=NO;
                cell1.chatImage.hidden=NO;
                
                
            }
            NSString *imgUrl= [NSString stringWithFormat:@"%@%@",IMAGELINK,[self.groupDict valueForKey:@"Coach_ProfileImage"]];
            
            [cell1.userima setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:self.noImage];
            
            
            //cell1.userima.image=self.noImage;
            
            
        }else{
            
            if ([[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[[[self.groupDict valueForKey:@"player_details"] objectAtIndex:indexPath.row -1] valueForKey:@"UserID"]]){
                
                cell1.userName.font=[UIFont fontWithName:@"Helvetica" size:14.0];
                
                cell1.mailButton.hidden=YES ;
                cell1.phoneButton.hidden=YES;
                cell1.chatButton.hidden=YES;
                
                cell1.sportImage1.hidden=YES;
                cell1.sportImage2.hidden=YES;
                cell1.chatImage.hidden=YES;
                
                
                cell1.userName.text=[NSString stringWithFormat:@"%@",[[[self.groupDict valueForKey:@"player_details"] objectAtIndex:indexPath.row -1] valueForKey:@"player_name"]];
                
                
            }else{
                
                cell1.userName.font=[UIFont fontWithName:@"Helvetica" size:14.0];
                
                cell1.mailButton.hidden=NO ;
                cell1.phoneButton.hidden=NO;
                cell1.chatButton.hidden=NO;
                
                cell1.sportImage1.hidden=NO;
                cell1.sportImage2.hidden=NO;
                cell1.chatImage.hidden=NO;
                
                cell1.userName.text=[[[self.groupDict valueForKey:@"player_details"] objectAtIndex:indexPath.row -1] valueForKey:@"player_name"];
                
                
            }
            
            
            NSString *imgUrl= [NSString stringWithFormat:@"%@%@",IMAGELINK,[[[self.groupDict valueForKey:@"player_details"] objectAtIndex:indexPath.row - 1] valueForKey:@"ProfileImage"]];
            
            [cell1.userima setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:self.noImage];
        }
        
//    }else{
//        
//        if ([[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[[[self.groupDict valueForKey:@"player_details"] objectAtIndex:indexPath.row] valueForKey:@"player_id"]]){
//            
//            cell1.userName.font=[UIFont fontWithName:@"Helvetica" size:14.0];
//            
//            cell1.mailButton.hidden=YES ;
//            cell1.phoneButton.hidden=YES;
//            cell1.chatButton.hidden=YES;
//            
//            cell1.sportImage1.hidden=YES;
//            cell1.sportImage2.hidden=YES;
//            cell1.chatImage.hidden=YES;
//            
//            
//            cell1.userName.text=[NSString stringWithFormat:@"%@",[[[self.groupDict valueForKey:@"player_details"] objectAtIndex:indexPath.row] valueForKey:@"player_name"]];
//            
//            
//        }else{
//            
//            cell1.userName.font=[UIFont fontWithName:@"Helvetica" size:14.0];
//            cell1.mailButton.hidden=NO ;
//            cell1.phoneButton.hidden=NO;
//            cell1.chatButton.hidden=NO;
//            cell1.sportImage1.hidden=NO;
//            cell1.sportImage2.hidden=NO;
//            cell1.chatImage.hidden=NO;
//            cell1.userName.text=[[[self.groupDict valueForKey:@"player_details"] objectAtIndex:indexPath.row] valueForKey:@"player_name"];
//            
//            
//        }
//        
//        
//        NSString *imgUrl= [NSString stringWithFormat:@"%@%@",IMAGELINK,[[[self.groupDict valueForKey:@"player_details"] objectAtIndex:indexPath.row] valueForKey:@"ProfileImage"]];
//        
//        [cell1.userima setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:self.noImage];
//    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    if (![[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[self.groupDict valueForKey:@"coach_id"]]) {
    
        if (indexPath.row==0) {
            
            PlayerDetails *details=[[PlayerDetails alloc] initWithNibName:@"PlayerDetails" bundle:nil];
            
            NSMutableDictionary * coachDict=[[[NSMutableDictionary alloc] init] autorelease];
            
            
            [coachDict setObject:[self.groupDict valueForKey:@"creator_name"] forKey:@"creator_name"];
            
            [coachDict setObject:[self.groupDict valueForKey:@"creator_phno"] forKey:@"creator_phno"];
            
            [coachDict setObject:[self.groupDict valueForKey:@"creator_phno2"] forKey:@"creator_phno2"];
            
            [coachDict setObject:[self.groupDict valueForKey:@"creator_email"] forKey:@"creator_email"];
            
            [coachDict setObject:[self.groupDict valueForKey:@"creator_email2"] forKey:@"creator_email2"];
            
            
            NSArray *arr=[[NSArray alloc] initWithObjects:coachDict,nil];
            details.dataArray=arr;
            details.selectedPlayer=indexPath.row - 1 ;
            [self.navigationController pushViewController:details animated:YES];
            
        }else{
            
            if ([[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[self.groupDict valueForKey:@"coach_id"]]) {
                
                PlayerDetails *details=[[PlayerDetails alloc] initWithNibName:@"PlayerDetails" bundle:nil];
                
                details.dataArray=[self.groupDict valueForKey:@"player_details"];
                details.selectedPlayer=indexPath.row - 1;
                [self.navigationController pushViewController:details animated:YES];
                
                [details release];
                
            }else{
                
                PlayerDetails *details=[[PlayerDetails alloc] initWithNibName:@"PlayerDetails" bundle:nil];
                details.dataArray=[self.groupDict valueForKey:@"player_details"];
                details.selectedPlayer=indexPath.row - 1;
                [self.navigationController pushViewController:details animated:YES];
                
                
            }
            
            
        }
//    }else{
//        
//        if ([[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:[self.groupDict valueForKey:@"coach_id"]]) {
//            
//            PlayerDetails *details=[[PlayerDetails alloc] initWithNibName:@"PlayerDetails" bundle:nil];
//            
//            details.dataArray=[self.groupDict valueForKey:@"player_details"];
//            details.selectedPlayer=indexPath.row ;
//            [self.navigationController pushViewController:details animated:YES];
//            
//            [details release];
//            
//        }else{
//            
//            PlayerDetails *details=[[PlayerDetails alloc] initWithNibName:@"PlayerDetails" bundle:nil];
//            details.dataArray=[self.groupDict valueForKey:@"player_details"];
//            details.selectedPlayer=indexPath.row ;
//            [self.navigationController pushViewController:details animated:YES];
//            
//            
//        }
//        
//        
//    }
    
    
}

@end
