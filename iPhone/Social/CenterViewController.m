//
//  WALLVC.m
//  Social
//
//  Created by Mindpace on 07/09/13.
//
//
#import "MessageVC.h"
#import "SelectContact.h"
#import "HomeVC.h"
#import "EventCalendarViewController.h"
#import "AddAFriend.h"
#import "SettingsViewController.h"
#import "CenterViewController.h"
#import "EventDetailsViewController.h"
#import "InviteDetailsViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "EventFilterPopOverViewController.h"
#import "ToDoByEventsVC.h"
#import "TeamMaintenanceVC.h"
#import "ChatMessageViewController.h"
#import "MyTeamsViewController.h"

@interface CenterViewController ()

@end

@implementation CenterViewController
@synthesize pusheventcontroller,pushinvitecontroller,isShowMainCalendarFirstScreeen,pushinvitefriendcontroller,invitefriendlabelbt;

@synthesize timelineima,
eventsima,
msgima,teamima,
invitesima,
notificationima,
timelineimasel,
eventsimasel,
msgimasel,teamimasel,
invitesimasel,
notificationimasel;



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
    //self.navigationController.navigationBar.layer.borderWidth=1.0;
  //  self.navigationController.navigationBar.layer.borderColor=[appDelegate.themeCyanColor CGColor];
    
 //   [appDelegate.leftVC view];
    
    // Make self the delegate of the ad banner.
 /*   self.adBanner.delegate = self;
    
    // Initially hide the ad banner.
    self.adBanner.alpha = 0.0; */
    @autoreleasepool {
        
        if (self.isiPad) {
            self.timelineima=[UIImage imageNamed:@"timelinetab_ipad.png"];
            self.eventsima=[UIImage imageNamed:@"eventtab_ipad.png"];
            self.teamima=[UIImage imageNamed:@"teamtab_ipad.png"];
            self.msgima=[UIImage imageNamed:@"messagetab_ipad.png"];
            self.invitesima=[UIImage imageNamed:@"finvitetab_ipad.png"];
            self.notificationima=[UIImage imageNamed:@"notificationtab_ipad.png"];
            self.timelineimasel=[UIImage imageNamed:@"timelinetabsel_ipad.png"];
            self.eventsimasel=[UIImage imageNamed:@"eventtabsel_ipad.png"];
            self.msgimasel=[UIImage imageNamed:@"messagetabsel_ipad.png"];
            self.teamimasel=[UIImage imageNamed:@"teamtabsel_ipad.png"];
            self.invitesimasel=[UIImage imageNamed:@"finvitetabsel_ipad.png"];
            self.notificationimasel=[UIImage imageNamed:@"notificationtabsel_ipad.png"];
        }
        else{
            self.timelineima=[UIImage imageNamed:@"timelinetab.png"];
            self.eventsima=[UIImage imageNamed:@"eventtab.png"];
            self.teamima=[UIImage imageNamed:@"teamtab.png"];
            self.msgima=[UIImage imageNamed:@"messagetab.png"];
            self.invitesima=[UIImage imageNamed:@"finvitetab.png"];
            self.notificationima=[UIImage imageNamed:@"notificationtab.png"];
            self.timelineimasel=[UIImage imageNamed:@"timelinetabsel.png"];
            self.eventsimasel=[UIImage imageNamed:@"eventtabsel.png"];
            self.msgimasel=[UIImage imageNamed:@"messagetabsel.png"];
            self.teamimasel=[UIImage imageNamed:@"teamtabsel.png"];
            self.invitesimasel=[UIImage imageNamed:@"finvitetabsel.png"];
            self.notificationimasel=[UIImage imageNamed:@"notificationtabsel.png"];
        }
    }
    [self.appDelegate.rightVC getAllUserDetailsFoRUser];
    
    self.coachupdatevw.hidden=YES;
    // Do any additional setup after loading the view from its nib.
    self.uptopbarvw.hidden=YES;
    
    [self setBarBlue];
    
    
   // CGRect navFrameRect=CGRectMake(0, 36, 320, 424);//Ch in xcode 5
    
    CGRect navFrameRect=CGRectMake(0, 0, 320, (self.view.bounds.size.height-49));
    
    if (self.isiPad) {
        navFrameRect=CGRectMake(0, 0, 768, (self.view.bounds.size.height-97));
    }
    
    
    
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    if(appDelegate.isIphone5)
    {
        //navFrameRect.size.height+=88;
    }
   
     self.appDelegate.navigationControllerAddAFriend.view.frame=navFrameRect;
    self.appDelegate.navigationController.view.frame=navFrameRect;
    self.appDelegate. navigationControllerCalendar.view.frame=navFrameRect;
    self.appDelegate.navigationControllerTeamMaintenance.view.frame=navFrameRect;
    self.appDelegate.navigationControllerMyTeams.view.frame=navFrameRect;  ////AD july For Myteam
    
    self.appDelegate.navigationControllerFindTeam.view.frame=navFrameRect;
    self.appDelegate.navigationControllerMyPhoto.view.frame=navFrameRect;
    self.appDelegate.navigationControllerSettings.view.frame=navFrameRect;
    self.appDelegate.navigationControllerClubLeague.view.frame=navFrameRect;
    self.appDelegate.navigationControllerMyContact.view.frame=navFrameRect;
    self.appDelegate.navigationControllerMySchdule.view.frame=navFrameRect;
      self.appDelegate.navigationControllerMyPhoto.view.frame=navFrameRect;
    self.appDelegate.navigationControllerTrainingVideo.view.frame=navFrameRect;
    self.appDelegate.navigationControllerBuySell.view.frame=navFrameRect;
    self.appDelegate.navigationControllerFaq.view.frame=navFrameRect;
    self.appDelegate.navigationControllerFeedBack.view.frame=navFrameRect;
    self.appDelegate.navigationControllerTutorial.view.frame=navFrameRect;
      self.appDelegate.navigationControllerTeamInvites.view.frame=navFrameRect;
    // self.appDelegate.navigationControllerEventNews.view.frame=navFrameRect;        //////  17/03/15 AD  ////
    self.appDelegate.navigationControllerChatMessage.view.frame=navFrameRect;
    self.appDelegate.navigationControllerTeamEvents.view.frame=navFrameRect;
    self.appDelegate.navigationControllerPrimaryMemeber.view.frame=navFrameRect;

    
    [self.view addSubview:self.appDelegate.navigationControllerClubLeague.view];

   [self.view addSubview:self.appDelegate.navigationControllerAddAFriend.view];
    [self.view addSubview:self.appDelegate.navigationController.view];
     [self.view addSubview:self.appDelegate. navigationControllerCalendar.view];
     [self.view addSubview:self.appDelegate.navigationControllerTeamMaintenance.view];
    [self.view addSubview:self.appDelegate.navigationControllerMyTeams.view];    ////AD july For Myteam
    
     [self.view addSubview:self.appDelegate.navigationControllerFindTeam.view];
     [self.view addSubview:self.appDelegate.navigationControllerMyPhoto.view];
     [self.view addSubview:self.appDelegate.navigationControllerSettings.view];
    [self.view addSubview:self.appDelegate.navigationControllerMyContact.view];
    [self.view addSubview:self.appDelegate.navigationControllerMySchdule.view];
     [self.view addSubview:self.appDelegate.navigationControllerMyPhoto.view];
    [self.view addSubview:self.appDelegate.navigationControllerTrainingVideo.view];
    [self.view addSubview:self.appDelegate.navigationControllerBuySell.view];
    [self.view addSubview:self.appDelegate.navigationControllerFaq.view];
    [self.view addSubview:self.appDelegate.navigationControllerFeedBack.view];
    [self.view addSubview:self.appDelegate.navigationControllerTutorial.view];
     [self.view addSubview:self.appDelegate.navigationControllerTeamInvites.view];
   //[self.view addSubview:self.appDelegate.navigationControllerEventNews.view];       //////  17/03/15 AD  ////
    [self.view addSubview:self.appDelegate.navigationControllerChatMessage.view];
    [self.view addSubview:self.appDelegate.navigationControllerTeamEvents.view];
    [self.view addSubview:self.appDelegate.navigationControllerPrimaryMemeber.view];

    [self showNavController:appDelegate.navigationController];
    
    
    /////////////////////
    
    /*PushByEventsVC *controller = [[PushByEventsVC alloc] initWithNibName:@"PushByEventsVC" bundle:nil];
    self.pusheventcontroller=controller;
    
    controller.delegate=self;
    
    [self.pusheventcontroller view];*/
    
    
    /*PushByInvitesVC *controller1 = [[PushByInvitesVC alloc] initWithNibName:@"PushByInvitesVC" bundle:nil];
    self.pushinvitecontroller=controller1;
    
    controller1.delegate=self;
   
    [self.pushinvitecontroller view];*/
    
    
    //////////////////////
    
    
    /*adVC.delegate=cVC;
     
     coachUpVC.delegate=cVC;
     
     [adVC view];
     [coachUpVC view];*/
    
    /*CGRect mm=  self.mainredtopbar.frame;
    
    mm.origin.y=(self.view.frame.size.height+self.view.frame.origin.y)-49;
    self.mainredtopbar.frame=mm;*/
  
    
    self.timelineimavw.image=self.timelineimasel;
    self.fsttablab.textColor=appDelegate.themeCyanColor;
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setStatusBarStyleOwnApp:1];
}


-(void)setBarBlue
{
    if(!appDelegate.isIos7 && !appDelegate.isIos8)
    {
        self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:((float) 0.0 / 255.0f)
                                                                          green:((float) 154.0 / 255.0f)
                                                                           blue:((float) 215.0 / 255.0f)
                                                                          alpha:1.0f];
        self.navigationController.navigationBar.translucent=NO;
    }
    else
    {
        //   [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"topBlueBar.png"]]];
        
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:((float) 0.0 / 255.0f)
                                                                      green:((float) 154.0 / 255.0f)
                                                                       blue:((float) 215.0 / 255.0f)
                                                                      alpha:1.0f]];
        
        self.navigationController.navigationBar.translucent=NO;
        
        if (self.isiPad) {
            [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:22.0]
                                                                   }];
        }
        else{
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:18.0]
                                                               }];
        }
        
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        
        // [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    }

}


-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)didChangeNumberOfEvents:(NSString*)number
{
    [self.calenderlabelbt setTitle:number forState:UIControlStateNormal];
    
    
    if([number intValue]>0)
        self.calenderlabelbt.hidden=NO;
    else
        self.calenderlabelbt.hidden=YES;
}

-(void)didSelectEvent:(Event*)newEvent :(FPPopoverController*)popOverController
{
      /*[popOverController dismissPopoverAnimated:YES];
    
    
    
    
    
    EventDetailsViewController *eVC=[[EventDetailsViewController alloc] initWithNibName:@"EventDetailsViewController" bundle:nil];
    
    NSLog(@"PushNewEvent=%@",newEvent);
    [self showNavController:appDelegate.navigationControllerCalendar];
    eVC.dataEvent=newEvent;
       [appDelegate.navigationControllerCalendar popToRootViewControllerAnimated:NO];
    [appDelegate.navigationControllerCalendar pushViewController:eVC animated:NO ];*/
}


-(void)didSelectInvite:(Invite*)newInvite :(FPPopoverController*)popOverController;
{
    [popOverController dismissPopoverAnimated:YES];
    
    
    
    
    
    InviteDetailsViewController *eVC=[[InviteDetailsViewController alloc] initWithNibName:@"InviteDetailsViewController" bundle:nil];
    
    NSLog(@"PushNewInvite=%@",newInvite);
    [self showNavController:appDelegate.navigationController];
    eVC.newinvite=newInvite;
    [appDelegate.navigationController popToRootViewControllerAnimated:NO];
    [appDelegate.navigationController pushViewController:eVC animated:NO ];
}





-(void)didChangeNumberOfInvites:(NSString*)number
{
    [self.postlabelbt setTitle:number forState:UIControlStateNormal];
    
    
    if([number intValue]>0)
        self.postlabelbt.hidden=NO;
    else
        self.postlabelbt.hidden=YES;
}


-(void)didChangeNumberMessage:(NSString*)number{
    
    [self.pendingMessage setTitle:number forState:UIControlStateNormal];
    
    if([number intValue]>0)
        self.pendingMessage.hidden=NO;
    else
        self.pendingMessage.hidden=YES;
    
}

-(void)didChangeNumberOfMainInvites:(NSString*)number
{
     NSLog(@"Totalunreadnumbers=%@",number);
    
  
    
    
    if([number intValue]>0)
        self.postlabelbt.hidden=NO;
    else
        self.postlabelbt.hidden=YES;
    
      [self.postlabelbt setTitle:number forState:UIControlStateNormal];
}


-(void)didSelectMainInvite:(Invite*)newInvite :(FPPopoverController*)popOverController
{
    
}


-(void)didChangeNumberOfFriendInvites:(NSString*)number
{
    NSLog(@"didChangeNumberOfFriendInvitesInCenterVC=%@",number);
    
    
   
    
    
    if([number intValue]>0)
        self.invitefriendlabelbt.hidden=NO;
    else
        self.invitefriendlabelbt.hidden=YES;
    
    
      NSLog(@"didChangeNumberOfFriendInvitesInCenterVC=%@",number);
    
     [self.invitefriendlabelbt setTitle:number forState:UIControlStateNormal];
    
    
}

-(void)didSelectFriendInvite:(Invite*)newInvite :(FPPopoverController*)popOverController
{
    
    
    
    
}



-(void)didChangeNumberOfCoachUpdates:(NSString*)number
{
    [self.coachupdatelabelbt setTitle:number forState:UIControlStateNormal];
    
    
    if([number intValue]>0)
        self.coachupdatelabelbt.hidden=NO;
    else
        self.coachupdatelabelbt.hidden=YES;
}

-(void)didSelectCoachUpdates:(Invite *)newInvite :(FPPopoverController *)popOverController
{
    
    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)showNavController:(UINavigationController*)navigationController
{
    [self enableSlidingAndShowTopBar];
   // appDelegate.slidePanelController.recognizesPanGesture=YES;
    
    [self disableMySwipes];
    
    
    if([appDelegate.navigationControllerTeamMaintenance isEqual:navigationController])
    {
        appDelegate.navigationControllerTeamMaintenance.view.hidden=NO;
        
        [self.view bringSubviewToFront:appDelegate.navigationControllerTeamMaintenance.view];
        
        TeamMaintenanceVC *teamVc=  (TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0];
        teamVc.isShowFristTime=YES;
        
        
        //////////////ADDDEB
        
        //teamVc.isShowFromNotification=NO;     //// AD 19th june

      /*  [[NSNotificationCenter defaultCenter] postNotificationName:SHOWNAVIGATIONCONTROLLERCHATMESSAGE object:nil];
        ChatMessageViewController *chat=(ChatMessageViewController *)[appDelegate.navigationControllerChatMessage.viewControllers objectAtIndex:0];
        [chat getUpdatedRegisterUserListing];*/
        
       // return;
        
        //[self setTabBar:0 :5];
    }
    else
    {
        appDelegate.navigationControllerTeamMaintenance.view.hidden=YES;
        
    }
    
    //////   AD july For Myteam  //////
    
    if([appDelegate.navigationControllerMyTeams isEqual:navigationController])
    {
        appDelegate.navigationControllerMyTeams.view.hidden=NO;
        
        [self.view bringSubviewToFront:appDelegate.navigationControllerMyTeams.view];
        
      //  MyTeamsViewController *teamVc=  (MyTeamsViewController*)[self.appDelegate.navigationControllerMyTeams.viewControllers objectAtIndex:0];
       // teamVc.isShowFristTime=YES;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:SHOWNAVIGATIONCONTROLLERMYTEAMS object:nil];
        //////////////ADDDEB
        
        //teamVc.isShowFromNotification=NO;     //// AD 19th june
        
        /*  [[NSNotificationCenter defaultCenter] postNotificationName:SHOWNAVIGATIONCONTROLLERCHATMESSAGE object:nil];
         ChatMessageViewController *chat=(ChatMessageViewController *)[appDelegate.navigationControllerChatMessage.viewControllers objectAtIndex:0];
         [chat getUpdatedRegisterUserListing];*/
        
        // return;
        
        [self setTabBar:0 :5];
    }
    else
    {
        appDelegate.navigationControllerMyTeams.view.hidden=YES;
        
    }
    
    ///////////// AD   ////////
    
    if([appDelegate.navigationControllerChatMessage isEqual:navigationController])
    {
        appDelegate.navigationControllerChatMessage.view.hidden=NO;
        
        [self.view bringSubviewToFront:appDelegate.navigationControllerChatMessage.view];
        [[NSNotificationCenter defaultCenter] postNotificationName:SHOWNAVIGATIONCONTROLLERCHATMESSAGE object:nil];
        ChatMessageViewController *chat=(ChatMessageViewController *)[appDelegate.navigationControllerChatMessage.viewControllers objectAtIndex:0];
        [chat getUpdatedRegisterUserListing];
        
        //// AD...iAd
        chat.adBanner.delegate = self;
        chat.adBanner.alpha = 0.0;
        chat.canDisplayBannerAds=YES;
        ////
        // return;
        
        [self setTabBar:0 :2];
    }
    else
    {
        appDelegate.navigationControllerChatMessage.view.hidden=YES;
        
    }
    //////  change the message //////

    
    if([appDelegate.navigationControllerPrimaryMemeber isEqual:navigationController])
    {
        appDelegate.navigationControllerPrimaryMemeber.view.hidden=NO;
        
        [self.view bringSubviewToFront:appDelegate.navigationControllerPrimaryMemeber.view];
        [[NSNotificationCenter defaultCenter] postNotificationName:SHOWNAVIGATIONCONTROLLERPRIMARYMEMBER object:nil];
        
    }
    else
    {
        appDelegate.navigationControllerPrimaryMemeber.view.hidden=YES;
        
    }

    
   

    if([appDelegate.navigationControllerEventNews isEqual:navigationController])
    {
        appDelegate.navigationControllerEventNews.view.hidden=NO;
        [appDelegate.slidePanelController showCenterPanelAnimated:YES];
        
        
         [self.view bringSubviewToFront:appDelegate.navigationControllerEventNews.view];
        return;
    }
    else
    {
        appDelegate.navigationControllerEventNews.view.hidden=YES;
    }
    
    
    
    
    if([appDelegate.navigationControllerTeamInvites isEqual:navigationController])
    {
        appDelegate.navigationControllerTeamInvites.view.hidden=NO;
        [appDelegate.slidePanelController showCenterPanelAnimated:YES];
        
        
         [self.view bringSubviewToFront:appDelegate.navigationControllerTeamInvites.view];
          [[NSNotificationCenter defaultCenter] postNotificationName:SHOWNAVIGATIONCONTROLLERNOTIFICATION object:nil];
        
        //return;
           [self setTabBar:0 :4];
    }
    else
    {
        appDelegate.navigationControllerTeamInvites.view.hidden=YES;
    }
    
    
    
  

    
    if([appDelegate.navigationControllerAddAFriend isEqual:navigationController])
    {
        appDelegate.navigationControllerAddAFriend.view.hidden=NO;
        
         [self.view bringSubviewToFront:appDelegate.navigationControllerAddAFriend.view];
        
      //  return;
         [[NSNotificationCenter defaultCenter] postNotificationName:SHOWNAVIGATIONCONTROLLERADDFRIEND object:nil];
        
           [self setTabBar:0 :5];
    }
    else
    {
        appDelegate.navigationControllerAddAFriend.view.hidden=YES;
        
         if([appDelegate.aDef objectForKey:ISFIRSTTIMEENTERADDFRIEND])
         {
             [appDelegate setUserDefaultValue:@"1" ForKey:ISFIRSTTIMESHOWPLUSINADDFRIEND];
         }
       
    }
    
    
    if([appDelegate.navigationControllerCoachUpdate isEqual:navigationController])
    {
        appDelegate.navigationControllerCoachUpdate.view.hidden=NO;
        
         [self.view bringSubviewToFront:appDelegate.navigationControllerCoachUpdate.view];
        
        return;
    }
    else
    {
        appDelegate.navigationControllerCoachUpdate.view.hidden=YES;
        
    }
    
    
    if([appDelegate.navigationControllerFeedBack isEqual:navigationController])
    {
        appDelegate.navigationControllerFeedBack.view.hidden=NO;
        [appDelegate.slidePanelController showCenterPanelAnimated:YES];
         [self setTabBar:1 :0];
        [appDelegate.leftVC selectTableViewIndex:2 :1];
        [self.view bringSubviewToFront:appDelegate.navigationControllerFeedBack.view];
        [[NSNotificationCenter defaultCenter] postNotificationName:SHOWNAVIGATIONCONTROLLERFEEDBACK object:nil];
        
    }
    else
    {
        [appDelegate.leftVC selectTableViewIndex:2 :0];
        appDelegate.navigationControllerFeedBack.view.hidden=YES;
    }
    

    
    
    
    
    
    if([appDelegate.navigationControllerMyPhoto isEqual:navigationController])
    {
        appDelegate.navigationControllerMyPhoto.view.hidden=NO;
        
         [self.view bringSubviewToFront:appDelegate.navigationControllerMyPhoto.view];
    }
    else
        appDelegate.navigationControllerMyPhoto.view.hidden=YES;
    
    
    if([appDelegate.navigationController isEqual:navigationController])
    {
        appDelegate.navigationController.view.hidden=NO;
        
        [self.view bringSubviewToFront:appDelegate.navigationController.view];
        
        // [appDelegate.leftVC selectTableViewIndex:0 :1];
        
        // appDelegate.slidePanelController.recognizesPanGesture=NO;
        
        [self enableMyHomeSwipe];
        [[NSNotificationCenter defaultCenter] postNotificationName:SHOWNAVIGATIONCONTROLLER object:nil];
        
        [self setTabBar:0 :0];
    }
    else
    {
        appDelegate.navigationController.view.hidden=YES;
        
        //  [appDelegate.leftVC selectTableViewIndex:0 :0];
        
    }
    
    if([appDelegate.navigationControllerCalendar isEqual:navigationController])
    {
        EventCalendarViewController *calVC=[appDelegate.navigationControllerCalendar.viewControllers objectAtIndex:0];
        
        if(isShowMainCalendarFirstScreeen)
        {
            isShowMainCalendarFirstScreeen=0;
            [calVC showFirstEnterView:1];
        }
        else
        {
             [calVC showFirstEnterView:0];
        }
        
           [calVC setOwnViewDependOnFlag:0];
        
        
         appDelegate.navigationControllerCalendar.view.hidden=NO;
        
         [self.view bringSubviewToFront:appDelegate.navigationControllerCalendar.view];
        
       // [appDelegate.leftVC selectTableViewIndex:2 :1];
        
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:SHOWNAVIGATIONCONTROLLERCALENDAR object:nil];
        
           [self setTabBar:0 :1];
      
    }
    else
    {
         appDelegate.navigationControllerCalendar.view.hidden=YES;
        
      //  [appDelegate.leftVC selectTableViewIndex:2 :0];
    }
    
    
    
    
    
    if([appDelegate.navigationControllerTeamMaintenance isEqual:navigationController])
    {
        
        appDelegate.navigationControllerTeamMaintenance.view.hidden=NO;
        
        [self.view bringSubviewToFront:appDelegate.navigationControllerTeamMaintenance.view];
        
        [(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] checkNoteam];
        TeamMaintenanceVC *temaMainTanceVc=(TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0];    ///// AD ////
        temaMainTanceVc.isShowFristTime=YES;     ///// AD ////
        
        [self enableMyTeamSwipe];
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:SHOWNAVIGATIONCONTROLLERTEAMMAINTANCE object:nil];
    }
    else
    {
        appDelegate.navigationControllerTeamMaintenance.view.hidden=YES;
        
        
       // [appDelegate.leftVC selectTableViewIndex:4 :0];
    }
    
    if([appDelegate.navigationControllerTeamEvents isEqual:navigationController])
    {
        
        appDelegate.navigationControllerTeamEvents.view.hidden=NO;
        
        [self.view bringSubviewToFront:appDelegate.navigationControllerTeamEvents.view];
        
        //[appDelegate.leftVC selectTableViewIndex:3 :1];
    }
    else
    {
        appDelegate.navigationControllerTeamEvents.view.hidden=YES;
        
        //[appDelegate.leftVC selectTableViewIndex:3 :0];
    }
    
  
    if([appDelegate.navigationControllerTrainingVideo isEqual:navigationController])
    {
        appDelegate.navigationControllerTrainingVideo.view.hidden=NO;
        
         [self.view bringSubviewToFront:appDelegate.navigationControllerTrainingVideo.view];
    }
    else
        appDelegate.navigationControllerTrainingVideo.view.hidden=YES;
    
    if([appDelegate.navigationControllerClubLeague isEqual:navigationController])
    {
        appDelegate.navigationControllerClubLeague.view.hidden=NO;
        
         [self.view bringSubviewToFront:appDelegate.navigationControllerClubLeague.view];
    }
    else
        appDelegate.navigationControllerClubLeague.view.hidden=YES;
    
    if([appDelegate.navigationControllerMyContact isEqual:navigationController])
    {
        appDelegate.navigationControllerMyContact.view.hidden=NO;
        
         [self.view bringSubviewToFront:appDelegate.navigationControllerMyContact.view];
    }
    else
        appDelegate.navigationControllerMyContact.view.hidden=YES;
    
    if([appDelegate.navigationControllerMySchdule isEqual:navigationController])
    {
        appDelegate.navigationControllerMySchdule.view.hidden=NO;
        
        
         [self.view bringSubviewToFront:appDelegate.navigationControllerMySchdule.view];
    }
    else
        appDelegate.navigationControllerMySchdule.view.hidden=YES;

    
    if([appDelegate.navigationControllerBuySell isEqual:navigationController])
    {
        appDelegate.navigationControllerBuySell.view.hidden=NO;
        
         [self.view bringSubviewToFront:appDelegate.navigationControllerBuySell.view];
    }
    else
        appDelegate.navigationControllerBuySell.view.hidden=YES;
    
   

    
    if([appDelegate.navigationControllerFindTeam isEqual:navigationController])
    {
         appDelegate.navigationControllerFindTeam.view.hidden=NO;
        
        
         [self.view bringSubviewToFront:appDelegate.navigationControllerFindTeam.view];
    }
    else
         appDelegate.navigationControllerFindTeam.view.hidden=YES;
    
    if([appDelegate.navigationControllerMyPhoto isEqual:navigationController])
    {
         appDelegate.navigationControllerMyPhoto.view.hidden=NO;
        
         [self.view bringSubviewToFront:appDelegate.navigationControllerMyPhoto.view];
          [[NSNotificationCenter defaultCenter] postNotificationName:SHOWNAVIGATIONCONTROLLERPHOTOALBUM object:nil];
         [self setTabBar:1 :0];
        [appDelegate.leftVC selectTableViewIndex:0 :1];
        
        
    }
    else
    {
         appDelegate.navigationControllerMyPhoto.view.hidden=YES;
        
        [appDelegate.leftVC selectTableViewIndex:0 :0];
        
    }
    
    if([appDelegate.navigationControllerFaq isEqual:navigationController])
    {
        appDelegate.navigationControllerFaq.view.hidden=NO;
        
         [self setTabBar:1 :0];
        [appDelegate.leftVC selectTableViewIndex:3 :1];
        [self.view bringSubviewToFront:appDelegate.navigationControllerFaq.view];
        [[NSNotificationCenter defaultCenter] postNotificationName:SHOWNAVIGATIONCONTROLLERFAQ object:nil];
    }
    else
    {
        [appDelegate.leftVC selectTableViewIndex:3 :0];
        appDelegate.navigationControllerFaq.view.hidden=YES;
        
    }
    
    ////////  24/02/2015 /////
    
    if([appDelegate.navigationControllerTutorial isEqual:navigationController])
    {
        appDelegate.navigationControllerTutorial.view.hidden=NO;
        //[appDelegate.slidePanelController showCenterPanelAnimated:YES];
        [self setTabBar:1 :0];
        [appDelegate.leftVC selectTableViewIndex:4 :1];
        [self.view bringSubviewToFront:appDelegate.navigationControllerTutorial.view];
        [[NSNotificationCenter defaultCenter] postNotificationName:SHOWNAVIGATIONCONTROLLERTUTORIAL object:nil];
        
    }
    else
    {
        [appDelegate.leftVC selectTableViewIndex:4 :0];
        appDelegate.navigationControllerTutorial.view.hidden=YES;
    }

    
    
    
    
    
   /* if([appDelegate.navigationControllerChatMessage isEqual:navigationController])
    {
        appDelegate.navigationControllerChatMessage.view.hidden=NO;
        
        [self setTabBar:1 :0];
        [appDelegate.leftVC selectTableViewIndex:4 :1];
        [self.view bringSubviewToFront:appDelegate.navigationControllerChatMessage.view];
        [[NSNotificationCenter defaultCenter] postNotificationName:SHOWNAVIGATIONCONTROLLERCHATMESSAGE object:nil];
        ChatMessageViewController *chat=(ChatMessageViewController *)[appDelegate.navigationControllerChatMessage.viewControllers objectAtIndex:0];
        [chat getUpdatedRegisterUserListing];
        
        // return;
        
        
    }
    else
    {
        [appDelegate.leftVC selectTableViewIndex:4 :0];
        appDelegate.navigationControllerChatMessage.view.hidden=YES;
        
    }*/
    
    ////////////   AD   ////////////
    
    if([appDelegate.navigationControllerSettings isEqual:navigationController])
    {
        appDelegate.navigationControllerSettings.view.hidden=NO;
        [[appDelegate.navigationControllerSettings.viewControllers objectAtIndex:0] populateData];
        
        [self.view bringSubviewToFront:appDelegate.navigationControllerSettings.view];
        [[NSNotificationCenter defaultCenter] postNotificationName:SHOWNAVIGATIONCONTROLLERSETTINGS object:nil];
        
        
        [self setTabBar:1 :0];
        [appDelegate.leftVC selectTableViewIndex:1 :1];
    }
    else
    {
        appDelegate.navigationControllerSettings.view.hidden=YES;
        
        [appDelegate.leftVC selectTableViewIndex:1 :0];
    }
    
   
    
    
    [appDelegate.slidePanelController showCenterPanelAnimated:YES];
    
    
     [self.view bringSubviewToFront:self.tabBarContainervw];
}

-(void)presentViewControllerForModal:(UIViewController*)vc{
    
    [self presentViewController:vc animated:YES completion:nil];
}


-(BOOL)getShowStatus:(UINavigationController*)navigationController
{
    BOOL flag=1;
    
    
    if(!([appDelegate.navigationControllerChatMessage isEqual:navigationController] && appDelegate.navigationControllerChatMessage))
    {
        
        if(appDelegate.navigationControllerChatMessage.view.hidden==NO)
        {
            flag=0;
        }
        
    }
    
    if(!([appDelegate.navigationControllerEventNews isEqual:navigationController] && appDelegate.navigationControllerEventNews))
    {
        if(appDelegate.navigationControllerEventNews.view.hidden==NO)
        {
            flag=0;
        }
    }
    if(!([appDelegate.navigationControllerTeamInvites isEqual:navigationController] && appDelegate.navigationControllerTeamInvites))
    {
        if(appDelegate.navigationControllerTeamInvites.view.hidden==NO)
        {
            flag=0;
        }
    }
    
    if(!([appDelegate.navigationControllerAddAFriend isEqual:navigationController] && appDelegate.navigationControllerAddAFriend))
    {
        if(appDelegate.navigationControllerAddAFriend.view.hidden==NO)
        {
            flag=0;
        }
    }
    if(!([appDelegate.navigationControllerCoachUpdate isEqual:navigationController] && appDelegate.navigationControllerCoachUpdate))
    {
        if(appDelegate.navigationControllerCoachUpdate.view.hidden==NO)
        {
            flag=0;
        }
    }
    if(!([appDelegate.navigationControllerFeedBack isEqual:navigationController] && appDelegate.navigationControllerFeedBack))
    {
        if(appDelegate.navigationControllerFeedBack.view.hidden==NO)
        {
            flag=0;
        }
    }
    if(!([appDelegate.navigationControllerMyPhoto isEqual:navigationController] && appDelegate.navigationControllerMyPhoto))
    {
        if(appDelegate.navigationControllerMyPhoto.view.hidden==NO)
        {
            flag=0;
        }
    }
    if(!([appDelegate.navigationController isEqual:navigationController] && appDelegate.navigationController))
    {
        if(appDelegate.navigationController.view.hidden==NO)
        {
            flag=0;
        }
    }
    if(!([appDelegate.navigationControllerCalendar isEqual:navigationController] && appDelegate.navigationControllerCalendar))
    {
        if(appDelegate.navigationControllerCalendar.view.hidden==NO)
        {
            flag=0;
        }
    }
    if(!([appDelegate.navigationControllerTeamMaintenance isEqual:navigationController] && appDelegate.navigationControllerTeamMaintenance))
    {
        if(appDelegate.navigationControllerTeamMaintenance.view.hidden==NO)
        {
            flag=0;
        }
    }
    if(!([appDelegate.navigationControllerTeamEvents isEqual:navigationController] && appDelegate.navigationControllerTeamEvents))
    {
        if(appDelegate.navigationControllerTeamEvents.view.hidden==NO)
        {
            flag=0;
        }
    }
    if(!([appDelegate.navigationControllerTrainingVideo isEqual:navigationController] && appDelegate.navigationControllerTrainingVideo))
    {
        if(appDelegate.navigationControllerTrainingVideo.view.hidden==NO)
        {
            flag=0;
        }
    }
    if(!([appDelegate.navigationControllerClubLeague isEqual:navigationController] && appDelegate.navigationControllerClubLeague))
    {
        if(appDelegate.navigationControllerClubLeague.view.hidden==NO)
        {
            flag=0;
        }
    }
    if(!([appDelegate.navigationControllerMyContact isEqual:navigationController] && appDelegate.navigationControllerMyContact))
    {
        if(appDelegate.navigationControllerMyContact.view.hidden==NO)
        {
            flag=0;
        }
    }
    if(!([appDelegate.navigationControllerMySchdule isEqual:navigationController] && appDelegate.navigationControllerMySchdule))
    {
        if(appDelegate.navigationControllerMySchdule.view.hidden==NO)
        {
            flag=0;
        }
    }
    if(!([appDelegate.navigationControllerBuySell isEqual:navigationController] && appDelegate.navigationControllerBuySell))
    {
        if(appDelegate.navigationControllerBuySell.view.hidden==NO)
        {
            flag=0;
        }
    }
   
    if(!([appDelegate.navigationControllerFindTeam isEqual:navigationController] && appDelegate.navigationControllerFindTeam))
    {
        
        if(appDelegate.navigationControllerFindTeam.view.hidden==NO)
        {
            flag=0;
        }
    }
    if(!([appDelegate.navigationControllerMyPhoto isEqual:navigationController] && appDelegate.navigationControllerMyPhoto))
    {
        if(appDelegate.navigationControllerMyPhoto.view.hidden==NO)
        {
            flag=0;
        }
    }
    if(!([appDelegate.navigationControllerFaq isEqual:navigationController] && appDelegate.navigationControllerFaq))
    {
        if(appDelegate.navigationControllerFaq.view.hidden==NO)
        {
            flag=0;
        }
    }
    
    if(!([appDelegate.navigationControllerTutorial isEqual:navigationController] && appDelegate.navigationControllerTutorial))
    {
        if(appDelegate.navigationControllerTutorial.view.hidden==NO)
        {
            flag=0;
        }
    }
    
    if(!([appDelegate.navigationControllerSettings isEqual:navigationController] && appDelegate.navigationControllerSettings))
    {
        if(appDelegate.navigationControllerSettings.view.hidden==NO)
        {
            flag=0;
        }
    }
    
    return flag;
    
}


-(void)setTabBar:(BOOL)isReset :(int)setIndex
{
    self.timelineimavw.image=self.timelineima;
    self.fsttablab.textColor=self.lightgraycolor;
    self.eventsimavw.image=self.eventsima;
    self.sectablab.textColor=self.lightgraycolor;
    self.msgimavw.image=self.msgima;
    self.teamimavw.image=self.teamima;
    self.msgtablab.textColor=self.lightgraycolor;
    self.teamtablab.textColor=self.lightgraycolor;
    self.invitesimavw.image=self.invitesima;
    self.invtablab.textColor=self.lightgraycolor;
    self.notificationimavw.image=self.notificationima;
    self.notificlab.textColor=self.lightgraycolor;
    
    
    if(!isReset)
    {
        
        if(setIndex==0)
        {
            self.timelineimavw.image=self.timelineimasel;
            self.fsttablab.textColor=self.appDelegate.themeCyanColor;
        }
        else if(setIndex==1)
        {
            self.eventsimavw.image=self.eventsimasel;
            self.sectablab.textColor=appDelegate.themeCyanColor;
            
        }
        else if(setIndex==2)
        {
            self.msgimavw.image=self.msgimasel;
            self.msgtablab.textColor=self.appDelegate.themeCyanColor;
            
        }
        else if(setIndex==5)
        {
            self.teamimavw.image=self.teamimasel;
            self.teamtablab.textColor=self.appDelegate.themeCyanColor;
            
        }
        else if(setIndex==3)
        {
            self.invitesimavw.image=self.invitesimasel;
            self.invtablab.textColor=self.appDelegate.themeCyanColor;
        }
        else if(setIndex==4)
        {
            self.notificationimavw.image=self.notificationimasel;
            self.notificlab.textColor=self.appDelegate.themeCyanColor;
            
        }
    }
}

-(IBAction)topbarbtapped:(id)sender
{
    
    MainInviteVC *mainvc= (MainInviteVC*)[appDelegate.navigationControllerTeamInvites.viewControllers objectAtIndex:0];
    
    NSLog(@"topbarbtapped====%i",  mainvc.teamInvitesVC.fetchedResultsController.fetchedObjects.count);
    
    
    
    
    
    
    int tag=[sender tag];
    
    
       [appDelegate.leftVC resetTableViewIndex];
    
  
    
    if(tag==0)
    {
        /*[appDelegate.navigationControllerEventNews popToRootViewControllerAnimated:NO];
        [self showNavController:appDelegate.navigationControllerEventNews];*/
         [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationController];
        
        
       
    }
    else if(tag==1)
    {
        [appDelegate.navigationControllerTeamInvites popToRootViewControllerAnimated:NO];
        [self showNavController:appDelegate.navigationControllerTeamInvites];
        
        
        
    }
    else if(tag==2)
    {

        
         if( [[self.appDelegate.navigationControllerAddAFriend.viewControllers lastObject] isMemberOfClass:[SelectContact class]])
         {
             [(SelectContact*)[self.appDelegate.navigationControllerAddAFriend.viewControllers lastObject] backf:nil];
         }
        
        
         // [appDelegate.navigationControllerAddAFriend popToRootViewControllerAnimated:NO];
     //   [adF.tbllView reloadData];
        NSLog(@"1.%@",appDelegate.navigationControllerAddAFriend);
        
      //  [self presentViewController:appDelegate.navigationControllerAddAFriend animated:YES completion:nil ];
       PushByInviteFriendVC *fVC= [self.appDelegate.navigationControllerAddAFriend.viewControllers objectAtIndex:0];
        [fVC.tabView reloadData];
        
        
        if(![appDelegate.aDef objectForKey:ISFIRSTTIMEENTERADDFRIEND])
            [appDelegate setUserDefaultValue:@"1" ForKey:ISFIRSTTIMEENTERADDFRIEND];
        
        [self showNavController:appDelegate.navigationControllerAddAFriend];
        
        //[(AddAFriend*)[appDelegate.navigationControllerAddAFriend.viewControllers objectAtIndex:0] loadTeamData];
        [(PushByInviteFriendVC*)[appDelegate.navigationControllerAddAFriend.viewControllers objectAtIndex:0] requestServerData];
        
        
        
    }
    else if(tag==3)
    {
        EventCalendarViewController *eVC=(EventCalendarViewController*) [appDelegate.navigationControllerCalendar.viewControllers objectAtIndex:0];
        [appDelegate.navigationControllerCalendar popToRootViewControllerAnimated:NO];
        // self.segmentbottom.selectedSegmentIndex=0;
        eVC.evpopVC.datelab.font=self.helveticaFont;
        eVC.evpopVC.teamandeventlab.font=self.helveticaFont;
        eVC.evpopVC.playerlab.font=self.helveticaFont;
        eVC.evpopVC.statuslab.font=self.helveticaFont;
        
        
        
        
        eVC.eventheaderlab.text=CREATETEAMEVENTINVITATION;
        eVC.isMonth=0;
        eVC.topSegCntrl.selectedSegmentIndex=eVC.isMonth;
        
        eVC.custompopuptopselectionvw.hidden=YES;
        eVC.custompopupbottomvw.hidden=YES;
        eVC.callistvc.fetchFirstDate=nil;
        eVC.callistvc.fetchLastDate=nil;
        eVC.callistvc.selTeamId=nil;
        eVC.callistvc.selplayerId=nil;
        eVC.callistvc.selShowByStatus=0;
        eVC.callistvc.isSelShowByStatus=0;
        eVC.callistvc.fetchedResultsController=nil;
        [eVC.callistvc loadTable];
        eVC.calvc.view.hidden=YES;
        eVC.callistvc.view.hidden=NO;
        
        eVC.downarrowfilterimavw.hidden=NO;
        eVC.downarrowfilterbt.hidden=NO;
        
        [eVC.calvc.monthView reloadData];
        
        [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerCalendar];
        
       
       
       
    }
    else if(tag==5)
    {
        
        
        
        
        /////  change message to roster  18/02/2015 /////
        
        
        
        [appDelegate.navigationControllerChatMessage popToRootViewControllerAnimated:NO];
        
        [(ChatMessageViewController*)[self.appDelegate.navigationControllerChatMessage.viewControllers objectAtIndex:0] refreshChatMessageList];
        
        [self showNavController:appDelegate.navigationControllerChatMessage];
        
        
        //[self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerTeamMaintenance];
        
        
       
     
    }
    else if(tag==4)
    {
        
        ////// AD 24th june FOR Friend Request ///
        
        if (invitefriendlabelbt.titleLabel.text.length>0 && invitefriendlabelbt.hidden==NO) {
            
            /*UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"" message:@"You have new Friend Requests. Do you want to view them?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
            [av show];*/
            
            if( [[self.appDelegate.navigationControllerAddAFriend.viewControllers lastObject] isMemberOfClass:[SelectContact class]])
            {
                [(SelectContact*)[self.appDelegate.navigationControllerAddAFriend.viewControllers lastObject] backf:nil];
            }
            
            
            // [appDelegate.navigationControllerAddAFriend popToRootViewControllerAnimated:NO];
            //   [adF.tbllView reloadData];
            NSLog(@"1.%@",appDelegate.navigationControllerAddAFriend);
            
            //  [self presentViewController:appDelegate.navigationControllerAddAFriend animated:YES completion:nil ];
            PushByInviteFriendVC *fVC= [self.appDelegate.navigationControllerAddAFriend.viewControllers objectAtIndex:0];
            [fVC.tabView reloadData];
            
            
            if(![appDelegate.aDef objectForKey:ISFIRSTTIMEENTERADDFRIEND])
                [appDelegate setUserDefaultValue:@"1" ForKey:ISFIRSTTIMEENTERADDFRIEND];
            
            [self showNavController:appDelegate.navigationControllerAddAFriend];

            
            
            
            return;
            
        }
        
        ////////   AD july For Myteam    ///////
        
        if(appDelegate.centerVC.dataArrayUpButtonsIds.count==0 || ![appDelegate.aDef objectForKey:ISEXISTOWNTEAM])
        {
                [self setTabBar:0 :5];
                [self performSelector:@selector(afterDelay:) withObject:nil afterDelay:0.0];
                return;
        }
        
        if(([appDelegate.aDef objectForKey:ISEXISTOWNTEAM]) && (appDelegate.centerVC.dataArrayUpButtonsIds.count>0) )
        {
            
            if (self.appDelegate.JSONDATAarr.count==1) {
                [self setTabBar:0 :5]; 
                [self performSelector:@selector(afterDelay:) withObject:nil afterDelay:0.0];
                return;
            }
            
            self.timelineimavw.image=self.appDelegate.centerViewController.timelineima;
            self.fsttablab.textColor=self.lightgraycolor;
            
            
            if([[appDelegate.navigationControllerMyTeams.viewControllers lastObject] isMemberOfClass:[MyTeamsViewController class]])
                [(MyTeamsViewController*)[appDelegate.navigationControllerMyTeams.viewControllers objectAtIndex:0] loadMyTeamData];
            MyTeamsViewController *teamVc=  (MyTeamsViewController*)[self.appDelegate.navigationControllerMyTeams.viewControllers objectAtIndex:0];
            [teamVc.tableTeam reloadData];
            /*  teamVc.isShowFristTime=YES;
             
             //////////////ADDDEB
             teamVc.isShowFromNotification=NO;
             /////////////  */
            [self showNavController:appDelegate.navigationControllerMyTeams];
            
            

        }
        
      ////////////// AD   ////////
        
    }

    
}

-(void)afterDelay:(id)sender{
    if([[appDelegate.navigationControllerTeamMaintenance.viewControllers lastObject] isMemberOfClass:[TeamMaintenanceVC class]])
        [(TeamMaintenanceVC*)[appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] loadTeamData];
    TeamMaintenanceVC *teamVc=  (TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0];
    teamVc.isShowFristTime=YES;
    
    //////////////ADDDEB
    teamVc.isShowFromNotification=NO;
    /////////////
    
    [self showNavController:appDelegate.navigationControllerTeamMaintenance];
    
}


- (IBAction)slidebTapped:(id)sender
{
    
    int tag=[sender tag];
    
    
    if(tag==0)
    {
        [appDelegate.slidePanelController showLeftPanelAnimated:YES];
        
    }
    else if(tag==1)
    {
        
        [appDelegate.slidePanelController showRightPanelAnimated:YES];
    }
}


- (void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self name:HANDLERECEIVEDMEMORYWARNING object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:CENTERVIEWONTROLLERSETNIL object:nil];
    
    
   
}
- (IBAction)calendarbTapped:(id)sender
{
    BOOL isExist=0;
     if( [[self.calenderlabelbt titleForState:UIControlStateNormal] integerValue]>0)
     {
         isExist=1;
     }
    
    self.pusheventcontroller.isExistData=isExist;
//     else
//     {
//         EventCalendarViewController *eVC=(EventCalendarViewController*) [appDelegate.navigationControllerCalendar.viewControllers objectAtIndex:0];
//         
//         [eVC.segmentbottom setSelectedSegmentIndex:1];
//         [eVC segTapped:eVC.segmentbottom];
//         [self showNavController:appDelegate.navigationControllerCalendar];
//     }
    //our popover
    FPPopoverController *popover = [[FPPopoverController alloc] initWithViewController:self.pusheventcontroller];
    
    self.pusheventcontroller.popOver=popover;
    //Default content size is 200x300. This can be set using the following property
     popover.contentSize = CGSizeMake(220,300);
    popover.tint=FPPopoverLightGrayTint;
    
    //the popover will be presented from the okButton view
    [popover presentPopoverFromView:sender];
    [self.pusheventcontroller setDataView];
    //no release (ARC enable)
 
    
    
    
    
}




- (IBAction)postbtapped:(id)sender
{
    BOOL isExist=0;
    
    if( [[self.postlabelbt titleForState:UIControlStateNormal] integerValue]>0)
    {
        isExist=1;
    }
    
    self.pushinvitecontroller.isExistData=isExist;
//    else
//    {
//        [self showNavController:appDelegate.navigationController];
//    }
        //our popover
        FPPopoverController *popover = [[FPPopoverController alloc] initWithViewController:self.pushinvitecontroller];
        
        self.pushinvitecontroller.popOver=popover;
        //Default content size is 200x300. This can be set using the following property
        popover.contentSize = CGSizeMake(220,300);
        popover.tint=FPPopoverLightGrayTint;
        
        //the popover will be presented from the okButton view
        [popover presentPopoverFromView:sender];
        
        //no release (ARC enable)
        
    [self.pushinvitecontroller setDataView];
  

    
    
}

/*
#pragma mark - AdBannerViewDelegate method implementation

-(void)bannerViewWillLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad Banner will load ad.");
}


-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad Banner did load ad.");
    
    // Show the ad banner.
    [UIView animateWithDuration:0.5 animations:^{
        self.adBanner.alpha = 1.0;
    }];
}


-(BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave{
    NSLog(@"Ad Banner action is about to begin.");
    
    //self.pauseTimeCounting = YES;
    
    return YES;
}


-(void)bannerViewActionDidFinish:(ADBannerView *)banner{
    NSLog(@"Ad Banner action did finish");
    
   // self.pauseTimeCounting = NO;
}


-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    NSLog(@"Unable to show ads. Error: %@", [error localizedDescription]);
    
    // Hide the ad banner.
    [UIView animateWithDuration:0.5 animations:^{
        self.adBanner.alpha = 0.0;
    }];
}
*/


- (void)viewDidUnload {
    [self setUptopbarvw:nil];
    [self setCoachupdatevw:nil];
    [self setInvitefriendlabelbt:nil];
    [self setCoachupdatelabelbt:nil];
    [self setMainredtopbar:nil];
    [super viewDidUnload];
}
@end
