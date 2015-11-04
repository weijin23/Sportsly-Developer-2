//
//  MySchduleViewController.m
//  Wall
//
//  Created by Sukhamoy on 28/11/13.
//
//

#import "MySchduleViewController.h"
#import "CenterViewController.h"
#import "RightVCTableCell.h"
#import "RightVCTableData.h"
#import "RightViewController.h"
#import "RosterCell.h"
#import "EventDetailsViewController.h"
#import "HomeVC.h"
#import "PlayerListViewController.h"
#import "PlayerDetails.h"

@interface MySchduleViewController ()<UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate>

@end

@implementation MySchduleViewController
@synthesize alldelarr,grayf,dGrayColor,grayColor,redf,todayIndexpath,todayFDate,selTeamId;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=appDelegate.backgroundPinkColor;
    self.topview.backgroundColor=appDelegate.barGrayColor;

    
    self.dGrayColor=[UIColor darkGrayColor];
    self.grayf=[UIFont systemFontOfSize:17];
    self.grayColor=[UIColor grayColor];
    self.redf=[UIFont systemFontOfSize:12];
    self.privateDotImage=[UIImage imageNamed:@"Dot-Image-with-P-text.png"];
    self.publicDotImage=[UIImage imageNamed:@"Grey dot.png"];
    
    self.rosterTable.separatorColor=[UIColor lightGrayColor];
    
    self.rosterTable.hidden=NO;
    [self updateEventList];
    self.rosterTable.delegate=self;
    self.rosterTable.dataSource=self;
    [self.rosterTable reloadData];

   
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:RIGHTVCPLAYERIMAGELOADED object:nil];

    self.todayIndexpath=nil;
    self.privateDotImage=nil;
    self.publicDotImage=nil;
    [dGrayColor release];
    [grayf release];
    [grayColor release];
    [redf release];
    [_showSettings release];
    [_rosterTable release];
    [super dealloc];
}
- (void)viewDidUnload
{
    
    [super viewDidUnload];
}




-(void)updateEventList{
    
    if (appDelegate.centerVC.dataArrayUpButtonsIds.count>0) {
        
        NSDate *currentDate=[[NSDate alloc] init];
        
        self.todayFDate=currentDate;
        [currentDate release];
        //[self dateFromSD:[NSDate date] ];
        
        self.selTeamId=[appDelegate.centerVC.dataArrayUpButtonsIds objectAtIndex:appDelegate.centerVC.lastSelectedTeam];
        self.fetchedResultsController=nil;
        
        [self.rosterTable reloadData];
        
        if(self.fetchedResultsController.fetchedObjects.count>0){
            
        }
    }
    
}


-(void)loadVC{
    
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

        UIView *cellview;
        UIImageView *imaview;
        cellview=[[[UIView alloc] initWithFrame:CGRectMake(0,0,300,21)] autorelease];
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
        
        NSArray *arr1=[sectionInfo objects];
        
        Event *event=(Event*)[arr1 objectAtIndex:0];
        
        NSArray *arr=[event.eventDateString componentsSeparatedByString:@"-"];
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
        
       
}
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 21.0;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (tableView.tag==999) {
        return [[self.fetchedResultsController sections] count];
    }else{
        return [self.appDelegate.JSONDATAarr count];
    }
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
   
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        
        NSLog(@"NOF=-%i",[sectionInfo numberOfObjects]);
        return [sectionInfo numberOfObjects];
        
       
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        return 30.0f;
    }





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        static NSString *CellIdentifier = @"RightVCTableCell";
        UITableViewCell *cell = [self.rosterTable dequeueReusableCellWithIdentifier:CellIdentifier]; ;
        
        if (cell == nil)
        {
            cell=(RosterCell *)[RosterCell cellFromNibNamed:@"RosterCell"];
            cell.selectionStyle=UITableViewCellSelectionStyleGray;
            tableView.separatorColor=[UIColor lightGrayColor];
            
        }
        
        [self configureCell:cell atIndexPath:indexPath andTableView:tableView];
        return cell;
        
       
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        Event *newEvent= [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        EventDetailsViewController *eVC=[[EventDetailsViewController alloc] initWithNibName:@"EventDetailsViewController" bundle:nil];
        
        NSLog(@"PushNewEvent=%@",newEvent);
        
        eVC.dataEvent=newEvent;
        [appDelegate.navigationControllerCalendar popToRootViewControllerAnimated:NO];
        [appDelegate.navigationControllerCalendar pushViewController:eVC animated:YES ];
        [eVC release];
        
        [appDelegate.centerViewController showNavController:appDelegate.navigationControllerCalendar];
        
       
}
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath andTableView:(UITableView*)tableview{
    
        RosterCell *cell1=(RosterCell*)cell;
        Event *newEvent= [fetchedResultsController objectAtIndexPath:indexPath];
        
        cell1.detailslabName.text =newEvent.eventName;
        cell1.detailslabField.text =newEvent.fieldName;
        cell1.detailslabName.textColor=[UIColor darkGrayColor];
        cell1.detailslabField.textColor=[UIColor darkGrayColor];
        cell1.detailslabTime.textColor=[UIColor redColor];
        cell1.rosterBtn.tag=indexPath.row;
        
        if([newEvent.isPublic boolValue])
        {
            
            cell1.leftimav.image =self.publicDotImage;
            cell1.rosterBtn.hidden=NO;
            cell1.rosterImageView.hidden=NO;
            
                  }
        else
        {
            cell1.leftimav.image =self.privateDotImage;
            cell1.rosterBtn.hidden=YES;
            cell1.rosterImageView.hidden=YES;
            
        }
        
        
        cell1.detailslabTime.text = [appDelegate.dateFormatM stringFromDate:newEvent.startTime ];
        
        
        
        
        if(!todayIndexpath)
        {
            if([newEvent.eventDate compare:self.todayFDate]!=NSOrderedDescending)
            {
                self.todayIndexpath=indexPath;
            }
        }
        
       
}



-(void)playerList:(UIButton*)sender{
    
    RosterCell *cell=(RosterCell*)[[sender superview] superview];
    Event *newEvent= [fetchedResultsController objectAtIndexPath:[self.rosterTable indexPathForCell:cell]];
    PlayerListViewController *player=[[PlayerListViewController alloc] initWithNibName:@"PlayerListViewController" bundle:nil];
    self.playerAttendance=player;

    player.eventId=newEvent.eventId;
    [self.navigationController pushViewController:player animated:YES];
    [player release];
    
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)settingsbTapped:(id)sender
{
    
    [self.appDelegate.centerViewController showNavController:appDelegate.navigationControllerSettings];
}


#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (fetchedResultsController != nil)
    {
        NSMutableArray *arr1=[[fetchedResultsController fetchedObjects] mutableCopy];
        self.alldelarr=arr1;
        [arr1 release];
        
        
        return fetchedResultsController;
    }
    
    
    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *entity = [NSEntityDescription entityForName:EVENT inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
   // NSPredicate *pre=[NSPredicate predicateWithFormat:@"eventDate>=%@",[NSDate date]];
    NSPredicate *pre=[NSPredicate predicateWithFormat:@"(eventDate>=%@) AND (userId==%@)",[NSDate date],[appDelegate.aDef objectForKey:LoggedUserID]];
    [fetchRequest setPredicate:pre];
    
    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"eventDate" ascending:YES /*selector:@selector(localizedCaseInsensitiveCompare:)*/] autorelease];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"eventDateString" cacheName:nil] ;
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    [aFetchedResultsController release];
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
        
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    NSArray *arr= [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:nil ];
    NSMutableArray *arr1=[arr mutableCopy];
    self.alldelarr=arr1;
    [arr1 release];
    
    return fetchedResultsController;
}











- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.rosterTable beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.rosterTable insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.rosterTable deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.rosterTable insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.rosterTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[self.rosterTable cellForRowAtIndexPath:indexPath] atIndexPath:indexPath andTableView:self.rosterTable];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.rosterTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.rosterTable insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.rosterTable endUpdates];
    //controller=nil;
    
    [self updateEventList];
    
}


@end
