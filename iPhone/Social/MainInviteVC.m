//
//  MainInviteVC.m
//  Wall
//
//  Created by Mindpace on 14/01/14.
//
//
#import "CenterViewController.h"
#import "MainInviteVC.h"

@interface MainInviteVC ()

@end

@implementation MainInviteVC

@synthesize teamInvitesVC,delegate,popOver,totalunreadnumbers,totalunreadnumbersTeam,totalunreadnumbersLike,totalunreadnumbersComment,topsecondvw,teamInvitesVCNavController,timeFont,likeCommentsVC,totalunreadnumbersCoachUpdates,totalunreadnumbersEvent,coachUpdatesVC,eventsVC,teamInvitesVCNav,
likeCommentsVCNav,
coachUpdatesVCNav,
eventsVCNav,isCoachUpdatesOpen,isEventsOpen,isLikeCommentsOpen,isTeamInViteOpen,screenHeight,totalunreadnumbersCoachNotifiedForTeam,totalunreadnumbersEventUpdate,totalunreadnumbersEventDelete,totalunreadnumbersUserNotifiedForTeamResponse,totalunreadnumbersCoachNotifiedForTeamEvent,
totalunreadnumbersUserNotifiedForTeamEventResponse,totalunreadnumbersAdmin,totalunreadnumbersCoachNotifiedForAdmin,isWelcomeAlert;

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
    
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNavigationControllerUpdated:) name:SHOWNAVIGATIONCONTROLLERNOTIFICATION object:nil];
    
    self.navigationController.delegate=self;
    
    totalunreadnumbers=0;
    totalunreadnumbersTeam=0;
    totalunreadnumbersAdmin=0;
    totalunreadnumbersLike=0;
    totalunreadnumbersComment=0;
    totalunreadnumbersCoachNotifiedForTeam=0;
     totalunreadnumbersUserNotifiedForTeamResponse=0;
    totalunreadnumbersEvent=0;

    totalunreadnumbersCoachNotifiedForTeamEvent=0;
    totalunreadnumbersUserNotifiedForTeamEventResponse=0;
     totalunreadnumbersEventUpdate=0;
     totalunreadnumbersEventDelete=0;
    totalunreadnumbersCoachUpdates=0;
    
    totalunreadnumbersCoachNotifiedForAdmin=0;
    
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=appDelegate.backgroundPinkColor;
    self.topview.backgroundColor=appDelegate.barGrayColor;
    self.topsecondvw.backgroundColor=appDelegate.backgroundPinkColor;
    
    
    @autoreleasepool {
        self.helveticaFont=[UIFont fontWithName:@"Helvetica Bold" size:14.0];
        self.timeFont=[UIFont fontWithName:@"Helvetica" size:14.0];
        self.uparrow=[UIImage imageNamed:@"uparrowheader.png"];
        self.downarrow=[UIImage imageNamed:@"downarrowheader.png"];
    }
    
    
    screenHeight=self.view.frame.size.height;
    
    
    CGRect navFrameRect;
    
    if (self.isiPad) {
        navFrameRect=CGRectMake(0, 0, 768,self.view.frame.size.height);
    }
    else{
        if(appDelegate.isIphone5)
            navFrameRect=CGRectMake(0, 0, 320,self.view.frame.size.height);
        else
            navFrameRect=CGRectMake(0, 0, 320,self.view.frame.size.height);
    }
    
    PushByInviteTeamVC *ptevc=[[PushByInviteTeamVC alloc] initWithNibName:@"PushByInviteTeamVC" bundle:nil];
     ptevc.delegate=self;
    
    
   // self.teamInvitesVCNav=[[UINavigationController alloc] initWithRootViewController:ptevc];
    
  
   // self.teamInvitesVCNav.navigationBar.hidden=YES;
   // self.teamInvitesVCNav.delegate=self;
      
    self.teamInvitesVC=ptevc;
    self.teamInvitesVC.view.frame=navFrameRect;
    
    ptevc=nil;
    
    
    [self.view addSubview:self.teamInvitesVC.view];
    
   // self.teamInvitesVC.view.hidden=YES;
    
    
   ////////////////////////////////////////////
    /*LikesAndCommentsVC *ptevc1=[[LikesAndCommentsVC alloc] initWithNibName:@"LikesAndCommentsVC" bundle:nil];
    ptevc1.delegate=self;
    
   
   
    
    
    
    
    self.likeCommentsVC=ptevc1;
     self.likeCommentsVC.view.frame=navFrameRect;
    ptevc1=nil;
    
    
    [self.view addSubview:self.likeCommentsVC.view];
    
     self.likeCommentsVC.view.hidden=YES;*/
    ////////////////////////////////////////////
    
    
    
    /*PushByCoachUpdateVC *coachUpVC=[[PushByCoachUpdateVC alloc] initWithNibName:@"PushByCoachUpdateVC" bundle:nil];
    coachUpVC.delegate=self;
 
    
    
    
    self.coachUpdatesVC=coachUpVC;
    self.coachUpdatesVC.view.frame=navFrameRect;
    coachUpVC=nil;
    [self.view addSubview:self.coachUpdatesVC.view];
     self.coachUpdatesVC.view.hidden=YES;*/
    
    
    ////////////////////////////////////////////
    
   /* PushByEventsVC *pushByEventVC=[[PushByEventsVC alloc] initWithNibName:@"PushByEventsVC" bundle:nil];
    
   pushByEventVC.delegate=self;

    
    
    
    self.eventsVC=pushByEventVC;
    self.eventsVC.view.frame=navFrameRect;
    pushByEventVC=nil;
    [self.view addSubview:self.eventsVC.view];
    self.eventsVC.view.hidden=YES;
   */
    
    
    ///////////////////////////////////////////
}




- (IBAction)popuptapped:(id)sender
{
    self.popupalertvw.hidden=YES;
    self.popupalertvwback.hidden=YES;
    
    
    if(self.isWelcomeAlert)
    {
   
    }
    else
    {
        [self.teamInvitesVC goToTimeLine:nil];
    }
    
    
    self.isWelcomeAlert=0;
}

-(void)showAlertViewCustom:(NSString*)labText
{
    
    self.custompopuplab.text=labText;
    
    self.popupalertvw.hidden=NO;
    self.popupalertvwback.hidden=NO;
    
    [self.view bringSubviewToFront:self.popupalertvwback];
    [self.view bringSubviewToFront:self.popupalertvw];
}







- (void)dealloc
{
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SHOWNAVIGATIONCONTROLLERNOTIFICATION object:nil];
}






/*- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
  
    CGRect m= self.teamInvitesVCNav.view.frame;
    m.origin.y=0;
        
        
    if(self.teamInvitesVCNav.viewControllers.count>1)
    {
    self.teamInvitesVCNav.view.frame=m;
    }
    
    if(self.likeCommentsVCNav.viewControllers.count>1)
    {
    self.likeCommentsVCNav.view.frame=m;
    }
    
    if(self.coachUpdatesVCNav.viewControllers.count>1)
    {
    self.coachUpdatesVCNav.view.frame=m;
    }
    
    if(self.eventsVCNav.viewControllers.count>1)
    {
    self.eventsVCNav.view.frame=m;
    }
    
}*/

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SHOWNAVIGATIONCONTROLLERNOTIFICATION object:nil];
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
    
    //// AD...iAd
    self.teamInvitesVC.adBanner.frame=CGRectMake(self.teamInvitesVC.adBanner.frame.origin.x, self.teamInvitesVC.adBanner.frame.origin.y, self.teamInvitesVC.adBanner.frame.size.width, self.teamInvitesVC.adBanner.frame.size.height);
    self.teamInvitesVC.adBanner.delegate = self;
    self.teamInvitesVC.adBanner.alpha = 0.0;
    self.teamInvitesVC.canDisplayBannerAds=YES;
    ////
    
}

-(void)setTopBarText
{
    if(self.navigationController.view.hidden==NO)//([appDelegate.centerViewController getShowStatus:self.navigationController])
    {
        if([[self.navigationController.viewControllers lastObject] isMemberOfClass:[self class]])
        {
            appDelegate.centerViewController.navigationItem.title=nil;
            appDelegate.centerViewController.navigationItem.titleView=nil;
            
            
            appDelegate.centerViewController.navigationItem.title=@"Notifications";
        }
    }
}

-(void)showNavigationBarButtons
{
    
    if(!self.leftBarButtonItem)
    {
         self.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"wallleftslide.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleLeftPanel:)];
    }
    
    if(!self.rightBarButtonItem)
    {
       // self.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"eventfilter.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleRightPanel:)];
    }
    
    
    appDelegate.centerViewController.navigationItem.title=nil;
    appDelegate.centerViewController.navigationItem.titleView=nil;
    
    //appDelegate.centerViewController.navigationItem.title=nil;
    // appDelegate.centerViewController.navigationItem.titleView=nil;
    
    appDelegate.centerViewController.navigationItem.leftBarButtonItem=self.leftBarButtonItem;
    
    appDelegate.centerViewController.navigationItem.rightBarButtonItem=self.rightBarButtonItem;
    
    
    [self setStatusBarStyleOwnApp:1];
    
    //// AD...iAd
    self.teamInvitesVC.adBanner.delegate = self;
    self.teamInvitesVC.adBanner.alpha = 0.0;
    self.teamInvitesVC.canDisplayBannerAds=YES;
    ////
    
}

-(void)toggleLeftPanel:(id)sender
{
    [appDelegate.slidePanelController showLeftPanelAnimated:YES];
    
}


-(void)toggleRightPanel:(id)sender
{
   
    
    
}







-(void)didChangeNumberOfTeamInvites:(NSString*)number
{
    self.totalunreadnumbersTeam=[number integerValue];
    
  

   

    
    
    self.totalunreadnumbers=self.totalunreadnumbersTeam+self.totalunreadnumbersLike+self.totalunreadnumbersComment+self.totalunreadnumbersEvent+self.totalunreadnumbersCoachUpdates+totalunreadnumbersCoachNotifiedForTeam+totalunreadnumbersEventUpdate+totalunreadnumbersEventDelete+totalunreadnumbersUserNotifiedForTeamResponse+totalunreadnumbersCoachNotifiedForTeamEvent+totalunreadnumbersUserNotifiedForTeamEventResponse+totalunreadnumbersAdmin+totalunreadnumbersCoachNotifiedForAdmin;
    
    NSLog(@"TotalunreadnumbersdidChangeNumberOfTeamInvites=%li",self.totalunreadnumbers);
   /* if(totalunreadnumbersTeam>0)
    {
         [self.teaminvitevwbt setTitle:[[NSString alloc] initWithFormat:@"%li",self.totalunreadnumbersTeam] forState:UIControlStateNormal];
        
         self.teaminvitevw.hidden=NO;
    }
    else
    {
        self.teaminvitevw.hidden=YES;
    }*/
    
    if(delegate)
    {
    if([delegate respondsToSelector:@selector(didChangeNumberOfMainInvites:)])
    [delegate didChangeNumberOfMainInvites:[[NSString alloc] initWithFormat:@"%li",self.totalunreadnumbers]];
    }
}


-(void)didChangeNumberOfAdminInvites:(NSString*)number
{
    self.totalunreadnumbersAdmin=[number integerValue];
    
    
    
    
    
    
    
    self.totalunreadnumbers=self.totalunreadnumbersTeam+self.totalunreadnumbersLike+self.totalunreadnumbersComment+self.totalunreadnumbersEvent+self.totalunreadnumbersCoachUpdates+totalunreadnumbersCoachNotifiedForTeam+totalunreadnumbersEventUpdate+totalunreadnumbersEventDelete+totalunreadnumbersUserNotifiedForTeamResponse+totalunreadnumbersCoachNotifiedForTeamEvent+totalunreadnumbersUserNotifiedForTeamEventResponse+totalunreadnumbersAdmin+totalunreadnumbersCoachNotifiedForAdmin;
    
    NSLog(@"TotalunreadnumbersdidChangeNumberOfTeamInvites=%li",self.totalunreadnumbers);
    /* if(totalunreadnumbersTeam>0)
     {
     [self.teaminvitevwbt setTitle:[[NSString alloc] initWithFormat:@"%li",self.totalunreadnumbersTeam] forState:UIControlStateNormal];
     
     self.teaminvitevw.hidden=NO;
     }
     else
     {
     self.teaminvitevw.hidden=YES;
     }*/
    
    if(delegate)
    {
        if([delegate respondsToSelector:@selector(didChangeNumberOfMainInvites:)])
            [delegate didChangeNumberOfMainInvites:[[NSString alloc] initWithFormat:@"%li",self.totalunreadnumbers]];
    }
}


-(void)didSelectTeamInvite:(Invite*)newInvite :(FPPopoverController*)popOverController
{
    
}



-(void)didChangeNumberLikeComments:(NSString*)number//////////////////
{
    
  // self.totalunreadnumbersLike= appDelegate.allHistoryLikesCounts;
    self.totalunreadnumbersLike=[number integerValue];
    
    self.totalunreadnumbers=self.totalunreadnumbersTeam+self.totalunreadnumbersLike+self.totalunreadnumbersComment+self.totalunreadnumbersEvent+self.totalunreadnumbersCoachUpdates+totalunreadnumbersCoachNotifiedForTeam+totalunreadnumbersEventUpdate+totalunreadnumbersEventDelete+totalunreadnumbersUserNotifiedForTeamResponse+totalunreadnumbersCoachNotifiedForTeamEvent+totalunreadnumbersUserNotifiedForTeamEventResponse+totalunreadnumbersAdmin+totalunreadnumbersCoachNotifiedForAdmin;
     NSLog(@"TotalunreadnumbersdidChangeNumberLikeComments=%li---------%i",self.totalunreadnumbers,[number integerValue]);
   /* if(totalunreadnumbersLike>0)
    {
        [self.likescmntsbt setTitle:[[NSString alloc] initWithFormat:@"%li",self.totalunreadnumbersLike] forState:UIControlStateNormal];
        
        
         self.likescmntsvw.hidden=NO;
    }
    else
    {
       // self.view2unreadlab.text=NOUNREAD;
        
        self.likescmntsvw.hidden=YES;
        
    }*/
    
    
    if(delegate)
    {
        if([delegate respondsToSelector:@selector(didChangeNumberOfMainInvites:)])
            [delegate didChangeNumberOfMainInvites:[[NSString alloc] initWithFormat:@"%li",self.totalunreadnumbers]];
    }
    
    
    
    
}

-(void)didSelectLikeComments:(LikeCommentData*)newInvite :(FPPopoverController*)popOverController
{
    
    
}
/////////
-(void)didChangeNumberOfCoachNotifiedForTeamInvite:(NSString*)number
{
    self.totalunreadnumbersCoachNotifiedForTeam=[number integerValue];
    
    self.totalunreadnumbers=self.totalunreadnumbersTeam+self.totalunreadnumbersLike+self.totalunreadnumbersComment+self.totalunreadnumbersEvent+self.totalunreadnumbersCoachUpdates+totalunreadnumbersCoachNotifiedForTeam+totalunreadnumbersEventUpdate+totalunreadnumbersEventDelete+totalunreadnumbersUserNotifiedForTeamResponse+totalunreadnumbersCoachNotifiedForTeamEvent+totalunreadnumbersUserNotifiedForTeamEventResponse+totalunreadnumbersAdmin+totalunreadnumbersCoachNotifiedForAdmin;
    NSLog(@"totalunreadnumbersCoachNotifiedForTeam=%li---------%i",self.totalunreadnumbers,[number integerValue]);
    if(delegate)
    {
        if([delegate respondsToSelector:@selector(didChangeNumberOfMainInvites:)])
            [delegate didChangeNumberOfMainInvites:[[NSString alloc] initWithFormat:@"%li",self.totalunreadnumbers]];
    }
}

-(void)didChangeNumberOfCoachNotifiedForAdminInvite:(NSString*)number
{
    self.totalunreadnumbersCoachNotifiedForAdmin=[number integerValue];
    
    self.totalunreadnumbers=self.totalunreadnumbersTeam+self.totalunreadnumbersLike+self.totalunreadnumbersComment+self.totalunreadnumbersEvent+self.totalunreadnumbersCoachUpdates+totalunreadnumbersCoachNotifiedForTeam+totalunreadnumbersEventUpdate+totalunreadnumbersEventDelete+totalunreadnumbersUserNotifiedForTeamResponse+totalunreadnumbersCoachNotifiedForTeamEvent+totalunreadnumbersUserNotifiedForTeamEventResponse+totalunreadnumbersAdmin+totalunreadnumbersCoachNotifiedForAdmin;
    NSLog(@"totalunreadnumbersCoachNotifiedForTeam=%li---------%i",self.totalunreadnumbers,[number integerValue]);
    if(delegate)
    {
        if([delegate respondsToSelector:@selector(didChangeNumberOfMainInvites:)])
            [delegate didChangeNumberOfMainInvites:[[NSString alloc] initWithFormat:@"%li",self.totalunreadnumbers]];
    }
}





-(void)didChangeNumberOfUserNotifiedForTeamInviteResponse:(NSString*)number
{
    self.totalunreadnumbersUserNotifiedForTeamResponse=[number integerValue];
    
    self.totalunreadnumbers=self.totalunreadnumbersTeam+self.totalunreadnumbersLike+self.totalunreadnumbersComment+self.totalunreadnumbersEvent+self.totalunreadnumbersCoachUpdates+totalunreadnumbersCoachNotifiedForTeam+totalunreadnumbersEventUpdate+totalunreadnumbersEventDelete+totalunreadnumbersUserNotifiedForTeamResponse+totalunreadnumbersCoachNotifiedForTeamEvent+totalunreadnumbersUserNotifiedForTeamEventResponse+totalunreadnumbersAdmin+totalunreadnumbersCoachNotifiedForAdmin;
    NSLog(@"totalunreadnumbersCoachNotifiedForTeam=%li---------%i",self.totalunreadnumbers,[number integerValue]);
    if(delegate)
    {
        if([delegate respondsToSelector:@selector(didChangeNumberOfMainInvites:)])
            [delegate didChangeNumberOfMainInvites:[[NSString alloc] initWithFormat:@"%li",self.totalunreadnumbers]];
    }
}

-(void)didChangeNumberOfCoachNotifiedForTeamEventInvite:(NSString*)number
{
    self.totalunreadnumbersCoachNotifiedForTeamEvent=[number integerValue];
    
    self.totalunreadnumbers=self.totalunreadnumbersTeam+self.totalunreadnumbersLike+self.totalunreadnumbersComment+self.totalunreadnumbersEvent+self.totalunreadnumbersCoachUpdates+totalunreadnumbersCoachNotifiedForTeam+totalunreadnumbersEventUpdate+totalunreadnumbersEventDelete+totalunreadnumbersUserNotifiedForTeamResponse+totalunreadnumbersCoachNotifiedForTeamEvent+totalunreadnumbersUserNotifiedForTeamEventResponse+totalunreadnumbersAdmin+totalunreadnumbersCoachNotifiedForAdmin;
    NSLog(@"totalunreadnumbersCoachNotifiedForTeam=%li---------%i",self.totalunreadnumbers,[number integerValue]);
    if(delegate)
    {
        if([delegate respondsToSelector:@selector(didChangeNumberOfMainInvites:)])
            [delegate didChangeNumberOfMainInvites:[[NSString alloc] initWithFormat:@"%li",self.totalunreadnumbers]];
    }
}


-(void)didChangeNumberOfUserNotifiedForTeamEventInviteResponse:(NSString*)number
{
    self.totalunreadnumbersUserNotifiedForTeamEventResponse=[number integerValue];
    
    self.totalunreadnumbers=self.totalunreadnumbersTeam+self.totalunreadnumbersLike+self.totalunreadnumbersComment+self.totalunreadnumbersEvent+self.totalunreadnumbersCoachUpdates+totalunreadnumbersCoachNotifiedForTeam+totalunreadnumbersEventUpdate+totalunreadnumbersEventDelete+totalunreadnumbersUserNotifiedForTeamResponse+totalunreadnumbersCoachNotifiedForTeamEvent+totalunreadnumbersUserNotifiedForTeamEventResponse+totalunreadnumbersAdmin+totalunreadnumbersCoachNotifiedForAdmin;
    NSLog(@"totalunreadnumbersCoachNotifiedForTeam=%li---------%i",self.totalunreadnumbers,[number integerValue]);
    if(delegate)
    {
        if([delegate respondsToSelector:@selector(didChangeNumberOfMainInvites:)])
            [delegate didChangeNumberOfMainInvites:[[NSString alloc] initWithFormat:@"%li",self.totalunreadnumbers]];
    }
}



-(void)didSelectCoachNotifiedForTeamInvite:(Invite*)newInvite :(FPPopoverController*)popOverController
{
    
}
////////

-(void)didChangeNumberOfCoachUpdates:(NSString*)number
{
    
    
    self.totalunreadnumbersCoachUpdates=[number integerValue];
    
    self.totalunreadnumbers=self.totalunreadnumbersTeam+self.totalunreadnumbersLike+self.totalunreadnumbersComment+self.totalunreadnumbersEvent+self.totalunreadnumbersCoachUpdates+totalunreadnumbersCoachNotifiedForTeam+totalunreadnumbersEventUpdate+totalunreadnumbersEventDelete+totalunreadnumbersUserNotifiedForTeamResponse+totalunreadnumbersCoachNotifiedForTeamEvent+totalunreadnumbersUserNotifiedForTeamEventResponse+totalunreadnumbersAdmin+totalunreadnumbersCoachNotifiedForAdmin;
    
    NSLog(@"didChangeNumberOfCoachUpdatesTotalunreadnumbers=%li",self.totalunreadnumbers);
    /*if(totalunreadnumbersCoachUpdates>0)
    {
        [self.cupdatevwbt setTitle:[[NSString alloc] initWithFormat:@"%li",self.totalunreadnumbersCoachUpdates] forState:UIControlStateNormal];
        
        
         self.cupdatevw.hidden=NO;
    }
    else
    {
        //self.view3unreadlab.text=NOUNREAD;
        
        self.cupdatevw.hidden=YES;
    }*/
    
    if(delegate)
    {
        if([delegate respondsToSelector:@selector(didChangeNumberOfMainInvites:)])
            [delegate didChangeNumberOfMainInvites:[[NSString alloc] initWithFormat:@"%li",self.totalunreadnumbers]];
    }
}

-(void)didSelectCoachUpdates:(Invite *)newInvite :(FPPopoverController *)popOverController
{
    
    
    
    
}


-(void)didChangeNumberOfEvents:(NSString*)number
{
    self.totalunreadnumbersEvent=[number integerValue];
    
    self.totalunreadnumbers=self.totalunreadnumbersTeam+self.totalunreadnumbersLike+self.totalunreadnumbersComment+self.totalunreadnumbersEvent+self.totalunreadnumbersCoachUpdates+totalunreadnumbersCoachNotifiedForTeam+totalunreadnumbersEventUpdate+totalunreadnumbersEventDelete+totalunreadnumbersUserNotifiedForTeamResponse+totalunreadnumbersCoachNotifiedForTeamEvent+totalunreadnumbersUserNotifiedForTeamEventResponse+totalunreadnumbersAdmin+totalunreadnumbersCoachNotifiedForAdmin;
    
    NSLog(@"didChangeNumberOfEventsTotalunreadnumbers=%li",self.totalunreadnumbers);
   /* if(totalunreadnumbersEvent>0)
    {
        [self.eventvwbt setTitle:[[NSString alloc] initWithFormat:@"%li",self.totalunreadnumbersEvent] forState:UIControlStateNormal];
        
          self.eventvw.hidden=NO;
    }
    else
    {
        self.eventvw.hidden=YES;
    }*/
    
    if(delegate)
    {
        if([delegate respondsToSelector:@selector(didChangeNumberOfMainInvites:)])
            [delegate didChangeNumberOfMainInvites:[[NSString alloc] initWithFormat:@"%li",self.totalunreadnumbers]];
    }
}



-(void)didChangeNumberOfEventsUpdate:(NSString*)number
{
    self.totalunreadnumbersEventUpdate=[number integerValue];
    
    self.totalunreadnumbers=self.totalunreadnumbersTeam+self.totalunreadnumbersLike+self.totalunreadnumbersComment+self.totalunreadnumbersEvent+self.totalunreadnumbersCoachUpdates+totalunreadnumbersCoachNotifiedForTeam+totalunreadnumbersEventUpdate+totalunreadnumbersEventDelete+totalunreadnumbersUserNotifiedForTeamResponse+totalunreadnumbersCoachNotifiedForTeamEvent+totalunreadnumbersUserNotifiedForTeamEventResponse+totalunreadnumbersAdmin+totalunreadnumbersCoachNotifiedForAdmin;
    
    NSLog(@"didChangeNumberOfEventsTotalunreadnumbers=%li",self.totalunreadnumbers);
    /* if(totalunreadnumbersEvent>0)
     {
     [self.eventvwbt setTitle:[[NSString alloc] initWithFormat:@"%li",self.totalunreadnumbersEvent] forState:UIControlStateNormal];
     
     self.eventvw.hidden=NO;
     }
     else
     {
     self.eventvw.hidden=YES;
     }*/
    
    if(delegate)
    {
        if([delegate respondsToSelector:@selector(didChangeNumberOfMainInvites:)])
            [delegate didChangeNumberOfMainInvites:[[NSString alloc] initWithFormat:@"%li",self.totalunreadnumbers]];
    }
}




-(void)didChangeNumberOfEventsDelete:(NSString*)number
{
    self.totalunreadnumbersEventDelete=[number integerValue];
    
    self.totalunreadnumbers=self.totalunreadnumbersTeam+self.totalunreadnumbersLike+self.totalunreadnumbersComment+self.totalunreadnumbersEvent+self.totalunreadnumbersCoachUpdates+totalunreadnumbersCoachNotifiedForTeam+totalunreadnumbersEventUpdate+totalunreadnumbersEventDelete+totalunreadnumbersUserNotifiedForTeamResponse+totalunreadnumbersCoachNotifiedForTeamEvent+totalunreadnumbersUserNotifiedForTeamEventResponse+totalunreadnumbersAdmin+totalunreadnumbersCoachNotifiedForAdmin;
    
    NSLog(@"didChangeNumberOfEventsTotalunreadnumbers=%li",self.totalunreadnumbers);
    /* if(totalunreadnumbersEvent>0)
     {
     [self.eventvwbt setTitle:[[NSString alloc] initWithFormat:@"%li",self.totalunreadnumbersEvent] forState:UIControlStateNormal];
     
     self.eventvw.hidden=NO;
     }
     else
     {
     self.eventvw.hidden=YES;
     }*/
    
    if(delegate)
    {
        if([delegate respondsToSelector:@selector(didChangeNumberOfMainInvites:)])
            [delegate didChangeNumberOfMainInvites:[[NSString alloc] initWithFormat:@"%li",self.totalunreadnumbers]];
    }
}

-(void)didSelectEvent:(Event*)newEvent :(FPPopoverController*)popOverController
{
   
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [self setTopsecondvw:nil];
    [self setView1:nil];
    [self setView2:nil];
    [self setView3:nil];
    [self setView4:nil];
    [self setView1unreadlab:nil];
    [self setView2unreadlab:nil];
    [self setView3unreadlab:nil];
    [self setView4unreadlab:nil];
   
    [self setEventsindicatorimavw:nil];
    [self setCoachupdatesindicatorimavw:nil];
    [self setLikecommentsindicatorimavw:nil];
    [self setTeaminvitesindicatorimavw:nil];
    [self setEventvw:nil];
    [self setEventvwbt:nil];
    [self setCupdatevw:nil];
    [self setCupdatevwbt:nil];
    [self setLikescmntsvw:nil];
    [self setLikescmntsbt:nil];
    [self setTeaminvitevw:nil];
    [self setTeaminvitevwbt:nil];
    [super viewDidUnload];
}


- (IBAction)cancelAction:(id)sender
{
    
    [self.navigationController.view setHidden:YES];
    
       [appDelegate.centerViewController showNavController:appDelegate.navigationController];
    
}

- (IBAction)selectionAction:(id)sender
{
    int tag=[sender tag];
    
  /*  UIButton *bt1=(UIButton*)[self.view viewWithTag:1];
    UIButton *bt2=(UIButton*)[self.view viewWithTag:2];
    UIButton *bt3=(UIButton*)[self.view viewWithTag:3];*/
    
    if(tag==1)
    {
          //self.mylab1.text=@"Team Invites";
         /*[bt1.titleLabel setFont:self.helveticaFont];
         [bt2.titleLabel setFont:self.timeFont];
         [bt3.titleLabel setFont:timeFont];*/
        
        isTeamInViteOpen=!isTeamInViteOpen;
        isLikeCommentsOpen=0;
        isCoachUpdatesOpen=0;
        isEventsOpen=0;
        
        
            self.teamInvitesVC.view.hidden=!isTeamInViteOpen;
            self.likeCommentsVC.view.hidden=!isLikeCommentsOpen;
         self.coachUpdatesVC.view.hidden=!isCoachUpdatesOpen;
         self.eventsVC.view.hidden=!isEventsOpen;
        
        
        [self setTeamInvitesStructure];
          
    }
    else if(tag==2)
    {
          // self.mylab1.text=@"Likes";
        /* [bt1.titleLabel setFont:self.timeFont];
         [bt2.titleLabel setFont:self.helveticaFont];
         [bt3.titleLabel setFont:self.timeFont];*/
        
        isLikeCommentsOpen=!isLikeCommentsOpen;
        isTeamInViteOpen=0;
        isCoachUpdatesOpen=0;
        isEventsOpen=0;

        
        self.teamInvitesVC.view.hidden=!isTeamInViteOpen;
        self.likeCommentsVC.view.hidden=!isLikeCommentsOpen;
        self.coachUpdatesVC.view.hidden=!isCoachUpdatesOpen;
        self.eventsVC.view.hidden=!isEventsOpen;
        
        
        [self setLikeCommentsStructure];
         
    }
    else if(tag==3)
    {
        //self.mylab1.text=@"Likes/Comments";
         /*[bt1.titleLabel setFont:self.timeFont];
         [bt2.titleLabel setFont:self.timeFont];
         [bt3.titleLabel setFont:self.helveticaFont];*/
        
        isTeamInViteOpen=0;
        isLikeCommentsOpen=0;
        isCoachUpdatesOpen=!isCoachUpdatesOpen;
        isEventsOpen=0;
        
        
        self.teamInvitesVC.view.hidden=!isTeamInViteOpen;
        self.likeCommentsVC.view.hidden=!isLikeCommentsOpen;
        self.coachUpdatesVC.view.hidden=!isCoachUpdatesOpen;
        self.eventsVC.view.hidden=!isEventsOpen;
        
        
        [self setCoachUpdatesStructure];
        
    }
    else if(tag==4)
    {
          //self.mylab1.text=@"Likes/Comments";
        /*[bt1.titleLabel setFont:self.timeFont];
         [bt2.titleLabel setFont:self.timeFont];
         [bt3.titleLabel setFont:self.helveticaFont];*/
        
       
        isTeamInViteOpen=0;
        isLikeCommentsOpen=0;
        isCoachUpdatesOpen=0;
        isEventsOpen=!isEventsOpen;
        
        
        self.teamInvitesVC.view.hidden=!isTeamInViteOpen;
        self.likeCommentsVC.view.hidden=!isLikeCommentsOpen;
        self.coachUpdatesVC.view.hidden=!isCoachUpdatesOpen;
        self.eventsVC.view.hidden=!isEventsOpen;
      
        
        [self setEventsStructure];
    }
    
}



-(void)setTeamInvitesStructure
{
    float dY=36;
    
    
    float oheight=screenHeight-(36+28+28+28+28);
    
    if(isTeamInViteOpen)
    {
        self.teaminvitesindicatorimavw.image=self.uparrow;
        
    }
    else
    {
    self.teaminvitesindicatorimavw.image=self.downarrow;
        
    }
    
    
    self.likecommentsindicatorimavw.image=self.downarrow;
    self.coachupdatesindicatorimavw.image=self.downarrow;
    self.eventsindicatorimavw.image=self.downarrow;
    
    
    
    CGRect r=self.view1.frame;
    
    self.view1.frame=CGRectMake(r.origin.x, dY, r.size.width, r.size.height);
    dY+=28;
    
    
    if(isTeamInViteOpen)
    {
    r=self.teamInvitesVC.view.frame;
    r.origin.y=dY;
    r.size.height=oheight;
    self.teamInvitesVC.view.frame=r;
    
    dY+=oheight;
    }
    r=self.view2.frame;
    
    self.view2.frame=CGRectMake(r.origin.x, dY, r.size.width, r.size.height);
    dY+=28;

    r=self.view3.frame;
    
    self.view3.frame=CGRectMake(r.origin.x, dY, r.size.width, r.size.height);
    dY+=28;
    
    r=self.view4.frame;
    self.view4.frame=CGRectMake(r.origin.x, dY, r.size.width, r.size.height);
    
}


-(void)setLikeCommentsStructure
{
    float dY=36;
    
    
    float oheight=screenHeight-(36+28+28+28+28);
    
    if(isLikeCommentsOpen)
    {
        
         self.likecommentsindicatorimavw.image=self.uparrow;
    }
    else
    {
         self.likecommentsindicatorimavw.image=self.downarrow;
        
    }
    
    
   
      self.teaminvitesindicatorimavw.image=self.downarrow;
    self.coachupdatesindicatorimavw.image=self.downarrow;
    self.eventsindicatorimavw.image=self.downarrow;
    
    //////////////////////////////
    
    CGRect r=self.view1.frame;
    
    self.view1.frame=CGRectMake(r.origin.x, dY, r.size.width, r.size.height);
    dY+=28;
    
    
   
    
    r=self.view2.frame;
    
    self.view2.frame=CGRectMake(r.origin.x, dY, r.size.width, r.size.height);
    dY+=28;
    
    if(isLikeCommentsOpen)
    {
    r=self.likeCommentsVC.view.frame;
    r.origin.y=dY;
    r.size.height=oheight;
    self.likeCommentsVC.view.frame=r;
    
    dY+=oheight;
    }
    r=self.view3.frame;
    
    self.view3.frame=CGRectMake(r.origin.x, dY, r.size.width, r.size.height);
    dY+=28;
    
    r=self.view4.frame;
    self.view4.frame=CGRectMake(r.origin.x, dY, r.size.width, r.size.height);
}

-(void)setCoachUpdatesStructure
{
    float dY=36;
    
    
    float oheight=screenHeight-(36+28+28+28+28);
    
    if(isCoachUpdatesOpen)
    {
        self.coachupdatesindicatorimavw.image=self.uparrow;
        
    }
    else
    {
        
         self.coachupdatesindicatorimavw.image=self.downarrow;
    }
    
    self.teaminvitesindicatorimavw.image=self.downarrow;
    self.likecommentsindicatorimavw.image=self.downarrow;
   
    self.eventsindicatorimavw.image=self.downarrow;
    
    
    
    /////////////////////
    CGRect r=self.view1.frame;
    
    self.view1.frame=CGRectMake(r.origin.x, dY, r.size.width, r.size.height);
    dY+=28;
    
    
   
    
    r=self.view2.frame;
    
    self.view2.frame=CGRectMake(r.origin.x, dY, r.size.width, r.size.height);
    dY+=28;
    
    
   
    
    
    r=self.view3.frame;
    
    self.view3.frame=CGRectMake(r.origin.x, dY, r.size.width, r.size.height);
    dY+=28;
    
    if(isCoachUpdatesOpen)
    {
    r=self.coachUpdatesVC.view.frame;
    r.origin.y=dY;
    r.size.height=oheight;
    self.coachUpdatesVC.view.frame=r;
    
    dY+=oheight;
    }
    r=self.view4.frame;
    self.view4.frame=CGRectMake(r.origin.x, dY, r.size.width, r.size.height);
}

-(void)setEventsStructure
{
    float dY=36;
    
    
    float oheight=screenHeight-(36+28+28+28+28);
    
    if(isEventsOpen)
    {
         self.eventsindicatorimavw.image=self.uparrow;
        
    }
    else
    {
         self.eventsindicatorimavw.image=self.downarrow;
        
    }
      self.teaminvitesindicatorimavw.image=self.downarrow;
    self.likecommentsindicatorimavw.image=self.downarrow;
    self.coachupdatesindicatorimavw.image=self.downarrow;
   
    
    ///////////////////
    CGRect r=self.view1.frame;
    
    self.view1.frame=CGRectMake(r.origin.x, dY, r.size.width, r.size.height);
    dY+=28;
    
    
    
    
    r=self.view2.frame;
    
    self.view2.frame=CGRectMake(r.origin.x, dY, r.size.width, r.size.height);
    dY+=28;
    
    r=self.view3.frame;
    
    self.view3.frame=CGRectMake(r.origin.x, dY, r.size.width, r.size.height);
    dY+=28;
    
    r=self.view4.frame;
    self.view4.frame=CGRectMake(r.origin.x, dY, r.size.width, r.size.height);
    dY+=28;
    
    
    if(isEventsOpen)
    {
    r=self.eventsVC.view.frame;
    r.origin.y=dY;
    r.size.height=oheight;
    self.eventsVC.view.frame=r;
    }
  
    
}


@end
