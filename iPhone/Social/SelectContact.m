//
//  ContactsVC.m
//  LinkBook
//
//  Created by Piyali on 21/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "MBProgressHUD.h"
#import "CenterViewController.h"
#import "ContactsUser.h"
#import "SelectContact.h"
#import "PushByInviteFriendVC.h"
@implementation SelectContact{
    BOOL isBack;
}

@synthesize tabView,headerl,mysearch,addb,deleteb,font,doneb,alldeleteb,alldelarr,fetchSearchResultsController,cancelSearch,mainGroup,isGroup,nontick,tick,contacts,mobile,indexes,mygroupContacts,backb,phvc,phFriend,teamId,strofbody,addAFriendVC,pickertop,dataAllArray,searchString,buttonMode,selectedRow,currentrow,selectedTeamId,currentmode,emailtotftext,pushInviteFriendvc,emailName;

@synthesize teamName,dictMemberSpectator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
     //   self.tabBarItem.image = [UIImage imageNamed:@"contact_tab.png"];
          
      //  self.tabBarItem.title=@"Contacts";
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
    self.phvc=nil;
    
   [[NSNotificationCenter defaultCenter] removeObserver:self name:HANDLERECEIVEDMEMORYWARNING object:nil];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:SELECTCONTACTIMAGELOADED object:nil];
      [[NSNotificationCenter defaultCenter] removeObserver:self name:USERLISTING object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:GETFULLNAME object:nil];
  
}
#pragma mark - View lifecycle




- (void)viewDidLoad
{
    // [self getUserListing];
    [super viewDidLoad];
    isBack=NO;
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageUpdated:) name:SELECTCONTACTIMAGELOADED object:nil];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userListUpdated:) name:USERLISTING object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fullNameLoaded:) name:GETFULLNAME object:nil];
    
    //////// Rakesh 13/07/15
    
    
    
   // self.mysearch.frame=CGRectMake(self.mysearch.frame.origin.x,self.mysearch.frame.origin.y,self.mysearch.frame.size.width,36);
    self.emailtotf.text=@"";
    self.emailtotftext=@"";
    self.emailName=@"";
    self.isFinishData=0;
    self.searchString=@"";
    if (!self.selectedTeamId) {
        self.selectedTeamId=@"";
    }
    
    
    
    
    ///// Rakesh 10/07/15
    if(self.appDelegate.alreadyRegisteredMember == YES)
    {
        [self.fName setValue:[UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        [self.lName setValue:[UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        [self.email setValue:[UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        [self.phoneNo setValue:[UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        [self.emailtotf setValue:[UIColor colorWithRed:54.0/255.0 green:152.0/255.0 blue:211.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    }
    else
    {
        [self.fName setValue:[UIColor colorWithRed:61.0/255.0 green:148.0/255.0 blue:212.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        [self.lName setValue:[UIColor colorWithRed:61.0/255.0 green:148.0/255.0 blue:212.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        [self.email setValue:[UIColor colorWithRed:61.0/255.0 green:148.0/255.0 blue:212.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        [self.phoneNo setValue:[UIColor colorWithRed:61.0/255.0 green:148.0/255.0 blue:212.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        [self.emailtotf setValue:[UIColor colorWithRed:61.0/255.0 green:148.0/255.0 blue:212.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
        
        
        self.fName.textColor = [UIColor colorWithRed:61.0/255.0 green:148.0/255.0 blue:212.0/255.0 alpha:1.0];
        self.lName.textColor = [UIColor colorWithRed:61.0/255.0 green:148.0/255.0 blue:212.0/255.0 alpha:1.0];
        self.email.textColor = [UIColor colorWithRed:61.0/255.0 green:148.0/255.0 blue:212.0/255.0 alpha:1.0];
        self.phoneNo.textColor = [UIColor colorWithRed:61.0/255.0 green:148.0/255.0 blue:212.0/255.0 alpha:1.0];
        self.emailtotf.textColor = [UIColor colorWithRed:61.0/255.0 green:148.0/255.0 blue:212.0/255.0 alpha:1.0];
        
    }
    
    
    
    
    
    if(self.appDelegate.alreadyRegisteredMember == YES)
    {
        self.fName.userInteractionEnabled = NO;
        self.lName.userInteractionEnabled = NO;
        self.email.userInteractionEnabled = NO;
        self.phoneNo.userInteractionEnabled = NO;
        self.emailtotf.userInteractionEnabled = NO;
    }
    /////
    
    //// AD july for member  /////
    
    if (self.dictMemberSpectator) {
        self.fName.text=[self.dictMemberSpectator valueForKey:@"FirstName"];
        self.lName.text=[self.dictMemberSpectator valueForKey:@"LastName"];
        self.email.text=[self.dictMemberSpectator valueForKey:@"Email"];
        self.phoneNo.text=[self.dictMemberSpectator valueForKey:@"ContactNo"];
        self.emailtotf.text=[self.dictMemberSpectator valueForKey:@"Email"];
        self.emailtotftext=[self.dictMemberSpectator valueForKey:@"Email"];
        self.emailName=[self.dictMemberSpectator valueForKey:@"FirstName"];
    }
    
    /*
     [self.selectedMemberDetailsDict setObject:self.nonMemberEmailId forKey:@"Email"];
     [self.selectedMemberDetailsDict setObject:@"" forKey:@"ContactNo"];
     [self.selectedMemberDetailsDict setObject:@"" forKey:@"FirstName"];
     [self.selectedMemberDetailsDict setObject:@"" forKey:@"LastName"];
     
     */
    
    ///////////////////////////////
    
    
    currentmode=1;
     self.limit=10;
    self.dataAllArray=[[NSMutableArray alloc] init];
    //self.topview.backgroundColor=appDelegate.barGrayColor;
  //  self.mysearch.tintColor=appDelegate.veryLightGrayColor;
  //  self.besidesearchvw.backgroundColor=appDelegate.barGrayColor;
  //  self.searchbottomvw.backgroundColor=appDelegate.barGrayColor;
    //self.view.backgroundColor=appDelegate.backgroundPinkColor;
    self.mobile=@"";
    // Do any additional setup after loading the view from its nib.
   // self.font=[UIFont fontWithName:@"Gill Sans" size:17];
    self.font=[UIFont systemFontOfSize:17];
    doneb.hidden=NO;
    alldeleteb.hidden=YES;
    self.alldelarr=[NSMutableArray array];
  //  self.tabView.tableHeaderView=self.mysearch;
    isSearchOn=NO;
    canSelectRow=YES;
    isCancelTappable=NO;
    isShowCancel=NO;
    //self.fetchSearchResultsController.delegate=self;
    if(isGroup)
    self.headerl.text=@"Add Group Contact";
    UIImage *nont=[UIImage imageNamed:@"Green-tickwithout@2x.png"];
    self.nontick=nont;
  //  [nont release];
    UIImage *t=[UIImage imageNamed:@"Green-tick@2x.png"];
    self.tick=t;
   // [t release];
    
    self.contacts=[NSMutableArray array];
    
            self.indexes=[NSMutableArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    
    
 //   self.mygroupContacts=[[mygroup connects] allObjects];
    
    
   // [self.mysearch setTintColor:self.lightbluecolor];
    
    [self setLayOutForLanguage];
    
    
    
    @autoreleasepool {
        if (self.isiPad) {
            self.suggestionimagegrey=[UIImage imageNamed:@"unselsuggetion_ipad.png"];
            self.searchimagegrey=[UIImage imageNamed:@"unselsearch_ipad.png"];
            self.contactsimagegrey=[UIImage imageNamed:@"unseladdb_ipad.png"];
            self.emailimagegrey=[UIImage imageNamed:@"unselemail_ipad.png"];
            self.suggestionimagered=[UIImage imageNamed:@"selsuggetion_ipad.png"];
            self.searchimagered=[UIImage imageNamed:@"selsearch_ipad.png"];
            self.contactsimagered=[UIImage imageNamed:@"seladdb_ipad.png"];
            self.emailimagered=[UIImage imageNamed:@"selemail_ipad.png"];
            self.helveticaFontForte=[UIFont fontWithName:@"Helvetica" size:22.0];
            self.helveticaFontBold=[UIFont fontWithName:@"Helvetica" size:21.0];
            self.helveticaFont=[UIFont fontWithName:@"Helvetica" size:20.0];
        }
        else{
            self.suggestionimagegrey=[UIImage imageNamed:@"unselsuggetion.png"];
            self.searchimagegrey=[UIImage imageNamed:@"unselsearch.png"];
            self.contactsimagegrey=[UIImage imageNamed:@"unseladdb.png"];
            self.emailimagegrey=[UIImage imageNamed:@"unselemail.png"];
            self.suggestionimagered=[UIImage imageNamed:@"selsuggetion.png"];
            self.searchimagered=[UIImage imageNamed:@"selsearch.png"];
            self.contactsimagered=[UIImage imageNamed:@"seladdb.png"];
            self.emailimagered=[UIImage imageNamed:@"selemail.png"];
            self.helveticaFontForte=[UIFont fontWithName:@"Helvetica" size:14.0];
            self.helveticaFontBold=[UIFont fontWithName:@"Helvetica" size:12.0];
            self.helveticaFont=[UIFont fontWithName:@"Helvetica" size:10.0];
        }
    }
    
    
    
    
   // self.fetchSearchResultsController=nil;
  //  self.fetchedResultsController=nil;
   // [self.tabView reloadData];
    
     /*if(  [[self.fetchedResultsController fetchedObjects] count]==0)
     {*/
         //[self showHudView:@"Fetching..."];
         //[self getUserListing];
     //}
    
  //  self.view.backgroundColor=appDelegate.backgroundPinkColor;
    
    
    
   /* CustomMailViewController *mailVC=[[CustomMailViewController alloc] initWithNibName:@"CustomMailViewController" bundle:nil];
    
    //mailVC.teamId=self.teamId;
   // mailVC.strofbody=self.strofbody;
    self.phFriend=mailVC;
    
    mailVC=nil;
    
    
    [self.phFriend view];*///Add Latest Ch
    
    AddAFriend *as=self.pushInviteFriendvc.addAFriendVC;//[[AddAFriend alloc] initWithNibName:@"AddAFriend" bundle:nil];
    
    self.addAFriendVC=as;
    self.addAFriendVC.selectContact=self;
   [self.addAFriendVC view];
    
    if(appDelegate.isIphone5)
        self.addAFriendVC.view.frame=CGRectMake(0, (164+88), self.addAFriendVC.view.frame.size.width, self.addAFriendVC.view.frame.size.height);
    else
         self.addAFriendVC.view.frame=CGRectMake(0, 164, self.addAFriendVC.view.frame.size.width, self.addAFriendVC.view.frame.size.height);
    
     [self.view addSubview:self.addAFriendVC.view];
    self.addAFriendVC.view.hidden=YES;
    as=nil;
    
   // self.phFriend.addAFriendVC=self.addAFriendVC;
    
    if (self.dataAllArray) {
        [self.dataAllArray removeAllObjects];
    }
   // [self suggestAction:nil];
}


#pragma mark -ClassMethod


#pragma mark - GETUSERFROM MAIL

-(void)getFullName:(NSString*)email
{
    self.fName.placeholder=@"Checking if the user already exists";
    self.lName.placeholder=@"Checking if the user already exists";
    
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
                        
                        self.fName.text=[aDict valueForKey:@"FirstName"];
                        self.lName.text=[aDict valueForKey:@"LastName"];
                        
                        
                    }else
                    {
                        self.emailtotf.userInteractionEnabled=YES;
                        self.fName.userInteractionEnabled=YES;
                        self.lName.userInteractionEnabled=YES;
                        self.fName.text=@"";
                        self.lName.text=@"";
                        self.fName.placeholder=@"First Name";
                        self.lName.placeholder=@"Last Name";
                    }
                }
            }
        }
    }
    
}




-(void)showNavigationBarButtons
{
    
    if(!self.leftBarButtonItem)
    {
        self.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backwhite.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleLeftPanel:)];
    }
    
    if(!self.rightBarButtonItem)
    {
        //self.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"eventfilter.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleRightPanel:)];
    }
    
    
    appDelegate.centerViewController.navigationItem.title=nil;
    appDelegate.centerViewController.navigationItem.titleView=nil;
    
    appDelegate.centerViewController.navigationItem.title=@"Invite Spectator";
    // appDelegate.centerViewController.navigationItem.titleView=nil;
    
    appDelegate.centerViewController.navigationItem.leftBarButtonItem=self.leftBarButtonItem;
    
    appDelegate.centerViewController.navigationItem.rightBarButtonItem=nil;
    
    
    [self setStatusBarStyleOwnApp:1];
    
}

-(void)toggleLeftPanel:(id)sender
{
    [self resetInHide];
    isBack=YES;
    
    /////////////
    if([self.mysearch becomeFirstResponder])
    {
        backb.hidden=NO;
        mysearch.showsCancelButton=NO;
        isSearchOn=NO;
        canSelectRow=YES;
        self.tabView.scrollEnabled=YES;
        
        [mysearch resignFirstResponder];
        [self enableSlidingAndShowTopBar];
        [cancelSearch setHidden:YES];
        isShowCancel=0;
        mysearch.text=@"";
        if([addb isHidden])
        {
            [addb setHidden:NO];
            self.fetchSearchResultsController=nil;
        }
        self.fetchSearchResultsController=nil;
        self.fetchedResultsController=nil;
        [tabView reloadData];
        if([tabView isEditing])
        {
            if([alldeleteb isHidden])
            {
                [alldeleteb setHidden:NO];
                
            }
        }
    }
    
    
    if([self.emailtotf becomeFirstResponder])
    {
        [self.emailtotf resignFirstResponder];
        [self enableSlidingAndShowTopBar];
        // self.emailtotf.hidden=YES;
        // self.mysearch.hidden=NO;
        self.cancelSearch.hidden=YES;
        isCancelTappable=0;
    }
    
    ////////////
    self.isFinishData=0;
    self.searchString=@"";
    
    [self.dataAllArray removeAllObjects];
    [self.tabView reloadData];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)toggleRightPanel:(id)sender
{
    
    
    
    
    
    
}





- (void)imageUpdated:(NSNotification *)notif
{
    
    
    
    NSNumber * info = [notif object];
    
    
    int row = [info intValue];
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    
    NSLog(@"ADDFImage for indexpath %i updated", indexPath.row);
    NSLog(@"ADDAFRIENDVC1reloadRows");
    
    if([[self.tabView indexPathsForVisibleRows] containsObject:indexPath])
    [self.tabView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    NSLog(@"ADDAFRIENDVC2reloadRows");
    
}

-(int)showAddAFriend
{
    
    if([self.emailtotf.text isEqualToString:@""] && [self.emailtotftext isEqualToString:@""])
    {
        [self showAlertMessage:@"The email id is not found."];
        
    }
    else if([self validEmail: self.emailtotftext ])//[self validEmail: self.emailtotf.text ]
    {
        
        /////////   AD 24th june FR    /////
        
        
        self.addAFriendVC.sendEmailId=self.emailtotftext;//self.emailtotf.text;
        self.addAFriendVC.sendEmailName=self.emailName;
        NSLog(@"addAFriendVC.sendEmailId=%@",self.addAFriendVC.sendEmailId);
        [self.addAFriendVC resetData];
        //[self.addAFriendVC.tbllView reloadData];
        //[self.navigationController pushViewController:self.addAFriendVC animated:YES];
        
        if(self.addAFriendVC.JSONDATAarr.count==1)
            [self showAddAFriendNative:0];
        else
            [self showAddAFriendNative:1];
        
        
           // if(self.addAFriendVC.JSONDATAarr && self.addAFriendVC.JSONDATAarr.count>0) ///AD FR
           /* if(self.appDelegate.JSONDATAarr && self.appDelegate.JSONDATAarr.count>0)
            {
                
                self.addAFriendVC.sendEmailId=self.emailtotftext;//self.emailtotf.text;
                self.addAFriendVC.sendEmailName=self.emailName;
                NSLog(@"addAFriendVC.sendEmailId=%@",self.addAFriendVC.sendEmailId);
                [self.addAFriendVC resetData];
                //[self.addAFriendVC.tbllView reloadData];
                //[self.navigationController pushViewController:self.addAFriendVC animated:YES];
                
                 if(self.addAFriendVC.JSONDATAarr.count==1)
                     [self showAddAFriendNative:0];
                 else
                     [self showAddAFriendNative:1];
                
            }
            else
            {
                [self showAlertMessage:@"No Team Found."];
            }
        */
        
        
        ////////////////
     
        return 1;
    }
    else
    {
        [self showAlertMessage:@"The email id is invalid."];
        
    }
    
    return 0;
    
}




-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag!=10)
    {
    if(buttonIndex==1)
    {
        
        if(self.addAFriendVC.JSONDATAarr && self.addAFriendVC.JSONDATAarr.count>0)
        {
        
        self.addAFriendVC.sendEmailId=self.emailtotftext;//self.emailtotf.text;
          self.addAFriendVC.sendEmailName=self.emailName;
        NSLog(@"addAFriendVC.sendEmailId=%@",self.addAFriendVC.sendEmailId);
       // [self.addAFriendVC resetData];
        //[self.addAFriendVC.tbllView reloadData];
        //[self.navigationController pushViewController:self.addAFriendVC animated:YES];
            
            if(self.addAFriendVC.JSONDATAarr.count==1)
                [self showAddAFriendNative:0];
            else
                [self showAddAFriendNative:1];
        }
        else
        {
            [self showAlertMessage:@"No Team Found."];
        }
    }
    }
    else
    {
        [self.addAFriendVC hideHudViewHere ];
    }
    
    
}


-(void)showAddAFriendNative:(BOOL)isShow
{
    if(![self.addAFriendVC.sendEmailName isEqualToString:@""])
        self.addAFriendVC.toolbartitle.text=[[NSString alloc] initWithFormat:@"Select team below to invite %@",self.emailtotftext];
    else
        self.addAFriendVC.toolbartitle.text=[[NSString alloc] initWithFormat:@"Select team below to invite %@",self.emailtotftext];
    

    //if(self.teamNames.count>1)
       // [ [self custompopuplabInvite] setText:[NSString stringWithFormat:@"Invite %@ (%@) to All Teams?",self.emailName,self.emailtotftext]];
//    else
//    {
    
        if ([self.emailName isEqualToString:@""]) {
            [[self custompopuplabInvite] setText:[NSString stringWithFormat:@"Invite %@ %@ to %@?",self.emailName,self.emailtotftext,self.teamName]];
        }
        else
            [[self custompopuplabInvite] setText:[NSString stringWithFormat:@"Invite %@ (%@) to %@?",self.emailName,self.emailtotftext,self.teamName]];  // 21/7/14
   // }
    [self showAlertViewCustomInvite:@"Friend invite has been sent" ];
    
    [self hideAddAFriendNative];
    
    
    
   /*
    if(isShow)
    {
        self.pickertop.hidden=NO;
        [self.view bringSubviewToFront:self.addAFriendVC.view];
        self.addAFriendVC.view.hidden=NO;
    }
    else
    {
        */
        
        
        
        self.pickertop.hidden=YES;
        self.addAFriendVC.view.hidden=YES;
        [self.addAFriendVC doneTapped:nil];
  //  }
    
  
    
   
   
    
    
    
}

-(void)showAlertViewCustom:(NSString*)labText
{
    self.custompopuplab.text=labText;
    self.popupalertvw.hidden=NO;
    self.popupalertvwback.hidden=NO;
    [self.view bringSubviewToFront:self.popupalertvwback];
     [self.view bringSubviewToFront:self.popupalertvw];
    
}

-(void)showAlertViewCustomInvite:(NSString*)labText
{
    //self.custompopuplab.text=labText;
    //self.popupalertvw.hidden=NO;
    self.popupalertvwback.hidden=NO;
    self.popupAlertVwInvite.hidden=NO;
    
    [self.view bringSubviewToFront:self.popupalertvwback];
    [self.view bringSubviewToFront:self.popupAlertVwInvite];
}

- (IBAction)cancelPopup:(id)sender {
    self.popupalertvw.hidden=YES;
    self.popupalertvwback.hidden=YES;
    self.popupAlertVwInvite.hidden=YES;
    //[self.addAFriendVC hideHudViewHere];
}

- (IBAction)popuptappedInvite:(id)sender {
    
    self.popupalertvw.hidden=YES;
    self.popupalertvwback.hidden=YES;
    self.popupAlertVwInvite.hidden=YES;
    if(![self validEmail:emailtotftext] || [emailtotftext length]==0)
    {
        [self showAlertViewCustom:@"Please enter a valid Email Id"];
        return;
    }

   // [self.navigationController popViewControllerAnimated:NO];
    
    [self sendToServer]; // 21/7/14    //////  AD 24th june FR
    
   // [self.addAFriendVC hideHudViewHere ];
}


/////////  AD 24th june  For Friend Request  /////////

-(void)sendToServer
{
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"user_id"];
    
    NSLog(@"addAFriendVC.sendEmailId22=%@",self.emailtotftext);
    [command setObject:self.emailtotftext forKey:@"email_id"];
    
    
    
    [command setObject:@"" forKey:@"text"];
    
     NSMutableArray *ar=[NSMutableArray arrayWithObject:self.selectedTeamId];
    
    [command setObject:ar forKey:@"team_id"];
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    
    
    self.requestDic=command;
    [appDelegate sendRequestFor:INVITEFRIENDS from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
}




-(void)notifyRequesterWithData:(id) aData :(id)aData1
{
    
    [self hideHudView];
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
//                if(self.teamIds.count==1 && self.teamNames.count==1)
//                {
                    if(![[aDict objectForKey:@"invite_send"] isEqualToString:@""])
                    {
                        if([self.emailName isEqualToString:@""])
                        {
                            [self showAlertViewCustom:[NSString stringWithFormat:@"%@ is invited to %@",self.emailtotftext,self.teamName]];
                        }
                        else
                            [self showAlertViewCustom:[NSString stringWithFormat:@"%@ is invited to %@",self.emailName,self.teamName]];
                        
                    }
                    else if(![[aDict objectForKey:@"invite_not_send"] isEqualToString:@""])
                    {
                        
                        //[ [self.selectContact custompopuplab] setText:[NSString stringWithFormat:@"%@ already got an invite for %@",self.sendEmailId,[self.teamNames objectAtIndex:0] ]];
                        //[ self.selectContact showAlertForNotSending:[NSString stringWithFormat:@"Friend invite not sent. %@ is either part of %@ or received an invite from %@",self.sendEmailId,[self.teamNames objectAtIndex:0],[self.teamNames objectAtIndex:0]]];
                        [ self showAlertForNotSending:[NSString stringWithFormat:@"%@ has already received an invite from this team. He can view %@ timeline",self.emailtotftext,self.teamName]];
                        
                        
                        
                        
                    }
                    else
                    {
                        [self hideHudViewHere];
                    }
                /*}
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
                */
                
                
                // [self.selectContact showAlertViewCustom:@"Friend invite has been sent" ]; // 21/7/14
                // [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
                self.requestDic=nil;
                
            //    [self requestServerData];  //Ch For Facebook//remove
                
            }
            else
            {
                [self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
            }
        }
    }
    
    
}

-(void)hideHudViewHere
{
    [self hideHudView];
    
    [self resetInHide];
    [self hideAddAFriendNative];
    
}

////////////////////////////////////////

-(void)showAlertForNotSending:(NSString*)msg
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:PRODUCT_NAME message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    alert.tag=10;
    [alert show];
}

- (IBAction)popuptapped:(id)sender
{
    isBack=YES;
    self.popupalertvw.hidden=YES;
    self.popupalertvwback.hidden=YES;
    //[self.addAFriendVC sendToServer]; // 21/7/14
    [self.addAFriendVC hideHudViewHere ];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)hideAddAFriendNative
{
      self.pickertop.hidden=YES;
     self.addAFriendVC.view.hidden=YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
    
   /*int m= [self showAddAFriend];
    
  
    if(m)
    {
        [self.emailtotf resignFirstResponder];
        [self enableSlidingAndShowTopBar];
        self.cancelSearch.hidden=YES;
        isCancelTappable=0;
        return YES;
    }
    else
    {
        return NO;
    }*/
}


/*- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if([textField isEqual:self.emailtotf])
    {
           self.emailtotftext=self.emailtotf.text;
        self.emailName=@"";
    }
    
    
    return YES;
    
}*/
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if([textField isEqual:self.emailtotf])
    {
          self.emailtotftext=self.emailtotf.text;
        self.emailName=@"";
    }
    
      return YES;
}
/*- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([textField isEqual:self.emailtotf])
    {
        NSString *totalText=[[NSString alloc] initWithFormat:@"%@%@", self.emailtotf.text,string ];
        
        if(![totalText isEqualToString: self.emailtotf.text])
        self.emailtotftext=totalText;
        else
          self.emailtotftext=self.emailtotf.text;
        
        totalText=nil;
        self.emailName=@"";
    }
    
    
      return YES;
}*/


#pragma mark - TExtFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if([textField isEqual:self.emailtotf])
    {
        self.emailtotftext=self.emailtotf.text;
        self.emailName=@"";
    }
    if (textField==self.fName || textField==self.lName) {
        if (self.emailtotf.text.length==0) {
            // self.isValidEmailCheck=0;
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Please enter your Email id" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
            //[cell.addMinEmailText becomeFirstResponder];
        }
        else if ([self validEmail:self.emailtotf.text]) {
            if (self.fName.text.length==0) {
                [self getFullName:textField.text];
            }
            
            
        }
        else{
            //self.isValidEmailCheck=0;
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"The email id is invalid" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
            
        }
    }
    
   /* if (textField==self.adminTypeText) {
        self.viewPickerContainer.hidden=NO;
        return NO;
    }*/
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==self.emailtotf) {
        
        if ([self validEmail:textField.text]) {
            
            [self getFullName:textField.text];
            
        }else{
            if (isBack==NO) {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"The email id is invalid" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                [alert show];
                
                [textField becomeFirstResponder];
            }
            
        }
        
    }
    
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}
- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([theTextField isEqual:self.emailtotf])
    {
        NSString *totalText=[[NSString alloc] initWithFormat:@"%@%@", self.emailtotf.text,string ];
        
        if(![totalText isEqualToString: self.emailtotf.text])
            self.emailtotftext=totalText;
        else
            self.emailtotftext=self.emailtotf.text;
        
        totalText=nil;
        self.emailName=@"";
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    int tag=[theTextField tag];
    
    if (tag==1002 ) {
        
        if (theTextField.text.length<=15) {
            
            NSCharacterSet *cs=[[NSCharacterSet characterSetWithCharactersInString:VALIDPHONENUMBER] invertedSet];
            NSString *filterString=[[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
            return [string isEqualToString:filterString];
            
        }else{
            return NO;
        }
        
    }
    
    
    if (theTextField==self.fName || theTextField==self.lName ) {
        
        if (theTextField.text.length<=15) {
            NSString *resultingString = [theTextField.text stringByReplacingCharactersInRange: range withString: string];
            NSCharacterSet *whitespaceSet = [NSCharacterSet whitespaceCharacterSet];
            if  ([resultingString rangeOfCharacterFromSet:whitespaceSet].location == NSNotFound)
            {
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




-(void)populateField:(ContactsUser*)contact
{
   
    NSLog(@"selectedContact=%@",contact);
    self.emailtotftext=@"";
    self.emailtotf.text=@"";
    self.emailtotf.text=contact.email;
    self.emailtotftext=contact.email;
    self.emailName=contact.contactName;
    
}

-(void)resetData
{
    isSearchOn=NO;
    isCancelTappable=NO;
    canSelectRow=YES;
    [cancelSearch setHidden:YES];
    isShowCancel=0;
    self.fetchSearchResultsController=nil;
    self.fetchedResultsController=nil;
   // [tabView reloadData];
    mysearch.text=@"";
    
   //////////////
    
  
    self.searchString=@"";
    //self.selectedTeamId=@"";
    currentmode=1;
    
   
        self.suggestLabel.hidden=NO;
    self.emailtotf.hidden=YES;
    self.mysearch.hidden=YES;
    self.searchbarbackgrndimgvw.hidden=YES;
    ////////////
   
 //   [self requestServerData]; //Ch For Facebook//remove
    
    
}


-(void)setSelectedItem:(int)num
{
    if(num==0)
    {
        self.suggestionslab.font=self.helveticaFontBold;
        self.searchlab.font=self.helveticaFont;
        self.contactslab.font=self.helveticaFont;
        self.emaillab.font=self.helveticaFont;
        
        self.suggestionslab.textColor=appDelegate.themeCyanColor;
        self.searchlab.textColor=self.darkgraycolor;
        self.contactslab.textColor=self.darkgraycolor;
        self.emaillab.textColor=self.darkgraycolor;
        
        [self.suggestioncenterbt setImage:self.suggestionimagered forState:UIControlStateNormal];
        [self.searchcenterbt setImage:self.searchimagegrey forState:UIControlStateNormal];
        [self.contactscenterbt setImage:self.contactsimagegrey forState:UIControlStateNormal];
        [self.emailcenterbt setImage:self.emailimagegrey forState:UIControlStateNormal];
    }
    else if(num==1)
    {
        self.searchlab.font=self.helveticaFontBold;
        self.suggestionslab.font=self.helveticaFont;
        self.contactslab.font=self.helveticaFont;
        self.emaillab.font=self.helveticaFont;
        
        self.suggestionslab.textColor=self.darkgraycolor;
        self.searchlab.textColor=appDelegate.themeCyanColor;
        self.contactslab.textColor=self.darkgraycolor;
        self.emaillab.textColor=self.darkgraycolor;
        
         [self.searchcenterbt setImage:self.searchimagered forState:UIControlStateNormal];
        [self.suggestioncenterbt setImage:self.suggestionimagegrey forState:UIControlStateNormal];
        [self.contactscenterbt setImage:self.contactsimagegrey forState:UIControlStateNormal];
        [self.emailcenterbt setImage:self.emailimagegrey forState:UIControlStateNormal];
    }
    else if(num==2)
    {
        /*self.contactslab.font=self.helveticaFontBold;
        self.suggestionslab.font=self.helveticaFont;
        self.searchlab.font=self.helveticaFont;
        self.emaillab.font=self.helveticaFont;
        
        self.suggestionslab.textColor=self.darkgraycolor;
        self.searchlab.textColor=self.darkgraycolor;
        self.contactslab.textColor=appDelegate.cellRedColor;
        self.emaillab.textColor=self.darkgraycolor;
        
         [self.contactscenterbt setImage:self.contactsimagered forState:UIControlStateNormal];
        [self.suggestioncenterbt setImage:self.suggestionimagegrey forState:UIControlStateNormal];
        [self.searchcenterbt setImage:self.searchimagegrey forState:UIControlStateNormal];
        [self.emailcenterbt setImage:self.emailimagegrey forState:UIControlStateNormal];*/
    }
    else if(num==3)
    {
        self.emaillab.font=self.helveticaFontBold;
        self.suggestionslab.font=self.helveticaFont;
        self.searchlab.font=self.helveticaFont;
        self.contactslab.font=self.helveticaFont;
        
        self.suggestionslab.textColor=self.darkgraycolor;
        self.searchlab.textColor=self.darkgraycolor;
        self.contactslab.textColor=self.darkgraycolor;
        self.emaillab.textColor=appDelegate.themeCyanColor;
        
         [self.emailcenterbt setImage:self.emailimagered forState:UIControlStateNormal];
        [self.suggestioncenterbt setImage:self.suggestionimagegrey forState:UIControlStateNormal];
        [self.contactscenterbt setImage:self.contactsimagegrey forState:UIControlStateNormal];
        [self.searchcenterbt setImage:self.searchimagegrey forState:UIControlStateNormal];
    }
    
}


-(void)requestServerDataSearch
{
    [self setSelectedItem:1];
    
    
    
    self.isFinishData=0;
    self.start=0;
    
    if( self.dataAllArray.count>0)
        [ self.tabView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    
    [self.dataAllArray removeAllObjects];
    [self.tabView reloadData];
    [self showHudView:@"Connecting..."];
    [self performSelector:@selector(getUserListings) withObject:nil afterDelay:0.0];
}




-(void)requestServerData
{
    [self setSelectedItem:0];
    
    
    
    self.isFinishData=0;
    self.start=0;
    
    if( self.dataAllArray.count>0)
        [ self.tabView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
 
        [self.dataAllArray removeAllObjects];
    [self.tabView reloadData];
    [self showHudView:@"Connecting..."];
    [self performSelector:@selector(getUserListings) withObject:nil afterDelay:0.0];
}

-(void)getUserListings
{
  NSString *startstr=  [NSString stringWithFormat:@"%lli",self.start] ;
 NSString *limitstr=    [NSString stringWithFormat:@"%lli",self.limit]
    ;
    
    
    if(![self.searchString isEqualToString:@""])
        [self getUserListing:self.selectedTeamId :self.searchString :limitstr :startstr :0];
    else
        [self getUserListing:self.selectedTeamId :self.searchString :limitstr :startstr :self.currentmode];
}

-(void)userListUpdated:(id)sender
{
      [self hideHudView];
    
     
    /*[super userListUpdated:sender];
    
    self.fetchedResultsController=nil;
   [self.tabView reloadData];
    
    if(  [[self.fetchedResultsController fetchedObjects] count]==0)
    {
        [self showHudAlert:@"No Results Found"];
        [self performSelector:@selector(hideHudViewHereFinished) withObject:nil afterDelay:2.0];
        
    }*/
   /* self.wallfootervwgreydot.hidden=NO;
    [self.wallfootervwactivind stopAnimating];*/
    
  
    
    
    SingleRequest *sReq=(SingleRequest*)[sender object];
    if([sReq.notificationName isEqualToString:USERLISTING])
    {
        if(sReq.responseData)
        {
            
            if (sReq.responseString)
            {
                [self hideHudView];
                   NSLog(@"PushByInviteFriendresponseString=%@",sReq.responseString);
                
                
                SBJsonParser *parser=[[SBJsonParser alloc] init];
                
                id res = [parser objectWithString:sReq.responseString];
                if ([res isKindOfClass:[NSDictionary class]])
                {
                    NSDictionary* aDict = (NSDictionary*) res;
                    
                    
                    if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
                    {
                       
                        
                        NSDictionary *aDic1=[aDict objectForKey:@"response"];
                        NSArray *userList=[aDic1 objectForKey:@"user_list"];
                        
                        [self storeUsers:userList];
                        
                       self.start+=self.limit;
                        
                    }
                    else
                    {
                       if(self.start!=0)
                         self.isFinishData=1;
                    }
                    
                }
                
            }
        }
        else
        {
             if(self.start!=0)
              self.isFinishData=1;
            
        }
    }
    else
    {
         if(self.start!=0)
          self.isFinishData=1;
    }
    
    
    if(  [self.dataAllArray count]==0)
    {
        //[self showHudAlert:@"Use your contacts or email friends"];// to invite them to join your wall
        
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode=MBProgressHUDModeText;
        hud.labelText =@"Use your contacts";
        hud.detailsLabelText =@"or email friends";
        
        hud.detailsLabelFont=hud.labelFont;
       // [self.view bringSubviewToFront:hud];   //// AD 30th
        
        
        
        [self performSelector:@selector(hideHudViewHereFinished) withObject:nil afterDelay:2.0];
        //[self showAlertMessage:@"Use your contacts or email friends to invite them to join your wall" title:@""];
    }
    else
    {
        [self hideHudView];
        [self.tabView reloadData];
    }

}


-(void)storeUsers:(NSArray*)userarray
{
    
    
    if(self.start==0)
    [self.dataAllArray removeAllObjects];
    
    
    for(NSDictionary *dic in userarray)
    {
        
        if(![[dic objectForKey:@"UserID"] isEqualToString:[appDelegate.aDef objectForKey:LoggedUserID]])
        {
            
            
            NSString *userid=[dic objectForKey:@"UserID"];
           
            
             
                
                
                
                ContactsUser *aContact=  [[ContactsUser alloc] init];
                
                
                NSString *name=[dic objectForKey:@"Name"];//[NSString stringWithFormat:@"%@ %@", [dic objectForKey:@"FirstName"] ,[dic objectForKey:@"LastName"]];
                
                aContact.contactName=name;
                aContact.email=[dic objectForKey:@"Email"];
                char ch;
                if (name.length > 0)
                {
                    
                    ch = [name characterAtIndex:0];
                    
                    
                    
                }
                else
                {
                    ch = [aContact.email characterAtIndex:0];
                }
                NSString* fc = [[NSString stringWithFormat:@"%c",ch] uppercaseString];
                
                aContact.cFirstChar=fc;
                
                aContact.userId=userid;
                aContact.profileImage=[NSString stringWithFormat:@"%@%@",IMAGELINKTHUMB,[dic objectForKey:PROFILEIMAGE]];
            
                aContact.profileImageInfo=[[ImageInfo alloc] initWithSourceURL:[[NSURL alloc] initWithString:aContact.profileImage]];
            
            
            [self.dataAllArray addObject:aContact];
            
        }
    }

    
}




-(void)hideHudViewHereFinished
{
  
    
    [self hideHudView];
}

-(void)setLayOutForLanguage
{
    [self.backb setTitle:@"" forState:UIControlStateNormal];
   
     [self.cancelSearch setTitle:@"Cancel" forState:UIControlStateNormal ];
    [self.addb setTitle:@"Done" forState:UIControlStateNormal];
    self.headerl.text=@"Select Friend";
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar 
{
    self.searchString=@"";
    isSearchOn = YES;
    canSelectRow = NO; 
    self.tabView.scrollEnabled = NO;
  
     mysearch.showsCancelButton=YES;
      
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if ([searchText length] > 0)
    {
       
        canSelectRow = NO; 
        self.tabView.scrollEnabled = YES; 
        [self searchMoviesTableView];
       
    }
    else
    {
       
        canSelectRow = NO; 
        self.tabView.scrollEnabled = NO;
    }
    
       self.searchString=searchText;
    
}


- (void) searchMoviesTableView 
{ //---clears the search result--- 
   
   
   
    self.fetchedResultsController=nil;
     self.fetchSearchResultsController=nil;
    // [self.tabView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
 backb.hidden=NO;
    mysearch.showsCancelButton=NO;
    isSearchOn=NO;
    canSelectRow=YES;
    self.tabView.scrollEnabled=YES;
   
    [mysearch resignFirstResponder];
     [self enableSlidingAndShowTopBar];
    [cancelSearch setHidden:YES];
    isShowCancel=0;
     mysearch.text=@"";
    if([addb isHidden])
    {
        [addb setHidden:NO];
        self.fetchSearchResultsController=nil;
    }
    self.fetchSearchResultsController=nil;
    self.fetchedResultsController=nil;
   // [tabView reloadData];
    if([tabView isEditing])
    {
    if([alldeleteb isHidden])
    {
        [alldeleteb setHidden:NO];
       
    }
    }
    
    
     self.searchString=@"";
    
}

-(IBAction) cancelSearch:(id)sender
{
    if(isCancelTappable)
    {
        isSearchOn=NO;
        
        isCancelTappable=NO;
         
         [cancelSearch setHidden:YES];
        isShowCancel=0;
      
        self.fetchSearchResultsController=nil;
         self.fetchedResultsController=nil;
      //  [tabView reloadData];
        if([tabView isEditing])
          [alldeleteb setHidden:NO];
        [tabView reloadData];
        mysearch.text=@"";
      
    }
    
    
    
    [self.emailtotf resignFirstResponder];
    self.emailtotf.hidden=YES;
    self.mysearch.hidden=YES;//Ch For Facebook
     self.searchbarbackgrndimgvw.hidden=YES;
    [self.mysearch resignFirstResponder];//Ch For Facebook//Add
    
    [self enableSlidingAndShowTopBar];
     self.searchString=@"";
    
  
  //  [self requestServerData];//Ch For Facebook//remove
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchMoviesTableView];
    isCancelTappable=YES;
    canSelectRow=YES;
    self.tabView.scrollEnabled=YES;
    [self.tabView reloadData];
    [mysearch resignFirstResponder];
     [self enableSlidingAndShowTopBar];
    [cancelSearch setHidden:YES];//Ch For Facebook//ch
     isShowCancel=1;
    mysearch.showsCancelButton=NO;
 
     mysearch.text=@"";
     backb.hidden=YES;
    
     /*self.isFinishData=0;
    self.start=0;
    [self showHudView:@"Connecting..."];
    [self performSelector:@selector(getUserListings) withObject:nil afterDelay:0.0];*/
    [self requestServerDataSearch];
  
}


-(IBAction)btapped:(id)sender
{
    int tag=[sender tag];
    
    if(tag==1)
    {
       /* AddContactVC *mvc =[[AddContactVC alloc] initWithNibName:@"AddContactVC" bundle:nil];
        mvc.isEditMode=0;*/
        /*if([contacts count]>0)
        {
        
        for(Contacts *con in contacts)
        {
            [mygroup addConnectsObject:con];
            [con addBelongstoObject:mygroup];
        }
        
            mygroup.date=[NSDate date];
        
        }*/
     //change   [self.phvc populateField:contacts];
        isBack=YES;
        [self.navigationController popViewControllerAnimated:YES];
        
     //   [mvc release];
    }
    else if(tag==0)
    {
        self.tabView.editing=YES;
        doneb.hidden=NO;
        
        if(!isSearchOn)
        alldeleteb.hidden=NO;
        else
          alldeleteb.hidden=YES;    
        addb.hidden=YES;
        deleteb.hidden=YES;
        cancelSearch.hidden=YES;
    }
     else if(tag==2)
     {
         Contacts *manObj;
         NSLog(@"Exist Object--%i",[alldelarr count]);
         for(manObj in alldelarr)
         {
             [appDelegate.managedObjectContext deleteObject:(NSManagedObject *)manObj];
         }
         [alldelarr removeAllObjects];
          [appDelegate saveContext];
     }
     else 
     {
       /* self.tabView.editing=NO; 
         doneb.hidden=YES;
         alldeleteb.hidden=YES;
         addb.hidden=NO;
         deleteb.hidden=NO;
         if(isShowCancel)
             cancelSearch.hidden=NO;
         
         //self.fetchedResultsController=nil;
        // self.fetchSearchResultsController=nil;
        // [tabView reloadData];
         if(isSearchOn)
             addb.hidden=YES;*/
      /*??   AddContactVC *mvc =[[AddContactVC alloc] initWithNibName:@"AddContactVC" bundle:nil];
         mvc.isEditMode=0;
         mvc.mygr=mygroup;
         mvc.fromgroup=1;//change 1 to 0
         [self.navigationController pushViewController:mvc animated:YES];
         
         [mvc release];*/
     }
}

/*-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return indexes;
}*/





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
 
    
   /* if(!isSearchOn)
    {
        NSLog(@"%i",[[self.fetchedResultsController sections] count]);
        int count=[[self.fetchedResultsController sections] count];
        self.indexes=[NSMutableArray array];
        
        for(int i=0;i<count;i++)
        {
            [indexes addObject:[[[fetchedResultsController sections] objectAtIndex:i] name]];
        }
       

        
        
    return [[self.fetchedResultsController sections] count];
    }
    else
    {
         NSLog(@"%i",[[self.fetchSearchResultsController sections] count]);
        int count=[[self.fetchSearchResultsController sections] count];
        self.indexes=[NSMutableArray array];
        
        for(int i=0;i<count;i++)
        {
            [indexes addObject:[[[fetchSearchResultsController sections] objectAtIndex:i] name]];
        }
    return [[self.fetchSearchResultsController sections] count];    
    }*/
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    /*id <NSFetchedResultsSectionInfo> sectionInfo;
    if(!isSearchOn)
    sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
   else
    sectionInfo = [[self.fetchSearchResultsController sections] objectAtIndex:section];
    
  
    return [sectionInfo numberOfObjects];*/
    
  return (self.dataAllArray.count+1);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==[self.dataAllArray count])
    {
        return self.wallfooterview.frame.size.height;
    }
    else
    {
        return 50;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
      static NSString *CellIdentifier = @"Cell";
    static NSString *CellIdentifier1 = @"Cell1";
    
    if(indexPath.row==[self.dataAllArray count])
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
            
            cell.backgroundColor=[UIColor clearColor];
            cell.selectionStyle=UITableViewCellSelectionStyleNone; 
        }
       
        
        if(!self.wallfooterview.superview)
        {
            [cell addSubview:self.wallfooterview];
        }
        
        if(tableView.contentSize.height>tableView.frame.size.height &&   self.isFinishData==0)
        {
            self.wallfootervwgreydot.hidden=YES;
            self.wallfootervwactivind.hidden=NO;
            [self.wallfootervwactivind startAnimating];
            [self performSelector:@selector(getUserListings) withObject:nil afterDelay:0.0];
        }
        else
        {
            self.wallfootervwactivind.hidden=YES;
            
            if(self.isFinishData==1)
            self.wallfootervwgreydot.hidden=NO;
            else
            self.wallfootervwgreydot.hidden=YES;
        }
        
        return cell;
        
    }
    else
    {
      
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        
        [self configureCell:cell atIndexPath:indexPath];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==[self.dataAllArray count])
    {
        return;
    }
    
    UITableViewCell *thisCell = [tableView cellForRowAtIndexPath:indexPath];
    
  
    
  
       
        
    if(!isSearchOn)
    {
   
        ContactsUser *aContact;
        aContact=[self.dataAllArray objectAtIndex:indexPath.row];
        
        
        if([mygroupContacts containsObject:aContact ])
        {
            [self showAlertMessage:@"This contact is already added in this group."];
            return;
        }
    
    
        
        UIImageView *aima=(UIImageView*)[thisCell.contentView viewWithTag:10];
        [aima removeFromSuperview];
        UIImageView *t=[[UIImageView alloc] initWithImage:self.tick];
        

        t.tag=10;
        t.frame=CGRectMake(15, 14, 17, 17);
      
        
        
        [self/*.phFriend*/ populateField:aContact];//Add Latest Ch
      
        [self showAddAFriend];
    }
    else
    {
        if(canSelectRow)
        {
           
            ContactsUser *aContact;
            aContact=[self.dataAllArray objectAtIndex:indexPath.row];
            
        
            if([mygroupContacts containsObject:aContact ])
            {
                [self showAlertMessage:@"This contact is already added in this group."];
                return;
            }
            
            UIImageView *aima=(UIImageView*)[thisCell.contentView viewWithTag:10];
            [aima removeFromSuperview];
                       UIImageView *t=[[UIImageView alloc] initWithImage:self.tick];
            t.tag=10;
            t.frame=CGRectMake(15, 14, 17, 17);
                      [self/*.phFriend*/ populateField:aContact];//Add Latest Ch
            
           
            [self showAddAFriend];
        }
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object for the given index path
       
        
        if(!isSearchOn)
        {
        [alldelarr removeObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        [appDelegate.managedObjectContext deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        }
        else
        {
            [alldelarr removeObject:[self.fetchSearchResultsController objectAtIndexPath:indexPath]];
            
            [appDelegate.managedObjectContext deleteObject:[self.fetchSearchResultsController objectAtIndexPath:indexPath]];
        }
        // Save the context.
        [appDelegate saveContext];
    }   
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
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
    
    
    
  
        return self.addAFriendVC.JSONDATAarr.count;
  
    
}
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    NSLog(@"Row=%i",row);
   
        return [[self.addAFriendVC.JSONDATAarr objectAtIndex:row] objectForKey:@"team_name"];
  
    
    
    // return [self.arrPickerItems5 objectAtIndex:row];
    
}



- (NSFetchedResultsController *)fetchSearchResultsController
{
    if (fetchSearchResultsController != nil) 
    {
        return fetchSearchResultsController;
    }
      
   /* NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:CONTACTS inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"contactName" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
   
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor,nil];
    NSPredicate *predicate;
    
    if(isGroup)
    {
        // [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"cMobile!=",self.mobile,nil ]];
        
        predicate =
        [NSPredicate predicateWithFormat:
         @"(contactName LIKE[cd] %@) OR (cMobile LIKE[cd] %@)",
         [NSString stringWithFormat:@"*%@*", mysearch.text],[NSString stringWithFormat:@"*%@*", mysearch.text]]; 
        
        
    
    }
    else
    {
        predicate =
        [NSPredicate predicateWithFormat:
         @"(contactName LIKE[cd] %@)",
         [NSString stringWithFormat:@"*%@*", mysearch.text]];   
    }
    
    
    
   
  
    
    [fetchRequest setPredicate:predicate];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"cFirstChar" cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchSearchResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchSearchResultsController performFetch:&error]) {
	   
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}*/
    
    return fetchSearchResultsController;
}    









- (NSFetchedResultsController *)fetchedResultsController
{
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
 
   /* NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:CONTACTS inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
 
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"contactName" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
  
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor,nil];

    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"cFirstChar" cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	   
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}*/
    
    return fetchedResultsController;
}    

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    /*UIView *cellview;
  
     cellview=[[UIView alloc] initWithFrame:CGRectMake(0,-1,320,22)];
 
  

    UILabel *header=[[UILabel alloc] initWithFrame:CGRectMake(5,0,50,21) ];
    header.font=font;
    header.textColor=appDelegate.cellRedColor;
    header.backgroundColor=[UIColor clearColor];
   
    id <NSFetchedResultsSectionInfo> sectionInfo;
    
    if(!isSearchOn)
    sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
    else
     sectionInfo = [[fetchSearchResultsController sections] objectAtIndex:section];
    
    
    header.text=[sectionInfo name];
     // [imaview addSubview:header];
    cellview.backgroundColor=appDelegate.barGrayColor;
      [cellview addSubview:header];
    return cellview;*/
    
    return nil;
}
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0;
}
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
   
    [self.tabView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tabView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tabView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tabView;
  
    switch(type) 
    {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
           // NSLog(@"Sec-%i Row-%i",indexPath.section,indexPath.row);
            
            if([controller isEqual:(NSFetchedResultsController *)fetchedResultsController])
            {
              //  NSLog(@"Search Con");
            }
            else
            {
               //  NSLog(@"Normal");
            }
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
         //   [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
             /* thisCell=[tableView cellForRowAtIndexPath:indexPath];
            if([thisCell.accessoryView isEqual:self.nontick])
            {
                thisCell.accessoryView=self.tick;
            }
            else
            {
               thisCell.accessoryView=self.nontick;  
            }*/
            
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
  
    [self.tabView endUpdates];
   
   // [self.tabView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   /*self.fetchedResultsController=nil;
    self.fetchSearchResultsController=nil;*/
    
    //[self resetInHide];//Ch For Facebook//remove
    
  
    
    
    self.addAFriendVC.selectContact=self.pushInviteFriendvc;
    
    if(self.addAFriendVC.view.superview)
        [self.addAFriendVC.view removeFromSuperview];
    [self.pushInviteFriendvc.view addSubview:self.addAFriendVC.view];
   // self.addAFriendVC.view.hidden=YES;
}

-(void)resetInHide
{
    self.selectedRow=0;
   // self.isFinishData=0;
   // self.searchString=@"";
    self.selectedTeamId=@"";
    currentmode=1;
   /* [self.dataAllArray removeAllObjects];
    [self.tabView reloadData];*/
    
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
  /*  self.fetchedResultsController=nil;
    self.fetchSearchResultsController=nil;*/
   //  self.mygroupContacts=[[mygroup connects] allObjects];
    
    
    
    self.addAFriendVC.selectContact=self;
    
    if(self.addAFriendVC.view.superview)
        [self.addAFriendVC.view removeFromSuperview];
    [self.view addSubview:self.addAFriendVC.view];
    //self.addAFriendVC.view.hidden=YES;
    
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    ContactsUser *cContact;
    	
    /*if(!isSearchOn)
      cContact = (Contacts *)[fetchedResultsController objectAtIndexPath:indexPath];
    else
      cContact = (Contacts *)[fetchSearchResultsController objectAtIndexPath:indexPath];   */
    
    
    cContact=[self.dataAllArray objectAtIndex:indexPath.row];
        
    [self.alldelarr addObject:cContact];
    
    UIView *cellview;
 
    if (self.isiPad) {
        cellview=[[UIView alloc] initWithFrame:CGRectMake(0,0,768,50)];
    }
    else
         cellview=[[UIView alloc] initWithFrame:CGRectMake(0,0,320,50)];
    

  
    
    cellview.backgroundColor=self.whitecolor;

    
    
    cell.backgroundView=cellview;
    
  
    
    NSArray *arr= [cell.contentView subviews];
    id lab;
    for(lab in arr)
    {
        [lab removeFromSuperview];
    }
    
  UIView *separator=[[UIView alloc] init];
    if (self.isiPad) {
        separator.frame=CGRectMake(0,49,768,1);
    }
    else
        separator.frame=CGRectMake(0,49,320,1);
    
    separator.backgroundColor=appDelegate.veryLightGrayColor;
    [cell.contentView addSubview:separator];
    UILabel *cname=[[UILabel alloc] init];
    if (self.isiPad) {
        cname.frame=CGRectMake(55,12, 600, 24);
    }
    else
        cname.frame=CGRectMake(55,12, 245, 24);
        
    cname.font=self.helveticaFontForte;
    cname.textColor=self.darkgraycolor;
    
    
 
    
    NSLog(@"indexPathCell===%i---%@----%@",indexPath.row,cContact.email,cContact.contactName);
    
    
    @autoreleasepool {
        
    
    if((![[cContact.contactName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]) && cContact.contactName)
    {
    cname.text=cContact.contactName;
    }
    else
    {
      cname.text=cContact.email;
    }
  
    }
    NSLog(@"CellText--%@",cname.text);
    
    cname.backgroundColor=[UIColor clearColor];
    
    
    
    
    
    
    
    
    
    
    [cell.contentView addSubview:cname];
    
    UIImageView *postima;
   postima=[[UIImageView alloc] init];
   
    postima.frame=CGRectMake(10,6,37,37);
    
    ImageInfo * info1 = cContact.profileImageInfo;
    [postima cleanPhotoFrame];
    
    if(info1.image)
    {
        [postima setImage:info1.image   ];
       
        [postima applyPhotoFrame];
    }
    else
    {
        postima.image=self.noImage;
        info1.notificationName=SELECTCONTACTIMAGELOADED;
        info1.notifiedObject=[NSNumber numberWithInt:indexPath.row];
        if(!info1.isProcessing)
            [info1 getImage];
    }
    
    
    [cell.contentView addSubview:postima];
    
    
    cell.textLabel.font=font;

    UIImageView *nont;

     if(![self.contacts containsObject:cContact])
    
        nont=[[UIImageView alloc] initWithImage:self.nontick]; 
    else
     nont=[[UIImageView alloc] initWithImage:self.tick];
  
    nont.tag=10;
    nont.frame=CGRectMake(15, 14, 17, 17);
   

  
}


-(IBAction)backf:(id)sender
{
  
      // [self.navigationController.view setHidden:YES];
    isBack=YES;
    [self resetInHide];
    
    
    /////////////
    if([self.mysearch becomeFirstResponder])
    {
    backb.hidden=NO;
    mysearch.showsCancelButton=NO;
    isSearchOn=NO;
    canSelectRow=YES;
    self.tabView.scrollEnabled=YES;
    
    [mysearch resignFirstResponder];
         [self enableSlidingAndShowTopBar];
    [cancelSearch setHidden:YES];
    isShowCancel=0;
    mysearch.text=@"";
    if([addb isHidden])
    {
        [addb setHidden:NO];
        self.fetchSearchResultsController=nil;
    }
    self.fetchSearchResultsController=nil;
    self.fetchedResultsController=nil;
    [tabView reloadData];
    if([tabView isEditing])
    {
        if([alldeleteb isHidden])
        {
            [alldeleteb setHidden:NO];
            
        }
    }
    }
    
    
    if([self.emailtotf becomeFirstResponder])
    {
        [self.emailtotf resignFirstResponder];
         [self enableSlidingAndShowTopBar];
       // self.emailtotf.hidden=YES;
       // self.mysearch.hidden=NO;
        self.cancelSearch.hidden=YES;
        isCancelTappable=0;
    }
    
    ////////////
     self.isFinishData=0;
     self.searchString=@"";
    
     [self.dataAllArray removeAllObjects];
     [self.tabView reloadData];
    
      [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)plusAction:(id)sender
{
    [self setSelectedItem:3];
    
    
     self.isFinishData=0;
    
    [self cancelSearch:nil];//Ch For Facebook//add
      self.suggestLabel.hidden=YES;//Ch For Facebook//add
    [self.dataAllArray removeAllObjects];
    
    [self.tabView reloadData];
    
   /* ABPeoplePickerNavigationController* contactPicker = [[ABPeoplePickerNavigationController alloc] init];
    contactPicker.peoplePickerDelegate = self;
    [self presentViewController:contactPicker animated:YES completion:^{
        
    }];
    
    contactPicker=nil;*/
    self.emailName=@"";
     self./*phFriend.*/emailtotftext=@"";
    self./*phFriend.*/emailtotf.text=@"";//Add Latest Ch
    //[self.navigationController pushViewController:self.phFriend animated:YES];
    [self.emailtotf becomeFirstResponder];
     [self disableSlidingAndHideTopBar];
    self.emailtotf.hidden=NO;
     self.searchbarbackgrndimgvw.hidden=NO;
   // self.mysearch.hidden=YES;//Ch For Facebook//remove
     [cancelSearch setHidden:YES];//Ch For Facebook//ch
    isCancelTappable=1;
    
    
}


- (void)displayPerson:(ABRecordRef)person{
    
   
    
    NSString* email = nil;
    ABMultiValueRef emailId = ABRecordCopyValue(person,
                                                kABPersonEmailProperty);
    
    
    
    if (ABMultiValueGetCount(emailId) > 0) {
        email = (__bridge  NSString*)
        ABMultiValueCopyValueAtIndex(emailId, 0);
        
        if(email)
            CFRelease((__bridge CFTypeRef)(email));
    } else {
        email =@"";
    }
    
    
    CFRelease(emailId);
    
    self.emailName=@"";
   self./*phFriend.*/emailtotftext=@"";
      self./*phFriend.*/emailtotf.text=@"";//Add Latest CH
    
    if (![email isEqualToString:@""])
    {
        self.emailName=@"";
      self./*phFriend.*/emailtotftext=email; //Add Latest CH
          self./*phFriend.*/emailtotf.text=email; //Add Latest CH
        [self.emailtotf becomeFirstResponder];
    }
    
  
   
   
}



- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissModal];
    
    //[self.appDelegate setHomeView];
    
   /* self.phFriend.emailtotf.text=@"";
    [self.navigationController pushViewController:self.phFriend animated:YES];*/
}


- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person{
     [self dismissModal];
    [self displayPerson:person];
   
    //[self.appDelegate setHomeView];
    
 //   [self.navigationController pushViewController:self.phFriend animated:YES];//Add Latest Ch
    
    
    
    
    
    
     [self showAddAFriend];
    return NO;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    
    return NO;
}





- (BOOL)isOdd:(int)no
{
    if(no%2==1)
        return YES;
    else
        return NO;
}

- (void)viewDidUnload
{
    [self setBesidesearchvw:nil];
    [self setBackf:nil];
    [self setShowAddressBook:nil];
    [self setCancelb:nil];
    [self setBackb:nil];
    [self setEmailtotf:nil];
    [self setPickertop:nil];
    [self setWallfooterview:nil];
    [self setWallfootervwgreydot:nil];
    [self setWallfootervwactivind:nil];
    [self setPickercontainer:nil];
    [self setPicker:nil];
   
    [self setSearchbottomvw:nil];
    [self setTopviewthird:nil];
   
    [self setSuggestLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)showAddressBookAction:(id)sender
{
    [self setSelectedItem:3];
    
    self.isFinishData=0;
    
    [self cancelSearch:nil];//Ch For Facebook//add
    self.suggestLabel.hidden=YES;//Ch For Facebook//add
    [self.dataAllArray removeAllObjects];
    
    [self.tabView reloadData];
    [self.emailtotf resignFirstResponder];//Ch For Facebook//remove
    [self.mysearch resignFirstResponder];//Ch For Facebook//remove
     [self enableSlidingAndShowTopBar];
   // [self disableSlidingAndHideTopBar];
    
    self.emailtotf.hidden=NO;
    self.searchbarbackgrndimgvw.hidden=NO;
    [cancelSearch setHidden:YES];//Ch For Facebook//ch
    isCancelTappable=1;
    
    
    ABPeoplePickerNavigationController* contactPicker = [[ABPeoplePickerNavigationController alloc] init];
    contactPicker.peoplePickerDelegate = self;
    
    self.isModallyPresentFromCenterVC=1;
    [self showModal:contactPicker];
    
    
    
    
    
    
    if(!appDelegate.isIos7)
    {
        contactPicker.navigationBar.tintColor=[UIColor colorWithRed:((float) 0.0 / 255.0f)
                                                                          green:((float) 154.0 / 255.0f)
                                                                           blue:((float) 215.0 / 255.0f)
                                                                          alpha:1.0f];
        contactPicker.navigationBar.translucent=NO;
    }
    else
    {
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:((float) 0.0 / 255.0f)
                                                                      green:((float) 154.0 / 255.0f)
                                                                       blue:((float) 215.0 / 255.0f)
                                                                      alpha:1.0f]];
        
        contactPicker.navigationBar.translucent=NO;
        
        if (self.isiPad) {
            [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:22.0]
                                                                   }];
        }
        else{
            [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:18.0]
                                                               }];
        }
    
        [contactPicker.navigationBar setTintColor:[UIColor whiteColor]];
        
    }
    contactPicker=nil;
}

////////// Arpita 17th april //////

#pragma  mark - ABpeoplepickerDelegate
/*- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}*/

// iOS 8

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier

{
    
    // [self peoplePickerNavigationController:peoplePicker shouldContinueAfterSelectingPerson:person];
    
    [self displayPerson:person];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}


// iOS 7
/*- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person{
    
    [self displayPerson:person];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    
    
    return NO;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    
    return NO;
}
*/



//////////////////////////////////

- (IBAction)cancelAction:(id)sender
{
    
    
}


- (IBAction)pickerAction:(id)sender
{
    
    int tag=[sender tag];
    
    if(tag==0)
    {
        //if(self.addAFriendVC.JSONDATAarr && self.addAFriendVC.JSONDATAarr.count>0) ////AD FR
        if(self.appDelegate.JSONDATAarr && self.appDelegate.JSONDATAarr.count>0)
        {
            
            self.pickercontainer.hidden=NO;
            self.picker.hidden=NO;
            [self.view bringSubviewToFront:self.pickertop];
            [self.view bringSubviewToFront:self.pickercontainer];
            self.pickertop.hidden=NO;
            [self.picker reloadAllComponents];
            [self.picker selectRow:self.selectedRow inComponent:0 animated:NO];
        }
        else
        {
            
            
            [self showAlertMessage:@"No Team Found."];
            //   change         [self showHudView:@"Fetching Team Listing..."];
            //            [self getTaemListing];
            
            
        }

    }
    else if(tag==1)
    {
        currentmode=0;
        
          [self requestServerData];
    }
    else if(tag==2)
    {
        self.pickercontainer.hidden=YES;
        self.pickertop.hidden=YES;
    }
    else if(tag==3)
    {
        self.pickercontainer.hidden=YES;
        self.pickertop.hidden=YES;
        
        self.selectedRow=self.currentrow;
        NSString *msg=  [[self.addAFriendVC.JSONDATAarr objectAtIndex:self.selectedRow] objectForKey:@"team_id"];
        
        self.selectedTeamId=msg;
        

        currentmode=1;
          [self requestServerData];
    }
    
    
    
}


- (IBAction)suggestAction:(id)sender
{
    
       self.searchString=@"";
    [self cancelSearch:nil];
     [self requestServerData];
    self.suggestLabel.hidden=NO;
    
}


- (IBAction)searchTopBtAction:(id)sender
{
    [self setSelectedItem:1];
    
    self.isFinishData=0;
    
       [self cancelSearch:nil];//Ch For Facebook//add
    
    [self.dataAllArray removeAllObjects];
    
    [self.tabView reloadData];
    
      self.suggestLabel.hidden=YES;
    self.emailName=@"";
    self./*phFriend.*/emailtotftext=@"";
    self./*phFriend.*/emailtotf.text=@"";//Add Latest Ch
  
    [self.mysearch becomeFirstResponder];
     [self disableSlidingAndHideTopBar];
 //   self.emailtotf.hidden=YES;//Ch For Facebook//remove
    self.mysearch.hidden=NO;
     self.searchbarbackgrndimgvw.hidden=NO;
    [cancelSearch setHidden:YES];//Ch For Facebook//ch
    isCancelTappable=1;

    
    
    
    
}
@end
