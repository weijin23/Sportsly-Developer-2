//
//  ToDoByEventsVC.m
//  LinkBook
//
//  Created by Piyali on 06/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "HomeVC.h"
#import "EventDetailsViewController.h"
#import "PushByEventsVC.h"
#import "FPPopoverController.h"
#import "Invite.h"
#import "PushByEventsVCCell.h"
@implementation PushByEventsVC

@synthesize alldelarr,tabView,grayf,dGrayColor,grayColor,redf,todayIndexpath,todayFDate,delegate,popOver,isExistData,dataImages,loadStatus,lastSelIndexPath,lastSelStatus;


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
    self.delegate=nil;
    self.privateDotImage=nil;
    self.publicDotImage=nil;
    
    
    self.fetchedResultsController.delegate=nil;
    self.fetchedResultsController=nil;
        
        
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENTBYPUSHIMAGELOADED object:nil];
         
            [[NSNotificationCenter defaultCenter] removeObserver:self name:INVITEFRIENDSSTATUS object:nil];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
  
}
-(void)nilDelegate:(id)sender
{
    self.delegate=nil;
    self.fetchedResultsController=nil;
    self.fetchedResultsController.delegate=nil;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
  
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    
    
    [super viewDidLoad];
    self.storeCreatedRequests=[[NSMutableArray alloc] init];
    self.dataImages=[[NSMutableArray alloc] init];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nilDelegate:) name:CENTERVIEWONTROLLERSETNIL object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageUpdated:) name:EVENTBYPUSHIMAGELOADED object:nil];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userListUpdated:) name:INVITEFRIENDSSTATUS object:nil];
   
    
    // Do any additional setup after loading the view from its nib.
    self.topview.backgroundColor=appDelegate.barGrayColor;
   // self.view.backgroundColor=appDelegate.backgroundPinkColor;
    self.dGrayColor=[UIColor darkGrayColor];
    self.grayf=[UIFont systemFontOfSize:17];
    self.grayColor=[UIColor grayColor];
        self.redf=[UIFont systemFontOfSize:12];
    self.privateDotImage=[UIImage imageNamed:@"Dot-Image-with-P-text.png"];
    self.publicDotImage=[UIImage imageNamed:@"Grey dot.png"];
    
    self.todayIndexpath=nil;
    self.todayFDate=[self dateFromSD:[NSDate date] ];
    
    [self.dataImages removeAllObjects];
    [self.tabView reloadData];
    if(delegate)
    {
        if([delegate respondsToSelector:@selector(didChangeNumberOfEvents:)])
        {
            [delegate didChangeNumberOfEvents:[NSString stringWithFormat:@"%i",self.fetchedResultsController.fetchedObjects.count]];
        }
    }
   /* [self.tabView scrollToRowAtIndexPath:self.todayIndexpath
                         atScrollPosition:UITableViewScrollPositionTop
                                 animated:YES];*/
    
  
   /* self.selContactNew=[[SelectContact alloc] initWithNibName:@"SelectContact" bundle:nil];
    [self.selContactNew view];*/
    
    
    if(self.fetchedResultsController.fetchedObjects.count>0)
        self.nolbl.hidden=YES;
    else
     self.nolbl.hidden=NO;
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
        self.tabView.hidden=NO;
        self.nolbl.hidden=YES;
    }
    else
    {
        self.tabView.hidden=YES;
        self.nolbl.hidden=NO;
    }
}


- (void)viewDidUnload
{
    [self setNolbl:nil];
    [self setPlusbuttoninvitefriendbt:nil];
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
    return 0.0;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    
    NSLog(@"NOF=-%i",[sectionInfo numberOfObjects]);
    return [sectionInfo numberOfObjects];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    
    static NSString *CellIdentifier = @"PushByEventsVCCell";
    
    PushByEventsVCCell *cell = [self.tabView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = (PushByEventsVCCell *)[PushByEventsVCCell cellFromNibNamed:CellIdentifier];
           cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;

}


- (void)configureCell:(PushByEventsVCCell *)cell1 atIndexPath:(NSIndexPath *)indexPath
{
  
    
    
    
    Invite *newEvent= [self.fetchedResultsController objectAtIndexPath:indexPath];

    cell1.senderName.text=newEvent.teamName;//[[NSString alloc] initWithFormat:@"%@ Team",newEvent.teamName];
    cell1.teamName.text=newEvent.eventName;//[[NSString alloc] initWithFormat:@"%@ Event",newEvent.eventName];
       
    
    cell1.statusLabel.hidden=NO;
    cell1.acceptBtn.hidden=YES;
    cell1.declineBtn.hidden=YES;
    
    
   /* [cell1.acceptBtn addTarget:self action:@selector(acceptInvite:) forControlEvents:UIControlEventTouchUpInside];
    
     [cell1.declineBtn addTarget:self action:@selector(declineInvite:) forControlEvents:UIControlEventTouchUpInside];*/
    
   /*if( newEvent.inviteStatus.intValue==0)
   {
       cell1.statusLabel.hidden=YES;
       cell1.acceptBtn.hidden=NO;
       cell1.declineBtn.hidden=NO;
   }
    else if( newEvent.inviteStatus.intValue==1)
    {
        cell1.statusLabel.text=@"Accepted";
    }
    else
    {
        cell1.statusLabel.text=@"Declined";
    }*/
     cell1.statusLabel.text=[self getDateTimeForHistory:newEvent.datetime];
  
    ImageInfo * info1=nil;
    
    NSLog(@"%i--%i",(self.dataImages.count-1),indexPath.row);
    
    int check=(self.dataImages.count-1);
    
    
    if(indexPath.row<=check)
    {
         info1 = [self.dataImages objectAtIndex:indexPath.row];
    }
    else
    {
        info1=[[ImageInfo alloc] initWithSourceURL:[[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"%@%@",TEAM_LOGO_URL, newEvent.teamLogo ]]];
        
        [self.dataImages insertObject:info1 atIndex:indexPath.row];
    }

    if(info1.image)
    {
        [cell1.posted setImage:info1.image   ];
        
        
    }
    else
    {
        cell1.posted.image=self.noImage;
        info1.notificationName=EVENTBYPUSHIMAGELOADED;
        info1.notifiedObject=[NSNumber numberWithInt:indexPath.row];
        if(!info1.isProcessing)
            [info1 getImage];
    }


}


/*-(void)acceptInvite:(UIButton*)sender
{
    if(loadStatus)
        return;
    
       self.loadStatus=1;
    PushByInviteFriendCell *cell=(PushByInviteFriendCell*) sender.superview.superview;
    
    NSIndexPath *indexPath= [self.tabView indexPathForCell:cell ];
    
    self.lastSelIndexPath=indexPath;
    Invite *newinvite=[self.fetchedResultsController objectAtIndexPath:indexPath];
     NSString *str=nil;
     str=@"Accept";
    lastSelStatus=1;
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
    
  
 
    SingleRequest *sinReq=nil;
    sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:INVITEFRIENDSSTATUSLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
    self.sinReq1=sinReq;
    [self.storeCreatedRequests addObject:self.sinReq1];
    sinReq.notificationName=INVITEFRIENDSSTATUS;
    
    [sinReq startRequest];
}*/

/*-(void)declineInvite:(UIButton*)sender
{
    if(loadStatus)
        return;
    
    
        self.loadStatus=1;
   PushByInviteFriendCell *cell=(PushByInviteFriendCell*) sender.superview.superview;
    
   NSIndexPath *indexPath= [self.tabView indexPathForCell:cell ];
      self.lastSelIndexPath=indexPath;
    
    Invite *newinvite=[self.fetchedResultsController objectAtIndexPath:indexPath];
    NSString *str=nil;
   
    str=@"Decline";
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
    
    
    
   
    
    
    SingleRequest *sinReq=nil;
    sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:INVITEFRIENDSSTATUSLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
    self.sinReq1=sinReq;
    [self.storeCreatedRequests addObject:self.sinReq1];
    sinReq.notificationName=INVITEFRIENDSSTATUS;
    
    [sinReq startRequest];

    
}*/


-(void)userListUpdated:(id)sender
{
    
    loadStatus=0;
    [self hideNativeHudView];
    SingleRequest *sReq=(SingleRequest*)[sender object];
    if([sReq.notificationName isEqualToString:INVITEFRIENDSSTATUS])
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
                        
                        
                        
                        
                        
                        
                        
                       Invite *newEvent=[self.fetchedResultsController objectAtIndexPath:self.lastSelIndexPath];
                        
                        
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
                        newEvent.inviteStatus=[[NSNumber alloc] initWithInt:lastSelStatus ];
                        
                        
                        
                      
                        
                        
                       
                        
                        
                        
                            
                       
                        
                        
                        
                        ///////////////////////
                        
                      
                        
                        
                        
                        
                       
                        
                        [appDelegate saveContext];
                        
                        
                        
                        
                        //////////////////
                            
                        
                        
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
     
    Invite *event=[self.fetchedResultsController objectAtIndexPath:indexPath];
    
    
    
    
    // [self.centerViewController showNavController:self.navigationControllerCalendar];
     EventDetailsViewController *eVC=[[EventDetailsViewController alloc] initWithNibName:@"EventDetailsViewController" bundle:nil];
    eVC.isFromPushBadge=1;
     eVC.eventId=event.eventId;
     eVC.isFromPush=1;
     eVC.playername=event.playerName;
     eVC.playerid=event.playerId;
     eVC.playeruserid=event.playerUserId;
    
    eVC.evUnreadevent=event;
     [appDelegate.navigationControllerTeamInvites pushViewController:eVC animated:YES ];
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
   // NSEntityDescription *entity = [NSEntityDescription entityForName:EVENTUNREAD inManagedObjectContext:self.managedObjectContext];
   // [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    // [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
  
    NSPredicate *pre=[NSPredicate predicateWithFormat:@"(userId=%@) AND type==%i",[appDelegate.aDef objectForKey:LoggedUserID],5];        //////  AD 29th May 2015
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"datetime" ascending:NO /*selector:@selector(localizedCaseInsensitiveCompare:)*/];
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
            [self configureCell:(PushByEventsVCCell*)[self.tabView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.tabView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tabView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
     NSLog(@"controllerDidChangeContent:2");
    [self.tabView endUpdates];
    //controller=nil;
    [self.dataImages removeAllObjects];
    [self.tabView reloadData];
    
    if(delegate )
    {
        if([delegate respondsToSelector:@selector(didChangeNumberOfEvents:)])
        {
            [delegate didChangeNumberOfEvents:[NSString stringWithFormat:@"%i",self.fetchedResultsController.fetchedObjects.count]];
        }
    }
    
    if(self.fetchedResultsController.fetchedObjects.count>0)
        self.nolbl.hidden=YES;
    else
        self.nolbl.hidden=NO;
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
    }
    else if(tag==1)
    {
        /*[self.navigationController pushViewController:self.selContactNew animated:YES];
        
        [self.selContactNew resetData];*/
    }
    
    
}

@end
