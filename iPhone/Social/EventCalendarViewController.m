//
//  EventCalendarViewController.m
//  Social
//
//  Created by Sukhamoy Hazra on 23/08/13.
//
//
#import "EventCalendarViewController.h"
#import "TeamEventsVC.h"
#import "TeamMaintenanceVC.h"
#import "EventUnread.h"
#import "CenterViewController.h"
#import "HomeVC.h"
#import "FPPopoverController.h"
#import "ToDoByEventsVC.h"
#import "EventCalendarViewController.h"
//#import "CalendarViewController.h"
#import "EventEditViewController.h"
#import "EventDetailsViewController.h"
#import "SaveTeamViewController.h"
@interface EventCalendarViewController ()

@end

@implementation EventCalendarViewController
@synthesize allTeamsImg,isMonth,arrPickerItems5,currentSelectedDate,buttonMode,selectedRow,selectedDate,currentrow,selectedRow1,selectedRow2,arrPickerItems6,arrPickerItems7,arrPickerItems8,isFromTeamAdmin,helveticaLargeFont,evpopVC,isAscendingDate,topSegCntrl,isExistOwnTeam,lblUserEmail;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)showFirstEnterView:(BOOL)mode
{
    if(mode==0)
    {
       // self.firstenterview.hidden=YES;
        [self.firstenterview removeFromSuperview];
    }
    else
    {
        // self.firstenterview.hidden=NO;
        [self.view addSubview:self.firstenterview];
        
        CGRect fr= self.firstenterview.frame;
        
        float height=appDelegate.centerViewController.view.bounds.size.height-49;//Ch in xcode 5 (424)
        
        
        if(appDelegate.isIphone5)
        {
            fr.size.height=height+88;
        }
        else
        {
          fr.size.height=height;
        }
        
        self.firstenterview.frame=fr;
        
         [self.view bringSubviewToFront:self.firstenterview];
    }
}

- (void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self name:HANDLERECEIVEDMEMORYWARNING object:nil];
      [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENTDETAILS object:nil];
    
      [[NSNotificationCenter defaultCenter] removeObserver:self name:TOTALTEAMLISTUPDATED object:nil];
    
     [[NSNotificationCenter defaultCenter] removeObserver:self name:SHOWNAVIGATIONCONTROLLERCALENDAR object:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.isiPad) {
        NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:20], UITextAttributeFont, nil];
        [self.segmentedControlCalSel setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
        [self.segmentbottom setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    }
    
    self.custompopuptopselectionvw.backgroundColor=appDelegate.themeCyanColor;
       isAscendingDate=1;
    self.evpopVC=nil;
    // Do any additional setup after loading the view from its nib.
   //change [self getTaemListing];
    isFromTeamAdmin=0;
   // self.topSelectionViewForAdmin.backgroundColor=appDelegate.backgroundPinkColor;
    
   
     
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userListUpdated:) name:EVENTDETAILS object:nil];
    
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(totalTeamListUpdated:) name:TOTALTEAMLISTUPDATED object:nil];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNavigationControllerUpdated:) name:SHOWNAVIGATIONCONTROLLERCALENDAR object:nil];
   /* @autoreleasepool {
        self.helveticaFont=[UIFont fontWithName:@"Helvetica" size:10.0];//Helvetica Bold
        self.helveticaLargeFont=[UIFont fontWithName:@"Helvetica" size:12.0];
    }*/
    if (self.isiPad) {
        CGRect sf= self.segmentedControlCalSel.frame;
        sf.size.height=40;
        self.segmentedControlCalSel.frame=sf;
    }
    else{
        CGRect sf= self.segmentedControlCalSel.frame;
        sf.size.height=28;
        self.segmentedControlCalSel.frame=sf;
    }
    
    self.calender=[NSCalendar currentCalendar];
    self.ctimezone=[NSTimeZone systemTimeZone];
    
    self.topSelectionViewForAdmin.backgroundColor=appDelegate.barGrayColor;
   // self.view.backgroundColor=appDelegate.backgroundPinkColor;
    
    NSArray *marrr=[[NSArray alloc] initWithObjects:@"Going",@"Not Going",MAYBE,NORSVP, nil];
    
    self.arrPickerItems8=marrr;
    
    
    
    NSMutableArray *marr=[[NSMutableArray alloc] init];
    
    self.arrPickerItems5=marr;
    
    
    NSDictionary *dicv=nil;
    /*dicv=[[NSDictionary alloc] initWithObjectsAndKeys:@"Private",@"team_name", @"Private",@"team_id",nil ];
    
    [arrPickerItems5 insertObject:dicv atIndex:0 ];*/
    marr=nil;
    dicv=nil;
   // self.view.backgroundColor=appDelegate.backgroundPinkColor;
   // self.firstenterview.backgroundColor=appDelegate.backgroundPinkColor;
    self.middleviewfirst.hidden=YES;
     self.cellvw1.layer.cornerRadius=3.0;
    self.cellvw2.layer.cornerRadius=3.0;
    self.cellvw3.layer.cornerRadius=3.0;
   // self.topview.backgroundColor=appDelegate.barGrayColor;
    self.topview.hidden=YES;
    self.bottomView.hidden=YES;
    // self.bottomView.backgroundColor=appDelegate.barGrayColor;
  
    storeCreatedRequests=[[NSMutableArray alloc] init];
    CalendarViewController *calVC=nil;
    
    if (self.isiPad) {
        calVC=[[CalendarViewController alloc] initWithNibName:@"CalendarViewController_iPad" bundle:nil];
    }
    else{
        calVC=[[CalendarViewController alloc] initWithNibName:@"CalendarViewController" bundle:nil];
    }
    self.calvc=calVC;
  
    
    ToDoByEventsVC *callsVC=[[ToDoByEventsVC alloc] initWithNibName:@"ToDoByEventsVC" bundle:nil];
    self.callistvc=callsVC;
    self.callistvc.eventCalVC=self;
    
    
    
    self.lblUserEmail=[[UILabel alloc] init];
    self.lblUserEmail.hidden=YES;
    self.lblUserEmail.text=@"This calendar's events  can also be viewed on your  iPhone calendar";
    self.lblUserEmail.textColor=[UIColor darkGrayColor];
    self.lblUserEmail.textAlignment=NSTextAlignmentCenter;
    self.lblUserEmail.font=[UIFont systemFontOfSize:9.0];
    
    if (self.isiPad) {
        calVC.view.frame=CGRectMake(0,65 , 768, 960-260);
        callsVC.view.frame=CGRectMake(0,65 , 768, 960-260);
        self.lblUserEmail.frame=CGRectMake(10, 960, 300, 20);
    }
    else{
         
         if(self.appDelegate.isIphone5)
         {
             calVC.view.frame=CGRectMake(0,45 , 320, (384-45+88)-65);
             callsVC.view.frame=CGRectMake(0,45 , 320, (384-45+88)-50);
             self.lblUserEmail.frame=CGRectMake(10, (384-45+88), 300, 20);
             
             
         }
         else
         {
             calVC.view.frame=CGRectMake(0,45 , 320, (384-45)-50);
             callsVC.view.frame=CGRectMake(0,45 , 320, (384-45)-50);
             self.lblUserEmail.frame=CGRectMake(10, (384-45), 300, 20);
             
         }
         
    }
    [self.view addSubview:calVC.view];
    [self.view addSubview:callsVC.view];
    [self.view addSubview:lblUserEmail];
    //[self.view sendSubviewToBack:calVC.view];
      self.eventheaderlab.text=CREATETEAMEVENTINVITATION;
    isMonth=1;
     [self setLeftBarButton];
    self.topSegCntrl.selectedSegmentIndex=isMonth;
    
    if(!isMonth)
    {
        calVC.view.hidden=YES;
        self.downarrowfilterimavw.hidden=NO;
        self.downarrowfilterbt.hidden=NO;
    }
    else
    {
         callsVC.view.hidden=YES;
        self.downarrowfilterimavw.hidden=YES;
         self.downarrowfilterbt.hidden=YES;
    }
    
    @autoreleasepool
    {
        self.helveticaFontForteBold=[UIFont fontWithName:@"Helvetica-Bold" size:12.0];
        self.helveticaFont=[UIFont fontWithName:@"Helvetica" size:10.0];
    }
    
    
    
    FilteredPlayerClass *fpc=[[FilteredPlayerClass alloc] init];
    
    fpc.delegate=self;
    [fpc performFetch];
    
    
    
    
     self.navigationController.delegate=self;
}
////////ADDDEBNEW

-(BOOL)checkEventExist
{
NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
NSEntityDescription *entity = [NSEntityDescription entityForName:EVENT inManagedObjectContext:self.managedObjectContext];
[fetchRequest setEntity:entity];
    [fetchRequest setFetchLimit:1];
    
    NSArray *ar=  [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];

if(ar.count)
{
    return 1;
}
else
{
        return 0;
}

}
////////
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SHOWNAVIGATIONCONTROLLERCALENDAR object:nil];
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

-(void)setTopBarText
{
    if(self.navigationController.view.hidden==NO)//([appDelegate.centerViewController getShowStatus:self.navigationController])
    {
        if([[self.navigationController.viewControllers lastObject] isMemberOfClass:[self class]])
        {
            appDelegate.centerViewController.navigationItem.title=nil;
            appDelegate.centerViewController.navigationItem.titleView=nil;
            
           
                appDelegate.centerViewController.navigationItem.title=@"Events";
        }
    }
}

-(void)showNavigationBarButtons
{
    
    if(!self.leftBarButtonItem)
    {
        self.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"eventfilter.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleLeftPanel:)];
    }
    
    if(!self.rightBarButtonItem)
    {
        if (self.isiPad) {
            self.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"plus_icon_add_ipad.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleRightPanel:)];
        }
        else
            self.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"plus_icon_add.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleRightPanel:)];
        
        //[self.btnAddEvent addTarget:self action:@selector(toggleRightPanel:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    appDelegate.centerViewController.navigationItem.title=nil;
    appDelegate.centerViewController.navigationItem.titleView=nil;
    
    //appDelegate.centerViewController.navigationItem.title=nil;
    // appDelegate.centerViewController.navigationItem.titleView=nil;
    
    [self setLeftBarButton];
    
    
    [self setRightBarButton];
   
    
    
    [self setStatusBarStyleOwnApp:1];
    
}


-(void)setRightBarButton
{
    
    if(self.navigationController.view.hidden==NO)
    {
        if([[self.navigationController.viewControllers lastObject] isMemberOfClass:[self class]])
        {
            
            if(isExistOwnTeam)
            {
                appDelegate.centerViewController.navigationItem.rightBarButtonItem=self.rightBarButtonItem;
                
                self.callistvc.noeventslab.text=self.callistvc.adminmsgnoevent;
                self.callistvc.lblPlus.text=@"+";
            }
            else
            {
                appDelegate.centerViewController.navigationItem.rightBarButtonItem=nil;
                //self.callistvc.btnAddEvent.hidden=YES
                
                self.callistvc.noeventslab.text=self.callistvc.normalmsgnoevent;
                self.callistvc.lblPlus.text=@"";
            }
        }
    }
}


-(void)setLeftBarButton
{
    
    if(self.navigationController.view.hidden==NO)
    {
        if([[self.navigationController.viewControllers lastObject] isMemberOfClass:[self class]])
        {
            
            if(!isMonth)
            {
                
                ////////ADDDEBNEW
                if([self checkEventExist])
                    ////////////
                appDelegate.centerViewController.navigationItem.leftBarButtonItem=self.leftBarButtonItem;
                
                ////////ADDDEBNEW
                else
                appDelegate.centerViewController.navigationItem.leftBarButtonItem=nil;
                ///////////////
            }
            else
            {
                appDelegate.centerViewController.navigationItem.leftBarButtonItem=nil;
            }
        }
    }
}

-(void)toggleLeftPanel:(id)sender
{
    appDelegate.centerViewController.navigationItem.rightBarButtonItem=nil;
    [self dropDownBtAction:nil];
    
}


-(void)toggleRightPanel:(id)sender
{
    if(self.custompopupbottomvw.hidden==NO && self.custompopuptopselectionvw.hidden==NO)
    {
        return;
    }
    
    
    
    
    EventEditViewController *eVc=[[EventEditViewController alloc] initWithNibName:@"EventEditViewController" bundle:nil];
    
    /*NSMutableArray *mdic=[self.arrPickerItems5 mutableCopy];
    
    if(mdic.count!=1)
    {
        [mdic removeLastObject];
    }
    
    eVc.arrPickerItems5=mdic;*/
    eVc.mode=1;
    eVc.defaultDate=self.currentSelectedDate;
    
    
    self.isModallyPresentFromCenterVC=1;
    [self showModal:eVc];
    
    
    
    
    
}



-(void)setOwnViewDependOnFlag:(BOOL)isOne
{
    isFromTeamAdmin=isOne;
    
   /* float m1=36;
    float m2=35;
    
       float height1= (384-44+88+8);
     float height2=(384-44+8);*/
    
    
    if(isFromTeamAdmin)
    {
       self.backimgvw.hidden=NO;
        self.backimgvwbt.hidden=NO;
        
       /* m1+=36;
        m2+=36;
        
        height2-=36;
        height2-=36;*/
        
        self.topview.hidden=YES;
        self.topSelectionViewForAdmin.hidden=NO;
        [self.view bringSubviewToFront:self.topSelectionViewForAdmin];
        self.todaybt.hidden=YES;
        
        
        //self.eventheaderlab.font=self.helveticaLargeFont;
        
    }
    else
    {
        self.backimgvw.hidden=YES;
        self.backimgvwbt.hidden=YES;
        self.topSelectionViewForAdmin.hidden=YES;
        self.topview.hidden=NO;
        [self.view bringSubviewToFront:self.topview];
        self.todaybt.hidden=NO;
    }
    
    
    
    
    
   /* if(self.appDelegate.isIphone5)
    {
        self.calvc.view.frame=CGRectMake(0,m1 , 320,height1);
      
        self.callistvc.view.frame=CGRectMake(0,m2 , 320, height1);
    }
    else
    {
        self.calvc.view.frame=CGRectMake(0,m1 , 320,height2 );
        self.callistvc.view.frame=CGRectMake(0,m2 , 320, height2);
    }*/
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidUnload
{
    [self setFirstenterview:nil];
    [self setMiddleviewfirst:nil];
    [self setEventheaderlab:nil];
    [self setCellvw1:nil];
    [self setCellvw2:nil];
    [self setCellvw3:nil];
    [self setPickercontainer:nil];
    [self setTop:nil];
    [self setDpicker:nil];
    [self setPicker:nil];
    [self setBackimgvw:nil];
    [self setBackimgvwbt:nil];
    [self setTopSelectionViewForAdmin:nil];
    [self setCreateeventlab:nil];
    [self setTrackeventlab:nil];
    [self setTrackteamlab:nil];
    [self setTodaybt:nil];
    [self setDownarrowfilterimavw:nil];
    [self setDownarrowfilterbt:nil];
    [super viewDidUnload];
    self.allTeamsImg=nil;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.calvc viewWillAppear:animated];
    
    [self.callistvc viewWillAppear:animated];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(teamListUpdated:) name:TEAM_LISTING object:nil];
    
    
}

 
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TEAM_LISTING object:nil];
    
    
}






-(void)processEditEvent:(NSString*)eventId :(BOOL)isExist
{
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    [command setObject:eventId forKey:@"event_id"];
    
   /* Invite *anObj = nil;
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:EVENTUNREAD inManagedObjectContext:self.managedObjectContext]];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"(eventId==%@) AND (userId==%@) AND (type==%i)",eventId,[appDelegate.aDef objectForKey:LoggedUserID],5]];
    
    NSArray* ar =nil;
    ar= [self.managedObjectContext executeFetchRequest:request error:nil];
    if ([ar count]>=1)
    {
        anObj= (Invite *) [ar objectAtIndex:0];
    }*/
    
    
    
    
 
   /* Invite  *eventvar=nil;
    
    if(anObj)
    {
        eventvar=anObj;
        
        [command setObject:eventvar.playerUserId forKey:@"UserID"];
        
    
    }
    else
    {*/
    
     [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
   // }
    
    
    
    
    
    
    
    
    
    
     
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    
    [self sendRequestForPost:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]:isExist];
}



-(void)processAcceptEvent:(Invite*)eventToDelete
{
    NSString  *eventId=eventToDelete.eventId;
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    [command setObject:eventId forKey:@"event_id"];
    
    [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
 
    [self showNativeHudView];
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    
    //[appDelegate sendRequestFor:EVENTDETAILS from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
    
    
    SingleRequest *sinReq=nil;
    sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:EVENTDETAILSLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
    //self.sinReq3=sinReq;
    [self.storeCreatedRequests addObject:sinReq];
    sinReq.notificationName=EVENTDETAILS;
    sinReq.userInfo=eventToDelete;
    [sinReq startRequest];
}



-(void)saveFailedEvent:(NSString*)eventId
{
    NSMutableArray *marr=nil;
    
     if([appDelegate.aDef objectForKey:FAILEDEVENTALREADYACCEPTEDLIST])
     {
         marr=[[appDelegate.aDef objectForKey:FAILEDEVENTALREADYACCEPTEDLIST] mutableCopy];
         
         
        
         
         
     }
    else
    {
        
        marr=[[NSMutableArray alloc] init];
        
        
    }
    
    
    if(![marr containsObject:eventId])
    {
    [marr addObject:eventId];
    [appDelegate setUserDefaultValue:marr ForKey:FAILEDEVENTALREADYACCEPTEDLIST];
    }
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PROCESSACCEPTEVENTFINISHED object:[NSNumber numberWithBool:0]];
    
}



-(void)userListUpdated:(id)sender
{
    [self hideNativeHudView];
    SingleRequest *sReq=(SingleRequest*)[sender object];
    
    
    
   
    
    if([sReq.notificationName isEqualToString:EVENTDETAILS])
    {
         Invite *eunread=(Invite*)   sReq.userInfo;
        
        
        
        if(sReq.responseData)
        {
            
            if (sReq.responseString)
            {
                SBJsonParser *parser=[[SBJsonParser alloc] init];
                
                id res = [parser objectWithString:sReq.responseString];
                if ([res isKindOfClass:[NSDictionary class]])
                {
                    NSDictionary* dic = (NSDictionary*) res;
                    
                    
                    if([[NSString stringWithFormat:@"%@", [dic objectForKey:@"status"]] isEqualToString:@"1"])
                    {
                              
                   //////////////////////////////////
                        
                        NSLog(@"StoreEventDetails=%@",sReq.userInfo);
                        
                        dic=[dic objectForKey:@"response"];
                        dic=[dic objectForKey:@"event_details"];
                        
                            
                            Event   *eventvar = nil;
                        /////////////////
                        NSString    *eId=    [dic objectForKey:@"event_id"];
                        Event *dataEvent=nil;
                        Event *anObj = nil;
                        NSFetchRequest * request = [[NSFetchRequest alloc] init];
                        [request setEntity:[NSEntityDescription entityForName:EVENT inManagedObjectContext:self.managedObjectContext]];
                        
                        [request setPredicate:[NSPredicate predicateWithFormat:@"(eventId==%@) AND (userId=%@)",eId,[appDelegate.aDef objectForKey:LoggedUserID]]];
                        
                        NSArray* ar =nil;
                        ar= [self.managedObjectContext executeFetchRequest:request error:nil];
                        if ([ar count]>=1)
                        {
                            anObj= (Event *) [ar objectAtIndex:0];
                        }
                        
                        
                        dataEvent=anObj;
                        if(dataEvent)
                        {
                            eventvar=dataEvent;
                        }
                        else
                        {
                        /////////////////
                            eventvar= (Event *)[NSEntityDescription insertNewObjectForEntityForName:EVENT inManagedObjectContext:self.managedObjectContext];
                        
                        }
                        
                        
                        
                            
                            eventvar.isPublic=[NSNumber numberWithBool:1];
                            eventvar.isCreated=[NSNumber numberWithBool:0];
                            
                           
                                eventvar.playerName=eunread.playerName;
                                eventvar.playerId=eunread.playerId;
                                eventvar.playerUserId=eunread.playerUserId;
                            
                          
                            
                            
                            eventvar.eventDate=[appDelegate.dateFormatDb dateFromString:[dic objectForKey:@"event_date"]];
                            eventvar.teamId= [NSString stringWithFormat:@"%@",  [dic objectForKey:@"team_id"] ];
                            eventvar.teamName= [dic objectForKey:@"team_name"];
                            eventvar.eventName=[dic objectForKey:@"event_name"];
                            eventvar.eventType=[dic objectForKey:@"event_type"];
                            eventvar.location= [dic objectForKey:@"location"];
                            eventvar.fieldName= [dic objectForKey:@"field_name"];
                            eventvar.isHomeGame= [NSNumber numberWithBool:[[dic objectForKey:@"is_home_ground"] boolValue] ];
                            eventvar.notes= [dic objectForKey:@"notes"];
                            eventvar.repeat=[appDelegate.centerViewController.arrPickerItemsRepeat objectAtIndex:[[dic objectForKey:@"repeat"] integerValue] ];
                            eventvar.arrivalTime=[appDelegate.dateFormatFullOriginal dateFromString:[NSString stringWithFormat:@"%@, %@",[dic objectForKey:@"event_date"],[dic objectForKey:@"arrival_time"]] ];
                            eventvar.startTime=[appDelegate.dateFormatFullOriginal dateFromString:[NSString stringWithFormat:@"%@, %@",[dic objectForKey:@"event_date"],[dic objectForKey:@"start_time"]] ];;
                            eventvar.endTime=[appDelegate.dateFormatFullOriginal dateFromString:[NSString stringWithFormat:@"%@, %@",[dic objectForKey:@"event_date"],[dic objectForKey:@"end_time"]] ];;
                            eventvar.uniformColor=[dic objectForKey:@"uniform"];
                            eventvar.opponentTeamId= [dic objectForKey:@"opponent_team_id"];
                            eventvar.opponentTeam= [dic objectForKey:@"opponent_team"];
                            eventvar.thingsToBring= [dic objectForKey:@"things_to_bring"];
                            eventvar.alertString=[appDelegate.centerViewController.arrPickerItemsAlert objectAtIndex:[[dic objectForKey:@"alert"] integerValue]];
                            
                            NSDate *stDateF= [appDelegate.centerViewController dateFromSD:eventvar.eventDate ];
                            if(![eventvar.alertString isEqualToString:@"Never"])
                            {
                                NSDate *d=[appDelegate.centerViewController getAlertDateForAlertString:eventvar.alertString:eventvar.startTime];
                                NSDate *arrDate3=[appDelegate.centerViewController dateFromSD:d];
                                
                                eventvar.alertDate=[stDateF dateByAddingTimeInterval:[d timeIntervalSinceDate:arrDate3]];
                            }
                            
                            
                            
                                eventvar.isPublicAccept=eunread.inviteStatus;
                            
                            eventvar.eventIdentifier=nil;
                            eventvar.userId=[appDelegate.aDef objectForKey:LoggedUserID];
                            eventvar.eventId=[dic objectForKey:@"event_id"];
                            
                            
                         //   NSLog(@"GetDateTimeCanNameBeforeCheckDate=%@", [self.dateFormatDb stringFromDate:eventvar.eventDate]);
                            eventvar.eventDateString=[appDelegate.centerViewController getDateTimeCanName:eventvar.eventDate];
                            
                            NSLog(@"GetDateTimeCanNameAfterCheckDate=%@",eventvar.eventDateString);
                            
                            
                            
                            
                            if(eventvar.isPublicAccept.intValue==0)
                            {
                                
                                EKEvent *newEvent=nil;
                                newEvent= [EKEvent eventWithEventStore:appDelegate.eventStore];
                                
                                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                
                                if ([defaults objectForKey:@"Calendar"] == nil) // Create Calendar if Needed
                                {
                                    EKSource *theSource = nil;
                                    
                                    for (EKSource *source in appDelegate.eventStore.sources)
                                    {
                                        if (source.sourceType == EKSourceTypeCalDAV && [source.title isEqualToString:@"iCloud"])
                                        {
                                            theSource = source;
                                            NSLog(@"iCloud Store Source");
                                            break;
                                        }
                                        else
                                        {
                                            for (EKSource *source in appDelegate.eventStore.sources)
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
                                        cal=[EKCalendar calendarWithEventStore:appDelegate.eventStore];
                                    else
                                        cal=[EKCalendar calendarForEntityType:EKEntityTypeEvent eventStore:appDelegate.eventStore ];
                                    
                                    cal.title = @"hello";
                                    cal.source = theSource;
                                    [appDelegate.eventStore saveCalendar:cal commit:YES error:nil];
                                    NSLog(@"cal id = %@", cal.calendarIdentifier);
                                    NSString *calendar_id = cal.calendarIdentifier;
                                    [defaults setObject:calendar_id forKey:@"Calendar"];
                                    [defaults synchronize];
                                    newEvent.calendar  = cal;
                                    
                                }
                                else
                                {
                                    newEvent.calendar  = [appDelegate.eventStore calendarWithIdentifier:[defaults objectForKey:@"Calendar"]];
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
                                BOOL save=  [appDelegate.eventStore saveEvent:newEvent span:EKSpanFutureEvents commit:YES error:&error];
                                NSLog(@"SaveEventStatus....1=%i \n%@",save,error.description);
                                
                                eventvar.eventIdentifier=newEvent.eventIdentifier;
                                
                                
                                
                               /* if(save)
                                {*/
                                
                                    [appDelegate saveContext];
                              /*  }
                                else
                                {
                                    [self.managedObjectContext rollback];
                                }*/
                                
                                
                            }
                            else
                            {
                                
                              //  NSLog(@"EventSaveNumber=%i",i);
                                [appDelegate saveContext];
                            }
                            
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                 ///////////////////////////////////
                        
                        
                        
                 
                        if(eunread)
                        [appDelegate.managedObjectContext deleteObject:eunread];
                        [appDelegate saveContext];
                        
                        
                        
                          [[NSNotificationCenter defaultCenter] postNotificationName:PROCESSACCEPTEVENTFINISHED object:[NSNumber numberWithBool:1]];
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                    }
                    
                    else
                    {
                         [self saveFailedEvent:eunread.eventId ];
                    }
                    
                }
                else
                {
                    [self saveFailedEvent:eunread.eventId ];
                }
                
            }
            else
            {
                [self saveFailedEvent:eunread.eventId ];
            }
        }
        else
        {
           
                [self saveFailedEvent:eunread.eventId ];
            
        }
    }
    else
    {
        
    }
    
}



-(void)sendRequestForPost:(NSDictionary*)dic :(BOOL)isExist
{
    // NSString *str=POST;
    
    NSURL* url = [NSURL URLWithString:EVENTDETAILSLINK];
    ASIFormDataRequest *aRequest=  [[ASIFormDataRequest alloc] initWithURL:url] ;
    
    
    
    [aRequest setShouldContinueWhenAppEntersBackground:YES];
    
    [aRequest setDelegate:self];
    
    [aRequest setValidatesSecureCertificate:NO];
    [ASIFormDataRequest setShouldThrottleBandwidthForWWAN:YES];
    
    
    
    if([[dic allKeys] count]>0)
    {
        
        
        for(int i=0;i<[[dic allKeys] count];i++)
        {
            // NSLog(@"RequestParam=%@",[[dic allKeys] objectAtIndex:i]);
            
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
    
    
    aRequest.userInfo=[[NSDictionary alloc] initWithObjectsAndKeys:[[NSNumber alloc] initWithBool:isExist],@"ISEXISTINDATABASE", nil];
    
    
    [aRequest startAsynchronous];
    
}


- (void)requestFinished:(ASIHTTPRequest *)request
{
	NSLog(@"Data Received in Connection ManagerProcessEditEvent.... %@ ",[request responseString]);
    
    NSString *str=[request responseString];
    
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
                
              
                            
                            
                            
                            NSDictionary *event_details=[[aDict objectForKey:@"response"] objectForKey:@"event_details"];
                          
                
                 if([[request.userInfo objectForKey:@"ISEXISTINDATABASE"] boolValue])
                 {
                
                         Event *dataEvent=   [self saveEditEvent:event_details :[event_details objectForKey:@"event_id"] ];
                            
                        /*if([[self.navigationController.viewControllers lastObject] isMemberOfClass:[EventDetailsViewController class]])
                        {
                         [self.navigationController popToRootViewControllerAnimated:YES];
                        }*/
                     if(self.evUnreadeventUpdate){
                      //[self.managedObjectContext deleteObject:self.evUnreadeventUpdate ];
                         self.evUnreadeventUpdate.viewStatus=[[NSNumber alloc] initWithBool:1];
                     }
                     [appDelegate saveContext];
                     self.evUnreadeventUpdate=nil;
                     [[NSNotificationCenter defaultCenter] postNotificationName:EVENTUPDATEPROCESSCOMPLETE object:nil];
                     
                     [appDelegate.centerViewController topbarbtapped:appDelegate.centerViewController.postbt];
                     EventDetailsViewController *eVC=[[EventDetailsViewController alloc] initWithNibName:@"EventDetailsViewController" bundle:nil];
                     
                     //  NSLog(@"PushNewEvent=%@",newEvent);
                     
                     eVC.dataEvent=dataEvent;
                     [appDelegate.navigationControllerCalendar popToRootViewControllerAnimated:NO];
                     [appDelegate.navigationControllerCalendar pushViewController:eVC animated:YES ];

                     
                 }
                else
                {
                    //////////////////////////////
                    Invite *anObj = nil;
                    NSFetchRequest * request = [[NSFetchRequest alloc] init];
                    [request setEntity:[NSEntityDescription entityForName:EVENTUNREAD inManagedObjectContext:self.managedObjectContext]];
                    
                    [request setPredicate:[NSPredicate predicateWithFormat:@"(eventId==%@) AND (userId==%@) AND (type==%i)",[event_details objectForKey:@"event_id"],[appDelegate.aDef objectForKey:LoggedUserID],5]];
                    
                    NSArray* ar =nil;
                    ar= [self.managedObjectContext executeFetchRequest:request error:nil];
                    if ([ar count]>=1)
                    {
                        anObj= (Invite *) [ar objectAtIndex:0];
                    }
                    
                    
                    
                    
                    ///////
                    Invite  *eventvar=nil;
                    
                    if(anObj)
                    {
                        eventvar=anObj;
                    
                    eventvar= (Invite *)[NSEntityDescription insertNewObjectForEntityForName:EVENTUNREAD inManagedObjectContext:self.managedObjectContext];
                    
                    
                    //eventvar.inviteStatus=[NSNumber numberWithInt:1];
                    //eventvar.isPublic=[NSNumber numberWithBool:1];
                   
                    
                    
                    eventvar.eventName=[event_details objectForKey:@"event_name"];
                  
                    eventvar.teamName=[event_details objectForKey:@"team_name"];
                    eventvar.teamLogo=[event_details objectForKey:@"team_logo"];
                 
                   // eventvar.type=[[NSNumber alloc] initWithInt:5];
                    if([event_details objectForKey:@"adddate"])
                    {
                        int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                        
                        NSDate *datetime=   [[appDelegate.dateFormatFullOriginalComment dateFromString:[event_details objectForKey:@"adddate"]] dateByAddingTimeInterval:difftime]  ;
                        
                        
                        eventvar.datetime=datetime;
                    }
                    
                    [appDelegate saveContext];
                    //////////////////////////////
                }
                
                
                
                
              
            }
              [self showAlertMessage: [NSString stringWithFormat:@"%@ updated.",[event_details objectForKey:@"event_name"] ] title:@""];
            }
            else
            {
                [appDelegate showNetworkError:[aDict objectForKey:@"message"] ];
            }
        }
    }
    
    
	
}





- (void)requestFailed:(ASIHTTPRequest *)request
{
    
    // [self resetPostView];
    //	NSLog(@"Error receiving data : %@ ",[request.error description]);
	//[appDelegate showNetworkError:CONNFAILMSG];ChAfter
	
}






-(Event*)saveEditEvent:(NSDictionary*)dic :(NSString*)eventId
{
    Event   *eventvar = nil;
    eventvar=[self objectOfType2Event:eventId];
    
    eventvar.isCreated=[NSNumber numberWithBool:0];
    eventvar.eventDate=[appDelegate.dateFormatDb dateFromString:[dic objectForKey:@"event_date"]];
    eventvar.teamId= [NSString stringWithFormat:@"%@", [dic objectForKey:@"team_id"] ];
    eventvar.teamName= [dic objectForKey:@"team_name"];
    eventvar.eventName=[dic objectForKey:@"event_name"];
    eventvar.eventType=[dic objectForKey:@"event_type"];
    eventvar.location= [dic objectForKey:@"location"];
    eventvar.fieldName= [dic objectForKey:@"field_name"];
    eventvar.isHomeGame= [NSNumber numberWithBool:[[dic objectForKey:@"is_home_ground"] boolValue] ];
    eventvar.notes= [dic objectForKey:@"notes"];
    eventvar.repeat=[self.arrPickerItemsRepeat objectAtIndex:[[dic objectForKey:@"repeat"] integerValue] ];
    eventvar.arrivalTime=[appDelegate.dateFormatFullOriginal dateFromString:[NSString stringWithFormat:@"%@, %@",[dic objectForKey:@"event_date"],[dic objectForKey:@"arrival_time"]] ];
    eventvar.startTime=[appDelegate.dateFormatFullOriginal dateFromString:[NSString stringWithFormat:@"%@, %@",[dic objectForKey:@"event_date"],[dic objectForKey:@"start_time"]] ];;
    eventvar.endTime=[appDelegate.dateFormatFullOriginal dateFromString:[NSString stringWithFormat:@"%@, %@",[dic objectForKey:@"event_date"],[dic objectForKey:@"end_time"]] ];;
    eventvar.uniformColor=[dic objectForKey:@"uniform"];
    eventvar.opponentTeamId= [dic objectForKey:@"opponent_team_id"];
    eventvar.opponentTeam= [dic objectForKey:@"opponent_team"];
    eventvar.thingsToBring= [dic objectForKey:@"things_to_bring"];
    eventvar.alertString=[self.arrPickerItemsAlert objectAtIndex:[[dic objectForKey:@"alert"] integerValue]];
    
    NSDate *stDateF= [self dateFromSD:eventvar.eventDate ];
    if(![eventvar.alertString isEqualToString:@"Never"])
    {
        NSDate *d=[self getAlertDateForAlertString:eventvar.alertString:eventvar.startTime];
        NSDate *arrDate3=[self dateFromSD:d];
        
        eventvar.alertDate=[stDateF dateByAddingTimeInterval:[d timeIntervalSinceDate:arrDate3]];
    }
    
    
  //  eventvar.isPublic=[NSNumber numberWithBool:1];
  //  eventvar.isPublicAccept=[NSNumber numberWithInt:1];
  //  eventvar.eventIdentifier=nil;
  //  eventvar.userId=[appDelegate.aDef objectForKey:LoggedUserID];
  //  eventvar.eventId=[dic objectForKey:@"event_id"];
    eventvar.eventDateString=[self getDateTimeCanName:eventvar.eventDate];
   
    
    
/////////////////////////////////////////////////////////////
    EKEvent *newEvent=nil;
    newEvent= [EKEvent eventWithEventStore:appDelegate.eventStore];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:@"Calendar"] == nil) // Create Calendar if Needed
    {
        EKSource *theSource = nil;
        
        for (EKSource *source in appDelegate.eventStore.sources)
        {
            if (source.sourceType == EKSourceTypeCalDAV && [source.title isEqualToString:@"iCloud"])
            {
                theSource = source;
                NSLog(@"iCloud Store Source");
                break;
            }
            else
            {
                for (EKSource *source in appDelegate.eventStore.sources)
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
        if(appDelegate.systemVersion<6.0)
            cal=[EKCalendar calendarWithEventStore:appDelegate.eventStore];
        else
            cal=[EKCalendar calendarForEntityType:EKEntityTypeEvent eventStore:appDelegate.eventStore ];
        
        cal.title = @"hello";
        cal.source = theSource;
        [appDelegate.eventStore saveCalendar:cal commit:YES error:nil];
        NSLog(@"cal id = %@", cal.calendarIdentifier);
        NSString *calendar_id = cal.calendarIdentifier;
        [defaults setObject:calendar_id forKey:@"Calendar"];
        [defaults synchronize];
        newEvent.calendar  = cal;
        
    }
    else
    {
        newEvent.calendar  = [appDelegate.eventStore calendarWithIdentifier:[defaults objectForKey:@"Calendar"]];
        NSLog(@"Calendar Existed");
        
       /* if(appDelegate.defaultCalendar)
            newEvent.calendar=appDelegate.defaultCalendar;*/
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
    BOOL save=  [appDelegate.eventStore saveEvent:newEvent span:EKSpanFutureEvents commit:YES error:&error];
    NSLog(@"SaveEventStatus....1=%i \n%@",save,error.description);
    
    eventvar.eventIdentifier=newEvent.eventIdentifier;
  
    [appDelegate saveContext];
    
    
    return eventvar;
}




- (IBAction)bTapped:(id)sender
{
    int tag=[sender tag];
    
    if(tag==0)
    {
        
        if(arrPickerItems5 && arrPickerItems5.count>0)
        {
            NSLog(@"%@",arrPickerItems5);
            
        PopOverViewController *controller = [[PopOverViewController alloc] initWithNibName:@"PopOverViewController" bundle:nil];
        controller.title=@"Teams";
        controller.delegate=self;
            controller.dataArray=arrPickerItems5;
        //our popover
        FPPopoverController *popover = [[FPPopoverController alloc] initWithViewController:controller];
        
            controller.popOver=popover;
        //Default content size is 200x300. This can be set using the following property
       // popover.contentSize = CGSizeMake(150,200);
        popover.tint=FPPopoverLightGrayTint;
        
        //the popover will be presented from the okButton view
        [popover presentPopoverFromView:sender];
        
        //no release (ARC enable)
            
         /////////////////////////Change With Picker
            
          
            
            
            
            
            
            
            
            
            
            
            
            
            
        //////////////////////////
            
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
        /*EventEditViewController *eVc=[[EventEditViewController alloc] initWithNibName:@"EventEditViewController_Private" bundle:nil];
         eVc.mode=0;
        eVc.defaultDate=self.currentSelectedDate;
        [self.navigationController pushViewController:eVc animated:YES];*/
        [self showAlertMessage:@"Private Event is not allowed"];
    }
    else
    {
       // self.segmentbottom.selectedSegmentIndex=0;
        self.evpopVC.datelab.font=self.helveticaFont;
        self.evpopVC.teamandeventlab.font=self.helveticaFont;
        self.evpopVC.playerlab.font=self.helveticaFont;
        self.evpopVC.statuslab.font=self.helveticaFont;
        
        
        
        
         self.eventheaderlab.text=CREATETEAMEVENTINVITATION;
        isMonth=0;
        [self setLeftBarButton];
        self.topSegCntrl.selectedSegmentIndex=isMonth;
        self.callistvc.fetchFirstDate=nil;
        self.callistvc.fetchLastDate=nil;
        self.callistvc.selTeamId=nil;
        self.callistvc.selplayerId=nil;
        self.callistvc.selShowByStatus=0;
        self.callistvc.isSelShowByStatus=0;
        self.callistvc.fetchedResultsController=nil;
        [self.callistvc loadTable];
        self.calvc.view.hidden=YES;
        self.callistvc.view.hidden=NO;
        
        self.downarrowfilterimavw.hidden=NO;
        self.downarrowfilterbt.hidden=NO;
        
        [self.calvc.monthView reloadData];
    }
}



-(void)showDate
{
   /* self.dateActionSheet=[[UIActionSheet alloc] initWithTitle:EVENTDATESELECTION delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:FILTERONDATES,CURRENTWEEK,ALL, nil];
    
    [self.dateActionSheet showInView:self.appDelegate.centerViewController.view];*/
    
    self.callistvc.fetchedResultsController=nil;
    self.callistvc.todayIndexpath=nil;
    self.callistvc.isAscendingDate=isAscendingDate;
    
    [self.callistvc.tabView reloadData];
    if(self.callistvc.fetchedResultsController.fetchedObjects.count>0)
    {
        [self.callistvc.tabView scrollToRowAtIndexPath:self.callistvc.todayIndexpath
                                      atScrollPosition:UITableViewScrollPositionTop
                                              animated:YES];
        self.callistvc.tabView.hidden=NO;
        self.callistvc.noeventslab.hidden=YES;
        self.callistvc.lblPlus.hidden=YES;
        self.callistvc.noeventsfilterlab.hidden=YES;
        self.callistvc.allfilterbt.hidden=YES;
        self.callistvc.noeventsimagevw.hidden=YES;
    }
    else
    {
        self.callistvc.tabView.hidden=YES;
        self.callistvc.noeventsimagevw.hidden=NO;
        
        if(self.callistvc.fetchFirstDate==nil && self.callistvc.fetchLastDate==nil && self.callistvc.selTeamId==nil && self.callistvc.selplayerId==nil && self.callistvc.isSelShowByStatus==0)
        {
            self.callistvc.noeventslab.hidden=NO;
            self.callistvc.lblPlus.hidden=NO;
            self.callistvc.noeventsfilterlab.hidden=YES;
            self.callistvc.allfilterbt.hidden=YES;
        }
        else
        {
            self.callistvc.noeventslab.hidden=YES;
            self.callistvc.lblPlus.hidden=YES;
            self.callistvc.noeventsfilterlab.hidden=NO;
            self.callistvc.allfilterbt.hidden=NO;
        }
    }
    
    
    //// AD...iAd
    self.callistvc.adBanner.delegate = self;
    self.callistvc.adBanner.alpha = 0.0;
    self.callistvc.canDisplayBannerAds=YES;
    ////
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
       
        self.pickercontainer.hidden=NO;
        self.picker.hidden=YES;
        self.dpicker.hidden=NO;
              [self.view bringSubviewToFront:self.top];
        [self.view bringSubviewToFront:self.pickercontainer];
  
        self.dpicker.datePickerMode=UIDatePickerModeDate;
        
        
        self.top.hidden=NO;
        buttonMode=1;
        
        NSDate *  date;
        
        if(self.selectedDate)
            date=self.selectedDate;
        else
            date=[[NSDate alloc] init];
        
        self.dpicker.date= date;
        
        date=nil;
    }
    else if(buttonIndex==1)
    {
        //@autoreleasepool {
           self.evpopVC.datelab.font=self.helveticaFontForteBold;  
        
        NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
        
        [formatter setTimeZone:ctimezone];
        
        [formatter setDateFormat:@"dd MMM, yyyy-hh:mm:ss a"];
        
        [calender setTimeZone:ctimezone];
            NSDate *currdate=[[NSDate alloc] init];
     
        
        NSDateComponents *weekdayComponents = [calender components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekdayCalendarUnit|NSWeekOfMonthCalendarUnit) fromDate:currdate];
        [weekdayComponents setWeekday:1];
        
        NSDate *weekFirst=[calender dateFromComponents:weekdayComponents];
        
        NSLog(@"weekFirst=%@",[formatter stringFromDate:weekFirst]);
        
        [weekdayComponents setWeekday:7];
        
         NSDate *weekLast=[calender dateFromComponents:weekdayComponents];
        
          NSLog(@"weekLast=%@",[formatter stringFromDate:weekLast]);
        
        
        NSDate *weekFirstFirst=[self dateFromSD:weekFirst];
        NSDate *weekLastLast=[self dateFromSDLast:weekLast];
        /////////////////
        
        ////////////////
        self.callistvc.fetchedResultsController=nil;
        self.callistvc.todayIndexpath=nil;
        self.callistvc.todayFDate=[self dateFromSD:currdate ];
        self.callistvc.fetchFirstDate=weekFirstFirst;
        self.callistvc.fetchLastDate=weekLastLast;
          self.callistvc.isAscendingDate=isAscendingDate;
        [self.callistvc.tabView reloadData];
        if(self.callistvc.fetchedResultsController.fetchedObjects.count>0)
        {
            [self.callistvc.tabView scrollToRowAtIndexPath:self.callistvc.todayIndexpath
                                          atScrollPosition:UITableViewScrollPositionTop
                                                  animated:YES];
            self.callistvc.tabView.hidden=NO;
            self.callistvc.noeventslab.hidden=YES;
            self.callistvc.lblPlus.hidden=YES;
            self.callistvc.noeventsfilterlab.hidden=YES;
              self.callistvc.allfilterbt.hidden=YES;
             self.callistvc.noeventsimagevw.hidden=YES;
        }
        else
        {
            self.callistvc.tabView.hidden=YES;
             self.callistvc.noeventsimagevw.hidden=NO;
            if(self.callistvc.fetchFirstDate==nil && self.callistvc.fetchLastDate==nil && self.callistvc.selTeamId==nil && self.callistvc.selplayerId==nil && self.callistvc.isSelShowByStatus==0)
            {
                self.callistvc.noeventslab.hidden=NO;
                self.callistvc.lblPlus.hidden=NO;
                self.callistvc.noeventsfilterlab.hidden=YES;
                  self.callistvc.allfilterbt.hidden=YES;
            }
            else
            {
                self.callistvc.noeventslab.hidden=YES;
                self.callistvc.lblPlus.hidden=YES;
                self.callistvc.noeventsfilterlab.hidden=NO;
                  self.callistvc.allfilterbt.hidden=NO;
            }
        }

        
        
    //}
    
    }
    else if(buttonIndex==2)
    {
         self.evpopVC.datelab.font=self.helveticaFontForteBold;
        
        NSDate *currdate=[[NSDate alloc] init];
        
        self.callistvc.fetchedResultsController=nil;
        self.callistvc.todayIndexpath=nil;
        self.callistvc.todayFDate=[self dateFromSD:currdate ];
        self.callistvc.fetchFirstDate=nil;
        self.callistvc.fetchLastDate=nil;
          self.callistvc.isAscendingDate=isAscendingDate;
        [self.callistvc.tabView reloadData];
        if(self.callistvc.fetchedResultsController.fetchedObjects.count>0)
        {
            [self.callistvc.tabView scrollToRowAtIndexPath:self.callistvc.todayIndexpath
                                          atScrollPosition:UITableViewScrollPositionTop
                                                  animated:YES];
            self.callistvc.tabView.hidden=NO;
            self.callistvc.noeventslab.hidden=YES;
            self.callistvc.lblPlus.hidden=YES;
            self.callistvc.noeventsfilterlab.hidden=YES;
              self.callistvc.allfilterbt.hidden=YES;
             self.callistvc.noeventsimagevw.hidden=YES;
        }
        else
        {
            self.callistvc.tabView.hidden=YES;
             self.callistvc.noeventsimagevw.hidden=NO;
            if(self.callistvc.fetchFirstDate==nil && self.callistvc.fetchLastDate==nil && self.callistvc.selTeamId==nil && self.callistvc.selplayerId==nil && self.callistvc.isSelShowByStatus==0)
            {
                self.callistvc.noeventslab.hidden=NO;
                self.callistvc.lblPlus.hidden=NO;
                self.callistvc.noeventsfilterlab.hidden=YES;
                  self.callistvc.allfilterbt.hidden=YES;
            }
            else
            {
                self.callistvc.noeventslab.hidden=YES;
                self.callistvc.lblPlus.hidden=YES;
                self.callistvc.noeventsfilterlab.hidden=NO;
                  self.callistvc.allfilterbt.hidden=NO;
            }
        }
        

        
        
        
    }
    
    //// AD...iAd
    self.callistvc.adBanner.delegate = self;
    self.callistvc.adBanner.alpha = 0.0;
    self.callistvc.canDisplayBannerAds=YES;
    ////

}

-(void)showTeam
{
    if(arrPickerItems5 && arrPickerItems5.count>0)
    {
        
        self.pickercontainer.hidden=NO;
        self.picker.hidden=NO;
        self.dpicker.hidden=YES;
          [self.view bringSubviewToFront:self.top];
        [self.view bringSubviewToFront:self.pickercontainer];
      
        self.top.hidden=NO;
        buttonMode=0;
        
        
        
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


-(void)changedVales:(NSArray*)arrPlayerName :(NSArray*)arrPlayerId
{
    self.arrPickerItems6=arrPlayerName;
    self.arrPickerItems7=arrPlayerId;
}



-(void)showPlayer
{
    if(arrPickerItems6 && arrPickerItems6.count>0)
    {
        
        self.pickercontainer.hidden=NO;
        self.picker.hidden=NO;
        self.dpicker.hidden=YES;
        [self.view bringSubviewToFront:self.top];
        [self.view bringSubviewToFront:self.pickercontainer];
        
        self.top.hidden=NO;
        buttonMode=2;
        
        
        
        [self.picker reloadAllComponents];
        [self.picker selectRow:self.selectedRow1 inComponent:0 animated:NO];
    }
    else
    {
        
        
        [self showAlertMessage:@"No Player Found."];
        //   change         [self showHudView:@"Fetching Team Listing..."];
        //            [self getTaemListing];
        
        
    }
}



-(void)showByStatus
{
    
   /* if(arrPickerItems6 && arrPickerItems6.count>0)
    {*/
        
        self.pickercontainer.hidden=NO;
        self.picker.hidden=NO;
        self.dpicker.hidden=YES;
        [self.view bringSubviewToFront:self.top];
        [self.view bringSubviewToFront:self.pickercontainer];
        
        self.top.hidden=NO;
        buttonMode=3;
        
        
        
        [self.picker reloadAllComponents];
        [self.picker selectRow:self.selectedRow2 inComponent:0 animated:NO];
    /*}
    else
    {
        
        
        [self showAlertMessage:@"No Player Found."];
        //   change         [self showHudView:@"Fetching Team Listing..."];
        //            [self getTaemListing];
        
        
    }*/
    
    
    
    
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
    
    
   
        if(buttonMode==0)
        return self.arrPickerItems5.count;
        else if(buttonMode==2)
        return self.arrPickerItems6.count;
        else
            return self.arrPickerItems8.count;
    
}
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    NSLog(@"Row=%i",row);
    if(buttonMode==0)
    return [[self.arrPickerItems5 objectAtIndex:row] objectForKey:@"team_name"];
      else if(buttonMode==2)
      return [self.arrPickerItems6 objectAtIndex:row] ;
      else 
          return [self.arrPickerItems8 objectAtIndex:row] ;
    
    
       // return [self.arrPickerItems5 objectAtIndex:row];
    
}


-(void)getTaemListing
{
   // [self hideHudView];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    NSDictionary *command=  [NSDictionary dictionaryWithObjectsAndKeys:[appDelegate.aDef objectForKey:LoggedUserID],@"coach_id", nil];
    NSString *jsonCommand = [writer stringWithObject:command];
    
    NSLog(@"RequestParamJSON=%@=====%@",jsonCommand,command);
    
    SingleRequest *sinReq=[[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:TEAM_LISTING_LINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
       self.sinReq2=sinReq;
    [self.storeCreatedRequests addObject:self.sinReq2];
    sinReq.notificationName=TEAM_LISTING;
    
    [sinReq startRequest];
    
 
    
}


-(void)totalTeamListUpdated:(id)sender
{
    
  HomeVC *hvc=(HomeVC*)[sender object];
    
    NSMutableArray *marr=[[NSMutableArray alloc] init];
    
    self.arrPickerItems5=marr;

    
    NSDictionary *dicv=nil;
    /*dicv=[[NSDictionary alloc] initWithObjectsAndKeys:@"Private",@"team_name", @"Private",@"team_id",nil ];
    
    [arrPickerItems5 insertObject:dicv atIndex:0 ];*/
    BOOL fl=0;
    for(int i=0;i<hvc.dataArrayUpButtons.count;i++)
    {
        dicv=[[NSDictionary alloc] initWithObjectsAndKeys:[hvc.dataArrayUpButtons objectAtIndex:i],@"team_name", [hvc.dataArrayUpButtonsIds objectAtIndex:i],@"team_id",nil ];
        
        [arrPickerItems5 addObject:dicv];
        
        if([[hvc.dataArrayUpIsCreated objectAtIndex:i] boolValue])
        {
            fl=1;
           
        }
        
    }
    
    if(fl==1)
    {
        isExistOwnTeam=1;
    }
    else
    {
        isExistOwnTeam=0;
    }
    
    [self setRightBarButton];
    
    [self.callistvc manageViewMessage:isExistOwnTeam];
    
    if(arrPickerItems5.count>1)
    {
        dicv=[[NSDictionary alloc] initWithObjectsAndKeys:@"All Teams",@"team_name", @"All Teams",@"team_id",nil ];
        
      //  [arrPickerItems5 insertObject:dicv atIndex:1 ];
        [arrPickerItems5 addObject:dicv ];
  
        
    }
    
}


-(void)teamListUpdated:(id)sender
{
    [self hideHudView];
    
    SingleRequest *sReq=(SingleRequest*)[sender object];
    
    
    if([sReq.notificationName isEqualToString:TEAM_LISTING])
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
                        
                        
                        NSDictionary *aDic1=[aDict objectForKey:@"response"];
                        
                        self.arrPickerItems5=[NSMutableArray arrayWithArray: [aDic1 objectForKey:@"team_list"]];
                      /*for(NSDictionary *dic in  [aDic1 objectForKey:@"team_list"])
                      {
                     
                        [arrPickerItems5 addObject:[dic objectForKey:@"team_name"]];
                        
                        
                      }*/
                        
                     
                        
                        
                        NSDictionary *dicv=nil;
                       /* dicv=[[NSDictionary alloc] initWithObjectsAndKeys:@"Private",@"team_name", @"Private",@"team_id",nil ];
                        
                        [arrPickerItems5 insertObject:dicv atIndex:0 ];*/
                        if(arrPickerItems5.count>1)
                        {
                            dicv=[NSDictionary dictionaryWithObjectsAndKeys:@"All Teams",@"team_name", @"All Teams",@"team_id",nil ];
                              [arrPickerItems5 addObject:dicv ];
                            
                        //[arrPickerItems5 insertObject:[NSDictionary dictionaryWithObjectsAndKeys:@"All Teams",@"team_name", @"All Teams",@"team_id",nil ] atIndex:1 ];
                        }
                    }
                    else
                    {
                        NSString *message=CONNFAILMSG;
                        [self showHudAlert:message];
                        [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
                    }
                    
                }
                
            }
            
        }
        else
        {
        NSString *message=CONNFAILMSG;
        [self showHudAlert:message];
        [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
        }
    }
}

-(void)hideHudViewHere
{
    [self hideHudView];
    
    
}


-(void)didSelectString:(NSString*)msg :(NSString*)msg1 :(FPPopoverController*)popOverController
{
    NSLog(@"SelectTeam=%@,SelectTeamId=%@",msg1,msg);
    [popOverController dismissPopoverAnimated:YES];
    
    if([msg1 isEqualToString:@"All Teams"])
    {
        msg=nil;
    }
    self.calvc.selTeamId=msg;
    [self.calvc.monthView reloadData];
    
    NSDate *currdate=[[NSDate alloc] init];
    [self.calvc.monthView selectDate:currdate];
    
    self.callistvc.selTeamId=msg;
    self.callistvc.fetchedResultsController=nil;
    self.callistvc.todayIndexpath=nil;
    self.callistvc.todayFDate=[self dateFromSD:currdate ];
    
    [self.callistvc.tabView reloadData];
    if(self.callistvc.fetchedResultsController.fetchedObjects.count>0)
    {
        [self.callistvc.tabView scrollToRowAtIndexPath:self.callistvc.todayIndexpath
                            atScrollPosition:UITableViewScrollPositionTop
                                    animated:YES];
        self.callistvc.tabView.hidden=NO;
        self.callistvc.noeventslab.hidden=YES;
        self.callistvc.lblPlus.hidden=YES;
        self.callistvc.noeventsfilterlab.hidden=YES;
          self.callistvc.allfilterbt.hidden=YES;
         self.callistvc.noeventsimagevw.hidden=YES;
    }
    else
    {
        self.callistvc.tabView.hidden=YES;
         self.callistvc.noeventsimagevw.hidden=NO;
        if(self.callistvc.fetchFirstDate==nil && self.callistvc.fetchLastDate==nil && self.callistvc.selTeamId==nil && self.callistvc.selplayerId==nil && self.callistvc.isSelShowByStatus==0)
        {
            self.callistvc.noeventslab.hidden=NO;
            self.callistvc.lblPlus.hidden=NO;
            self.callistvc.noeventsfilterlab.hidden=YES;
              self.callistvc.allfilterbt.hidden=YES;
        }
        else
        {
            self.callistvc.noeventslab.hidden=YES;
            self.callistvc.lblPlus.hidden=YES;
            self.callistvc.noeventsfilterlab.hidden=NO;
              self.callistvc.allfilterbt.hidden=NO;
        }
    }
    
    //// AD...iAd
    self.callistvc.adBanner.delegate = self;
    self.callistvc.adBanner.alpha = 0.0;
    self.callistvc.canDisplayBannerAds=YES;
    ////
}


- (IBAction)segTapped:(UISegmentedControl*)sender
{
    
    if(sender.selectedSegmentIndex==0)
    {
        self.callistvc.todayIndexpath=nil;
        self.callistvc.todayFDate=[self dateFromSD:[NSDate date] ];
        [self.callistvc.tabView reloadData];
        [self.callistvc.tabView scrollToRowAtIndexPath:self.callistvc.todayIndexpath
                                      atScrollPosition:UITableViewScrollPositionTop
                                              animated:YES];
        
        [self.calvc.monthView selectDate:[NSDate date]];
        //// AD...iAd
        self.callistvc.adBanner.delegate = self;
        self.callistvc.adBanner.alpha = 0.0;
        self.callistvc.canDisplayBannerAds=YES;
        ////
        
    }
    else
    {
          self.eventheaderlab.text=UPCOMINGTEAMEVENTS;
        isMonth=1;
        [self setLeftBarButton];
        self.calvc.view.hidden=NO;
        self.callistvc.view.hidden=YES;
        
        self.downarrowfilterimavw.hidden=YES;
        self.downarrowfilterbt.hidden=YES;
    }
   
}


- (IBAction)actionMonth:(id)sender
{
    
    if([sender tag]==0)
    {
     //   self.callistvc.todayIndexpath=nil;
        self.callistvc.todayFDate=[self dateFromSD:[NSDate date] ];
        [self.callistvc.tabView reloadData];
        
        NSLog(@"actionMonthTodayIndexPath=%@",self.callistvc.todayIndexpath);
        
        [self.callistvc.tabView scrollToRowAtIndexPath:self.callistvc.todayIndexpath
                                      atScrollPosition:UITableViewScrollPositionTop
                                              animated:YES];
        
        [self.calvc.monthView selectDate:[NSDate date]];
        
    }
    else
    {
        ////Move Bottom
        
        
        ////
         
    }

    self.eventheaderlab.text=UPCOMINGTEAMEVENTS;
    isMonth=1;
     [self setLeftBarButton];
     self.topSegCntrl.selectedSegmentIndex=isMonth;
    self.calvc.view.hidden=NO;
    self.callistvc.view.hidden=YES;
    
    self.downarrowfilterimavw.hidden=YES;
    self.downarrowfilterbt.hidden=YES;
}
- (IBAction)firstAction:(id)sender
{
    
    int tag=[sender tag];
    [self showFirstEnterView:0];
    if(tag==0)
    {
        /*EventEditViewController *eVc=[[EventEditViewController alloc] initWithNibName:@"EventEditViewController_Private" bundle:nil];
        eVc.mode=0;
        eVc.defaultDate=self.currentSelectedDate;
        [self.navigationController pushViewController:eVc animated:YES];*/
         [self showAlertMessage:@"Private Event is not allowed"];
    }
    else if(tag==1)
    {
        self.eventheaderlab.text=CREATETEAMEVENTINVITATION;
        isMonth=0;
         [self setLeftBarButton];
        self.topSegCntrl.selectedSegmentIndex=isMonth;
        [self.callistvc loadTable];
        self.calvc.view.hidden=YES;
        self.callistvc.view.hidden=NO;
        self.downarrowfilterimavw.hidden=NO;
        self.downarrowfilterbt.hidden=NO;
    }
    else if(tag==2)
    {
        self.eventheaderlab.text=UPCOMINGTEAMEVENTS;
        isMonth=1;
         [self setLeftBarButton];
         self.topSegCntrl.selectedSegmentIndex=isMonth;
        self.calvc.view.hidden=NO;
        self.callistvc.view.hidden=YES;
        self.downarrowfilterimavw.hidden=YES;
        self.downarrowfilterbt.hidden=YES;
    }
   

    
}



- (IBAction)picerAction:(id)sender
{
    self.pickercontainer.hidden=YES;
    self.top.hidden=YES;
    
    
    int tag=[sender tag];
    
       NSDate *currdate=[[NSDate alloc] init];
    if(buttonMode==0)
    {
        
        if(tag==2)
        {
            self.evpopVC.teamandeventlab.font=self.helveticaFontForteBold;
            
            self.selectedRow=self.currentrow;
            NSString *msg=  [[self.arrPickerItems5 objectAtIndex:self.selectedRow] objectForKey:@"team_id"];
            
            NSString *msg1=    [[self.arrPickerItems5 objectAtIndex:self.selectedRow] objectForKey:@"team_name"];
            
            
            NSLog(@"SelectTeam=%@,SelectTeamId=%@",msg1,msg);
            
            
            if([msg1 isEqualToString:@"All Teams"])
            {
                msg=nil;
            }
            self.calvc.selTeamId=msg;
            [self.calvc.monthView reloadData];
            
            
            [self.calvc.monthView selectDate:currdate];
            
            
            
            ///////////////////////////////////////////////////////////////////////////////////
            
            self.callistvc.selTeamId=msg;
            self.callistvc.fetchedResultsController=nil;
            self.callistvc.todayIndexpath=nil;
            self.callistvc.todayFDate=[self dateFromSD:currdate ];
            
            [self.callistvc.tabView reloadData];
            if(self.callistvc.fetchedResultsController.fetchedObjects.count>0)
            {
                [self.callistvc.tabView scrollToRowAtIndexPath:self.callistvc.todayIndexpath
                                              atScrollPosition:UITableViewScrollPositionTop
                                                      animated:YES];
                self.callistvc.tabView.hidden=NO;
                self.callistvc.noeventslab.hidden=YES;
                self.callistvc.lblPlus.hidden=YES;
                self.callistvc.noeventsfilterlab.hidden=YES;
                self.callistvc.allfilterbt.hidden=YES;
                self.callistvc.noeventsimagevw.hidden=YES;
            }
            else
            {
                self.callistvc.tabView.hidden=YES;
                self.callistvc.noeventsimagevw.hidden=NO;
                
                
                if(self.callistvc.fetchFirstDate==nil && self.callistvc.fetchLastDate==nil && self.callistvc.selTeamId==nil && self.callistvc.selplayerId==nil && self.callistvc.isSelShowByStatus==0)
                {
                    self.callistvc.noeventslab.hidden=NO;
                    self.callistvc.lblPlus.hidden=NO;
                    self.callistvc.noeventsfilterlab.hidden=YES;
                    self.callistvc.allfilterbt.hidden=YES;
                }
                else
                {
                    self.callistvc.noeventslab.hidden=YES;
                    self.callistvc.lblPlus.hidden=YES;
                    self.callistvc.noeventsfilterlab.hidden=NO;
                    self.callistvc.allfilterbt.hidden=NO;
                }
                
            }
            
        }

    }
    else if(buttonMode==1)
    {
        
        if(tag==2)
        {
            
              self.evpopVC.datelab.font=self.helveticaFontForteBold;
        self.selectedDate=self.dpicker.date;
        
        
        NSDate *weekFirstFirst=[self dateFromSD:self.selectedDate];
        NSDate *weekLastLast=[self dateFromSDLast:self.selectedDate];
        
        
        self.callistvc.fetchedResultsController=nil;
        self.callistvc.todayIndexpath=nil;
        self.callistvc.todayFDate=[self dateFromSD:currdate ];
        self.callistvc.fetchFirstDate=weekFirstFirst;
        self.callistvc.fetchLastDate=weekLastLast;
        self.callistvc.isAscendingDate=isAscendingDate;
            
            
            
            
        [self.callistvc.tabView reloadData];
        if(self.callistvc.fetchedResultsController.fetchedObjects.count>0)
        {
            [self.callistvc.tabView scrollToRowAtIndexPath:self.callistvc.todayIndexpath
                                          atScrollPosition:UITableViewScrollPositionTop
                                                  animated:YES];
            self.callistvc.tabView.hidden=NO;
            self.callistvc.noeventslab.hidden=YES;
            self.callistvc.lblPlus.hidden=YES;
            self.callistvc.noeventsfilterlab.hidden=YES;
            self.callistvc.allfilterbt.hidden=YES;
             self.callistvc.noeventsimagevw.hidden=YES;
        }
        else
        {
            self.callistvc.tabView.hidden=YES;
             self.callistvc.noeventsimagevw.hidden=NO;
            
            if(self.callistvc.fetchFirstDate==nil && self.callistvc.fetchLastDate==nil && self.callistvc.selTeamId==nil && self.callistvc.selplayerId==nil && self.callistvc.isSelShowByStatus==0)
            {
                self.callistvc.noeventslab.hidden=NO;
                self.callistvc.lblPlus.hidden=NO;
                self.callistvc.noeventsfilterlab.hidden=YES;
                  self.callistvc.allfilterbt.hidden=YES;
            }
            else
            {
                self.callistvc.noeventslab.hidden=YES;
                self.callistvc.lblPlus.hidden=YES;
                self.callistvc.noeventsfilterlab.hidden=NO;
                  self.callistvc.allfilterbt.hidden=NO;
            }
        }

        }
    }
    else if(buttonMode==2)
    {
    
        if(tag==2)
        {
            self.evpopVC.playerlab.font=self.helveticaFontForteBold;
            self.selectedRow1=self.currentrow;
            
           // NSString *msg=  [self.arrPickerItems6 objectAtIndex:self.selectedRow1] ;
            NSString *msg1=  [self.arrPickerItems7 objectAtIndex:self.selectedRow1] ;
            
            
            self.calvc.selplayerId=msg1;
            [self.calvc.monthView reloadData];
            
            
            [self.calvc.monthView selectDate:currdate];

            
      
        self.callistvc.selplayerId=msg1;
        self.callistvc.fetchedResultsController=nil;
        self.callistvc.todayIndexpath=nil;
        self.callistvc.todayFDate=[self dateFromSD:currdate ];
        
        [self.callistvc.tabView reloadData];
        if(self.callistvc.fetchedResultsController.fetchedObjects.count>0)
        {
            [self.callistvc.tabView scrollToRowAtIndexPath:self.callistvc.todayIndexpath
                                          atScrollPosition:UITableViewScrollPositionTop
                                                  animated:YES];
            self.callistvc.tabView.hidden=NO;
            self.callistvc.noeventslab.hidden=YES;
            self.callistvc.lblPlus.hidden=YES;
            self.callistvc.noeventsfilterlab.hidden=YES;
              self.callistvc.allfilterbt.hidden=YES;
             self.callistvc.noeventsimagevw.hidden=YES;
        }
        else
        {
            self.callistvc.tabView.hidden=YES;
             self.callistvc.noeventsimagevw.hidden=NO;
            if(self.callistvc.fetchFirstDate==nil && self.callistvc.fetchLastDate==nil && self.callistvc.selTeamId==nil && self.callistvc.selplayerId==nil && self.callistvc.isSelShowByStatus==0)
            {
                self.callistvc.noeventslab.hidden=NO;
                self.callistvc.lblPlus.hidden=NO;
                self.callistvc.noeventsfilterlab.hidden=YES;
                  self.callistvc.allfilterbt.hidden=YES;
            }
            else
            {
                self.callistvc.noeventslab.hidden=YES;
                self.callistvc.lblPlus.hidden=YES;
                self.callistvc.noeventsfilterlab.hidden=NO;
                  self.callistvc.allfilterbt.hidden=NO;
            }
        }
        
        
        }

        
        
        
    }
    else if(buttonMode==3)
    {
        
        if(tag==2)
        {
    
             self.evpopVC.statuslab.font=self.helveticaFontForteBold;
            
            self.selectedRow2=self.currentrow;
            NSString *msg1=  [self.arrPickerItems8 objectAtIndex:self.selectedRow2] ;
            
            int showstatus=0;
            
            if([msg1 isEqualToString:NORSVP] )
                showstatus=1;
            else if([msg1 isEqualToString:@"Not Going"])
                showstatus=2;
            else if([msg1 isEqualToString:MAYBE])
                showstatus=3;
            
            
            
            self.calvc.isSelShowByStatus=1;
            self.calvc.selShowByStatus=showstatus;
            [self.calvc.monthView reloadData];
            
            
            [self.calvc.monthView selectDate:currdate];
            
            
            self.callistvc.isSelShowByStatus=1;
            self.callistvc.selShowByStatus=showstatus;
            self.callistvc.fetchedResultsController=nil;
            self.callistvc.todayIndexpath=nil;
            self.callistvc.todayFDate=[self dateFromSD:currdate ];
            
            [self.callistvc.tabView reloadData];
            if(self.callistvc.fetchedResultsController.fetchedObjects.count>0)
            {
                [self.callistvc.tabView scrollToRowAtIndexPath:self.callistvc.todayIndexpath
                                              atScrollPosition:UITableViewScrollPositionTop
                                                      animated:YES];
                self.callistvc.tabView.hidden=NO;
                self.callistvc.noeventslab.hidden=YES;
                self.callistvc.lblPlus.hidden=YES;
                self.callistvc.noeventsfilterlab.hidden=YES;
                  self.callistvc.allfilterbt.hidden=YES;
                 self.callistvc.noeventsimagevw.hidden=YES;
            }
            else
            {
                self.callistvc.tabView.hidden=YES;
                 self.callistvc.noeventsimagevw.hidden=NO;
                if(self.callistvc.fetchFirstDate==nil && self.callistvc.fetchLastDate==nil && self.callistvc.selTeamId==nil && self.callistvc.selplayerId==nil && self.callistvc.isSelShowByStatus==0)
                {
                    self.callistvc.noeventslab.hidden=NO;
                    self.callistvc.lblPlus.hidden=NO;
                    self.callistvc.noeventsfilterlab.hidden=YES;
                      self.callistvc.allfilterbt.hidden=YES;
                }
                else
                {
                    self.callistvc.noeventslab.hidden=YES;
                    self.callistvc.lblPlus.hidden=YES;
                    self.callistvc.noeventsfilterlab.hidden=NO;
                      self.callistvc.allfilterbt.hidden=NO;
                }
            }
            
            
        }

            
            
    
        
    }
    
    //// AD...iAd
    self.callistvc.adBanner.delegate = self;
    self.callistvc.adBanner.alpha = 0.0;
    self.callistvc.canDisplayBannerAds=YES;
    ////

    
}

- (IBAction)backAction:(id)sender
{
    
    [self.appDelegate.centerViewController showNavController:appDelegate.navigationControllerTeamMaintenance];
    
    TeamMaintenanceVC *tmVC=  (TeamMaintenanceVC*) [appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0];
    
    [tmVC.teamNavController popToRootViewControllerAnimated:NO];
}


- (IBAction)topSelectionAdminAction:(id)sender
{
    int tag=[sender tag];
    
    if(tag==0)
    {
        TeamEventsVC *teVC= (TeamEventsVC*)[appDelegate.navigationControllerTeamEvents.viewControllers objectAtIndex:0];
        
        [teVC createEvent];
        
          [self.appDelegate.centerViewController showNavController:appDelegate.navigationControllerTeamEvents];
        
       
        
        
    }
    else if(tag==1)
    {
        
    }
    else if(tag==2)
    {
          [self.appDelegate.centerViewController showNavController:appDelegate.navigationControllerTeamMaintenance];
        SaveTeamViewController *teamView=[[SaveTeamViewController alloc]initWithNibName:@"SaveTeamViewController" bundle:nil];
        teamView.itemno=self.selectedTeamIndex;
        teamView.editMode=YES;
        teamView.isInvite=1;
        teamView.selectedTeamIndex=self.selectedTeamIndex;
        teamView.isTeamView=NO;
        
        TeamMaintenanceVC *tmVC=(TeamMaintenanceVC*)[appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0];
        
        
        [tmVC.teamNavController pushViewController:teamView animated:NO];
    }
}


- (IBAction)dropDownBtAction:(id)sender
{
    /*EventFilterPopOverViewController *controller=nil;
    
    if(!self.evpopVC)
    {
    controller = [[EventFilterPopOverViewController alloc] initWithNibName:@"EventFilterPopOverViewController" bundle:nil];
    self.evpopVC=controller;
    }
    else
    {
        controller=self.evpopVC;
    }
    
   
    controller.delegate=self;
   
    FPPopoverController *popover = [[FPPopoverController alloc] initWithViewController:controller];
    
    controller.popOver=popover;
    
     popover.contentSize = CGSizeMake(170,160);
    popover.tint=FPPopoverLightGrayTint;
    
    
    
    if(isFromTeamAdmin)
         [popover presentPopoverFromView:self.downarrowimavw];
        else
    [popover presentPopoverFromView:self.downarrowfilterimavw];
    
    */
    
    
    if(self.custompopupbottomvw.hidden==YES && self.custompopuptopselectionvw.hidden==YES)
    {
    self.custompopupbottomvw.hidden=NO;
    self.custompopuptopselectionvw.hidden=NO;
    
    [self.view bringSubviewToFront:self.custompopupbottomvw];
    [self.view bringSubviewToFront:self.custompopuptopselectionvw];
        
        self.pickercontainer.hidden=YES;
        self.top.hidden=YES;
    }
    else
    {
        ///// AD 11th june
        appDelegate.centerViewController.navigationItem.rightBarButtonItem=self.rightBarButtonItem;
        //////

        self.custompopupbottomvw.hidden=YES;
        self.custompopuptopselectionvw.hidden=YES;
    }
    
    

    
    
    
}
- (IBAction)custompopupbTapped:(id)sender
{
    ///// AD 11th june
    appDelegate.centerViewController.navigationItem.rightBarButtonItem=self.rightBarButtonItem;
    //////
    
    self.currentrow = 0;
    int filterNum=[sender tag];
    
    if(filterNum==0)
    {
        isAscendingDate=1;
        [self showDate];
    }
    else if(filterNum==1)
    {
        isAscendingDate=0;
        [self showDate];
    }
    else if(filterNum==2)
    {
        [self showPlayer];
        
    }
    else if(filterNum==3)
    {
        [self showByStatus];
       
    }
    else if(filterNum==4)
    {
        
        [self showTeam];
    }
    else if(filterNum==5)
    {
        
        [self.callistvc allFilterAction:self.callistvc.allfilterbt];
    }
    
    
    [self hideCustomPopupTapped:nil];
}

- (IBAction)hideCustomPopupTapped:(id)sender
{
    ///// AD 11th june
    appDelegate.centerViewController.navigationItem.rightBarButtonItem=self.rightBarButtonItem;
    //////
    
    self.custompopupbottomvw.hidden=YES;
    self.custompopuptopselectionvw.hidden=YES;
}


-(void)didSelectFilterAction:(int)filterNum :(FPPopoverController*)popOverController
{
     [popOverController dismissPopoverAnimated:YES];
    
    if(filterNum==1)
    {
       
        [self showDate];
    }
    else if(filterNum==2)
    {
       
        [self showTeam];
    }
    else if(filterNum==3)
    {
        
        [self showPlayer];
    }
    else if(filterNum==4)
    {
       
        [self showByStatus];
    }
   


}





- (IBAction)topSegTapped:(id)sender
{
    UISegmentedControl *sender1=(UISegmentedControl*)sender;
    
    if(sender1.selectedSegmentIndex==0)
    {
       // self.viewAddEvent.hidden=NO;
        self.lblUserEmail.hidden=YES;
        // self.segmentbottom.selectedSegmentIndex=0;
        self.evpopVC.datelab.font=self.helveticaFont;
        self.evpopVC.teamandeventlab.font=self.helveticaFont;
        self.evpopVC.playerlab.font=self.helveticaFont;
        self.evpopVC.statuslab.font=self.helveticaFont;
        
        
        
        
        self.eventheaderlab.text=CREATETEAMEVENTINVITATION;
        isMonth=0;
         [self setLeftBarButton];
        self.callistvc.fetchFirstDate=nil;
        self.callistvc.fetchLastDate=nil;
        self.callistvc.selTeamId=nil;
        self.callistvc.selplayerId=nil;
        self.callistvc.selShowByStatus=0;
        self.callistvc.isSelShowByStatus=0;
        self.callistvc.fetchedResultsController=nil;
        [self.callistvc loadTable];
        self.calvc.view.hidden=YES;
        self.callistvc.view.hidden=NO;
        isAscendingDate=1;
        self.downarrowfilterimavw.hidden=NO;
        self.downarrowfilterbt.hidden=NO;
        
        [self.calvc.monthView reloadData];
        
    }
    else
    {
        
        //self.viewAddEvent.hidden=YES;
        //self.lblUserEmail.hidden=NO;
        self.lblUserEmail.hidden=YES;
        [self.calvc.monthView selectDate:[NSDate date]];
        self.eventheaderlab.text=UPCOMINGTEAMEVENTS;
        isMonth=1;
         [self setLeftBarButton];
        self.topSegCntrl.selectedSegmentIndex=isMonth;
        self.calvc.view.hidden=NO;
        self.callistvc.view.hidden=YES;
        
        self.downarrowfilterimavw.hidden=YES;
        self.downarrowfilterbt.hidden=YES;
    }
}
@end
