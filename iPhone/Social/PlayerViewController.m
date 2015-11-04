//
//  PlayerViewController.m
//  Wall
//
//  Created by Sukhamoy on 20/11/13.
//
//
#import <QuartzCore/QuartzCore.h>
#import "PlayerViewController.h"
#import <AddressBookUI/AddressBookUI.h>
#import "ModalDropDownViewController.h"
#import "PlayerListCell.h"
#import "TeamMaintenanceVC.h"
#import "InviteViewController.h"
#import "CenterViewController.h"
@interface PlayerViewController ()<ABPeoplePickerNavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    NSString *strName;
    //int last_row;
}

@end

@implementation PlayerViewController
@synthesize CountPlayer,emailIdValue,emailIdValue1,last_emailId,selectedTeamIndex,playerMode,command,selectedPlayerIndex;
@synthesize currrentTextFiled,isTapBack,isValidEmailCheck;
@synthesize selectedTextIndex,isGetName;
@synthesize dictMemberPlayer;

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
    self.isTapBack=0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fullNameLoaded:) name:GETFULLNAME object:nil];
    strName=@"";
   // self.view.backgroundColor=appDelegate.backgroundPinkColor;
    //self.topview.backgroundColor=appDelegate.barGrayColor;
    
    [self.playerDetailView.layer setCornerRadius:3.0f];
    [self.playerDetailView.layer setMasksToBounds:YES];
    
       
    self.isPlayer=NO;
    self.isPrimary1=NO;
    self.isPrimary2=NO;
    
    self.isPlayerEmailIDRegster=YES;
    self.isPrimary1EmailIDRegster=NO;
    self.isPrimary2EmailIDRegster=NO;

  
    af=[[UIScreen mainScreen] applicationFrame];
    
    self.playerName=[[[NSMutableArray alloc] init] autorelease];
    self.lastName=[[[NSMutableArray alloc] init] autorelease];
    self.emailIdValue=[[[NSMutableArray alloc] init] autorelease];
    self.phoneNoValue=[[[NSMutableArray alloc] init] autorelease];
    self.emailIdValue1=[[[NSMutableArray alloc] init] autorelease];
//    if (self.isiPad) {
//        self.playerScrollView.frame=CGRectMake(0,self.playerScrollView.frame.origin.y,self.playerScrollView.frame.size.width ,599);
//    }
//    else{
        self.playerScrollView.frame=CGRectMake(0,self.playerScrollView.frame.origin.y,self.playerScrollView.frame.size.width ,self.playerScrollView.frame.size.height);
//    }
    
    if (playerMode==0) {
        
        self.isPlayerEmailIDRegster=NO;
        self.CountPlayer=1;
        [self.addBtn setTitle:@"Add Player" forState:UIControlStateNormal];
        
        if (self.dictMemberPlayer) {
            [self.playerName addObject:[self.dictMemberPlayer valueForKey:@"FirstName"]];
            [self.lastName addObject:[self.dictMemberPlayer valueForKey:@"LastName"]];
            [self.emailIdValue addObject:[self.dictMemberPlayer valueForKey:@"Email"]];
            [self.phoneNoValue addObject:[self.dictMemberPlayer valueForKey:@"ContactNo"]];
        }
        else{
            [self.playerName addObject:@""];
            [self.lastName addObject:@""];
            [self.emailIdValue addObject:@""];
            [self.phoneNoValue addObject:@""];
        }
        
        
        if (self.isiPad) {
            self.playerScrollView.contentSize=CGSizeMake(self.playerScrollView.contentSize.width, self.playerScrollView.contentSize.height + 562);
            self.playerTable.frame=CGRectMake(self.playerTable.frame.origin.x, self.playerTable.frame.origin.y, self.playerTable.frame.size.width, self.playerTable.frame.size.height + 512);
            self.playerDetailView.frame=CGRectMake(self.playerDetailView.frame.origin.x, self.playerDetailView.frame.origin.y, self.playerDetailView.frame.size.width, self.playerDetailView.frame.size.height + 512);
        }
        else{
            self.playerScrollView.contentSize=CGSizeMake(320, self.playerScrollView.contentSize.height + 320);
            self.playerTable.frame=CGRectMake(self.playerTable.frame.origin.x, self.playerTable.frame.origin.y, self.playerTable.frame.size.width, self.playerTable.frame.size.height + 292);
            self.playerDetailView.frame=CGRectMake(self.playerDetailView.frame.origin.x, self.playerDetailView.frame.origin.y, self.playerDetailView.frame.size.width, self.playerDetailView.frame.size.height + 292);
        }
        [self.playerTable reloadData];
        
    }else
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getRegisteNameLoaded:) name:GETREGISTERNAME object:nil]; /// 10/9/14
        
        [self checkEmailRegister:@""];
        
        [self.addBtn setTitle:@"Update Player" forState:UIControlStateNormal];
        self.CountPlayer=0;
       
        
        if (![[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"Email1"] isEqualToString:@""]) {
            
            
//            [self checkEmailRegister:[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"Email1"]];  /// 10/9/14
            if (self.isiPad) {
                self.playerScrollView.contentSize=CGSizeMake(self.playerScrollView.contentSize.width, self.playerScrollView.contentSize.height + 562);
                self.playerTable.frame=CGRectMake(self.playerTable.frame.origin.x, self.playerTable.frame.origin.y, self.playerTable.frame.size.width, self.playerTable.frame.size.height + 512);
                self.playerDetailView.frame=CGRectMake(self.playerDetailView.frame.origin.x, self.playerDetailView.frame.origin.y, self.playerDetailView.frame.size.width, self.playerDetailView.frame.size.height + 512);
            }
            else{
                
                self.playerScrollView.contentSize=CGSizeMake(320, self.playerScrollView.contentSize.height + 320);
                self.playerTable.frame=CGRectMake(self.playerTable.frame.origin.x, self.playerTable.frame.origin.y, self.playerTable.frame.size.width, self.playerTable.frame.size.height + 292);
                self.playerDetailView.frame=CGRectMake(self.playerDetailView.frame.origin.x, self.playerDetailView.frame.origin.y, self.playerDetailView.frame.size.width, self.playerDetailView.frame.size.height + 292);
            }
            
        [self.emailIdValue addObject:[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"Email1"]];
        //[self.playerName addObject:[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"player_name"]];
            
        [self.playerName addObject:[[[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"player_name"] componentsSeparatedByString:@" "] objectAtIndex:0]];

            if ([[[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"player_name"] componentsSeparatedByString:@" "] count]>1) {
                
                if ([[[[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"player_name"] componentsSeparatedByString:@" "] objectAtIndex:1] length]>0) {
                    
                    [self.lastName addObject:[[[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"player_name"] componentsSeparatedByString:@" "] objectAtIndex:1]];
                }else{
                    
                    [self.lastName addObject:@""];
                    
                }

            }else{
                
                 [self.lastName addObject:@""];
            }
            
    

        self.CountPlayer++;
        }
        
        if (![[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"Email2"] isEqualToString:@""]) {
            
           // [self checkEmailRegister:[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"Email1"]];  /// 10/9/14
            if (self.isiPad) {
                self.playerScrollView.contentSize=CGSizeMake(self.playerScrollView.contentSize.width, self.playerScrollView.contentSize.height + 562);
                self.playerTable.frame=CGRectMake(self.playerTable.frame.origin.x, self.playerTable.frame.origin.y, self.playerTable.frame.size.width, self.playerTable.frame.size.height + 512);
                self.playerDetailView.frame=CGRectMake(self.playerDetailView.frame.origin.x, self.playerDetailView.frame.origin.y, self.playerDetailView.frame.size.width, self.playerDetailView.frame.size.height + 512);
            }
            else{
                self.playerScrollView.contentSize=CGSizeMake(320, self.playerScrollView.contentSize.height + 320);
                self.playerTable.frame=CGRectMake(self.playerTable.frame.origin.x, self.playerTable.frame.origin.y, self.playerTable.frame.size.width, self.playerTable.frame.size.height + 292);
                self.playerDetailView.frame=CGRectMake(self.playerDetailView.frame.origin.x, self.playerDetailView.frame.origin.y, self.playerDetailView.frame.size.width, self.playerDetailView.frame.size.height + 292);
            }
            
            [self.emailIdValue addObject:[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"Email2"]];
            
            
            [self.playerName addObject:[[[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"Email_Rel2"] componentsSeparatedByString:@" "] objectAtIndex:0]];
            
             if ([[[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"Email_Rel2"] componentsSeparatedByString:@" "] count]>1) {
            
                if ([[[[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"Email_Rel2"] componentsSeparatedByString:@" "] objectAtIndex:1] length]>0) {
                    
                    [self.lastName addObject:[[[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"Email_Rel2"] componentsSeparatedByString:@" "] objectAtIndex:1]];
                }else{
                    
                    [self.lastName addObject:@""];
                    
                    
                }
             }else{
                 [self.lastName addObject:@""];  
             }

            
            //[self.lastName addObject:[[[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"Email_Rel2"] componentsSeparatedByString:@" "] objectAtIndex:1]];
            
            self.CountPlayer++;
        }
        
        if (![[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"Email3"] isEqualToString:@""]) {
            
            //[self checkEmailRegister:[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"Email1"]];  /// 10/9/14
            
            if (self.isiPad) {
                self.playerScrollView.contentSize=CGSizeMake(self.playerScrollView.contentSize.width, self.playerScrollView.contentSize.height + 512);
                self.playerTable.frame=CGRectMake(self.playerTable.frame.origin.x, self.playerTable.frame.origin.y, self.playerTable.frame.size.width, self.playerTable.frame.size.height + 462);
                self.playerDetailView.frame=CGRectMake(self.playerDetailView.frame.origin.x, self.playerDetailView.frame.origin.y, self.playerDetailView.frame.size.width, self.playerDetailView.frame.size.height + 462);
            }
            else{
                self.playerScrollView.contentSize=CGSizeMake(320, self.playerScrollView.contentSize.height + 275);
                self.playerTable.frame=CGRectMake(self.playerTable.frame.origin.x, self.playerTable.frame.origin.y, self.playerTable.frame.size.width, self.playerTable.frame.size.height + 252);
                self.playerDetailView.frame=CGRectMake(self.playerDetailView.frame.origin.x, self.playerDetailView.frame.origin.y, self.playerDetailView.frame.size.width, self.playerDetailView.frame.size.height + 252);
            }
            
            [self.emailIdValue addObject:[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"Email3"]];
            [self.playerName addObject:[[[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"Email_Rel3"] componentsSeparatedByString:@" "] objectAtIndex:0]];
            
              if ([[[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"Email_Rel3"] componentsSeparatedByString:@" "] count]>1) {
            
                if ([[[[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"Email_Rel3"] componentsSeparatedByString:@" "] objectAtIndex:1] length]>0) {
                    [self.lastName addObject:[[[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"Email_Rel3"] componentsSeparatedByString:@" "] objectAtIndex:1]];
                }else{
                    
                    [self.lastName addObject:@""];
                    
                }
              }else{
                   [self.lastName addObject:@""];
              }
            //[self.lastName addObject:[[[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"Email_Rel2"] componentsSeparatedByString:@" "] objectAtIndex:1]];
          
            self.CountPlayer++;

        }
        
        
        if (![[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"ph_no"] isEqualToString:@""] && ![[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"ph_no"] isEqualToString:@"0"]) {
            
            
            [self.phoneNoValue addObject:[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"ph_no"]];
        }else{
            
            [self.phoneNoValue addObject:@""];
        }
        
        
        
        if (![[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"ph_no2"] isEqualToString:@""] && ![[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"ph_no2"] isEqualToString:@"0"]) {
            
            [self.phoneNoValue addObject:[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"ph_no2"]];
           
        }else{
            [self.phoneNoValue addObject:@""];

        }
        
        
        if (![[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"ph_no3"] isEqualToString:@""] && ![[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"ph_no3"] isEqualToString:@"0"]) {
            
                     
            [self.phoneNoValue addObject:[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"ph_no3"]];
         
        }else{
            
            [self.phoneNoValue addObject:@""];

        }
        
      
        
    }
    
    svos= self.playerScrollView.contentSize;

    
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setStatusBarStyleOwnApp:0];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:GETREGISTERNAME object:nil];
    [self setStatusBarStyleOwnApp:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HANDLERECEIVEDMEMORYWARNING object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:GETFULLNAME object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:GETREGISTERNAME object:nil];
    
    
    [_playerTable release];
    //[_playerDetailView release];
    [super dealloc];
    
}


- (void)viewDidUnload {
    [self setPlayerHeaderView:nil];
    [self setAddPlayerViewlbl:nil];
    [self setPlayerScrollView:nil];
    
    [super viewDidUnload];
}
#pragma mark - GETUSERFROM MAIL

-(void)getFullName:(NSString*)email
{
//    self.addMinNameText.placeholder=@"Getting First Name";
//    self.lastName.text=@"Getting Last Name";
    //[self.currrentTextFiled resignFirstResponder];
    self.isGetName=YES;
    //self.last_emailId=email;
    int selectedIndex= [self.emailIdValue indexOfObject:email];
   // last_row=selectedIndex;
    [self.playerName replaceObjectAtIndex:selectedIndex withObject:@"Checking if the user already exists"];
    [self.lastName replaceObjectAtIndex:selectedIndex withObject:@"Checking if the user already exists"];
    [self.playerTable reloadData];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    NSMutableDictionary *command1=[[NSMutableDictionary alloc] init];
    [command1 setObject:email forKey:@"Email"];
    NSString *jsonCommand = [writer stringWithObject:command1];

    
    SingleRequest *sinReq=[[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:GETFULLNAMELINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
    self.sinReq4=sinReq;
    
   
    sinReq.notificationName=GETFULLNAME;
    
    [sinReq startRequest];
}


-(void)fullNameLoaded:(id)sender
{
    SingleRequest *sReq=(SingleRequest*)[sender object];
    
      NSLog(@"%@",sReq.responseString);
    //self.emailIdValue=self.emailIdValue1;
    if([sReq.notificationName isEqualToString:GETFULLNAME])
    {
        if(sReq.responseData)
        {
            
            if (sReq.responseString)
            {
                SBJsonParser *parser=[[SBJsonParser alloc] init];
                
                id res = [parser objectWithString:sReq.responseString];
                if ([res isKindOfClass:[NSDictionary class]])
                {
                    NSDictionary* aDict = (NSDictionary*) res;
                    
                    
                    if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
                    {
                        
                        //// Arpita 26th March
                        
                        //int selectedIndex= [self.emailIdValue indexOfObject:[aDict valueForKey:@"Email"]];
                        
                        int selectedIndex;
                        for (int i=0; i<self.emailIdValue.count; i++) {
                            if ([[self.emailIdValue objectAtIndex:i] caseInsensitiveCompare:[aDict valueForKey:@"Email"]]==NSOrderedSame) {
                                selectedIndex=i;
                                [self.playerName replaceObjectAtIndex:selectedIndex withObject:[aDict valueForKey:@"FirstName"]];
                                [self.lastName replaceObjectAtIndex:selectedIndex withObject:[aDict valueForKey:@"LastName"]];
                                
                               /* UIAlertView *at=[[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"First name & last name of player has been populated from user info. You can update the phone no."] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                                [at show];*/
                            }
                        }
                        
                        
                        //[self.playerName replaceObjectAtIndex:selectedIndex withObject:[aDict valueForKey:@"FirstName"]];
                        //[self.lastName replaceObjectAtIndex:selectedIndex withObject:[aDict valueForKey:@"LastName"]];
                        if (selectedIndex==0)
                        {
                            self.isPlayerEmailIDRegster=YES;
                        }
                        else if (selectedIndex==1)
                        {
                            self.isPrimary1EmailIDRegster=YES;
                        }else
                        {
                             self.isPrimary2EmailIDRegster=YES;
                        }
                        //[self.currrentTextFiled resignFirstResponder];
                        
                        //Subhasish..26th March
                        //same should apply for Admin also...(if needed in future)
                       /* UIAlertView *at=[[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"First name & last name of player has been populated from user info. You can update the phone no."] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                        [at show];*/

                        [self.playerTable reloadData];
                        [self pickCellText];
                        //[self.currrentTextFiled becomeFirstResponder];
                        
                    }else
                    {
                        //// Arpita 26th March
                        
                        //int selectedIndex= [self.emailIdValue indexOfObject:[aDict valueForKey:@"Email"]];
                        
                        int selectedIndex;
                        for (int i=0; i<self.emailIdValue.count; i++) {
                            if ([[self.emailIdValue objectAtIndex:i] isEqualToString:[aDict valueForKey:@"Email"]]) {
                                selectedIndex=i;
                                [self.playerName replaceObjectAtIndex:selectedIndex withObject:@""];
                                [self.lastName replaceObjectAtIndex:selectedIndex withObject:@""];
                            }
                        }
                        
                        
                        //[self.playerName replaceObjectAtIndex:selectedIndex withObject:[aDict valueForKey:@"FirstName"]];
                        //[self.lastName replaceObjectAtIndex:selectedIndex withObject:[aDict valueForKey:@"LastName"]];
                        if (selectedIndex==0)
                        {
                            self.isPlayerEmailIDRegster=NO;
                        }
                        else if (selectedIndex==1)
                        {
                            self.isPrimary1EmailIDRegster=NO;
                        }else if (selectedIndex==2)
                        {
                            self.isPrimary2EmailIDRegster=NO;
                        }
//                        [self.playerName replaceObjectAtIndex:selectedIndex withObject:@""];
//                        [self.lastName replaceObjectAtIndex:selectedIndex withObject:@""];
                        //[self.currrentTextFiled resignFirstResponder];
                        [self.playerTable reloadData];
                        [self pickCellText];
                        //[self.currrentTextFiled becomeFirstResponder];
                    }
                    
                    
                    if (self.isPlayerEmailIDRegster || self.isPrimary1EmailIDRegster || self.isPrimary2EmailIDRegster) {
                        [self.gupiTextField becomeFirstResponder];
                    }
                    
                    
                }
            }
        }
    }
    
}

-(void)pickCellText{
    
    PlayerListCell *cell =(PlayerListCell *)[self.playerTable cellForRowAtIndexPath:self.selectedTextIndex];
    [cell.addMinNameText becomeFirstResponder];
    
}

#pragma mark - InvitePlayer

-(void)playerInvite:(id)sender{
    /*
    InviteViewController *invite=[[InviteViewController alloc] initWithNibName:@"InviteViewController" bundle:nil];
    invite.selectEdTeamIndex=self.selectedTeamIndex;
    [self.appDelegate.centerViewController presentViewControllerForModal:invite];
    [invite release];*/
    
    
    //[self showAlertMessage:errorstr title:@""];   /// 20/02/2015
    
    
}

#pragma mark - AddPlayer
- (IBAction)addPlayer:(id)sender {
    
    [self.playerName addObject:@""];
    [self.lastName addObject:@""];
    [self.emailIdValue addObject:@""];
    [self.phoneNoValue addObject:@""];
    
    if (self.CountPlayer!=2) {
        if (self.isiPad) {
            self.playerScrollView.contentSize=CGSizeMake(self.playerScrollView.contentSize.width, self.playerScrollView.contentSize.height + 562);
            self.playerTable.frame=CGRectMake(self.playerTable.frame.origin.x, self.playerTable.frame.origin.y, self.playerTable.frame.size.width, self.playerTable.frame.size.height + 562);
            self.playerDetailView.frame=CGRectMake(self.playerDetailView.frame.origin.x, self.playerDetailView.frame.origin.y, self.playerDetailView.frame.size.width, self.playerDetailView.frame.size.height + 562);
        }
        else{
            self.playerScrollView.contentSize=CGSizeMake(320, self.playerScrollView.contentSize.height + 320);
            self.playerTable.frame=CGRectMake(self.playerTable.frame.origin.x, self.playerTable.frame.origin.y, self.playerTable.frame.size.width, self.playerTable.frame.size.height + 292);
            self.playerDetailView.frame=CGRectMake(self.playerDetailView.frame.origin.x, self.playerDetailView.frame.origin.y, self.playerDetailView.frame.size.width, self.playerDetailView.frame.size.height + 292);
        }
        
    }else{
        if (self.isiPad) {
            self.playerScrollView.contentSize=CGSizeMake(self.playerScrollView.contentSize.width, self.playerScrollView.contentSize.height + 562);
            self.playerTable.frame=CGRectMake(self.playerTable.frame.origin.x, self.playerTable.frame.origin.y, self.playerTable.frame.size.width, self.playerTable.frame.size.height + 482);
            self.playerDetailView.frame=CGRectMake(self.playerDetailView.frame.origin.x, self.playerDetailView.frame.origin.y, self.playerDetailView.frame.size.width, self.playerDetailView.frame.size.height + 482);
        }
        else{
            self.playerScrollView.contentSize=CGSizeMake(320, self.playerScrollView.contentSize.height + 275);
            self.playerTable.frame=CGRectMake(self.playerTable.frame.origin.x, self.playerTable.frame.origin.y, self.playerTable.frame.size.width, self.playerTable.frame.size.height + 252);
            self.playerDetailView.frame=CGRectMake(self.playerDetailView.frame.origin.x, self.playerDetailView.frame.origin.y, self.playerDetailView.frame.size.width, self.playerDetailView.frame.size.height + 252);
        }
    }
    
    
    self.CountPlayer++;
    svos= self.playerScrollView.contentSize;

    [self.playerTable reloadData];

    
}


#pragma mark - EditCell
-(IBAction)editCustomCell:(UIButton*)sender{
    
    PlayerListCell *selectedCell=(PlayerListCell*)[[[sender superview] superview] superview];
    
   // NSIndexPath *selecedIndexPath=[self.playerTable indexPathForCell:selectedCell];
    
    if ([selectedCell.delBtn isHidden]) {
        selectedCell.delBtn.hidden=NO;
        selectedCell.addressBookBtn.hidden=YES;
        
    }else{
        
        selectedCell.delBtn.hidden=YES;
        selectedCell.addressBookBtn.hidden=NO;
        
        
    }
}

-(IBAction)deleteCustomCell:(UIButton*)sender{
    
    PlayerListCell *selectedCell=(PlayerListCell*)[[[sender superview] superview] superview];
    NSIndexPath *selectedIndexPath=[self.playerTable indexPathForCell:selectedCell];
    self.CountPlayer--;
    if (self.CountPlayer==2){
        
        if (self.isiPad) {
            self.playerScrollView.contentSize=CGSizeMake(self.playerScrollView.contentSize.width, self.playerScrollView.contentSize.height - 512);
            self.playerTable.frame=CGRectMake(self.playerTable.frame.origin.x, self.playerTable.frame.origin.y, self.playerTable.frame.size.width, self.playerTable.frame.size.height - 462);
            self.playerDetailView.frame=CGRectMake(self.playerDetailView.frame.origin.x, self.playerDetailView.frame.origin.y, self.playerDetailView.frame.size.width, self.playerDetailView.frame.size.height - 462);
        }
        else{
            self.playerScrollView.contentSize=CGSizeMake(320, self.playerScrollView.contentSize.height - 250);
            self.playerTable.frame=CGRectMake(self.playerTable.frame.origin.x, self.playerTable.frame.origin.y, self.playerTable.frame.size.width, self.playerTable.frame.size.height - 252);
            self.playerDetailView.frame=CGRectMake(self.playerDetailView.frame.origin.x, self.playerDetailView.frame.origin.y, self.playerDetailView.frame.size.width, self.playerDetailView.frame.size.height - 252);
        }
        
        if (selectedIndexPath.row==0) {
            
            [self.playerName replaceObjectAtIndex:0 withObject:[self.playerName objectAtIndex:1]];
            [self.playerName replaceObjectAtIndex:1 withObject:[self.playerName objectAtIndex:2]];
           // [self.playerName replaceObjectAtIndex:2 withObject:@""];  ///20/03
            [self.playerName removeObjectAtIndex:2];
            
            [self.lastName replaceObjectAtIndex:0 withObject:[self.lastName objectAtIndex:1]];
            [self.lastName replaceObjectAtIndex:1 withObject:[self.lastName objectAtIndex:2]];
            //[self.lastName replaceObjectAtIndex:2 withObject:@""];    ///20/03
            [self.lastName removeObjectAtIndex:2];
            
            [self.emailIdValue replaceObjectAtIndex:0 withObject:[self.emailIdValue objectAtIndex:1]];
            [self.emailIdValue replaceObjectAtIndex:1 withObject:[self.emailIdValue objectAtIndex:2]];
            //[self.emailIdValue replaceObjectAtIndex:2 withObject:@""];    ///20/03
            [self.emailIdValue removeObjectAtIndex:2];
            
            [self.phoneNoValue replaceObjectAtIndex:0 withObject:[self.phoneNoValue objectAtIndex:1]];
            [self.phoneNoValue replaceObjectAtIndex:1 withObject:[self.phoneNoValue objectAtIndex:2]];
            //[self.phoneNoValue replaceObjectAtIndex:2 withObject:@""];    ///20/03
            [self.phoneNoValue removeObjectAtIndex:2];
            
        }else if(selectedIndexPath.row==1){
            
            [self.playerName replaceObjectAtIndex:1 withObject:[self.playerName objectAtIndex:2]];
            //[self.playerName replaceObjectAtIndex:2 withObject:@""];  ///20/03
            [self.playerName removeObjectAtIndex:2];
            
            [self.lastName replaceObjectAtIndex:1 withObject:[self.lastName objectAtIndex:2]];
            //[self.lastName replaceObjectAtIndex:2 withObject:@""];    ///20/03
            [self.lastName removeObjectAtIndex:2];
            
            [self.emailIdValue replaceObjectAtIndex:1 withObject:[self.emailIdValue objectAtIndex:2]];
            //[self.emailIdValue replaceObjectAtIndex:2 withObject:@""];    ///20/03
            [self.emailIdValue removeObjectAtIndex:2];
            
            [self.phoneNoValue replaceObjectAtIndex:1 withObject:[self.phoneNoValue objectAtIndex:2]];
            //[self.phoneNoValue replaceObjectAtIndex:2 withObject:@""];    ///20/03
            [self.phoneNoValue removeObjectAtIndex:2];
            
                      
        }else{
            
//            [self.playerName replaceObjectAtIndex:2 withObject:@""];
//            [self.lastName replaceObjectAtIndex:2 withObject:@""];
//            [self.emailIdValue replaceObjectAtIndex:2 withObject:@""];
//            [self.phoneNoValue replaceObjectAtIndex:2 withObject:@""];    ///20/03
            
            [self.playerName removeObjectAtIndex:2];
            [self.lastName removeObjectAtIndex:2];
            [self.emailIdValue removeObjectAtIndex:2];
            [self.phoneNoValue removeObjectAtIndex:2];

        }
        self.isPrimary2EmailIDRegster=NO;
        
    }else if (self.CountPlayer==1){
        
        if (self.isiPad) {
            self.playerScrollView.contentSize=CGSizeMake(self.playerScrollView.contentSize.width, self.playerScrollView.contentSize.height - 512);
            self.playerTable.frame=CGRectMake(self.playerTable.frame.origin.x, self.playerTable.frame.origin.y, self.playerTable.frame.size.width, self.playerTable.frame.size.height - 462);
            self.playerDetailView.frame=CGRectMake(self.playerDetailView.frame.origin.x, self.playerDetailView.frame.origin.y, self.playerDetailView.frame.size.width, self.playerDetailView.frame.size.height - 462);
        }
        else{
            self.playerScrollView.contentSize=CGSizeMake(320, self.playerScrollView.contentSize.height - 320);
            self.playerTable.frame=CGRectMake(self.playerTable.frame.origin.x, self.playerTable.frame.origin.y, self.playerTable.frame.size.width, self.playerTable.frame.size.height - 292);
            self.playerDetailView.frame=CGRectMake(self.playerDetailView.frame.origin.x, self.playerDetailView.frame.origin.y, self.playerDetailView.frame.size.width, self.playerDetailView.frame.size.height - 292);
        }
        
        if (selectedIndexPath.row==0) {
            
            
            [self.playerName replaceObjectAtIndex:0 withObject:[self.playerName objectAtIndex:1]];
//            [self.playerName replaceObjectAtIndex:1 withObject:@""];
            [self.playerName removeObjectAtIndex:1];
            
            [self.lastName replaceObjectAtIndex:0 withObject:[self.lastName objectAtIndex:1]];
//            [self.lastName replaceObjectAtIndex:1 withObject:@""];
            [self.lastName removeObjectAtIndex:1];
            
            
            [self.emailIdValue replaceObjectAtIndex:0 withObject:[self.emailIdValue objectAtIndex:1]];
//            [self.emailIdValue replaceObjectAtIndex:1 withObject:@""];
            [self.emailIdValue removeObjectAtIndex:1];
            
            [self.phoneNoValue replaceObjectAtIndex:0 withObject:[self.phoneNoValue objectAtIndex:1]];
//            [self.phoneNoValue replaceObjectAtIndex:1 withObject:@""];
            [self.phoneNoValue removeObjectAtIndex:1];


           
        }else{
          
//            [self.playerName replaceObjectAtIndex:1 withObject:@""];
//            [self.lastName replaceObjectAtIndex:1 withObject:@""];
//            [self.emailIdValue replaceObjectAtIndex:1 withObject:@""];
//            [self.phoneNoValue replaceObjectAtIndex:1 withObject:@""];
            
            [self.playerName removeObjectAtIndex:1];
            [self.lastName removeObjectAtIndex:1];
            [self.emailIdValue removeObjectAtIndex:1];
            [self.phoneNoValue removeObjectAtIndex:1];

        }
        self.isPrimary1EmailIDRegster=NO;
        
    }
    else{
        
        if (self.isiPad) {
            self.playerScrollView.contentSize=CGSizeMake(self.playerScrollView.contentSize.width, self.playerScrollView.contentSize.height - 562);
            self.playerTable.frame=CGRectMake(self.playerTable.frame.origin.x, self.playerTable.frame.origin.y, self.playerTable.frame.size.width, self.playerTable.frame.size.height - 512);
            self.playerDetailView.frame=CGRectMake(self.playerDetailView.frame.origin.x, self.playerDetailView.frame.origin.y, self.playerDetailView.frame.size.width, self.playerDetailView.frame.size.height - 512);
        }
        else{
            self.playerScrollView.contentSize=CGSizeMake(320, self.playerScrollView.contentSize.height - 292);
            self.playerTable.frame=CGRectMake(self.playerTable.frame.origin.x, self.playerTable.frame.origin.y, self.playerTable.frame.size.width, self.playerTable.frame.size.height - 292);
            self.playerDetailView.frame=CGRectMake(self.playerDetailView.frame.origin.x, self.playerDetailView.frame.origin.y, self.playerDetailView.frame.size.width, self.playerDetailView.frame.size.height - 292);
        }
        
//        [self.playerName replaceObjectAtIndex:0 withObject:@""];
//        [self.lastName replaceObjectAtIndex:0 withObject:@""];
//        [self.emailIdValue replaceObjectAtIndex:0 withObject:@""];
//        [self.phoneNoValue replaceObjectAtIndex:0 withObject:@""];
        
        [self.playerName removeObjectAtIndex:0];
        [self.lastName removeObjectAtIndex:0];
        [self.emailIdValue removeObjectAtIndex:0];
        [self.phoneNoValue removeObjectAtIndex:0];
        
        self.isTapBack=1;
        [self.currrentTextFiled resignFirstResponder];
        [self dismissViewControllerAnimated:YES completion:nil];
        
       /* [self.emailIdValue removeAllObjects];
        [self.playerName removeAllObjects];
        [self.lastName removeAllObjects];
        [self.phoneNoValue removeAllObjects];*/
       
    }
    svos= self.playerScrollView.contentSize;
    [self.playerTable reloadData];

}

#pragma mark - ClassMethod

- (IBAction)backPlayer:(id)sender {
    self.isTapBack=1;
    [self.currrentTextFiled resignFirstResponder];
   /* [self.emailIdValue removeAllObjects];
    [self.playerName removeAllObjects];
    [self.lastName removeAllObjects];
    [self.phoneNoValue removeAllObjects];*/
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)popupAlertTapped:(id)sender {
    self.popupBackVw.hidden = YES;
    self.popupAlertVw.hidden = YES;
}

- (IBAction)done:(id)sender
{
    
    
    
    if (self.CountPlayer>0) {
        
    if (playerMode==0) {
        
    NSString* tmp=nil;
    NSString *errorstr=@"";
    
    if (self.playerName.count>0) {
            
       for (int i=0; i<self.CountPlayer; i++) {
                
            tmp=[[self.playerName objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if ([tmp  isEqualToString:@""] )
            {
                    
                if(errorstr.length==0)
                    errorstr=@"Please enter player information";
                    break;
                }
            }

            
            
        }else{
            if(errorstr.length==0)
                errorstr=@"Please enter player information";
        }
    
        
       
       
    if (self.emailIdValue.count>0) {
        
        for (int i=0; i<self.CountPlayer; i++) {
            
            if (![self validEmail:[self.emailIdValue objectAtIndex:i]]) {
                if(errorstr.length==0)
                    errorstr=@"The email id is invalid";
                break;
            }
        }
        
    }else{
        
        if(errorstr.length==0)
            errorstr=@"Please enter email id";
        
    }
        
        
        if (self.lastName.count>0) {
            
            for (int i=0; i<self.CountPlayer; i++) {
                
                tmp=[[self.lastName objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                if ([tmp  isEqualToString:@""] )
                {
                    
                    if(errorstr.length==0)
                        errorstr=@"Please enter player information";
                    break;
                }
            }
            
            
            
        }else{
            if(errorstr.length==0)
                errorstr=@"Please enter player information";
        }
        
        
    /*if (self.emailIdValue.count>0) {
            
            for (int i=0; i<count; i++) {
                
                if ([[appDelegate.aDef objectForKey:EMAIL] isEqualToString:[self.emailIdValue objectAtIndex:i]]) {
                    if(errorstr.length==0)
                        errorstr=@"As a coach you are already part of the team. Please enter one more unique email id.";
                    break;
                }
            }
            
        }*/
    
    
    if([errorstr length]>INITIALERRORSTRINGLENGTH)
    {
        
        [self showAlertMessage:errorstr title:@""];
        return;
    }
    
    
  self.command = [NSMutableDictionary dictionary];
    
    [self.command setObject:[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"team_id"] forKey:@"team_id"];
    [self.command setObject:[self.playerName objectAtIndex:0] forKey:@"player_name"];
    [self.command setObject:[self.lastName objectAtIndex:0] forKey:@"last_name"];

    
    if (self.CountPlayer==3) {
        
        [self.command setObject:[self.emailIdValue objectAtIndex:0] forKey:@"Email1"];
        [self.command setObject:[self.emailIdValue objectAtIndex:1] forKey:@"Email2"];
        [self.command setObject:[self.emailIdValue objectAtIndex:2] forKey:@"Email3"];
        
        
        [self.command setObject:[NSString stringWithFormat:@"%@ %@",[self.playerName objectAtIndex:0],[self.lastName objectAtIndex:0]] forKey:@"Email_Rel1"];
        [self.command setObject:[NSString stringWithFormat:@"%@ %@",[self.playerName objectAtIndex:1],[self.lastName objectAtIndex:1]] forKey:@"Email_Rel2"];
        [self.command setObject:[NSString stringWithFormat:@"%@ %@",[self.playerName objectAtIndex:2],[self.lastName objectAtIndex:2]] forKey:@"Email_Rel3"];
        
        [self.command setObject:[NSString stringWithFormat:@"%@ %@",[self.playerName objectAtIndex:1],[self.lastName objectAtIndex:1]] forKey:@"Name2"];
        [self.command setObject:[NSString stringWithFormat:@"%@ %@",[self.playerName objectAtIndex:2],[self.lastName objectAtIndex:2]] forKey:@"Name3"];
        
        // Phone no
        
        [self.command setObject:[self.phoneNoValue objectAtIndex:0] forKey:@"ph_no"];
        [self.command setObject:[self.phoneNoValue objectAtIndex:1] forKey:@"ph_no2"];
        [self.command setObject:[self.phoneNoValue objectAtIndex:2] forKey:@"ph_no3"];
        
        [self.command setObject:[NSString stringWithFormat:@"%@ %@",[self.playerName objectAtIndex:0],[self.lastName objectAtIndex:0]] forKey:@"Ph_Rel1"];
        [self.command setObject:[NSString stringWithFormat:@"%@ %@",[self.playerName objectAtIndex:1],[self.lastName objectAtIndex:1]] forKey:@"Ph_Rel2"];
        [self.command setObject:[NSString stringWithFormat:@"%@ %@",[self.playerName objectAtIndex:2],[self.lastName objectAtIndex:2]] forKey:@"Ph_Rel3"];
        
    }else if (self.CountPlayer==2){
        
        [self.command setObject:[self.emailIdValue objectAtIndex:0] forKey:@"Email1"];
        [self.command setObject:[self.emailIdValue objectAtIndex:1] forKey:@"Email2"];
        [command setObject:@"" forKey:@"Email3"];
        
        [self.command setObject:[NSString stringWithFormat:@"%@ %@",[self.playerName objectAtIndex:0],[self.lastName objectAtIndex:0]] forKey:@"Email_Rel1"];
        [self.command setObject:[NSString stringWithFormat:@"%@ %@",[self.playerName objectAtIndex:1],[self.lastName objectAtIndex:1]] forKey:@"Email_Rel2"];
        [self.command setObject:[NSString stringWithFormat:@"%@ %@",[self.playerName objectAtIndex:1],[self.lastName objectAtIndex:1]] forKey:@"Name2"];
        [self.command setObject:@"" forKey:@"Email_Rel3"];
        
        
        //Phone no
        [self.command setObject:[self.phoneNoValue objectAtIndex:0] forKey:@"ph_no"];
        [self.command setObject:[self.phoneNoValue objectAtIndex:1]  forKey:@"ph_no2"];
        [command setObject:@"" forKey:@"ph_no3"];
        
        [self.command setObject:[NSString stringWithFormat:@"%@ %@",[self.playerName objectAtIndex:0],[self.lastName objectAtIndex:0]] forKey:@"Ph_Rel1"];
        [self.command setObject:[NSString stringWithFormat:@"%@ %@",[self.playerName objectAtIndex:1],[self.lastName objectAtIndex:1]] forKey:@"Ph_Rel2"];
        [self.command setObject:@"" forKey:@"Ph_Rel3"];


        
    }else if(self.CountPlayer==1){
        
        [self.command setObject:[self.emailIdValue objectAtIndex:0] forKey:@"Email1"];
        [command setObject:@"" forKey:@"Email2"];
        [command setObject:@"" forKey:@"Email3"];
        
        [self.command setObject:[NSString stringWithFormat:@"%@ %@",[self.playerName objectAtIndex:0],[self.lastName objectAtIndex:0]] forKey:@"Email_Rel1"];
        [self.command setObject:@"" forKey:@"Email_Rel2"];
        [self.command setObject:@"" forKey:@"Email_Rel3"];
        
        //Phone no
        
        [self.command setObject:[self.phoneNoValue objectAtIndex:0] forKey:@"ph_no"];
        [command setObject:@"" forKey:@"ph_no2"];
        [command setObject:@"" forKey:@"ph_no3"];
        
        [self.command setObject:[NSString stringWithFormat:@"%@ %@",[self.playerName objectAtIndex:0],[self.lastName objectAtIndex:0]] forKey:@"Ph_Rel1"];
        [self.command setObject:@"" forKey:@"Ph_Rel2"];
        [self.command setObject:@"" forKey:@"Ph_Rel3"];
        


    }else{
       
        
        [self.command setObject:@"" forKey:@"ph_no"];
        [command setObject:@"" forKey:@"ph_no2"];
        [command setObject:@"" forKey:@"ph_no3"];
        
        [self.command setObject:@"" forKey:@"Ph_Rel1"];
        [self.command setObject:@"" forKey:@"Ph_Rel2"];
        [self.command setObject:@"" forKey:@"Ph_Rel3"];

    }
     
        
       
    [self.command setObject:@"" forKey:@"user_id"];
    
    if(self.selectedContact)
    {
        
        if([self.selectedContact.email isEqualToString:[self.emailIdValue objectAtIndex:0]])
        {
            [self.command setObject:self.selectedContact.userId forKey:@"user_id"];
        }
        else
        {
            Contacts *aContact=[self objectOfType:CONTACTS forName:[self.emailIdValue objectAtIndex:0] andManObjCon:self.managedObjectContext];
            
            if(aContact)
                [self.command setObject:aContact.userId forKey:@"user_id"];
        }
        
    }
    else
    {
        Contacts *aContact=[self objectOfType:CONTACTS forName:[self.emailIdValue objectAtIndex:0] andManObjCon:self.managedObjectContext];
        
        if(aContact)
            [self.command setObject:aContact.userId forKey:@"user_id"];
    }
    
    
    
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    NSString *jsonCommand = [writer stringWithObject:self.command];
        
        NSLog(@"%@",jsonCommand);
    
    [writer release];
    
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    [appDelegate sendRequestFor:ADD_PLAYER from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
    }else{
        
        
        
        NSString* tmp=nil;
        NSString *errorstr=@"";
        
        if (self.playerName.count>0) {
            
            for (int i=0; i<self.CountPlayer; i++) {
                
                tmp=[[self.playerName objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                if ([tmp  isEqualToString:@""] )
                {
                    
                    if(errorstr.length==0)
                        errorstr=@"Name missing.";
                    break;
                }
            }
            
            
            
        }else{
            if(errorstr.length==0)
                errorstr=@"Name missing.";
        }
        
        
        
        
        if (self.emailIdValue.count>0) {
            
            for (int i=0; i<self.CountPlayer; i++) {
                
                if (![self validEmail:[self.emailIdValue objectAtIndex:i]]) {
                    if(errorstr.length==0)
                        errorstr=@"The Email Id is invalid.";
                    break;
                }
            }
            
        }else{
            
            if(errorstr.length==0)
                errorstr=@"Please enter email id.";
            
        }
        
        
      /*  if (self.emailIdValue.count>0) {
            
            for (int i=0; i<count; i++) {
                
                if ([[appDelegate.aDef objectForKey:EMAIL] isEqualToString:[self.emailIdValue objectAtIndex:i]]) {
                    if(errorstr.length==0)
                        errorstr=@"As a coach you are already part of the team. Please enter one more unique email id.";
                    break;
                }
            }
            
        }*/

        
        if([errorstr length]>INITIALERRORSTRINGLENGTH)
        {
            
            [self showAlertMessage:errorstr title:@""];
            return;
        }
        
        
        self.command = [NSMutableDictionary dictionary];
        
        [self.command setObject:[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"player_id"] forKey:@"player_id"];
        [self.command setObject:[self.playerName objectAtIndex:0] forKey:@"player_name"];
        [self.command setObject:[self.lastName objectAtIndex:0] forKey:@"last_name"];

        
        if (self.CountPlayer==3) {
            
            [self.command setObject:[self.emailIdValue objectAtIndex:0] forKey:@"Email1"];
            [self.command setObject:[self.emailIdValue objectAtIndex:1] forKey:@"Email2"];
            [self.command setObject:[self.emailIdValue objectAtIndex:2] forKey:@"Email3"];
            
            [NSString stringWithFormat:@"%@ %@",[self.playerName objectAtIndex:0],[self.lastName objectAtIndex:0]];
            
            [self.command setObject:[NSString stringWithFormat:@"%@ %@",[self.playerName objectAtIndex:0],[self.lastName objectAtIndex:0]] forKey:@"Email_Rel1"];
            [self.command setObject:[NSString stringWithFormat:@"%@ %@",[self.playerName objectAtIndex:1],[self.lastName objectAtIndex:1]] forKey:@"Email_Rel2"];
            [self.command setObject:[NSString stringWithFormat:@"%@ %@",[self.playerName objectAtIndex:2],[self.lastName objectAtIndex:2]] forKey:@"Email_Rel3"];
            
            [self.command setObject:[NSString stringWithFormat:@"%@ %@",[self.playerName objectAtIndex:1],[self.lastName objectAtIndex:1]] forKey:@"Name2"];
            [self.command setObject:[NSString stringWithFormat:@"%@ %@",[self.playerName objectAtIndex:2],[self.lastName objectAtIndex:2]] forKey:@"Name3"];
            // Phone no
            
            [self.command setObject:[self.phoneNoValue objectAtIndex:0] forKey:@"ph_no"];
            [self.command setObject:[self.phoneNoValue objectAtIndex:1] forKey:@"ph_no2"];
            [self.command setObject:[self.phoneNoValue objectAtIndex:2] forKey:@"ph_no3"];
            
            [self.command setObject:[NSString stringWithFormat:@"%@ %@",[self.playerName objectAtIndex:0],[self.lastName objectAtIndex:0]] forKey:@"Ph_Rel1"];
            [self.command setObject:[NSString stringWithFormat:@"%@ %@",[self.playerName objectAtIndex:1],[self.lastName objectAtIndex:1]] forKey:@"Ph_Rel2"];
            [self.command setObject:[NSString stringWithFormat:@"%@ %@",[self.playerName objectAtIndex:2],[self.lastName objectAtIndex:2]] forKey:@"Ph_Rel3"];
            
        }else if (self.CountPlayer==2){
            
            [self.command setObject:[self.emailIdValue objectAtIndex:0] forKey:@"Email1"];
            [self.command setObject:[self.emailIdValue objectAtIndex:1] forKey:@"Email2"];
            [command setObject:@"" forKey:@"Email3"];
            
            [self.command setObject:[NSString stringWithFormat:@"%@ %@",[self.playerName objectAtIndex:1],[self.lastName objectAtIndex:1]] forKey:@"Name2"];
            [self.command setObject:@"" forKey:@"Name3"];
            
            [self.command setObject:[NSString stringWithFormat:@"%@ %@",[self.playerName objectAtIndex:0],[self.lastName objectAtIndex:0]] forKey:@"Email_Rel1"];
            [self.command setObject:[NSString stringWithFormat:@"%@ %@",[self.playerName objectAtIndex:1],[self.lastName objectAtIndex:1]] forKey:@"Email_Rel2"];
              [self.command setObject:[NSString stringWithFormat:@"%@ %@",[self.playerName objectAtIndex:1],[self.lastName objectAtIndex:1]] forKey:@"Name2"];
            [self.command setObject:@"" forKey:@"Email_Rel3"];
            
            
            //Phone no
            [self.command setObject:[self.phoneNoValue objectAtIndex:0] forKey:@"ph_no"];
            [self.command setObject:[self.phoneNoValue objectAtIndex:1]  forKey:@"ph_no2"];
            [command setObject:@"" forKey:@"ph_no3"];
            
            [self.command setObject:[NSString stringWithFormat:@"%@ %@",[self.playerName objectAtIndex:0],[self.lastName objectAtIndex:0]] forKey:@"Ph_Rel1"];
            [self.command setObject:[NSString stringWithFormat:@"%@ %@",[self.playerName objectAtIndex:1],[self.lastName objectAtIndex:1]] forKey:@"Ph_Rel2"];
            [self.command setObject:@"" forKey:@"Ph_Rel3"];
            
            
            
        }else if(self.CountPlayer==1){
            
            [self.command setObject:[self.emailIdValue objectAtIndex:0] forKey:@"Email1"];
            [command setObject:@"" forKey:@"Email2"];
            [command setObject:@"" forKey:@"Email3"];
            
            [self.command setObject:@"" forKey:@"Name2"];
            [self.command setObject:@"" forKey:@"Name3"];
            
            [self.command setObject:[NSString stringWithFormat:@"%@ %@",[self.playerName objectAtIndex:0],[self.lastName objectAtIndex:0]] forKey:@"Email_Rel1"];
            [self.command setObject:@"" forKey:@"Email_Rel2"];
            [self.command setObject:@"" forKey:@"Email_Rel3"];
            
            //Phone no
            
            [self.command setObject:[self.phoneNoValue objectAtIndex:0] forKey:@"ph_no"];
            [command setObject:@"" forKey:@"ph_no2"];
            [command setObject:@"" forKey:@"ph_no3"];
            
            [self.command setObject:[NSString stringWithFormat:@"%@ %@",[self.playerName objectAtIndex:0],[self.lastName objectAtIndex:0]] forKey:@"Ph_Rel1"];
            [self.command setObject:@"" forKey:@"Ph_Rel2"];
            [self.command setObject:@"" forKey:@"Ph_Rel3"];
            
            
            
        }else{
            
            
            [self.command setObject:@"" forKey:@"ph_no"];
            [command setObject:@"" forKey:@"ph_no2"];
            [command setObject:@"" forKey:@"ph_no3"];
            
            [self.command setObject:@"" forKey:@"Ph_Rel1"];
            [self.command setObject:@"" forKey:@"Ph_Rel2"];
            [self.command setObject:@"" forKey:@"Ph_Rel3"];
            
        }
        
        

        SBJsonWriter *writer = [[SBJsonWriter alloc] init];
        
        NSString *jsonCommand = [writer stringWithObject:command];
        
        [writer release];
        
        [self showHudView:@"Connecting..."];
        [self showNativeHudView];
        
        [appDelegate sendRequestFor:EDIT_PLAYER from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
    }
    }else{
        
    }
    
}


-(void)notifyRequesterWithData:(id) aData :(id)aData1{
    [self hideHudView];
    [self hideNativeHudView];
    
    if([aData isKindOfClass:[ConnectionManager class]])
    {
        ConnectionManager *aR=(ConnectionManager*)aData;
        if(playerMode==0)
        {
            if([aR.requestSingleId isEqualToString:ADD_PLAYER])
            {
                
            }
        }
        else if(playerMode==1)
        {
            if([aR.requestSingleId isEqualToString:EDIT_PLAYER])
            {
                
            }
        }
        
        return;
    }
    
    NSString *str=(NSString*)aData;
    NSLog(@"JSONData=%@",str);
    if(playerMode==0)
    {
        if (str)
        {
            SBJsonParser *parser=[[SBJsonParser alloc] init];
            
            id res = [parser objectWithString:str];
            
            [parser release];
            if ([res isKindOfClass:[NSDictionary class]])
            {
                NSDictionary* aDict = (NSDictionary*) res;
                NSString *message=[aDict objectForKey:@"message"];
                NSLog(@"%@",message);
                
                if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
                {
                    [self.command removeObjectForKey:@"user_id"];
                    [self.command removeObjectForKey:@"team_id"];
                    [self.command removeObjectForKey:@"last_name"];
                    
                    [self.command setObject:[aDict objectForKey:@"player_id"] forKey:@"player_id"];
                    [self.command setObject:[NSString stringWithFormat:@"%@ %@",[self.playerName objectAtIndex:0],[self.lastName objectAtIndex:0]] forKey:@"player_name"];
                    [self.command setObject:[aDict objectForKey:@"invites"] forKey:@"invites"];

                    
                    [[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] addObject:self.command];
                    NSLog(@"player list %@",[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"]);
                    
//                    [self enableSlidingAndShowTopBar];
//                    [self.navigationController popViewControllerAnimated:YES];
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                    /*[self.emailIdValue removeAllObjects];
                    [self.playerName removeAllObjects];
                    [self.lastName removeAllObjects];
                    [self.phoneNoValue removeAllObjects];*/
                    
                    [self performSelector:@selector(playerInvite:) withObject:nil afterDelay:2.0];

                }
                else
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                }
            }
        }
    }
    else if(playerMode==1)
    {
        if (str)
        {
            SBJsonParser *parser=[[SBJsonParser alloc] init];
            
            id res = [parser objectWithString:str];
            
            [parser release];
            if ([res isKindOfClass:[NSDictionary class]])
            {
                NSDictionary* aDict = (NSDictionary*) res;
                // aDict=[aDict objectForKey:@"responseData"];
                NSString *message=[aDict objectForKey:@"message"];
                NSLog(@"%@",message);
                
                if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
                {
                    
                    
                    [[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] setObject:[NSString stringWithFormat:@"%@ %@",[self.command valueForKey:@"player_name"],[self.command valueForKey:@"last_name"]] forKey:@"player_name"];
                    
                    [[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] setObject:[self.command valueForKey:@"Name2"] forKey:@"Name2"];
                    
                     [[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] setObject:[self.command valueForKey:@"Name3"] forKey:@"Name3"];

                    
                    
                    [[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] setObject:[self.command valueForKey:@"Email1"] forKey:@"Email1"];
                    [[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] setObject:[self.command valueForKey:@"Email2"] forKey:@"Email2"];
                    [[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] setObject:[self.command valueForKey:@"Email3"] forKey:@"Email3"];
                    
                    [[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] setObject:[self.command valueForKey:@"Email_Rel1"] forKey:@"Email_Rel1"];
                    [[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] setObject:[self.command valueForKey:@"Email_Rel2"] forKey:@"Email_Rel2"];
                    [[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] setObject:[self.command valueForKey:@"Email_Rel3"] forKey:@"Email_Rel3"];

                    
                    
                    [[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] setObject:[self.command valueForKey:@"ph_no"] forKey:@"ph_no"];
                    [[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] setObject:[self.command valueForKey:@"ph_no2"] forKey:@"ph_no2"];
                    [[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] setObject:[self.command valueForKey:@"ph_no3"] forKey:@"ph_no3"];
                    
                    [[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] setObject:[self.command valueForKey:@"Ph_Rel1"] forKey:@"Ph_Rel1"];
                    [[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] setObject:[self.command valueForKey:@"Ph_Rel2"] forKey:@"Ph_Rel2"];
                    [[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] setObject:[self.command valueForKey:@"Ph_Rel3"] forKey:@"Ph_Rel3"];

//                    [self enableSlidingAndShowTopBar];
//                    [self.navigationController popViewControllerAnimated:YES];
                    [self dismissViewControllerAnimated:YES completion:nil];

                   /* [self.emailIdValue removeAllObjects];
                    [self.playerName removeAllObjects];
                    [self.lastName removeAllObjects];
                    [self.phoneNoValue removeAllObjects];*/

                }
                
                
                else
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Operation failed." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                }
            }
        }
    }

}

#pragma mark - UITableViewDatasourace

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.CountPlayer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isiPad) {
        return 511;
    }
    return 291;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
          
        if (self.CountPlayer==3) {
            return nil;
        }else{
            return self.playerHeaderView;
        }

 }

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
        
        if (self.CountPlayer==3) {
            return 0;
        }else{
            if(self.isiPad)
                return 80;
            return 50;
        }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"DropDownCell";
    
    PlayerListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        
        cell = [PlayerListCell customCell];
        
        [cell.editBtn addTarget:self action:@selector(editCustomCell:) forControlEvents:UIControlEventTouchUpInside];
        [cell.delBtn addTarget:self action:@selector(deleteCustomCell:) forControlEvents:UIControlEventTouchUpInside];
        [cell.addressBookBtn addTarget:self action:@selector(userListingTapped:) forControlEvents:UIControlEventTouchUpInside];
        cell.delBtn.hidden=YES;
        cell.addressBookBtn.hidden=NO;
        cell.addMinEmailText.delegate=self;
        cell.addMinPhoneText.delegate=self;
        cell.addMinNameText.delegate=self;
        cell.lastName.delegate=self;
        @autoreleasepool
        {
            if(self.appDelegate.alreadyRegisteredMember == YES)
            {
                [cell.addMinEmailText setValue:[UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
                [cell.addMinPhoneText setValue:[UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
                [cell.addMinNameText setValue:[UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
                [cell.lastName setValue:[UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
            }
            else
            {
                [cell.addMinEmailText setValue:[UIColor colorWithRed:61.0/255.0 green:148.0/255.0 blue:212.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
                [cell.addMinPhoneText setValue:[UIColor colorWithRed:61.0/255.0 green:148.0/255.0 blue:212.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
                [cell.addMinNameText setValue:[UIColor colorWithRed:61.0/255.0 green:148.0/255.0 blue:212.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
                [cell.lastName setValue:[UIColor colorWithRed:61.0/255.0 green:148.0/255.0 blue:212.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
                
                cell.addMinEmailText.textColor = [UIColor colorWithRed:61.0/255.0 green:148.0/255.0 blue:212.0/255.0 alpha:1.0];
                cell.addMinPhoneText.textColor = [UIColor colorWithRed:61.0/255.0 green:148.0/255.0 blue:212.0/255.0 alpha:1.0];
                cell.addMinNameText.textColor = [UIColor colorWithRed:61.0/255.0 green:148.0/255.0 blue:212.0/255.0 alpha:1.0];
                cell.lastName.textColor = [UIColor colorWithRed:61.0/255.0 green:148.0/255.0 blue:212.0/255.0 alpha:1.0];
                
            }
            
        }

    }
    cell.delBtn.hidden=YES;

    if(indexPath.row==0)
    {
        
        if (playerMode!=0)
        {
            if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"UserID"] isEqualToString:@""])
            {
                cell.addMinNameText.userInteractionEnabled=YES;
                cell.lastName.userInteractionEnabled=YES;
                cell.addMinEmailText.userInteractionEnabled=YES;
                
                
            }
            else
            {
                if (self.isPlayerEmailIDRegster)
                {
                    cell.addMinNameText.userInteractionEnabled=NO;
                    cell.lastName.userInteractionEnabled=NO;
                    cell.addMinEmailText.userInteractionEnabled=NO;
                }
                else
                {
                    cell.addMinNameText.userInteractionEnabled=YES;
                    cell.lastName.userInteractionEnabled=YES;
                    cell.addMinEmailText.userInteractionEnabled=YES;
                    
                    
                }
            }
            cell.addressBookBtn.hidden = YES;
        }
        else
        {
            if (self.isPlayerEmailIDRegster) {
                
                /*cell.addMinNameText.userInteractionEnabled=YES;
                cell.lastName.userInteractionEnabled=YES;*/
                //[self.currrentTextFiled resignFirstResponder];
               // [cell.lastName resignFirstResponder];
                cell.addMinNameText.userInteractionEnabled=NO;
                cell.lastName.userInteractionEnabled=NO;
                
                
                
                
            }else{
                
                cell.addMinNameText.userInteractionEnabled=YES;
                cell.lastName.userInteractionEnabled=YES;
                
            }
            

        }
        cell.rowSeparator.hidden=NO;
        cell.title.text=@"";
        cell.addMinNameText.tag=1000;
        cell.addMinEmailText.tag=1001;
        cell.addMinPhoneText.tag=1002;
        cell.lastName.tag=1003;
        cell.addressBookBtn.tag=1;
        cell.addMinNameText.text=[self.playerName objectAtIndex:0];
        cell.lastName.text=[self.lastName objectAtIndex:0];
        cell.addMinEmailText.text=[self.emailIdValue objectAtIndex:0];
        cell.addMinPhoneText.text=[self.phoneNoValue objectAtIndex:0];
        cell.editBtn.hidden = YES;
        cell.addressBookBtn.hidden=YES;
        
    }else if(indexPath.row==1)
    {
        
       // cell.backgroundColor=[UIColor orangeColor];
        
        if (playerMode!=0)
        {
            if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"UserID2"] isEqualToString:@""])
            {
                cell.addMinNameText.userInteractionEnabled=YES;
                cell.lastName.userInteractionEnabled=YES;
                cell.addMinEmailText.userInteractionEnabled=YES;
            }
            else
            {
                if (self.isPrimary1EmailIDRegster)
                {
                    cell.addMinNameText.userInteractionEnabled=NO;
                    cell.lastName.userInteractionEnabled=NO;
                    cell.addMinEmailText.userInteractionEnabled=YES;
                }
                else
                {
                    cell.addMinNameText.userInteractionEnabled=YES;
                    cell.lastName.userInteractionEnabled=YES;
                    cell.addMinEmailText.userInteractionEnabled=YES;
                    
                }
//                cell.addMinNameText.userInteractionEnabled=NO;
//                cell.lastName.userInteractionEnabled=NO;
//                cell.addMinEmailText.userInteractionEnabled=NO;
            }
        }
        else
        {
            if (self.isPrimary1EmailIDRegster)
            {
                
//                [cell.addMinNameText resignFirstResponder];
//                [cell.lastName resignFirstResponder];
                cell.addMinNameText.userInteractionEnabled=NO;
                cell.lastName.userInteractionEnabled=NO;
                
            }
            else{
                
                cell.addMinNameText.userInteractionEnabled=YES;
                cell.lastName.userInteractionEnabled=YES;
            }
            
        }

        
        cell.rowSeparator.hidden=NO;
        cell.title.text=@"";
        cell.addMinNameText.tag=2000;
        cell.addMinEmailText.tag=2001;
        cell.addMinPhoneText.tag=2002;
        cell.lastName.tag=2003;
        cell.addressBookBtn.tag=2;
        cell.addMinNameText.text=[self.playerName objectAtIndex:1];
        cell.lastName.text=[self.lastName objectAtIndex:1];
        cell.addMinEmailText.text=[self.emailIdValue objectAtIndex:1];
        cell.addMinPhoneText.text=[self.phoneNoValue objectAtIndex:1];
        cell.addressBookBtn.hidden=NO;
        
    }else{
        
        if (playerMode!=0)
        {
            if ([[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"UserID3"] isEqualToString:@""])
            {
                cell.addMinNameText.userInteractionEnabled=YES;
                cell.lastName.userInteractionEnabled=YES;
                cell.addMinEmailText.userInteractionEnabled=YES;
                
            }
            else
            {
                
                if (self.isPrimary2EmailIDRegster)
                {
                    cell.addMinNameText.userInteractionEnabled=NO;
                    cell.lastName.userInteractionEnabled=NO;
                    cell.addMinEmailText.userInteractionEnabled=YES;
                    
                }
                else
                {
                    cell.addMinNameText.userInteractionEnabled=YES;
                    cell.lastName.userInteractionEnabled=YES;
                    cell.addMinEmailText.userInteractionEnabled=YES;
                    
                }
//                cell.addMinNameText.userInteractionEnabled=NO;
//                cell.lastName.userInteractionEnabled=NO;
//                cell.addMinEmailText.userInteractionEnabled=NO;
            }
        }
        else
        {
            if (self.isPrimary2EmailIDRegster)
            {
                
//                [cell.addMinNameText resignFirstResponder];
//                [cell.lastName resignFirstResponder];
                cell.addMinNameText.userInteractionEnabled=NO;
                cell.lastName.userInteractionEnabled=NO;
                
                
            }else
            {
                
                cell.addMinNameText.userInteractionEnabled=YES;
                cell.lastName.userInteractionEnabled=YES;
                
            }
            
        }
        
        cell.addressBookBtn.hidden=NO;
        cell.rowSeparator.hidden=YES;
        cell.title.text=@"";
        cell.addMinNameText.tag=3000;
        cell.addMinEmailText.tag=3001;
        cell.addMinPhoneText.tag=3002;
        cell.lastName.tag=3003;
        cell.addressBookBtn.tag=3;
        cell.addMinNameText.text=[self.playerName objectAtIndex:2];
        cell.lastName.text=[self.lastName objectAtIndex:2];
        cell.addMinEmailText.text=[self.emailIdValue objectAtIndex:2];
        cell.addMinPhoneText.text=[self.phoneNoValue objectAtIndex:2];

        
    }

    if (self.CountPlayer==1) {
        self.titleLbl.text=@"Add Player";
    }else{
        self.titleLbl.text=@"Add Parent, Guardian, Friend, etc";

    }
    
       return cell;
}

#pragma mark - UITableViewDelgate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}


#pragma  mark - MoveScroll


/*-(void)moveScrollView:(UIView *)theView
{
    CGFloat vcy=theView.superview.superview.frame.origin.y+theView.superview.frame.origin.y+theView.center.y;
    
    CGFloat fsh=af.size.height;
    CGFloat sa=0.0;
    if(isiPhone5)
        sa=vcy-fsh/5.5;   //sa=vcy-fsh/3.2;
    else
        sa=vcy-fsh/6.5;
    
    if(sa<0)
        sa=0;
    
    self.playerScrollView.contentSize=CGSizeMake(af.size.width,af.size.height+kb.size.height);
    NSLog(@"%f-%f-%f,%f",self.playerScrollView.contentSize.height,af.size.height,kb.size.height,sa);
    [ self.playerScrollView setContentOffset:CGPointMake(0,sa) animated:YES];
}*/


-(void)moveScrollView:(UIView *)theView

{
    
    CGFloat vcy=theView.superview.superview.frame.origin.y+theView.superview.frame.origin.y+theView.center.y;
    
    
    
    CGFloat fsh=af.size.height;
    
    CGFloat sa=0.0;
    
    if(isiPhone5)
        
        sa=vcy-fsh/5.5;   //sa=vcy-fsh/3.2;
    
    else
        
        sa=vcy-fsh/6.5;
    
    
    
    if(sa<0)
        
        sa=0;
    
    //////////////////////////////ADDDEBATTAM
    
    if (self.CountPlayer==3)
        
        self.playerScrollView.contentSize=CGSizeMake(af.size.width,(svos.height+kb.size.height+150));
    
    else
        
        self.playerScrollView.contentSize=CGSizeMake(af.size.width,svos.height+kb.size.height);
    
    ////////////////////////////
    
    
    
    
    
    NSLog(@"%f-%f-%f,%f",self.playerScrollView.contentSize.height,af.size.height,kb.size.height,sa);
    
    [ self.playerScrollView setContentOffset:CGPointMake(0,sa) animated:YES];
    
}




#pragma mark - TextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField==self.gupiTextField) {
        return;
    }
    self.currrentTextFiled=textField;
    //if(appDelegate.isIos7){
        [self moveScrollView:[[[textField superview] superview] superview]];
//    }
//    else{
//        [self moveScrollView:[[textField superview] superview]];
//    }
    if(textField.tag==1000 || textField.tag==1003){
        self.isTapBack=1;
        
        // commented on  6th Oct
        //PlayerListCell *cell =(PlayerListCell *)[[[textField superview] superview] superview];
        PlayerListCell *cell;
        if(appDelegate.isIos7)
           
            cell =(PlayerListCell *)[[[[textField superview] superview] superview] superview];
        else
           
            cell =(PlayerListCell *)[[[textField superview] superview] superview];
        
        if (cell.addMinEmailText.text.length==0) {
            self.isValidEmailCheck=0;
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Please enter your Email id" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil]; 
            [alert show];
            [alert release];
            //[cell.addMinEmailText becomeFirstResponder];
        }
        else if ([self validEmail:cell.addMinEmailText.text]) {
            if(self.isValidEmailCheck==0){
                [self.emailIdValue replaceObjectAtIndex:0 withObject:cell.addMinEmailText.text];
//                [self.currrentTextFiled resignFirstResponder];
               // NSIndexPath *inde=[self.playerTable indexPathForCell:cell];
                self.selectedTextIndex=[self.playerTable indexPathForCell:cell];
                //self.emailIdValue1=self.emailIdValue;
                self.last_emailId=@"";
                for (NSString *str in self.emailIdValue) {
                    if (self.last_emailId.length>0) {
                        self.last_emailId=[self.last_emailId stringByAppendingFormat:@",%@",str];
                    }
                    else
                        self.last_emailId=str;
                }
                NSLog(@"Email array is: %@",self.emailIdValue);
                [self getFullName:cell.addMinEmailText.text];
                self.isValidEmailCheck=1;
                
            }
            
        }else{
            self.isValidEmailCheck=0;
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"The email id is invalid" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
//            if (self.isTapBack==0)
//                [textField becomeFirstResponder];
        }
    }
    else if(textField.tag==2000 || textField.tag==2003){
        self.isTapBack=1;
        
        // commented on  6th Oct
        //PlayerListCell *cell =(PlayerListCell *)[[[textField superview] superview] superview];
        PlayerListCell *cell;
        if(appDelegate.isIos7)
            
            cell =(PlayerListCell *)[[[[textField superview] superview] superview] superview];
        else
            
            cell =(PlayerListCell *)[[[textField superview] superview] superview];
        
        if (cell.addMinEmailText.text.length==0) {
            self.isValidEmailCheck=0;
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Please enter your Email id" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            //[cell.addMinEmailText becomeFirstResponder];
        }
        else if ([self validEmail:cell.addMinEmailText.text]) {
            if(self.isValidEmailCheck==0){
                [self.emailIdValue replaceObjectAtIndex:1 withObject:cell.addMinEmailText.text];
                //                [self.currrentTextFiled resignFirstResponder];
                // NSIndexPath *inde=[self.playerTable indexPathForCell:cell];
                self.selectedTextIndex=[self.playerTable indexPathForCell:cell];
                //self.emailIdValue1=self.emailIdValue;
                self.last_emailId=@"";
                for (NSString *str in self.emailIdValue) {
                    if (self.last_emailId.length>0) {
                        self.last_emailId=[self.last_emailId stringByAppendingFormat:@",%@",str];
                    }
                    else
                        self.last_emailId=str;
                }
                [self getFullName:cell.addMinEmailText.text];
                self.isValidEmailCheck=1;
                
            }
            
        }else{
            self.isValidEmailCheck=0;
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"The email id is invalid" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            //            if (self.isTapBack==0)
            //                [textField becomeFirstResponder];
        }
    }
    else if(textField.tag==3000 || textField.tag==3003){
        self.isTapBack=1;
        
        // commented on  6th Oct
        //PlayerListCell *cell =(PlayerListCell *)[[[textField superview] superview] superview];
        PlayerListCell *cell;
        if(appDelegate.isIos7)
            
            cell =(PlayerListCell *)[[[[textField superview] superview] superview] superview];
        else
            
            cell =(PlayerListCell *)[[[textField superview] superview] superview];
        
        if (cell.addMinEmailText.text.length==0) {
            self.isValidEmailCheck=0;
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Please enter your Email id" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            //[cell.addMinEmailText becomeFirstResponder];
        }
        else if ([self validEmail:cell.addMinEmailText.text]) {
            if(self.isValidEmailCheck==0){
                [self.emailIdValue replaceObjectAtIndex:2 withObject:cell.addMinEmailText.text];
                //                [self.currrentTextFiled resignFirstResponder];
                // NSIndexPath *inde=[self.playerTable indexPathForCell:cell];
                self.selectedTextIndex=[self.playerTable indexPathForCell:cell];
               // self.emailIdValue1=self.emailIdValue;
                self.last_emailId=@"";
                for (NSString *str in self.emailIdValue) {
                    if (self.last_emailId.length>0) {
                        self.last_emailId=[self.last_emailId stringByAppendingFormat:@",%@",str];
                    }
                    else
                        self.last_emailId=str;
                }
                [self getFullName:cell.addMinEmailText.text];
                self.isValidEmailCheck=1;
                
            }
            
        }else{
            self.isValidEmailCheck=0;
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"The email id is invalid" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            //            if (self.isTapBack==0)
            //                [textField becomeFirstResponder];
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField==self.gupiTextField) {
        return;
    }
    if (self.isGetName) {
        self.isGetName=NO;
        return;
    }
    
    if(textField.tag==1000){
        
            
        [self.playerName replaceObjectAtIndex:0 withObject:textField.text];
       
      
    }
    else if (textField.tag==2000) {
        
        
            
        [self.playerName replaceObjectAtIndex:1 withObject:textField.text];
      

        
    } else if (textField.tag==3000) {
            
        [self.playerName replaceObjectAtIndex:2 withObject:textField.text];
             
        
    }else if(textField.tag==1001){
        
       
            
        if ([self validEmail:textField.text]) {
            
            [self.emailIdValue replaceObjectAtIndex:0 withObject:textField.text];
            //[self getFullName:textField.text];
            self.isValidEmailCheck=0;
            
        }else{
            if (self.isTapBack==0){
                [textField becomeFirstResponder];
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"The email id is invalid" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
            }
            
        }
        
        
    }
    else if (textField.tag==2001) {
        
        if ([self validEmail:textField.text]) {
                
            [self.emailIdValue replaceObjectAtIndex:1 withObject:textField.text];
            //[self getFullName:textField.text];
            self.isValidEmailCheck=0;
            
        }else{
            
            if (self.isTapBack==0){
                [textField becomeFirstResponder];
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"The email id is invalid" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
            }

           /* UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"The email id is invalid" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            [textField becomeFirstResponder];*/ /// 10/9
        }
      
        
        
    } else if (textField.tag==3001) {
        
                  
        if ([self validEmail:textField.text]) {
            
            [self.emailIdValue replaceObjectAtIndex:2 withObject:textField.text];
            //[self getFullName:textField.text];  
            self.isValidEmailCheck=0;
            
        }else{
            
            if (self.isTapBack==0){
                [textField becomeFirstResponder];
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"The email id is invalid" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
            }
           /* UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"The email id is invalid" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            [textField becomeFirstResponder];*/  /// 10/9
        }
        
       
        
        
    }else if(textField.tag==1002){
        
                  
        [self.phoneNoValue replaceObjectAtIndex:0 withObject:textField.text];
       
        
    }
    else if (textField.tag==2002) {
        
                   
        [self.phoneNoValue replaceObjectAtIndex:1 withObject:textField.text];
     
        
        
    } else if (textField.tag==3002) {
        
        [self.phoneNoValue replaceObjectAtIndex:2 withObject:textField.text];
        
        
        
    }else if(textField.tag==1003){
        

        
        [self.lastName replaceObjectAtIndex:0 withObject:textField.text];
             
    }
    else if (textField.tag==2003) {
        
        
        [self.lastName replaceObjectAtIndex:1 withObject:textField.text];
     
        
        
    } else if (textField.tag==3003) {
        
        
        [self.lastName replaceObjectAtIndex:2 withObject:textField.text];

        
    }


    
    
      
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (textField==self.gupiTextField) {
        return YES;
    }
    self.playerScrollView.contentSize=svos;
    self.playerScrollView.contentOffset=CGPointMake(0, 0);
    
    ///////  ARPI 11/9/14
    if(textField.tag==1001){
        
        
        
        if ([self validEmail:textField.text]) {
            
            [self.emailIdValue replaceObjectAtIndex:0 withObject:textField.text];
            [self getFullName:textField.text];
            
        }else{
            if (self.isTapBack==0){
                //[textField becomeFirstResponder];
                /*UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"The email id is invalid" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];*/  /// 11/9
            }
            
        }
        
        
    }
    else if (textField.tag==2001) {
        
        if ([self validEmail:textField.text]) {
            
            [self.emailIdValue replaceObjectAtIndex:1 withObject:textField.text];
            [self getFullName:textField.text];
            
        }else{
            
            if (self.isTapBack==0){
                /*[textField becomeFirstResponder];
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"The email id is invalid" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];*/  /// 11/9
            }
            
            /* UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"The email id is invalid" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
             [alert show];
             [alert release];
             [textField becomeFirstResponder];*/ /// 10/9
        }
        
        
        
    } else if (textField.tag==3001) {
        
        
        if ([self validEmail:textField.text]) {
            
            [self.emailIdValue replaceObjectAtIndex:2 withObject:textField.text];
            [self getFullName:textField.text];
            
        }else{
            
            if (self.isTapBack==0){
               /* [textField becomeFirstResponder];
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"The email id is invalid" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];*/  /// 11/9
            }
            /* UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"The email id is invalid" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
             [alert show];
             [alert release];
             [textField becomeFirstResponder];*/  /// 10/9
        }
        
        
        
        
    }
    ///////// /////////
    
    return YES;
}
- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (theTextField==self.gupiTextField) {
        return YES;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if (theTextField.tag==1000 || theTextField.tag==2000 || theTextField.tag==3000 ) {
        
        if (theTextField.text.length<=15) {
            NSString *resultingString = [theTextField.text stringByReplacingCharactersInRange: range withString: string];
            NSCharacterSet *whitespaceSet = [NSCharacterSet whitespaceCharacterSet];
            if  ([resultingString rangeOfCharacterFromSet:whitespaceSet].location == NSNotFound)      {
                return YES;
            }  else  {
                return NO;
            }

        }else{
            return NO;
        }
    }
    
   
        
    if (theTextField.tag==1002 || theTextField.tag==2002 || theTextField.tag==3002 ) {
        
        if (theTextField.text.length<=15) {
            
            NSCharacterSet *cs=[[NSCharacterSet characterSetWithCharactersInString:VALIDPHONENUMBER] invertedSet];
            NSString *filterString=[[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
            return [string isEqualToString:filterString];
            
        }else{
            return NO;
        }

    }
    
    if (theTextField.tag==1003 || theTextField.tag==2003 || theTextField.tag==3003 ) {
        
        if (theTextField.text.length<=15) {
            NSString *resultingString = [theTextField.text stringByReplacingCharactersInRange: range withString: string];
            NSCharacterSet *whitespaceSet = [NSCharacterSet whitespaceCharacterSet];
            if  ([resultingString rangeOfCharacterFromSet:whitespaceSet].location == NSNotFound)      {
                return YES;
            }  else  {
                return NO;
            }
            
        }else{
            return NO;
        }
        
    }

    
    
    return YES;

}

#pragma  mark - GetContactFromIphone

- (IBAction)userListingTapped:(UIButton*)sender{
    
    [self.currrentTextFiled resignFirstResponder];

    ABPeoplePickerNavigationController *contactPicker = [[ABPeoplePickerNavigationController alloc] init];
    contactPicker.peoplePickerDelegate = self;
    
    if (sender.tag==1) {
       
        self.isPlayer=YES;
        self.isPrimary1=NO;
        self.isPrimary2=NO;

        
    }else if(sender.tag==2){
        
        self.isPlayer=NO;
        self.isPrimary1=YES;
        self.isPrimary2=NO;

        
    }else{
       
        
        self.isPlayer=NO;
        self.isPrimary1=NO;
        self.isPrimary2=YES;

    }
    
    [self presentViewController:contactPicker animated:YES completion:^{
        
    }];
    
    [contactPicker release];
    
}

- (void)displayPerson:(ABRecordRef)person{
    
    NSString *name=nil;
    NSString *lastname=nil;
    NSString* fName = ( NSString*)ABRecordCopyValue(person,
                                                    kABPersonFirstNameProperty);
    NSString* mName = ( NSString*)ABRecordCopyValue(person,
                                                    kABPersonMiddleNameProperty);
    NSString* lName = ( NSString*)ABRecordCopyValue(person,
    
                                                    kABPersonLastNameProperty);
    if (fName) {
        
        name=[NSString stringWithFormat:@"%@",fName];
                    
    }
    
    if (mName){
        
        name=[NSString stringWithFormat:@"%@%@",name,mName];

    }
    
    if (lName){
        
        lastname=lName;
    }
    
    if(fName)
        CFRelease(fName);
    
    if(mName)
        CFRelease(mName);
    if(lName)
        CFRelease(lName);

    
    NSString* email = nil;
    ABMultiValueRef emailId = ABRecordCopyValue(person,
                                                kABPersonEmailProperty);
    
    
    
    if (ABMultiValueGetCount(emailId) > 0) {
        email = ( NSString*)
        ABMultiValueCopyValueAtIndex(emailId, 0);
        
//        if(email)
//            CFRelease(email);
    } else {
        //Subhasish..24th March
        self.popupBackVw.hidden = NO;
        self.popupAlertVw.hidden = NO;
        return;
    }
    
    
   
    
    
    NSString* phone = nil;
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person,
                                                     kABPersonPhoneProperty);
    if (ABMultiValueGetCount(phoneNumbers) > 0) {
        phone = ( NSString*)
        ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
      
//        if(phone)
//            CFRelease(phone);
    } else {
        phone = @"";
    }
    
    
    
    if (self.isPlayer) {
        
        if (self.isPlayer)
        {
            
        }
        
        if(name){
        [self.playerName replaceObjectAtIndex:0 withObject:name];
        }else{
            [self.playerName replaceObjectAtIndex:0 withObject:@""];
  
        }
        if(lastname){
            [self.lastName replaceObjectAtIndex:0 withObject:lastname];
        }else{
            [self.lastName replaceObjectAtIndex:0 withObject:@""];
            
        }
        
        
        if (email) {
            [self.emailIdValue replaceObjectAtIndex:0 withObject:email];

        }else{
            [self.emailIdValue replaceObjectAtIndex:0 withObject:@""];

        }
        if (phone) {
            
            [self.phoneNoValue replaceObjectAtIndex:0 withObject:phone];

        }else{
            [self.phoneNoValue replaceObjectAtIndex:0 withObject:@""];

        }
        
    }else if (self.isPrimary1){
        
        
        if(name){
            [self.playerName replaceObjectAtIndex:1 withObject:name];
        }else{
            [self.playerName replaceObjectAtIndex:1 withObject:@""];
            
        }
        
        if(lastname){
            [self.lastName replaceObjectAtIndex:1 withObject:lastname];
        }else{
            [self.lastName replaceObjectAtIndex:1 withObject:@""];
            
        }

        
        if (email) {
            [self.emailIdValue replaceObjectAtIndex:1 withObject:email];
            
        }else{
            [self.emailIdValue replaceObjectAtIndex:1 withObject:@""];
            
        }
        if (phone) {
            
            [self.phoneNoValue replaceObjectAtIndex:1 withObject:phone];
            
        }else{
            [self.phoneNoValue replaceObjectAtIndex:1 withObject:@""];
            
        }


        
    }else if (self.isPrimary2){
        
        if(name){
            [self.playerName replaceObjectAtIndex:2 withObject:name];
        }else{
            [self.playerName replaceObjectAtIndex:2 withObject:@""];
            
        }
        
        if(lastname){
            [self.lastName replaceObjectAtIndex:2 withObject:lastname];
        }else{
            [self.lastName replaceObjectAtIndex:2 withObject:@""];
            
        }
        
        if (email) {
            [self.emailIdValue replaceObjectAtIndex:2 withObject:email];
            
        }else{
            [self.emailIdValue replaceObjectAtIndex:2 withObject:@""];
            
        }
        if (phone) {
            
            [self.phoneNoValue replaceObjectAtIndex:2 withObject:phone];
            
        }else{
            [self.phoneNoValue replaceObjectAtIndex:2 withObject:@""];
            
        }

        
    }
    if(phoneNumbers)
        CFRelease(phoneNumbers);

     CFRelease(emailId);
    [self.playerTable reloadData];
}


#pragma  mark - ABpeoplepickerDelegate
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

// iOS 8

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier

{
    
    // [self peoplePickerNavigationController:peoplePicker shouldContinueAfterSelectingPerson:person];
    
    [self displayPerson:person];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}


// iOS 7
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person{
    
    [self displayPerson:person];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    
    
    return NO;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    
    return NO;
}


#pragma mark - GetEmailIdRegister --- ///10/9/14



-(void)checkEmailRegister:(NSString*)email
{
    NSMutableArray *arrMail=[[NSMutableArray alloc] init];
    if (![[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"Email1"] isEqualToString:@""])
        [arrMail addObject:[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"Email1"]];
    if (![[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"Email2"] isEqualToString:@""])
        [arrMail addObject:[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"Email2"]];
    
    if (![[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"Email3"] isEqualToString:@""])
        [arrMail addObject:[[[[self.appDelegate.JSONDATAarr objectAtIndex:selectedTeamIndex] objectForKey:@"player_details"] objectAtIndex:selectedPlayerIndex] objectForKey:@"Email3"]];
    
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    NSMutableDictionary *command1=[[NSMutableDictionary alloc] init];
    [command1 setObject:arrMail forKey:@"Email"];
    NSString *jsonCommand = [writer stringWithObject:command1];
    
    
    SingleRequest *sinReq=[[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:GETREGISTERNAMELINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
    self.sinReq4=sinReq;
    
    
    sinReq.notificationName=GETREGISTERNAME;
    
    [sinReq startRequest];
}



-(void)getRegisteNameLoaded:(id)sender{
    
    SingleRequest *sReq=(SingleRequest*)[sender object];
    
    NSLog(@"%@",sReq.responseString);
    
    if([sReq.notificationName isEqualToString:GETREGISTERNAME])
    {
        if(sReq.responseData)
        {
            
            if (sReq.responseString)
            {
                SBJsonParser *parser=[[SBJsonParser alloc] init];
                
                id res = [parser objectWithString:sReq.responseString];
                if ([res isKindOfClass:[NSDictionary class]])
                {
                    NSDictionary* aDict = (NSDictionary*) res;
                    
                     NSLog(@"%@",aDict);
                    int a=0;
                    NSMutableArray *arrEmail=[aDict objectForKey:@"user"];
                    
                    
                    if (arrEmail.count>2)
                    {
                        if (![[[arrEmail objectAtIndex:2] valueForKey:@"UserID"] isEqualToString:@""]) {
                            self.isPrimary2EmailIDRegster=YES;
                            a=1;
                        }
//                        self.isPrimary2EmailIDRegster=YES;
                    }
                    if (arrEmail.count>1)
                    {
                        if (![[[arrEmail objectAtIndex:1] valueForKey:@"UserID"] isEqualToString:@""]) {
                            self.isPrimary1EmailIDRegster=YES;
                            a=1;
                        }
                        //self.isPrimary1EmailIDRegster=YES;
                    }
                    if (arrEmail.count>0)
                    {
                        if (![[[arrEmail objectAtIndex:0] valueForKey:@"UserID"] isEqualToString:@""]) {
                            self.isPlayerEmailIDRegster=YES;
                            strName=@"player";
                        }
                        
                    }
                    if (a==1) {
                        if (strName) {
                            strName=[strName stringByAppendingString:@", optional user"];
                        }
                        else{
                            strName=@"optional user";
                        }
                    }
                    
                    
                    [self.playerTable reloadData];
                    //Subhasish..26th March
                    if (strName) {
                    /*    UIAlertView *at=[[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"First name & last name of %@ has been populated from user info. You can update the phone no.",strName] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                        [at show];*/
                    }
                   
                    
                    
                    /*if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
                    {
                        
                        
                        
                        
                    }else
                    {
                        
                    }*/
                }
            }
        }
    }

}


@end
