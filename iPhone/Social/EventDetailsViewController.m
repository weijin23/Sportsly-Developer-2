//
//  EventDetailsViewController.m
//  Social
//
//  Created by Sukhamoy Hazra on 09/09/13.
//
//
#import "HomeVC.h"
#import "MapViewController.h"
#import "ToDoByEventsVC.h"
#import "EventCalendarViewController.h"
#import "CenterViewController.h"
#import "PlayerListViewController.h"
#import "EventEditViewController.h"
#import "EventDetailsViewController.h"
#import "MapViewVC.h"
@interface EventDetailsViewController ()

@end

@implementation EventDetailsViewController
@synthesize dataEvent,isFromPush,playername,playeruserid,playerid,isShowAccept,isGesturePositive,isShowDelete,evUnreadevent,evStatusVC,isTeamAccept;
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
    
    
    /////////////Add Later Ch
    isShowDelete=0;
    self.tapGesture=[[UITapGestureRecognizer alloc] init];
    self.tapGesture.numberOfTapsRequired=1;
    [self.tapGesture addTarget:self action:@selector(gestureTapped:)];
    [self.mainview addGestureRecognizer:self.tapGesture];
    /////////////
    self.statusimavw.hidden=YES;
    self.view8.hidden=YES;//Add Later Ch
    self.view5.hidden=YES;
    self.view6.hidden=YES;
    self.view7.hidden=YES;//Add Later Ch
//    [self.view.layer setCornerRadius:8.0f];
//    [self.view1.layer setMasksToBounds:YES];
    
   /* self.view.backgroundColor=appDelegate.backgroundPinkColor;
    self.topview.backgroundColor=appDelegate.barGrayColor;
    
    
    self.mainview.layer.cornerRadius=8.0;
    self.view1.layer.cornerRadius=8.0;*/

    if(!isFromPush)
    {
       
        
        
        if(dataEvent.isPublicAccept.intValue==1)
        {
            self.isShowAccept=1;
            
            if(self.isTeamAccept)
            {
            self.acceptb.hidden=NO;
            self.declineb.hidden=NO;
            self.maybebtn.hidden=NO;
                self.attendingvw.hidden=NO;
                self.notattendingvw.hidden=NO;
                self.maybevw.hidden=NO;
            }
         /* UIButton *bt= (UIButton*) [self.view1 viewWithTag:1];
            bt.hidden=YES;*///Add Latest Ch
            isShowDelete=0;
        }
        else
        {
            if(!dataEvent.isPublic.boolValue)
            {
                isShowDelete=1;
            }
        }
        
         [self populateDataField];
        
    
    }
    else
    {
       /* UIButton *canb=(UIButton*)  [self.topview viewWithTag:1];
        [canb setTitle:@"Back" forState:UIControlStateNormal];*///Add Latest Ch
        
      UIButton *  canb=(UIButton*)  [self.topview viewWithTag:2];
        canb.enabled=NO;
        
        self.scrollView.hidden=YES;
        
        
        NSMutableDictionary *command = [NSMutableDictionary dictionary];
       [command setObject:self.eventId forKey:@"event_id"];
        
        [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
        
        SBJsonWriter *writer = [[SBJsonWriter alloc] init];
        
        
        NSString *jsonCommand = [writer stringWithObject:command];
        
        
        [self showHudView:@"Getting Event Details..."];
        [self showNativeHudView];
        NSLog(@"RequestParamJSON=%@",jsonCommand);
        
        
        [appDelegate sendRequestFor:EVENTDETAILS from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
    

    }
    //_lblCoachEmail.text=[appDelegate.aDef objectForKey:EMAIL];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self populateDataField];
    
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
        self.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleRightPanel:)];
    }
    
    
   // appDelegate.centerViewController.navigationItem.title=nil;
    appDelegate.centerViewController.navigationItem.titleView=nil;
    
   // appDelegate.centerViewController.navigationItem.title=@"Players Attending";
    // appDelegate.centerViewController.navigationItem.titleView=nil;
    
    appDelegate.centerViewController.navigationItem.leftBarButtonItem=self.leftBarButtonItem;
    if(self.inviteplayerbtvw.hidden==YES)
        appDelegate.centerViewController.navigationItem.rightBarButtonItem=nil;
    else
        appDelegate.centerViewController.navigationItem.rightBarButtonItem=self.rightBarButtonItem;
    
    
    [self setStatusBarStyleOwnApp:1];
    
}


-(void)setTopTextAndRightBarButton:(NSString*)toptext :(BOOL)isShowUpdate
{
    
    if(isShowUpdate)
    {
        if(!self.rightBarButtonItem)
        {
            self.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleRightPanel:)];
        }
        
        appDelegate.centerViewController.navigationItem.rightBarButtonItem=self.rightBarButtonItem;
    }
    else {
        appDelegate.centerViewController.navigationItem.rightBarButtonItem=nil;
    }
    
    NSLog(@"TopText=%@",toptext);
    if(toptext)
        appDelegate.centerViewController.navigationItem.title=toptext;
    else
        appDelegate.centerViewController.navigationItem.title=nil;
}


-(void)toggleLeftPanel:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)toggleRightPanel:(id)sender
{
    ////////  12/03/2015   ////////
   /*
    EventEditViewController *eVc=nil;
    if(dataEvent.isPublic.boolValue)
    {
        eVc= [[EventEditViewController alloc] initWithNibName:@"EventEditViewController" bundle:nil];
        eVc.mode=1;
        
        eVc.isEditMode=1;
        eVc.dataEvent=self.dataEvent;
        
    
        
        self.isModallyPresentFromCenterVC=1;
        [self showModal:eVc];
    }
    else
    {
       
         [self showAlertMessage:@"Private Event is not allowed"];
    }
    */
    ///////////   AD  ////////////
    
    
    UIActionSheet *action=[[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Edit",@"Delete",nil];
    action.tag=1001;
    
    //action.backgroundColor = [UIColor lightGrayColor];
    
    
    [action showInView:self.view];
    
    
    
}



#pragma mark - ActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (actionSheet.tag==1001){
        
        if (buttonIndex==0) {
            
            EventEditViewController *eVc=nil;
            if(dataEvent.isPublic.boolValue)
            {
                eVc= [[EventEditViewController alloc] initWithNibName:@"EventEditViewController" bundle:nil];
                eVc.mode=1;
                
                eVc.isEditMode=1;
                eVc.dataEvent=self.dataEvent;
                
                
                
                self.isModallyPresentFromCenterVC=1;
                [self showModal:eVc];
            }
            else
            {
                
                [self showAlertMessage:@"Private Event is not allowed"];
            }
            
        }
        else if(buttonIndex==1){
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"" message:@"Are you sure want to delete this event?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
            [alertView show];
        }
    }
}



-(void)gestureTapped:(UITapGestureRecognizer*)gesture
{
    UIButton *bt=(UIButton*)[self.view1 viewWithTag:1];
    
    if(!isGesturePositive)
    {
        isGesturePositive=1;
        
        if(isShowDelete)
        {
        bt.hidden=NO;
        }
    }
    else
    {
        isGesturePositive=0;
        
        bt.hidden=YES;
    }
}

-(void)notifyRequesterWithData:(id) aData :(id)aData1
{
    
    [self hideHudView];
    [self hideNativeHudView];
    
    if([aData isKindOfClass:[ConnectionManager class]])
    {
        ConnectionManager *aR=(ConnectionManager*)aData;
        if([aR.requestSingleId isEqualToString:EVENTDETAILS])
        {
            
        }
        else if ([aR.requestSingleId isEqualToString:DELETEEVENT])
        {
            
        }
        else if ([aR.requestSingleId isEqualToString:EVENTINVITESTATUS])
        {
            
        }
        
        return;
    }
    
    
    NSString *str=(NSString*)aData;
    
    NSLog(@"Data=%@",str);
   
    ConnectionManager *aR=(ConnectionManager*)aData1;
    
    if([aR.requestSingleId isEqualToString:EVENTDETAILS ])
    {
    
    
    if (str)
    {
        SBJsonParser *parser=[[SBJsonParser alloc] init];
        
        id res = [parser objectWithString:str];
        if ([res isKindOfClass:[NSDictionary class]])
        {
            NSDictionary* aDict = (NSDictionary*) res;
            // aDict=[aDict objectForKey:@"responseData"];
           // NSString *message=[aDict objectForKey:@"message"];
            
            if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
            {
                self.isShowAccept=1;
                
                if(self.isTeamAccept)
                {
                self.acceptb.hidden=NO;
                self.declineb.hidden=NO;
                 self.maybebtn.hidden=NO;
                    self.attendingvw.hidden=NO;
                    self.notattendingvw.hidden=NO;
                    self.maybevw.hidden=NO;
                }
               /* UIButton *bt= (UIButton*) [self.view1 viewWithTag:1];
                bt.hidden=YES;*///Add Latest Ch
                isShowDelete=0;
               /* UIButton *canb=(UIButton*)  [self.topview viewWithTag:1];
                [canb setTitle:@"" forState:UIControlStateNormal];*///Add Latest Ch
                
              UIButton * canb=(UIButton*)  [self.topview viewWithTag:2];
                canb.enabled=YES;
                
                self.scrollView.hidden=NO;
                
                
              
                NSDictionary *event_details=[[aDict objectForKey:@"response"] objectForKey:@"event_details"];
                
                
                if(self.evUnreadevent){
                //[self.managedObjectContext deleteObject:self.evUnreadevent ];
                    self.evUnreadevent.viewStatus=[[NSNumber alloc] initWithBool:1];
                }
                if(self.evUnreadeventUpdate){
                // [self.managedObjectContext deleteObject:self.evUnreadeventUpdate ];
                    self.evUnreadeventUpdate.viewStatus=[[NSNumber alloc] initWithBool:1];
                    
                }
                [appDelegate saveContext];
                self.evUnreadevent=nil;
                self.evUnreadeventUpdate=nil;
                
                [self saveToMyDatabase:event_details];
                
                [self populateDataField];
            }
            else
            {
                [self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
            }
        }
    }
    
    
    }
    else if ([aR.requestSingleId isEqualToString:DELETEEVENT])
    {
        
        
        if (str)
        {
            SBJsonParser *parser=[[SBJsonParser alloc] init];
            
            id res = [parser objectWithString:str];
            if ([res isKindOfClass:[NSDictionary class]])
            {
                NSDictionary* aDict = (NSDictionary*) res;
                if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
                {
                    
                   
                    
                    EKEvent *newEvent=nil;
                    newEvent= [appDelegate.eventStore eventWithIdentifier:dataEvent.eventIdentifier];
                    
                    NSError *error=nil;
                    BOOL save=  [appDelegate.eventStore removeEvent:newEvent span:EKSpanFutureEvents commit:YES error:&error ];
                    NSLog(@"DeleteEventStatus=%i \n%@",save,error.description);
                    
                    if(save)
                        [self deleteObjectOfTypeEvent:dataEvent];
                    
                    
                    self.isFromPushBadge=0;
                    
                    
                     NSString *message=[aDict objectForKey:@"message"];
                  //  [self showHudAlert:message];  ////AD 1st july
                    [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
                }
                else
                {
                    
                    [self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
                }
            }
        }

        
        
    }
    else if([aR.requestSingleId isEqualToString:EVENTINVITESTATUS])
    {
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
                    
                    self.isShowAccept=0;
                    
 /////
                    if(isTeamAccept)
                    {
                    self.acceptb.hidden=YES;
                    self.declineb.hidden=YES;
                     self.maybebtn.hidden=YES;
                    self.attendingvw.hidden=YES;
                    self.notattendingvw.hidden=YES;
                    self.maybevw.hidden=YES;
                    self.chStatusbtvw.hidden=NO;
                    }
                   /* UIButton *bt= (UIButton*) [self.view1 viewWithTag:1];
                    bt.hidden=NO;*///Add Latest Ch
                    isShowDelete=1;
                    NSString *message=nil;
                    if([[self.requestDic objectForKey:@"Status"] isEqualToString:@"Accept"])
                    {
                        [self saveToDeviceCalendar:dataEvent];
                        
                        message=@"Event Accepted";
                    }
                    else if([[self.requestDic objectForKey:@"Status"] isEqualToString:@"Decline"])
                    {
                      //  [self deleteObjectOfTypeEvent:dataEvent];
                        [self saveToDeviceCalendarForDecline:dataEvent];
                        
                        [self deleteEventFromDeviceCalendar:dataEvent];
                        message=@"Event Declined";
                    }
                    else if([[self.requestDic objectForKey:@"Status"] isEqualToString:@"Maybe"])
                    {
                        //  [self deleteObjectOfTypeEvent:dataEvent];
                       
                        
                        [self saveToDeviceCalendarForMayBe:dataEvent];
                         [self deleteEventFromDeviceCalendar:dataEvent];
                        message=@"Event May Be";
                    }
                    
                      self.isFromPushBadge=1;
                 //   [self showHudAlert:message];  ////AD 1st july
                    [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
                    
                    
                    
                    
                    self.requestDic=nil;
                  /*  [self showHudAlert:[aDict objectForKey:@"message"]];
                    [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];*/
                    
                }
                else
                {
                    [self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
                }
            }
        }
        

    }
    
    
    
    
    
    
    
    
}


-(void)saveToMyDatabase:(NSDictionary*)dic
{
    Event   *eventvar = nil;
    Event *dataEvent1=nil;
   
    
    NSString *eId=[dic objectForKey:@"event_id"];
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:EVENT inManagedObjectContext:appDelegate.managedObjectContext]];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"(eventId==%@) AND (userId=%@)",eId,[appDelegate.aDef objectForKey:LoggedUserID]]];
    
    NSArray* ar =nil;
    ar= [appDelegate.managedObjectContext executeFetchRequest:request error:nil];
    if ([ar count]>=1)
    {
        dataEvent1= (Event *) [ar objectAtIndex:0];
    }
    
    
    
    if(!dataEvent1)
    {
        
        eventvar= (Event *)[NSEntityDescription insertNewObjectForEntityForName:EVENT inManagedObjectContext:self.managedObjectContext];
    }
    else
    {
        eventvar=dataEvent1;
    }
    
    
    
    
   /////////////////////////////////////////////
  
    
    
    
    
  
    
    
    
    
    
    
    
     eventvar.isPublic=[NSNumber numberWithBool:1];
    if ([[dic objectForKey:@"createdby"] isEqualToString:[self.appDelegate.aDef objectForKey:LoggedUserID]]) {
        eventvar.isCreated=[NSNumber numberWithBool:1];
    }
    else
        eventvar.isCreated=[NSNumber numberWithBool:0];
    eventvar.playerName=self.playername;
    eventvar.playerId=self.playerid;
    eventvar.playerUserId=self.playeruserid;
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
    
   
   
    eventvar.isPublicAccept=[NSNumber numberWithInt:1];
    eventvar.eventIdentifier=nil;
    eventvar.userId=[appDelegate.aDef objectForKey:LoggedUserID];
    eventvar.creatorUserId=[dic objectForKey:@"createdby"];
    eventvar.eventId=[dic objectForKey:@"event_id"];
    eventvar.eventDateString=[self getDateTimeCanName:eventvar.eventDate];
    [appDelegate saveContext];
    
    
    self.dataEvent=eventvar;

}




-(void)populateDataField
{
    self.inviteplayerbtvw.hidden=NO;
    
   // appDelegate.centerViewController.navigationItem.rightBarButtonItem=self.rightBarButtonItem;
    
    NSString *topBarText=  [[NSString alloc] initWithFormat:@"%@ Details",dataEvent.eventName];
    [self setTopTextAndRightBarButton:topBarText:1];
    NSLog(@"populateDataField=%@",dataEvent);
    
    int fe=0;
    int i=0;
    for(NSString* s in appDelegate.centerVC.dataArrayUpButtonsIds)
    {
        if([s isEqualToString:dataEvent.teamId])
        {
            
            fe=1;
            break;
        }
        
        i++;
    }
    
    
     Invite *invite=(Invite*)  [self objectOfTypeInvite:INVITE forTeam:dataEvent.teamId andManObjCon:self.managedObjectContext];
    
    
    
    if(fe || invite.inviteStatus.integerValue==0)
    {
        
       
            NSString *teamStatus=nil;
         if(fe)
       teamStatus= [appDelegate.centerVC.dataArrayUpInvites objectAtIndex:i];
        
        
        
        
    
    if([teamStatus isEqualToString:@"Accept"] || invite.inviteStatus.integerValue==0)
    {
        self.isTeamAccept=1;
    }
    else
    {
         self.isTeamAccept=0;
        
       if( [teamStatus isEqualToString:@"Decline"])
        [self saveToDeviceCalendarForDecline:dataEvent];
       else
         [self saveToDeviceCalendarForMayBe:dataEvent];
           
           
        [self deleteEventFromDeviceCalendar:dataEvent];
    }
    }
    else
    {
         self.isTeamAccept=0;
    }
    
    
    
    if(dataEvent.isPublic.boolValue)
    {
        if(!dataEvent.isCreated.boolValue)
        {
            UIButton *bt=(UIButton*)  [self.topview viewWithTag:10];
            bt.hidden=YES;
            
            bt=(UIButton*)  [self.topview viewWithTag:11];
            bt.hidden=YES;
            
            bt=(UIButton*)  [self.topview viewWithTag:12];
            bt.hidden=YES;
            
            /*bt=(UIButton*)  [self.view1 viewWithTag:1];
             bt.hidden=YES;*///Add Latest Ch
            isShowDelete=0;
            self.rosterbt.hidden=NO;
            self.rosterimavw.hidden=NO;
            
            self.inviteplayerbt.hidden=YES;
            
            self.inviteplayerbtvw.hidden=YES;
            
            BOOL flag=0;
            int i=0;
            for(NSString *str in appDelegate.centerVC.dataArrayUpButtonsIds)
            {
                if([str isEqualToString: dataEvent.teamId ])
                {
                   flag=1;
                    NSString *s=  [appDelegate.centerVC.dataArrayUpInvites objectAtIndex:i];
                    
                    
                    if(![s isEqualToString:@"Accept"])
                    {
                        self.attendingvw.hidden=YES;
                        self.notattendingvw.hidden=YES;
                        self.maybevw.hidden=YES;
                        
                    }
                    break;
                }
                
                i++;
            }
            
            
            
            /// Arpita..20/03/15
            appDelegate.centerViewController.navigationItem.rightBarButtonItem=nil;
            if(self.isTeamAccept)
            {
                
                if(dataEvent.isPublicAccept.intValue==1)
                {
                    self.acceptb.hidden=NO;
                    self.attendingvw.hidden=NO;
                    self.declineb.hidden=NO;
                    self.notattendingvw.hidden=NO;
                    self.maybebtn.hidden=NO;
                    self.maybevw.hidden=NO;
                }
                else
                {
                    if ([dataEvent.userId isEqualToString:dataEvent.creatorUserId]) {
                        self.rosterbt.hidden=YES;
                        self.rosterimavw.hidden=YES;
                        
                        self.inviteplayerbt.hidden=NO;
                        
                        self.inviteplayerbtvw.hidden=NO;
                        [self showNavigationBarButtons];
                    }
                    else{
                        self.chStatusbtvw.hidden=NO;
                        
                        if(dataEvent.isPublicAccept.intValue==0)
                            self.stlbl.text=@"Your current RSVP status: Accepted";
                        else if(dataEvent.isPublicAccept.intValue==2)
                            self.stlbl.text=@"Your current RSVP status: Declined";
                        else if(dataEvent.isPublicAccept.intValue==3)
                            self.stlbl.text=@"Your current RSVP status: Maybe";
                    }
                }
                
                
            }
            [self setTopTextAndRightBarButton:topBarText:0];
        }
        else
        {
            ////..Arpita 23/03/2015
         
            if(dataEvent.isPublicAccept.intValue==1)
            {
                self.acceptb.hidden=NO;
                self.attendingvw.hidden=NO;
                self.declineb.hidden=NO;
                self.notattendingvw.hidden=NO;
                self.maybebtn.hidden=NO;
                self.maybevw.hidden=NO;
                self.inviteplayerbt.hidden=YES;
                
                self.inviteplayerbtvw.hidden=YES;
            }
            isShowDelete=1;
            
            
            [self setTopTextAndRightBarButton:topBarText:1];
        }
    }
    else
    {
        self.inviteplayerbt.hidden=YES;
        self.inviteplayerbtvw.hidden=YES;
        self.rosterbt.hidden=YES;
        self.rosterimavw.hidden=YES;
        
         [self setTopTextAndRightBarButton:topBarText:0];
    }
    
    
    
   /* UIButton *canb=(UIButton*)  [self.topview viewWithTag:1];
    [canb setTitle:[self getDateTimeCan:dataEvent.eventDate] forState:UIControlStateNormal];*///Add Latest Ch
    
    
    self.view1evname.text=dataEvent.eventName;
    self.eventDetailsLab.text=topBarText;
    //[self.inviteplayerbt setTitle:[[NSString alloc] initWithFormat:@"Invite Players to %@",dataEvent.eventName] forState:UIControlStateNormal];
    
    self.view2datelab.text=[self getDateTime:dataEvent.eventDate ];
    self.view2timelab.text=[appDelegate.dateFormatM stringFromDate:dataEvent.arrivalTime];
    self.view2eventtimelab.text=[appDelegate.dateFormatM stringFromDate:dataEvent.startTime];//[NSString stringWithFormat:@"%@ to %@",[appDelegate.dateFormatM stringFromDate:dataEvent.startTime],[appDelegate.dateFormatM stringFromDate:dataEvent.endTime]];
    self.endtimeLabel.text=[appDelegate.dateFormatM stringFromDate:dataEvent.endTime];
    self.view2repeatlab.text=[NSString stringWithFormat:@"Repeat %@",[dataEvent repeat]];
    
    
    NSString *locsstr=[dataEvent.location stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if(dataEvent.location && (![locsstr isEqualToString:@""]))
    {
            self.locationBt.hidden=NO;
        self.locationbtimavw.hidden=NO;
        
         if(dataEvent.fieldName && (![dataEvent.fieldName isEqualToString:@""]))
        locsstr=[[NSString alloc] initWithFormat:@"%@\n%@", dataEvent.location,dataEvent.fieldName ];
        else
        locsstr=dataEvent.location;
            
        self.view3addresslab.text=locsstr;

    }
    else
    {
     self.view3addresslab.text=@"-";
            self.locationBt.hidden=YES;
            self.locationbtimavw.hidden=YES;
        
        locsstr=@"-";
    }
    
    
    self.view7alertlab.text=[NSString stringWithFormat:@"Reminder %@",[dataEvent alertString]];
    
    self.notestxtview.text=dataEvent.notes;
    
    if(dataEvent.playerName)
    self.viewPlayerLab.text=dataEvent.playerName;
    else
    self.viewPlayerLab.text=@"-";
    
    if(dataEvent.isPublic.boolValue)
    {
    if(dataEvent.isHomeGame!=nil){
        
    if(dataEvent.isHomeGame.boolValue)
    self.isHomeLabel.text=@"Yes";
    else
    self.isHomeLabel.text=@"No";
    }
    else
        self.isHomeLabel.text=@"-";
    }
    else
    {
        self.isHomeLabel.text=@"-";
    }
    self.view1evloc.text=dataEvent.location;
    
    self.view8team.text=dataEvent.teamName;
    NSString *notestesxt=[dataEvent.notes stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if(dataEvent.notes && (![notestesxt isEqualToString:@""]))//Add Later Ch
    {
        self.notestxtview.text=notestesxt;
    }
    else
    {
        self.notestxtview.text=@"No Notes";
        
        notestesxt=@"No Notes";
    }
    CGRect f;
    
    if([dataEvent.isPublic boolValue])
    {
        self.statusimavw.image=self.publicDotImage;
       if(dataEvent.uniformColor && (![dataEvent.uniformColor isEqualToString:@""]))//Add Later Ch
        self.view4uniform.text=dataEvent.uniformColor;
        else
         self.view4uniform.text=@"-";
        
        
      
        
        
        
        self.view5team.text=dataEvent.opponentTeam;
        self.view6thingtobring.text=dataEvent.thingsToBring;
        
        /*f=self.view2.frame;
        f.origin.y=56;
         self.view2.frame=f;*/
        
        ///////////////Add Latest Ch
        f=self.view3.frame;
        CGRect f1=self.view3addresslab.frame;
        
        
        CGSize labelTextSize =[self getSizeOfText:locsstr :CGSizeMake (self.view3addresslab.frame.size.width,10000) :self.view3addresslab.font];
        //[dataEvent.location sizeWithFont:self.view3addresslab.font constrainedToSize:CGSizeMake (self.view3addresslab.frame.size.width,10000) lineBreakMode: NSLineBreakByWordWrapping];
        
        
        if(labelTextSize.height<20)
            labelTextSize.height=20;
        f1.size=labelTextSize;
         f.size=CGSizeMake(f.size.width, (self.view3addresslab.frame.origin.y+labelTextSize.height+10));
        self.view3addresslab.frame=f1;
       
        self.view3.frame=f;
        
        self.view3lstdivider.frame=CGRectMake(self.view3lstdivider.frame.origin.x,self.view3.frame.size.height-1,self.view3lstdivider.frame.size.width,self.view3lstdivider.frame.size.height);
        
        
        
        
        
        
        if(!isShowAccept)//Add Later Ch
        {
        f= self.view4.frame;
            f.origin.y=self.view3.frame.origin.y+self.view3.frame.size.height;//+2;//Add Later New
        self.view4.frame=f;
        
        /*f= self.view4.frame;
        f.size.height=self.view4uniformdivider.frame.origin.y+self.view4uniformdivider.frame.size.height;
        
        self.view4.frame=f;*/
            
            ///////////////
            
            /*f= self.view9.frame;
            f.origin.y=self.view4.frame.origin.y+self.view4.frame.size.height+2;
            self.view9.frame=f;*///Add Latest Ch
            
            
            f=self.view9.frame;
            f.origin.y=self.view4.frame.origin.y+self.view4.frame.size.height;//+2;   //Add Later New
            CGRect f1=self.notestxtview.frame;
            
            
            
            CGSize labelTextSize;
          
            labelTextSize=[self getSizeOfText:notestesxt :CGSizeMake (self.notestxtview.frame.size.width,10000) :self.notestxtview.font];
            
            
            
            //[dataEvent.notes sizeWithFont:self.notestxtview.font constrainedToSize:CGSizeMake (self.notestxtview.frame.size.width,10000) lineBreakMode: NSLineBreakByWordWrapping];
            
            
            if(labelTextSize.height<20)
                labelTextSize.height=20;
            /*if(labelTextSize.width<200)
                labelTextSize.width=200;*/
            
            
            f1.size=labelTextSize;
            f.size=CGSizeMake(labelTextSize.width, (labelTextSize.height+self.notestxtview.frame.origin.y+10));
            self.notestxtview.frame=f1;
            self.view9divider.frame=CGRectMake(self.view9divider.frame.origin.x, (labelTextSize.height+self.notestxtview.frame.origin.y+9), self.view9divider.frame.size.width, self.view9divider.frame.size.height);
            self.view9.frame=f;
            
            
            /////////////////////////////
        }
        ///////////////
       /* f= self.view5.frame;
        f.origin.y=self.view4.frame.origin.y+self.view4.frame.size.height;
        self.view5.frame=f;*/
        
        ////////////
       /* f=self.view6thingtobring.frame;
        labelTextSize = [dataEvent.thingsToBring sizeWithFont:self.view6thingtobring.font constrainedToSize:CGSizeMake (self.view6thingtobring.frame.size.width,10000) lineBreakMode: NSLineBreakByWordWrapping];
        f.size=labelTextSize;
        f.origin.y+=8;
        self.view6thingtobring.frame=f;
        [self.view6thingtobring sizeToFit];
        f= self.view6divider.frame;
        f.origin.y=self.view6thingtobring.frame.origin.y+self.view6thingtobring.frame.size.height+8;
        self.view6divider.frame=f;
        
        f= self.view6.frame;
        f.origin.y=self.view5.frame.origin.y+self.view5.frame.size.height;
        f.size.height=self.view6divider.frame.origin.y+self.view6divider.frame.size.height;
        self.view6.frame=f;
        
        */
        
        
        ///////////
        
        
       /* f= self.view7.frame;
        f.origin.y=self.view4.frame.origin.y+self.view4.frame.size.height;
        self.view7.frame=f;*///Add Latest Ch
        
      
        
    }
    else
    {
        self.statusimavw.image=self.privateDotImage;
        
       
        self.view4.hidden=YES;
      
        
       /* f=self.view2.frame;
        f.origin.y-=21;
         self.view2.frame=f;*/
        
       
        
        UIView *v1=nil;
        if( dataEvent.location && (![dataEvent.location isEqualToString:@""]))
        {
            
            
            f=self.view3.frame;
             f.origin.y=self.view2.frame.origin.y+self.view2.frame.size.height;
            CGRect f1=self.view3addresslab.frame;
            CGSize labelTextSize =[self getSizeOfText:locsstr :CGSizeMake (self.view3addresslab.frame.size.width,10000) :self.view3addresslab.font];
            
            //[dataEvent.location sizeWithFont:self.view3addresslab.font constrainedToSize:CGSizeMake (self.view3addresslab.frame.size.width,10000) lineBreakMode: NSLineBreakByWordWrapping];
            if(labelTextSize.height<20)
                labelTextSize.height=20;
            f1.size=labelTextSize;
            
            f.size=CGSizeMake(f.size.width, (labelTextSize.height+10+self.view3addresslab.frame.origin.y));;
            self.view3addresslab.frame=f1;
            
            self.view3.frame=f;
            
            
            ////////////////////////////
           
           
          
            self.view3.hidden=NO;
            
            v1=self.view3;
            ////////////////////////////
            
            
            
            
            
            
            
        }
        else
        {
            self.view3.hidden=YES;
            
             v1=self.view2;
        }
        
       
        
        f=self.view9.frame;
        f.origin.y=v1.frame.origin.y+v1.frame.size.height;//+2
        CGRect f1=self.notestxtview.frame;
        CGSize labelTextSize =[self getSizeOfText:notestesxt :CGSizeMake (self.notestxtview.frame.size.width,10000) :self.notestxtview.font];
        
        //[dataEvent.notes sizeWithFont:self.notestxtview.font constrainedToSize:CGSizeMake (self.notestxtview.frame.size.width,10000) lineBreakMode: NSLineBreakByWordWrapping];
        
        if(labelTextSize.height<20)
            labelTextSize.height=20;
        /*if(labelTextSize.width<200)
            labelTextSize.width=200;*/
        
        f1.size=labelTextSize;
        f.size=CGSizeMake(labelTextSize.width, (labelTextSize.height+self.notestxtview.frame.origin.y+10));
        self.notestxtview.frame=f1;
        self.view9.frame=f;
    }
    
    
   
    
    
    
    CGRect r=  self.mainview.frame;
    
    if(!isShowAccept)//Add Later Ch
    {
    r.size.height=self.view9.frame.origin.y+self.view9.frame.size.height+5;
    }
    else
    {
    r.size.height=self.view3.frame.origin.y+self.view3.frame.size.height+5;
        
        
        self.view9.hidden=YES;
        self.view4.hidden=YES;
    }
    self.mainview.frame=r;
    
    
    r=self.chStatusbtvw.frame;
    r.origin.y= self.mainview.frame.origin.y+self.mainview.frame.size.height+15/*+33*/;
    self.chStatusbtvw.frame=r;
    
    
    r=self.attendingvw.frame;
    r.origin.y= self.mainview.frame.origin.y+self.mainview.frame.size.height+15;
    self.attendingvw.frame=r;
    
    r=self.maybevw.frame;
    r.origin.y= self.mainview.frame.origin.y+self.mainview.frame.size.height+15;
    self.maybevw.frame=r;
    
    r=self.notattendingvw.frame;
    r.origin.y= self.mainview.frame.origin.y+self.mainview.frame.size.height+15;
    self.notattendingvw.frame=r;
    
    
    
    self.scrollView.contentSize=CGSizeMake(320,self.notattendingvw.frame.origin.y+self.notattendingvw.frame.size.height+15);
    
    
    if(self.inviteplayerbt.hidden==NO)
    {
        /*r=self.inviteplayerbt.frame;
        r.origin.y= self.mainview.frame.origin.y+self.mainview.frame.size.height+15;
        self.inviteplayerbt.frame=r;
        
        self.scrollView.contentSize=CGSizeMake(320,self.inviteplayerbt.frame.origin.y+self.inviteplayerbt.frame.size.height+15);*/
    }
    else
    {
        r=self.scrollView.frame;
        r.size.height+=50;
        self.scrollView.frame=r;
       // _lblCoachEmail.frame=CGRectMake(_lblCoachEmail.frame.origin.x, _lblCoachEmail.frame.origin.y+50, _lblCoachEmail.frame.size.width, _lblCoachEmail.frame.size.height);
    }
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)viewDidUnload
{
    [self setView9:nil];
    [self setNoteslab:nil];
    [self setView8divider:nil];
    [self setNotestxtview:nil];
    [self setRosterimavw:nil];
    [self setRosterbt:nil];
    [self setViewPlayerLab:nil];
    [self setMaybebtn:nil];
    [self setInviteplayerbt:nil];
    [self setEventDetailsLab:nil];
    [self setLocationBt:nil];
    [super viewDidUnload];
    
    
    
    
}
- (IBAction)bTapped:(id)sender
{
    
    int tag=[sender tag];
    
    if(tag==1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if(tag==12)
    {
        EventEditViewController *eVc=nil;
        if(dataEvent.isPublic.boolValue)
        {
        eVc= [[EventEditViewController alloc] initWithNibName:@"EventEditViewController" bundle:nil];
            eVc.mode=1;
        }
        else
        {
        /*eVc= [[EventEditViewController alloc] initWithNibName:@"EventEditViewController_Private" bundle:nil];
              eVc.mode=0;*/
             [self showAlertMessage:@"Private Event is not allowed"];
        }
        eVc.isEditMode=1;
        eVc.dataEvent=self.dataEvent;
        
        self.isModallyPresentFromCenterVC=1;
        [self showModal:eVc];
      //  [self.navigationController pushViewController:eVc animated:YES];
    }
   
    
}






- (IBAction)actionTapped:(id)sender
{
    int tag=[sender tag];
    
    
    BOOL flag=0;
    
    int i=0;
    
    for(NSString *str in appDelegate.centerVC.dataArrayUpButtonsIds)
    {
        if([str isEqualToString: dataEvent.teamId ])
        {
            flag=1;
            
            break;
        }
        
        i++;
    }
    
    
    if(!flag)
    {
              
        [self showAlertMessage:@"You need to accept the team invite before team event invite" title:@""];
        
        
        return;
    }
    else
    {
        NSString *s=  [appDelegate.centerVC.dataArrayUpInvites objectAtIndex:i];
        
        
        if(![s isEqualToString:@"Accept"])
        {
              [self showAlertMessage:@"You need to accept the team invite before team event invite" title:@""];
            
            
            return;
        }
    }
    
    
    
    
    
    
    
       
    NSString *str=nil;
    
    if(tag==0)
    {
        str=@"Accept";
    }
    else if(tag==1)
    {
        self.backAlertView.hidden=NO;
        self.alertView.hidden=NO;
        self.lblMessage.text=@"Are you sure you want to decline?";
//        self.lblMessage.text=[NSString stringWithFormat:@"Are you sure you want to decline. You will not be able to view %@ moments",dataEvent.eventName];
        return;
        str=@"Decline";
    }
    else if(tag==2)
    {
        str=@"Maybe";
    }
    
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    [command setObject:dataEvent.playerUserId forKey:@"UserID"];//[appDelegate.aDef objectForKey:LoggedUserID]
    [command setObject:str forKey:@"Status"];
    [command setObject:dataEvent.eventId forKey:@"event_id"];
    
    if(![[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:dataEvent.playerUserId])
    [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"Primary_UserID"];
    else
    [command setObject:@"" forKey:@"Primary_UserID"];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    
    
    self.requestDic=command;
    [appDelegate sendRequestFor:EVENTINVITESTATUS from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
    
    
    
    
    
    
    
    
    
    
   ///////////////////////
    
    
    
}



-(void)hideHudViewHere
{
    [self hideHudView];
     [self.navigationController popViewControllerAnimated:YES];
    
    
    if(self.isFromPushBadge)
    {
        EventCalendarViewController *eVC=(EventCalendarViewController*) [appDelegate.navigationControllerCalendar.viewControllers objectAtIndex:0];
        [appDelegate.navigationControllerCalendar popToRootViewControllerAnimated:NO];
        /*  [eVC.segmentbottom setSelectedSegmentIndex:0];
         [eVC segTapped:eVC.segmentbottom];*/
        
        self.appDelegate.centerViewController.isShowMainCalendarFirstScreeen=0;
        eVC.eventheaderlab.text=UPCOMINGTEAMEVENTS;
        eVC.isMonth=1;
        eVC.topSegCntrl.selectedSegmentIndex=eVC.isMonth;
        eVC.calvc.view.hidden=NO;
        eVC.callistvc.view.hidden=YES;
        eVC.downarrowfilterimavw.hidden=YES;
        eVC.downarrowfilterbt.hidden=YES;
        
        [eVC.calvc.monthView reloadData];
        [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerCalendar];
        
        
        [eVC.calvc.monthView selectDate:self.dataEvent.eventDate];
    }
}


-(void)saveToDeviceCalendarForDecline:(Event*)eventvar
{
    eventvar.isPublicAccept=[NSNumber numberWithInt:2];
    [appDelegate saveContext];
}

-(void)saveToDeviceCalendarForMayBe:(Event*)eventvar
{
    eventvar.isPublicAccept=[NSNumber numberWithInt:3];
    [appDelegate saveContext];
}

-(void)saveToDeviceCalendar:(Event*)eventvar
{

    
    
EKEvent *newEvent=nil;
    
    
    
   
    
    
    newEvent= [appDelegate.eventStore eventWithIdentifier:((Event*)eventvar).eventIdentifier];
    

    if(!newEvent)
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
    
    /*if(appDelegate.defaultCalendar)
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
    eventvar.isPublicAccept=[NSNumber numberWithInt:0];
    [appDelegate saveContext];
}




-(void)deleteEventFromDeviceCalendar:(Event *)dataEvent1
{
    
        if(dataEvent1)
        {
            EKEvent *newEvent=nil;
            
            
            newEvent= [appDelegate.eventStore eventWithIdentifier:((Event*)dataEvent1).eventIdentifier];
            
            NSError *error=nil;
            BOOL save=  [appDelegate.eventStore removeEvent:newEvent span:EKSpanFutureEvents commit:YES error:&error ];
            NSLog(@"DeleteEventStatusAfterStatusEventChange=%i \n%@",save,error.description);
            
            
        }
    

}


- (IBAction)actionbtn:(id)sender
{
    int tag=[sender tag];
    
    if(tag==1)
    {
        
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"" message:@"Are you sure want to delete this event?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        [alertView show];
        
    }
    else if(tag==2)
    {
        
       /* MapViewVC *mpVc=[[MapViewVC alloc] initWithNibName:@"MapViewVC" bundle:nil];
        mpVc.selectedAddress=dataEvent.location;
        [self.navigationController pushViewController:mpVc animated:YES];*/
        
        MapViewController *mapVC=[[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
        
        if(dataEvent.fieldName)
            mapVC.selectedAddress=[[NSString alloc] initWithFormat:@"%@,%@", [ dataEvent location ],dataEvent.fieldName ];
        else
            mapVC.selectedAddress=dataEvent.location;
        
          mapVC.selectedAddress1=dataEvent.location;
        
        //[self.navigationController pushViewController:mapVC animated:YES];
        self.isModallyPresentFromCenterVC=1;
        [self showModal:mapVC];
        
    }
    
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex==1)
    {
        if([dataEvent.isPublic boolValue])
        {
            
            if([dataEvent.isCreated boolValue])
            {
                NSMutableDictionary *command = [NSMutableDictionary dictionary];
                
                NSLog(@"%@-%@",dataEvent.teamId,dataEvent.eventId);
                
                [command setObject:dataEvent.teamId forKey:@"team_id"];
                
                [command setObject:dataEvent.eventId forKey:@"event_id"];
                
                SBJsonWriter *writer = [[SBJsonWriter alloc] init];
                
                
                NSString *jsonCommand = [writer stringWithObject:command];
                
                
                [self showHudView:@"Deleting..."];
                [self showNativeHudView];
                NSLog(@"RequestParamJSON=%@",jsonCommand);
                
                
                [appDelegate sendRequestFor:DELETEEVENT from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
            }
            //            else
            //            {
            //                EKEvent *newEvent=nil;
            //                newEvent= [appDelegate.eventStore eventWithIdentifier:dataEvent.eventIdentifier];
            //                NSLog(@"DeleteEventDetails=%@--%@",dataEvent.eventIdentifier,newEvent);
            //                NSError *error=nil;
            //                BOOL save=  [appDelegate.eventStore removeEvent:newEvent span:EKSpanFutureEvents commit:YES error:&error ];
            //                NSLog(@"DeleteEventStatus=%i \n%@",save,error.description);
            //
            //                if(save)
            //                    [self deleteObjectOfTypeEvent:dataEvent];
            //
            //
            //                 [self.navigationController popViewControllerAnimated:YES];
            //
            //            }
        }
       /* else
        {
            
            
            EKEvent *newEvent=nil;
            newEvent= [appDelegate.eventStore eventWithIdentifier:dataEvent.eventIdentifier];
            NSLog(@"DeleteEventDetails=%@--%@--%@",dataEvent.eventIdentifier,newEvent,dataEvent);
            NSError *error=nil;
            BOOL save=  [appDelegate.eventStore removeEvent:newEvent span:EKSpanFutureEvents commit:YES error:&error ];
            NSLog(@"DeleteEventStatus=%i \n%@",save,error.description);
            
            if(save)
                [self deleteObjectOfTypeEvent:dataEvent];
            
            
            [self.navigationController popViewControllerAnimated:YES];
        }*/
   
    }
    
    
}


- (IBAction)rosterAction:(id)sender
{
    
    
    PlayerListViewController *player=[[PlayerListViewController alloc] initWithNibName:@"PlayerListViewController" bundle:nil];
    self.playerAttendance=player;
    player.eventId=self.dataEvent.eventId;
    [self.navigationController pushViewController:player animated:YES];
   

    
    
}

- (void)inviteActionData:(NSString*)titletext
{
    titletext=[NSString stringWithFormat:@"Invite Player to %@",self.dataEvent.eventName];
    [self.inviteplayerbt setTitle:@"Invitees" forState:UIControlStateNormal];
    
    CGRect fr= self.addimageinvitebt.frame;
    fr.origin.x+=58;
    self.addimageinvitebt.frame=fr;
    
    EventPlayerStatusVC *player=[[EventPlayerStatusVC alloc] initWithNibName:@"EventPlayerStatusVC" bundle:nil];
    
    player.headerTitle=titletext;
    player.eventId=self.dataEvent.eventId;
    player.eventTeamId=self.dataEvent.teamId;
    
    
    self.isModallyPresentFromCenterVC=1;
    [self showModal:player];
    
    
    // [self.navigationController pushViewController:player animated:YES];
    
    
}

- (IBAction)inviteAction:(id)sender
{
    
    //////  22/8/14  ////
    
    /*if(appDelegate.isIos7)
     cell= (EventCell*)sender.superview.superview.superview;
     else
     cell= (EventCell*)sender.superview.superview;
     
     NSIndexPath *indexPath=[self.tabView indexPathForCell:cell];
     
     Event *newEvent= [fetchedResultsController objectAtIndexPath:indexPath];*/
   /*
    PlayerListViewController *player=[[PlayerListViewController alloc] initWithNibName:@"PlayerListViewController" bundle:nil];
    
    //////
    NSString *strDt=[appDelegate.dateFormatEventShort stringFromDate:self.dataEvent.eventDate];
    NSString *strFinl=[strDt stringByAppendingFormat:@" %@ attendance",self.dataEvent.eventName];
    player.strTitle=strFinl;
    ////// 16/01/15
    
    
    self.playerAttendance=player;
    player.eventId=dataEvent.eventId;
    player.teamId=dataEvent.teamId;
    [appDelegate.navigationControllerCalendar pushViewController:player animated:YES];
    
    */
    
    EventPlayerStatusVC *player=[[EventPlayerStatusVC alloc] initWithNibName:@"EventPlayerStatusVC" bundle:nil];
    player.eventId=self.dataEvent.eventId;
      player.eventTeamId=self.dataEvent.teamId;
    
    
    self.isModallyPresentFromCenterVC=1;
    [self showModal:player];
    
    
   // [self.navigationController pushViewController:player animated:YES];
    
    
}


- (IBAction)chStatusAction:(id)sender
{
    
    self.chStatusbtvw.hidden=YES;
    self.acceptb.hidden=NO;
    self.attendingvw.hidden=NO;
    self.declineb.hidden=NO;
    self.notattendingvw.hidden=NO;
    self.maybebtn.hidden=NO;
    self.maybevw.hidden=NO;
    
    float y=self.scrollView.contentSize.height-self.scrollView.frame.size.height;
    
    if(y<0)
    {
        y=0;
    }
    
    self.scrollView.contentOffset=CGPointMake(0, y);
    
    //[self.scrollView scrollRectToVisible:CGRectMake(0, y, 320, <#CGFloat height#>) animated:YES];
    
}
- (IBAction)doneAlert:(UIButton *)sender {
    self.backAlertView.hidden=YES;
    self.alertView.hidden=YES;
    
    if (sender.tag==0) {
        return;
    }
    NSString *str=@"Decline";
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    [command setObject:dataEvent.playerUserId forKey:@"UserID"];//[appDelegate.aDef objectForKey:LoggedUserID]
    [command setObject:str forKey:@"Status"];
    [command setObject:dataEvent.eventId forKey:@"event_id"];
    
    if(![[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:dataEvent.playerUserId])
        [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"Primary_UserID"];
    else
        [command setObject:@"" forKey:@"Primary_UserID"];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    
    
    self.requestDic=command;
    [appDelegate sendRequestFor:EVENTINVITESTATUS from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
}
@end
