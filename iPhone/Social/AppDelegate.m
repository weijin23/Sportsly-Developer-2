//
//  AppDelegate.m
//  Social
//
//  Created by Mindpace on 08/08/13.
//
//
#import "PushByInviteTeamVC.h"
#import "TeamEventsVC.h"
#import "MessageVC.h"
#import "EventUnread.h"
#import "LikesAndCommentsVC.h"
#import "MainInviteVC.h"
#import "PushByCoachUpdateVC.h"
#import "PushByInviteFriendVC.h"
#import "SelectContact.h"
#import "AddAFriend.h"
#import "Event.h"
#import "EventDetailsViewController.h"
#import "TeamMaintenanceVC.h"
#import "MyTeamsViewController.h"
#import "CenterViewController.h"
#import "EventCalendarViewController.h"
#import "LoginPageViewController.h"
#import "AppDelegate.h"
#import "HomeVC.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>
#import "SettingsViewController.h"
#import "Invite.h"
#import "ClubLeagueViewController.h"
#import "MyContactViewController.h"
#import "MySchduleViewController.h"
#import "ShowVideoViewController.h"
#import "BuySellViewController.h"
#import "TeamPlayerViewController.h"
#import "FAQViewController.h"
#import "FeedBackViewController.h"
#import "Tutorila1ViewController.h"
#import "ChatViewController.h"
#import "PushByEventsVC.h"
#import "ChatMessageViewController.h"
#import "PhotoMainVC.h"
#import "FirstLoginViewController.h"
#import "PrimaryMemeberViewController.h"
#import "Tutorila1ViewController.h"

@implementation AppDelegate

@synthesize systemVersion,isIphone5,aDef,dateFormatDb,dateFormatM,slidePanelController,navigationControllerfirst,dataModel,arrItems,currentSendDeviceTokenStatus,centerViewController,eventStore,eventsList,defaultCalendar,locationLatPlayground,locationLongPlayground,JSONDATAarr,userOwnImage,teamList,cellRedColor,dateFormatFullOriginal,JSONDATAImages,eventsTempStoreArr,dateFormatFullOriginalComment,dateFormatFullHome,locationLat,locationLong,locationManager,currentLocation,dateFormatDbAmerican,isProcessEventPublic,sinReq1,sinReq2,storeCreatedRequests,deviceScale,barGrayColor,backgroundPinkColor,veryLightGrayColor,labelRedColor,dateFormatEvent,dateFormatEventShort,trainningVideoVC,navigationControllerCoachUpdate,navigationControllerTeamInvites,allHistoryLikesComments,allHistoryLikesCounts,navigationControllerEventNews,clearcolor,navigationControllerTeamEvents,faceBookImageData,isIos7,isIos8,commonHeight,navigationControllerCenter,themeCyanColor,leftPanelGrayColor,backGroundUnreadGray,isFromAlbumForVideoPost,faceBookVideoPath;

@synthesize eventEditViewController;

@synthesize navigationControllerCalendar;
@synthesize navigationControllerTeamMaintenance;
@synthesize navigationControllerMyTeams; ////AD july For Myteam
@synthesize navigationControllerAddAFriend;
@synthesize navigationControllerFindTeam;
@synthesize navigationControllerMyPhoto;
@synthesize navigationControllerSettings,dateFormatFull;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize navigationControllerClubLeague;
@synthesize navigationControllerMyContact;
@synthesize navigationControllerMySchdule;
@synthesize navigationControllerTrainingVideo;
@synthesize navigationControllerBuySell;
@synthesize navigationControllerFaq;
@synthesize navigationControllerFeedBack;
@synthesize navigationControllerTutorial;
@synthesize navigationControllerChatMessage;
@synthesize navigationControllerPrimaryMemeber;
@synthesize isTeamCreate,JSONDATAMemberarr,isTeamAccept;

@synthesize alreadyRegisteredMember;

//@synthesize strNewAddTeamMessage;
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kFOUNDDEVICETOKEN object:self];
    
     [[NSNotificationCenter defaultCenter] removeObserver:self name:COMINGFRIENDINVITES object:nil];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(comingFriendInvitesListUpdated:) name:COMINGFRIENDINVITES object:nil];
    
    
    isProcessEventPublic=0;
    self.userOwnImage=nil;
    
    
    eventStore=nil;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        self.commonHeight=900;//Ch in xcode
    }
    else{
        self.commonHeight=367;//Ch in xcode 5
    }
    
    //[codeString substringFromIndex:1]
    
    
    if([[[UIDevice currentDevice] systemVersion] length]>1)
    {
        // add  current device IOS 8 on 6th october
    if([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] floatValue]==7.0)
    {
        self.isIos7=1;
        NSLog(@"OSVersion=%f",[[[UIDevice currentDevice] systemVersion] floatValue]);
      
    }
    else if ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] floatValue]==8.0)
    {
        self.isIos8 = 1;
        NSLog(@"OSVersion=%f",[[[UIDevice currentDevice] systemVersion] floatValue]);
    }
    else
    {
        self.isIos7=0;
    }
    }
    //////////////////
    
    /*
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:INVITE inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
   // NSPredicate *pre=[NSPredicate predicateWithFormat:@"type==%i OR type==%i OR type==%i OR type==%i OR type==%i OR type==%i OR type==%i OR type==%i OR type==%i OR type==%i OR type==%i OR type==%i",0,3,5,6,7,8,9,10,11,12,14,15];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"datetime" ascending:NO ];//@"inviteStatus"
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
//    [fetchRequest setPredicate:pre];
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil] ;
    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    
    NSLog(@"aFetchedResultsControllerCount=%i",aFetchedResultsController.fetchedObjects.count);
    
    
    */
    
    //////////////////
    
    self.storeCreatedRequests=[[NSMutableArray alloc] init];
    
     // [application setStatusBarStyle:UIStatusBarStyleBlackOpaque];  //Ch in xcode 5
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.deviceScale=[[UIScreen mainScreen] scale];
    
     self.systemVersion=[[[UIDevice currentDevice] systemVersion] floatValue];
    
       self.aDef=[NSUserDefaults standardUserDefaults];
    
    self.currentSendDeviceTokenStatus=0;
    
    BOOL isForceLogOut=0;
    
       NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    if(![self.aDef objectForKey:ISFIRSTTIME])
    {
        /*NSString *udid=  nil;
        
        if(systemVersion<6.0)
            udid= [[UIDevice currentDevice] uniqueDeviceIdentifier];
        else
            udid=[[[UIDevice currentDevice] identifierForVendor] UUIDString];
        
        [self setUserDefaultValue:udid ForKey:UDID];
        [self setUserDefaultValue:@"1" ForKey:ISFIRSTTIME];
        
        [self setUserDefaultValue:appVersion ForKey:APPBUNDLEVERSION];*/
        NSString *strNib=@"";
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            strNib=@"Tutorila1ViewController_iPad";
        }
        else{
            strNib=@"Tutorila1ViewController";
        }
        Tutorila1ViewController *loginViewController=[[Tutorila1ViewController alloc] initWithNibName:@"Tutorila1ViewController" bundle:nil];
        
        UINavigationController *nav3=[[UINavigationController alloc] initWithRootViewController:loginViewController] ;
        self.navigationControllerfirst = nav3 ;
        
        self.navigationControllerfirst.navigationBarHidden=YES;
        
    }
    else
    {
        NSString *aVersion=[self.aDef objectForKey:APPBUNDLEVERSION];
        
        
        if((!aVersion) || (![appVersion isEqualToString:aVersion]))
        {
              [self setUserDefaultValue:appVersion ForKey:APPBUNDLEVERSION];
            isForceLogOut=1;
        }
        
        NSString *strNib=@"";
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            strNib=@"FirstLoginViewController_iPad";
        }
        else{
            strNib=@"FirstLoginViewController";
        }
        
        FirstLoginViewController *loginViewController=[[FirstLoginViewController alloc] initWithNibName:@"FirstLoginViewController" bundle:nil];
        
        UINavigationController *nav3=[[UINavigationController alloc] initWithRootViewController:loginViewController] ;
        self.navigationControllerfirst = nav3 ;
        
        self.navigationControllerfirst.navigationBarHidden=YES;
        
    }
    
    
    
    
    // Override point for customization after application launch.
    CGRect m=[[UIScreen mainScreen] bounds];
    
    if(m.size.height==568)
    {
        isIphone5=1;
    }
    else
    {
        isIphone5=0;
    }
    @autoreleasepool
    {
        
        self.clearcolor=[UIColor clearColor];
        
        self.leftPanelGrayColor=[self colorWithHexString:@"333333"];/*[UIColor colorWithRed:((float) 60.0 / 255.0f)
                                        green:((float) 60.0 / 255.0f)
                                         blue:((float) 59.0 / 255.0f)
                                        alpha:1.0f];*/
        
       self.backGroundUnreadGray= [self colorWithHexString:@"F1F0F0"];
        self.barGrayColor=[self colorWithHexString:Grey];
        //self.backgroundPinkColor=[self colorWithHexString:Pink];
    self.cellRedColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"cellred.png"]];
        self.topBarRedColor=[self colorWithHexString:@"990a04"];//[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbarcolor.png"]];
        
     self.veryLightGrayColor= [UIColor colorWithRed:((float) 220.0 / 255.0f)
                               green:((float) 220.0 / 255.0f)
                                blue:((float) 220.0 / 255.0f)
                               alpha:1.0f];
        
        self.labelRedColor= [UIColor colorWithRed:((float) 255.0 / 255.0f)
                                                 green:((float) 67.0 / 255.0f)
                                                  blue:((float) 37.0 / 255.0f)
                                                 alpha:1.0f];
        
        
        
        self.themeCyanColor=[UIColor colorWithRed:((float) 0.0 / 255.0f)//13
                                            green:((float) 154.0 / 255.0f)//153
                                             blue:((float) 215.0 / 255.0f)//206
                                            alpha:1.0f];
        
        
    }
    //EKCalendarChooser *masterViewController = [[[EKCalendarChooser alloc] initWithSelectionStyle:EKCalendarChooserSelectionStyleMultiple displayStyle:EKCalendarChooserDisplayAllCalendars eventStore: [[[EKEventStore alloc] init] autorelease]] autorelease];
    self.dateFormatFull=[[NSDateFormatter alloc ] init];
    [dateFormatFull setDateFormat:@" HH:mm:ss"];
    
    self.dateFormatDb=[[NSDateFormatter alloc ] init];
    [dateFormatDb setDateFormat:@"yyyy-MM-dd"];
    
    self.dateFormatDbAmerican=[[NSDateFormatter alloc ] init];
    [dateFormatDbAmerican setDateFormat:@"MM-dd-yyyy"];
    
    self.dateFormatFullOriginal=[[NSDateFormatter alloc ] init];
    [dateFormatFullOriginal setDateFormat:@"yyyy-MM-dd, HH:mm:ss"];
    
    self.dateFormatFullOriginalComment=[[NSDateFormatter alloc ] init];
    [dateFormatFullOriginalComment setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    self.dateFormatFullHome=[[NSDateFormatter alloc ] init];
    [dateFormatFullHome setDateFormat:@"dd MMM, hh:mm aa"];
    
    self.dateFormatM=[[NSDateFormatter alloc ] init];
    [dateFormatM setDateFormat:@"hh:mm a"];
    
      self.dateFormatEvent=[[NSDateFormatter alloc ] init];
     [dateFormatEvent setDateFormat:@"dd MMM, yyyy"];
    
    self.dateFormatEventShort=[[NSDateFormatter alloc ] init];
    [dateFormatEventShort setDateFormat:@"dd MMM"];
    
    JASidePanelController *jas= [[JASidePanelController alloc] init];
    self.slidePanelController =jas;
  
    NSString *strNib=@"";
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        strNib=@"LeftViewController_iPad";
    }
    else{
        strNib=@"LeftViewController";
    }
    
    LeftViewController   *masterViewControllerLeft=[[LeftViewController alloc] initWithNibName:@"LeftViewController" bundle:nil];
    
    
    NSString *strNib1=@"";
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        strNib1=@"RightViewController_iPad";
    }
    else{
        strNib1=@"RightViewController";
    }
    RightViewController   *masterViewControllerRight=[[RightViewController alloc] initWithNibName:@"RightViewController" bundle:nil];
    
    
    
    self.leftVC=masterViewControllerLeft;
    self.rightVC=masterViewControllerRight;
    
    [self.leftVC view];
    
   UINavigationController *nav1=[[UINavigationController alloc] initWithRootViewController:masterViewControllerLeft] ;
    self.navigationControllerLeft = nav1;
     self.navigationControllerLeft.navigationBarHidden=YES;
    
    
    UINavigationController *nav2=[[UINavigationController alloc] initWithRootViewController:masterViewControllerRight];
    self.navigationControllerRight = nav2;
     self.navigationControllerRight.navigationBarHidden=YES;
    
  
    
    
  
    
    
      self.slidePanelController.shouldDelegateAutorotateToVisiblePanel = NO;
    self.slidePanelController.leftPanel =self.navigationControllerLeft;
    self.slidePanelController.centerPanel =nil;
    self.slidePanelController.rightPanel = nil;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        self.slidePanelController.leftFixedWidth=400;//170
    }
    else{
        self.slidePanelController.leftFixedWidth=170;//196
    }
    
    self.slidePanelController.rightFixedWidth=214;
    
    
    
    [self createAndSetAllCenterNavController];
    DataModel *adm=[[DataModel alloc] init];
    self.dataModel = adm;
    
    
   
    
    id controller=nil;
    
    
    /* self.slidePanelController.centerPanel = self.navigationControllerCenter;//(UIViewController*)self.centerViewController;*/
    
    if(isForceLogOut)
    {
        [self removeUserDefaultValueForKey:ISLOGIN];
         //[self removeUserDefaultValueForKey:LoggedUserID];
    }
    
    if(([self.aDef objectForKey:ISLOGIN] && [self.aDef objectForKey:LoggedUserID]) || [self.aDef objectForKey:ISLOGINWITHFACEBOOK])
    {
        [self.centerViewController setBarBlue];
        [self.centerViewController setStatusBarStyleOwnApp:1];
       controller = self.slidePanelController;
        [self createEventStore];
    }
    else
    {
       // self.slidePanelController.centerPanel =nil;
        
        controller=self.navigationControllerfirst;
        
    }
    
    
   /* CGRect rc=  self.navigationController.navigationBar.frame;
    rc.size.height-=10;
    self.navigationController.navigationBar.frame=rc;
    self.navigationController.navigationBarHidden=NO;*/
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifiedForDeviceTokenSend:) name:kFOUNDDEVICETOKEN object:self];
    
    
  //  [self createLocationManager];
    
    self.window.rootViewController=controller;
    
    
   
    
   
    [self.window makeKeyAndVisible];
    
    [self registerForGetttingDTForPushNotificationServiceStatus:0];
    
    
    
    
    NSDictionary *pushDic = [launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
    if (pushDic != nil)
    {
        NSLog(@"Notification");
        
          [self processPushData:pushDic];
        
    }
   
    
    
    //// facebook sdk change 8th july
    
   /* if([self.aDef objectForKey:ISLOGINWITHFACEBOOK] && [self.aDef objectForKey:ISLOGIN])
    {
     if (![[FBSession activeSession] isOpen])
     {
         
         if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
             
              [self openSessionWithAllowLoginUI:NO];
             
         }
         else
         {
               [self openSessionWithAllowLoginUI:YES];
         }
         
    
     
     }
    }*/
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    /////////////
    
    
}

- (NSUInteger) application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if ([[self.window.rootViewController presentedViewController] isKindOfClass:[MPMoviePlayerViewController class]])
    {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    else
    {
        return UIInterfaceOrientationMaskPortrait;
    }
}


-(void)removeAllDataOfLoggedInUser
{
    @try {
        
        
        self.myFriendList=nil;
        self.messageUserList=nil;
        [self removeUserDefaultValueForKey:ARRAYNAMES];
        [self removeUserDefaultValueForKey:ARRAYIDS];
        [self removeUserDefaultValueForKey:ARRAYSTATUS];
        [self removeUserDefaultValueForKey:ARRAYTEAMSPORTS];
        [self removeUserDefaultValueForKey:ARRAYISCREATES];
        [self removeUserDefaultValueForKey:ARRAYIMAGES];
        [self removeUserDefaultValueForKey:ARRAYTEXTS];
        //[self removeUserDefaultValueForKey:ISLOGIN];
        
        if([self.aDef objectForKey:ISLOGINWITHFACEBOOK])
        {
            [self removeUserDefaultValueForKey:ISLOGINWITHFACEBOOK];
            [self closeSession];
        }
        
        self.faceBookImageData=nil;
        [self removeUserDefaultValueForKey:NEWLOGIN];
        [self removeUserDefaultValueForKey:LoggedUserDeviceTokenStatus];
        [self removeUserDefaultValueForKey:ISFETCHUSERPROFILEURL];
        [self removeUserDefaultValueForKey:USERPROFILEURL];
        [self removeUserDefaultValueForKey:ISLIKECOMMENTALREADYLOADED];
        [self removeUserDefaultValueForKey:ALLHISTORYLIKECOUNTS];
        [self removeUserDefaultValueForKey:FIRSTTIMEPOSTDICTIONARY];
        [self removeUserDefaultValueForKey:ISFIRSTTIMESHOWPLUSINADDFRIEND];
        [self removeUserDefaultValueForKey:ISFIRSTTIMEENTERADDFRIEND];
        [self removeUserDefaultValueForKey:ISEXISTOWNTEAM];
        self.allHistoryLikesComments=nil;
        self.allHistoryLikesCounts=0;
        self.userOwnImage=nil;
        [self removeAllUserData];
        
        [self deleteAllInvites ];
        [self deleteAllEvents];
        
       
        
    }
    @catch (NSException *exception)
    {
        
        NSLog(@"Exception is=%@",exception);
        
    }

}


-(void)deleteAllInvites
{
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^(void)
                   {
                       
                       NSManagedObjectContext *tmpContext = [[NSManagedObjectContext alloc] init];
                       tmpContext.persistentStoreCoordinator = __persistentStoreCoordinator;
                       
                       // something that takes long
                       NSFetchRequest * request = [[NSFetchRequest alloc] init];
                       
                       [request setEntity:[NSEntityDescription entityForName:INVITE inManagedObjectContext:tmpContext]];
                       NSArray* ar = [tmpContext executeFetchRequest:request error:nil];
                       
                       for(NSManagedObject *anObj in ar)
                       {
                           [tmpContext deleteObject:anObj];
                       }
                       
                       NSError *error;
                       if (![tmpContext save:&error])
                       {
                           // handle error
                       }
                       
                       
                     
                       
                      

                   });
    
    
    
}
-(void)deleteAllEvents
{
    
    
    
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^(void)
                   {
                       
                       NSManagedObjectContext *tmpContext = [[NSManagedObjectContext alloc] init];
                       tmpContext.persistentStoreCoordinator = __persistentStoreCoordinator;
                       
                       
                       NSFetchRequest * request = [[NSFetchRequest alloc] init];
                       
                       [request setEntity:[NSEntityDescription entityForName:EVENT inManagedObjectContext:tmpContext]];
                       [request setPredicate:[NSPredicate predicateWithFormat:@"isPublic==%i",1]];
                       NSArray* ar = [tmpContext executeFetchRequest:request error:nil];
                       
                       for(Event *dataEvent in ar)
                       {
                           if(dataEvent)
                           {
                               EKEvent *newEvent=nil;
                               
                               
                               newEvent= [self.eventStore eventWithIdentifier:((Event*)dataEvent).eventIdentifier];
                               
                               NSError *error=nil;
                               BOOL save=  [self.eventStore removeEvent:newEvent span:EKSpanFutureEvents commit:YES error:&error ];
                               NSLog(@"DeleteEventStatus=%i \n%@",save,error.description);
                               
                            
                               [tmpContext deleteObject:dataEvent];
                               
                           }
                       }
                       
                       

                       
                       NSError *error;
                       if (![tmpContext save:&error])
                       {
                           
                       }
                       
                       
                       
                       
                       
                       
                       /*NSFetchRequest * request1 = [[NSFetchRequest alloc] init];
                       
                       [request1 setEntity:[NSEntityDescription entityForName:EVENTUNREAD inManagedObjectContext:tmpContext]];
                       [request1 setPredicate:[NSPredicate predicateWithFormat:@"type==%i",5]];
                       NSArray* ar1 = [tmpContext executeFetchRequest:request1 error:nil];
                       
                       for(Invite *dataEvent in ar1)
                       {
                           if(dataEvent)
                           {
                               
                               [tmpContext deleteObject:dataEvent];
                               
                           }
                       }
                       
                       
                       
                       error=nil;
                       if (![tmpContext save:&error])
                       {
                           
                       }*/
                       
                       
                   });

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}



-(void)updateAllEvents:(NSString*)teamId :(BOOL)isConvertToPlayer
{
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
	
    [request setEntity:[NSEntityDescription entityForName:EVENT inManagedObjectContext:self.managedObjectContext]];
    
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"isPublic==%i && teamId==%@",1,teamId]];
   
    
    
	NSArray* ar = [self.managedObjectContext executeFetchRequest:request error:nil];
    
    for(Event *dataEvent in ar)
    {
        if(dataEvent.playerName1 && dataEvent.playerId1 && dataEvent.playerUserId1 && dataEvent.isPublicAccept1)
        {
          
            if(isConvertToPlayer)
            {
            dataEvent.isPublicAccept=dataEvent.isPublicAccept1;
            dataEvent.playerName=dataEvent.playerName1;
            dataEvent.playerId=dataEvent.playerId1;
            dataEvent.playerUserId=dataEvent.playerUserId1;
            dataEvent.isCreated=[NSNumber numberWithBool:0];
            
            dataEvent.isPublicAccept1=nil;
            dataEvent.playerName1=nil;
            dataEvent.playerId1=nil;
            dataEvent.playerUserId1=nil;
            }
            else
            {
                dataEvent.isPublicAccept1=nil;
                dataEvent.playerName1=nil;
                dataEvent.playerId1=nil;
                dataEvent.playerUserId1=nil;
            }
            
        }
    }
    
    [self saveContext];
    
    
    
    
}



-(void)createLocationManager
{
	
    if(!locationManager)
    {
        CLLocationManager *aLocationManager = [[CLLocationManager alloc] init];
        [self setLocationManager:aLocationManager];
        locationManager.delegate = self;
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            
            [self.locationManager requestWhenInUseAuthorization];
            
        }
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        locationManager.distanceFilter = 100.0f;
        
    }
  
	 [locationManager startUpdatingLocation];
}

-(void)getNewUpdate
{
     [locationManager startUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	
    NSLog(@"latitude %+.6f, longitude %+.6f\n",
          newLocation.coordinate.latitude,
          newLocation.coordinate.longitude);
    
    
  //  NSDate* eventDate = newLocation.timestamp;
  //  NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
   /* if (abs(howRecent) < 15.0)
    {*/
        [self.locationManager stopUpdatingLocation];
        self.currentLocation =newLocation ;//[newLocation copy];
        self.locationLat = newLocation.coordinate.latitude;
        self.locationLong = newLocation.coordinate.longitude;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kLatLongFound object:self];
        
    //}
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    // If it's a relatively recent event, turn off updates to save power
    CLLocation* location = [locations lastObject];
   // NSDate* eventDate = location.timestamp;
   // NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
   /* if (abs(howRecent) < 15.0)
    {*/
        // If the event is recent, do something with it.
        NSLog(@"latitude %+.6f, longitude %+.6f\n",
              location.coordinate.latitude,
              location.coordinate.longitude);
        
        [self.locationManager stopUpdatingLocation];
        self.currentLocation = location;//[location copy];
        self.locationLat = location.coordinate.latitude;
        self.locationLong =location.coordinate.longitude;
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kLatLongFound object:self];
        
    //}
    
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	if([CLLocationManager locationServicesEnabled] == NO)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Services Disabled"
                                                        message:@"Please enable location services for this app by going to Location Services under General in the settings app."
                                                       delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
        
        
    }else{
       /* NSString * errorString = @"Unable to determine your current location.";
        UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error Locating" message:errorString delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [errorAlert show];*/
    }
	
	[locationManager stopUpdatingLocation];
}








-(void)createEventStore
{
    if(!eventStore)
    {
    EKEventStore *store = [[EKEventStore alloc] init];
        eventStore=store;
     ///////////////////////////////////
        
        if([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
        {
            // iOS 6 and later
            // This line asks user's permission to access his calendar
            [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error)
             {
                 if (granted) // user user is ok with it
                 {
                                     
                     self.defaultCalendar = self.eventStore.defaultCalendarForNewEvents;

                 }
                 else // if he does not allow
                 {
                     self.defaultCalendar = self.eventStore.defaultCalendarForNewEvents;

                    /* [[[UIAlertView alloc]initWithTitle:@"" message:@"Please allow Calendar from Settings>Privacy>Calendars" delegate:nil cancelButtonTitle:@"Okay"  otherButtonTitles: nil] show];*/
                     return;
                 }
             }];
        }
        
        // iOS < 6
        else
        {
           
            self.defaultCalendar = self.eventStore.defaultCalendarForNewEvents;

        
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        //////////////////////////////
                 
         // self.eventsList = [self fetchEvents];
    }
}


/*- (NSMutableArray *)fetchEvents
{
    NSDate *startDate = [NSDate date];
    
    //Create the end date components
    NSDateComponents *tomorrowDateComponents = [[NSDateComponents alloc] init];
    tomorrowDateComponents.day = 1;
	
    NSDate *endDate = [[NSCalendar currentCalendar] dateByAddingComponents:tomorrowDateComponents
                                                                    toDate:startDate
                                                                   options:0];
	// We will only search the default calendar for our events
	NSArray *calendarArray = [NSArray arrayWithObject:self.defaultCalendar];
    
    // Create the predicate
	NSPredicate *predicate = [self.eventStore predicateForEventsWithStartDate:startDate
                                                                      endDate:endDate
                                                                    calendars:calendarArray];
	
	// Fetch all events that match the predicate
	NSMutableArray *events = [NSMutableArray arrayWithArray:[self.eventStore eventsMatchingPredicate:predicate]];
    
	return events;
}
*/


-(void)saveAllUserDataFirstName:(NSString*)FirstName LastName:(NSString*)LastName Address:(NSString*)Address Email:(NSString*)Email Password:(NSString*)Password ContactNo:(NSString*)ContactNo PrimaryEmail1:(NSString*)PrimaryEmail1 PrimaryEmail2:(NSString*)PrimaryEmail2 SecondaryEmail1:(NSString*)SecondaryEmail1 SecondaryEmail2:(NSString*)SecondaryEmail2 SecondaryEmail3:(NSString*)SecondaryEmail3 SecondaryEmail4:(NSString*)SecondaryEmail4 SecondaryEmail5:(NSString*)SecondaryEmail5 SecondaryEmail6:(NSString*)SecondaryEmail6 ProfileImage:(NSString*)ProfileImage teamNotification:(NSString*)teamNotification friendNotification:(NSString *)friendNotification eventNotification:(NSString*)eventNotification messageNotification:(NSString *)messageNotification teamNotificationEmail:(NSString*)teamNotificationEmail friendNotificationEmail:(NSString *)friendNotificationEmail eventNotificationEmail:(NSString*)eventNotificationEmail messageNotificationEmail:(NSString *)messageNotificationEmail
{
    
    
    if(FirstName)
        [self setUserDefaultValue:FirstName ForKey:FIRSTNAME];
    if(LastName)
        [self setUserDefaultValue:LastName ForKey:LASTNAME];
    if(Address)
        [self setUserDefaultValue:Address ForKey:ADDRESS];
    if(Email)
        [self setUserDefaultValue:Email ForKey:EMAIL];
    if(Password)
        [self setUserDefaultValue:Password ForKey:PASSWORD];
    if(ContactNo)
        [self setUserDefaultValue:ContactNo ForKey:CONTACTNO];
    if(PrimaryEmail1)
        [self setUserDefaultValue:PrimaryEmail1 ForKey:PRIMARYEMAIL1];
    if(PrimaryEmail2)
        [self setUserDefaultValue:PrimaryEmail2 ForKey:PRIMARYEMAIL2];
    if(SecondaryEmail1)
        [self setUserDefaultValue:SecondaryEmail1 ForKey:SECONDARYEMAIL1];
    if(SecondaryEmail2)
        [self setUserDefaultValue:SecondaryEmail2 ForKey:SECONDARYEMAIL2];
    if(SecondaryEmail3)
        [self setUserDefaultValue:SecondaryEmail3 ForKey:SECONDARYEMAIL3];
    if(SecondaryEmail4)
        [self setUserDefaultValue:SecondaryEmail4 ForKey:SECONDARYEMAIL4];
    if(SecondaryEmail5)
        [self setUserDefaultValue:SecondaryEmail5 ForKey:SECONDARYEMAIL5];
    if(SecondaryEmail6)
        [self setUserDefaultValue:SecondaryEmail6 ForKey:SECONDARYEMAIL6];
    
    if (teamNotification)
        [self setUserDefaultValue:teamNotification ForKey:TEAMNTIFICATION];
    if (teamNotificationEmail)
        [self setUserDefaultValue:teamNotificationEmail ForKey:TEAMNOTIFICATIONEMAIL];

    if (friendNotification)
        [self setUserDefaultValue:friendNotification ForKey:FRIENDNOTIFICATION];
    if (friendNotificationEmail)
        [self setUserDefaultValue:friendNotificationEmail ForKey:FRIENDNOTIFICATIONEMAIL];
    
    if (eventNotification)
        [self setUserDefaultValue:eventNotification ForKey:EVENTNOTIFICATION];
    if (eventNotificationEmail)
        [self setUserDefaultValue:eventNotificationEmail ForKey:EVENTNOTIFICATIONEMAIL];
   
    
    if (messageNotification)
        [self setUserDefaultValue:messageNotification ForKey:MESSAGENOTIFICATION];
    if (messageNotificationEmail)
        [self setUserDefaultValue:messageNotificationEmail ForKey:MESSAGENOTIFICATIONEMAIL];
    
}

/*FirstName:(NSString*)FirstName LastName:(NSString*)LastName Address:(NSString*)Address Email:(NSString*)Email Password:(NSString*)Password ContactNo:(NSString*)ContactNo PrimaryEmail1:(NSString*)PrimaryEmail1 PrimaryEmail2:(NSString*)PrimaryEmail2 SecondaryEmail1:(NSString*)SecondaryEmail1 SecondaryEmail2:(NSString*)SecondaryEmail2 SecondaryEmail3:(NSString*)SecondaryEmail3 SecondaryEmail4:(NSString*)SecondaryEmail4 SecondaryEmail5:(NSString*)SecondaryEmail5 SecondaryEmail6:(NSString*)SecondaryEmail6 ProfileImage:(NSString*)ProfileImage*/
-(void)removeAllUserData
{
    
   // if(FirstName)
        [self removeUserDefaultValueForKey:FIRSTNAME];
   // if(LastName)
        [self removeUserDefaultValueForKey:LASTNAME];
   // if(Address)
        [self removeUserDefaultValueForKey:ADDRESS];
   // if(Email)
        [self removeUserDefaultValueForKey:EMAIL];
  //  if(Password)
        [self removeUserDefaultValueForKey:PASSWORD];
   // if(ContactNo)
        [self removeUserDefaultValueForKey:CONTACTNO];
   // if(PrimaryEmail1)
        [self removeUserDefaultValueForKey:PRIMARYEMAIL1];
    //if(PrimaryEmail2)
        [self removeUserDefaultValueForKey:PRIMARYEMAIL2];
    //if(SecondaryEmail1)
        [self removeUserDefaultValueForKey:SECONDARYEMAIL1];
   // if(SecondaryEmail2)
        [self removeUserDefaultValueForKey:SECONDARYEMAIL2];
   // if(SecondaryEmail3)
        [self removeUserDefaultValueForKey:SECONDARYEMAIL3];
   // if(SecondaryEmail4)
        [self removeUserDefaultValueForKey:SECONDARYEMAIL4];
   // if(SecondaryEmail5)
        [self removeUserDefaultValueForKey:SECONDARYEMAIL5];
   // if(SecondaryEmail6)
        [self removeUserDefaultValueForKey:SECONDARYEMAIL6];
    
    
    
    
    
}

-(void)setHomeView
{
}
/*-(void)setHomeView
{
    
    NSLog(@"CallAppDelegateSetHomeView");
    
    float height=self.centerViewController.view.bounds.size.height-49;//Ch in xcode 5 (424)
    
    if(self.isIphone5)
        height+=88;
    
    CGRect r= self.navigationController.view.frame;
    r.origin.y=0;                                        //Ch in xcode 5 (36) in all (0) origin.y
    r.size.height=height;
    self.navigationController.view.frame=r;
    
    r= self.navigationControllerSettings.view.frame;
    r.origin.y=0;
    r.size.height=height;
    self.navigationControllerSettings.view.frame=r;
    
    r= self.navigationControllerTeamMaintenance.view.frame;
    r.origin.y=0;
    r.size.height=height;
    self.navigationControllerTeamMaintenance.view.frame=r;
    
  TeamMaintenanceVC *ateamvc=  (TeamMaintenanceVC*)[self.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0];
    
    if(self.isIphone5)
        ateamvc.teamNavController.view.frame=CGRectMake(0,0,320,(self.commonHeight+88));
    else
        ateamvc.teamNavController.view.frame=CGRectMake(0,0,320,self.commonHeight);
    
    
    
    r= self.navigationControllerCalendar.view.frame;
    r.origin.y=0;
    r.size.height=height;
    self.navigationControllerCalendar.view.frame=r;
    
    r= self.navigationControllerClubLeague.view.frame;
    r.origin.y=0;
    r.size.height=height;
    self.navigationControllerClubLeague.view.frame=r;
    
    r= self.navigationControllerAddAFriend.view.frame;
    r.origin.y=0;
    r.size.height=height;
    self.navigationControllerAddAFriend.view.frame=r;
    
        
    r= self.navigationControllerMyContact.view.frame;
    r.origin.y=0;
    r.size.height=height;
    self.navigationControllerMyContact.view.frame=r;
    
    r= self.navigationControllerMySchdule.view.frame;
    r.origin.y=0;
    r.size.height=height;
    self.navigationControllerMySchdule.view.frame=r;
    
    r= self.navigationControllerTrainingVideo.view.frame;
    r.origin.y=0;
    r.size.height=height;
    self.navigationControllerTrainingVideo.view.frame=r;
    
    r= self.navigationControllerMyPhoto.view.frame;
    r.origin.y=0;
    r.size.height=height;
    self.navigationControllerMyPhoto.view.frame=r;
    
    r= self.navigationControllerBuySell.view.frame;
    r.origin.y=0;
    r.size.height=height;
    self.navigationControllerBuySell.view.frame=r;
    
    r= self.navigationControllerTeamRoster.view.frame;
    r.origin.y=0;
    r.size.height=height;
    self.navigationControllerTeamRoster.view.frame=r;
    

    r= self.navigationControllerFaq.view.frame;
    r.origin.y=0;
    r.size.height=height;
    self.navigationControllerFaq.view.frame=r;
    
    r= self.navigationControllerFeedBack.view.frame;
    r.origin.y=0;
    r.size.height=height;
    self.navigationControllerFeedBack.view.frame=r;
    
    r= self.navigationControllerChat.view.frame;
    r.origin.y=0;
    r.size.height=height;
    self.navigationControllerChat.view.frame=r;
}*/

-(void)setHomeViewToUp
{
    CGRect r= self.navigationController.view.frame;
    r.origin.y=0;
    self.navigationController.view.frame=r;
    
    
    
    
}

-(void)setTeamMaintenanceViewToUp
{
    CGRect r= self.navigationControllerTeamMaintenance.view.frame;
    r.origin.y=0;
    self.navigationControllerTeamMaintenance.view.frame=r;

    
}

////AD july For Myteam

-(void)setMyTeamViewToUp
{
    CGRect r= self.navigationControllerMyTeams.view.frame;
    r.origin.y=0;
    self.navigationControllerMyTeams.view.frame=r;
    
    
}

//////

-(void)setSettingsViewTopup{
    
    CGRect r1= self.navigationControllerSettings.view.frame;
    r1.origin.y=0;
    self.navigationControllerSettings.view.frame=r1;
    

}

-(void)createAndSetAllCenterNavController
{
    ///////////Center Controller VC
     PushByInviteFriendVC *adVC=[[PushByInviteFriendVC alloc]initWithNibName:@"PushByInviteFriendVC" bundle:nil];
    
    
    HomeVC *masterViewController=[[HomeVC alloc] initWithNibName:@"HomeVC" bundle:nil];
    self.centerVC=masterViewController;

    EventCalendarViewController *masterViewControllerCal=[[EventCalendarViewController alloc] initWithNibName:@"EventCalendarViewController" bundle:nil];
    TeamMaintenanceVC *masterViewControllerTeamMaintenance =[[TeamMaintenanceVC alloc]initWithNibName:@"TeamMaintenanceVC" bundle:nil];
    
   ////// AD .... july for MyTeam
    MyTeamsViewController *masterViewControllerMyTeams =[[MyTeamsViewController alloc]initWithNibName:@"MyTeamsViewController" bundle:nil];
    
    
   SettingsViewController *sepVC=[[SettingsViewController alloc]initWithNibName:@"SettingsViewController" bundle:nil];
    
   
    /////////////
  //  ClubLeagueViewController *clubLeague=[[ClubLeagueViewController alloc] initWithNibName:@"ClubLeagueViewController" bundle:nil];
    
   // MyContactViewController *myContact=[[MyContactViewController alloc] initWithNibName:@"MyContactViewController" bundle:nil];
    
   // MySchduleViewController *mySchdule=[[MySchduleViewController alloc] initWithNibName:@"MySchduleViewController" bundle:nil];
    
    PhotoMainVC *myPhoto=[[PhotoMainVC alloc] initWithNibName:@"PhotoMainVC" bundle:nil];
    
  // ShowVideoViewController *trainingViedo=[[ShowVideoViewController alloc] initWithNibName:@"ShowVideoViewController" bundle:nil];
    //self.trainningVideoVC=trainingViedo;
  //  BuySellViewController *buysell=[[BuySellViewController alloc] initWithNibName:@"BuySellViewController" bundle:nil];
    
   
    
    
    FAQViewController *faqView=[[FAQViewController alloc] initWithNibName:@"FAQViewController" bundle:nil];
    
    FeedBackViewController *feedBack=[[FeedBackViewController alloc] initWithNibName:@"FeedBackViewController" bundle:nil];
    
    Tutorila1ViewController *tutorial=[[Tutorila1ViewController alloc] initWithNibName:@"Tutorila1ViewController" bundle:nil];
    
   // PushByCoachUpdateVC *coachUpVC=[[PushByCoachUpdateVC alloc] initWithNibName:@"PushByCoachUpdateVC" bundle:nil];
    
    
    
 //   PushByEventsVC *pushByEventVC=[[PushByEventsVC alloc] initWithNibName:@"PushByEventsVC" bundle:nil];
    

  MainInviteVC *mainInvitevc=[[MainInviteVC alloc] initWithNibName:@"MainInviteVC" bundle:nil];
    
    ChatMessageViewController *chatMessage=[[ChatMessageViewController alloc] initWithNibName:@"ChatMessageViewController" bundle:nil];
    
    
    
    TeamEventsVC *teamEventsVC=[[TeamEventsVC alloc] initWithNibName:@"TeamEventsVC" bundle:nil];
    
      PrimaryMemeberViewController *primary=[[PrimaryMemeberViewController alloc] initWithNibName:@"PrimaryMemeberViewController" bundle:nil];

    ///////////////Center Controller Navigation
    UINavigationController *nav4=[[UINavigationController alloc] initWithRootViewController:adVC];
    self.navigationControllerAddAFriend=nav4;
    self.navigationControllerAddAFriend.navigationBarHidden=YES;
    
    nav4=[[UINavigationController alloc] initWithRootViewController:masterViewController] ;
    
    self.navigationController = nav4;
    self.navigationController.navigationBarHidden=YES;
    
    nav4=[[UINavigationController alloc] initWithRootViewController:masterViewControllerCal] ;
    self.navigationControllerCalendar = nav4;
    self.navigationControllerCalendar.navigationBarHidden=YES;
    
   
    
    
    nav4=[[UINavigationController alloc]initWithRootViewController:masterViewControllerTeamMaintenance];
    self.navigationControllerTeamMaintenance=nav4;
    self.navigationControllerTeamMaintenance.navigationBarHidden=YES;
    
  ////// AD .... july for MyTeam
    nav4=[[UINavigationController alloc]initWithRootViewController:masterViewControllerMyTeams];
    self.navigationControllerMyTeams=nav4;
    self.navigationControllerMyTeams.navigationBarHidden=YES;
    
/////////////////
    
    nav4=[[UINavigationController alloc] initWithRootViewController:sepVC];
    self.navigationControllerSettings=nav4;
    self.navigationControllerSettings.navigationBarHidden=YES;
    
    
    nav4=[[UINavigationController alloc] initWithRootViewController:primary];
    self.navigationControllerPrimaryMemeber=nav4;
    self.navigationControllerPrimaryMemeber.navigationBarHidden=YES;
    ////////////////
   /* nav4=[[UINavigationController alloc] initWithRootViewController:clubLeague];
    self.navigationControllerClubLeague=nav4;
    self.navigationControllerClubLeague.navigationBarHidden=YES;*/
    
   /* nav4=[[UINavigationController alloc] initWithRootViewController:myContact];
    self.navigationControllerMyContact=nav4;
    self.navigationControllerMyContact.navigationBarHidden=YES;*/
    
  /*  nav4=[[UINavigationController alloc] initWithRootViewController:mySchdule];
    self.navigationControllerMySchdule=nav4;
  self.navigationControllerMySchdule.navigationBarHidden=YES;*/
    
    nav4=[[UINavigationController alloc] initWithRootViewController:myPhoto];
    self.navigationControllerMyPhoto=nav4;
    self.navigationControllerMyPhoto.navigationBarHidden=YES;
    
  /*  nav4=[[UINavigationController alloc]initWithRootViewController:trainingViedo];
    self.navigationControllerTrainingVideo=nav4;
    self.navigationControllerTrainingVideo.navigationBarHidden=YES;*/
    
   /* nav4=[[UINavigationController alloc] initWithRootViewController:buysell];
    self.navigationControllerBuySell=nav4;
    self.navigationControllerBuySell.navigationBarHidden=YES;*/
    
    

    
    nav4=[[UINavigationController alloc] initWithRootViewController:faqView];
    self.navigationControllerFaq=nav4;
    self.navigationControllerFaq.navigationBarHidden=YES;
    
    nav4=[[UINavigationController alloc] initWithRootViewController:feedBack];
    self.navigationControllerFeedBack=nav4;
    self.navigationControllerFeedBack.navigationBarHidden=YES;
    
    ///////  10/03/15   ////
    
    nav4=[[UINavigationController alloc] initWithRootViewController:tutorial];
    self.navigationControllerTutorial=nav4;
    self.navigationControllerTutorial.navigationBarHidden=YES;
    
    //////  AD  //////////
    
   /* nav4=[[UINavigationController alloc] initWithRootViewController:pushByEventVC] ;
    self.navigationControllerEventNews = nav4;
    self.navigationControllerEventNews.navigationBarHidden=YES;*/
    
    
    /*nav4=[[UINavigationController alloc] initWithRootViewController:coachUpVC] ;
    self.navigationControllerCoachUpdate = nav4;
    self.navigationControllerCoachUpdate.navigationBarHidden=YES;*/

   

    nav4=[[UINavigationController alloc] initWithRootViewController:mainInvitevc];
    self.navigationControllerTeamInvites=nav4;
    self.navigationControllerTeamInvites.navigationBarHidden=YES;
    
    nav4=[[UINavigationController alloc] initWithRootViewController:chatMessage];
    self.navigationControllerChatMessage=nav4;
    self.navigationControllerChatMessage.navigationBarHidden=YES;
    
    
    nav4=[[UINavigationController alloc] initWithRootViewController:teamEventsVC] ;
    self.navigationControllerTeamEvents = nav4;
    self.navigationControllerTeamEvents.navigationBarHidden=YES;
    
   
    
    CenterViewController *cVC=[[CenterViewController alloc] initWithNibName:@"CenterViewController" bundle:nil] ;
    self.centerViewController=cVC;
    
    nav4=[[UINavigationController alloc] initWithRootViewController:cVC] ;
    self.navigationControllerCenter = nav4;
    self.navigationControllerCenter.navigationBarHidden=NO;
    
    
    
    
    adVC.delegate=cVC;
    
    
    
    
    
    
    
   // coachUpVC.delegate=cVC;
    
    mainInvitevc.delegate=cVC;
    
  //  pushByEventVC.delegate=cVC;
    chatMessage.delegate=cVC;

   // [mainInvitevc view];
    /*[adVC view];
    [coachUpVC view];*/
       self.slidePanelController.centerPanel = self.navigationControllerCenter;
    
   
    
   
}

-(void)addEventsAfterLogin:(NSArray*)arr :(BOOL) createdby :(NSString*)playername :(NSString*)playerid :(NSString*)playeruserid :(BOOL)isTeamMayBe :(BOOL)isTeamAdmin :(BOOL)isPlayerAndAdmin :(BOOL)isAdminAndPlayer
{
        NSLog(@"EventsNumberAddedInLoginCall=%i",arr.count);
    int i=0;
    
    for(NSDictionary *eventDetails in arr)
    {
        i++;
        
        
        
        
      
        
        
        NSDictionary *dic=eventDetails;
        
        
        
        if([eventDetails objectForKey:@"event_invite_status"])
        {
            if([[eventDetails objectForKey:@"event_invite_status"] isEqualToString:PENDING] && (!createdby))
            {
                
            
                continue;
            }
            
        }
        
        if([[eventDetails objectForKey:@"Status"] isEqualToString:PENDING] && (!createdby))
        {
            
            
            
            
            continue;
        }
        
        NSString *eId=[eventDetails objectForKey:@"event_id"];
        
        
        
        if(createdby || ([[eventDetails objectForKey:@"view_status"] integerValue]))
        {
       
        ///////
         Event *dataEvent=nil;
        Event *anObj = nil;
        NSFetchRequest * request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:EVENT inManagedObjectContext:self.managedObjectContext]];
         
        [request setPredicate:[NSPredicate predicateWithFormat:@"(eventId==%@) AND (userId=%@)",eId,[self.aDef objectForKey:LoggedUserID]]];
             
        NSArray* ar =nil;
        ar= [self.managedObjectContext executeFetchRequest:request error:nil];
        if ([ar count]>=1)
        {
            anObj= (Event *) [ar objectAtIndex:0];
        }
        
        
        dataEvent=anObj;
        
        ///////
    
           Event   *eventvar = nil;
        if(!dataEvent)
        {
    
         
            eventvar= (Event *)[NSEntityDescription insertNewObjectForEntityForName:EVENT inManagedObjectContext:self.managedObjectContext];
        }
        else
        {
            eventvar=dataEvent;
            
            
            
            if(isPlayerAndAdmin)////Admin Exist
            {
                eventvar.playerName1=playername;
                eventvar.playerId1=playerid;
                eventvar.playerUserId1=playeruserid;
                //eventvar.isTeamMayBe=[NSNumber numberWithBool:isTeamMayBe];
                if(isTeamMayBe)
                {
                    eventvar.isPublicAccept1=[NSNumber numberWithInt:3];
                }
                else
                {
                    if([[eventDetails objectForKey:@"Status"] isEqualToString:@"Accept"] )
                        eventvar.isPublicAccept1=[NSNumber numberWithInt:0];
                    else if([[eventDetails objectForKey:@"Status"] isEqualToString:@"Decline"])
                        eventvar.isPublicAccept1=[NSNumber numberWithInt:2];
                    else if([[eventDetails objectForKey:@"Status"] isEqualToString:@"Maybe"])
                        eventvar.isPublicAccept1=[NSNumber numberWithInt:3];
                    else
                        eventvar.isPublicAccept1=[NSNumber numberWithInt:1];
                }

                
                [self saveContext];
                
                continue;
            }
            
            
            
            
            
            if(isAdminAndPlayer)//Player Exist
            {
                eventvar.playerName1=eventvar.playerName;
                eventvar.playerId1=eventvar.playerId;
                eventvar.playerUserId1=eventvar.playerUserId;
                //eventvar.isTeamMayBe=[NSNumber numberWithBool:isTeamMayBe];
               
                eventvar.isPublicAccept1=eventvar.isPublicAccept;
                
                
              
            }
        }
              eventvar.isPublic=[NSNumber numberWithBool:1];
            eventvar.isCreated=[NSNumber numberWithBool:createdby];
            
            if(!createdby)
            {
                eventvar.playerName=playername;
                 eventvar.playerId=playerid;
                eventvar.playerUserId=playeruserid;
            }
            else
            {
                
                /////  AD 21th May
                
                /*if(isTeamAdmin)
                eventvar.playerName=ADMIN;
                else
                eventvar.playerName=COACH;*/
                
                eventvar.playerName=[NSString stringWithFormat:@"%@ %@",[self.aDef objectForKey:FIRSTNAME],[self.aDef objectForKey:LASTNAME]];
                
                eventvar.playerId=[self.aDef objectForKey:LoggedUserID];
                eventvar.playerUserId=[self.aDef objectForKey:LoggedUserID];
                
                
                
            }
            
            
            eventvar.eventDate=[self.dateFormatDb dateFromString:[dic objectForKey:@"event_date"]];
            eventvar.teamId= [NSString stringWithFormat:@"%@",  [dic objectForKey:@"team_id"] ];
            eventvar.teamName= [dic objectForKey:@"team_name"];
            eventvar.eventName=[dic objectForKey:@"event_name"];
            eventvar.eventType=[dic objectForKey:@"event_type"];
            eventvar.location= [dic objectForKey:@"location"];
            eventvar.fieldName= [dic objectForKey:@"field_name"];
            eventvar.isHomeGame= [NSNumber numberWithBool:[[dic objectForKey:@"is_home_ground"] boolValue] ];
            eventvar.notes= [dic objectForKey:@"notes"];
            eventvar.repeat=[self.centerViewController.arrPickerItemsRepeat objectAtIndex:[[dic objectForKey:@"repeat"] integerValue] ];
            eventvar.arrivalTime=[self.dateFormatFullOriginal dateFromString:[NSString stringWithFormat:@"%@, %@",[dic objectForKey:@"event_date"],[dic objectForKey:@"arrival_time"]] ];
            eventvar.startTime=[self.dateFormatFullOriginal dateFromString:[NSString stringWithFormat:@"%@, %@",[dic objectForKey:@"event_date"],[dic objectForKey:@"start_time"]] ];;
            eventvar.endTime=[self.dateFormatFullOriginal dateFromString:[NSString stringWithFormat:@"%@, %@",[dic objectForKey:@"event_date"],[dic objectForKey:@"end_time"]] ];;
            eventvar.uniformColor=[dic objectForKey:@"uniform"];
            eventvar.opponentTeamId= [dic objectForKey:@"opponent_team_id"];
            eventvar.opponentTeam= [dic objectForKey:@"opponent_team"];
            eventvar.thingsToBring= [dic objectForKey:@"things_to_bring"];
            eventvar.alertString=[self.centerViewController.arrPickerItemsAlert objectAtIndex:[[dic objectForKey:@"alert"] integerValue]];
            
            NSDate *stDateF= [self.centerViewController dateFromSD:eventvar.eventDate ];
            if(![eventvar.alertString isEqualToString:@"Never"])
            {
                NSDate *d=[self.centerViewController getAlertDateForAlertString:eventvar.alertString:eventvar.startTime];
                NSDate *arrDate3=[self.centerViewController dateFromSD:d];
                
                eventvar.alertDate=[stDateF dateByAddingTimeInterval:[d timeIntervalSinceDate:arrDate3]];
            }
            
            
          
            if(isTeamMayBe)
            {
              eventvar.isPublicAccept=[NSNumber numberWithInt:3];
            }
            else
            {
              if([[eventDetails objectForKey:@"Status"] isEqualToString:@"Accept"] || createdby)
              eventvar.isPublicAccept=[NSNumber numberWithInt:0];
              else if([[eventDetails objectForKey:@"Status"] isEqualToString:@"Decline"])
              eventvar.isPublicAccept=[NSNumber numberWithInt:2];
              else if([[eventDetails objectForKey:@"Status"] isEqualToString:@"Maybe"])
                  eventvar.isPublicAccept=[NSNumber numberWithInt:3];
              else
              eventvar.isPublicAccept=[NSNumber numberWithInt:1];
            }
    
            eventvar.eventIdentifier=nil;
            eventvar.userId=[self.aDef objectForKey:LoggedUserID];
            eventvar.creatorUserId=[dic objectForKey:@"createdby"];
            eventvar.eventId=[dic objectForKey:@"event_id"];
            
            
           NSLog(@"GetDateTimeCanNameBeforeCheckDate=%@", [self.dateFormatDb stringFromDate:eventvar.eventDate]);
            eventvar.eventDateString=[self.centerViewController getDateTimeCanName:eventvar.eventDate];
           
            NSLog(@"GetDateTimeCanNameAfterCheckDate=%@",eventvar.eventDateString);
            
            
            
            
            if([[eventDetails objectForKey:@"Status"] isEqualToString:@"Accept"] || createdby)
            {
                
                EKEvent *newEvent=nil;
                newEvent= [EKEvent eventWithEventStore:self.eventStore];
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                
                if ([defaults objectForKey:@"Calendar"] == nil) // Create Calendar if Needed
                {
                    EKSource *theSource = nil;
                    
                    for (EKSource *source in self.eventStore.sources)
                    {
                        if (source.sourceType == EKSourceTypeCalDAV && [source.title isEqualToString:@"iCloud"])
                        {
                            theSource = source;
                            NSLog(@"iCloud Store Source");
                            break;
                        }
                        else
                        {
                            for (EKSource *source in self.eventStore.sources)
                            {
                                if (source.sourceType == EKSourceTypeLocal)
                                {
                                    theSource = source;
                                    NSLog(@"iPhone Local Store Source");
                                    break;
                                }
                            }
                        }
                    }
                    
                    EKCalendar *cal;
                    if(self.systemVersion<6.0)
                        cal=[EKCalendar calendarWithEventStore:self.eventStore];
                    else
                        cal=[EKCalendar calendarForEntityType:EKEntityTypeEvent eventStore:self.eventStore ];
                    
                    cal.title = @"hello";
                    cal.source = theSource;
                    [self.eventStore saveCalendar:cal commit:YES error:nil];
                    NSLog(@"cal id = %@", cal.calendarIdentifier);
                    NSString *calendar_id = cal.calendarIdentifier;
                    [defaults setObject:calendar_id forKey:@"Calendar"];
                    [defaults synchronize];
                    newEvent.calendar  = cal;
                    
                }
                else
                {
                    newEvent.calendar  = [self.eventStore calendarWithIdentifier:[defaults objectForKey:@"Calendar"]];
                    NSLog(@"Calendar Existed");
                    
                   /* if(self.defaultCalendar)
                        newEvent.calendar=self.defaultCalendar;*/
                }
                
                newEvent.title=eventvar.eventName;
                newEvent.startDate=eventvar.startTime;
                newEvent.endDate=eventvar.endTime;
                newEvent.location=eventvar.location;
                if(eventvar.alertDate)
                {
                    EKAlarm *newAlarm=[EKAlarm alarmWithAbsoluteDate:eventvar.alertDate];
                    [newEvent addAlarm:newAlarm];
                }
                
                
                
                if(![eventvar.repeat isEqualToString:@"Never"])
                {
                    EKRecurrenceFrequency rfcy;
                    
                    
                    if([eventvar.repeat isEqualToString:@"Every Day"])
                    {
                        rfcy=EKRecurrenceFrequencyDaily;
                    }
                    else if([eventvar.repeat isEqualToString:@"Every Week"])
                    {
                        rfcy=EKRecurrenceFrequencyWeekly;
                    }
                    else if([eventvar.repeat isEqualToString:@"Every Month"])
                    {
                        rfcy=EKRecurrenceFrequencyMonthly;
                    }
                    else
                    {
                        rfcy=EKRecurrenceFrequencyYearly;
                    }
                    
                    EKRecurrenceRule *rule=[[EKRecurrenceRule alloc] initRecurrenceWithFrequency:rfcy interval:1 end:nil];
                    [newEvent addRecurrenceRule:rule];
                    
                }
                NSError *error=nil;
                BOOL save=  [self.eventStore saveEvent:newEvent span:EKSpanFutureEvents commit:YES error:&error];
                NSLog(@"SaveEventStatus....1=%i \n%@",save,error.description);
                
                eventvar.eventIdentifier=newEvent.eventIdentifier;
               
                
                
                /*if(save)
                {*/
                    
                [self saveContext];
                /*}
                else
                {
                    [self.managedObjectContext rollback];
                }*/
                
                
            }
            else
            {
                
                NSLog(@"EventSaveNumber=%i",i);
                 [self saveContext];
            }
          
        
      //////
        
        
      }
        else
        {
            if([[self.aDef objectForKey:EVENTNOTIFICATION] isEqualToString:@"Y"])
            {
                
                
            if([[eventDetails objectForKey:@"Status"] isEqualToString:NORESPONSE])
            {
            
            Invite *dataEvent=nil;
            Invite *anObj = nil;
            NSFetchRequest * request = [[NSFetchRequest alloc] init];
            [request setEntity:[NSEntityDescription entityForName:EVENTUNREAD inManagedObjectContext:self.managedObjectContext]];
            
            [request setPredicate:[NSPredicate predicateWithFormat:@"(eventId==%@) AND (userId==%@) AND (type==%i)",eId,[self.aDef objectForKey:LoggedUserID],5]];
            
            NSArray* ar =nil;
            ar= [self.managedObjectContext executeFetchRequest:request error:nil];
            if ([ar count]>=1)
            {
                anObj= (Invite *) [ar objectAtIndex:0];
            }
            
            
            dataEvent=anObj;
            
            ///////
              Invite   *eventvar = nil;
            
            if(!dataEvent)
            {

                
              
                eventvar= (Invite *)[NSEntityDescription insertNewObjectForEntityForName:EVENTUNREAD inManagedObjectContext:self.managedObjectContext];
            }
            else
            {
                eventvar=dataEvent;
            }
                 eventvar.inviteStatus=[NSNumber numberWithInt:1];
                eventvar.isPublic=[NSNumber numberWithBool:1];
                eventvar.playerName=playername;
                eventvar.playerId=playerid;
                eventvar.playerUserId=playeruserid;
                
                
                eventvar.eventName=[dic objectForKey:@"event_name"];
                eventvar.eventId=[dic objectForKey:@"event_id"];
                eventvar.teamName=[dic objectForKey:@"team_name"];
                  eventvar.teamLogo=[dic objectForKey:@"team_logo"];
                eventvar.userId=[self.aDef objectForKey:LoggedUserID];
               // eventvar.creatorUserId=[dic objectForKey:@"createdby"];
                eventvar.type=[[NSNumber alloc] initWithInt:5];
                if([dic objectForKey:@"adddate"])
                {
                    int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                    
                    NSDate *datetime=   [[self.dateFormatFullOriginalComment dateFromString:[dic objectForKey:@"adddate"]] dateByAddingTimeInterval:difftime]  ;
                    
                    
                    eventvar.datetime=datetime;
                }
                
                
                
                
                [self saveContext];
            
                
                
                
            }
          /////////////
            }
        }
    }
    
}

-(void)notifiedForDeviceTokenSend:(id)sen
{
    NSString *deviceToken=[self.aDef objectForKey:DEVICE_TOKEN];
    NSString *userId=[self.aDef objectForKey:LoggedUserID];
    
    [self sendDeviceToServerDeviceToken:deviceToken UserId:userId CheckStatus:0];
}


-(void)sendDeviceToServerDeviceToken:(NSString*)dToken UserId:(NSString*)userId CheckStatus:(BOOL)status
{
    if(dToken)
    {
        
        
        SBJsonWriter *writer = [[SBJsonWriter alloc] init];
        
        NSDictionary *command=  [NSDictionary dictionaryWithObjectsAndKeys:dToken,@"deviceToken",userId,@"UserID",@"Iphone",@"deviceType",[self.aDef objectForKey:UDID],@"IMEI", nil];
        NSString *jsonCommand = [writer stringWithObject:command];
        
        NSLog(@"RequestParamJSON=%@=====%@",jsonCommand,command);
        
        SingleRequest *sinReq=[[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:SINGLEREQUESTLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
           self.sinReq1=sinReq;
        [self.storeCreatedRequests addObject:self.sinReq1];
        [sinReq startRequest];
        
     
    }
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    
    NSString* currentDeviceToken = [[[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"Device Token : %@" , currentDeviceToken);
    NSLog(@"Remote type : %d", [[UIApplication sharedApplication] enabledRemoteNotificationTypes]);
    
    [self setUserDefaultValue:currentDeviceToken ForKey:DEVICE_TOKEN];
    
    if(currentSendDeviceTokenStatus==1)
    {
        self.currentSendDeviceTokenStatus=0;
    [[NSNotificationCenter defaultCenter ] postNotificationName:kFOUNDDEVICETOKEN object:self];
    }
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
   
    NSLog(@"Fail to register for remote notifications: %@", error);
    
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    NSLog(@"Notification Received : %d PushData=%@", [userInfo count],userInfo);
    
    [self processPushData:userInfo];
    
    
}


-(void)savependingMessage:(NSArray*)messageList
{
    
    self.allPendingMessage=(NSMutableArray*)messageList;
}


-(void)processPushData:(NSDictionary*)userInfo
{
    
    @autoreleasepool
    {
        
    
    
    NSDictionary *absDetails=   [userInfo objectForKey:@"aps"];
    
  
    int isShowAlert=0;
    
    
    NSDictionary *eventDetails=[userInfo objectForKey:@"details_event"];
    
    
    
    if(!isProcessEventPublic)
    {
    if(eventDetails)
    {
         if([[eventDetails objectForKey:@"msg"] isEqualToString:@"event_deleted"])
        {
            
            /*if([[NSString stringWithFormat:@"%@", [eventDetails objectForKey:@"status"]] isEqualToString:@"1"])
            {*/
                
                
                NSString *eId=[NSString stringWithFormat:@"%@", [eventDetails objectForKey:@"e_id"] ];
                NSString *eName=[eventDetails objectForKey:@"e_n"];
                NSString *eTeam=[eventDetails objectForKey:@"t_n"];
                NSString *eDate=[eventDetails objectForKey:@"e_dt"];
                
                
             
                
                
                
                Invite *dataEvent=nil;
                Invite *anObj = nil;
                NSFetchRequest * request = [[NSFetchRequest alloc] init];
                [request setEntity:[NSEntityDescription entityForName:EVENTUNREAD inManagedObjectContext:self.managedObjectContext]];
                
                [request setPredicate:[NSPredicate predicateWithFormat:@"(eventId==%@) AND (userId=%@) AND (type==%i)",eId,[self.aDef objectForKey:LoggedUserID],9]];
                
                NSArray* ar =nil;
                ar= [self.managedObjectContext executeFetchRequest:request error:nil];
                if ([ar count]>=1)
                {
                    anObj= (Invite *) [ar objectAtIndex:0];
                }
                
                
                dataEvent=anObj;
                
                
                Invite   *eventvar = nil;
                
                
                if(!dataEvent)
                {
                    
                    eventvar= (Invite *)[NSEntityDescription insertNewObjectForEntityForName:EVENTUNREAD inManagedObjectContext:self.managedObjectContext];
                    
                    
                    
                }
                else
                {
                    eventvar=dataEvent;
                    
                    
                    
                    
                }
                /////////////////////////Add Event Record for same event if exist
                Invite *anObj1 = nil;
                NSFetchRequest * request1 = [[NSFetchRequest alloc] init];
                [request1 setEntity:[NSEntityDescription entityForName:EVENTUNREAD inManagedObjectContext:self.managedObjectContext]];
                
                [request1 setPredicate:[NSPredicate predicateWithFormat:@"(eventId==%@) AND (userId==%@) AND (type==%i)",eId,[self.aDef objectForKey:LoggedUserID],5]];
                
                NSArray* ar1 =nil;
                ar1= [self.managedObjectContext executeFetchRequest:request1 error:nil];
                if ([ar1 count]>=1)
                {
                    anObj1= (Invite *) [ar1 objectAtIndex:0];
                }
                
                
                
                
                ///////
                
                
                
                
                /////////////////////////
             
              
                
                if(anObj1)
                {
                      eventvar.inviteStatus=[NSNumber numberWithInt:1];
                }
                else
                {
                    
                }
                
                eventvar.viewStatus=[NSNumber numberWithInt:0];
                eventvar.last_id=[eventDetails objectForKey:EDelLASTIDPUSH];
                //if([eventUpdateDetails objectForKey:@"event_name"])
                eventvar.eventName=eName;//[eventUpdateDetails objectForKey:@"event_name"];
                eventvar.eventId=eId;
                
               // if([eventUpdateDetails objectForKey:@"team_name"])
                eventvar.teamName=eTeam;//[eventUpdateDetails objectForKey:@"team_name"];
                if([eventDetails objectForKey:@"t_l"])
                    eventvar.teamLogo=[eventDetails objectForKey:@"t_l"];
                eventvar.userId=[self.aDef objectForKey:LoggedUserID];
                if([eventDetails objectForKey:@"u_dt"])
                {
                    int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                    
                    NSDate *datetime=   [[self.dateFormatFullOriginalComment dateFromString:[eventDetails objectForKey:@"u_dt"]] dateByAddingTimeInterval:difftime]  ;
                    
                    
                    eventvar.datetime=datetime;
                }
                eventvar.type=[[NSNumber alloc] initWithInt:9];
                
                if(eDate)
                {
                    int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                    
                    NSDate *datetime=   [[self.dateFormatFullOriginalComment dateFromString:eDate] dateByAddingTimeInterval:difftime]  ;
                    
                    
                  eventvar.eventDate=datetime;
                }
                
                
                [self saveContext];
                
                

                
                
                
                
                
            
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /*NSString *eId=[NSString stringWithFormat:@"%@", [eventDetails objectForKey:@"event_id"] ];
                  NSString *eName=[eventDetails objectForKey:@"event_name"];
                  NSString *eTeam=[eventDetails objectForKey:@"team_name"];
                  NSString *eDate=[eventDetails objectForKey:@"event_date"];
            
            Event *dataEvent=[self.centerViewController objectOfType2Event:eId];
            
            if(dataEvent)
            {
            EKEvent *newEvent=nil;
            
            
            newEvent= [self.eventStore eventWithIdentifier:dataEvent.eventIdentifier];
            
            NSError *error=nil;
            BOOL save=  [self.eventStore removeEvent:newEvent span:EKSpanFutureEvents commit:YES error:&error ];
            NSLog(@"DeleteEventStatus=%i \n%@",save,error.description);
            
            if(save || dataEvent.isPublicAccept.intValue)
            {
                [self.centerViewController deleteObjectOfTypeEvent:dataEvent];
                
                
                [self showNetworkError:[NSString stringWithFormat:@"%@ Event Deleted for the team %@ on %@",eName,eTeam,eDate]];
                
               EventCalendarViewController *eCal=(EventCalendarViewController*)[self.navigationControllerCalendar.viewControllers objectAtIndex:0];
                
                [self.navigationControllerCalendar popViewControllerAnimated:NO];
                [eCal.calvc.monthView reloadData];
                [eCal.calvc.monthView selectDate:[NSDate date]];
            }
            }
        */
                
                
                
                
                
                
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                
        /*}
        else
        {
            [self showNetworkError:@"Error in Push Message to receive event."];
        }*/
    }
         else
         {
             [self showNetworkError:@"Error in Push Message to receive event."];
         }
    }
    }
    
    
    
    
    
    ///////////////////
    
    NSDictionary *eventDetailsAdded=[userInfo objectForKey:@"details_event_added"];
    
    
    
    if(!isProcessEventPublic)
    {
        if(eventDetailsAdded)
        {
    
    
    /*if([[eventDetails objectForKey:@"message"] isEqualToString:@"event_added"])
    {
        if([[NSString stringWithFormat:@"%@", [eventDetails objectForKey:@"status"]] isEqualToString:@"1"])
        {*/
             NSString *eId=[NSString stringWithFormat:@"%@", [eventDetailsAdded objectForKey:@"event_id"] ];
            if(( ![eId isEqualToString:@""]) && [eventDetailsAdded objectForKey:@"event_id"])
            {
            
           
            
          //  Event *dataEvent=[self.centerViewController objectOfType2Event:eId];
                
                
                
                Invite *dataEvent=nil;
                Invite *anObj = nil;
                NSFetchRequest * request = [[NSFetchRequest alloc] init];
                [request setEntity:[NSEntityDescription entityForName:EVENTUNREAD inManagedObjectContext:self.managedObjectContext]];
                
                [request setPredicate:[NSPredicate predicateWithFormat:@"(eventId==%@) AND (userId=%@) AND (type==%i)",eId,[self.aDef objectForKey:LoggedUserID],5]];
                
                NSArray* ar =nil;
                ar= [self.managedObjectContext executeFetchRequest:request error:nil];
                if ([ar count]>=1)
                {
                    anObj= (Invite *) [ar objectAtIndex:0];
                }
                
                
                  dataEvent=anObj;
                
                
                Invite   *eventvar = nil;
               
            
            if(!dataEvent)
            {
                
                 eventvar= (Invite *)[NSEntityDescription insertNewObjectForEntityForName:EVENTUNREAD inManagedObjectContext:self.managedObjectContext];
                
               /* [self.centerViewController showNavController:self.navigationControllerCalendar];
                EventDetailsViewController *eVC=[[EventDetailsViewController alloc] initWithNibName:@"EventDetailsViewController" bundle:nil];
              
                eVC.eventId=[ NSString stringWithFormat:@"%@",[eventDetailsAdded objectForKey:@"event_id"]];
                eVC.isFromPush=1;
                eVC.playername=[eventDetailsAdded objectForKey:@"player_name"];
                eVC.playerid=[eventDetailsAdded objectForKey:@"player_id"];
                eVC.playeruserid=[eventDetailsAdded objectForKey:@"user_id"];
                [self.navigationControllerCalendar pushViewController:eVC animated:YES ];*/
                
             
                
                ///////
               
            }
            else
            {
                eventvar=dataEvent;
                  
                  
              
                  
            }
                  
                
                
                
                    eventvar.inviteStatus=[NSNumber numberWithInt:1];
                eventvar.viewStatus=[NSNumber numberWithInt:0];
                    eventvar.isPublic=[NSNumber numberWithBool:1];
                    eventvar.playerName=[eventDetailsAdded objectForKey:@"player_name"];
                    eventvar.playerId= [eventDetailsAdded objectForKey:@"player_id"] ;
                    eventvar.playerUserId=[eventDetailsAdded objectForKey:@"user_id"] ;
                    
                    if([eventDetailsAdded objectForKey:@"event_name"])
                    eventvar.eventName=[eventDetailsAdded objectForKey:@"event_name"];
                    eventvar.eventId=eId;
                if([eventDetailsAdded objectForKey:@"team_id"])
                    eventvar.teamId=[eventDetailsAdded objectForKey:@"team_id"];
                 if([eventDetailsAdded objectForKey:@"team_name"])
                    eventvar.teamName=[eventDetailsAdded objectForKey:@"team_name"];
                 if([eventDetailsAdded objectForKey:@"team_logo"])
                    eventvar.teamLogo=[eventDetailsAdded objectForKey:@"team_logo"];
                    eventvar.userId=[self.aDef objectForKey:LoggedUserID];
                    if([eventDetailsAdded objectForKey:@"adddate"])
                    {
                        int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                        
                        NSDate *datetime=   [[self.dateFormatFullOriginalComment dateFromString:[eventDetailsAdded objectForKey:@"adddate"]] dateByAddingTimeInterval:difftime]  ;
                        
                        
                        eventvar.datetime=datetime;
                    }
                     eventvar.type=[[NSNumber alloc] initWithInt:5];
                    [self saveContext];
                

            
        }
        else
        {
            [self showNetworkError:@"Error in Push Message to receive event."];
        }
        }
        
    }
    
       /* }
    
    }*/
    
    
    
    
    ///////////////////
    
  //  NSLog(@"userInfoTest=%@",userInfo);
        NSDictionary *eventUpdateDetails=[userInfo objectForKey:@"event_update_details"];
    
    
    NSLog(@"EventUpdateDetails%@",eventUpdateDetails);
    
    if(eventUpdateDetails)
    {
        
        /*if([[eventUpdateDetails objectForKey:@"msg"] isEqualToString:@"event_updated"])
        {*/
            /*if([[NSString stringWithFormat:@"%@", [eventUpdateDetails objectForKey:@"sta"]] isEqualToString:@"1"])
            {*/
                
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                
                    
                    
                    
                   NSString *eId=[NSString stringWithFormat:@"%@", [eventUpdateDetails objectForKey:@"e_id"] ];
                    
                    
                    
                    Invite *dataEvent=nil;
                    Invite *anObj = nil;
                    NSFetchRequest * request = [[NSFetchRequest alloc] init];
                    [request setEntity:[NSEntityDescription entityForName:EVENTUNREAD inManagedObjectContext:self.managedObjectContext]];
                    
                    [request setPredicate:[NSPredicate predicateWithFormat:@"(eventId==%@) AND (userId=%@) AND (type==%i)",eId,[self.aDef objectForKey:LoggedUserID],8]];
                    
                    NSArray* ar =nil;
                    ar= [self.managedObjectContext executeFetchRequest:request error:nil];
                    if ([ar count]>=1)
                    {
                        anObj= (Invite *) [ar objectAtIndex:0];
                    }
                    
                    
                    dataEvent=anObj;
                    
                    
                    Invite   *eventvar = nil;
                    
                    
                    if(!dataEvent)
                    {
                        
                        eventvar= (Invite *)[NSEntityDescription insertNewObjectForEntityForName:EVENTUNREAD inManagedObjectContext:self.managedObjectContext];
                        
                      
                        
                    }
                    else
                    {
                        eventvar=dataEvent;
                        
                        
                        
                        
                    }
                 /////////////////////////Add Event Record for same event if exist
                Invite *anObj1 = nil;
                NSFetchRequest * request1 = [[NSFetchRequest alloc] init];
                                    [request1 setEntity:[NSEntityDescription entityForName:EVENTUNREAD inManagedObjectContext:self.managedObjectContext]];
                
                                   [request1 setPredicate:[NSPredicate predicateWithFormat:@"(eventId==%@) AND (userId==%@) AND (type==%i)",eId,[self.aDef objectForKey:LoggedUserID],5]];
                
                                   NSArray* ar1 =nil;
                                   ar1= [self.managedObjectContext executeFetchRequest:request1 error:nil];
                                   if ([ar1 count]>=1)
                                    {
                                       anObj1= (Invite *) [ar1 objectAtIndex:0];
                                   }
                
                
                
                
                                    ///////
                
                
                
                    
                 /////////////////////////
                    eventvar.inviteStatus=[NSNumber numberWithInt:1];
                    eventvar.isPublic=[NSNumber numberWithBool:1];
                
                
                eventvar.viewStatus=[NSNumber numberWithInt:0];
                eventvar.last_id=[eventUpdateDetails objectForKey:EUpdtLASTIDPUSH];
                
                if(anObj1)
                {
                    eventvar.playerName=anObj1.playerName;
                    eventvar.playerId= anObj1.playerId ;
                    eventvar.playerUserId=anObj1.playerUserId ;
                }
                
                    
                    if([eventUpdateDetails objectForKey:@"e_n"])
                        eventvar.eventName=[eventUpdateDetails objectForKey:@"e_n"];
                    eventvar.eventId=eId;
                    
                    if([eventUpdateDetails objectForKey:@"t_n"])
                        eventvar.teamName=[eventUpdateDetails objectForKey:@"t_n"];
                    if([eventUpdateDetails objectForKey:@"t_l"])
                        eventvar.teamLogo=[eventUpdateDetails objectForKey:@"t_l"];
                    eventvar.userId=[self.aDef objectForKey:LoggedUserID];
                    if([eventUpdateDetails objectForKey:@"u_dt"])
                    {
                        int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                        
                        NSDate *datetime=   [[self.dateFormatFullOriginalComment dateFromString:[eventUpdateDetails objectForKey:@"u_dt"]] dateByAddingTimeInterval:difftime]  ;
                        
                        
                        eventvar.datetime=datetime;
                    }
                    eventvar.type=[[NSNumber alloc] initWithInt:8];
                
                NSString *eDate=nil;
                eDate=[eventUpdateDetails objectForKey:@"e_dt"];
                
                if(eDate)
                {
                    int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                    
                    NSDate *datetime=   [[self.dateFormatFullOriginalComment dateFromString:eDate] dateByAddingTimeInterval:difftime]  ;
                    
                    
                    eventvar.eventDate=datetime;
                }
                    [self saveContext];
                    
                    
                    
                
                
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                
                
                
            ////////////////////////////////////
                
              /*  NSString *eId=[NSString stringWithFormat:@"%@", [eventUpdateDetails objectForKey:@"e_id"] ];
                
                Event *dataEvent=[self.centerViewController objectOfType2Event:eId];
                
                if(dataEvent)
                {
                    
                    if(dataEvent.isCreated.boolValue==NO)
                    {
                    EventCalendarViewController *evc=(EventCalendarViewController*)[self.navigationControllerCalendar.viewControllers objectAtIndex:0];
                    
                    [evc processEditEvent:eId:1];
                    }
                    
                }*/
                
              /////////////////////////////
                
              //  else
//                {
//                    
//                
//                    Invite *anObj = nil;
//                    NSFetchRequest * request = [[NSFetchRequest alloc] init];
//                    [request setEntity:[NSEntityDescription entityForName:EVENTUNREAD inManagedObjectContext:self.managedObjectContext]];
//                    
//                    [request setPredicate:[NSPredicate predicateWithFormat:@"(eventId==%@) AND (userId==%@) AND (type==%i)",eId,[self.aDef objectForKey:LoggedUserID],5]];
//                    
//                    NSArray* ar =nil;
//                    ar= [self.managedObjectContext executeFetchRequest:request error:nil];
//                    if ([ar count]>=1)
//                    {
//                        anObj= (Invite *) [ar objectAtIndex:0];
//                    }
//                    
//                    
//             
//                    
//                    ///////
//                 
//                    
//                    if(anObj)
//                    {
//                        
//                        EventCalendarViewController *evc=(EventCalendarViewController*)[self.navigationControllerCalendar.viewControllers objectAtIndex:0];
//                        
//                        [evc processEditEvent:eId:0];
//                        
//                        
//                        
//                    }
//                    
//                }
                
                    /////////////
                
                
                
                
                
                
                
             //////////////////////////////
                
            /*}
            else
            {
                [self showNetworkError:@"Error in Push Message to receive event."];
            }*/
        /*}
        else
        {
            [self showNetworkError:@"Error in Push Message to receive event."];
        }*/
    }
    
    
    id mlike= [userInfo objectForKey:@"L_u_id" ] ;
    int flagg=0;
    if(mlike)
    {
        if([mlike isEqualToString:[self.aDef objectForKey:LoggedUserID] ])
            flagg=1;
    }
   //  flagg=0;
    if(!flagg)
    {
    if(mlike)
    {
       // NSString *likeuserId=[NSString stringWithFormat:@"%@",mlike];
        
         /*Invite *invite=(Invite*)  [self.centerViewController objectOfTypeInvite:INVITE forPost:[userInfo objectForKey:@"post_id" ] forUser:likeuserId forType:1 andManObjCon:self.managedObjectContext];
        
        if(!invite)
        {
            invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
            invite.message=[absDetails objectForKey:@"alert"];
            invite.userId=likeuserId;
            invite.postId= [userInfo objectForKey:@"post_id" ];
            invite.type=[NSNumber numberWithInt:1];
            [self saveContext];
        }*/
        
        
        
        MainInviteVC* maininvitevc=  (MainInviteVC*) [self.navigationControllerTeamInvites.viewControllers objectAtIndex:0];
        
       
        [self addFromPush:userInfo];
        
    }
    }
     mlike= [userInfo objectForKey:@"c_u_id" ] ;
    flagg=0;
    if(mlike)
    {
        if([mlike isEqualToString:[self.aDef objectForKey:LoggedUserID] ])
            flagg=1;
    }

   // flagg=0;
    
    if(!flagg)
    {
    if(mlike)
    {
       // NSString *likeuserId=[NSString stringWithFormat:@"%@",mlike];
        
       /* Invite *invite=(Invite*)  [self.centerViewController objectOfTypeInvite:INVITE forPost:[userInfo objectForKey:@"post_id" ] forUser:likeuserId forType:2 andManObjCon:self.managedObjectContext];
        
        if(!invite)
        {
            invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
            invite.message=[absDetails objectForKey:@"alert"];
            invite.userId=likeuserId;
            invite.postId=[userInfo objectForKey:@"post_id" ];
            invite.type=[NSNumber numberWithInt:2];
            [self saveContext];
        }*/
        
        
        MainInviteVC* maininvitevc=  (MainInviteVC*) [self.navigationControllerTeamInvites.viewControllers objectAtIndex:0];
        
        
        [self addFromPush:userInfo];
        
    }
    }
    
    
    
     NSDictionary *inviteDetails=[userInfo objectForKey:@"invite_details"];
    
    
    
    if(inviteDetails)
    {
        //isShowAlert=1;
        NSString *mesg=[inviteDetails objectForKey:@"message"];
         /*2014-05-05 16:11:13.461 Wall[1088:60b] Notification Received : 2 PushData={
         aps =     {
         alert = "Hi Som, You have been removed from AC Milan";
         };
         "invite_details" =     {
         message = "player_deleted";
         "player_name" = Som;
         status = 1;
         "team_id" = 37;
         "team_name" = "AC Milan";
         };
         }*/
        
        if(mesg && [mesg isEqualToString:@"player_deleted"])
        {
            NSString *status=[[NSString alloc] initWithFormat:@"%@", [inviteDetails objectForKey:@"status"]];
            
            if([status isEqualToString:@"1"])
            {
                
                NSString *teamId=[[NSString alloc] initWithFormat:@"%@", [inviteDetails objectForKey:@"team_id"] ];
                
                
            
                        
                        
                        
                        
                        NSDictionary *coachDic=nil;
                       /* NSString *invitesDic=nil;
                        NSNumber *isCreatedDic=nil;*/
                        int i=0;
                        BOOL fla=0;
                        
                        for(NSString *str in self.centerVC.dataArrayUpButtonsIds)
                         {
                         if( teamId && [str isEqualToString: teamId ])
                         {
                         
                         coachDic=[self.centerVC.dataArrayUpCoachDetails objectAtIndex:i];
                         
                         /*invitesDic=[self.centerVC.dataArrayUpInvites objectAtIndex:i];
                         
                         isCreatedDic=[self.centerVC.dataArrayUpIsCreated objectAtIndex:i];*/
                             /*NSMutableDictionary *mdic=[coachDic mutableCopy];
                             
                             [mdic setObject:[dic objectForKey:@"invites"] forKey:PLAYERINVITESTATUS];
                             
                             [arraycoachdetails replaceObjectAtIndex:i withObject:mdic];*/
                             if(![coachDic objectForKey:SECONDARYUSERSENDERID])
                             {
                             if([coachDic objectForKey:PLAYERINVITESTATUS])
                             {
                             fla=1;
                             }
                             
                             
                             
                             if(fla)
                             {
                                 NSMutableDictionary *mdic=[coachDic mutableCopy];
                                 
                                 [mdic removeObjectForKey:PLAYERINVITESTATUS];
                                 
                                 
                                 [self.centerVC.dataArrayUpCoachDetails replaceObjectAtIndex:i withObject:mdic];
                                 
                                 [self setUserDefaultValue:self.centerVC.dataArrayUpCoachDetails ForKey:ARRAYCOACHDETAILS];
                                 
                                 
                                 
                                 /*[appDelegate.centerVC.dataArrayUpInvites replaceObjectAtIndex:i withObject:[self.requestDic objectForKey:@"coach2_status"]];
                                  
                                  [appDelegate setUserDefaultValue:appDelegate.centerVC.dataArrayUpInvites ForKey:ARRAYSTATUS];
                                  
                                  [appDelegate.centerVC.dataArrayUpIsCreated replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:1]];
                                  
                                  
                                  [appDelegate setUserDefaultValue:appDelegate.centerVC.dataArrayUpCoachDetails ForKey:ARRAYISCREATES];*/
                                 
                                  [self updateAllEvents:teamId :0];
                                 
                             }
                             else
                             {
                                 [self.centerVC updateArrayByDeletingOneTeam:teamId];
                                 
                                  [self.centerViewController deleteAllEvents:teamId];
                             }

                             }
                             
                             
                             
                             
                             
                             
                             
                         break;
                         }
                         i++;
                         }
                         
                         
                
                  

                
                
            }
            
        }
        else
        {
      Invite *invite=(Invite*)  [self.centerViewController objectOfTypeInvite:INVITE forTeam1:[NSString stringWithFormat:@"%@", [inviteDetails objectForKey:@"team_id"] ] andManObjCon:self.managedObjectContext];
        
        int flag=1;
        
        
        
      for(NSString *str in self.centerVC.dataArrayUpButtonsIds)
      {
          if([str isEqualToString: [NSString stringWithFormat:@"%@", [inviteDetails objectForKey:@"team_id"] ] ])
          {
              flag=0;
          }
      }
        
        
        
        if(flag || ((!flag) && invite.type.integerValue==0))
        {
        if(!invite)
        {
            invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
        }
        
            invite.teamName=[inviteDetails objectForKey:@"team_name"];
            invite.teamId=[NSString stringWithFormat:@"%@", [inviteDetails objectForKey:@"team_id"] ];
            invite.creatorEmail=[inviteDetails objectForKey:@"c_email"];
            if([inviteDetails objectForKey:TEAMSPORTKEY])
                invite.teamSport=[inviteDetails objectForKey:TEAMSPORTKEY];
            invite.creatorName=[inviteDetails objectForKey:@"c_name"];
            invite.creatorPhno=[NSString stringWithFormat:@"%@", [inviteDetails objectForKey:@"c_phno"] ];
            invite.message=nil;//[NSString stringWithFormat:@"Team invite from %@",invite.teamName];
            invite.type=[NSNumber numberWithInt:0];
            
            if([inviteDetails objectForKey:@"p_u_id"])
            {
             NSString *playeruseId= [NSString stringWithFormat:@"%@",  [inviteDetails objectForKey:@"p_u_id"] ];
                
                
            if(![playeruseId isEqualToString:[self.aDef objectForKey:LoggedUserID]])
             invite.userId=[inviteDetails objectForKey:@"p_u_id"];
            }
            
            
            if([inviteDetails objectForKey:@"adddate"])
            {
                int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                
                NSDate *datetime=   [[self.dateFormatFullOriginalComment dateFromString:[inviteDetails objectForKey:@"adddate"]] dateByAddingTimeInterval:difftime]  ;
                
                
                invite.datetime=datetime;
            }
            
            if([inviteDetails objectForKey:@"c_img"])
            invite.senderProfileImage=[inviteDetails objectForKey:@"c_img"];
            else
             invite.senderProfileImage=@"";
            
            invite.inviteStatus=[[NSNumber alloc] initWithInt:0];
            
            [self saveContext];
        
        
        }
            
            
            
            
            
            
            
            
            
            
            
            
        }
        
        
    }
    ///////////////////////////////////////////////////////////////////////////////////////Admin Del
        
        NSDictionary *adDel=[userInfo objectForKey:@"ad_del"];
        
        
        
        if(adDel)
        {
            NSString *teamId=[[NSString alloc] initWithFormat:@"%@", [adDel objectForKey:@"t_id"] ];
            
            NSDictionary *coachDic=nil;
             NSString *invitesDic=nil;
             NSNumber *isCreatedDic=nil;
            int i=0;
            BOOL fla=0;
            
            for(NSString *str in self.centerVC.dataArrayUpButtonsIds)
            {
                if( teamId && [str isEqualToString: teamId ])
                {
                    
                    coachDic=[self.centerVC.dataArrayUpCoachDetails objectAtIndex:i];
                    
                    invitesDic=[self.centerVC.dataArrayUpInvites objectAtIndex:i];
                     
                     isCreatedDic=[self.centerVC.dataArrayUpIsCreated objectAtIndex:i];
                    /*NSMutableDictionary *mdic=[coachDic mutableCopy];
                     
                     [mdic setObject:[dic objectForKey:@"invites"] forKey:PLAYERINVITESTATUS];
                     
                     [arraycoachdetails replaceObjectAtIndex:i withObject:mdic];*/
                    if(![coachDic objectForKey:SECONDARYUSERSENDERID])
                    {
                        if([coachDic objectForKey:PLAYERINVITESTATUS])
                        {
                            fla=1;
                        }
                        
                        
                        
                        if(fla)
                        {
                            NSMutableDictionary *mdic=[coachDic mutableCopy];
                            
                            NSString *st=[mdic objectForKey:PLAYERINVITESTATUS];
                            
                            [mdic removeObjectForKey:PLAYERINVITESTATUS];
                            
                            if([mdic objectForKey:@"creator_id"])
                            [mdic removeObjectForKey:@"creator_id"];
                            
                            
                            [self.centerVC.dataArrayUpCoachDetails replaceObjectAtIndex:i withObject:mdic];
                            
                            [self setUserDefaultValue:self.centerVC.dataArrayUpCoachDetails ForKey:ARRAYCOACHDETAILS];
                            
                            
                            
                            [self.centerVC.dataArrayUpInvites replaceObjectAtIndex:i withObject:st];
                             
                             [self setUserDefaultValue:self.centerVC.dataArrayUpInvites ForKey:ARRAYSTATUS];
                             
                             [self.centerVC.dataArrayUpIsCreated replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:0]];
                             
                             
                             [self setUserDefaultValue:self.centerVC.dataArrayUpIsCreated ForKey:ARRAYISCREATES];
                            
                            
                            [self updateAllEvents:teamId :1];
                            
                        }
                        else
                        {
                            [self.centerVC updateArrayByDeletingOneTeam:teamId];
                            
                             [self.centerViewController deleteAllEvents:teamId];
                        }
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                    break;
                }
                i++;
            }

        
        
        }
        
        
        
    //////////////////////////////////////////////////////////////////////////////////////Admin
        
        NSDictionary *adminDetails=[userInfo objectForKey:@"ad_d"];
        
        
        
        if(adminDetails)
        {
            NSDictionary *inviteDetails=adminDetails;
            
            Invite *invite=(Invite*)  [self.centerViewController objectOfTypeAdminInvite:INVITE forTeam1:[NSString stringWithFormat:@"%@", [inviteDetails objectForKey:@"t_id"] ] andManObjCon:self.managedObjectContext];
            
            int flag=1;
            
            
            
           /* for(NSString *str in self.centerVC.dataArrayUpButtonsIds)
            {
                if([str isEqualToString: [NSString stringWithFormat:@"%@", [inviteDetails objectForKey:@"t_id"] ] ])
                {
                    flag=0;
                }
            }*/
            
            
            
            if(flag /*|| ((!flag) && invite.type.integerValue==0)*/)
            {
                if(!invite)
                {
                    invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
                }
                
                invite.teamName=[inviteDetails objectForKey:@"t_n"];
                invite.teamId=[NSString stringWithFormat:@"%@", [inviteDetails objectForKey:@"t_id"] ];
                invite.creatorEmail=[inviteDetails objectForKey:@"c_m"];
               // if([inviteDetails objectForKey:TEAMSPORTKEY])
                    invite.teamSport=[inviteDetails objectForKey:@"t_s"];
                invite.creatorName=[inviteDetails objectForKey:@"c_n"];
                invite.creatorPhno=[NSString stringWithFormat:@"%@", [inviteDetails objectForKey:@"c_ph"] ];
                invite.message=nil;//[NSString stringWithFormat:@"Team invite from %@",invite.teamName];
                invite.type=[NSNumber numberWithInt:14];
                
               
                
                
                if([inviteDetails objectForKey:@"dt"])
                {
                    int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                    
                    NSDate *datetime=   [[self.dateFormatFullOriginalComment dateFromString:[inviteDetails objectForKey:@"dt"]] dateByAddingTimeInterval:difftime]  ;
                    
                    
                    invite.datetime=datetime;
                }
                
                if([inviteDetails objectForKey:@"c_img"])
                    invite.senderProfileImage=[inviteDetails objectForKey:@"c_img"];
                else
                    invite.senderProfileImage=@"";
                
                invite.inviteStatus=[[NSNumber alloc] initWithInt:0];
                
                
                 invite.userId=[inviteDetails objectForKey:@"c_id"];
                
                [self saveContext];
                
                
            }
            
            
            
            
            
            
            
            
            
            
            
            
        }
    
    ///////////////////////////////InviteFriend
   
    NSDictionary *inviteFriendDetails=[userInfo objectForKey:@"wallview_details"];
    
    
    
    if(inviteFriendDetails)
    {
        /*NSArray *ids=[[inviteFriendDetails objectForKey:@"id"] componentsSeparatedByString:@","];
         NSArray *teamids=[[inviteFriendDetails objectForKey:@"t_id"] componentsSeparatedByString:@","];
         NSArray *teamnames=[[inviteFriendDetails objectForKey:@"t_n"] componentsSeparatedByString:@","];
        int count=ids.count;*/
        
           [self parseFriendInvites:[inviteFriendDetails objectForKey:@"id" ]];
        
       /* for(int j=0;j<count;j++)
        {
          Invite *invite=(Invite*)  [self.centerViewController objectOfTypeInvite:INVITE forTeam1:[NSString stringWithFormat:@"%@", [teamids objectAtIndex:j] ]  andManObjCon:self.managedObjectContext];
        
      
        
        int flag=1;
        
        
        
        for(NSString *str in self.centerVC.dataArrayUpButtonsIds)
        {
            if([str isEqualToString: [NSString stringWithFormat:@"%@", [inviteDetails objectForKey:@"t_id"] ] ])
            {
                flag=0;
            }
        }
        
        
        
        if(flag)
        {
            if(!invite)
            {
                invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
                invite.teamName=[teamnames objectAtIndex:j];
                invite.teamId=[teamids objectAtIndex:j];
                invite.creatorEmail=@"";//[dic objectForKey:@"creator_email"];
                invite.creatorName=@"";//[dic objectForKey:@"creator_name"];
                invite.creatorPhno=@"";//[dic objectForKey:@"creator_phno"];
                invite.message=[NSString stringWithFormat:@"Friend invite from %@",invite.teamName];
                
                NSString *body=nil;
                if(![[inviteFriendDetails objectForKey:@"sndr_n"] isEqualToString:@""])
                {
                    // body= [[NSString alloc] initWithFormat:@"%@ has invited you to join his team, %@, wall on SidelineHeroes.\n\n%@",sendername,invite.teamName,APPURL];
                    body= [NSString stringWithFormat:@"Hi,\n\nI'd like to invite you to join team, %@ on Sportsly (%@)\n\n%@",invite.teamName,APPURL,[inviteFriendDetails objectForKey:@"sndr_n"]];
                }
                else
                {
                    //body=  [[NSString alloc] initWithFormat:@"A Coach has invited you to join his team, %@, wall on SidelineHeroes.\n\n%@",invite.teamName,APPURL];
                    body=  [NSString stringWithFormat:@"Hi,\n\nI'd like to invite you to join team, %@ on Sportsly (%@)",invite.teamName,APPURL];
                }
                
              
                
                
                
                
                
                
                invite.contentMessage=body;
                body=nil;
                invite.type=[NSNumber numberWithInt:4];
                invite.postId=[ids objectAtIndex:j];
                invite.userId=[inviteFriendDetails objectForKey:@"sndr_id"];
                ////////
                int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                
                NSDate *datetime=   [[self.dateFormatFullOriginalComment dateFromString:[inviteFriendDetails objectForKey:@"dt"]] dateByAddingTimeInterval:difftime]  ;
                
                
                invite.datetime=datetime;
                
                if([inviteFriendDetails objectForKey:TEAMSPORTKEY])
                    invite.teamSport=[inviteFriendDetails objectForKey:TEAMSPORTKEY];
                invite.inviteStatus=[[NSNumber alloc] initWithInteger:0];
                invite.senderName=[inviteFriendDetails objectForKey:@"sndr_n"];
                invite.senderProfileImage=[inviteFriendDetails objectForKey:@"PImage"];
                ////////
                [self saveContext];
                 
                
             
                
                
            }
            
        }
        
    }*/
    }
    
    
    
    
    
    
    ///////////////////////////////
    
    NSDictionary *deleteTeamDetails=[userInfo objectForKey:@"team_delete_details"];
    
    
    
    if(deleteTeamDetails)
    {
        //isShowAlert=1;
        
        NSString *teamId=[NSString stringWithFormat:@"%@", [deleteTeamDetails objectForKey:@"team_id"] ];
        
        
        
        for(NSString *str in self.centerVC.dataArrayUpButtonsIds)
        {
            if([str isEqualToString: teamId ])
            {
               
                
                if([[NSString stringWithFormat:@"%@", [deleteTeamDetails objectForKey:@"status"]] isEqualToString:@"1"])
                {
                    [self.centerVC updateArrayByDeletingOneTeam:teamId];
                    
                   [self.centerViewController deleteAllEvents:teamId];
                    

                    
                }
                break;
            }
           
        }

        
        
     
        
    }
    
    //////////
     NSDictionary *updateDetails=[userInfo objectForKey:@"new_coach_update"];
    
    
    if(updateDetails)
    {
       // isShowAlert=1;
        
    int flag=0;
       int i=0;
    
    for(NSString *str in self.centerVC.dataArrayUpButtonsIds)
    {
        if([str isEqualToString: [NSString stringWithFormat:@"%@", [updateDetails objectForKey:@"team_id"] ] ])
        {
            flag=1;
            
            
            break;
        }
        i++;
    }
    
    
    if(flag)
    {
        Invite *invite=(Invite*)  [self.centerViewController objectOfTypeInvite:INVITE forTeam:[NSString stringWithFormat:@"%@", [updateDetails objectForKey:@"team_id"] ] forUpdate:3 forUpdateId:[updateDetails objectForKey:@"update_id"] andManObjCon:self.managedObjectContext];
        if(!invite)
        {
            invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
        }
       
      
        invite.teamName=[updateDetails objectForKey:@"team_name"];
        invite.teamId=[NSString stringWithFormat:@"%@", [updateDetails objectForKey:@"team_id"] ];
       // invite.message=[NSString stringWithFormat:@"New status update for %@ team",invite.teamName];
        invite.type=[NSNumber numberWithInt:3];
        
        invite.message=[updateDetails objectForKey:@"team_update"];
        invite.postId=[[NSString alloc] initWithFormat:@"%@", [updateDetails objectForKey:@"update_id"] ];
        invite.inviteStatus=[[NSNumber alloc] initWithInt:0];//[[updateDetails objectForKey:@"view_status"] integerValue];
        
        int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
        
        NSDate *datetime=   [[self.dateFormatFullOriginalComment dateFromString:[updateDetails objectForKey:@"update_adddate"]] dateByAddingTimeInterval:difftime]  ;
        invite.datetime=datetime;
        invite.senderProfileImage=[ [NSString alloc] initWithFormat:@"%@%@", TEAM_LOGO_URL,[updateDetails objectForKey:@"team_logo"] ];
        
        
        
        
        
        
        
        
        [self saveContext];
        
        
     
        [self.centerVC.dataArrayUpTexts replaceObjectAtIndex:i withObject: [updateDetails objectForKey:@"team_update"]];
        
     [self setUserDefaultValue:self.centerVC.dataArrayUpTexts ForKey:ARRAYTEXTS];
        
        if(i==self.centerVC.lastSelectedTeam)
        {
            if(![self.centerVC.updatetextvw isFirstResponder])
                self.centerVC.updatetextvw.text=[self.centerVC textForUpdateField:[self.centerVC.dataArrayUpTexts objectAtIndex:self.centerVC.lastSelectedTeam]];
        }
    
    }
    //////////
    }
    
    /*
     {
     aps =     {
     alert = "Davenport updated";
     };
     "team_update_details" =     {
     message = "team_updated";
     status = 1;
     "team_id" = 114;
     "team_name" = Davenport;
     };
     }
     
    
    
    
    
    */
    //////////////////////////
    
    NSDictionary *teamUpdateDetails=[userInfo objectForKey:@"team_update_details"];
    
    
    if(teamUpdateDetails)
    {
        //isShowAlert=1;
        
        int flag=0;
        int i=0;
        
        for(NSString *str in self.centerVC.dataArrayUpButtonsIds)
        {
            if([str isEqualToString: [NSString stringWithFormat:@"%@", [teamUpdateDetails objectForKey:@"t_id"] ] ])
            {
                flag=1;
                
                
                break;
            }
            i++;
        }
        
        
        if(flag)
        {
            /*Invite *invite=(Invite*)  [self.centerViewController objectOfTypeInvite:INVITE forTeam:[NSString stringWithFormat:@"%@", [updateDetails objectForKey:@"team_id"] ] forUpdate:3 andManObjCon:self.managedObjectContext];
            if(!invite)
            {
                invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
            }
            
            
            invite.teamName=[updateDetails objectForKey:@"team_name"];
            invite.teamId=[NSString stringWithFormat:@"%@", [updateDetails objectForKey:@"team_id"] ];
            invite.message=[NSString stringWithFormat:@"New status update for %@ team",invite.teamName];
            invite.type=[NSNumber numberWithInt:3];
            
            
            [self saveContext];*/
            
            
            
            [self.centerVC.dataArrayUpButtons replaceObjectAtIndex:i withObject: [teamUpdateDetails objectForKey:@"t_n"]];
            
            if([teamUpdateDetails objectForKey:@"t_s"])
            [self.centerVC.dataArrayUpTeamSports replaceObjectAtIndex:i withObject: [teamUpdateDetails objectForKey:@"t_s"]];
            
            [self setUserDefaultValue:self.centerVC.dataArrayUpButtons ForKey:ARRAYNAMES];
              [self setUserDefaultValue:self.centerVC.dataArrayUpTeamSports ForKey:ARRAYTEAMSPORTS];
            
           /* if(i==self.centerVC.lastSelectedTeam)
            {
                if(![self.centerVC.updatetextvw isFirstResponder])
                    self.centerVC.updatetextvw.text=[self.centerVC textForUpdateField:[self.centerVC.dataArrayUpTexts objectAtIndex:self.centerVC.lastSelectedTeam]];
            }*/
            [self.centerVC addTeamListing:[NSMutableArray array] :[NSMutableArray array]  :[NSMutableArray array]  :[NSMutableArray array]  :[NSMutableArray array]  :[NSMutableArray array]  :[NSMutableArray array] :[NSMutableArray array]];
            [self.centerVC showParticularTeam:self.centerVC.lastSelectedTeam];
        }
        //////////
    }
    
    
    
    
    
    
    
    
   //////////////////////////
    
    /////////////////////
    
     NSDictionary *teaminviteStatusDetailsForCoach=[userInfo objectForKey:@"details"];
    
    int selectEdTeamIndex=0;
    int flagforCoach=0;
    
    if(teaminviteStatusDetailsForCoach)
    {
        /////////////
        Invite *invite=(Invite*)  [self.centerViewController objectOfTypeTeamInvite:INVITE forTeam1:[NSString stringWithFormat:@"%@", [teaminviteStatusDetailsForCoach objectForKey:@"t_id"] ] andManObjCon:self.managedObjectContext];
        
        int flag=1;
        
        NSString *teamId= [NSString stringWithFormat:@"%@", [teaminviteStatusDetailsForCoach objectForKey:@"t_id"] ];
        
        for(NSString *str in self.centerVC.dataArrayUpButtonsIds)
        {
            if([str isEqualToString: teamId ])
            {
                flag=0;
            }
        }
        
        
        
       /* if(flag)
        {*/
        if(invite && flag)
        {
          
            
            NSDictionary *dic=teaminviteStatusDetailsForCoach;
            NSString *tId= [ [NSString alloc] initWithFormat:@"%@", [dic objectForKey:@"t_id"]];
            Invite *invite=(Invite*)  [self.centerViewController objectOfTypeInviteTeamResponseForUser:INVITE forId:tId andManObjCon:self.managedObjectContext];
            
            if(!invite)
            {
                invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
                invite.teamName=[dic objectForKey:@"t_n"];
                invite.teamId=tId;
                
                
                invite.playerId=[dic objectForKey:@"p_id"];
                
                
                invite.playerName=[dic objectForKey:@"a_n"];
                invite.profImg=[[NSString alloc] initWithFormat:@"%@%@",IMAGELINKTHUMB,[dic objectForKey:@"a_img"]];
                invite.type=[NSNumber numberWithInt:10];
                ////////
                int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                
                NSDate *datetime=   [[self.dateFormatFullOriginalComment dateFromString:[dic objectForKey:@"a_dt"]] dateByAddingTimeInterval:difftime]  ;
                
                
                invite.datetime=datetime;
                
                invite.viewStatus=[[NSNumber alloc] initWithBool:0];
                
                
                if([[dic objectForKey:@"stat"] isEqualToString:@"p"])
                {
                invite.message=@"primary";
                }
                else
                {
                  invite.message=@"player";
                }
                
                
                if([[dic objectForKey:@"inv"] isEqualToString:@"Accept"])
                    invite.inviteStatus=[[NSNumber alloc] initWithInt:1 ];
                else if([[dic objectForKey:@"inv"] isEqualToString:@"Decline"])
                    invite.inviteStatus=[[NSNumber alloc] initWithInt:2 ];
                else if([[dic objectForKey:@"inv"] isEqualToString:@"Maybe"])
                    invite.inviteStatus=[[NSNumber alloc] initWithInt:3 ];
                
                
                
            }

            
            
            
            
            
            
            //////////////////////////////////////////
             /* MainInviteVC* maininvitevc=  (MainInviteVC*) [self.navigationControllerTeamInvites.viewControllers objectAtIndex:0];
            [maininvitevc view];
            
            PushByInviteTeamVC *pVC=[maininvitevc teamInvitesVC];
            
            [pVC view];
            
            [pVC teamInviteStatusUpdateFromPush:invite :[teaminviteStatusDetailsForCoach objectForKey:@"inv"]];*/
            ///////////////////////////////////////////
            
        }
        else
        {
        
        for (int i=0;i<[self.JSONDATAarr count]; i++) {
            
            
            if ([[[self.JSONDATAarr objectAtIndex:i]valueForKey:@"team_id"] integerValue]==[[teaminviteStatusDetailsForCoach valueForKey:@"t_id"] integerValue]) {
                
                selectEdTeamIndex=i;
                flagforCoach=1;
                break;
                
                }
            }
        
        if (flagforCoach) {
            //isShowAlert=1;
            //[[[self.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"player_details"] count]
                
        for (int i=0; i<[(NSArray *)[[self.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"player_details"] count]; i++) {
            
            int pid= [[[[[self.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"player_details"] objectAtIndex:i] objectForKey: @"player_id"] integerValue] ;
            
            if([[teaminviteStatusDetailsForCoach valueForKey:@"p_id"] integerValue]==pid)
            {
                
                [[[[self.JSONDATAarr objectAtIndex:selectEdTeamIndex] objectForKey:@"player_details"] objectAtIndex:i ] setObject: [teaminviteStatusDetailsForCoach valueForKey:@"inv"]forKey:@"invites"];
                
                break;
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:TEAMINVITESTATUSACCEPTEDFORCOACH object:nil];
        }
            
        //////////////////////Save
            NSDictionary *dic=teaminviteStatusDetailsForCoach;
            Invite *invite=(Invite*)  [self.centerViewController objectOfTypeInviteTeamResponse:INVITE forTeam:[dic objectForKey:@"p_id"] andManObjCon:self.managedObjectContext];
            
            if(!invite)
            {
                invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
                invite.teamName=[dic objectForKey:@"t_n"];
                invite.teamId=[NSString stringWithFormat:@"%@", [dic objectForKey:@"t_id"] ];
                
                invite.playerId=[dic objectForKey:@"p_id"];
                invite.playerName=[dic objectForKey:@"a_n"];
                invite.profImg=[[NSString alloc] initWithFormat:@"%@%@",IMAGELINKTHUMB,[dic objectForKey:@"a_img"]];
                invite.type=[NSNumber numberWithInt:7];
                ////////
                int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                
                NSDate *datetime=   [[self.dateFormatFullOriginalComment dateFromString:[dic objectForKey:@"a_dt"]] dateByAddingTimeInterval:difftime]  ;
                
                
                invite.datetime=datetime;
                
                invite.viewStatus=[[NSNumber alloc] initWithBool:0];
                
                if([[dic objectForKey:@"inv"] isEqualToString:@"Accept"])
                    invite.inviteStatus=[[NSNumber alloc] initWithInt:1 ];
                else if([[dic objectForKey:@"inv"] isEqualToString:@"Decline"])
                    invite.inviteStatus=[[NSNumber alloc] initWithInt:2 ];
                else if([[dic objectForKey:@"inv"] isEqualToString:@"Maybe"])
                    invite.inviteStatus=[[NSNumber alloc] initWithInt:3 ];
                
                
                
            }
            
            
            
            
            
            
            
            
            
            
            
      ///////////////////////////
            
    }

    
    }
    
       // }
        
        
        
        
        
        
        
        
        
        
        
        
        
    
    }
   /////////////////////
        NSDictionary *adminStatusCoach=[userInfo objectForKey:@"a_ad_det"];
        
        if(adminStatusCoach)
        {
             NSDictionary *dic= adminStatusCoach;
            
            Invite *invite=(Invite*)  [self.centerViewController objectOfTypeInviteAdminResponse:INVITE forTeam:[dic objectForKey:@"t_id"] forAdmin:[dic objectForKey:@"p_id"]  andManObjCon:self.managedObjectContext];
            
           
            
            
            if(!invite)
            {
                invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
                invite.teamName=[dic objectForKey:@"t_n"];
                invite.teamId=[NSString stringWithFormat:@"%@", [dic objectForKey:@"t_id"] ];
                
                invite.playerId=[dic objectForKey:@"p_id"];
                
                
                NSString *acceptorName=@"";
                NSArray *aarr= [[absDetails objectForKey:@"alert"] componentsSeparatedByString:@" has "];
                
                if(aarr.count>1)
                    acceptorName=[aarr objectAtIndex:0];
                
                invite.playerName=acceptorName;//[dic objectForKey:@"a_n"];
                invite.profImg=[[NSString alloc] initWithFormat:@"%@%@",IMAGELINKTHUMB,[dic objectForKey:@"a_img"]];
                invite.type=[NSNumber numberWithInt:15];
                ////////
                int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                
                NSDate *datetime=   [[self.dateFormatFullOriginalComment dateFromString:[dic objectForKey:@"a_dt"]] dateByAddingTimeInterval:difftime]  ;
                
                
                invite.datetime=datetime;
                
                invite.viewStatus=[[NSNumber alloc] initWithBool:0];
                
                if([[dic objectForKey:@"inv"] isEqualToString:@"Accept"])
                    invite.inviteStatus=[[NSNumber alloc] initWithInt:1 ];
                else if([[dic objectForKey:@"inv"] isEqualToString:@"Decline"])
                    invite.inviteStatus=[[NSNumber alloc] initWithInt:2 ];
                else if([[dic objectForKey:@"inv"] isEqualToString:@"Maybe"])
                    invite.inviteStatus=[[NSNumber alloc] initWithInt:3 ];
                
                
                
            }
            
            
            
            
            
            
            
            
            
            
            
            ///////////////////////////
            
        }

        
        
        
        
    
    /////////////////////////////////////////////////
    
    
    
     NSDictionary *eventAcceptdetails=[userInfo objectForKey:@"d_e_status"];
    
    
    
    if(eventAcceptdetails)
    {
        
        /*if([[NSString stringWithFormat:@"%@", [eventAcceptdetails objectForKey:@"status"]] isEqualToString:@"1"])
        {*/
            
        NSString *eId=[[NSString alloc] initWithFormat:@"%@",[eventAcceptdetails objectForKey:@"e_id"]];
        
            Event *dataEvent=[self.centerViewController objectOfType2Event:eId];
        
        ///////
        
        NSString *teamName=nil;
       NSString *acceptorName=nil;
        
        
        
       NSArray *aarr= [[absDetails objectForKey:@"alert"] componentsSeparatedByString:@" has "];
        
        if(aarr.count>1)
         acceptorName=[aarr objectAtIndex:0];
        
        aarr= [[absDetails objectForKey:@"alert"] componentsSeparatedByString:@" for "];
        
        if(aarr.count>1)
            teamName=[aarr objectAtIndex:1];
        
        
        if(!dataEvent || dataEvent.isCreated.boolValue==0)//For Player or Primary
        {
            /*Invite *dataEvent=nil;
            Invite *anObj = nil;
            NSFetchRequest * request = [[NSFetchRequest alloc] init];
            [request setEntity:[NSEntityDescription entityForName:EVENTUNREAD inManagedObjectContext:self.managedObjectContext]];
            
            [request setPredicate:[NSPredicate predicateWithFormat:@"(eventId==%@) AND (userId=%@) AND (type==%i)",eId,[self.aDef objectForKey:LoggedUserID],5]];
            
            NSArray* ar =nil;
            ar= [self.managedObjectContext executeFetchRequest:request error:nil];
            if ([ar count]>=1)
            {
                anObj= (Invite *) [ar objectAtIndex:0];
            }
            
            
            dataEvent=anObj;
            
           
            
            
           if(dataEvent)
            {
           
              
                    EventCalendarViewController *evc=(EventCalendarViewController*)[self.navigationControllerCalendar.viewControllers objectAtIndex:0];
                
                
                
                    [evc processAcceptEvent:dataEvent];
                    
                
            }*/
            NSDictionary *dic=eventAcceptdetails;
            
            NSString *tId= [ [NSString alloc] initWithFormat:@"%@", [dic objectForKey:@"t_id"]];
            Invite *invite=(Invite*)  [self.centerViewController objectOfTypeInviteTeamEventResponseForUser:INVITE forId:tId forEventId:[eventAcceptdetails objectForKey:@"e_id"] andManObjCon:self.managedObjectContext];
            
            if(!invite)
            {
                invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
                
            }
                invite.teamName=teamName;
                 invite.playerName=acceptorName;
                
                
                invite.teamId=tId;
                
                
                invite.playerId=[dic objectForKey:@"p_id"];
                
                
               
                invite.profImg=[[NSString alloc] initWithFormat:@"%@%@",IMAGELINKTHUMB,[dic objectForKey:@"a_img"]];
                invite.type=[NSNumber numberWithInt:11];
                ////////
                int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                
                NSDate *datetime=   [[self.dateFormatFullOriginalComment dateFromString:[dic objectForKey:@"e_dt"]] dateByAddingTimeInterval:difftime]  ;
                
                
                invite.datetime=datetime;
                
                invite.viewStatus=[[NSNumber alloc] initWithBool:0];
                
                
                if([[dic objectForKey:@"sta"] isEqualToString:@"p"])
                {
                    invite.message=@"primary";
                }
                else
                {
                    invite.message=@"player";
                }
                
                
                if([[dic objectForKey:@"inv"] isEqualToString:@"Accept"])
                    invite.inviteStatus=[[NSNumber alloc] initWithInt:0 ];
                else if([[dic objectForKey:@"inv"] isEqualToString:@"Decline"])
                    invite.inviteStatus=[[NSNumber alloc] initWithInt:2 ];
                else if([[dic objectForKey:@"inv"] isEqualToString:@"Maybe"])
                    invite.inviteStatus=[[NSNumber alloc] initWithInt:3 ];
                
                invite.eventId=[eventAcceptdetails objectForKey:@"e_id"];
                invite.eventName=[eventAcceptdetails objectForKey:@"e_n"];
            

            
        }
        else//For Coach
        {
            if(dataEvent.isCreated.boolValue==1)
            {
            NSDictionary *dic=eventAcceptdetails;
            
            NSString *tId= [ [NSString alloc] initWithFormat:@"%@", [dic objectForKey:@"t_id"]];
            
           
            
            Invite *invite=(Invite*)  [self.centerViewController objectOfTypeInviteTeamEventResponse:INVITE forTeam:[dic objectForKey:@"p_id"] forEventId:[eventAcceptdetails objectForKey:@"e_id"] andManObjCon:self.managedObjectContext];
            
            if(!invite)
            {
                invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
            }
                
                invite.teamName=teamName;
                invite.playerName=acceptorName;
                
                invite.teamId=tId;
                
                invite.playerId=[dic objectForKey:@"p_id"];
               
                invite.profImg=[[NSString alloc] initWithFormat:@"%@%@",IMAGELINKTHUMB,[dic objectForKey:@"a_img"]];
                invite.type=[NSNumber numberWithInt:12];
                ////////
                int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                
                NSDate *datetime=   [[self.dateFormatFullOriginalComment dateFromString:[dic objectForKey:@"e_dt"]] dateByAddingTimeInterval:difftime]  ;
                
                
                invite.datetime=datetime;
                
                invite.viewStatus=[[NSNumber alloc] initWithBool:0];
                
                if([[dic objectForKey:@"inv"] isEqualToString:@"Accept"])
                    invite.inviteStatus=[[NSNumber alloc] initWithInt:0 ];
                else if([[dic objectForKey:@"inv"] isEqualToString:@"Decline"])
                    invite.inviteStatus=[[NSNumber alloc] initWithInt:2 ];
                else if([[dic objectForKey:@"inv"] isEqualToString:@"Maybe"])
                    invite.inviteStatus=[[NSNumber alloc] initWithInt:3 ];
                
                
                invite.eventId=[eventAcceptdetails objectForKey:@"e_id"];
                invite.eventName=[eventAcceptdetails objectForKey:@"e_n"];
            
            
            
            
            
            }
            
            
            
            
            
            
            
            
            
        }
            
            
            
        /*}
        else
        {
            [self showNetworkError:@"Error in Push Message to receive event."];
        }*/
        [self saveContext];
        
    }
    
    
    //}
        
// Chat Message Push
    
    
    
    //NSDictionary *pushChat=[userInfo objectForKey:@"d_e_status"];
        //NSDictionary *pushChat=[userInfo objectForKey:@"d_e_status"];
        
        if([userInfo valueForKey:@"p_t"])
        {
            if ([[userInfo valueForKey:@"p_t"] isEqualToString:@"c_p"])
            {
                
                NSMutableDictionary *dict=[NSMutableDictionary dictionary];
                [dict setObject:[userInfo valueForKey:@"snd"] forKey:@"sender"];
                //[dict setObject:[userInfo valueForKey:@"rcv"] forKey:@"receiver"];
                [dict setObject:[userInfo valueForKey:@"img"] forKey:@"ProfileImage"];
                [dict setObject:[userInfo valueForKey:@"s_nm"] forKey:@"sender_name"];
                [dict setObject:[userInfo valueForKey:@"txt"] forKey:@"message"];
                [dict setObject:[userInfo valueForKey:@"dt"] forKey:@"adddate"];
                [dict setObject:@"" forKey:@"group_id"];
                
                
                
                if (self.allPendingMessage) {
                    
                    NSPredicate *predicated=[NSPredicate predicateWithFormat:@"sender='%@'",[userInfo valueForKey:@"snd"]];
                    NSArray *arr=[self.allPendingMessage filteredArrayUsingPredicate:predicated];
                    if (arr.count==0) {
                        
                        [self.allPendingMessage addObject:dict];
                        
                    }else{
                        [self.allPendingMessage removeObjectsInArray:arr];
                        [self.allPendingMessage addObject:dict];
                    }

                    
                }else{
                    
                    self.allPendingMessage=[[NSMutableArray alloc] init];
                    [self.allPendingMessage addObject:dict];
                }
                
                [(ChatMessageViewController*)[self.navigationControllerChatMessage.viewControllers objectAtIndex:0 ] refreshChatMessageList];
                
            }else{
                
                [(ChatMessageViewController*)[self.navigationControllerChatMessage.viewControllers objectAtIndex:0 ] collectDataForGroupChat:[userInfo valueForKey:@"g_id"]];
            }
            
        }
        
        
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //////////////////////////////////////////////////
    
    
    
    
    if(isShowAlert)
    {
    /*if([absDetails objectForKey:@"alert"])
    {
        UIAlertView *al=[[UIAlertView alloc] initWithTitle:@"New Notification" message:[absDetails objectForKey:@"alert"] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil] ;
        [al show];
    }*/
    
    
    }
    
    }
}






-(void)addFromPush:(NSDictionary*)dic
{
    
    NSLog(@"UserInfoAddFromPush=%@",dic);
    
    
    
    
    Invite   *data = nil;
    data= (Invite *)[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
    
    
    data.data1=[dic objectForKey:@"p_id"];
    data.last_id=[[NSString alloc] initWithFormat:@"%@", [dic objectForKey:@"l_id"] ];
    
    if([dic objectForKey:@"L_u_id"])
        data.isComment=[[NSNumber alloc] initWithBool:1];
    else
        data.isComment=[[NSNumber alloc] initWithBool:0];

    if([dic objectForKey:@"date"])
    {
        int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
        
        NSDate *datetime=   [[self.dateFormatFullOriginalComment dateFromString:[dic objectForKey:@"date"]] dateByAddingTimeInterval:difftime]  ;
        
        
        
        data.datetime=datetime;
        
    }
    else
    {
        data.datetime=[[NSDate alloc] init];
    }
    
    if(![[dic objectForKey:@"p_img"] isEqualToString:@""])
    {
        NSString *profimg=[[NSString alloc] initWithFormat:@"%@%@",IMAGELINKTHUMB,[dic objectForKey:@"p_img"]];
        
        
        data.profImg=profimg;
        profimg=nil;
        
    }
    else
    {
        data.profImg=@"";
    }
    data.message=[[dic objectForKey:@"aps"] objectForKey:@"alert"];
    data.inviteStatus=[[NSNumber alloc] initWithInt:0];
    
    data.type=[[NSNumber alloc] initWithInt:6];

    data.teamName=[dic objectForKey:@"t_n"];
    
    
    
    /*appDelegate.allHistoryLikesCounts++;
    [appDelegate setUserDefaultValue:[NSNumber numberWithLongLong:appDelegate.allHistoryLikesCounts] ForKey:ALLHISTORYLIKECOUNTS ];
    
    [self.dataArrayOrg insertObject:data atIndex:0];
    
    self.start=self.dataArrayOrg.count;
    
    [self reloadTableView];*/
    
    [self saveContext];
}



-(void)parseFriendInvites:(NSString*)data
{
    if(data)
    {
        
        
        SBJsonWriter *writer = [[SBJsonWriter alloc] init];
        
        NSDictionary *command=  [NSDictionary dictionaryWithObjectsAndKeys:data,@"id", nil];
        NSString *jsonCommand = [writer stringWithObject:command];
        
        NSLog(@"RequestParamJSON=%@=====%@",jsonCommand,command);
        
        SingleRequest *sinReq=[[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:COMINGFRIENDINVITESLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
        self.sinReq2=sinReq;
        self.sinReq2.notificationName=COMINGFRIENDINVITES;
        [self.storeCreatedRequests addObject:self.sinReq2];
        [sinReq startRequest];
        
        
    }
    
}



-(void)comingFriendInvitesListUpdated:(id)sender
{
    SingleRequest *sReq=(SingleRequest*)[sender object];
    if([sReq.notificationName isEqualToString:COMINGFRIENDINVITES])
    {
        if(sReq.responseData)
        {
            
            if (sReq.responseString)
            {
                NSLog(@"comingFriendInvitesListUpdated=%@",sReq.responseString);
                
                SBJsonParser *parser=[[SBJsonParser alloc] init];
                
                id res = [parser objectWithString:sReq.responseString];
                
            
                
                if ([res isKindOfClass:[NSDictionary class]])
                {
                    NSDictionary* aDict = (NSDictionary*) res;
                    
                    
                    NSArray *ar=[aDict objectForKey:@"admin_details"];
                     
                        for(NSDictionary *dic in ar)
                        {
                            Invite *invite=(Invite*)  [self.centerViewController objectOfTypeInvite:INVITE forTeam1:[NSString stringWithFormat:@"%@", [dic objectForKey:@"team_id"] ] /*forUpdate:4*/ andManObjCon:self.managedObjectContext];
                            
                            
                            
                            int flag=1;
                            
                            
                            
                            for(NSString *str in self.centerVC.dataArrayUpButtonsIds)
                            {
                                if([str isEqualToString: [NSString stringWithFormat:@"%@", [dic objectForKey:@"team_id"] ] ])
                                {
                                    flag=0;
                                }
                            }
                            
                            
                            
                            if(flag)
                            {
                            
                                
                                if(!invite)
                                {
                            invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
                             invite.teamName=[dic objectForKey:@"team_name"];
                             invite.teamId=[dic objectForKey:@"team_id"];
                             invite.creatorEmail=@"";//[dic objectForKey:@"creator_email"];
                             invite.creatorName=@"";//[dic objectForKey:@"creator_name"];
                             invite.creatorPhno=@"";//[dic objectForKey:@"creator_phno"];
                             invite.message=[NSString stringWithFormat:@"Friend invite from %@",invite.teamName];
                             
                             NSString *body=nil;
                             if(![[dic objectForKey:@"creator_name"] isEqualToString:@""])
                             {
                             // body= [[NSString alloc] initWithFormat:@"%@ has invited you to join his team, %@, wall on SidelineHeroes.\n\n%@",sendername,invite.teamName,APPURL];
                             body= [NSString stringWithFormat:@"Hi,\n\nI'd like to invite you to join team, %@ on Sportsly (%@)\n\n%@",invite.teamName,APPURL,[dic objectForKey:@"creator_name"]];
                             }
                             else
                             {
                             //body=  [[NSString alloc] initWithFormat:@"A Coach has invited you to join his team, %@, wall on SidelineHeroes.\n\n%@",invite.teamName,APPURL];
                             body=  [NSString stringWithFormat:@"Hi,\n\nI'd like to invite you to join team, %@ on Sportsly (%@)",invite.teamName,APPURL];
                             }
                             
                             
                             
                             
                             
                             
                             
                             
                             invite.contentMessage=body;
                             body=nil;
                             invite.type=[NSNumber numberWithInt:4];
                             invite.postId=[dic objectForKey:@"id"];
                                    
                                    
                                    
                            
                             ////////
                             int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                             
                             NSDate *datetime=   [[self.dateFormatFullOriginalComment dateFromString:[dic objectForKey:@"datetime"]] dateByAddingTimeInterval:difftime]  ;
                             
                             
                             invite.datetime=datetime;
                             
                             if([dic objectForKey:TEAMSPORTKEY])
                             invite.teamSport=[dic objectForKey:TEAMSPORTKEY];
                             invite.inviteStatus=[[NSNumber alloc] initWithInteger:0];
                                    
                                    if([[dic objectForKey:@"admin_type2"] isEqualToString:@"Y"])
                                    {
                              invite.userId=[dic objectForKey:@"coach_id"];
                             invite.senderName=[dic objectForKey:@"creator_name"];
                                    }
                                    else
                                    {
                                        invite.userId=[dic objectForKey:@"user_id"];
                                        invite.senderName=[NSString stringWithFormat:@"%@ %@", [dic objectForKey:@"FirstName"],[dic objectForKey:@"LastName"]];

                                    }
                             invite.senderProfileImage=[dic objectForKey:@"ProfileImage"];
                             ////////
                           
                             
                            }
                            
                        }
                        }
                    
                      [self saveContext];
                  
                    
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






-(NSManagedObject*)isExistObjectOfTypeEventUnread:(NSString*)eId
{
   
    
    
Invite *dataEvent=nil;
Invite *anObj = nil;
NSFetchRequest * request = [[NSFetchRequest alloc] init];
[request setEntity:[NSEntityDescription entityForName:EVENTUNREAD inManagedObjectContext:self.managedObjectContext]];

[request setPredicate:[NSPredicate predicateWithFormat:@"(eventId==%@) AND (userId=%@) AND (type==%i)",eId,[self.aDef objectForKey:LoggedUserID],5]];

NSArray* ar =nil;
ar= [self.managedObjectContext executeFetchRequest:request error:nil];
if ([ar count]>=1)
{
    anObj= (Invite *) [ar objectAtIndex:0];
}


dataEvent=anObj;
    
    
    
    return dataEvent;
}



-(void)savePushDataForLike:(NSDictionary*)userInfo :(NSString*)alertStr
{
    id mlike= [userInfo objectForKey:@"Like_user_id" ] ;
    int flagg=0;
    if(mlike)
    {
        if([mlike isEqualToString:[self.aDef objectForKey:LoggedUserID] ])
            flagg=1;
    }
    //  flagg=0;
    if(!flagg)
    {
        if(mlike)
        {
            NSString *likeuserId=[NSString stringWithFormat:@"%@",mlike];
            
            Invite *invite=(Invite*)  [self.centerViewController objectOfTypeInvite:INVITE forPost:[userInfo objectForKey:@"post_id" ] forUser:likeuserId forType:1 andManObjCon:self.managedObjectContext];
            
            if(!invite)
            {
                invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
                invite.message=alertStr;
                invite.userId=likeuserId;
                invite.postId= [userInfo objectForKey:@"post_id" ];
                invite.type=[NSNumber numberWithInt:1];
                [self saveContext];
            }
            
        }
    }

}


-(void)savePushDataForComment:(NSDictionary*)userInfo :(NSString*)alertStr
{
 id mlike= [userInfo objectForKey:@"cmnt_user_id" ] ;
  int flagg=0;
    if(mlike)
    {
        if([mlike isEqualToString:[self.aDef objectForKey:LoggedUserID] ])
            flagg=1;
    }
    
    // flagg=0;
    
    if(!flagg)
    {
        if(mlike)
        {
            NSString *likeuserId=[NSString stringWithFormat:@"%@",mlike];
            
            Invite *invite=(Invite*)  [self.centerViewController objectOfTypeInvite:INVITE forPost:[userInfo objectForKey:@"post_id" ] forUser:likeuserId forType:2 andManObjCon:self.managedObjectContext];
            
            if(!invite)
            {
                invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
                invite.message=alertStr;
                invite.userId=likeuserId;
                invite.postId=[userInfo objectForKey:@"post_id" ];
                invite.type=[NSNumber numberWithInt:2];
                [self saveContext];
            }
            
        }
    }
    

}


-(UIColor*)colorWithHexString:(NSString*)hex
{
    unsigned int r, g, b;
    @autoreleasepool {
        
        
        NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
        
        // String should be 6 or 8 characters
        if ([cString length] < 6) return [UIColor grayColor];
        
        // strip 0X if it appears
        if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
        
        if ([cString length] != 6) return  [UIColor grayColor];
        
        // Separate into r, g, b substrings
        NSRange range;
        range.location = 0;
        range.length = 2;
        NSString *rString = [cString substringWithRange:range];
        
        range.location = 2;
        NSString *gString = [cString substringWithRange:range];
        
        range.location = 4;
        NSString *bString = [cString substringWithRange:range];
        
        // Scan values
        
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
    }
    
    NSLog(@"R=%u G=%u B=%u",r,g,b);
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}






-(void)registerForGetttingDTForPushNotificationServiceStatus:(BOOL)status
{
    self.currentSendDeviceTokenStatus=status;
    if ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] floatValue]==8.0) {
        if ([[UIApplication sharedApplication]respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
        {
            // iOS 8 Notifications
            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
            
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        }
    }
    else {
    
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationType)(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }
}




-(void)addRootVC:(UIViewController*)vc
{
    self.window.rootViewController = vc;
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

-(void)setUserDefaultValue:(id)value ForKey:(NSString *)key
{
    [self.aDef setObject:value forKey:key];
    [self.aDef synchronize];
}

-(void)removeUserDefaultValueForKey:(NSString *)key
{
    [self.aDef removeObjectForKey:key];
    [self.aDef synchronize];
}


-(void)showNetworkError:(NSString*) errorMsg
{
    /*UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:errorMsg delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
    [alert show];*/
    
    
    NSLog(@"AppDelegateshowNetworkError");
}

-(BOOL)sendMultipleRequestFor:(NSMutableArray *)aRequestPages from:(id)aSource
{
    return [dataModel sendRequestFor:aRequestPages from:aSource];
}

-(BOOL)sendRequestFor:(NSString *)aRequestPage from:(id)aSource parameter:(NSDictionary*)dic
{
    return [dataModel sendSingleRequestFor:aRequestPage from:aSource parameter:dic];
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    if([[self.aDef objectForKey:LoggedUserDeviceTokenStatus] isEqualToString:@"N"] && [self.aDef objectForKey:ISLOGIN])
    {
        NSString *deviceToken=[self.aDef objectForKey:DEVICE_TOKEN];
        NSString *userId=[self.aDef objectForKey:LoggedUserID];
        
        if(deviceToken)
        {
            [self sendDeviceToServerDeviceToken:deviceToken UserId:userId CheckStatus:0];
        }
        else
        {
            [self registerForGetttingDTForPushNotificationServiceStatus:1];
        }
        
    }
    
    
    if([self.aDef objectForKey:ISLOGIN] && [self.aDef objectForKey:LoggedUserID])
    {
        
        
        
        EventCalendarViewController *evc=(EventCalendarViewController*)[self.navigationControllerCalendar.viewControllers objectAtIndex:0];
        
        if(evc)
        {
            
            NSArray *checkarr=[self.aDef objectForKey:FAILEDEVENTALREADYACCEPTEDLIST];
            
            
            for (NSString *s in checkarr )
            {
                
            
            
            NSString *eventId=s;
            
            Invite *dataEvent=(Invite*)[self isExistObjectOfTypeEventUnread:eventId];
            if(dataEvent)
            [evc processAcceptEvent:dataEvent];
            
            }
            
            
        }
        
    }
    
    
    
    
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    //// facebook sdk change 8th july
     //[FBAppCall handleDidBecomeActive];
    
    [FBSDKAppEvents activateApp];
    
    //////
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
     //[FBSession.activeSession close];
   /* NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:INVITE inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    // NSPredicate *pre=[NSPredicate predicateWithFormat:@"type==%i OR type==%i OR type==%i OR type==%i OR type==%i OR type==%i OR type==%i OR type==%i OR type==%i OR type==%i OR type==%i OR type==%i",0,3,5,6,7,8,9,10,11,12,14,15];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"datetime" ascending:NO ];//@"inviteStatus"
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    //    [fetchRequest setPredicate:pre];
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil] ;
    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    
    NSLog(@"aFetchedResultsControllerCount=%i",aFetchedResultsController.fetchedObjects.count);

    */
    
    
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Social" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Social.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return __persistentStoreCoordinator;
}

/////////////////////Facebook


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    // attempt to extract a token from the url
    
  //// facebook sdk change 8th july
    
   // return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
    return [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    ///////
}


//- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
//{
//    // If the session was opened successfully
//    if (!error && state == FBSessionStateOpen){
//        NSLog(@"Session opened");
//        // Show the user the logged-in UI
//        [self userLoggedIn];
//        return;
//    }
//    if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed){
//        // If the session is closed
//        NSLog(@"Session closed");
//        // Show the user the logged-out UI
//        [self userLoggedOut];
//    }
//    
//    // Handle errors
//    if (error){
//        NSLog(@"Error");
//        NSString *alertText;
//        NSString *alertTitle;
//        // If the error requires people using an app to make an action outside of the app in order to recover
//        if ([FBErrorUtility shouldNotifyUserForError:error] == YES){
//            alertTitle = @"Something went wrong";
//            alertText = [FBErrorUtility userMessageForError:error];
//            [self showMessage:alertText withTitle:alertTitle];
//        } else {
//            
//            // If the user cancelled login, do nothing
//            if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
//                NSLog(@"User cancelled login");
//                
//                // Handle session closures that happen outside of the app
//            } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession){
//                alertTitle = @"Session Error";
//                alertText = @"Your current session is no longer valid. Please log in again.";
//                [self showMessage:alertText withTitle:alertTitle];
//                
//                // Here we will handle all other errors with a generic error message.
//                // We recommend you check our Handling Errors guide for more information
//                // https://developers.facebook.com/docs/ios/errors/
//            } else {
//                //Get more error information from the error
//                NSDictionary *errorInformation = [[[error.userInfo objectForKey:@"com.facebook.sdk:ParsedJSONResponseKey"] objectForKey:@"body"] objectForKey:@"error"];
//                
//                // Show the user an error message
//                alertTitle = @"Something went wrong";
//                alertText = [NSString stringWithFormat:@"Please retry. \n\n If the problem persists contact us and mention this error code: %@", [errorInformation objectForKey:@"message"]];
//                [self showMessage:alertText withTitle:alertTitle];
//            }
//        }
//        // Clear this token
//        [FBSession.activeSession closeAndClearTokenInformation];
//        // Show the user the logged-out UI
//        [self userLoggedOut];
//    }
//}



/////// 22/9/14  ///////

/*- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState)state error:(NSError *)error
{
    // FBSample logic
    // Any time the session is closed, we want to display the login controller (the user
    // cannot use the application unless they are logged in to Facebook). When the session
    // is opened successfully, hide the login controller and show the main UI.
    switch (state) {
        case FBSessionStateOpen:
        {
            if(session.isOpen)
            {
                NSLog(@"SessionStateOpen");
                
                  [[NSNotificationCenter defaultCenter] postNotificationName:SESSIONSTATEOPEN object:self];
            }
            
        }
            break;
        case FBSessionStateClosed:
        {
            NSLog(@"SessionStateClosed");
        }
            break;
        case FBSessionStateClosedLoginFailed:
            
        {
            NSLog(@"SessionStateClosedLoginFailed");
            [FBSession.activeSession closeAndClearTokenInformation];
            
        }
            break;
            
        case FBSessionStateCreated:
        {
            NSLog(@"SessionStateCreated");
        }
            break;
        case FBSessionStateCreatedTokenLoaded:
        {
            NSLog(@"SessionStateCreatedTokenLoaded");
        }
            break;
        case FBSessionStateCreatedOpening:
        {
            NSLog(@"SessionStateCreatedOpening");
        }
            break;
        case FBSessionStateOpenTokenExtended:
        {
            NSLog(@"SessionStateOpenTokenExtended");
            
            if(session.isOpen)
            {
                NSLog(@"SessionStateOpenTokenExtended");
                
                [[NSNotificationCenter defaultCenter] postNotificationName:SESSIONSTATEOPENEXTENDED object:self];
            }
        }
            break;
            
        default:
        {
            NSLog(@"SessionDefault");
        }
            break;
    }
    
  
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                            message:error.localizedDescription
                                                           delegate:nil
                                                  cancelButtonTitle:@"Okay"
                                                  otherButtonTitles:nil];
        [alertView show];
        
    }
}*/

//// facebook sdk change 8th july
/*
- (void)sessionStateChanged:(FBSession *)session :(FBSessionState)state error:(NSError *)error
{
    
    // FBSample logic
    // Any time the session is closed, we want to display the login controller (the user
    // cannot use the application unless they are logged in to Facebook). When the session
    // is opened successfully, hide the login controller and show the main UI.
    
    switch (state) {
        case FBSessionStateOpen:
        {
            if(session.isOpen)
            {
                NSLog(@"SessionStateOpen");
                
                [[NSNotificationCenter defaultCenter] postNotificationName:SESSIONSTATEOPEN object:self];
            }
            
        }
            break;
        case FBSessionStateClosed:
        {
            NSLog(@"SessionStateClosed");
        }
            break;
        case FBSessionStateClosedLoginFailed:
            
        {
            NSLog(@"SessionStateClosedLoginFailed");
            [FBSession.activeSession closeAndClearTokenInformation];
            
        }
            break;
            
        case FBSessionStateCreated:
        {
            NSLog(@"SessionStateCreated");
        }
            break;
        case FBSessionStateCreatedTokenLoaded:
        {
            NSLog(@"SessionStateCreatedTokenLoaded");
        }
            break;
        case FBSessionStateCreatedOpening:
        {
            NSLog(@"SessionStateCreatedOpening");
        }
            break;
        case FBSessionStateOpenTokenExtended:
        {
            NSLog(@"SessionStateOpenTokenExtended");
            
            if(session.isOpen)
            {
                NSLog(@"SessionStateOpenTokenExtended");
                
                [[NSNotificationCenter defaultCenter] postNotificationName:SESSIONSTATEOPENEXTENDED object:self];
            }
        }
            break;
            
        default:
        {
            NSLog(@"SessionDefault");
        }
            break;
    }
    
    
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:error.localizedDescription
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
        
    }
}


//////  AD

- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI
{
    
 
    
    
    return [FBSession openActiveSessionWithReadPermissions:@[@"public_profile", @"email"]
                                              allowLoginUI:allowLoginUI
                                         completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                             // Handler for session state changes
                                             // This method will be called EACH time the session state changes,
                                             // also for intermediate states and NOT just when the session open
                                             [self sessionStateChanged:session :state error:error];
                                         }];
    
   // NSArray *permissions = [NSArray arrayWithObjects:@"publish_actions", @"publish_stream", nil];

    //if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
    
    
    ///// 22/9/14  ///
    
        // If there's one, just open the session silently, without showing the user the login UI

    
//}

}
-(void)facebookpostmessage :(NSString *)str
{
    
 
    
    [FBRequestConnection startForPostStatusUpdate:str
                                completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                 //   [[NSNotificationCenter defaultCenter] postNotificationName:SESSIONLogIn object:self];
                                    [self showAlert:str result:result error:error];
                                    
                                }];
 
    
    
}
 */

- (void)showAlert:(NSString *)message
           result:(id)result
            error:(NSError *)error
{
    
    NSString *alertMsg;
    NSString *alertTitle;
    if (error)
    {
        alertMsg = error.localizedDescription;
        alertTitle =@"" ;
    }
    else
    {
        
        alertTitle=@"Facebook" ;
        
        
        
        alertMsg=@"Your progress has been posted to your wall." ;
        
      
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle
                                                        message:alertMsg
                                                       delegate:nil
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
    [alertView show];
    
}

//// facebook sdk change 8th july
/*- (void) closeSession
{
    [FBSession.activeSession closeAndClearTokenInformation];
}*/

////////////////////////////

@end

