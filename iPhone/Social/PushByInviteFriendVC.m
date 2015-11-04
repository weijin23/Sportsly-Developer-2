//
//  ToDoByEventsVC.m
//  LinkBook
//
//  Created by Piyali on 06/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "CenterViewController.h"
#import "HomeVC.h"
#import "EventDetailsViewController.h"
#import "PushByInviteFriendVC.h"
#import "FPPopoverController.h"
#import "SelectContact.h"
#import "PushByInviteFriendCell.h"
#import "PushByInviteTeamCell.h"
#import "TeamMaintenanceVC.h"
#import "MyTeamsViewController.h"

@implementation PushByInviteFriendVC

@synthesize alldelarr,tabView,grayf,dGrayColor,grayColor,redf,todayIndexpath,todayFDate,delegate,popOver,isExistData,selContactNew,dataImages,loadStatus,lastSelIndexPath,lastSelStatus,start,limit,isFinishData,isLoadSuccessMayKnowPeople,dataAllArray,emailtotftext,emailName,isExistTeam;
@synthesize strInviteStatus;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
     [[NSNotificationCenter defaultCenter] removeObserver:self name:HANDLERECEIVEDMEMORYWARNING object:nil];
      [[NSNotificationCenter defaultCenter] removeObserver:self name:CENTERVIEWONTROLLERSETNIL object:nil];
    
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SHOWNAVIGATIONCONTROLLERADDFRIEND object:nil];
    self.delegate=nil;
    self.privateDotImage=nil;
    self.publicDotImage=nil;
    
    
    self.fetchedResultsController.delegate=nil;
    self.fetchedResultsController=nil;
        
        
              [[NSNotificationCenter defaultCenter] removeObserver:self name:SELECTCONTACTIMAGELOADEDPUSHBY object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:INVITEFRIENDPUSHLISTINGIMAGELOADED object:nil];
         
            [[NSNotificationCenter defaultCenter] removeObserver:self name:INVITEFRIENDSSTATUS object:nil];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
  
}
-(void)nilDelegate:(id)sender
{
    self.delegate=nil;
    
    self.fetchedResultsController.delegate=nil;
    self.fetchedResultsController=nil;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
  
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
 
    [super viewDidLoad];
    self.navigationController.delegate=self;
    
    self.isFinishData=0;
    self.limit=10;
    self.isLoadSuccessMayKnowPeople=0;
    
    
    self.storeCreatedRequests=[[NSMutableArray alloc] init];
    self.dataImages=[[NSMutableArray alloc] init];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nilDelegate:) name:CENTERVIEWONTROLLERSETNIL object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageUpdated:) name:INVITEFRIENDPUSHLISTINGIMAGELOADED object:nil];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userListUpdated:) name:INVITEFRIENDSSTATUS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userListUpdatedPushBy:) name:USERLISTINGPUSHBYINVITEFRIEND object:nil];
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageUpdatedPush:) name:SELECTCONTACTIMAGELOADEDPUSHBY object:nil];
    
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNavigationControllerUpdated:) name:SHOWNAVIGATIONCONTROLLERADDFRIEND object:nil];
    
    self.dataAllArray=[[NSMutableArray alloc] init];
    
    // Do any additional setup after loading the view from its nib.
   // self.topview.backgroundColor=appDelegate.barGrayColor;
   // self.view.backgroundColor=appDelegate.backgroundPinkColor;
    self.dGrayColor=[UIColor darkGrayColor];
    
    if (self.isiPad) {
        self.grayf=[UIFont systemFontOfSize:20];
        self.grayColor=[UIColor grayColor];
        self.redf=[UIFont systemFontOfSize:16];
        self.helveticaFontForte=[UIFont fontWithName:@"Helvetica" size:18.0];
    }
    else{
        self.grayf=[UIFont systemFontOfSize:17];
        self.grayColor=[UIColor grayColor];
        self.redf=[UIFont systemFontOfSize:12];
        self.helveticaFontForte=[UIFont fontWithName:@"Helvetica" size:15.0];
    }
    self.privateDotImage=[UIImage imageNamed:@"Dot-Image-with-P-text.png"];
    self.publicDotImage=[UIImage imageNamed:@"Grey dot.png"];
    self.todayIndexpath=nil;
    self.todayFDate=[self dateFromSD:[NSDate date] ];
    
    
    @autoreleasepool {
       if (self.isiPad) {
           self.helveticaFontForteBold=[UIFont fontWithName:@"Helvetica-Bold" size:20.0];
           self.helveticaFont=[UIFont fontWithName:@"Helvetica" size:17.0];
           self.helveticaFontBold=[UIFont fontWithName:@"Helvetica-Bold" size:16.0];

       }
       else{
           self.helveticaFontForteBold=[UIFont fontWithName:@"Helvetica-Bold" size:14.0];
           self.helveticaFont=[UIFont fontWithName:@"Helvetica" size:12.0];
           self.helveticaFontBold=[UIFont fontWithName:@"Helvetica-Bold" size:12.0];

       }
        
       
    }
  
    [self.dataImages removeAllObjects];
    [self.tabView reloadData];
    if(delegate)
    {
    if([delegate respondsToSelector:@selector(didChangeNumberOfFriendInvites:)])
    {
         NSArray *ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"inviteStatus==0"]];
        
        [delegate didChangeNumberOfFriendInvites:[NSString stringWithFormat:@"%i",ar.count]];
    }
    }
   /* [self.tabView scrollToRowAtIndexPath:self.todayIndexpath
                         atScrollPosition:UITableViewScrollPositionTop
                                 animated:YES];*/
    
  
  
    
    
    if(self.fetchedResultsController.fetchedObjects.count>0)
    {
        self.nolbl.hidden=YES;
        self.nofriendinvitesimavw.hidden=YES;
        CGRect fr=  self.tabView.frame;
        fr.origin.y=0;
        fr.size.height=self.view.frame.size.height;   //// iAd 8/05
      //  fr.size.height=self.view.frame.size.height-50;
        self.tabView.frame=fr;
        //CGRectMake(self.tabView.frame.origin.x, 41, self.tabView.frame.size.width,380);
    }
    else
    {
     self.nolbl.hidden=NO;
        //self.nofriendinvitesimavw.hidden=NO;   /// 03/03/2015
        CGRect fr=  self.tabView.frame;
        if (self.isiPad) {
            fr.origin.y=305;
            fr.size.height=self.view.frame.size.height-300;
        }
        else{
            fr.origin.y=150;
            fr.size.height=self.view.frame.size.height-150;  //// iAd 8/05
          //  fr.size.height=self.view.frame.size.height-200;
        }
        self.tabView.frame=fr;
        //CGRectMake(self.tabView.frame.origin.x, 91, self.tabView.frame.size.width,330);
    }
    
    
   // [self requestServerData ];
    
    
    
    
    
    
    
    //////////////////
    AddAFriend *as=[[AddAFriend alloc] initWithNibName:@"AddAFriend" bundle:nil];
    
    self.addAFriendVC=as;
    self.addAFriendVC.selectContact=self;
    [self.addAFriendVC view];
    
    if(appDelegate.isIphone5)
        self.addAFriendVC.view.frame=CGRectMake(0, (164+88-49), self.addAFriendVC.view.frame.size.width, self.addAFriendVC.view.frame.size.height);
    else
        self.addAFriendVC.view.frame=CGRectMake(0, (164-49), self.addAFriendVC.view.frame.size.width, self.addAFriendVC.view.frame.size.height);//Add Ch in Xcode 5
    
    [self.view addSubview:self.addAFriendVC.view];
    self.addAFriendVC.view.hidden=YES;
    as=nil;
    
    // self.phFriend.addAFriendVC=self.addAFriendVC;
    
   
    
    //////////////////
    self.selContactNew=[[SelectContact alloc] initWithNibName:@"SelectContact" bundle:nil];
    self.selContactNew.pushInviteFriendvc=self;
    [self.selContactNew view];
    
    
    
   /* NSString *text=@"You currently have no friend invite.\nInvite friends to view or post to your timeline\nTeam details will remain private.";
    NSString *str=@"You currently have no friend invite.\nInvite friends to view or post to your timeline\n";
    NSUInteger length = [str length];
    //////
    
    CGFloat bigFontSize = 13;
    CGFloat fontSize = 11;
    if (self.isiPad) {
        bigFontSize=23;
        fontSize = 21;
    }
    UIFont *biggerFont = [UIFont fontWithName:@"Helvetica" size:bigFontSize];
    UIFont *regularFont = [UIFont fontWithName:@"Helvetica" size:fontSize];
    UIColor *foregroundColor = [UIColor lightGrayColor];
    
    // Create the attributes
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                           biggerFont, NSFontAttributeName,
                           foregroundColor, NSForegroundColorAttributeName, nil];
    NSDictionary *subAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                              regularFont, NSFontAttributeName, nil];
    const NSRange range = NSMakeRange(0,length); // range of " 2012/10/14 ". Ideally this should not be hardcoded
    
    // Create the attributed string (text + attributes)
    NSMutableAttributedString *attributedText =[[NSMutableAttributedString alloc] initWithString:text attributes:attrs];
    [attributedText setAttributes:subAttrs range:range];
    
    // Set it in our UILabel and we are done!
    [self.nolbl setAttributedText:attributedText];
    
    
    
    /////
    self.nolbl.text=@"You currently have no invites.\nInvite friends to view and post on one or more of your Timelines yet they will not be able to see any team event details as that is private for team members only.";  /// 23/8/14
    
    */

    
    
    
    self.nolbl.text=@"Invite friends and family to share team moments. Personal team details will remain private";  /// 16/01/15
    
}



- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SHOWNAVIGATIONCONTROLLERADDFRIEND object:nil];
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated;
{
    
}


-(void)showNavigationControllerUpdated:(id)sender
{
    
    
    if(self.navigationController.view.hidden==NO)//[appDelegate.centerViewController getShowStatus:self.navigationController])
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

-(void)setRightBarButton
{
    
    if(self.navigationController.view.hidden==NO)
    {
        if([[self.navigationController.viewControllers lastObject] isMemberOfClass:[self class]])
        {
            
            if(isExistTeam)
                appDelegate.centerViewController.navigationItem.rightBarButtonItem=self.rightBarButtonItem;
            else
                appDelegate.centerViewController.navigationItem.rightBarButtonItem=nil;
        }
    }
}

-(void)setTopBarText
{
    if(self.navigationController.view.hidden==NO)//([appDelegate.centerViewController getShowStatus:self.navigationController])
    {
        if([[self.navigationController.viewControllers lastObject] isMemberOfClass:[self class]])
        {
            appDelegate.centerViewController.navigationItem.title=nil;
            appDelegate.centerViewController.navigationItem.titleView=nil;
            
            
            appDelegate.centerViewController.navigationItem.title=@"Spectator Requests";
        }
    }
}

-(void)showNavigationBarButtons
{
    
    if(!self.leftBarButtonItem)
    {
        self.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"teamRosterWall.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleLeftPanel:)];
    }
    
    ///// AD 24th june Friend Request
    
   /* if(!self.rightBarButtonItem)
    {
        if (self.isiPad) {
            self.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"plus_icon_add_ipad.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleRightPanel:)];
        }
        else{
            self.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"plus_icon_add.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleRightPanel:)];
        }
    }*/
    
    ///////////
    
    appDelegate.centerViewController.navigationItem.title=nil;
    appDelegate.centerViewController.navigationItem.titleView=nil;
    
    //appDelegate.centerViewController.navigationItem.title=nil;
    // appDelegate.centerViewController.navigationItem.titleView=nil;
    
    
    appDelegate.centerViewController.navigationItem.leftBarButtonItem=self.leftBarButtonItem;
    
  //  [self setRightBarButton];   ///// AD 24th june Friend Request
    appDelegate.centerViewController.navigationItem.rightBarButtonItem=nil;
    
    [self setStatusBarStyleOwnApp:1];
    
}

-(void)toggleLeftPanel:(id)sender
{
    //[appDelegate.slidePanelController showLeftPanelAnimated:YES];   //// AD 24th june FR
    //[self.navigationController popViewControllerAnimated:YES];
    
//    self.timelineimavw.image=self.appDelegate.centerViewController.timelineima;
//    self.fsttablab.textColor=self.lightgraycolor;
    
    
    if([[appDelegate.navigationControllerTeamMaintenance.viewControllers lastObject] isMemberOfClass:[TeamMaintenanceVC class]])
        [(TeamMaintenanceVC*)[appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] loadTeamData];
    TeamMaintenanceVC *teamVc=  (TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0];
    teamVc.isShowFristTime=YES;
    
    //////////////ADDDEB
    teamVc.isShowFromNotification=NO;
    /////////////
    [self.appDelegate.centerViewController showNavController:appDelegate.navigationControllerTeamMaintenance];
    
    
}


-(void)toggleRightPanel:(id)sender
{
    
    
    if(self.selContactNew.addAFriendVC.JSONDATAarr && self.selContactNew.addAFriendVC.JSONDATAarr.count>0)
    {
        [self.navigationController pushViewController:self.selContactNew animated:YES];
        
        //[self.selContactNew resetData];
    }
    else
    {
        [self showAlertMessage:@"You need to belong to a team as a player to invite friends."];
    }
    
    
}









-(void)populateField:(ContactsUser*)contact
{
    
    NSLog(@"selectedContact=%@",contact);
    self.emailtotftext=@"";
    
    self.emailtotftext=contact.email;
    self.emailName=contact.contactName;
}

-(void)resetInHide
{
     self.emailtotftext=@"";
    self.emailName=@"";
}

-(int)showAddAFriend
{
    
    if( [self.emailtotftext isEqualToString:@""])
    {
        [self showAlertMessage:@"The email id is not found."];
        
    }
    else if([self validEmail: self.emailtotftext ])//[self validEmail: self.emailtotf.text ]
    {
        /*UIAlertView *al=[[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:INVITEFRIENDSALERTMESSAGE,self.emailtotf.text] delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
         
         [al show];*/
        
        
        if(self.addAFriendVC.JSONDATAarr && self.addAFriendVC.JSONDATAarr.count>0)
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
            [self showAlertMessage:@"You need to belong to a team as a player to invite friends."];
        }
        
        
        
        return 1;
    }
    else
    {
        [self showAlertMessage:@"The email id is invalid."];
        
    }
    
    return 0;
    
}



-(void)showAlertViewCustomInvite:(NSString*)labText
{
    self.custompopuplab.text=labText;
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
    
    if (self.isDecline) {
        self.loadStatus=1;
        
        self.isDecline=NO;
        
        Invite *newinvite=[self.fetchedResultsController objectAtIndexPath:self.lastSelIndexPath];
        NSString *str=nil;
        
        str=@"Decline";
        self.strInviteStatus=str;
        lastSelStatus=2;
        NSMutableDictionary *command = [NSMutableDictionary dictionary];
        [command setObject:str forKey:@"status"];
        [command setObject:newinvite.postId forKey:@"id"];
        [command setObject:newinvite.teamId forKey:@"team_id"];
        [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
        SBJsonWriter *writer = [[SBJsonWriter alloc] init];
        
        
        NSString *jsonCommand = [writer stringWithObject:command];
        
        
        
        [self showNativeHudView];
        NSLog(@"RequestParamJSON=%@",jsonCommand);
        
        
        self.requestDic=command;
        
        
        
        /*[appDelegate sendRequestFor:INVITEFRIENDSSTATUS from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];*/
        
        SingleRequest *sinReq=nil;
        sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:INVITEFRIENDSSTATUSLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
        self.sinReq2=sinReq;
        [self.storeCreatedRequests addObject:self.sinReq2];
        sinReq.notificationName=INVITEFRIENDSSTATUS;
        
        [sinReq startRequest];
    }
    else
        [self.addAFriendVC sendToServer]; // 21/7/14
   // [self.addAFriendVC hideHudViewHere ];
}

-(void)showAlertForNotSending:(NSString*)msg
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:PRODUCT_NAME message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    alert.tag=10;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==10)
    {
        [self.addAFriendVC hideHudViewHere ];
    }
    
    
}


- (IBAction)popuptapped:(id)sender
{
    self.popupalertvw.hidden=YES;
    self.popupalertvwback.hidden=YES;
    
    
//    if(![self.custompopuplab.text isEqualToString:@"Friend invite has been sent"])
//        [self goToTimeLine:nil];
//    else
    [self.addAFriendVC hideHudViewHereOnly ];
    //[self.addAFriendVC hideHudViewHere ];
   
}



-(void)goToTimeLine:(NSString*)msg
{
    [appDelegate.centerViewController showNavController:appDelegate.navigationController];
    
    if(appDelegate.centerVC.dataArrayUpButtonsIds.count==1)
    {
        [appDelegate.centerVC showAlertViewCustom:msg];
    }
    
    else if(appDelegate.centerVC.dataArrayUpButtonsIds.count==2)
    {
        [appDelegate.centerVC showAlertViewCustom:@"Congrats, you now belong to multiple Timelines. Scroll through them by swiping left/right"];
    }
}


-(void)showAlertViewCustom:(NSString*)labText
{

    
        
        self.custompopuplab.text=labText;
    
    
    self.popupalertvw.hidden=NO;
    self.popupalertvwback.hidden=NO;
    
    [self.view bringSubviewToFront:self.popupalertvwback];
    [self.view bringSubviewToFront:self.popupalertvw];
    
    
}


-(void)showAddAFriendNative:(BOOL)isShow
{
    if(![self.addAFriendVC.sendEmailName isEqualToString:@""])
        self.addAFriendVC.toolbartitle.text=[[NSString alloc] initWithFormat:@"Select team below to invite %@",self.addAFriendVC.sendEmailName];
    else
        self.addAFriendVC.toolbartitle.text=[[NSString alloc] initWithFormat:@"Select team below to invite %@",self.addAFriendVC.sendEmailId];
    
    
    if(isShow)
    {
    self.pickertop.hidden=NO;
     self.addAFriendVC.view.hidden=NO;
    [self.view bringSubviewToFront:self.addAFriendVC.view];
    }
    else
    {
        self.pickertop.hidden=YES;
        self.addAFriendVC.view.hidden=YES;
        [self.addAFriendVC doneTapped:nil];
    }
    
    
    
    
    
}

-(void)hideAddAFriendNative
{
    self.pickertop.hidden=YES;
    self.addAFriendVC.view.hidden=YES;
}

-(void)requestServerData
{
    
    self.isLoadSuccessMayKnowPeople=0;
    self.isFinishData=0;
    self.start=0;
    [self.dataAllArray removeAllObjects];
    [self.tabView reloadData];
    
    [self showNativeHudView];
    [self performSelector:@selector(getUserListings) withObject:nil afterDelay:0.0];


}


-(void)getUserListings
{
    NSString *startstr=  [NSString stringWithFormat:@"%lli",self.start] ;
    NSString *limitstr=    [NSString stringWithFormat:@"%lli",self.limit];
    
    
    
    [self getUserListingPush:@"" :@"" :limitstr :startstr :1];
}

-(void)userListUpdatedPushBy:(id)sender
{
    [self hideNativeHudView];
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
    if([sReq.notificationName isEqualToString:USERLISTINGPUSHBYINVITEFRIEND])
    {
        if(sReq.responseData)
        {
            
            if (sReq.responseString)
            {
                
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
                        
                          self.isLoadSuccessMayKnowPeople=1;
                        
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
    
    
    /*if(  [self.dataAllArray count]==0)
    {
        [self showHudAlert:@"No Results Found"];
        [self performSelector:@selector(hideHudViewHereFinished) withObject:nil afterDelay:2.0];
        
    }
    else
    {*/
    
    if(self.dataAllArray.count>0)
    [self moveStatusLabelBasisOfNumber:1];
    else
    [self moveStatusLabelBasisOfNumber:0];
    
        [self.tabView reloadData];
    //}
    
}




-(void)moveStatusLabelBasisOfNumber:(BOOL)isExist
{
   
   if(isExist)
   {
    CGRect r= self.nolbl.frame;
       if (self.isiPad) {
           r.origin.y=105;
       }
       else
           r.origin.y=50;
    self.nolbl.frame=r;
    
    r=self.nofriendinvitesimavw.frame;
       if (self.isiPad) {
           r.origin.y=95;
       }
       else
           r.origin.y=70;
    self.nofriendinvitesimavw.frame=r;
       
       
       self.tabView.hidden=NO;
   }
    else
    {
        CGRect r= self.nolbl.frame;
        if (self.isiPad) {
            r.origin.y=335;
        }
        else
            r.origin.y=240;
        self.nolbl.frame=r;
        
        r=self.nofriendinvitesimavw.frame;
        if (self.isiPad) {
            r.origin.y=205;
        }
        else
            r.origin.y=170;
        self.nofriendinvitesimavw.frame=r;
        
        
        if(self.fetchedResultsController.fetchedObjects.count>0)
           self.tabView.hidden=NO; 
            else
          self.tabView.hidden=YES;
    }
}



-(void)storeUsers:(NSArray*)userarray
{
    
    
    if(self.start==0)
        [self.dataAllArray removeAllObjects];
    
    if(self.selContactNew.addAFriendVC.JSONDATAarr && self.selContactNew.addAFriendVC.JSONDATAarr.count>0)
    {
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
    
}











//////////////////////////////////////////////////////////////////////////////////////////////////
- (void)imageUpdatedPush:(NSNotification *)notif
{
    
    
    
    NSNumber * info = [notif object];
    
    
    int row = [info intValue];
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:row inSection:1];
    
    NSLog(@"ADDFImage for indexpath %i updated", indexPath.row);
    NSLog(@"ADDAFRIENDVC1reloadRows");
    
    if([[self.tabView indexPathsForVisibleRows] containsObject:indexPath])
        [self.tabView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    NSLog(@"ADDAFRIENDVC2reloadRows");
    
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

-(void)setDataView
{
    if(isExistData)
    {
    //    self.tabView.hidden=NO;
        
        CGRect fr=  self.tabView.frame;
        fr.origin.y=0;
        fr.size.height=self.view.frame.size.height;   //// iAd 8/05
       // fr.size.height=self.view.frame.size.height-50;
        self.tabView.frame=fr;
        //CGRectMake(self.tabView.frame.origin.x, 41, self.tabView.frame.size.width,380);
        self.nolbl.hidden=YES;
        self.nofriendinvitesimavw.hidden=YES;
    }
    else
    {
    //    self.tabView.hidden=YES;
        CGRect fr=  self.tabView.frame;
        if (self.isiPad) {
            fr.origin.y=305;
            fr.size.height=self.view.frame.size.height-300;
        }
        else{
            fr.origin.y=200;
            fr.size.height=self.view.frame.size.height-200;   //// iAd 8/05
          //  fr.size.height=self.view.frame.size.height-250;
        }

        self.tabView.frame=fr;
        self.nolbl.hidden=NO;
    }
}


- (void)viewDidUnload
{
    [self setNolbl:nil];
    [self setPlusbuttoninvitefriendbt:nil];
    [self setFirstsectionheadervw:nil];
    [self setPickertop:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

/*-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *cellview;
    UIImageView *imaview;
    cellview=[[[UIView alloc] initWithFrame:CGRectMake(0,0,320,21)] autorelease];
    imaview=[[UIImageView alloc ] initWithImage:[UIImage imageNamed:@"Slid1_black 1st separation bar.png"]];
    imaview.frame=CGRectMake(0,0,320,21);
    
    
    UILabel *header=[[UILabel alloc] initWithFrame:CGRectMake(15,0,150,21) ];
    header.font=[UIFont systemFontOfSize:14];
   
    header.backgroundColor=[UIColor clearColor];
    
    UILabel *header1=[[UILabel alloc] initWithFrame:CGRectMake(170,0,150,21) ];
    header1.font=[UIFont systemFontOfSize:14];
   
    header1.backgroundColor=[UIColor clearColor];
    
    
     NSDate *currDate=[[NSDate alloc] init];
    
    
    id <NSFetchedResultsSectionInfo> sectionInfo;
    
   
        sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
       
    NSArray *arr=[[sectionInfo name] componentsSeparatedByString:@"-"];
    header.text=[arr objectAtIndex:0];
    header1.text=[arr objectAtIndex:1];
    if([[sectionInfo name] isEqualToString:[self getDateTimeCanName:currDate]])
    {
        header.textColor=[UIColor redColor];
        header1.textColor=[UIColor redColor];
    }
    else
    {
        header.textColor=[UIColor whiteColor];
        header1.textColor=[UIColor whiteColor];
    }
    [currDate release];
    [imaview addSubview:header];
     [imaview addSubview:header1];
    [cellview addSubview:imaview];
    [imaview release];
    [header release];
    [header1 release];
    return cellview;
}*/
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==0)
    {
        if(![appDelegate.aDef objectForKey:ISFIRSTTIMESHOWPLUSINADDFRIEND])
        {
            if(self.plusbuttoninvitefriendbt.hidden==NO)
                self.tappluslabel.hidden=YES;//NO
            else
                self.tappluslabel.hidden=YES;
        }
        else
        {
            self.tappluslabel.hidden=YES;
        }
    return 0.0;
    }
    else
    {
        
        if([appDelegate.aDef objectForKey:ISFIRSTTIMESHOWPLUSINADDFRIEND])
        return self.firstsectionheadervw.frame.size.height;
        else
        {
          
            if(self.plusbuttoninvitefriendbt.hidden==NO)
            
            return self.firstsectionheadervw.frame.size.height;//firstsectionheaderviewextended
            else
            return self.firstsectionheadervw.frame.size.height;
            
        }
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if(isLoadSuccessMayKnowPeople==0)
    return [[self.fetchedResultsController sections] count];
    else
    return 2;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(isLoadSuccessMayKnowPeople==0 || indexPath.section==0)
    {
        
        
        
        if(!(indexPath.row<self.fetchedResultsController.fetchedObjects.count))
        {
            return 95.0f;
        }
        else
        {
            Invite *newEvent= [self.fetchedResultsController objectAtIndexPath:indexPath];
            
            
            NSString *teamSport= newEvent.teamSport;
            
            NSString *acstr=nil;
            
            if(teamSport)
                acstr=[[NSString alloc] initWithFormat:@"%@ has invited you to view %@ %@ team wall",newEvent.senderName,newEvent.teamName,newEvent.teamSport];
            else
                acstr=[[NSString alloc] initWithFormat:@"%@ has invited you to view %@ team wall",newEvent.senderName,newEvent.teamName];
            
            
            
            NSMutableAttributedString *attr=[[NSMutableAttributedString alloc] initWithString:acstr];
            
            
            [attr addAttribute:NSForegroundColorAttributeName value:self.dGrayColor range:NSMakeRange(0, acstr.length)];
            [attr addAttribute:NSFontAttributeName value:self.helveticaFontForte range:NSMakeRange(0, acstr.length)];
            
            
            if(acstr && newEvent.teamName)
                [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:newEvent.teamName]];
            
            if(acstr && newEvent.senderName)
                [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:newEvent.senderName]];
            
            
            if(acstr && teamSport)
                [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:teamSport]];
            
            UILabel *senderName=nil;
            UILabel *teamName=nil;
            if (self.isiPad) {
                senderName=[[UILabel alloc] initWithFrame:CGRectMake(65, 3, 245, 40)];
                senderName.numberOfLines=0;
                senderName.font=[UIFont fontWithName:@"Helvetica" size:18.0];
                
                senderName.attributedText=attr;
                [senderName sizeToFit];
                
                teamName=[[UILabel alloc] initWithFrame:CGRectMake(80, 29, 245, 26)];
                teamName.numberOfLines=0;
                teamName.text=[self getDateTimeForHistory:newEvent.datetime];
            }
            else{
            
            senderName=[[UILabel alloc] initWithFrame:CGRectMake(65, 3, 245, 28)];
            senderName.numberOfLines=0;
            senderName.font=[UIFont fontWithName:@"Helvetica" size:14.0];
            
            senderName.attributedText=attr;
            [senderName sizeToFit];
            
            teamName=[[UILabel alloc] initWithFrame:CGRectMake(80, 29, 245, 16)];
            teamName.numberOfLines=0;
            teamName.text=[self getDateTimeForHistory:newEvent.datetime];
            }
            float dY=3;
            
            
            
            
            
            
            dY+=senderName.frame.size.height;
            dY+=2;
            dY+=teamName.frame.size.height;
            dY+=5;
//            if (self.isiPad) {
//                dY+=(45+5);
//            }
//            else{
                dY+=(30+5);
//            }
            ++dY;
            
            
            if (self.isiPad) {
                
                if(dY<145)
                    dY=145;
                
                else if(dY<169)
                    dY=169;
            }
            else{                
                if(dY<95)
                    dY=95;
            }
            
            return dY;
        }
        
        
        
        
        
    }
    else
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
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(isLoadSuccessMayKnowPeople==0 || section==0)
    {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    
    NSLog(@"NOF=-%i",[sectionInfo numberOfObjects]);
    return [sectionInfo numberOfObjects];
    }
    else
    {
         return (self.dataAllArray.count+1);
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
      if(section==0)
      {
          if(![appDelegate.aDef objectForKey:ISFIRSTTIMESHOWPLUSINADDFRIEND])
          {
                 if(self.plusbuttoninvitefriendbt.hidden==NO)
                     self.tappluslabel.hidden=YES;//NO
                     else
                     self.tappluslabel.hidden=YES;
          }
          else
          {
             self.tappluslabel.hidden=YES;
          }
              
              
              
          return nil;
      }
    else
    {
        
        if([appDelegate.aDef objectForKey:ISFIRSTTIMESHOWPLUSINADDFRIEND])
            return self.firstsectionheadervw;
        else
        {
            
            if(self.plusbuttoninvitefriendbt.hidden==NO)
            {
                
                 if(self.tappluslabel.hidden==NO)
                      self.tappluslabelm.hidden=YES;
                else
                      self.tappluslabelm.hidden=NO;
                
                
                return self.firstsectionheadervw;//firstsectionheaderviewextended;
            }
            else
            {
                return self.firstsectionheadervw;
            }
            
        }
        
        
      
    }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    if(indexPath.section==0)
    {
    static NSString *CellIdentifier = @"PushByInviteTeamCell";
    
    PushByInviteTeamCell *cell = [self.tabView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = (PushByInviteTeamCell *)[PushByInviteTeamCell cellFromNibNamed:CellIdentifier];
           cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
    }
    else
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

}


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section==0)
    {
        
        PushByInviteTeamCell *cell1=(PushByInviteTeamCell*)cell;
        
        Invite *newEvent= [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        NSString *teamSport= newEvent.teamSport;
        
        NSString *acstr=nil;
        
        if(teamSport)
            acstr=[[NSString alloc] initWithFormat:@"%@ has invited you to view %@ %@ team wall",newEvent.senderName,newEvent.teamName,newEvent.teamSport];
            else
        acstr=[[NSString alloc] initWithFormat:@"%@ has invited you to view %@ team wall",newEvent.senderName,newEvent.teamName];
        
        
        
        NSMutableAttributedString *attr=[[NSMutableAttributedString alloc] initWithString:acstr];
        
        
        [attr addAttribute:NSForegroundColorAttributeName value:self.dGrayColor range:NSMakeRange(0, acstr.length)];
        [attr addAttribute:NSFontAttributeName value:self.helveticaFontForte range:NSMakeRange(0, acstr.length)];
        
        
        if(acstr && newEvent.teamName)
            [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:newEvent.teamName]];
        
        if(acstr && newEvent.senderName)
            [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:newEvent.senderName]];
        
        
        if(acstr && teamSport)
            [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:teamSport]];
        
        
        
        
        cell1.senderName.attributedText=attr;
        [cell1.senderName sizeToFit];
        
        
        cell1.teamName.text=[self getDateTimeForHistory:newEvent.datetime];
        
        float dY=cell1.senderName.frame.origin.y;
        
        
        
        
        
        
        dY+=cell1.senderName.frame.size.height;
        
        
        if (self.isiPad) {
            
            dY+=5;
            cell1.teamName.frame=CGRectMakeWithSize(cell1.teamName.frame.origin.x,(dY+4), cell1.teamName.frame.size);
            cell1.imagetimevw.frame=CGRectMakeWithSize(cell1.imagetimevw.frame.origin.x,(dY+4+1), cell1.imagetimevw.frame.size);
            dY=cell1.teamName.frame.origin.y+cell1.teamName.frame.size.height;
            
            cell1.statusLabel.frame=CGRectMakeWithSize(cell1.statusLabel.frame.origin.x,(dY+4), cell1.statusLabel.frame.size);
            dY+=5;
        }
        else{
            cell1.teamName.frame=CGRectMakeWithSize(cell1.teamName.frame.origin.x,(dY+2), cell1.teamName.frame.size);
            cell1.imagetimevw.frame=CGRectMakeWithSize(cell1.imagetimevw.frame.origin.x,(dY+2+1), cell1.imagetimevw.frame.size);
            dY=cell1.teamName.frame.origin.y+cell1.teamName.frame.size.height;
            
            cell1.statusLabel.frame=CGRectMakeWithSize(cell1.statusLabel.frame.origin.x,(dY+2), cell1.statusLabel.frame.size);
        }
        
        
        
        
        cell1.statusLabel.hidden=NO;
        cell1.acceptBtn.hidden=YES;
        cell1.declineBtn.hidden=YES;
        cell1.maybeBtn.hidden=YES;
        
        
        CGRect btrect=cell1.acceptBtn.frame;
        btrect.origin.y=dY+5;
        cell1.acceptBtn.frame=btrect;
        
        btrect=cell1.declineBtn.frame;
        if (self.isiPad)
            btrect.origin.x-=95;
        else
            btrect.origin.x-=45;
        btrect.origin.y=dY+5;
        cell1.declineBtn.frame=btrect;
        
        btrect=cell1.maybeBtn.frame;
        btrect.origin.y=dY+5;
        cell1.maybeBtn.frame=btrect;
        
        
        [cell1.acceptBtn addTarget:self action:@selector(acceptInvite:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell1.declineBtn addTarget:self action:@selector(declineInvite:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell1.maybeBtn addTarget:self action:@selector(mayBeInvite:) forControlEvents:UIControlEventTouchUpInside];
        cell1.mainBackgroundVw.backgroundColor=self.whitecolor;
        if( newEvent.inviteStatus.intValue==0)
        {
            cell1.statusLabel.hidden=YES;
            cell1.acceptBtn.hidden=NO;
            cell1.declineBtn.hidden=NO;
         //   cell1.maybeBtn.hidden=NO;
            
            
            [cell1.mainBackgroundVw bringSubviewToFront:cell1.acceptBtn];
            [cell1.mainBackgroundVw bringSubviewToFront:cell1.declineBtn];
            [cell1.mainBackgroundVw bringSubviewToFront:cell1.maybeBtn];
            
            cell1.mainBackgroundVw.backgroundColor=appDelegate.backGroundUnreadGray;
        }
        else if( newEvent.inviteStatus.intValue==1)
        {
            cell1.statusLabel.text=@"Accepted";
        }
        else if( newEvent.inviteStatus.intValue==2)
        {
            cell1.statusLabel.text=@"Declined";
        }
        else
        {
            cell1.statusLabel.text=@"Maybe";
        }
        
        if( newEvent.inviteStatus.intValue==0)
        {
            dY=cell1.acceptBtn.frame.origin.y+cell1.acceptBtn.frame.size.height+5;
            
           
            
           
            if (self.isiPad) {
                if(dY<169)
                    dY=169;
            }
            else{
            
            if(dY<94)
                dY=94;
            }
            
           
        }
        else
        {
            dY=cell1.statusLabel.frame.origin.y+cell1.statusLabel.frame.size.height+4;
            if (self.isiPad) {
                if(dY<145)
                    dY=145;
            }
            else{
                if(dY<79)
                    dY=79;
            }
            
        }
        
        
        CGRect m= cell1.mainBackgroundVw.frame;
        m.size.height=++dY;
        cell1.mainBackgroundVw.frame=m;
        
        
        
        btrect=cell1.separator.frame;
        btrect.origin.y=dY-1;
        
        
        cell1.separator.frame=btrect;
        
        
        
        
        /*[cell1.posted cleanPhotoFrame];
        if(newEvent.senderProfileImage)
        {
            NSURL *url=[[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"%@%@",IMAGELINKTHUMB, newEvent.senderProfileImage ]];
            
            [cell1.posted setImageWithURL:url placeholderImage:self.noImage];
            
            
            [cell1.posted applyPhotoFrame];
            
        }
        else
        {
            [cell1.posted setImage:self.noImage];
        }*/
        
        ImageInfo * info1=nil;
        
            NSLog(@"%i--%i",(self.dataImages.count-1),indexPath.row);
        
            int check=(self.dataImages.count-1);
        
        
            if(indexPath.row<=check)
           {
                 info1 = [self.dataImages objectAtIndex:indexPath.row];
            }
            else
            {
               info1=[[ImageInfo alloc] initWithSourceURL:[[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"%@%@",IMAGELINKTHUMB, newEvent.senderProfileImage ]]];
        
                [self.dataImages insertObject:info1 atIndex:indexPath.row];
            }
        
        
        
                [cell1.posted cleanPhotoFrame];
            if(info1.image)
           {
                [cell1.posted setImage:info1.image   ];
        
                [cell1.posted applyPhotoFrame];
            }
            else
            {
                cell1.posted.image=self.noImage;
               info1.notificationName=INVITEFRIENDPUSHLISTINGIMAGELOADED;
               info1.notifiedObject=[NSNumber numberWithInt:indexPath.row];
            if(!info1.isProcessing)
                [info1 getImage];
           }
        

    }
    else
    {
        
        
        ContactsUser *cContact;
    	
        /*if(!isSearchOn)
         cContact = (Contacts *)[fetchedResultsController objectAtIndexPath:indexPath];
         else
         cContact = (Contacts *)[fetchSearchResultsController objectAtIndexPath:indexPath];   */
        
        
        cContact=[self.dataAllArray objectAtIndex:indexPath.row];
        
        [self.alldelarr addObject:cContact];
        
       // UIView *cellview;
        
      //  cellview=[[UIView alloc] initWithFrame:CGRectMake(0,0,310,44)];
        
        UIView *separator;
        
       
        
      //  cellview.backgroundColor=self.whitecolor;
        
        
        
       // cell.backgroundView=cellview;
        
        
        
        NSArray *arr= [cell.contentView subviews];
        id lab;
        for(lab in arr)
        {
            [lab removeFromSuperview];
        }
        
       //   [cell.contentView addSubview:cellview];
        if (self.isiPad) {
            separator=[[UIView alloc] initWithFrame:CGRectMake(0,49,768,1)];
        }
        else
            separator=[[UIView alloc] initWithFrame:CGRectMake(0,49,320,1)];
        separator.backgroundColor=appDelegate.veryLightGrayColor;
        [cell.contentView addSubview:separator];
        
        
        
        UILabel *cname=[[UILabel alloc] initWithFrame:CGRectMake(55, 12, 155, 24)];
        
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
        
//        if (self.isiPad) {
//            postima.frame=CGRectMake(10, 6, 47, 47);
//        }
       // else{
            postima.frame=CGRectMake(10, 6, 37, 37);
        //}
        
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
            info1.notificationName=SELECTCONTACTIMAGELOADEDPUSHBY;
            info1.notifiedObject=[NSNumber numberWithInt:indexPath.row];
            if(!info1.isProcessing)
                [info1 getImage];
        }
        
        
        [cell.contentView addSubview:postima];
        
        UIImageView *addima;
        addima=[[UIImageView alloc] init];
        
        if (self.isiPad) {
            addima.frame=CGRectMake(680, 10, 74, 30);
        }
        else{
            addima.frame=CGRectMake(230, 10, 74, 30);
        }
        [addima setImage:[UIImage imageNamed:@"add_friend_img.png"]];
        [cell.contentView addSubview:addima];
        //cell.textLabel.font=font;
        
        /*UIImageView *nont;
        
        if(![self.contacts containsObject:cContact])
            
            nont=[[UIImageView alloc] initWithImage:self.nontick]; 
        else
            nont=[[UIImageView alloc] initWithImage:self.tick];
        
        nont.tag=10;
        nont.frame=CGRectMake(15, 14, 17, 17);*/
        
    }

}


-(void)acceptInvite:(UIButton*)sender
{
    if(loadStatus)
        return;
    
       self.loadStatus=1;
    
    
    
    PushByInviteFriendCell *cell=nil;
    
    if(appDelegate.isIos7)
    cell=(PushByInviteFriendCell*) sender.superview.superview.superview.superview;
    else
          cell=(PushByInviteFriendCell*) sender.superview.superview.superview;
    
    NSIndexPath *indexPath= [self.tabView indexPathForCell:cell ];
    
    self.lastSelIndexPath=indexPath;
    
    
    Invite *newinvite=[self.fetchedResultsController objectAtIndexPath:indexPath];
    
    NSLog(@"SecondaryIdLogIn1.1=%@",indexPath);
    NSLog(@"SecondaryIdLogIn2.1=%@",newinvite);
    
     NSString *str=nil;
     str=@"Accept";
    self.strInviteStatus=str;
    lastSelStatus=1;
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    
      NSLog(@"SecondaryIdLogIn1=%@",newinvite.postId);
       NSLog(@"SecondaryIdLogIn2=%@",newinvite.teamId);
    
    [command setObject:str forKey:@"status"];
    [command setObject:newinvite.teamId forKey:@"team_id"];
    [command setObject:newinvite.postId forKey:@"id"];
    
    [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    
    [self showNativeHudView];
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    
    
    self.requestDic=command;
    
    
   // [appDelegate sendRequestFor:INVITEFRIENDSSTATUS from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
 
    SingleRequest *sinReq=nil;
    sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:INVITEFRIENDSSTATUSLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
    self.sinReq1=sinReq;
    [self.storeCreatedRequests addObject:self.sinReq1];
    sinReq.notificationName=INVITEFRIENDSSTATUS;
    
    [sinReq startRequest];
}

-(void)declineInvite:(UIButton*)sender
{
    if(loadStatus)
        return;
    
    self.isDecline=YES;
    
    self.popupalertvwback.hidden=NO;
    self.popupAlertVwInvite.hidden=NO;
    
    PushByInviteFriendCell *cell=nil;
    
    if(appDelegate.isIos7)
        cell=(PushByInviteFriendCell*) sender.superview.superview.superview.superview;
    else
        cell=(PushByInviteFriendCell*) sender.superview.superview.superview;
    
    
    NSIndexPath *indexPath= [self.tabView indexPathForCell:cell ];
    self.lastSelIndexPath=indexPath;
    Invite *newinvite=[self.fetchedResultsController objectAtIndexPath:self.lastSelIndexPath];
    
    self.custompopuplabInvite.text=[NSString stringWithFormat:@"Are you sure you want to decline? You will not be able to view your friend's %@ moments",newinvite.teamSport];
}


-(void)userListUpdated:(id)sender
{
    
    loadStatus=0;
    [self hideNativeHudView];
    [self hideHudView];
    SingleRequest *sReq=(SingleRequest*)[sender object];
    if([sReq.notificationName isEqualToString:INVITEFRIENDSSTATUS])
    {
        
        NSLog(@"ResponseFriendInvite%@",sReq.responseString);
        
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
              
                        Invite *newEvent=[self.fetchedResultsController objectAtIndexPath:self.lastSelIndexPath];
                        
                        NSString *msgline=@"";
                        if ([self.strInviteStatus isEqualToString:@"Accept"])
                            msgline=[[NSString alloc] initWithFormat:@"Welcome to %@'s %@ %@ timeline.\nShare team moments with %@",newEvent.senderName,newEvent.teamName,newEvent.teamSport,newEvent.senderName];
                        else if ([self.strInviteStatus isEqualToString:@"Decline"])
                            msgline=[[NSString alloc] initWithFormat:@"Welcome to %@'s %@ %@ timeline for limited period.",newEvent.senderName,newEvent.teamName,newEvent.teamSport];
                        
                        
                        /*if(newEvent.type.intValue==4 )
                        {
                            if(delegate)
                            {
                                if([delegate respondsToSelector:@selector(didSelectInvite::)])
                                {
                                    [delegate didSelectFriendInvite:newEvent:self.popOver];
                                }
                            }
                        }*/
                       
                        
                        
                        
                      //  newEvent.inviteStatus=[[NSNumber alloc] initWithInt:lastSelStatus ];
                        [appDelegate.managedObjectContext deleteObject:newEvent];
                        
                        
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
                        
                        
                        [appDelegate.centerVC updateArrayByAddingOneTeam:newEvent.teamName :newEvent.teamId:[self.requestDic objectForKey:@"status"] :[NSNumber numberWithInt:0] :[ NSString stringWithFormat:@"%@%@", TEAM_LOGO_URL,[aDict objectForKey:@"team_logo"] ]:[aDict objectForKey:@"status_update"] :[NSMutableArray array]:micdic:teamSportN];
                        
                        
                       
                        
                        
                        
                          //  [appDelegate saveContext];
                        

                            
                       
                        
                        
                        
                        ///////////////////////
                        
                        /*NSArray *teamUpdateListing=[ aDict objectForKey:@"team_update_listing"];
                        
                        for(NSDictionary *diction in teamUpdateListing)
                        {
                            
                            Invite *invite=(Invite*)  [self objectOfTypeInvite:INVITE forTeam:newEvent.teamId forUpdate:3 forUpdateId:[diction objectForKey:@"update_id"] andManObjCon:self.managedObjectContext];
                            if(!invite)
                            {
                                NSLog(@"InInviteFriendStatusInUpdate");
                                
                                invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
                                
                                
                                
                                invite.teamName=newEvent.teamName;//[ aDict objectForKey:@"team_name"];
                                invite.teamId=newEvent.teamId;//[NSString stringWithFormat:@"%@", [ aDict objectForKey:@"team_id"] ];
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
                        
                        
                        
                        
                        //////////////////
                            
                       
                        [self goToTimeLine:msgline];
                        
                        //[self showAlertViewCustom:msgline];
                        
                    }
                    else
                    {
                        
                    }
                    
                }
                
            }
        }
        else
        {
            
            
        }
    }
    else
    {
        
    }
    
}



/*- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the managed object for the given index path
        
        
        ToDo *td= [self.fetchedResultsController objectAtIndexPath:indexPath];
        
      
        NSDictionary *dic;
        NSArray *notifications=[[UIApplication sharedApplication] scheduledLocalNotifications];
        
        UILocalNotification *notification;
     
       
            for (notification in notifications)
            {
                
                
                dic=[notification userInfo];
                
                
                
                if([[dic objectForKey:td.contacts.cMobile] isEqualToString:[appDelegate.dateFormatDb stringFromDate:td.date]])
                {
                    [[UIApplication sharedApplication] cancelLocalNotification:notification];
                    
                }
                
                
                
                
            }  
            
        
        
        
        
        
        
        
        
        [alldelarr removeObject:td];
        
        [appDelegate.managedObjectContext deleteObject:td];
        
        
        
        
        
        
        
        
        
        
        
        
        // Save the context.
        [appDelegate saveContext];
    }   
}*/




- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if(indexPath.section==1)
     {
    if(indexPath.row==[self.dataAllArray count])
    {
        return;
    }
         
        
             
             ContactsUser *aContact;
             aContact=[self.dataAllArray objectAtIndex:indexPath.row];
             
             
             [self/*.phFriend*/ populateField:aContact];//Add Latest Ch
             
             [self showAddAFriend];
        
         
     }
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (fetchedResultsController != nil)
    {
        NSMutableArray *arr1=[[fetchedResultsController fetchedObjects] mutableCopy];
        self.alldelarr=arr1;
        
        
        return fetchedResultsController;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    // Set up the fetched results controller.
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:INVITE inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    // [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
  
    NSPredicate *pre=[NSPredicate predicateWithFormat:@"type==%i",4];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"inviteStatus" ascending:YES /*selector:@selector(localizedCaseInsensitiveCompare:)*/];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    [fetchRequest setPredicate:pre];
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    //   
   //   [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"type == %@",[NSNumber numberWithBool:0]]];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil] ;
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	    /*
	     Replace this implementation with code to handle the error appropriately.
         
	     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
	     */
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    NSArray *arr= [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:nil ];
    NSMutableArray *arr1=[arr mutableCopy];
    self.alldelarr=arr1;
    
    return fetchedResultsController;
}    











- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    //[self.tabView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
        //    [self.tabView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
         //   [self.tabView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
           // [self.tabView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
           // [self.tabView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
           // [self configureCell:[self.tabView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
           /* [self.tabView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tabView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];*/
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
     NSLog(@"controllerDidChangeContent:2");
  //  [self.tabView endUpdates];
    //controller=nil;
    [self.dataImages removeAllObjects];
    [self.tabView reloadData];
    
    if(delegate )
    {
    if([delegate respondsToSelector:@selector(didChangeNumberOfFriendInvites:)])
    {
       NSArray *ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"inviteStatus==0"]];
        
        [delegate didChangeNumberOfFriendInvites:[NSString stringWithFormat:@"%i",ar.count]];
    }
    }
    
    if(self.fetchedResultsController.fetchedObjects.count>0)
    {
        self.nolbl.hidden=YES;
        self.nofriendinvitesimavw.hidden=YES;
        
        CGRect fr=  self.tabView.frame;
        fr.origin.y=0;
        fr.size.height=self.view.frame.size.height;   //// iAd 8/05
      //  fr.size.height=self.view.frame.size.height-50;
        self.tabView.frame=fr;//CGRectMake(self.tabView.frame.origin.x, 41, self.tabView.frame.size.width,380);
    }
    else
    {
        self.nolbl.hidden=NO;
       // self.nofriendinvitesimavw.hidden=NO;    /// 03/03/2015
        CGRect fr=  self.tabView.frame;
        if (self.isiPad) {
            fr.origin.y=305;
            fr.size.height=self.view.frame.size.height-300;
        }
        else{
            fr.origin.y=150;
            fr.size.height=self.view.frame.size.height-150;   //// iAd 8/05
          //  fr.size.height=self.view.frame.size.height-200;
        }
//        fr.origin.y=200;
//        fr.size.height=self.view.frame.size.height-200;
        self.tabView.frame=fr;//CGRectMake(self.tabView.frame.origin.x, 91, self.tabView.frame.size.width,330);
    }
}

/*- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    ToDo *todo= (ToDo *)[fetchedResultsController objectAtIndexPath:indexPath];
    
//    NSArray *arr1=[contacts.todo allObjects];
//    NSPredicate *pre=[NSPredicate predicateWithFormat:@"date>=%@",fmonthdate];
//    NSArray *arr2= [arr1 filteredArrayUsingPredicate:pre];
//    
//    
//    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES] autorelease];
//    
//    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor,nil];
//    
//    
//    ToDo *todo=[[arr2 sortedArrayUsingDescriptors:sortDescriptors] lastObject];
 
    
//    cell.textLabel.textColor=self.grayColor;
//     cell.detailTextLabel.textColor=self.redColor;
//     cell.textLabel.font=grayf;
//     cell.detailTextLabel.font=redf;
//     cell.textLabel.text=group.groupName;
//     
//     if(group.date!=nil)
//     cell.detailTextLabel.text=[NSString stringWithFormat:@"Last Update:%@",[appDelegate.dateFormatGr stringFromDate:group.date]];
    UIColor *cl=[UIColor clearColor];
    NSArray *arr= [cell.contentView subviews];
    id lab;
    for(lab in arr)
    {
        [lab removeFromSuperview];
    }
    UILabel *cname=[[UILabel alloc] initWithFrame:CGRectMake(65,4,200, 20)];
    cname.text=todo.contactName;
    cname.backgroundColor=cl;
    cname.font=grayf;
    cname.textColor=dGrayColor;
    [cell.contentView addSubview:cname];
    [cname release];
    
    UITextView *tView=[[UITextView alloc] initWithFrame:CGRectMake(57,24,200,22)];
    
    tView.editable=NO;
    if(todo !=nil)
        tView.text=todo.toDo;
    else
        tView.text=@"";
    
    tView.textColor=grayColor;
    tView.backgroundColor=cl;
    tView.font=redf;
    [cell.contentView addSubview:tView];
    [tView release];
    
    
    UILabel *cname1=[[UILabel alloc] initWithFrame:CGRectMake(65,48,200,14)];
    if(todo.date!=nil)
        cname1.text=[self getDateTime:[NSDate dateWithTimeInterval:300 sinceDate:todo.date]];
    else
        cname1.text=@"";   
    cname1.backgroundColor=cl;
    cname1.font=redf;
    cname1.textColor=grayColor;
    [cell.contentView addSubview:cname1];
    [cname1 release];
    
    
    
    
    UIImageView *aV;
    
    
    
    
    
    if(todo.contacts.cPhoto!=nil)
        aV=[[UIImageView alloc ] initWithImage:[UIImage imageWithData:todo.contacts.cPhoto]];
    else
        aV=[[UIImageView alloc ] initWithImage:[UIImage imageNamed:@"slid6_no image gray.png"]];
    
    aV.contentMode=UIViewContentModeScaleAspectFit;
    aV.frame=CGRectMake(8, 6, 47, 39);
    [cell.contentView addSubview:aV];
    [aV release];
    
    
    
//    UIImageView *aView=[[UIImageView alloc ] initWithImage:[UIImage imageNamed:@"Slid1_arow in crcl.png"]];
//    cell.accessoryView=aView;
//    [aView release];
 
    UIView *cellview;
    UIImageView *imaview;
    cellview=[[UIView alloc] initWithFrame:CGRectMake(0,0,320,65)];
    imaview=[[UIImageView alloc ] initWithImage:[UIImage imageNamed:@"slid6_gray bar.png"]];
    imaview.frame=CGRectMake(0,0,320,65);
    
    UIImageView *imaview1;
    imaview1=[[UIImageView alloc ] initWithImage:[UIImage imageNamed:@"slid3_mdl gray line.png"]];
    imaview1.frame=CGRectMake(0,63,320,2);
    
    
     NSLog(@"%@",todo.toDo);
    NSLog(@"%@",todo.firstWeekDate);
    
    [cellview addSubview:imaview];
    [cellview addSubview:imaview1];
    
    cell.backgroundView=cellview;
    [cellview release];
    [imaview release];
    [imaview1 release];
    
    
}*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)topBarAction:(id)sender
{
    int tag=[sender tag];
    
    if(tag==0)
    {
         [self.navigationController.view setHidden:YES];
        
        [appDelegate.centerViewController showNavController:appDelegate.navigationController];
    }
    else if(tag==1)
    {
        
        if(self.selContactNew.addAFriendVC.JSONDATAarr && self.selContactNew.addAFriendVC.JSONDATAarr.count>0)
        {
            [self.navigationController pushViewController:self.selContactNew animated:YES];
            
            [self.selContactNew resetData];
        }
        else
        {
            [self showAlertMessage:@"You need to belong to a team as a player to invite friends."];
        }
        
        
       
    }
    
    
}

@end
