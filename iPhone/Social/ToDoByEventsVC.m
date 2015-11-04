//
//  ToDoByEventsVC.m
//  LinkBook
//
//  Created by Piyali on 06/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "EventCalendarViewController.h"
#import "EventDetailsViewController.h"
#import "ToDoByEventsVC.h"
#import "PlayerListViewController.h"
#import "EventEditViewController.h"

@implementation ToDoByEventsVC

@synthesize alldelarr,tabView,grayf,dGrayColor,grayColor,redf,todayIndexpath,todayFDate,selTeamId,noeventslab,eventCalVC,selplayerId,selShowByStatus,isSelShowByStatus,isAscendingDate,noeventsimagevw,noeventsfilterlab,allfilterbt,normalmsgnoevent,adminmsgnoevent;


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
    self.noeventslab=nil;
    self.privateDotImage=nil;
    self.publicDotImage=nil;
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ///////////////////ADDDEB
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAttenDanceForEvent:) name:SHOWEVENTATTENDANCENOTIFY object:nil];
    
    ///////////////////
       isAscendingDate=1;
    @autoreleasepool {
        
        if (self.isiPad) {
            self.tickImage=[UIImage imageNamed:@"accepted_image_invite_ipad.png"];//acceptinvite.png
            self.crossImage=[UIImage imageNamed:@"decile_image_invite_ipad.png"];//declineinvite.png
            self.questionmarkImage=[UIImage imageNamed:@"reminder_send_invite_ipad.png"];
            self.maybeQuestionmarkImage=[UIImage imageNamed:@"maybe_image_invite_ipad.png"];
        }
        else{
//            self.tickImage=[UIImage imageNamed:@"accepted_image.png"];//acceptinvite.png
//            self.crossImage=[UIImage imageNamed:@"decile_image.png"];//declineinvite.png
            self.tickImage=[UIImage imageNamed:@"accepted_image_invite.png"];//acceptinvite.png
            self.crossImage=[UIImage imageNamed:@"decile_image_invite.png"];//declineinvite.png
            self.questionmarkImage=[UIImage imageNamed:@"reminder_send_invite.png"];
            self.maybeQuestionmarkImage=[UIImage imageNamed:@"maybe_image_invite.png"];
        }
    //self.questionmarkImage=[UIImage imageNamed:@"reminder_send.png"];//noresponsemaybe.png
    
    //self.maybeQuestionmarkImage=[UIImage imageNamed:@"invite_send.png"];//maybeinvite.png
        
        
      
    }
    
    self.normalmsgnoevent=@"Wait for Team Admin to schedule  events.\nYou have no team event scheduled.";//@"You currently have no events";
    self.adminmsgnoevent=@"Create a team event by tapping on     above";
    
    // Do any additional setup after loading the view from its nib.
    self.dGrayColor=[UIColor darkGrayColor];
    self.grayf=[UIFont systemFontOfSize:17];
     self.grayColor=[UIColor grayColor];
        self.redf=[UIFont systemFontOfSize:12];
    self.privateDotImage=[UIImage imageNamed:@"Dot-Image-with-P-text.png"];
    self.publicDotImage=[UIImage imageNamed:@"Grey dot.png"];
    
   // self.todayIndexpath=nil;
  
   //self.selTeamId=@"Private";
    
    @autoreleasepool
    {
       // NSDate *date=[NSDate date];
       // self.fetchFirstDate=[self dateFromSD:date];
       // self.fetchLastDate=[self dateFromSDLast:date];
    }
   // self.noeventslab.text=@"Wait for Team Admin to schedule  events.\nYou have no team event scheduled.";
}


- (IBAction)addEvent:(id)sender {
    
    EventEditViewController *eVc=[[EventEditViewController alloc] initWithNibName:@"EventEditViewController" bundle:nil];
    
    
    eVc.mode=1;
   // eVc.defaultDate=self.currentSelectedDate;
    
    
    self.isModallyPresentFromCenterVC=1;
    [self showModal:eVc];
    
}

-(void)manageViewMessage:(BOOL)animated
{
    
    
    
    if(!animated)
    {
        self.viewMessage.hidden=YES;
        self.imageViewMessage.hidden=YES;
    }
    else
    {
        self.viewMessage.hidden=NO;
       // self.imageViewMessage.hidden=NO;
        [self performSelector:@selector(hideimageViewMessage) withObject:self afterDelay:3.0];

    }
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
     NSLog(@"niltodayindexpath");
     self.todayIndexpath=nil;
      self.todayFDate=[self dateFromSD:[NSDate date] ];
    [self.tabView reloadData];
    
    if(self.fetchedResultsController.fetchedObjects.count>0)
    {
    [self.tabView scrollToRowAtIndexPath:self.todayIndexpath
                        atScrollPosition:UITableViewScrollPositionTop
                                animated:YES];
        
        
        self.tabView.hidden=NO;
        self.noeventslab.hidden=YES;
        self.lblPlus.hidden=YES;
        self.noeventsfilterlab.hidden=YES;
          self.allfilterbt.hidden=YES;
         self.noeventsimagevw.hidden=YES;
        self.viewMessage.hidden=NO;
       // self.imageViewMessage.hidden=NO;
        [self performSelector:@selector(hideimageViewMessage) withObject:self afterDelay:3.0];

    }
    else
    {
        self.tabView.hidden=YES;
         //self.noeventsimagevw.hidden=NO;
        self.viewMessage.hidden=YES;
        self.imageViewMessage.hidden=YES;
        if(self.fetchFirstDate==nil && self.fetchLastDate==nil && self.selTeamId==nil && self.selplayerId==nil && self.isSelShowByStatus==0)
        {
            self.noeventslab.hidden=NO;
            self.lblPlus.hidden=NO;
            self.noeventsfilterlab.hidden=YES;
             self.allfilterbt.hidden=YES;
        }
        else
        {
            self.noeventslab.hidden=YES;
            self.lblPlus.hidden=YES;
            self.noeventsfilterlab.hidden=NO;
             self.allfilterbt.hidden=NO;
        }
        
    }
    
   /* //// AD...iAd
    self.adBanner.delegate = self;
    self.adBanner.alpha = 0.0;
    self.canDisplayBannerAds=YES;
    ////*/
}

-(void)loadTable
{
    self.todayIndexpath=nil;
    self.todayFDate=[self dateFromSD:[NSDate date]];
    
    [self.tabView reloadData];
    
    if(self.fetchedResultsController.fetchedObjects.count>0)
    {
        [self.tabView scrollToRowAtIndexPath:self.todayIndexpath
                            atScrollPosition:UITableViewScrollPositionTop
                                    animated:YES];
        
        
        self.tabView.hidden=NO;
        self.noeventslab.hidden=YES;
        self.lblPlus.hidden=YES;
        self.noeventsfilterlab.hidden=YES;
         self.allfilterbt.hidden=YES;
         self.noeventsimagevw.hidden=YES;
        self.viewMessage.hidden=NO;
        //self.imageViewMessage.hidden=NO;
        [self performSelector:@selector(hideimageViewMessage) withObject:self afterDelay:3.0];
    }
    else
    {
        self.tabView.hidden=YES;
         //self.noeventsimagevw.hidden=NO;
       self.viewMessage.hidden=YES;
        self.imageViewMessage.hidden=YES;
        if(self.fetchFirstDate==nil && self.fetchLastDate==nil && self.selTeamId==nil && self.selplayerId==nil && self.isSelShowByStatus==0)
        {
            self.noeventslab.hidden=NO;
            self.lblPlus.hidden=NO;
            self.noeventsfilterlab.hidden=YES;
             self.allfilterbt.hidden=YES;
        }
        else
        {
            self.noeventslab.hidden=YES;
            self.lblPlus.hidden=YES;
            self.noeventsfilterlab.hidden=NO;
             self.allfilterbt.hidden=NO;
        }
       
        
    }
    
//    //// AD...iAd
//    self.adBanner.delegate = self;
//    self.adBanner.alpha = 0.0;
//    self.canDisplayBannerAds=YES;
//    ////

}

- (IBAction)topBarAction:(id)sender
{
    
    int tag=[sender tag];
    
    if(tag==1)
    {
        [self.eventCalVC showDate];
    }
    else if(tag==2)
    {
        [self.eventCalVC showTeam];
    }
    else if(tag==3)
    {
        [self.eventCalVC showPlayer];
    }
    else if(tag==4)
    {
        [self.eventCalVC showByStatus];
    }
}









- (void)viewDidUnload
{
    [self setNoeventslab:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

/*-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *cellview;
   // UIImageView *imaview;
    cellview=[[UIView alloc] initWithFrame:CGRectMake(0,0,320,21)];
   // imaview=[[UIImageView alloc ] initWithImage:[UIImage imageNamed:@"Slid1_black 1st separation bar.png"]];
   // imaview.frame=CGRectMake(0,0,320,21);
    cellview.backgroundColor=appDelegate.barGrayColor;
    
    UILabel *header=[[UILabel alloc] initWithFrame:CGRectMake(15,0,150,21) ];
    header.font=[UIFont systemFontOfSize:14];
   
    header.backgroundColor=[UIColor clearColor];
    
    UILabel *header1=[[UILabel alloc] initWithFrame:CGRectMake(170,0,150,21) ];
    header1.font=[UIFont systemFontOfSize:14];
   
    header1.backgroundColor=[UIColor clearColor];
    
    
     NSDate *currDate=[[NSDate alloc] init];
    
    
    id <NSFetchedResultsSectionInfo> sectionInfo;
    
   
        sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    
  
   // int i=section;
   
        
        
     //   NSLog(@"NOF=%i----Section=%i",[sectionInfo numberOfObjects],i);
        NSArray *arr1=[sectionInfo objects];
       
             Event *event=(Event*)[arr1 objectAtIndex:0];
             
            // NSLog(@"%@-%@",event.eventDateString,event.eventName);
             
    
    
  

    
    
    
    
    
    
 //   NSLog(@"sectionInfo name=%@",[sectionInfo name]);
    
       
    NSArray *arr=[event.eventDateString componentsSeparatedByString:@"-"];
    header.text=[arr objectAtIndex:0];
    header1.text=[arr objectAtIndex:1];
    if([[sectionInfo name] isEqualToString:[self getDateTimeCanName:currDate]])
    {
       // header.textColor=[UIColor redColor];
       // header1.textColor=[UIColor redColor];
    }
    else
    {
       // header.textColor=[UIColor whiteColor];
        //header1.textColor=[UIColor whiteColor];
    }
    header.textColor=appDelegate.labelRedColor;
    header1.textColor=appDelegate.labelRedColor;

    [cellview addSubview:header];
     [cellview addSubview:header1];
   // [cellview addSubview:imaview];
    return cellview;
}*/
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0;//21.0;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return 80.0f;
    }
    else
        return 44.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    
  //  NSLog(@"NOF=-%i",[sectionInfo numberOfObjects]);
    return [sectionInfo numberOfObjects];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    //    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell=(EventCell *)[EventCell cellFromNibNamed:@"EventCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
    }
    
	[self configureCell:cell atIndexPath:indexPath];
    
        return cell;
}


- (void)configureCell:(UITableViewCell *)cell1 atIndexPath:(NSIndexPath *)indexPath
{
    EventCell *cell=(EventCell*)cell1;
    
    
    
    Event *newEvent= [fetchedResultsController objectAtIndexPath:indexPath];
//	cell.detailslabName.text =newEvent.eventName;
//    cell.detailslabField.text =newEvent.fieldName;
//    
//    if([newEvent.isPublic boolValue])
//    {
//        cell.detailslabName.frame=CGRectMake(150, 6, 160, 16);
//        
//        cell.leftimav.image =self.publicDotImage;
//    }
//    else
//    {
//        cell.detailslabName.frame=CGRectMake(150, 11, 160, 16);
//        cell.leftimav.image =self.privateDotImage;
//    }
//    
//    // AppDelegate *appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
//    cell.detailslabTime.text = [appDelegate.dateFormatM stringFromDate:newEvent.startTime ];
    
    if([newEvent.teamName isEqualToString:@"Private"] || (!newEvent.isPublic.boolValue))
    {
        cell.rosterbt.hidden=NO;
        cell.rosterIma.hidden=NO;
    }
    else
    {
        cell.rosterbt.hidden=NO;
          cell.rosterIma.hidden=NO;
    }
    
    [cell.rosterbt addTarget:self action:@selector(rosterAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.detailslabEventName.text=newEvent.eventName;
    
    cell.detailslabName.text =newEvent.playerName;//newEvent.eventName;//Add Latest Ch
  
    
    if([newEvent.isPublic boolValue]==0)
    {
          cell.detailslabField.text =[[NSString alloc] initWithFormat:@"%@, %@", [appDelegate.dateFormatEventShort stringFromDate:newEvent.eventDate ] ,[appDelegate.dateFormatM stringFromDate:newEvent.startTime ]];//newEvent.teamName;//Add Latest Ch
       // cell.detailslabTime.text = ;
    }
    else
    {
          cell.detailslabField.text = [[NSString alloc] initWithFormat:@"%@, %@", [appDelegate.dateFormatEventShort stringFromDate:newEvent.eventDate ],[appDelegate.dateFormatM stringFromDate:newEvent.arrivalTime ] ] ;//newEvent.teamName;//Add Latest Ch
        //cell.detailslabTime.text = ;
    }
    
    
    
    cell.backgroundStatusView.backgroundColor=[UIColor whiteColor];
   /* cell.detailslabName.textColor=self.blackcolor;
    cell.detailslabField.textColor=self.blackcolor;
    cell.detailslabTime.textColor=self.blackcolor;*///Add Latest Ch
     cell.leftimav.image =self.tickImage;//Add Latest Ch
    if([newEvent.isPublic boolValue])
    {
        
        
        //cell.leftimav.image =self.publicDotImage;//Add Latest Ch
        
        if([newEvent.isPublicAccept intValue]==1 )
        {
          
           /* cell.detailslabName.textColor=appDelegate.cellRedColor;
            cell.detailslabField.textColor=appDelegate.cellRedColor;
            cell.detailslabTime.textColor=appDelegate.cellRedColor;*///Add Latest Ch
             cell.leftimav.image =self.questionmarkImage;//Add Latest Ch
            
        }
        else if([newEvent.isPublicAccept intValue]==2)
        {
         
         /*   cell.detailslabName.textColor=[UIColor grayColor];
            cell.detailslabField.textColor=[UIColor grayColor];
            cell.detailslabTime.textColor=[UIColor grayColor];*///Add Latest Ch
             cell.leftimav.image =self.crossImage;//Add Latest Ch
        }
        else if([newEvent.isPublicAccept intValue]==3)
        {
            
             cell.leftimav.image =self.maybeQuestionmarkImage;
            
        }
    }
    else
    {
       
       // cell.leftimav.image =self.privateDotImage;//Add Latest Ch
       
    }
    
    //cell.leftimav.hidden=YES;//Add Latest Ch
   
    
    
    
    
    
    cell.detailslabTeamName.text=newEvent.teamName;
    
    
    
    if(!todayIndexpath)
    {
        if(([newEvent.eventDate compare:self.todayFDate]!=NSOrderedAscending) && ([newEvent.eventDate compare:[self dateFromSDLast:self.todayFDate ]]!=NSOrderedDescending))
        {
            self.todayIndexpath=indexPath;
            NSLog(@"todayIndexpathConfigureCell=%@",self.todayIndexpath);
        }
    }

    
    
    /*
    
    if(((indexPath.row+1)%3))
    {
        cell.separator.hidden=YES;
    }
    else
    {
        cell.separator.hidden=NO;
    }
    */
    
    
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


-(void)rosterAction:(UIButton*)sender
{
    EventCell *cell=nil;
    
    // changed on 7th October
    if(appDelegate.isIos7)
        //cell= (EventCell*)sender.superview.superview;
        cell= (EventCell*)sender.superview.superview.superview;
    else
        cell= (EventCell*)sender.superview.superview;
    
    NSIndexPath *indexPath=[self.tabView indexPathForCell:cell];
    
    Event *newEvent= [fetchedResultsController objectAtIndexPath:indexPath];
    
    
    ////// 16/01/15  //////
    
   /* if ([newEvent.userId isEqualToString:[appDelegate.aDef objectForKey:LoggedUserID]]) {
        EventPlayerStatusVC *evntPlayer=[[EventPlayerStatusVC alloc] initWithNibName:@"EventPlayerStatusVC" bundle:nil];
        evntPlayer.eventId=newEvent.eventId;
        evntPlayer.eventTeamId=newEvent.teamId;
        
        
        self.isModallyPresentFromCenterVC=1;
        [self showModal:evntPlayer];
        return;
    }*/
    
    
    PlayerListViewController *player=[[PlayerListViewController alloc] initWithNibName:@"PlayerListViewController" bundle:nil];
    
    //////
    
    NSDateFormatter *dateFor=[[NSDateFormatter alloc ] init];
    [dateFor setDateFormat:@"EEEE LLLL d"];
    NSString *strDt=[dateFor stringFromDate:newEvent.eventDate];
    NSString *strFinl=[[NSString stringWithFormat:@"%@ %@ ",newEvent.teamName,newEvent.eventName] stringByAppendingString:strDt];
    player.strTitle=strFinl;
    ////// 16/01/15
    
    
    self.playerAttendance=player;
    player.eventId=newEvent.eventId;
    player.teamId=newEvent.teamId;
    [appDelegate.navigationControllerCalendar pushViewController:player animated:YES];
    
    
    ///// AD 15th july  /////
    
    
    
    
    
    
   ///////////// AD  ////////////
    
}


///////////////ADDDEB

-(void)showAttenDanceForEvent:(id)sender
{
    
    
    NSString *eventId=(NSString*)[sender object];
    
    Event *newEvent=nil;
    @autoreleasepool {
        
        
        NSArray *arr=[fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"eventId==%@",eventId]];
        
        
        newEvent= [arr objectAtIndex:0];
    }
    /*PlayerListViewController *player=[[PlayerListViewController alloc] initWithNibName:@"PlayerListViewController" bundle:nil];
    self.playerAttendance=player;
    player.eventId=newEvent.eventId;
    player.teamId=newEvent.teamId;
    [appDelegate.navigationControllerCalendar pushViewController:player animated:YES];*/
    
    
    
    EventPlayerStatusVC *player=[[EventPlayerStatusVC alloc] initWithNibName:@"EventPlayerStatusVC" bundle:nil];
    player.isFromAttendance=1;
    player.eventId=newEvent.eventId;
    player.eventTeamId=newEvent.teamId;
    
    
    self.isModallyPresentFromCenterVC=1;
    [self showModal:player];
    
    
    
    
}

///////////////


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   /* Contacts *con=[self.fetchedResultsController objectAtIndexPath:indexPath];
    
    
    ToDoDetails *mvc =[[ToDoDetails alloc] initWithNibName:@"ToDoDetails" bundle:nil];
    
    mvc.cContacts=con;
    [self.navigationController pushViewController:mvc animated:YES];
    
    [mvc release]; */
    
   
    Event *newEvent= [self.fetchedResultsController objectAtIndexPath:indexPath];
    
   
    
    EventDetailsViewController *eVC=[[EventDetailsViewController alloc] initWithNibName:@"EventDetailsViewController" bundle:nil];
    
  //  NSLog(@"PushNewEvent=%@",newEvent);
    
    eVC.dataEvent=newEvent;
       [appDelegate.navigationControllerCalendar popToRootViewControllerAnimated:NO];
    [appDelegate.navigationControllerCalendar pushViewController:eVC animated:YES ];
    
    
    
}


-(void)sortArray{
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"birthDate"
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray;
   //// sortedArray = [drinkDetails sortedArrayUsingDescriptors:sortDescriptors];
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
    NSEntityDescription *entity = [NSEntityDescription entityForName:EVENT inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
   // [fetchRequest setReturnsObjectsAsFaults:NO];
    // Set the batch size to a suitable number.
    // [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSPredicate *pre=nil;
 ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    
    
    
    if(self.isSelShowByStatus)
    {
        if(self.selplayerId)
        {
            
            if(self.fetchFirstDate && self.fetchLastDate)
            {
                if([selTeamId isEqualToString:@"Private"])
                {
                    pre=[NSPredicate predicateWithFormat:@"(teamId==%@ OR isPublic==0) AND (userId==%@) AND (startTime >= %@) AND (startTime <= %@) AND (playerId==%@ )",self.selTeamId,[appDelegate.aDef objectForKey:LoggedUserID],self.fetchFirstDate,self.fetchLastDate,self.selplayerId/*,[NSNull null]*/];//OR playerId==\"\" OR playerId==%@
                    
                }
                else if(selTeamId)
                {
                    pre=[NSPredicate predicateWithFormat:@"(teamId==%@) AND (userId==%@) AND (startTime >= %@) AND (startTime <= %@) AND (playerId==%@) AND (isPublicAccept==%i)",self.selTeamId,[appDelegate.aDef objectForKey:LoggedUserID],self.fetchFirstDate,self.fetchLastDate,self.selplayerId,self.selShowByStatus];
                    
                }
                else
                {
                    pre=[NSPredicate predicateWithFormat:@"(userId==%@) AND (startTime >= %@) AND (startTime <= %@) AND (playerId==%@) AND (isPublicAccept==%i)",[appDelegate.aDef objectForKey:LoggedUserID],self.fetchFirstDate,self.fetchLastDate,self.selplayerId,self.selShowByStatus];// AND (isPublic==1)
                }
                
            }
            else
            {
                if([selTeamId isEqualToString:@"Private"])
                {
                    pre=[NSPredicate predicateWithFormat:@"(teamId==%@ OR isPublic==0) AND (userId==%@)  AND (playerId==%@ )",self.selTeamId,[appDelegate.aDef objectForKey:LoggedUserID],self.selplayerId/*,[NSNull null]*/];//OR playerId==\"\" OR playerId==%@
                    
                }
                else if(selTeamId)
                {
                    pre=[NSPredicate predicateWithFormat:@"(teamId==%@) AND (userId==%@)  AND (playerId==%@) AND (isPublicAccept==%i)",self.selTeamId,[appDelegate.aDef objectForKey:LoggedUserID],self.selplayerId,self.selShowByStatus];
                    
                }
                else
                {
                    pre=[NSPredicate predicateWithFormat:@"(userId==%@) AND (playerId==%@) AND (isPublicAccept==%i)",[appDelegate.aDef objectForKey:LoggedUserID],self.selplayerId,self.selShowByStatus];// AND (isPublic==1)
                }
                
            }
            
        }
        else
        {
            
            if(self.fetchFirstDate && self.fetchLastDate)
            {
                if([selTeamId isEqualToString:@"Private"])
                {
                    pre=[NSPredicate predicateWithFormat:@"(teamId==%@ OR isPublic==0) AND (userId==%@) AND (startTime >= %@) AND (startTime <= %@)",self.selTeamId,[appDelegate.aDef objectForKey:LoggedUserID],self.fetchFirstDate,self.fetchLastDate];
                    
                }
                else if(selTeamId)
                {
                    pre=[NSPredicate predicateWithFormat:@"(teamId==%@) AND (userId==%@) AND (startTime >= %@) AND (startTime <= %@) AND (isPublicAccept==%i)",self.selTeamId,[appDelegate.aDef objectForKey:LoggedUserID],self.fetchFirstDate,self.fetchLastDate,self.selShowByStatus];
                    
                }
                else
                {
                    pre=[NSPredicate predicateWithFormat:@"(userId==%@) AND (startTime >= %@) AND (startTime <= %@) AND (isPublicAccept==%i)",[appDelegate.aDef objectForKey:LoggedUserID],self.fetchFirstDate,self.fetchLastDate,self.selShowByStatus];// AND (isPublic==1)
                }
                
            }
            else
            {
                if([selTeamId isEqualToString:@"Private"])
                {
                    pre=[NSPredicate predicateWithFormat:@"(teamId==%@ OR isPublic==0) AND (userId==%@)",self.selTeamId,[appDelegate.aDef objectForKey:LoggedUserID]];
                    
                }
                else if(selTeamId)
                {
                    pre=[NSPredicate predicateWithFormat:@"(teamId==%@) AND (userId==%@) AND (isPublicAccept==%i)",self.selTeamId,[appDelegate.aDef objectForKey:LoggedUserID],self.selShowByStatus];
                    
                }
                else
                {
                    pre=[NSPredicate predicateWithFormat:@"(userId==%@) AND (isPublicAccept==%i)",[appDelegate.aDef objectForKey:LoggedUserID],self.selShowByStatus];// AND (isPublic==1)
                }
                
            }
            
        }
    }
    else
    {
        if(self.selplayerId)
        {
            
            if(self.fetchFirstDate && self.fetchLastDate)
            {
                if([selTeamId isEqualToString:@"Private"])
                {
                    pre=[NSPredicate predicateWithFormat:@"(teamId==%@ OR isPublic==0) AND (userId==%@) AND (startTime >= %@) AND (startTime <= %@) AND (playerId==%@ )",self.selTeamId,[appDelegate.aDef objectForKey:LoggedUserID],self.fetchFirstDate,self.fetchLastDate,self.selplayerId/*,[NSNull null]*/];//OR playerId==\"\" OR playerId==%@
                    
                }
                else if(selTeamId)
                {
                    pre=[NSPredicate predicateWithFormat:@"(teamId==%@) AND (userId==%@) AND (startTime >= %@) AND (startTime <= %@) AND (playerId==%@)",self.selTeamId,[appDelegate.aDef objectForKey:LoggedUserID],self.fetchFirstDate,self.fetchLastDate,self.selplayerId];
                    
                }
                else
                {
                    pre=[NSPredicate predicateWithFormat:@"(userId==%@) AND (startTime >= %@) AND (startTime <= %@) AND (playerId==%@)",[appDelegate.aDef objectForKey:LoggedUserID],self.fetchFirstDate,self.fetchLastDate,self.selplayerId];// AND (isPublic==1)
                }
                
            }
            else
            {
                if([selTeamId isEqualToString:@"Private"])
                {
                    pre=[NSPredicate predicateWithFormat:@"(teamId==%@ OR isPublic==0) AND (userId==%@)  AND (playerId==%@ )",self.selTeamId,[appDelegate.aDef objectForKey:LoggedUserID],self.selplayerId/*,[NSNull null]*/];//OR playerId==\"\" OR playerId==%@
                    
                }
                else if(selTeamId)
                {
                    pre=[NSPredicate predicateWithFormat:@"(teamId==%@) AND (userId==%@)  AND (playerId==%@)",self.selTeamId,[appDelegate.aDef objectForKey:LoggedUserID],self.selplayerId];
                    
                }
                else
                {
                    pre=[NSPredicate predicateWithFormat:@"(userId==%@) AND (playerId==%@)",[appDelegate.aDef objectForKey:LoggedUserID],self.selplayerId];// AND (isPublic==1)
                }
                
            }
            
        }
        else
        {
            
            if(self.fetchFirstDate && self.fetchLastDate)
            {
                if([selTeamId isEqualToString:@"Private"])
                {
                    pre=[NSPredicate predicateWithFormat:@"(teamId==%@ OR isPublic==0) AND (userId==%@) AND (startTime >= %@) AND (startTime <= %@)",self.selTeamId,[appDelegate.aDef objectForKey:LoggedUserID],self.fetchFirstDate,self.fetchLastDate];
                    
                }
                else if(selTeamId)
                {
                    pre=[NSPredicate predicateWithFormat:@"(teamId==%@) AND (userId==%@) AND (startTime >= %@) AND (startTime <= %@)",self.selTeamId,[appDelegate.aDef objectForKey:LoggedUserID],self.fetchFirstDate,self.fetchLastDate];
                    
                }
                else
                {
                    pre=[NSPredicate predicateWithFormat:@"(userId==%@) AND (startTime >= %@) AND (startTime <= %@)",[appDelegate.aDef objectForKey:LoggedUserID],self.fetchFirstDate,self.fetchLastDate];// AND (isPublic==1)
                }
                
            }
            else
            {
                if([selTeamId isEqualToString:@"Private"])
                {
                    pre=[NSPredicate predicateWithFormat:@"(teamId==%@ OR isPublic==0) AND (userId==%@)",self.selTeamId,[appDelegate.aDef objectForKey:LoggedUserID]];
                    
                }
                else if(selTeamId)
                {
                    pre=[NSPredicate predicateWithFormat:@"(teamId==%@) AND (userId==%@)",self.selTeamId,[appDelegate.aDef objectForKey:LoggedUserID]];
                    
                }
                else
                {
                    pre=[NSPredicate predicateWithFormat:@"(userId==%@)",[appDelegate.aDef objectForKey:LoggedUserID]];// AND (isPublic==1)
                }
                
            }
            
        }
    }
    
    
    
    
    
    
    
    
    
    
  ////////////////////////////////////////////////////////////////////////////////////////////////////////
     [fetchRequest setPredicate:pre];
    NSSortDescriptor *sortDescriptor = nil;
    NSSortDescriptor *dateSD =nil;
    if(isAscendingDate==1){
        sortDescriptor=[[NSSortDescriptor alloc] initWithKey:@"arrivalTime" ascending:YES /*selector:@selector(localizedCaseInsensitiveCompare:)*/];
        dateSD = [NSSortDescriptor sortDescriptorWithKey:@"eventDate" ascending:YES];
    }
    else{
        sortDescriptor=[[NSSortDescriptor alloc] initWithKey:@"arrivalTime" ascending:NO /*selector:@selector(localizedCaseInsensitiveCompare:)*/];
        dateSD = [NSSortDescriptor sortDescriptorWithKey:@"eventDate" ascending:NO];
    }
    
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    //sortDescriptor=[[NSSortDescriptor alloc] initWithKey:@"startTime" ascending:YES /*selector:@selector(localizedCaseInsensitiveCompare:)*/]; startTime
    //NSSortDescriptor *dateSD = [NSSortDescriptor sortDescriptorWithKey:@"eventDate" ascending:YES];
    
    NSArray *sortDescriptors1 = [NSArray arrayWithObjects:sortDescriptor,dateSD, nil];
    [fetchRequest setSortDescriptors:sortDescriptors1];
  
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    //   
    
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil] ;//@"eventDateString"
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
    
       ////////
    
    
    
    NSArray *arr= [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:nil ];
    
   // NSLog(@"FetchedObjects=%@",arr);
    
   /* for(Event *ev in arr)
    {
        NSLog(@"StartTime=%@",ev.startTime);
    }*/
    
    NSMutableArray *arr1=[arr mutableCopy];
    self.alldelarr=arr1;
    
    return fetchedResultsController;
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
    
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tabView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tabView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[self.tabView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.tabView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tabView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tabView endUpdates];
    //controller=nil;
      self.todayFDate=[self dateFromSD:[NSDate date] ];
    
    NSLog(@"niltodayindexpath");
     self.todayIndexpath=nil;
    [self.tabView reloadData];
    
     if(self.fetchedResultsController.fetchedObjects.count>0)
     {
         [self.tabView scrollToRowAtIndexPath:self.todayIndexpath
                             atScrollPosition:UITableViewScrollPositionTop
                                     animated:YES];
         self.tabView.hidden=NO;
         self.noeventslab.hidden=YES;
         self.lblPlus.hidden=YES;
         self.noeventsfilterlab.hidden=YES;
         self.noeventsimagevw.hidden=YES;
         self.viewMessage.hidden=NO;
        // self.imageViewMessage.hidden=NO;
         [self performSelector:@selector(hideimageViewMessage) withObject:self afterDelay:3.0];
          self.allfilterbt.hidden=YES;
     }
     else
     {
         self.tabView.hidden=YES;
         // self.noeventsimagevw.hidden=NO;
         self.viewMessage.hidden=YES;
         self.imageViewMessage.hidden=YES;
         if(self.fetchFirstDate==nil && self.fetchLastDate==nil && self.selTeamId==nil && self.selplayerId==nil && self.isSelShowByStatus==0)
         {
             self.noeventslab.hidden=NO;
             self.lblPlus.hidden=NO;
             self.noeventsfilterlab.hidden=YES;
              self.allfilterbt.hidden=YES;
             
         }
         else
         {
             self.noeventslab.hidden=YES;
             self.lblPlus.hidden=YES;
             self.noeventsfilterlab.hidden=NO;
              self.allfilterbt.hidden=NO;
         }
         
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

- (IBAction)allFilterAction:(id)sender
{
  
 /////////
    NSDate *currdate=[[NSDate alloc] init];
    
    self.fetchedResultsController=nil;
    self.todayIndexpath=nil;
    self.todayFDate=[self dateFromSD:currdate ];
    self.fetchFirstDate=nil;
    self.fetchLastDate=nil;
    self.selTeamId=nil;
    self.selplayerId=nil;
    self.selShowByStatus=0;
    self.isSelShowByStatus=0;
    self.isAscendingDate=1;
     // [self loadTable];
    [self.tabView reloadData];
    if(self.fetchedResultsController.fetchedObjects.count>0)
    {
        [self.tabView scrollToRowAtIndexPath:self.todayIndexpath
                                      atScrollPosition:UITableViewScrollPositionTop
                                              animated:YES];
        self.tabView.hidden=NO;
        self.noeventslab.hidden=YES;
        self.lblPlus.hidden=YES;
        self.noeventsfilterlab.hidden=YES;
        self.allfilterbt.hidden=YES;
        self.noeventsimagevw.hidden=YES;
        self.viewMessage.hidden=NO;
      //  self.imageViewMessage.hidden=NO;
        [self performSelector:@selector(hideimageViewMessage) withObject:self afterDelay:3.0];

    }
    else
    {
        self.tabView.hidden=YES;
      //  self.noeventsimagevw.hidden=NO;
        self.viewMessage.hidden=YES;
        self.imageViewMessage.hidden=YES;
        if(self.fetchFirstDate==nil && self.fetchLastDate==nil && self.selTeamId==nil && self.selplayerId==nil && self.isSelShowByStatus==0)
        {
            self.noeventslab.hidden=NO;
            self.lblPlus.hidden=NO;
            self.noeventsfilterlab.hidden=YES;
            self.allfilterbt.hidden=YES;
        }
        else
        {
            self.noeventslab.hidden=YES;
            self.lblPlus.hidden=YES;
            self.noeventsfilterlab.hidden=NO;
            self.allfilterbt.hidden=NO;
        }
    }
    
}

-(void)hideimageViewMessage{
    
    self.imageViewMessage.hidden=YES;
}


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


@end
