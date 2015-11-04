 //
//  TeamMaintenanceVC.m
//  Social
//
//  Created by Animesh@Mindpace on 09/09/13.
//
//
#import "HomeVC.h"
#import "CenterViewController.h"
#import "Reachability.h"
#import "TeamMaintenanceVC.h"
#import "TeamDetailsViewController.h"
#import "TeamListCell.h"
#import "SaveTeamViewController.h"
#import "InvitePlayerListViewController.h"
#import "PageControlExampleViewControl.h"
#import "AddAdminViewController.h"
#import "PlayerViewController.h"
#import "SpectatorViewController.h"
#import "SelectContact.h"
#import "AddmemberViewController.h"

@interface TeamMaintenanceVC ()

@end

@implementation TeamMaintenanceVC
@synthesize isShowFristTime;
@synthesize lastSelectedRow;
int row,mode;
@synthesize kNumberOfPages,scrollView,pageControl,pageControlUsed,lastSelectedTeam;
//////////////ADDARPI
@synthesize isShowFromNotification,teamIdForShowingNotification;
@synthesize whichSegmentTap,countAdmin;

@synthesize addAFriendVC,selContactNew,crossImage1;
@synthesize memberDetailDict;
/////////////

-(void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SHOWNAVIGATIONCONTROLLERTEAMMAINTANCE object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ALLREGISTEREDUSERS object:nil];
    [self setScrollBackView:nil];
    [super viewDidUnload];
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
    
    self.horidividervw.backgroundColor=[UIColor grayColor];
    self.horidividervw.hidden=YES;
    
    
    self.scrollBackView.backgroundColor=appDelegate.themeCyanColor;
    
    appDelegate.JSONDATAarr=nil;
    appDelegate.JSONDATAImages=nil;
    
    
    self.crossImage1=[UIImage imageNamed:@"LongPressdelete.png"];
    storeCreatedRequests=[[NSMutableArray alloc] init];
    self.view.userInteractionEnabled=YES;
    self.navigationController.delegate=self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNavigationControllerUpdated:) name:SHOWNAVIGATIONCONTROLLERTEAMMAINTANCE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchAllRegisteredUsers:) name:ALLREGISTEREDUSERS object:nil];
    
    [self loadTeamData];
    [self addPanGestureToView:nil];
    
   // [self showAllSporstlyUsers];
    //[self createTeamScroll];
   
}

- (void)addPanGestureToView:(UIView *)view
{
    /*UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(_handlePan:)];
     panGesture.delegate = self;
     panGesture.maximumNumberOfTouches = 1;
     panGesture.minimumNumberOfTouches = 1;
     [view addGestureRecognizer:panGesture];*/
    

    UISwipeGestureRecognizer *sgleft=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeDone)];
    sgleft.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:sgleft];
    
    
    UISwipeGestureRecognizer *sgright=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeDone)];
    sgright.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:sgright];
    
    sgright=nil;
    sgleft=nil;
}




-(void)setTopBarText
{
    if(self.navigationController.view.hidden==NO)//([appDelegate.centerViewController getShowStatus:self.navigationController])
    {
        if([[self.navigationController.viewControllers lastObject] isMemberOfClass:[self class]])
        {
            appDelegate.centerViewController.navigationItem.title=nil;
            appDelegate.centerViewController.navigationItem.titleView=nil;
            
            if(self.appDelegate.JSONDATAarr.count>0){
                appDelegate.centerViewController.navigationItem.title=[[self.appDelegate.JSONDATAarr objectAtIndex:lastSelectedTeam] objectForKey:@"team_name"];
            }else{
                appDelegate.centerViewController.navigationItem.title=PRODUCT_NAME;
                
            }
        }
    }
}





- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SHOWNAVIGATIONCONTROLLERTEAMMAINTANCE object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:ALLREGISTEREDUSERS object:nil];
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated;
{
    
}


-(void)showNavigationControllerUpdated:(id)sender
{
    
    if(self.navigationController.view.hidden==NO)
    {
        if([[self.navigationController.viewControllers lastObject] isMemberOfClass:[self class]])
        {
            [self showNavigationBarButtons];
            [self setTopBarText];
            
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
        self.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"wallleftslide.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleLeftPanel:)];
    }
    
    /////  change message to roster  18/02/2015 /////
   
   /* if(!self.rightBarButtonItem)
    {
        if (self.isiPad) {
            self.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"plus_icon_add_ipad.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleRightPanel:)];
        }
        else{
            self.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"plus_icon_add.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleRightPanel:)];
        }
    }
    else{*/
        if (self.isiPad) {
            self.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"plus_icon_add_ipad.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleRightPanel:)];
        }
        else{
            self.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"plus_icon_add.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleRightPanel:)];
        }
//    }
    
    appDelegate.centerViewController.navigationItem.title=nil;
    appDelegate.centerViewController.navigationItem.titleView=nil;
    
    
    appDelegate.centerViewController.navigationItem.leftBarButtonItem=self.leftBarButtonItem;
    appDelegate.centerViewController.navigationItem.rightBarButtonItem=self.rightBarButtonItem;
    
    
    /////////////
    
    if (self.isShowFristTime /*//////ADDDEB*/ || self.isShowFromNotification  /*////////*/) {
        
        int selectedIndex=0,flag=0;
        
        for (int i=0; i<self.appDelegate.JSONDATAarr.count; i++) {
            
            //////////////ADDDEB
            
            if(isShowFristTime)
            {
                ////////////////////
            if ([[[self.appDelegate.JSONDATAarr objectAtIndex:i] valueForKey:@"team_id"] isEqualToString:[self.appDelegate.centerVC.dataArrayUpButtonsIds objectAtIndex:self.appDelegate.centerVC.lastSelectedTeam]]) {
                flag=1;
                selectedIndex=i;
                //break;  ////  Ad 19th june
            }
                //////////////ADDDEB
            }
            if(isShowFromNotification)
            {
                if ([[[self.appDelegate.JSONDATAarr objectAtIndex:i] valueForKey:@"team_id"] isEqualToString:self.teamIdForShowingNotification]) {
                    flag=1;
                    selectedIndex=i;
                   // break;   ////  Ad 19th june
                }
            }
            
            ///////////////////
        }
        
        int page = selectedIndex;
        
        // page--;
        
        if(page>=0 && page< self.appDelegate.JSONDATAarr.count)
        {
            pageControl.currentPage=page;
            
            CGRect frame = scrollView.frame;
            frame.origin.x = frame.size.width * page;
            frame.origin.y = 0;
            pageControlUsed = YES;
            [scrollView scrollRectToVisible:frame animated:YES];
            
            
        }
        
        self.isShowFristTime=NO;

        //////////////ADDDEB
        self.isShowFromNotification=NO;
        self.teamIdForShowingNotification=nil;
        /////////////////
    }
    
   
    [self showRightButton:1];
    [self setStatusBarStyleOwnApp:1];
    
}


-(void)showRightButton:(BOOL)isShow
{
    if(self.navigationController.view.hidden==NO)
    {
        if([[self.navigationController.viewControllers lastObject] isMemberOfClass:[self class]])
        {
           
            
            if(isShow && [[self.teamNavController.viewControllers lastObject] isKindOfClass:[TeamDetailsViewController class]])
            {
                 appDelegate.centerViewController.navigationItem.rightBarButtonItem=self.rightBarButtonItem;
            }
            else if(isShow && (!self.teamNavController.view.superview))
            {
                appDelegate.centerViewController.navigationItem.rightBarButtonItem=self.rightBarButtonItem;
            }
            else
            {
               
                 //appDelegate.centerViewController.navigationItem.rightBarButtonItem=nil;   //// 14/01/2014
                
                 //self.rightBarButtonItem.image=[UIImage imageNamed:@""];
                //[self.rightBarButtonItem ];
               // self.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add_team-icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(showFriendList:)];
            }
        }
    }
}



-(void)toggleLeftPanel:(id)sender
{
    /////  change message to roster  18/02/2015 /////
    
    /*
    [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationController];
    
    self.appDelegate.centerViewController.timelineimavw.image=self.appDelegate.centerViewController.timelineimasel;
    self.appDelegate.centerViewController.fsttablab.textColor=self.appDelegate.themeCyanColor;
     
     */
    
    [self.view endEditing:YES];
    [appDelegate.slidePanelController showLeftPanelAnimated:YES];

    //////////////////

}


-(void)toggleRightPanel:(id)sender
{
    if (self.whichSegmentTap==0) {
        [self AddTeam:sender];
    }
    else{
        if (self.whichSegmentTap==2){
            if(self.countAdmin>1)
            {
                // “Only two Admin per team
                
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Sorry, only two admin allowed per team" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
        }
        AddmemberViewController *member=[[AddmemberViewController alloc] initWithNibName:@"AddmemberViewController" bundle:nil];
        //player.selectedTeamIndex=self.lastSelectedTeam;
        // player.playerMode=0;
        // [self.navigationController pushViewController:player animated:YES];
        [self.appDelegate.centerViewController presentViewControllerForModal:member];
        
    }
    
    
}

////  AD july For Member

-(void)selectProperClassForSegmentTap:(NSMutableDictionary *)dictMember
{
    
    UIButton * sender=nil;
    self.memberDetailDict=dictMember;
    
    if (self.whichSegmentTap==1)
    {
        [self addPlayer:sender];
        
    }
    else if (self.whichSegmentTap==2)
    {
        [self addAdmin:sender];
        
    }
    else if (self.whichSegmentTap==3)
    {
        [self addSpectator:sender];
        
    }

}


-(void)setSegmentIndex:(int)segIndx adminCount:(int)adminCount isAdmin:(BOOL)isadmin{
    
    if(self.navigationController.view.hidden==NO)
    {
        if([[self.navigationController.viewControllers lastObject] isMemberOfClass:[self class]])
        {
            if (isadmin==YES)
            {
                appDelegate.centerViewController.navigationItem.rightBarButtonItem=self.rightBarButtonItem;
            }
            else
                appDelegate.centerViewController.navigationItem.rightBarButtonItem=nil;
        }
    }
    self.whichSegmentTap=segIndx;
    self.countAdmin=adminCount;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
   /* if (self.appDelegate.isTeamCreate) {
        
        [self performSelector:@selector(AddTeam:) withObject:nil afterDelay:0.1];
        self.appDelegate.isTeamCreate=NO;
    }
   */
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


-(void)checkNoteam{
    
    if((![appDelegate.aDef objectForKey:ISEXISTOWNTEAM]) && (appDelegate.centerVC.dataArrayUpButtonsIds.count==0) )
    {
        
        self.noTeamVw.hidden=NO;
        [self showRightButton:1];
        [self AddTeam:nil];

    }
}



-(void)loadTeamData
{

    
    if((!appDelegate.JSONDATAarr.count) || (!appDelegate.JSONDATAarr) || appDelegate.isTeamAccept==YES)
    {
        appDelegate.isTeamAccept=NO;
          int flag=1;
        
        if(flag)
        {
            mode=0;
            NSMutableDictionary *command = [NSMutableDictionary dictionary];
          //  [command setObject:[self.appDelegate.aDef objectForKey:LoggedUserID] forKey:@"coach_id"];
            [command setObject:[self.appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
            [command setObject:@"1" forKey:@"case"];
            SBJsonWriter *writer = [[SBJsonWriter alloc] init];
            NSString *jsonCommand = [writer stringWithObject:command];
            [self showNativeHudView];
            [self sendRequestForTeamData:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
        }
    }
    
}


-(void)sendRequestForTeamData:(NSDictionary*)dic
{
    
    NSURL* url = [NSURL URLWithString:TEAMROSTERLINK];

    //NSURL* url = [NSURL URLWithString:TEAM_LISTING_LINK];
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
    [self showAllSporstlyUsers];
    
    [self hideNativeHudView];
    NSString *str=[request responseString];
    
    NSLog(@"Data=%@",str);
    
    
    if(str)
        
    {
        SBJsonParser *parser=[[SBJsonParser alloc] init];
        
        id res = [parser objectWithString:str];
        if ([res isKindOfClass:[NSDictionary class]  ])
        {
            NSDictionary* aDict = (NSDictionary*) res;
            
                
                
            self.appDelegate.JSONDATAarr=[NSMutableArray arrayWithArray:[[[aDict objectForKey:@"response"] objectForKey:@"users_team"] objectForKey:@"team_list"]];
            
            
            // [self.appDelegate.centerVC.dataArrayUpButtonsIds objectAtIndex:self.appDelegate.centerVC.lastSelectedTeam];
            
            NSLog(@"user team list maintenance %@",self.appDelegate.JSONDATAarr);
            
            
            ////////////////////////////////////////
            
                NSMutableArray *marr=[[NSMutableArray alloc] init];
                self.appDelegate.JSONDATAImages=marr;
                for(NSDictionary *dic in  self.appDelegate.JSONDATAarr)
                {
                    ImageInfo *userImainfo=  [[ImageInfo alloc] initWithSourceURL:[NSURL URLWithString:[ NSString stringWithFormat:@"%@%@",TEAM_LOGO_URL,[dic objectForKey:@"team_logo"]]]];
                    [ self.appDelegate.JSONDATAImages addObject:userImainfo];
                    
                }
            
                
            if ([self.appDelegate.JSONDATAarr count]>0 || appDelegate.centerVC.dataArrayUpButtonsIds.count>0) {
                    
                self.noTeamVw.hidden=YES;
                    
                [appDelegate setUserDefaultValue:@"1" ForKey:ISEXISTOWNTEAM];
                [self createTeamScroll];
                
                
                if([self.teamNavController.view.superview isEqual:self.view])
                    [self.teamNavController.view removeFromSuperview];
                
                TeamDetailsViewController *addTeam=[[TeamDetailsViewController alloc]initWithNibName:@"TeamDetailsViewController" bundle:nil];
                addTeam.selectedTeamIndex=0;
                
                UINavigationController *aNav=[[UINavigationController alloc] initWithRootViewController:addTeam];
                
                self.teamNavController=aNav;
                aNav=nil;
                self.teamNavController.navigationBarHidden=YES;
                
                if (self.isiPad) {
                    self.teamNavController.view.frame=CGRectMake(0,54,768,(appDelegate.commonHeight - 54));

                }
                else{
                    if(appDelegate.isIphone5)
                        self.teamNavController.view.frame=CGRectMake(0,44,320,(appDelegate.commonHeight+ 88 - 44));
                    else
                        self.teamNavController.view.frame=CGRectMake(0,44,320,appDelegate.commonHeight - 44);
                }
                
                [self.view addSubview:self.teamNavController.view];
                [self.view bringSubviewToFront:self.teamNavController.view];
                    NSLog(@"frame %@ ",NSStringFromCGRect(self.teamNavController.view.bounds));
                [self upBtappedNew:self.buttonfirstinscroll.tag];
                
                
                 }else{
                     
                     self.noTeamVw.hidden=NO;
                     [self showRightButton:1];
                     if([appDelegate.aDef objectForKey:ISEXISTOWNTEAM])
                         [appDelegate removeUserDefaultValueForKey:ISEXISTOWNTEAM];
                     

                     [self AddTeam:nil];
                 }

            

        }else if ([res isKindOfClass:[NSArray class]  ]){
            
            self.noTeamVw.hidden=NO;
            [self showRightButton:1];
            
        }else{
            self.noTeamVw.hidden=NO;
            [self showRightButton:1];
            
        }
    }
}


- (void)requestFailed:(ASIHTTPRequest *)request
{
    [self hideNativeHudView];
	NSLog(@"Error receiving dataImage : %@ ",[request.error description]);
	//[self showAlertMessage:CONNFAILMSG];ChAfter
    
}

#pragma GetAll User List ---

#pragma mark - Fetch All Registered Users of Sporstly

- (void)showAllSporstlyUsers
{
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    NSMutableDictionary *command1 = [[NSMutableDictionary alloc] init];
    [command1 setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
    
    NSString *jsonCommand = [writer stringWithObject:command1];
    
    
    SingleRequest *sinReq = [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:ALLREGISTEREDUSERLISTLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
    self.sinReq4 = sinReq;
    sinReq.notificationName = ALLREGISTEREDUSERS;
    [sinReq startRequest];
}

- (void)fetchAllRegisteredUsers:(id)sender
{
    SingleRequest *sReq = (SingleRequest *)[sender object];
    
    NSLog(@"ALL REGISTERED USER LISTING :: %@",sReq.responseString);
    
    if([sReq.notificationName isEqualToString:ALLREGISTEREDUSERS])
    {
        if(sReq.responseData)
        {
            
            if (sReq.responseString)
            {
                SBJsonParser *parser = [[SBJsonParser alloc] init];
                
                id res = [parser objectWithString:sReq.responseString];
                if ([res isKindOfClass:[NSArray class]])
                {
                    
                    self.appDelegate.JSONDATAMemberarr=[(NSMutableArray *) res mutableCopy];
                    //self.allRegUserArr = [(NSMutableArray *) res mutableCopy];
                    [self importUsersFromContacts];
                    
                }
            }
        }
    }
}

#pragma mark - All Users from Contacts

- (void)importUsersFromContacts
{
    CFErrorRef *error = nil;
    
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
    
    __block BOOL accessGranted = NO;
    if (&ABAddressBookRequestAccessWithCompletion != NULL)
    { // we're on iOS 6
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
    }
    else
    { // we're on iOS 5 or older
        accessGranted = YES;
    }
    
    if (accessGranted)
    {
        
#ifdef DEBUG
        NSLog(@"Fetching contact info ----> ");
#endif
        
        CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
        CFIndex nPeople = ABAddressBookGetPersonCount(addressBook);
        
        NSMutableArray *arrFriend = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < nPeople; i++)
        {
            
            ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
            
            //get First Name and Last Name
            
            NSString *firstName = @"";
            if (ABRecordCopyValue(person, kABPersonFirstNameProperty))
            {
                firstName = (__bridge NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
            }
            
            NSString *lastName  =  @"";
            if (ABRecordCopyValue(person, kABPersonFirstNameProperty))
            {
                lastName  =  (__bridge NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
            }
            else
            {
                continue;
            }
            
            NSString *fullName = @"";
            
            if(!firstName && !lastName)
            {
                continue;
            }
            
            if(!firstName && lastName)
            {
                fullName = lastName;
            }
            if(firstName && !lastName)
            {
                fullName = firstName;
            }
            if (firstName && lastName)
            {
                fullName = [firstName stringByAppendingFormat:@" %@",lastName];
            }
            
            
            // get contacts picture, if pic doesn't exists, show standard one
            
            NSData *imageData = (__bridge NSData *)ABPersonCopyImageData(person);
            UIImage *image  = [UIImage imageWithData:imageData];
            if (!image)
            {
                image = [UIImage imageNamed:@"profile_image.png"];
            }
            
            //get Contact email
            
            NSMutableArray *contactEmails = [NSMutableArray new];
            ABMultiValueRef multiEmails = ABRecordCopyValue(person, kABPersonEmailProperty);
            
            CFIndex emailCount = ABMultiValueGetCount(multiEmails);
            if(emailCount == 0)
            {
                [contactEmails addObject:@""];
            }
            
            
            for (CFIndex i=0; i<ABMultiValueGetCount(multiEmails); i++)
            {
                CFStringRef contactEmailRef = ABMultiValueCopyValueAtIndex(multiEmails, i);
                NSString *contactEmail = (__bridge NSString *)contactEmailRef;
                
                if(contactEmail.length > 0 && [self NSStringIsValidEmail:contactEmail])
                {
                    [contactEmails addObject:contactEmail];
                }
                else
                {
                    continue;
                }
            }
            
            //get Contact phone
            
            NSMutableArray *phoneNumbers = [[NSMutableArray alloc] init];
            ABMultiValueRef multiPhones = ABRecordCopyValue(person, kABPersonPhoneProperty);
            
            CFIndex phoneNumCount = ABMultiValueGetCount(multiPhones);
            if(phoneNumCount == 0)
            {
                [phoneNumbers addObject:@"0"];
            }
            
            for(CFIndex i=0; i<ABMultiValueGetCount(multiPhones); i++)
            {
                
                CFStringRef phoneNumberRef = ABMultiValueCopyValueAtIndex(multiPhones, i);
                NSString *phoneNumber = (__bridge NSString *) phoneNumberRef;
                
                if(phoneNumber.length > 0)
                {
                    [phoneNumbers addObject:phoneNumber];
                }
                else
                {
                    continue;
                }
            }
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            
            
            [dict setObject:image forKey:@"ProfileImage"];
            
            NSArray *fullNameSeparator = [fullName componentsSeparatedByString:@" "];
            if (fullNameSeparator.count>0) {
                [dict setObject:[fullNameSeparator objectAtIndex:0] forKey:@"FirstName"];
                [dict setObject:@"" forKey:@"LastName"];
            }
            if (fullNameSeparator.count>1) {
                [dict setObject:[fullNameSeparator objectAtIndex:1] forKey:@"LastName"];
            }
            if (fullNameSeparator.count==0) {
                [dict setObject:@"" forKey:@"FirstName"];
                [dict setObject:@"" forKey:@"LastName"];
            }
            //[dict setObject:fullName forKey:@"name"];
            [dict setObject:@"" forKey:@"UserID"];
            [dict setObject:@"" forKey:@"FacebookID"];
            [dict setObject:@"PhoneContacts" forKey:@"type"];
            
            
            /*if(ABMultiValueGetCount(multiEmails) > 0)
             {
             [dict setObject:contactEmails forKey:@"Email"];
             }
             if(ABMultiValueGetCount(multiPhones) > 0)
             {
             [dict setObject:phoneNumbers forKey:@"ContactNo"];
             }*/
            
            [dict setObject:contactEmails forKey:@"Email"];
            [dict setObject:phoneNumbers forKey:@"ContactNo"];
            
            [self.appDelegate.JSONDATAMemberarr addObject:dict];
            
        }
        
        NSSortDescriptor *sortNameDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"FirstName" ascending:YES selector:@selector(compare:)];
        [self.appDelegate.JSONDATAMemberarr sortUsingDescriptors:[NSArray arrayWithObjects:sortNameDescriptor,nil]];
        
        
        NSLog(@"My Sorted contact list :: %@",self.appDelegate.JSONDATAMemberarr);
        
        //[self.tablvw reloadData];
        
        /*self.contactDict = [arrFriend objectAtIndex:0];
         NSLog(@"My contact dictionary :: %@",self.contactDict);
         
         [self.allRegUserArr addObject:self.contactDict];*/
        
    }
}





- (BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:checkString];
}

- (BOOL) NSStringIsValidPhone: (NSString *)checkString
{
    NSString *phoneRegex2 = @"^(\\([0-9]{3})\\) [0-9]{3}-[0-9]{4}$";
    NSPredicate *phoneTest2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex2];
    
    return [phoneTest2 evaluateWithObject:checkString];
}



#pragma mark - CreateTeamScroolView
-(void)createTeamScroll{
    
    if ([self.appDelegate.JSONDATAarr count]) {
        
        [appDelegate setUserDefaultValue:@"1" ForKey:ISEXISTOWNTEAM];
        self.noTeamVw.hidden=YES;
        
    }else{
        
        self.noTeamVw.hidden=NO;
        if([self.teamNavController.view.superview isEqual:self.view])
            [self.teamNavController.view removeFromSuperview];
        if([appDelegate.aDef objectForKey:ISEXISTOWNTEAM])
            [appDelegate removeUserDefaultValueForKey:ISEXISTOWNTEAM];
        [self setTopBarText];

    }
    
    ////////////////////////////////////////////////////////
    kNumberOfPages=[self.appDelegate.JSONDATAarr count];
    lastSelectedTeam=0;
    
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < kNumberOfPages; i++) {
        [controllers addObject:[NSNull null]];
    }
    self.arrayControllers = controllers;
    controllers=nil;
	
    // a page is the width of the scroll view
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * kNumberOfPages, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    
	
    pageControl.numberOfPages = kNumberOfPages;
    //  pageControl.currentPage = 0;
	
    // pages are created on demand
    // load the visible page
    // load the page on either side to avoid flashes when the user starts scrolling
    
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview) ];
    
    
    for (unsigned i = 0; i < kNumberOfPages; i++) {
        [self loadScrollViewWithPage:i];
        
    }
    for (unsigned i = 0; i < kNumberOfPages; i++) {
        [self loadScrollViewWithPage:i];
        
    }
    

}




-(void)upBtappedNew:(int)indexNo
{
    
   
    
    int tag=indexNo;
    

    lastSelectedTeam=indexNo;

    self.selectedButton.hidden=YES;
    
    [self setTopBarText];

    if([self.teamNavController.view.superview isEqual:self.view])
        [self.teamNavController.view removeFromSuperview];
    
    TeamDetailsViewController *addTeam=[[TeamDetailsViewController alloc]initWithNibName:@"TeamDetailsViewController" bundle:nil];
    addTeam.selectedTeamIndex=tag;
    addTeam.teamVc=self;
    UINavigationController *aNav=[[UINavigationController alloc] initWithRootViewController:addTeam];
    
    self.teamNavController=aNav;
    aNav=nil;
    self.teamNavController.navigationBarHidden=YES;
    if (self.isiPad) {
        self.teamNavController.view.frame=CGRectMake(0,54,768,(appDelegate.commonHeight - 54));
        
    }
    else{
        if(appDelegate.isIphone5)
            self.teamNavController.view.frame=CGRectMake(0,44,320,(appDelegate.commonHeight + 88 - 44));
        else
            self.teamNavController.view.frame=CGRectMake(0,44,320,appDelegate.commonHeight - 44);
    }
    
    [self.view addSubview:self.teamNavController.view];
    [self.view bringSubviewToFront:self.teamNavController.view];
    
    SaveTeamViewController *teamView=[[SaveTeamViewController alloc]initWithNibName:@"SaveTeamViewController" bundle:nil];
    teamView.itemno=tag;
    teamView.editMode=YES;
    teamView.isInvite=0;
    teamView.selectedTeamIndex=tag;
    teamView.isTeamView=NO;
    [self.teamNavController pushViewController:teamView animated:NO];
    
   /* SpectatorViewController *spectorView=[[SpectatorViewController alloc]initWithNibName:@"SpectatorViewController" bundle:nil];
    spectorView.itemno=tag;
//    teamView.editMode=YES;
//    teamView.isInvite=0;
    spectorView.selectedTeamIndex=tag;
//    teamView.isTeamView=NO;
    [self.teamNavController pushViewController:spectorView animated:NO];*/


}


#pragma mark - ScroolViewDelegate


- (void)loadScrollViewWithPage:(int)page {
    
    if (page < 0) return;
    if (page >= kNumberOfPages) return;
	
    // replace the placeholder if necessary
    PageControlExampleViewControl *controller = [_arrayControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null]) {
        controller = [[PageControlExampleViewControl alloc] initWithNibName:@"PageControllerExample" bundle:nil];
        
        controller.sportsName=[[self.appDelegate.JSONDATAarr objectAtIndex:page] objectForKey:@"team_sport"];
          controller.pageNumberLabel.text=controller.sportsName;
        [controller loadImage:controller.sportsName];
        NSLog(@"loadScrollViewWithPage=%@",controller.sportsName);
        controller.pageNumberLabel.text=controller.pageNumberLabel.text;
        [_arrayControllers replaceObjectAtIndex:page withObject:controller];
        
    }
    else
    {
       
          controller.sportsName=[[self.appDelegate.JSONDATAarr objectAtIndex:page] objectForKey:@"team_sport"];
        controller.pageNumberLabel.text=controller.sportsName;
        [controller loadImage:controller.sportsName];
          NSLog(@"loadScrollViewWithPage=%@",controller.sportsName);
    }
	
    // add the controller's view to the scroll view
    if (nil == controller.view.superview) {
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        
        [scrollView addSubview:controller.view];
    }
    controller=nil;
}



-(void)leftSwipeDone
{
    
    int page = pageControl.currentPage;
    
    page--;
    
    if(page>=0 && page< self.appDelegate.JSONDATAarr.count)
    {
        pageControl.currentPage=page;
        
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        pageControlUsed = YES;
        [scrollView scrollRectToVisible:frame animated:YES];
        
        //Subhasish..10th July
        [appDelegate.centerVC getFromMyTeams:page-1];
        
    }
    
}

-(void)rightSwipeDone
{
    int page = pageControl.currentPage;
    
    page++;
    
    if(page>=0 && page< self.appDelegate.JSONDATAarr.count)
    {
        pageControl.currentPage=page;
        
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        pageControlUsed = YES;
        [scrollView scrollRectToVisible:frame animated:YES];
        
        //Subhasish..10th July
        [appDelegate.centerVC getFromMyTeams:page-1];

    }

}

// AD 19th MyTeams
-(void)getFromMyTeams:(int)page{
    if (page==-1) {
        pageControl.currentPage=1;
       [self leftSwipeDone];
    }
    else{
        pageControl.currentPage=page;
        
        [self rightSwipeDone];
    }
}

////////



- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
    
    
    if([sender isEqual:self.scrollView])
    {
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (pageControlUsed) {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    /*[self loadScrollViewWithPage:page - 1];
     [self loadScrollViewWithPage:page];
     [self loadScrollViewWithPage:page + 1];*/
	
    // A possible optimization would be to unload the views+controllers which are no longer visible
    
    
    //[self changePage:pageControl];
    
    }
    
    
    
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
/*- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView1
{
    if([scrollView1 isEqual:self.scrollView])
        
    {
    pageControlUsed = NO;
    self.selectedButton.hidden=YES;
    [self upBtappedNew:pageControl.currentPage];
    }
}*/


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView1
{
    if([scrollView1 isEqual:self.scrollView])
        
    {
        
        pageControlUsed = NO;
        self.selectedButton.hidden=YES;
        [self upBtappedNew:pageControl.currentPage];
    }
}

- (IBAction)changePage:(id)sender
{
    int page = pageControl.currentPage;
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    /*[self loadScrollViewWithPage:page - 1];
     [self loadScrollViewWithPage:page];
     [self loadScrollViewWithPage:page + 1];*/
    // update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    pageControlUsed = YES;
    [scrollView scrollRectToVisible:frame animated:YES];
    // Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    
    
    
    // [self upBtappedNew:page];
}








-(IBAction)AddTeam:(UIButton*)sender
{
    
    TeamDetailsViewController *addTeam=[[TeamDetailsViewController alloc]initWithNibName:@"TeamDetailsViewController" bundle:nil];
    addTeam.selectedTeamIndex=-1;
    addTeam.editBtn.hidden=YES;
    addTeam.isAddTeam=YES;
    addTeam.isMyTeam=NO;
    [addTeam setNewTeamIndex:^(int selectedTeam){
        
        self.selectedTeamTag=selectedTeam;
        [self createTeamScroll];
        [self upBtappedNew:selectedTeam];
        
        SaveTeamViewController *teamView=[[SaveTeamViewController alloc]initWithNibName:@"SaveTeamViewController" bundle:nil];
        teamView.itemno=self.selectedTeamTag;
        teamView.editMode=YES;
        teamView.isInvite=1;
        teamView.selectedTeamIndex=self.selectedTeamTag;
        teamView.isTeamView=NO;
        [self.teamNavController pushViewController:teamView animated:NO];

        
    }];
    [self.appDelegate.centerViewController presentViewControllerForModal:addTeam];
}

-(void)addAdmin:(UIButton *)sender{
    
    if(self.countAdmin<2)
    {
        
        AddAdminViewController *addAdmin=[[AddAdminViewController alloc] initWithNibName:@"AddAdminViewController" bundle:nil];
        addAdmin.selectedTeamIndex=lastSelectedTeam;
        addAdmin.isAddAdmin=YES;
        addAdmin.selectedAddmin=self.countAdmin;
        addAdmin.dictMemberAdmin=self.memberDetailDict;   /// AD july for Member
        
        [self.appDelegate.centerViewController presentViewControllerForModal:addAdmin];
        
        
    }else{
        
        // “Only two Admin per team
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Sorry, only two admin allowed per team" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
    }

    
}

-(void)addSpectator:(UIButton *)sender{
    
    NSLog(@"Team:%d",self.selectedTeamTag);
    NSLog(@"TeamLast:%d",self.lastSelectedTeam);
    
    
    //if(self.selContactNew.addAFriendVC.JSONDATAarr && self.selContactNew.addAFriendVC.JSONDATAarr.count>0)
    if (self.appDelegate.JSONDATAarr && self.appDelegate.JSONDATAarr.count>0)
    {
        if( [[self.appDelegate.navigationControllerAddAFriend.viewControllers lastObject] isMemberOfClass:[SelectContact class]])
        {
            [(SelectContact*)[self.appDelegate.navigationControllerAddAFriend.viewControllers lastObject] backf:nil];
        }
        
        self.selContactNew=[[SelectContact alloc] initWithNibName:@"SelectContact" bundle:nil];
        [self.navigationController pushViewController:self.selContactNew animated:YES];
        
        self.selContactNew.selectedTeamId=[[self.appDelegate.JSONDATAarr objectAtIndex:lastSelectedTeam] objectForKey:@"team_id"];
        self.selContactNew.teamName=[[self.appDelegate.JSONDATAarr objectAtIndex:lastSelectedTeam] objectForKey:@"team_name"];
        self.selContactNew.dictMemberSpectator=self.memberDetailDict; /// AD july for Member
        
        
        
        
        
        

        //[self.selContactNew resetData];
        
        
    }
    else
    {
        [self showAlertMessage:@"You need to belong to a team as a player to invite friends."];
    }
    
    
   /* SpectatorViewController *spectator=[[SpectatorViewController alloc] initWithNibName:@"SpectatorViewController" bundle:nil];
    spectator.selectedTeamIndex=self.lastSelectedTeam;
   // spectator.playerMode=0;
    // [self.navigationController pushViewController:player animated:YES];
    [self.appDelegate.centerViewController presentViewControllerForModal:spectator];*/
}

-(void)addPlayer:(UIButton *)sender
{
    
    NSLog(@"Team:%d",self.selectedTeamTag);
    NSLog(@"TeamLast:%d",self.lastSelectedTeam);
    
    PlayerViewController *player=[[PlayerViewController alloc] initWithNibName:@"PlayerViewController" bundle:nil];
    player.selectedTeamIndex=self.lastSelectedTeam;
    player.playerMode=0;
    player.dictMemberPlayer=self.memberDetailDict;   /// AD july for Member
    // [self.navigationController pushViewController:player animated:YES];
    
    player.isPlayerEmailIDRegster=appDelegate.alreadyRegisteredMember;
    
    [self.appDelegate.centerViewController presentViewControllerForModal:player];
    
    
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
