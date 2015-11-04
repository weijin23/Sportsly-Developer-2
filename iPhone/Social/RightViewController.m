 //
//  RightViewController.m
//  Social
//
//  Created by Mindpace on 12/08/13.
//
//
#import "ToDoByEventsVC.h"
#import "EventCalendarViewController.h"
#import "CenterViewController.h"
#import "RightViewController.h"
#import "RightViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "ChatViewController.h"
#import "MessageVC.h"
#import "HomeVC.h"
@interface RightViewController ()

@end

@implementation RightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=self.darkGrayColor;
    self.msLbl.hidden=YES;
    self.timeFont=[UIFont fontWithName:@"Helvetica" size:10.0];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getAllUserDetailsFoRUser];

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

- (void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self name:HANDLERECEIVEDMEMORYWARNING object:nil];
    [_contactTable release];
    [_fotterView release];
    [super dealloc];
}
- (void)viewDidUnload
{
    [self setMsLbl:nil];
    [super viewDidUnload];
}


- (IBAction)settingsbTapped:(id)sender
{
    
    [self.appDelegate.centerViewController showNavController:appDelegate.navigationControllerSettings];
}

//- (IBAction)messageToPlayer:(id)sender {
//    
//    if (appDelegate.centerVC.dataArrayUpButtonsIds.count>0) {
//        
//        if (self.appDelegate.myFriendList.count>0) {
//            
//            [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerMessageType];
//            [(MessageVC*) [self.appDelegate.navigationControllerMessageType.viewControllers objectAtIndex:0] setIntialized];
//            
//        }else{
//            
//        }
//        
//    }else{
//        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Sidelineheros" message:@"You need to be part of a team to send message" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
//        [alert show];
//        [alert release];
//    }
//   
//}

- (IBAction)showMoreContact:(id)sender {
    
    
    
}

#pragma mark - UserDetails

-(void)getAllUserDetailsFoRUser{
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    
    [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
//    [command setObject:@"0" forKey:@"start"];
//     [command setObject:@"20" forKey:@"limit"];
//    [command setObject:@"" forKey:@"search"];

    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    //[self showHudView:@"Connecting..."];
    [self showNativeHudView];
    
    NSURL* url = [NSURL URLWithString:USERLISTLINK];
    
    ASIFormDataRequest *aRequest=  [[ASIFormDataRequest alloc] initWithURL:url] ;
    self.myFormRequest1=aRequest;
    [self.storeCreatedRequests addObject:self.myFormRequest1];
    
    
    [aRequest setShouldContinueWhenAppEntersBackground:YES];
    
    [aRequest setDelegate:self];
    
    [aRequest setValidatesSecureCertificate:NO];
    [ASIFormDataRequest setShouldThrottleBandwidthForWWAN:YES];
    [aRequest addPostValue:jsonCommand forKey:@"requestParam"];
    
    [aRequest setDidFinishSelector:@selector(requestFinished:)];
    [aRequest setDidFailSelector:@selector(requestFailed:)];
    
    [aRequest startAsynchronous];
    
    
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
	NSLog(@"Data Received in Connection Manager.... %@ ",[request responseString]);
    // [self hideActiveIndicatorOwnPost];
    [self hideNativeHudView];
    [self hideHudView];
    
    NSString *str=[request responseString];
    NSLog(@"Data=%@",str);
    
    
    if (str)
    {
        SBJsonParser *parser=[[SBJsonParser alloc] init];
        
        id res = [parser objectWithString:str];
        if ([res isKindOfClass:[NSDictionary class]])
        {
            NSDictionary* aDict = (NSDictionary*) res;
            self.allUserList=[[aDict objectForKey:@"response"] objectForKey:@"user_details"] ;
            self.appDelegate.messageUserList=self.allUserList;
            if (self.allUserList.count>0) {
                self.msLbl.hidden=YES;
                  self.contactTable.frame=CGRectMake( self.contactTable.frame.origin.x, 64,  self.contactTable.frame.size.width,  self.contactTable.frame.size.height);
                
            }else{
                self.contactTable.frame=CGRectMake( self.contactTable.frame.origin.x, 85,  self.contactTable.frame.size.width,  self.contactTable.frame.size.height);
                self.msLbl.hidden=NO;

            }
            NSLog(@"all Team List %@",self.allUserList);
            [self.contactTable reloadData];
        }
    }
    
    
	
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    
    [self hideNativeHudView];
    [self hideHudView];
	//[self showAlertMessage:CONNFAILMSG];ChAfter
	
}



#pragma mark - UITableViewDatasourace

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.allUserList.count;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 52;
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0;
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    
// return self.fotterView;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    
//    return 30;
//    
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *CellIdentifier = @"RightViewCell";
    RightViewCell *cell = [self.contactTable dequeueReusableCellWithIdentifier:CellIdentifier]; ;
    
    if (cell == nil)
    {
        
        cell =[RightViewCell rightCell];
        //cell.selectionStyle=UITableViewCellSelectionStyleGray;
        //tableView.separatorColor=[UIColor lightGrayColor];
    }
    
    
    cell.nameLbl.text=[[self.allUserList objectAtIndex:indexPath.row] valueForKey:@"Name"];
    NSString *imgUrl= [NSString stringWithFormat:@"%@%@",IMAGELINK,[[self.allUserList objectAtIndex: indexPath.row]  valueForKey:@"ProfileImage"]];
    [cell.profileImageView setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:self.noImage];
    cell.msgLbl.text=[[self.allUserList objectAtIndex:indexPath.row] valueForKey:@"last_message"];
    
    if ([[[self.allUserList objectAtIndex:indexPath.row] valueForKey:@"login"] isEqualToString:@"yes"]) {
        cell.statusImageView.hidden=NO;
    }else{
        cell.statusImageView.hidden=YES;

    }
    
    int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
    
    NSDate *datetime=   [[self.appDelegate.dateFormatFullOriginalComment dateFromString:[[self.allUserList objectAtIndex:indexPath.row] valueForKey:@"adddate"]] dateByAddingTimeInterval:difftime] ;
    
    if ([[[self.allUserList objectAtIndex:indexPath.row] valueForKey:@"adddate"] isEqualToString:@""]) {
        cell.dateLbl.text=@"";
    }else{
    cell.dateLbl.text=[self getDateTimeForHistory:datetime ];
    }
    cell.dateLbl.font=self.timeFont;

    return cell;
  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    ChatViewController *fVC=(ChatViewController*)[appDelegate.navigationControllerChat.viewControllers objectAtIndex:0];
//    //fVC.reciverUserId=[self.groupDict valueForKey:@"coach_id"];
//    [fVC disableRedTopBar];
//    fVC.isList=1;
//    
//    fVC.reciverUserId=[[self.allUserList objectAtIndex:indexPath.row] valueForKey:@"UserID"];
//    fVC.reciverName=[[self.allUserList objectAtIndex:indexPath.row] valueForKey:@"Name"];
//    fVC.reciverProfileImage=[NSString stringWithFormat:@"%@%@",IMAGELINK,[[self.allUserList objectAtIndex: indexPath.row]  valueForKey:@"ProfileImage"]];
//    [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerChat];
//    
//    if ([[self.allUserList objectAtIndex:indexPath.row] valueForKey:@"UserID"]) {
//        [(ChatViewController*)[self.appDelegate.navigationControllerChat.viewControllers objectAtIndex:0]getMessageListforSender:[self.appDelegate.aDef valueForKey:LoggedUserID] andReciver:[[self.allUserList objectAtIndex:indexPath.row] valueForKey:@"UserID"]];
//        // [[(ChatViewController*)self.appDelegate.navigationControllerChat.viewControllers object] getMessageListforSender:[self.appDelegate.aDef valueForKey:LoggedUserID] andReciver:reciverId];
//        
//    }

}


@end
