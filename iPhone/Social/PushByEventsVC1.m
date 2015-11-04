//
//  ToDoByEventsVC.m
//  LinkBook
//
//  Created by Piyali on 06/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "EventDetailsViewController.h"
#import "PushByEventsVC1.h"

@implementation PushByEventsVC1

@synthesize alldelarr,tabView,grayf,dGrayColor,grayColor,redf,todayIndexpath,todayFDate,delegate,popOver,isExistData;


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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nilDelegate:) name:CENTERVIEWONTROLLERSETNIL object:nil];
    // Do any additional setup after loading the view from its nib.
    self.dGrayColor=[UIColor darkGrayColor];
    self.grayf=[UIFont systemFontOfSize:17];
     self.grayColor=[UIColor grayColor];
        self.redf=[UIFont systemFontOfSize:12];
    self.privateDotImage=[UIImage imageNamed:@"Dot-Image-with-P-text.png"];
    self.publicDotImage=[UIImage imageNamed:@"Grey dot.png"];
    
    self.todayIndexpath=nil;
    self.todayFDate=[self dateFromSD:[NSDate date] ];
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
    return 44.0f;
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
    EventPushCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    //    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell=(EventPushCell *)[EventPushCell cellFromNibNamed:@"EventPushCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
    }
    
	[self configureCell:cell atIndexPath:indexPath];
    
        return cell;
}


- (void)configureCell:(UITableViewCell *)cell1 atIndexPath:(NSIndexPath *)indexPath
{
    EventPushCell *cell=(EventPushCell*)cell1;
    
    
    
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
    
    
    cell.detailslabName.text =newEvent.eventName;
    cell.detailslabField.text =newEvent.fieldName;
    cell.backgroundStatusView.backgroundColor=[UIColor whiteColor];
    cell.detailslabName.textColor=appDelegate.cellRedColor;
    cell.detailslabField.textColor=[UIColor darkGrayColor];
    cell.detailslabTime.textColor=[UIColor darkGrayColor];
    /*if([newEvent.isPublic boolValue])
    {
        cell.detailslabName.frame=CGRectMake(150, 6, 160, 16);
        
        cell.leftimav.image =self.publicDotImage;
        
        if([newEvent.isPublicAccept boolValue])
        {
            cell.backgroundStatusView.backgroundColor=appDelegate.cellRedColor;
            cell.detailslabName.textColor=[UIColor whiteColor];
            cell.detailslabField.textColor=[UIColor lightGrayColor];
            cell.detailslabTime.textColor=[UIColor lightGrayColor];
            
        }
    }
    else
    {
        cell.detailslabName.frame=CGRectMake(150, 11, 160, 16);
        cell.leftimav.image =self.privateDotImage;
    }*/
    
    
    cell.detailslabTime.text = [appDelegate.dateFormatDb stringFromDate:newEvent.startTime ];
    
    
    
    
    if(!todayIndexpath)
    {
        if([newEvent.eventDate compare:self.todayFDate]!=NSOrderedAscending)
        {
            self.todayIndexpath=indexPath;
        }
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
   /* Contacts *con=[self.fetchedResultsController objectAtIndexPath:indexPath];
    
    
    ToDoDetails *mvc =[[ToDoDetails alloc] initWithNibName:@"ToDoDetails" bundle:nil];
    
    mvc.cContacts=con;
    [self.navigationController pushViewController:mvc animated:YES];
    
    [mvc release]; */
    
  
    
    
    
    
    Event *newEvent= [self.fetchedResultsController objectAtIndexPath:indexPath];
    
   
   
    if(delegate)
    {
    if([delegate respondsToSelector:@selector(didSelectEvent::)])
    {
        [delegate didSelectEvent:newEvent:self.popOver];
    }
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
    NSEntityDescription *entity = [NSEntityDescription entityForName:EVENT inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    // [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
  
   // NSPredicate *pre=[NSPredicate predicateWithFormat:@"(date>%@) AND (done==%@)",[NSDate date],[NSString stringWithFormat:@"0"]];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"eventDate" ascending:YES /*selector:@selector(localizedCaseInsensitiveCompare:)*/];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
  //  [fetchRequest setPredicate:pre];
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    //   
      [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"isPublicAccept == %@ AND userId==%@",[NSNumber numberWithInt:1],[appDelegate.aDef objectForKey:LoggedUserID]]];
    
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
    [self.tabView reloadData];
    
    if(delegate)
    {
    if([delegate respondsToSelector:@selector(didChangeNumberOfEvents:)])
    {
        [delegate didChangeNumberOfEvents:[NSString stringWithFormat:@"%i",self.fetchedResultsController.fetchedObjects.count]];
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

@end
