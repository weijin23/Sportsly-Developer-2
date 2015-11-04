//
//  CalendarViewController.m
//  Social
//
//  Created by Sukhamoy Hazra on 22/08/13.
//
//
#import "AppDelegate.h"
#import "PlayerListViewController.h"
#import "EventCalendarViewController.h"
#import "EventDetailsViewController.h"
#import "Event.h"
#import "CalendarViewController.h"
#import "EventCell.h"
#import "CenterViewController.h"
#import "PlayerListViewController.h"
@interface CalendarViewController ()

@end

@implementation CalendarViewController
@synthesize privateDotImage,publicDotImage,selTeamId,crossImage,tickImage,questionmarkImage,selplayerId,selShowByStatus,isSelShowByStatus,maybeQuestionmarkImage;
@synthesize playerAttendance;
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    // Do any additional setup after loading the view from its nib.
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}


- (NSUInteger) supportedInterfaceOrientations{
	return  UIInterfaceOrientationMaskPortrait;
}
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}


#pragma mark View Lifecycle
- (void) viewDidLoad
{
	[super viewDidLoad];
    
    @autoreleasepool {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            self.tickImage=[UIImage imageNamed:@"accepted_image_invite_ipad.png"];//acceptinvite.png
            self.crossImage=[UIImage imageNamed:@"decile_image_invite_ipad.png"];//declineinvite.png
            self.questionmarkImage=[UIImage imageNamed:@"reminder_send_invite_ipad.png"];
            self.maybeQuestionmarkImage=[UIImage imageNamed:@"maybe_image_invite_ipad.png"];
        }
        else{
            
            self.tickImage=[UIImage imageNamed:@"accepted_image_invite.png"];//acceptinvite.png
            self.crossImage=[UIImage imageNamed:@"decile_image_invite.png"];//declineinvite.png
            self.questionmarkImage=[UIImage imageNamed:@"reminder_send_invite.png"];
            self.maybeQuestionmarkImage=[UIImage imageNamed:@"maybe_image_invite.png"];
        }
    }
   /* @autoreleasepool {
        
        
        self.tickImage=[UIImage imageNamed:@"accepted_image.png"];//acceptinvite.png
        self.questionmarkImage=[UIImage imageNamed:@"reminder_send.png"];//noresponsemaybe.png
        self.crossImage=[UIImage imageNamed:@"decile_image.png"];//declineinvite.png
        self.maybeQuestionmarkImage=[UIImage imageNamed:@"invite_send.png"];//maybeinvite.png
    }*/
	self.title = NSLocalizedString(@"Month Grid", @"");
	[self.monthView selectDate:[NSDate date]];
    self.privateDotImage=[UIImage imageNamed:@"Dot-Image-with-P-text.png"];
    self.publicDotImage=[UIImage imageNamed:@"Grey dot.png"];
    
    
    
   
    [self.monthView selectDate:[NSDate date]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
     [self.monthView reloadData];
    
    
}

#pragma mark MonthView Delegate & DataSource
- (NSArray*) calendarMonthView:(TKCalendarMonthView*)monthView marksFromDate:(NSDate*)startDate toDate:(NSDate*)lastDate
{
	[self generateRandomDataForStartDate:startDate endDate:lastDate];
	return self.dataArray;
}
- (void) calendarMonthView:(TKCalendarMonthView*)monthView didSelectDate:(NSDate*)date{
	NSLog(@"Date Selected: %@",date);
	[self.tableView reloadData];
    
    
    
   AppDelegate *appDelegate= (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [ (EventCalendarViewController*)[appDelegate.navigationControllerCalendar.viewControllers objectAtIndex:0] setCurrentSelectedDate:date];
}
- (void) calendarMonthView:(TKCalendarMonthView*)mv monthDidChange:(NSDate*)d animated:(BOOL)animated{
	[super calendarMonthView:mv monthDidChange:d animated:animated];
	[self.tableView reloadData];
}


#pragma mark UITableView Delegate & DataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSArray *ar = self.dataDictionary[[self.monthView dateSelected]];
	if(ar == nil) return 0;
	return [ar count];
}
- (UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    static NSString *CellIdentifier = @"Cell";
    
    //EventCell *cell=[[EventCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
     tv.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    EventCell *cell=[tv dequeueReusableCellWithIdentifier:@"Cell"];
//    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell=(EventCell *)[EventCell cellFromNibNamed:@"EventCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
    }
      AppDelegate *appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
	NSArray *ar = self.dataDictionary[[self.monthView dateSelected]];
    
    Event *newEvent= ar[indexPath.row];
    
    
    ////////////////////
    if([newEvent.teamName isEqualToString:@"Private"] || (!newEvent.isPublic.boolValue))
    {
        cell.rosterbt.hidden=YES;
            cell.rosterIma.hidden=YES;
    }
    else
    {
        cell.rosterbt.hidden=NO;
            cell.rosterIma.hidden=NO;
    }
    
      [cell.rosterbt addTarget:self action:@selector(rosterAction:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.detailslabEventName.text=newEvent.eventName;
    cell.detailslabName.text =newEvent.playerName;//newEvent.eventName;//Add Latest Ch
   
    cell.backgroundStatusView.backgroundColor=[UIColor whiteColor];
  /*  cell.detailslabName.textColor=[UIColor blackColor];
    cell.detailslabField.textColor=[UIColor blackColor];
    cell.detailslabTime.textColor=[UIColor blackColor];*///Add Latest Ch
    
        cell.leftimav.image =self.tickImage;//Add Latest Ch
    if([newEvent.isPublic boolValue])
    {
              
    
        
        if([newEvent.isPublicAccept intValue]==1 )
        {
    
            
            cell.leftimav.image =self.questionmarkImage;
       

        }
        else if([newEvent.isPublicAccept intValue]==2)
        {
            
            cell.leftimav.image =self.crossImage;
        }
        else if([newEvent.isPublicAccept intValue]==3)
        {
            
            cell.leftimav.image =self.maybeQuestionmarkImage;
            
        }
    }
    else
    {
         
   
    }
  
  
    /*if([newEvent.isPublic boolValue]==0)
        cell.detailslabTime.text = [appDelegate.dateFormatM stringFromDate:newEvent.startTime ];
    else
        cell.detailslabTime.text = [appDelegate.dateFormatM stringFromDate:newEvent.arrivalTime ];*/
    if([newEvent.isPublic boolValue]==0)
    {
        cell.detailslabField.text =[[NSString alloc] initWithFormat:@"%@, %@", [appDelegate.dateFormatEventShort stringFromDate:newEvent.eventDate ] ,[appDelegate.dateFormatM stringFromDate:newEvent.startTime ]];//newEvent.teamName;//Add Latest Ch
       
    }
    else
    {
        cell.detailslabField.text = [[NSString alloc] initWithFormat:@"%@, %@", [appDelegate.dateFormatEventShort stringFromDate:newEvent.eventDate ],[appDelegate.dateFormatM stringFromDate:newEvent.arrivalTime ] ] ;//newEvent.teamName;//Add Latest Ch
      
    }
    
  //   cell.detailslabField.text =[appDelegate.dateFormatEventShort stringFromDate:newEvent.eventDate ];
    
      
    cell.detailslabTeamName.text=newEvent.teamName;
    
    
    /*if(((indexPath.row+1)%3))
    {
        cell.separator.hidden=YES;
    }
    else
    {
        cell.separator.hidden=NO;
    }*/
    
    /////////////////////
    return cell;
	
}

-(void)rosterAction:(UIButton*)sender
{
    EventCell *cell=nil;
    
   AppDelegate *appDelegate= (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    if(appDelegate.isIos7)
        cell= (EventCell*)sender.superview.superview.superview;
    else
        cell= (EventCell*)sender.superview.superview;
    
    NSIndexPath *indexPath=[self.tableView indexPathForCell:cell];
    
    NSArray *ar = self.dataDictionary[[self.monthView dateSelected]];
    Event *newEvent= ar[indexPath.row];
    
    PlayerListViewController *player=[[PlayerListViewController alloc] initWithNibName:@"PlayerListViewController" bundle:nil];
    self.playerAttendance=player;
    player.eventId=newEvent.eventId;
    player.teamId=newEvent.teamId;
    
    
      [appDelegate.navigationControllerCalendar pushViewController:player animated:YES];
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *ar = self.dataDictionary[[self.monthView dateSelected]];
    Event *newEvent= ar[indexPath.row];
    
     AppDelegate *appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    EventDetailsViewController *eVC=[[EventDetailsViewController alloc] initWithNibName:@"EventDetailsViewController" bundle:nil];
    eVC.dataEvent=newEvent;
    
    [appDelegate.navigationControllerCalendar popToRootViewControllerAnimated:NO];
    [appDelegate.navigationControllerCalendar pushViewController:eVC animated:YES ];
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




- (void) generateRandomDataForStartDate:(NSDate*)start endDate:(NSDate*)end
{
	// this function sets up dataArray & dataDictionary
	// dataArray: has boolean markers for each day to pass to the calendar view (via the delegate function)
	// dataDictionary: has items that are associated with date keys (for tableview)
	
    AppDelegate *appDelegate= (AppDelegate*)[[UIApplication sharedApplication] delegate];
	
	NSLog(@"Delegate Range: %@ %@ %d",start,end,[start daysBetweenDate:end]);
	
	self.dataArray = [NSMutableArray array];
	self.dataDictionary = [NSMutableDictionary dictionary];
	
	NSDate *d = start;
	while(YES)
    {
		
        
        NSArray *arr=[appDelegate.centerViewController objectOfType1EventStartDate:[appDelegate.centerViewController dateFromSD:d] EndDate:[appDelegate.centerViewController dateFromSDLast:d]:self.selTeamId:self.selplayerId:self.isSelShowByStatus:self.selShowByStatus];
        
        NSLog(@"EventCount=%i,Date=%@",arr.count,[appDelegate.dateFormatDb stringFromDate:d]);
        
		/*NSInteger r = arc4random();
		if(r % 3==1){
			(self.dataDictionary)[d] = @[@"Item one",@"Item two"];
			[self.dataArray addObject:@YES];
			
		}else if(r%4==1){
			(self.dataDictionary)[d] = @[@"Item one"];
			[self.dataArray addObject:@YES];
			
		}else
			[self.dataArray addObject:@NO];*/
		
		if(arr.count>0)
        {
			(self.dataDictionary)[d] = arr;
			[self.dataArray addObject:@YES];
			
		}
        else
			[self.dataArray addObject:@NO];
		
        
        
        
        
		NSDateComponents *info = [d dateComponentsWithTimeZone:self.monthView.timeZone];
		info.day++;
		d = [NSDate dateWithDateComponents:info];
		if([d compare:end]==NSOrderedDescending) break;
	}
	
}


@end
