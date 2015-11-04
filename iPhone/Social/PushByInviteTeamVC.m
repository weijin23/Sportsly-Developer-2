//
//  ToDoByEventsVC.m
//  LinkBook
//
//  Created by Piyali on 06/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "HomeVC.h"
#import "PushByTeamResponseCell.h"
#import "LikesAndCommentsVCCell.h"
#import "EventDetailsViewController.h"
#import "PushByEventsVCCell.h"
#import "EventDetailsViewController.h"
#import "PushByInviteTeamVC.h"
#import "FPPopoverController.h"
#import "SelectContact.h"
#import "PushByInviteTeamCell.h"
#import "InviteDetailsViewController.h"
#import "HomeVCTableData.h"
#import "CenterViewController.h"
#import "PushByCoachUpdateCell.h"
#import "LikeCommentData.h"
#import "PostLikeViewController.h"
#import "CommentVC.h"
#import "EventCalendarViewController.h"
#import "TeamMaintenanceVC.h"

@implementation PushByInviteTeamVC

@synthesize alldelarr,tabView,grayf,dGrayColor,grayColor,redf,todayIndexpath,todayFDate,delegate,popOver,isExistData,selContactNew,dataImages,loadStatus,lastSelIndexPath,lastSelStatus,lastSelRowCoach,timeFont,lastSelRowTeamResponse,likeTimeImavw,commentTimeImavw,lastSelRowEventDelete,lastSelRowEventUpdate,lastSelRowTeamEventResponse,lastSelRowUserTeamEventResponse,userEventResponseRecord,lastSelStatusAdmin;
@synthesize strInviteStatus,isDeclineAdmin;

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
    
     [[NSNotificationCenter defaultCenter] removeObserver:self name:PROCESSACCEPTEVENTFINISHED object:nil];
    
      [[NSNotificationCenter defaultCenter] removeObserver:self name:CENTERVIEWONTROLLERSETNIL object:nil];
      [[NSNotificationCenter defaultCenter] removeObserver:self name:COACHTEAMRESPONSE object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:USERTEAMRESPONSE object:nil];
    
    
     [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENTUPDATEPROCESSCOMPLETE object:nil];
    
    self.delegate=nil;
    self.privateDotImage=nil;
    self.publicDotImage=nil;
    
    
    self.fetchedResultsController.delegate=nil;
    self.fetchedResultsController=nil;
        
        
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:INVITEBYTEAMIMAGELOADED object:nil];
         
            [[NSNotificationCenter defaultCenter] removeObserver:self name:TEAMINVITESTATUSBYPUSH object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ADMININVITESTATUSBYPUSH object:nil];
    

       [[NSNotificationCenter defaultCenter] removeObserver:self name:TEAMINVITESTATUSBYPUSHONTEAMINVITERESPONSE object:nil];
    
  
    ///////////
    [[NSNotificationCenter defaultCenter] removeObserver:self name:COACHUPDATEPUSHLISTINGIMAGELOADED object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:COACHUPDATEVIEWSTATUS object:nil];
    
      [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENTBYPUSHIMAGELOADED object:nil];
    
    
    
     [[NSNotificationCenter defaultCenter] removeObserver:self name:COACHADMINRESPONSE object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENTUPDATEVIEWSTATUS object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENTDELETEVIEWSTATUS object:nil];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UPDATELIKECOMMENTSTATUSVIEW object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:INDIVIDUALPOST object:nil];
    ////////////
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //// AD...iAd
    self.adBanner.delegate = self;
    self.adBanner.alpha = 0.0;
    self.canDisplayBannerAds=YES;
    ////
    
  
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageUpdated:) name:INVITEBYTEAMIMAGELOADED object:nil];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userListUpdated:) name:TEAMINVITESTATUSBYPUSH object:nil];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageUpdatedNewEvent:) name:EVENTBYPUSHIMAGELOADED object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(adminListUpdated:) name:ADMININVITESTATUSBYPUSH object:nil];
    
    
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(processEventUpdated:) name:PROCESSACCEPTEVENTFINISHED object:nil];
    
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(coachTeamResponse:) name:COACHTEAMRESPONSE object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userTeamResponse:) name:USERTEAMRESPONSE object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(coachTeamEventResponse:) name:COACHTEAMEVENTRESPONSE object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userTeamEventResponse:) name:USERTEAMEVENTRESPONSE object:nil];
    
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(eventUpdateViewResponse:) name:EVENTUPDATEVIEWSTATUS object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(eventDeleteViewResponse:) name:EVENTDELETEVIEWSTATUS object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(eventUpdateComplete:) name:EVENTUPDATEPROCESSCOMPLETE object:nil];
 
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userListUpdatedONTEAMINVITERESPONSE:) name:TEAMINVITESTATUSBYPUSHONTEAMINVITERESPONSE object:nil];
    
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(coachAdminResponse:) name:COACHADMINRESPONSE object:nil];
    
    
    /////////////////////For Coach Update
    @autoreleasepool {
         self.dotImage=[UIImage imageNamed:@"Blue Dot.png"];
        self.privateDotImage=[UIImage imageNamed:@"Dot-Image-with-P-text.png"];
        self.publicDotImage=[UIImage imageNamed:@"Grey dot.png"];
        if (self.isiPad) {
            self.helveticaFontForte=[UIFont fontWithName:@"Helvetica" size:20.0];
            self.helveticaFontForteBold=[UIFont fontWithName:@"Helvetica-Bold" size:20.0];
            self.helveticaFont=[UIFont fontWithName:@"Helvetica" size:18.0];
            self.helveticaFontBold=[UIFont fontWithName:@"Helvetica-Bold" size:18.0];
            self.teamNoImage= [UIImage imageNamed:@"no_image.png"];
            self.timeFont=[UIFont fontWithName:@"Helvetica" size:16.0];
            self.likeTimeImavw=[UIImage imageNamed:@"notlike_ipad.png"];
            self.commentTimeImavw=[UIImage imageNamed:@"notcomment_ipad.png"];
            
            self.dGrayColor=[UIColor darkGrayColor];
            self.dGrayColor=[UIColor darkGrayColor];
            self.grayf=[UIFont systemFontOfSize:17];
            self.grayColor=[UIColor grayColor];
            self.redf=[UIFont systemFontOfSize:12];
        }
        else{
            self.helveticaFontForte=[UIFont fontWithName:@"Helvetica" size:14.0];
            self.helveticaFontForteBold=[UIFont fontWithName:@"Helvetica-Bold" size:14.0];
            self.helveticaFont=[UIFont fontWithName:@"Helvetica" size:12.0];
            self.helveticaFontBold=[UIFont fontWithName:@"Helvetica-Bold" size:12.0];
            self.teamNoImage= [UIImage imageNamed:@"no_image.png"];
            self.timeFont=[UIFont fontWithName:@"Helvetica" size:10.0];
            self.likeTimeImavw=[UIImage imageNamed:@"notlike.png"];
            self.commentTimeImavw=[UIImage imageNamed:@"notcomment.png"];
            
            self.dGrayColor=[UIColor darkGrayColor];
            self.grayf=[UIFont systemFontOfSize:17];
            self.grayColor=[UIColor grayColor];
            self.redf=[UIFont systemFontOfSize:12];
        }
        
        //self.privateDotImage=[UIImage imageNamed:@"Dot-Image-with-P-text.png"];
       // self.publicDotImage=[UIImage imageNamed:@"Grey dot.png"];
    }
   // self.dataImages=[[NSMutableArray alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageUpdatedCoachUpdate:) name:COACHUPDATEPUSHLISTINGIMAGELOADED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userListUpdatedCoachUpdate:) name:COACHUPDATEVIEWSTATUS object:nil];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userListUpdatedForCommantStatus:) name:UPDATELIKECOMMENTSTATUSVIEW object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userListUpdatedForComment:) name:INDIVIDUALPOST object:nil];
    
    
    
    
   //////////////////////
   
    
    // Do any additional setup after loading the view from its nib.
    self.topview.backgroundColor=appDelegate.barGrayColor;
   // self.view.backgroundColor=appDelegate.backgroundPinkColor;
  
    
    self.todayIndexpath=nil;
    self.todayFDate=[self dateFromSD:[NSDate date] ];
    
    [self.dataImages removeAllObjects];
    [self.tabView reloadData];
    
    
 
    
    
    if(delegate )
    {
        if([delegate respondsToSelector:@selector(didChangeNumberOfTeamInvites:)])
        {
            NSArray *ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"inviteStatus==0 AND type==%i",0]];
            
            [delegate didChangeNumberOfTeamInvites:[NSString stringWithFormat:@"%i",ar.count]];
        }
    }
    
    
    
    if(delegate )
    {
        if([delegate respondsToSelector:@selector(didChangeNumberOfAdminInvites:)])
        {
            NSArray *ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"inviteStatus==0 AND type==%i",14]];
            
            [delegate didChangeNumberOfAdminInvites:[NSString stringWithFormat:@"%i",ar.count]];
        }
    }
    
    
    if(delegate)
    {
        if([delegate respondsToSelector:@selector(didChangeNumberOfCoachUpdates:)])
        {
            NSArray *ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"inviteStatus==0 AND type==%i",3]];
            
            [delegate didChangeNumberOfCoachUpdates:[NSString stringWithFormat:@"%i",ar.count]];
        }
    }
    
    
    
    if(delegate )
    {
        if([delegate respondsToSelector:@selector(didChangeNumberOfEvents:)])
        {
             NSArray *ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(viewStatus==0 OR viewStatus==nil) AND type==%i",5]];     /////  AD 27th May
            
            [delegate didChangeNumberOfEvents:[NSString stringWithFormat:@"%i",ar.count]];
        }
    }
    
    if(delegate )
    {
        if([delegate respondsToSelector:@selector(didChangeNumberOfEventsUpdate:)])
        {
            NSArray *ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"viewStatus==0 AND type==%i",8]];    /////  AD 27th May
            
            [delegate didChangeNumberOfEventsUpdate:[NSString stringWithFormat:@"%i",ar.count]];
        }
    }
    
    if(delegate )
    {
        if([delegate respondsToSelector:@selector(didChangeNumberOfEventsDelete:)])
        {
            NSArray *ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"viewStatus==0 AND type==%i",9]];   /////  AD 27th May
            
            [delegate didChangeNumberOfEventsDelete:[NSString stringWithFormat:@"%i",ar.count]];
        }
    }
    
    
    
    if(delegate)
    {
        
        
        
        if([delegate respondsToSelector:@selector(didChangeNumberLikeComments:)])
        {
            NSArray *ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"inviteStatus==0 AND type==%i",6]];
            
            
            [delegate didChangeNumberLikeComments:[NSString stringWithFormat:@"%i",ar.count]];
        }
    }
    
    
    
    
    if(delegate)
    {
        
        
        
        if([delegate respondsToSelector:@selector(didChangeNumberOfCoachNotifiedForTeamInvite:)])
        {
            NSArray *ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"viewStatus==0 AND type==%i",7]];
            
            
            [delegate didChangeNumberOfCoachNotifiedForTeamInvite:[NSString stringWithFormat:@"%i",ar.count]];
        }
    }
    
    if(delegate)
    {
        
        
        
        if([delegate respondsToSelector:@selector(didChangeNumberOfUserNotifiedForTeamInviteResponse:)])
        {
            NSArray *ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"viewStatus==0 AND type==%i",10]];
            
            
            [delegate didChangeNumberOfUserNotifiedForTeamInviteResponse:[NSString stringWithFormat:@"%i",ar.count]];
        }
    }
    
    if(delegate)
    {
        
        
        
        if([delegate respondsToSelector:@selector(didChangeNumberOfCoachNotifiedForAdminInvite:)])
        {
            NSArray *ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"viewStatus==0 AND type==%i",15]];
            
            
            [delegate didChangeNumberOfCoachNotifiedForAdminInvite:[NSString stringWithFormat:@"%i",ar.count]];
        }
    }
    
    
    
    
    
    if(delegate)
    {
        
        
        
        if([delegate respondsToSelector:@selector(didChangeNumberOfCoachNotifiedForTeamEventInvite:)])
        {
            NSArray *ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"viewStatus==0 AND type==%i",12]];
            
            
            [delegate didChangeNumberOfCoachNotifiedForTeamEventInvite:[NSString stringWithFormat:@"%i",ar.count]];
        }
    }
    
    if(delegate)
    {
        
        NSLog(@"fetchedResultsController.count=%i",fetchedResultsController.fetchedObjects.count);
        
        if([delegate respondsToSelector:@selector(didChangeNumberOfUserNotifiedForTeamEventInviteResponse:)])
        {
            NSArray *ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"viewStatus==0 AND type==%i",11]];
            
            
            [delegate didChangeNumberOfUserNotifiedForTeamEventInviteResponse:[NSString stringWithFormat:@"%i",ar.count]];
        }
    }
    

    
    
    
    
    
   /* [self.tabView scrollToRowAtIndexPath:self.todayIndexpath
                         atScrollPosition:UITableViewScrollPositionTop
                                 animated:YES];*/
    
  
    self.selContactNew=[[SelectContact alloc] initWithNibName:@"SelectContact" bundle:nil];
    [self.selContactNew view];
    
    
    if(self.fetchedResultsController.fetchedObjects.count>0)
    {
        self.nolbl.hidden=YES;
         self.nonotificationvw.hidden=YES;
    }
    else
    {
     self.nolbl.hidden=NO;
         self.nonotificationvw.hidden=NO;
    }
    
}





- (void)imageUpdatedNewEvent:(NSNotification *)notif
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


- (void)imageUpdatedCoachUpdate:(NSNotification *)notif
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
         self.nonotificationvw.hidden=YES;
    }
    else
    {
        self.tabView.hidden=YES;
        self.nolbl.hidden=NO;
         self.nonotificationvw.hidden=NO;
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
   
    Invite *newEvent= [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    
    NSString *acstr=[[NSString alloc] initWithFormat:@"%@ sent you an invite to join %@ %@",newEvent.creatorName,newEvent.teamName,newEvent.teamSport];
    
    NSMutableAttributedString *attr=[[NSMutableAttributedString alloc] initWithString:acstr];
    
    
    [attr addAttribute:NSForegroundColorAttributeName value:self.dGrayColor range:NSMakeRange(0, acstr.length)];
    [attr addAttribute:NSFontAttributeName value:self.helveticaFontForte range:NSMakeRange(0, acstr.length)];
    
    
    if(acstr && newEvent.teamName)
        [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:newEvent.teamName]];
    
    if(acstr && newEvent.creatorName)
        [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:newEvent.creatorName]];
    
    
    if(acstr && newEvent.teamSport)
        [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:newEvent.teamSport]];
    
    
    
    
    self.lblSize.attributedText=attr;
    [self.lblSize sizeToFit];
    
    
    self.lblSize.text=[self getDateTimeForHistory:newEvent.datetime];
    
    float dY=self.lblSize.frame.size.height;
    
    
    
    
    Invite *data=[self.fetchedResultsController objectAtIndexPath:indexPath];
    
    if(data.type.integerValue==0 || data.type.integerValue==14)
    {
        if( data.inviteStatus.intValue==0)
        {
            if(self.isiPad)
                
            {
                return 170;
            }
            else{
                if (dY>32.5) {
                    
                    
                    return 95+12;
                }

                return 95;
            }
        }
        else
        {
            if(self.isiPad)
                
            {
                return 145.0;
            }
            else{
                if (dY>32.5) {
                    
                    
                    return 80.0+12;
                }
                return 80.0;
            }
        }
        
    }
    else if( data.type.integerValue==5 || data.type.integerValue==7 || data.type.integerValue==8 || data.type.integerValue==9 || data.type.integerValue==10 || data.type.integerValue==11 || data.type.integerValue==12 || data.type.integerValue==15)//15a
    {
        if (self.isiPad) {
            return 110.0f;
        }
         return 60.0f;
    }
    else if(data.type.integerValue==3)
    {
    
    
   /* float dY=22;
        
        
        @autoreleasepool {
           NSString *text=[NSString stringWithFormat:@"\"%@\"",data.message ];
    
    
    
    dY=dY+labelTextSize.height+2+15+5;
        }
    
    if(dY<60)
        dY=60;
    
    
    return dY;*/
        Invite *newEvent=data;
        
        float dY=2;
        CGSize labelTextSize;
        
        NSString *acstr=nil;
        @autoreleasepool {
            
          

            NSString *text=[NSString stringWithFormat:@"\"%@\"",data.message ];
            acstr=  [[NSString alloc] initWithFormat:@"%@ coach update %@",newEvent.teamName,text];
            
            if(self.isiPad)
                
            {
                labelTextSize =[self getSizeOfText:acstr :CGSizeMake (607,10000) :self.helveticaFontForte];
            }
            else{
                labelTextSize =[self getSizeOfText:acstr :CGSizeMake (245,10000) :self.helveticaFontForte];
            }
            //[text sizeWithFont:self.helveticaFontForte constrainedToSize:CGSizeMake (220,10000) lineBreakMode: NSLineBreakByWordWrapping];
            
            
            
          // dY=dY+labelTextSize.height+2+15+5;
        }
        
        
        UILabel *lab=nil;
        {
           
            
        
            
            NSMutableAttributedString *attr=[[NSMutableAttributedString alloc] initWithString:acstr];
            
            
            // cell1.senderName.text=newEvent.teamName;//[[NSString alloc] initWithFormat:@"%@ Team",newEvent.teamName];
            
            
            // [attr setFont:[UIFont systemFontOfSize:14.0]/*[UIFont fontWithName:@"Helvetica" size:14.0]*//*self.helveticaFontForte*/];
            //[attr setFontName:@"Helvetica" size:14.0];
            //  [attr setFont:[UIFont systemFontOfSize:14.0]];
            
             //// AD 19th May
           // [attr addAttribute:NSForegroundColorAttributeName value:self.dGrayColor range:NSMakeRange(0, acstr.length)];
            [attr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:239.0/255.0 green:63.0/255.0 blue:55.0/255.0 alpha:1.0] range:NSMakeRange(0, acstr.length)];
            [attr addAttribute:NSFontAttributeName value:self.helveticaFontForte range:NSMakeRange(0, acstr.length)];
            
            if(acstr && newEvent.teamName)
            [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:newEvent.teamName]];
            
               if(acstr && @"update")
            [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:@"update"]];
          // [attr addAttribute: value:<#(id)#> range:<#(NSRange)#>];
           
            

            
            
            //////////////////////////
            
            
            
            if(self.isiPad)
                
            {
                lab=[[UILabel alloc] initWithFrame:CGRectMake(103, dY, 607, labelTextSize.height)];
            }
            else{
                lab=[[UILabel alloc] initWithFrame:CGRectMake(65, dY, 245, labelTextSize.height)];
            }
//            lab=[[UILabel alloc] initWithFrame:CGRectMake(65, dY, 245, labelTextSize.height)];
            
            lab.font=self.helveticaFont;
            lab.textColor=self.darkgraycolor;
            
            
            
            lab.attributedText=attr;
            
            lab.tag=10;
            lab.numberOfLines=0;
            
            
            [lab sizeToFit];
            dY+=lab.frame.size.height;
            
            dY+=2;
            
            
            
            
        }
        dY+=(15+5);
        lab=nil;
        if (self.isiPad) {
            if(dY<100)
                dY=100;
        }
        else{
            if(dY<60)
                dY=60;
        }
        
        return dY;
        

        
        
        
        
        
    }
    else
    {
       
        
        float dY=5;
        
      
        
        
        UILabel *lab=nil;
        {
            NSString *acstr=nil;
            
            
            
             NSString *teamName=data.teamName;
           @autoreleasepool {
              
//                int i=0;
//                for(NSString *str in appDelegate.centerVC.dataArrayUpButtonsIds)
//                {
//                    if([str isEqualToString: data.teamId ])
//                    {
//                        teamName=[appDelegate.centerVC.dataArrayUpButtons objectAtIndex:i];
//                        break;
//                    }
//                    i++;
//                }
                
                
                NSArray *arr=   [data.message componentsSeparatedByString:@"your"];
                
                acstr=[[NSString alloc] initWithFormat:@"%@your %@%@",[arr objectAtIndex:0],teamName,[arr objectAtIndex:1]];
            }
            CGSize labelTextSize;
            if(self.isiPad)
                
            {
                labelTextSize =[self getSizeOfText:acstr :CGSizeMake (607,10000) :self.helveticaFontForte];
            }
            else{
                labelTextSize =[self getSizeOfText:acstr :CGSizeMake (245,10000) :self.helveticaFontForte];
            }
            
            //[acstr sizeWithFont:self.helveticaFontForte constrainedToSize:CGSizeMake (215,10000) lineBreakMode: NSLineBreakByWordWrapping];
            
            NSMutableAttributedString *attr=[[NSMutableAttributedString alloc] initWithString:acstr];
            [attr addAttribute:NSForegroundColorAttributeName value:self.dGrayColor range:NSMakeRange(0, acstr.length)];
            [attr addAttribute:NSFontAttributeName value:self.helveticaFontForte range:NSMakeRange(0, acstr.length)];
            
            @autoreleasepool
            {
                
                
                NSArray *a=nil;
                if(!data.isComment.boolValue)
                    a= [acstr componentsSeparatedByString:@"likes"];
                else
                    a= [acstr componentsSeparatedByString:@"commented"];
            
                
                
                
                if(a.count>0)
                {
                       if(acstr && [a objectAtIndex:0])
                    [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:[a objectAtIndex:0]]];
                }
            }
            
               if(acstr && @"post")
            [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:@"post"]];
            
            if(acstr && teamName)
                [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:teamName]];
            
            
            if(!data.isComment.boolValue)
            {
                   if(acstr && @"likes")
                [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:@"likes"]];
            }
            else
            {
                   if(acstr && @"commented")
                [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:@"commented"]];
            }
            
            
            //////////////////////////
            
          
            if(self.isiPad)
                
            {
                lab=[[UILabel alloc] initWithFrame:CGRectMake(103, dY, 607, labelTextSize.height)];
            }
            else{
                lab=[[UILabel alloc] initWithFrame:CGRectMake(65, dY, 245, labelTextSize.height)];
            }
            
            
            lab.font=self.helveticaFont;
            lab.textColor=self.darkgraycolor;
            
            
            
            lab.attributedText=attr;
            
            lab.tag=10;
            lab.numberOfLines=0;
           
            
            [lab sizeToFit];
            dY+=lab.frame.size.height;
            
            dY+=2;
            
         
            
            
        }
        dY+=(15+5);
        lab=nil;
        
        if (self.isiPad) {
            if(dY<100)
                dY=100;
        }
        else{
            if(dY<60)
                dY=60;
        }
        
        return dY;

    }

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
  
    
    static NSString *CellIdentifier = @"PushByInviteTeamCell";
    
      static NSString *CellIdentifier1= @"PushByCoachUpdateCell";
      static NSString *CellIdentifier2 = @"PushByEventsVCCell";
     static NSString *CellIdentifier3 = @"CellLikeComments";
    static NSString *CellIdentifier4 = @"PushByTeamResponseCell";
    
       Invite *newEvent= [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    NSLog(@"%@ creatorName=%@",newEvent.type,newEvent.creatorName);
    
    
    if(newEvent.type.integerValue==0)
    {
    PushByInviteTeamCell *cell = [self.tabView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = (PushByInviteTeamCell *)[PushByInviteTeamCell cellFromNibNamed:CellIdentifier];
           cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
    }
    if(newEvent.type.integerValue==14)
    {
        PushByInviteTeamCell *cell = [self.tabView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = (PushByInviteTeamCell *)[PushByInviteTeamCell cellFromNibNamed:CellIdentifier];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
        }
        
      
            [self configureCellAdminInvite:cell atIndexPath:indexPath];
        
        
     
        return cell;
    }
    else if(newEvent.type.integerValue==3)
    {
        PushByCoachUpdateCell *cell = [self.tabView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil)
        {
            cell = (PushByCoachUpdateCell *)[PushByCoachUpdateCell cellFromNibNamed:CellIdentifier1];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
        }
        [self configureCellPushByCoachUpdate:cell atIndexPath:indexPath];
        return cell;
    }
    
    else if(newEvent.type.integerValue==5)
    {
  
    
    PushByEventsVCCell *cell = [self.tabView dequeueReusableCellWithIdentifier:CellIdentifier2];
    if (cell == nil)
    {
        cell = (PushByEventsVCCell *)[PushByEventsVCCell cellFromNibNamed:CellIdentifier2];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    [self configureCellNewEvent:cell atIndexPath:indexPath];
    return cell;
    }
    else if(newEvent.type.integerValue==8)
    {
        
        
        PushByEventsVCCell *cell = [self.tabView dequeueReusableCellWithIdentifier:CellIdentifier2];
        if (cell == nil)
        {
            cell = (PushByEventsVCCell *)[PushByEventsVCCell cellFromNibNamed:CellIdentifier2];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
        }
        [self configureCellUpdateEvent:cell atIndexPath:indexPath];
        return cell;
    }
    else if(newEvent.type.integerValue==9)
    {
        
        
        PushByEventsVCCell *cell = [self.tabView dequeueReusableCellWithIdentifier:CellIdentifier2];
        if (cell == nil)
        {
            cell = (PushByEventsVCCell *)[PushByEventsVCCell cellFromNibNamed:CellIdentifier2];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
        }
        [self configureCellDeleteEvent:cell atIndexPath:indexPath];
        return cell;
    }
    else if(newEvent.type.integerValue==7)
    {
        
        
        PushByTeamResponseCell *cell = [self.tabView dequeueReusableCellWithIdentifier:CellIdentifier4];
        if (cell == nil)
        {
            cell = (PushByTeamResponseCell *)[PushByTeamResponseCell cellFromNibNamed:CellIdentifier4];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
        }
        [self configureCellTeamResponse:cell atIndexPath:indexPath];
        return cell;
    }
    else if(newEvent.type.integerValue==15)//15a
    {
        
        
        PushByTeamResponseCell *cell = [self.tabView dequeueReusableCellWithIdentifier:CellIdentifier4];
        if (cell == nil)
        {
            cell = (PushByTeamResponseCell *)[PushByTeamResponseCell cellFromNibNamed:CellIdentifier4];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
        }
        [self configureCellAdminResponse:cell atIndexPath:indexPath];
        return cell;
    }
    else if(newEvent.type.integerValue==10)
    {
        
        
        PushByTeamResponseCell *cell = [self.tabView dequeueReusableCellWithIdentifier:CellIdentifier4];
        if (cell == nil)
        {
            cell = (PushByTeamResponseCell *)[PushByTeamResponseCell cellFromNibNamed:CellIdentifier4];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
        }
        [self configureCellUserTeamResponse:cell atIndexPath:indexPath];
        return cell;
    }
    else if(newEvent.type.integerValue==12)
    {
        
        
        PushByTeamResponseCell *cell = [self.tabView dequeueReusableCellWithIdentifier:CellIdentifier4];
        if (cell == nil)
        {
            cell = (PushByTeamResponseCell *)[PushByTeamResponseCell cellFromNibNamed:CellIdentifier4];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
        }
        [self configureCellTeamEventResponse:cell atIndexPath:indexPath];
        return cell;
    }
    else if(newEvent.type.integerValue==11)
    {
        
        
        PushByTeamResponseCell *cell = [self.tabView dequeueReusableCellWithIdentifier:CellIdentifier4];
        if (cell == nil)
        {
            cell = (PushByTeamResponseCell *)[PushByTeamResponseCell cellFromNibNamed:CellIdentifier4];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
        }
        [self configureCellUserTeamEventResponse:cell atIndexPath:indexPath];
        return cell;
    }
    else
    {
      
        
        
        
        LikesAndCommentsVCCell *cell = (LikesAndCommentsVCCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
        if (cell == nil)
        {
            cell = (LikesAndCommentsVCCell *)[LikesAndCommentsVCCell cellFromNibNamed:@"LikesAndCommentsVCCell"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        
        [self configureCellLike:cell atIndexPath:indexPath];
        return cell;

    }
}
////////////////////////////////////


- (void)configureCellLike:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
    LikesAndCommentsVCCell *cell1=(LikesAndCommentsVCCell*)cell;
    
   Invite *data= [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    
    // NSLog(@"AllHistoryTbCellTeamId=%@----%@",data.teamId,data.message);
    
    
    float dY=5;
    
    //////////////////////////
    
    
    NSString *acstr=nil;
      NSString *teamName=data.teamName;
    @autoreleasepool {
        
        
      
//        int i=0;
//        for(NSString *str in appDelegate.centerVC.dataArrayUpButtonsIds)
//        {
//            if([str isEqualToString: data.teamId ])
//            {
//                teamName=[appDelegate.centerVC.dataArrayUpButtons objectAtIndex:i];
//                break;
//            }
//            i++;
//        }
        
     NSArray *arr=   [data.message componentsSeparatedByString:@"your"];
        
        NSArray *arr1=   [data.message componentsSeparatedByString:@"post"];
        if ([[arr1 objectAtIndex:1] length]>3) {
            acstr=[[NSString alloc] initWithFormat:@"%@your %@%@",[arr objectAtIndex:0],teamName,[arr objectAtIndex:1]];
        }
        else
            acstr=[[NSString alloc] initWithFormat:@"%@your %@ post.",[arr objectAtIndex:0],teamName];

        
        
    }
   
    
    NSMutableAttributedString *attr=[[NSMutableAttributedString alloc] initWithString:acstr];
    [attr addAttribute:NSForegroundColorAttributeName value:self.dGrayColor range:NSMakeRange(0, acstr.length)];
    [attr addAttribute:NSFontAttributeName value:self.helveticaFontForte range:NSMakeRange(0, acstr.length)];
    
    @autoreleasepool
    {
        
        
        NSArray *a=nil;
        
        if(!data.isComment.boolValue)
            a= [acstr componentsSeparatedByString:@"likes"];
        else
             a= [acstr componentsSeparatedByString:@"commented"];
        
        if(a.count>0)
        {
               if(acstr && [a objectAtIndex:0])
            [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:[a objectAtIndex:0]]];
        }
    }
     if(!data.isComment.boolValue)
     {
            if(acstr && @"likes")
     [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:@"likes"]];
         
         
         
         cell1.imageViewTime.image=self.likeTimeImavw;
     }
     else
     {
            if(acstr && @"commented")
     [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:@"commented"]];
         
          cell1.imageViewTime.image=self.commentTimeImavw;
     }
    
       if(acstr && @"post")
    [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:@"post"]];
    
    if(acstr && teamName)
        [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:teamName]];
    
    //////////////////////////
    CGSize labelTextSize;
    if(self.isiPad)
    
    {
        dY+=5;
        labelTextSize =[self getSizeOfText:acstr :CGSizeMake (607,10000) :self.helveticaFontForte];
        cell1.senderName.frame=CGRectMake(103, dY, 607, labelTextSize.height);
    }
    else{
        labelTextSize =[self getSizeOfText:acstr :CGSizeMake (245,10000) :self.helveticaFontForte];
        cell1.senderName.frame=CGRectMake(65, dY, 245, labelTextSize.height);
    }
    //CGSize labelTextSize =[self getSizeOfText:acstr :CGSizeMake (245,10000) :self.helveticaFontForte];
   // [acstr sizeWithFont:self.helveticaFontForte constrainedToSize:CGSizeMake (215,10000) lineBreakMode:NSLineBreakByWordWrapping];
    
    
    /*UILabel *m= (UILabel*)[cell1.mainBackgroundVw viewWithTag:10];
    if(m)
    {
        [m removeFromSuperview];
    }
    
    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(65, dY, 245, labelTextSize.height)];
    
    lab.font=self.helveticaFont;
    lab.textColor=self.darkgraycolor;
   
    
    
    lab.attributedText=attr;
    
    lab.tag=10;
    lab.numberOfLines=0;
    [cell1.mainBackgroundVw addSubview:lab ];*/
    cell1.senderName.attributedText=attr;
    
    
    
    
    [cell1.senderName sizeToFit];
    dY+=cell1.senderName.frame.size.height;
    
    dY+=2;
    
    if (self.isiPad) {
        dY+=3;
        cell1.teamName.frame= CGRectMake(cell1.teamName.frame.origin.x, dY, 587, 25);
        
        cell1.imageViewTime.frame=CGRectMakeWithSize(cell1.imageViewTime.frame.origin.x, (dY+3), cell1.imageViewTime.frame.size);
    }
    else{
        cell1.teamName.frame= CGRectMake(83, dY, 225, 15);
        
        cell1.imageViewTime.frame=CGRectMakeWithSize(65, (dY+1), cell1.imageViewTime.frame.size);
    }
    
    /*UILabel *lab1=[[UILabel alloc] initWithFrame:CGRectMake(5, dY, 230, 15)];
     
     lab1.font=self.timeFont;
     lab1.textColor=self.darkgraycolor;*/
    cell1.teamName.text=[self getDateTimeForHistory:data.datetime ];
    
    
      NSLog(@"DataMessageLike=%@",data.message);
     NSLog(@"DataMessageLikeFrame=%@",[NSValue valueWithCGRect:cell1.teamName.frame ]);
    
    cell1.teamName.font=self.timeFont;
    cell1.teamName.textColor=self.lightgraycolor;
    
    //[cell.contentView addSubview:lab1 ];
      NSLog(@"LikeImagelink%@",data.profImg);
    
    
    [cell1.posted cleanPhotoFrame];
    
    if(data.profImg)
    {
    NSURL *url=[[NSURL alloc] initWithString:data.profImg];
        
         [cell1.posted applyPhotoFrame];
    
    [cell1.posted setImageWithURL:url placeholderImage:self.noImage];
    }
    else
    {
        [cell1.posted setImage:self.noImage];
    }
    
    if( data.inviteStatus.integerValue==0)
    {
        cell1.statusimagvw.image=self.dotImage;
          cell1.mainBackgroundVw.backgroundColor=appDelegate.backGroundUnreadGray;
    }
    
    else
    {
        cell1.statusimagvw.image=nil;
          cell1.mainBackgroundVw.backgroundColor=self.whitecolor;
    }
    
    float y=cell1.teamName.frame.origin.y+cell1.teamName.frame.size.height+4;
    
 
    
    
    /*UIView *mseparator= (UIView*)[cell1.mainBackgroundVw viewWithTag:20];
    UIView *separatorvw=nil;
    if(mseparator)
    {
        //[mseparator removeFromSuperview];
        separatorvw=mseparator;
        separatorvw.frame=CGRectMake(0, y, 320, 1);
    }
   else
   {
         separatorvw=[[UIView alloc] initWithFrame:CGRectMake(0, y, 320, 1)];
         separatorvw.backgroundColor=appDelegate.veryLightGrayColor;
         separatorvw.tag=20;
         [cell1.mainBackgroundVw addSubview:separatorvw];
   }*/
    
 
    
    CGRect btrect=cell1.separator.frame;
    btrect.origin.y=y;
    
    if (self.isiPad) {
        if(btrect.origin.y<99)
            btrect.origin.y=99;
    }
    else{
        if(btrect.origin.y<58)
            btrect.origin.y=58;
    }
    cell1.separator.frame=btrect;
   
  
   
}





- (void)configureCellNewEvent:(PushByEventsVCCell *)cell1 atIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    Invite *newEvent= [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    
    NSString *acstr=[[NSString alloc] initWithFormat:@"%@ request from %@",newEvent.eventName,newEvent.teamName];
    
    NSMutableAttributedString *attr=[[NSMutableAttributedString alloc] initWithString:acstr];
    
    [attr addAttribute:NSForegroundColorAttributeName value:self.dGrayColor range:NSMakeRange(0, acstr.length)];
    [attr addAttribute:NSFontAttributeName value:self.helveticaFontForte range:NSMakeRange(0, acstr.length)];
    
       if(acstr && newEvent.teamName)
    [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:newEvent.teamName]];
    if(acstr && newEvent.eventName)
        [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:newEvent.eventName]];
    if(acstr && newEvent.teamSport)
        [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:newEvent.teamSport]];
    
       if(acstr && @"Event")
    [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:@"Event"]];
    
    
    
    
    
    
    
    
    cell1.senderName.attributedText=attr;//[[NSString alloc] initWithFormat:@"%@ Team",newEvent.teamName];
    
    
    
    
    
    
    
    
    
    cell1.teamName.hidden=YES;
    cell1.teamName.text=newEvent.eventName;//[[NSString alloc] initWithFormat:@"%@ Event",newEvent.eventName];
    cell1.teamName.font=self.helveticaFontBold;
    
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
    
    /*ImageInfo * info1=nil;
    
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
    }*/
    
    /*if(info1.image)
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
    }*/
    NSLog(@"NewEvent%@",[[NSString alloc] initWithFormat:@"%@%@",TEAM_LOGO_URL, newEvent.teamLogo ]);
    
    
     [cell1.posted cleanPhotoFrame];
    
    if(newEvent.teamLogo)
    {
    NSURL *url=[[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"%@%@",TEAM_LOGO_URL, newEvent.teamLogo ]];
    
    [cell1.posted setImageWithURL:url placeholderImage:self.teamNoImage];
        
         [cell1.posted applyPhotoFrame];
    }
    else
    {
        [cell1.posted setImage:self.teamNoImage];
    }
    
    if( newEvent.viewStatus.intValue!=1)
    {
     cell1.mainBackgroundVw.backgroundColor=appDelegate.backGroundUnreadGray;
        
    }
    else
    {
        cell1.mainBackgroundVw.backgroundColor=self.whitecolor;
        cell1.userInteractionEnabled=NO;
    }
   CGRect btrect=cell1.separator.frame;
    btrect.origin.y=cell1.statusLabel.frame.origin.y+cell1.statusLabel.frame.size.height+3;
    
    if (self.isiPad) {
        if(btrect.origin.y<99)
            btrect.origin.y=99;
    }
    else{
        if(btrect.origin.y<59)
            btrect.origin.y=59;
    }
    cell1.separator.frame=btrect;
    
}



- (void)configureCellUpdateEvent:(PushByEventsVCCell *)cell1 atIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    Invite *newEvent= [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    
    NSString *acstr=[[NSString alloc] initWithFormat:@"Event updated for %@",newEvent.teamName];
    
    NSMutableAttributedString *attr=[[NSMutableAttributedString alloc] initWithString:acstr];
    
    [attr addAttribute:NSForegroundColorAttributeName value:self.dGrayColor range:NSMakeRange(0, acstr.length)];
    [attr addAttribute:NSFontAttributeName value:self.helveticaFontForte range:NSMakeRange(0, acstr.length)];
    
    if(acstr && newEvent.teamName)
        [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:newEvent.teamName]];
    
    if(acstr && @"Event")
        [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:@"Event"]];
    
    
    
    
    
    
    
    
    cell1.senderName.attributedText=attr;//[[NSString alloc] initWithFormat:@"%@ Team",newEvent.teamName];
    
    
    
    
    
    
    
    
    
    
    cell1.teamName.text=newEvent.eventName;//[[NSString alloc] initWithFormat:@"%@ Event",newEvent.eventName];
    cell1.teamName.font=self.helveticaFontBold;
    
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
    
    /*ImageInfo * info1=nil;
     
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
     }*/
    
    /*if(info1.image)
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
     }*/
    NSLog(@"NewEvent%@",[[NSString alloc] initWithFormat:@"%@%@",TEAM_LOGO_URL, newEvent.teamLogo ]);
    
    
    [cell1.posted cleanPhotoFrame];
    
    if(newEvent.teamLogo)
    {
        NSURL *url=[[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"%@%@",TEAM_LOGO_URL, newEvent.teamLogo ]];
        
        [cell1.posted setImageWithURL:url placeholderImage:self.teamNoImage];
        
        [cell1.posted applyPhotoFrame];
    }
    else
    {
        [cell1.posted setImage:self.teamNoImage];
    }
    
    if( newEvent.viewStatus.intValue!=1)
    {
        cell1.mainBackgroundVw.backgroundColor=appDelegate.backGroundUnreadGray;
    }
    else
        cell1.userInteractionEnabled=NO;
    
    CGRect btrect=cell1.separator.frame;
    btrect.origin.y=cell1.statusLabel.frame.origin.y+cell1.statusLabel.frame.size.height+3;
    
    if (self.isiPad) {
        if(btrect.origin.y<99)
            btrect.origin.y=99;
    }
    else{
        if(btrect.origin.y<59)
            btrect.origin.y=59;
    }
    cell1.separator.frame=btrect;
    
}



- (void)configureCellDeleteEvent:(PushByEventsVCCell *)cell1 atIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    Invite *newEvent= [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    
    NSString *acstr=[[NSString alloc] initWithFormat:@"Event deleted for %@",newEvent.teamName];
    
    NSMutableAttributedString *attr=[[NSMutableAttributedString alloc] initWithString:acstr];
    
    [attr addAttribute:NSForegroundColorAttributeName value:self.dGrayColor range:NSMakeRange(0, acstr.length)];
    [attr addAttribute:NSFontAttributeName value:self.helveticaFontForte range:NSMakeRange(0, acstr.length)];
    
    if(acstr && newEvent.teamName)
        [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:newEvent.teamName]];
    
    if(acstr && @"Event")
        [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:@"Event"]];
    
    
    
    
    
    
    
    
    cell1.senderName.attributedText=attr;//[[NSString alloc] initWithFormat:@"%@ Team",newEvent.teamName];
    
    
    
    
    
    
    
    
    
    
    cell1.teamName.text=newEvent.eventName;//[[NSString alloc] initWithFormat:@"%@ Event",newEvent.eventName];
    cell1.teamName.font=self.helveticaFontBold;
    
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
    
    /*ImageInfo * info1=nil;
     
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
     }*/
    
    /*if(info1.image)
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
     }*/
    NSLog(@"NewEvent%@",[[NSString alloc] initWithFormat:@"%@%@",TEAM_LOGO_URL, newEvent.teamLogo ]);
    
    
    [cell1.posted cleanPhotoFrame];
    
    if(newEvent.teamLogo)
    {
        NSURL *url=[[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"%@%@",TEAM_LOGO_URL, newEvent.teamLogo ]];
        
        [cell1.posted setImageWithURL:url placeholderImage:self.teamNoImage];
        
        [cell1.posted applyPhotoFrame];
    }
    else
    {
        [cell1.posted setImage:self.teamNoImage];
    }
    
    
    cell1.mainBackgroundVw.backgroundColor=appDelegate.backGroundUnreadGray;
    CGRect btrect=cell1.separator.frame;
    btrect.origin.y=cell1.statusLabel.frame.origin.y+cell1.statusLabel.frame.size.height+3;
    
    if (self.isiPad) {
        if(btrect.origin.y<99)
            btrect.origin.y=99;
    }
    else{
        if(btrect.origin.y<59)
            btrect.origin.y=59;
    }
    cell1.separator.frame=btrect;
    
}




- (void)configureCell:(PushByInviteTeamCell *)cell1 atIndexPath:(NSIndexPath *)indexPath
{
  
    
    
    
    Invite *newEvent= [self.fetchedResultsController objectAtIndexPath:indexPath];

   
    
    NSString *acstr=[[NSString alloc] initWithFormat:@"%@ sent you an invite to join %@ %@",newEvent.creatorName,newEvent.teamName,newEvent.teamSport];
    
    NSMutableAttributedString *attr=[[NSMutableAttributedString alloc] initWithString:acstr];
    
    
    [attr addAttribute:NSForegroundColorAttributeName value:self.dGrayColor range:NSMakeRange(0, acstr.length)];
    [attr addAttribute:NSFontAttributeName value:self.helveticaFontForte range:NSMakeRange(0, acstr.length)];
    
    
       if(acstr && newEvent.teamName)
    [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:newEvent.teamName]];
    
       if(acstr && newEvent.creatorName)
    [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:newEvent.creatorName]];
    
    
    if(acstr && newEvent.teamSport)
        [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:newEvent.teamSport]];
    
    
    
    
    cell1.senderName.attributedText=attr;
    [cell1.senderName sizeToFit];
   
    
    cell1.teamName.text=[self getDateTimeForHistory:newEvent.datetime];
    
    float dY=cell1.senderName.frame.origin.y;
    
  
    
    
   
    
    dY+=cell1.senderName.frame.size.height;
    
    
    if(self.isiPad)
    {
        dY+=5;
        cell1.teamName.frame=CGRectMakeWithSize(cell1.teamName.frame.origin.x,(dY+2), cell1.teamName.frame.size);
        cell1.imagetimevw.frame=CGRectMakeWithSize(cell1.imagetimevw.frame.origin.x,(dY+2+1), cell1.imagetimevw.frame.size);
    }
    else{
     cell1.teamName.frame=CGRectMakeWithSize(cell1.teamName.frame.origin.x,(dY+2), cell1.teamName.frame.size);
      cell1.imagetimevw.frame=CGRectMakeWithSize(cell1.imagetimevw.frame.origin.x,(dY+2+1), cell1.imagetimevw.frame.size);
    }
    dY=cell1.teamName.frame.origin.y+cell1.teamName.frame.size.height;
    
    cell1.statusLabel.frame=CGRectMakeWithSize(cell1.statusLabel.frame.origin.x,(dY+2), cell1.statusLabel.frame.size);
    
  
    
    
    cell1.statusLabel.hidden=NO;
    cell1.acceptBtn.hidden=YES;
    cell1.declineBtn.hidden=YES;
    cell1.maybeBtn.hidden=YES;
    
    
    CGRect btrect=cell1.acceptBtn.frame;
    btrect.origin.y=dY+5;
    cell1.acceptBtn.frame=btrect;
    
    btrect=cell1.declineBtn.frame;
    btrect.origin.y=dY+5;
    cell1.declineBtn.frame=btrect;
    
    btrect=cell1.maybeBtn.frame;
    btrect.origin.y=dY+5;
    cell1.maybeBtn.frame=btrect;
    
    
    [cell1.acceptBtn addTarget:self action:@selector(acceptInvite:) forControlEvents:UIControlEventTouchUpInside];
    
     [cell1.declineBtn addTarget:self action:@selector(declineInvite:) forControlEvents:UIControlEventTouchUpInside];
    
      [cell1.maybeBtn addTarget:self action:@selector(mayBeInvite:) forControlEvents:UIControlEventTouchUpInside];
     cell1.mainBackgroundVw.backgroundColor=self.whitecolor;
   if( newEvent.inviteStatus.intValue==0)
   {
       cell1.statusLabel.hidden=YES;
       cell1.acceptBtn.hidden=NO;
       cell1.declineBtn.hidden=NO;
       cell1.maybeBtn.hidden=NO;
       
       CGRect f1= cell1.declineBtn.frame;
       if (self.isiPad) {
           f1.origin.x=290;
       }
       else
           f1.origin.x=155;
       cell1.declineBtn.frame=f1;
       
       
       [cell1.mainBackgroundVw bringSubviewToFront:cell1.acceptBtn];
         [cell1.mainBackgroundVw bringSubviewToFront:cell1.declineBtn];
         [cell1.mainBackgroundVw bringSubviewToFront:cell1.maybeBtn];
       
       
       
       cell1.mainBackgroundVw.backgroundColor=appDelegate.backGroundUnreadGray;
   }
    else if( newEvent.inviteStatus.intValue==1)
    {
        cell1.statusLabel.text=@"You accepted";
        cell1.statusLabel.textColor=[UIColor colorWithRed:74.0/255.0 green:186.0/255.0 blue:111.0/255.0 alpha:1.0];
    }
    else if( newEvent.inviteStatus.intValue==2)
    {
        cell1.statusLabel.text=@"You declined";
        cell1.statusLabel.textColor=[UIColor colorWithRed:239.0/255.0 green:63.0/255.0 blue:55.0/255.0 alpha:1.0];
    }
    else 
    {
        cell1.statusLabel.text=@"Maybe";
    }
    
    if( newEvent.inviteStatus.intValue==0)
    {
        dY=cell1.acceptBtn.frame.origin.y+cell1.acceptBtn.frame.size.height+5;
        
        if (self.isiPad) {
            if(dY<169)
                dY=169;
        }
        else{
            if(dY<94)
                dY=94;
        }
    }
    else
    {
          dY=cell1.statusLabel.frame.origin.y+cell1.statusLabel.frame.size.height+4;
        
        if (self.isiPad) {
            if(dY<144)
                dY=144;
        }
        else{
            if(dY<79)
                dY=79;
        }
        
    }
  
    
    
    
    
    
    btrect=cell1.separator.frame;
    btrect.origin.y=dY;
    
    
    cell1.separator.frame=btrect;
    
    
    
    NSLog(@"TeamInvite%@",[[NSString alloc] initWithFormat:@"%@%@",IMAGELINKTHUMB, newEvent.senderProfileImage ]);
    
     [cell1.posted cleanPhotoFrame];
    if(newEvent.senderProfileImage)
    {
    NSURL *url=[[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"%@%@",IMAGELINKTHUMB, newEvent.senderProfileImage ]];

    [cell1.posted setImageWithURL:url placeholderImage:self.noImage];
        
        
         [cell1.posted applyPhotoFrame];

    }
    else
    {
        [cell1.posted setImage:self.noImage];
    }
}




- (void)configureCellAdminInvite:(PushByInviteTeamCell *)cell1 atIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    Invite *newEvent= [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    
    
    NSString *acstr=[[NSString alloc] initWithFormat:@"%@ sent you an admin invite for %@ %@",newEvent.creatorName,newEvent.teamName,newEvent.teamSport];//%@ sent you an invite to become admin for %@ %@
    
    NSMutableAttributedString *attr=[[NSMutableAttributedString alloc] initWithString:acstr];
    
    
    [attr addAttribute:NSForegroundColorAttributeName value:self.dGrayColor range:NSMakeRange(0, acstr.length)];
    [attr addAttribute:NSFontAttributeName value:self.helveticaFontForte range:NSMakeRange(0, acstr.length)];
    
    
    if(acstr && newEvent.teamName)
        [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:newEvent.teamName]];
    
    if(acstr && newEvent.creatorName)
        [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:newEvent.creatorName]];
    
    
    if(acstr && newEvent.teamSport)
        [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:newEvent.teamSport]];
    
    
    
    
    cell1.senderName.attributedText=attr;
    [cell1.senderName sizeToFit];
    
    
    cell1.teamName.text=[self getDateTimeForHistory:newEvent.datetime];
    
    float dY=cell1.senderName.frame.origin.y;
    
    
    
    dY+=cell1.senderName.frame.size.height;
    
    if(self.isiPad)
    {
        dY+=5;
        cell1.teamName.frame=CGRectMakeWithSize(cell1.teamName.frame.origin.x,(dY+2), cell1.teamName.frame.size);
        cell1.imagetimevw.frame=CGRectMakeWithSize(cell1.imagetimevw.frame.origin.x,(dY+2+1), cell1.imagetimevw.frame.size);
    }
    else{
    
        cell1.teamName.frame=CGRectMakeWithSize(cell1.teamName.frame.origin.x,(dY+2), cell1.teamName.frame.size);
        cell1.imagetimevw.frame=CGRectMakeWithSize(cell1.imagetimevw.frame.origin.x,(dY+2+1), cell1.imagetimevw.frame.size);
    }
    dY=cell1.teamName.frame.origin.y+cell1.teamName.frame.size.height;
    
    cell1.statusLabel.frame=CGRectMakeWithSize(cell1.statusLabel.frame.origin.x,(dY+2), cell1.statusLabel.frame.size);
    
    
    
    
    cell1.statusLabel.hidden=NO;
    cell1.acceptBtn.hidden=YES;
    cell1.declineBtn.hidden=YES;
    cell1.maybeBtn.hidden=YES;
    
    
    CGRect btrect=cell1.acceptBtn.frame;
    btrect.origin.y=dY+5;
    cell1.acceptBtn.frame=btrect;
    
    btrect=cell1.declineBtn.frame;
    btrect.origin.y=dY+5;
    cell1.declineBtn.frame=btrect;
    
    btrect=cell1.maybeBtn.frame;
    btrect.origin.y=dY+5;
    cell1.maybeBtn.frame=btrect;
    
    
    [cell1.acceptBtn addTarget:self action:@selector(acceptInviteAdmin:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell1.declineBtn addTarget:self action:@selector(declineInviteAdmin:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell1.maybeBtn addTarget:self action:@selector(mayBeInviteAdmin:) forControlEvents:UIControlEventTouchUpInside];
    cell1.mainBackgroundVw.backgroundColor=self.whitecolor;
    if( newEvent.inviteStatus.intValue==0)
    {
        cell1.statusLabel.hidden=YES;
        cell1.acceptBtn.hidden=NO;
        cell1.declineBtn.hidden=NO;
        cell1.maybeBtn.hidden=YES;
        
        CGRect f1= cell1.declineBtn.frame;
        if (self.isiPad) {
            f1.origin.x=212;
        }
        else
            f1.origin.x=110;
        cell1.declineBtn.frame=f1;
        
        [cell1.mainBackgroundVw bringSubviewToFront:cell1.acceptBtn];
        [cell1.mainBackgroundVw bringSubviewToFront:cell1.declineBtn];
        [cell1.mainBackgroundVw bringSubviewToFront:cell1.maybeBtn];
        
        cell1.mainBackgroundVw.backgroundColor=appDelegate.backGroundUnreadGray;
    }
    else if( newEvent.inviteStatus.intValue==1)
    {
        cell1.statusLabel.text=@"You accepted";
        cell1.statusLabel.textColor=[UIColor colorWithRed:74.0/255.0 green:186.0/255.0 blue:111.0/255.0 alpha:1.0];
    }
    else if( newEvent.inviteStatus.intValue==2)
    {
        cell1.statusLabel.text=@"You declined";
        cell1.statusLabel.textColor=[UIColor colorWithRed:239.0/255.0 green:63.0/255.0 blue:55.0/255.0 alpha:1.0];
    }
    else
    {
        cell1.statusLabel.text=@"Maybe";
    }
    
    if( newEvent.inviteStatus.intValue==0)
    {
        dY=cell1.acceptBtn.frame.origin.y+cell1.acceptBtn.frame.size.height+5;
        if (self.isiPad) {
            if(dY<169)
                dY=169;
        }
        else{
            if(dY<94)
                dY=94;
        }
    }
    else
    {
        dY=cell1.statusLabel.frame.origin.y+cell1.statusLabel.frame.size.height+4;
        
        if (self.isiPad) {
            if(dY<144)
                dY=144;
        }
        else{
            if(dY<79)
                dY=79;
        }
        
    }
    
    
    
    
    
    
    btrect=cell1.separator.frame;
    btrect.origin.y=dY;
    
    
    cell1.separator.frame=btrect;
    
    
    
    NSLog(@"TeamInvite%@",[[NSString alloc] initWithFormat:@"%@%@",IMAGELINKTHUMB, newEvent.senderProfileImage ]);
    
    [cell1.posted cleanPhotoFrame];
    if(newEvent.senderProfileImage)
    {
        NSURL *url=[[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"%@%@",IMAGELINKTHUMB, newEvent.senderProfileImage ]];
        
        [cell1.posted setImageWithURL:url placeholderImage:self.noImage];
        
        
        [cell1.posted applyPhotoFrame];
        
    }
    else
    {
        [cell1.posted setImage:self.noImage];
    }
}






//////////////Coach Team Response


- (void)configureCellTeamResponse: (PushByTeamResponseCell *)cell1 atIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    Invite *newEvent= [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //newEvent.senderName;
    NSString *ss=nil;
    if(newEvent.inviteStatus.intValue==1)
    {
    ss=@"accepted";
    }
    else if(newEvent.inviteStatus.intValue==2)
    {
         ss=@"declined";
    }
    else if(newEvent.inviteStatus.intValue==3)
    {
          ss=@"Maybe";
    }
    
    
    NSString *acstr=nil;
    
   // “”player” accepted team event invite as a Maybe
    
    
    if(newEvent.inviteStatus.intValue==3)
   acstr= [[NSString alloc] initWithFormat:@"%@ accepted Team invite as a %@ for %@",newEvent.playerName,ss,newEvent.teamName];
    else
    acstr=    [[NSString alloc] initWithFormat:@"%@ %@ Team invite for %@",newEvent.playerName,ss,newEvent.teamName];
    
    NSMutableAttributedString *attr=[[NSMutableAttributedString alloc] initWithString:acstr];
    
    
    [attr addAttribute:NSForegroundColorAttributeName value:self.dGrayColor range:NSMakeRange(0, acstr.length)];
    [attr addAttribute:NSFontAttributeName value:self.helveticaFontForte range:NSMakeRange(0, acstr.length)];
    
       if(acstr && newEvent.teamName)
    [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:newEvent.teamName]];
    
    if(acstr && ss){
        if ([ss isEqualToString:@"accepted"]) {
            [attr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:74.0/255.0 green:186.0/255.0 blue:111.0/255.0 alpha:1.0] range:[acstr rangeOfString:@"accepted"]];
        }
        else if ([ss isEqualToString:@"declined"]) {
            [attr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:239.0/255.0 green:63.0/255.0 blue:55.0/255.0 alpha:1.0] range:[acstr rangeOfString:@"declined"]];
        }
        
        [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:ss]];
    }
    
    
       if(acstr && newEvent.playerName)
    [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:newEvent.playerName]];
    
    
    
    
    
    
    
    cell1.senderName.attributedText=attr;//[[NSString alloc] initWithFormat:@"%@ Team",newEvent.teamName];;
    [cell1.senderName sizeToFit];
    /*if(newEvent.message)
     cell1.teamName.text=newEvent.message;
     else
     cell1.teamName.text=[[NSString alloc] initWithFormat:TEAMINVITECONTENTSHOWROW,newEvent.teamName,newEvent.teamSport,newEvent.creatorName,newEvent.creatorName,newEvent.creatorEmail,newEvent.creatorPhno];*/
    float dY=cell1.senderName.frame.origin.y;
    
    
    
    
    // cell1.senderName.frame=CGRectMake(65, dY, 230, labelTextSize.height);
    
    dY+=cell1.senderName.frame.size.height;
    if (self.isiPad) {
        dY+=4;
        cell1.teamName.frame=CGRectMakeWithSize(cell1.teamName.frame.origin.x,(dY+2), cell1.teamName.frame.size);
        cell1.leftimagetime.frame=CGRectMakeWithSize(cell1.leftimagetime.frame.origin.x,(dY+2+2), cell1.leftimagetime.frame.size);
    }
    else{
        cell1.teamName.frame=CGRectMakeWithSize(cell1.teamName.frame.origin.x,(dY+2), cell1.teamName.frame.size);
        cell1.leftimagetime.frame=CGRectMakeWithSize(cell1.leftimagetime.frame.origin.x,(dY+2+1), cell1.leftimagetime.frame.size);
    }
    
     cell1.teamName.text=[self getDateTimeForHistory:newEvent.datetime];
    cell1.teamName.hidden=NO;
    cell1.statusLabel.hidden=YES;
   
    
   // NSLog(@"TeamInvite%@",[[NSString alloc] initWithFormat:@"%@%@",IMAGELINKTHUMB, newEvent.senderProfileImage ]);
    
     [cell1.posted cleanPhotoFrame];
    if(newEvent.profImg)
    {
        NSURL *url=[[NSURL alloc] initWithString:newEvent.profImg];
        
        [cell1.posted setImageWithURL:url placeholderImage:self.noImage];
        
         [cell1.posted applyPhotoFrame];
        
    }
    else
    {
        [cell1.posted setImage:self.noImage];
    }
    
    
    
    
    
    if( newEvent.viewStatus.boolValue==0)
    {
        cell1.statusimagvw.image=self.dotImage;
        cell1.mainBackgroundVw.backgroundColor=appDelegate.backGroundUnreadGray;
    }
    
    else
    {
        cell1.statusimagvw.image=nil;
        
        cell1.mainBackgroundVw.backgroundColor=self.whitecolor;
    }
    
    
    
    
    
    CGRect btrect=cell1.separator.frame;
    btrect.origin.y=cell1.teamName.frame.origin.y+cell1.teamName.frame.size.height+4;
    if (self.isiPad) {
        if(btrect.origin.y<99)
            btrect.origin.y=99;
    }
    else{
        if(btrect.origin.y<58)
            btrect.origin.y=58;
    }
    cell1.separator.frame=btrect;
}


/////////////////////////


- (void)configureCellAdminResponse: (PushByTeamResponseCell *)cell1 atIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    Invite *newEvent= [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //newEvent.senderName;
    NSString *ss=nil;
    if(newEvent.inviteStatus.intValue==1)
    {
        ss=@"accepted";
    }
    else if(newEvent.inviteStatus.intValue==2)
    {
        ss=@"declined";
    }
    else if(newEvent.inviteStatus.intValue==3)
    {
        ss=@"Maybe";
    }
    
    
    NSString *acstr=nil;
    
    // “”player” accepted team event invite as a Maybe
    
    
    /*if(newEvent.inviteStatus.intValue==3)
        acstr= [[NSString alloc] initWithFormat:@"%@ accepted team invite as a %@ for %@",newEvent.playerName,ss,newEvent.teamName];
    else*/
        acstr=    [[NSString alloc] initWithFormat:@"%@ %@ Admin invite for %@",newEvent.playerName,ss,newEvent.teamName];
    
    NSMutableAttributedString *attr=[[NSMutableAttributedString alloc] initWithString:acstr];
    
    
    [attr addAttribute:NSForegroundColorAttributeName value:self.dGrayColor range:NSMakeRange(0, acstr.length)];
    [attr addAttribute:NSFontAttributeName value:self.helveticaFontForte range:NSMakeRange(0, acstr.length)];
    
    if(acstr && newEvent.teamName)
        [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:newEvent.teamName]];
    
    if(acstr && ss){
        
        if ([ss isEqualToString:@"accepted"]) {
            [attr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:74.0/255.0 green:186.0/255.0 blue:111.0/255.0 alpha:1.0] range:[acstr rangeOfString:@"accepted"]];
        }
        else if ([ss isEqualToString:@"declined"]) {
            [attr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:239.0/255.0 green:63.0/255.0 blue:55.0/255.0 alpha:1.0] range:[acstr rangeOfString:@"declined"]];
        }
        [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:ss]];
        
    }
    
    if(acstr && newEvent.playerName)
        [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:newEvent.playerName]];
    
    
    
    
    
    
    
    cell1.senderName.attributedText=attr;//[[NSString alloc] initWithFormat:@"%@ Team",newEvent.teamName];;
    [cell1.senderName sizeToFit];
    /*if(newEvent.message)
     cell1.teamName.text=newEvent.message;
     else
     cell1.teamName.text=[[NSString alloc] initWithFormat:TEAMINVITECONTENTSHOWROW,newEvent.teamName,newEvent.teamSport,newEvent.creatorName,newEvent.creatorName,newEvent.creatorEmail,newEvent.creatorPhno];*/
    float dY=cell1.senderName.frame.origin.y;
    
    
    
    
    // cell1.senderName.frame=CGRectMake(65, dY, 230, labelTextSize.height);
    
    dY+=cell1.senderName.frame.size.height;
    
    if (self.isiPad) {
        dY+=4;
        cell1.teamName.frame=CGRectMakeWithSize(cell1.teamName.frame.origin.x,(dY+2), cell1.teamName.frame.size);
        cell1.leftimagetime.frame=CGRectMakeWithSize(cell1.leftimagetime.frame.origin.x,(dY+2+2), cell1.leftimagetime.frame.size);
    }
    else{
        
        cell1.teamName.frame=CGRectMakeWithSize(cell1.teamName.frame.origin.x,(dY+2), cell1.teamName.frame.size);
        cell1.leftimagetime.frame=CGRectMakeWithSize(cell1.leftimagetime.frame.origin.x,(dY+2+1), cell1.leftimagetime.frame.size);
    }
    
    
    cell1.teamName.text=[self getDateTimeForHistory:newEvent.datetime];
    cell1.teamName.hidden=NO;
    cell1.statusLabel.hidden=YES;
    /* cell1.acceptBtn.hidden=YES;
     cell1.declineBtn.hidden=YES;
     cell1.maybeBtn.hidden=YES;
     
     
     [cell1.acceptBtn addTarget:self action:@selector(acceptInvite:) forControlEvents:UIControlEventTouchUpInside];
     
     [cell1.declineBtn addTarget:self action:@selector(declineInvite:) forControlEvents:UIControlEventTouchUpInside];
     
     [cell1.maybeBtn addTarget:self action:@selector(mayBeInvite:) forControlEvents:UIControlEventTouchUpInside];*/
    
    /*if( newEvent.inviteStatus.intValue==0)
     {
     cell1.statusLabel.hidden=YES;
     cell1.acceptBtn.hidden=NO;
     cell1.declineBtn.hidden=NO;
     cell1.maybeBtn.hidden=NO;
     }
     else if( newEvent.inviteStatus.intValue==1)
     {
     cell1.statusLabel.text=@"Accepted";
     }
     else if( newEvent.inviteStatus.intValue==2)
     {
     cell1.statusLabel.text=@"Declined";
     }
     else
     {
     cell1.statusLabel.text=@"May Be";
     }*/
    
    
    /*ImageInfo * info1=nil;
     
     NSLog(@"%i--%i",(self.dataImages.count-1),indexPath.row);
     
     int check=(self.dataImages.count-1);
     
     
     if(indexPath.row<=check)
     {
     info1 = [self.dataImages objectAtIndex:indexPath.row];
     }
     else
     {
     info1=[[ImageInfo alloc] initWithSourceURL:[[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"%@%@",TEAM_LOGO_URL, newEvent.senderProfileImage ]]];
     
     [self.dataImages insertObject:info1 atIndex:indexPath.row];
     }*/
    
    /* if(info1.image)
     {
     [cell1.posted setImage:info1.image   ];
     
     
     }
     else
     {
     cell1.posted.image=self.noImage;
     info1.notificationName=INVITEBYTEAMIMAGELOADED;
     info1.notifiedObject=[NSNumber numberWithInt:indexPath.row];
     if(!info1.isProcessing)
     [info1 getImage];
     }*/
    
    // NSLog(@"TeamInvite%@",[[NSString alloc] initWithFormat:@"%@%@",IMAGELINKTHUMB, newEvent.senderProfileImage ]);
    
    [cell1.posted cleanPhotoFrame];
    if(newEvent.profImg)
    {
        NSURL *url=[[NSURL alloc] initWithString:newEvent.profImg];
        
        [cell1.posted setImageWithURL:url placeholderImage:self.noImage];
        
        [cell1.posted applyPhotoFrame];
        
    }
    else
    {
        [cell1.posted setImage:self.noImage];
    }
    
    
    
    
    
    if( newEvent.viewStatus.boolValue==0)
    {
        cell1.statusimagvw.image=self.dotImage;
        cell1.mainBackgroundVw.backgroundColor=appDelegate.backGroundUnreadGray;
    }
    
    else
    {
        cell1.statusimagvw.image=nil;
        
        cell1.mainBackgroundVw.backgroundColor=self.whitecolor;
    }
    
    
    
    
    
    CGRect btrect=cell1.separator.frame;
    btrect.origin.y=cell1.teamName.frame.origin.y+cell1.teamName.frame.size.height+4;
    if (self.isiPad) {
        if(btrect.origin.y<99)
            btrect.origin.y=99;
    }
    else{
        if(btrect.origin.y<58)
            btrect.origin.y=58;
    }
    cell1.separator.frame=btrect;
}





/////////////////////////

- (void)configureCellUserTeamResponse: (PushByTeamResponseCell *)cell1 atIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    Invite *newEvent= [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //newEvent.senderName;
    NSString *ss=nil;
    if(newEvent.inviteStatus.intValue==1)
    {
        ss=@"accepted";
    }
    else if(newEvent.inviteStatus.intValue==2)
    {
        ss=@"declined";
    }
    else if(newEvent.inviteStatus.intValue==3)
    {
        ss=@"Maybe";
    }
    
    
    NSString *acstr=nil;
    
    // “”player” accepted team event invite as a Maybe
    
    
    if(newEvent.inviteStatus.intValue==3)
        acstr= [[NSString alloc] initWithFormat:@"%@ accepted Team invite as a %@ for %@",newEvent.playerName,ss,newEvent.teamName];
    else
        acstr=    [[NSString alloc] initWithFormat:@"%@ %@ Team invite for %@",newEvent.playerName,ss,newEvent.teamName];
    
    NSMutableAttributedString *attr=[[NSMutableAttributedString alloc] initWithString:acstr];
    
    
    [attr addAttribute:NSForegroundColorAttributeName value:self.dGrayColor range:NSMakeRange(0, acstr.length)];
    [attr addAttribute:NSFontAttributeName value:self.helveticaFontForte range:NSMakeRange(0, acstr.length)];
    
    if(acstr && newEvent.teamName)
        [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:newEvent.teamName]];
    
    if(acstr && ss){
        if ([ss isEqualToString:@"accepted"]) {
            [attr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:74.0/255.0 green:186.0/255.0 blue:111.0/255.0 alpha:1.0] range:[acstr rangeOfString:@"accepted"]];
        }
        else if ([ss isEqualToString:@"declined"]) {
            [attr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:239.0/255.0 green:63.0/255.0 blue:55.0/255.0 alpha:1.0] range:[acstr rangeOfString:@"declined"]];
        }
        
        [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:ss]];
        
    }
    
    if(acstr && newEvent.playerName)
        [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:newEvent.playerName]];
    
    
    
    
    
    
    
    cell1.senderName.attributedText=attr;//[[NSString alloc] initWithFormat:@"%@ Team",newEvent.teamName];;
    [cell1.senderName sizeToFit];
    /*if(newEvent.message)
     cell1.teamName.text=newEvent.message;
     else
     cell1.teamName.text=[[NSString alloc] initWithFormat:TEAMINVITECONTENTSHOWROW,newEvent.teamName,newEvent.teamSport,newEvent.creatorName,newEvent.creatorName,newEvent.creatorEmail,newEvent.creatorPhno];*/
    float dY=cell1.senderName.frame.origin.y;
    
    
    
    
    // cell1.senderName.frame=CGRectMake(65, dY, 230, labelTextSize.height);
    
    dY+=cell1.senderName.frame.size.height;
    
    if (self.isiPad) {
        dY+=4;
        cell1.teamName.frame=CGRectMakeWithSize(cell1.teamName.frame.origin.x,(dY+2), cell1.teamName.frame.size);
        cell1.leftimagetime.frame=CGRectMakeWithSize(cell1.leftimagetime.frame.origin.x,(dY+2+2), cell1.leftimagetime.frame.size);
    }
    else{
    cell1.teamName.frame=CGRectMakeWithSize(cell1.teamName.frame.origin.x,(dY+2), cell1.teamName.frame.size);
    cell1.leftimagetime.frame=CGRectMakeWithSize(cell1.leftimagetime.frame.origin.x,(dY+2+1), cell1.leftimagetime.frame.size);
    }
    
    
    cell1.teamName.text=[self getDateTimeForHistory:newEvent.datetime];
    cell1.teamName.hidden=NO;
    cell1.statusLabel.hidden=YES;
    /* cell1.acceptBtn.hidden=YES;
     cell1.declineBtn.hidden=YES;
     cell1.maybeBtn.hidden=YES;
     
     
     [cell1.acceptBtn addTarget:self action:@selector(acceptInvite:) forControlEvents:UIControlEventTouchUpInside];
     
     [cell1.declineBtn addTarget:self action:@selector(declineInvite:) forControlEvents:UIControlEventTouchUpInside];
     
     [cell1.maybeBtn addTarget:self action:@selector(mayBeInvite:) forControlEvents:UIControlEventTouchUpInside];*/
    
    /*if( newEvent.inviteStatus.intValue==0)
     {
     cell1.statusLabel.hidden=YES;
     cell1.acceptBtn.hidden=NO;
     cell1.declineBtn.hidden=NO;
     cell1.maybeBtn.hidden=NO;
     }
     else if( newEvent.inviteStatus.intValue==1)
     {
     cell1.statusLabel.text=@"Accepted";
     }
     else if( newEvent.inviteStatus.intValue==2)
     {
     cell1.statusLabel.text=@"Declined";
     }
     else
     {
     cell1.statusLabel.text=@"May Be";
     }*/
    
    
    /*ImageInfo * info1=nil;
     
     NSLog(@"%i--%i",(self.dataImages.count-1),indexPath.row);
     
     int check=(self.dataImages.count-1);
     
     
     if(indexPath.row<=check)
     {
     info1 = [self.dataImages objectAtIndex:indexPath.row];
     }
     else
     {
     info1=[[ImageInfo alloc] initWithSourceURL:[[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"%@%@",TEAM_LOGO_URL, newEvent.senderProfileImage ]]];
     
     [self.dataImages insertObject:info1 atIndex:indexPath.row];
     }*/
    
    /* if(info1.image)
     {
     [cell1.posted setImage:info1.image   ];
     
     
     }
     else
     {
     cell1.posted.image=self.noImage;
     info1.notificationName=INVITEBYTEAMIMAGELOADED;
     info1.notifiedObject=[NSNumber numberWithInt:indexPath.row];
     if(!info1.isProcessing)
     [info1 getImage];
     }*/
    
    // NSLog(@"TeamInvite%@",[[NSString alloc] initWithFormat:@"%@%@",IMAGELINKTHUMB, newEvent.senderProfileImage ]);
    
    [cell1.posted cleanPhotoFrame];
    if(newEvent.profImg)
    {
        NSURL *url=[[NSURL alloc] initWithString:newEvent.profImg];
        
        [cell1.posted setImageWithURL:url placeholderImage:self.noImage];
        
        [cell1.posted applyPhotoFrame];
        
    }
    else
    {
        [cell1.posted setImage:self.noImage];
    }
    
    
    
    
    
    if( newEvent.viewStatus.boolValue==0)
    {
        cell1.statusimagvw.image=self.dotImage;
        cell1.mainBackgroundVw.backgroundColor=appDelegate.backGroundUnreadGray;
    }
    
    else
    {
        cell1.statusimagvw.image=nil;
        
        cell1.mainBackgroundVw.backgroundColor=self.whitecolor;
    }
    
    
    
    
    
    CGRect btrect=cell1.separator.frame;
    btrect.origin.y=cell1.teamName.frame.origin.y+cell1.teamName.frame.size.height+4;
    if (self.isiPad) {
        if(btrect.origin.y<99)
            btrect.origin.y=99;
    }
    else{
        if(btrect.origin.y<58)
            btrect.origin.y=58;
    }
    cell1.separator.frame=btrect;
}








- (void)configureCellTeamEventResponse:(PushByTeamResponseCell *)cell1 atIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    Invite *newEvent= [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //newEvent.senderName;
    NSString *ss=nil;
    if(newEvent && newEvent.inviteStatus.intValue==0)
    {
        ss=@"accepted";
    }
    else if(newEvent.inviteStatus.intValue==2)
    {
        ss=@"declined";
    }
    else if(newEvent.inviteStatus.intValue==3)
    {
        ss=@"Maybe";
    }
    
    
    NSString *acstr=nil;
    
    // “”player” accepted team event invite as a Maybe
    
    
    if(newEvent.inviteStatus.intValue==3)
        acstr= [[NSString alloc] initWithFormat:@"%@ accepted %@ event invite as a %@ for %@",newEvent.playerName,newEvent.eventName,ss,newEvent.teamName];
    else
        acstr=    [[NSString alloc] initWithFormat:@"%@ %@ %@ event invite for %@",newEvent.playerName,ss,newEvent.eventName,newEvent.teamName];
    
    NSMutableAttributedString *attr=[[NSMutableAttributedString alloc] initWithString:acstr];
    
    
    [attr addAttribute:NSForegroundColorAttributeName value:self.dGrayColor range:NSMakeRange(0, acstr.length)];
    [attr addAttribute:NSFontAttributeName value:self.helveticaFontForte range:NSMakeRange(0, acstr.length)];
    
    if(acstr && newEvent.teamName)
        [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:newEvent.teamName]];
    
    if(acstr && ss){
        
        if ([ss isEqualToString:@"accepted"]) {
            [attr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:74.0/255.0 green:186.0/255.0 blue:111.0/255.0 alpha:1.0] range:[acstr rangeOfString:@"accepted"]];
        }
        else if ([ss isEqualToString:@"declined"]) {
            [attr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:239.0/255.0 green:63.0/255.0 blue:55.0/255.0 alpha:1.0] range:[acstr rangeOfString:@"declined"]];
        }
    
        [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:ss]];
    }

    if(acstr && newEvent.playerName)
        [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:newEvent.playerName]];
    
    
    if(acstr && newEvent.eventName)
        [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:newEvent.eventName]];
    
    
    
    
    cell1.senderName.attributedText=attr;//[[NSString alloc] initWithFormat:@"%@ Team",newEvent.teamName];;
    [cell1.senderName sizeToFit];
    /*if(newEvent.message)
     cell1.teamName.text=newEvent.message;
     else
     cell1.teamName.text=[[NSString alloc] initWithFormat:TEAMINVITECONTENTSHOWROW,newEvent.teamName,newEvent.teamSport,newEvent.creatorName,newEvent.creatorName,newEvent.creatorEmail,newEvent.creatorPhno];*/
    float dY=cell1.senderName.frame.origin.y;
    
    
    
    
    // cell1.senderName.frame=CGRectMake(65, dY, 230, labelTextSize.height);
    
    dY+=cell1.senderName.frame.size.height;
    if (self.isiPad) {
        dY+=4;
        cell1.teamName.frame=CGRectMakeWithSize(cell1.teamName.frame.origin.x,(dY+2), cell1.teamName.frame.size);
        cell1.leftimagetime.frame=CGRectMakeWithSize(cell1.leftimagetime.frame.origin.x,(dY+2+2), cell1.leftimagetime.frame.size);
    }
    else{
        
        cell1.teamName.frame=CGRectMakeWithSize(cell1.teamName.frame.origin.x,(dY+2), cell1.teamName.frame.size);
        cell1.leftimagetime.frame=CGRectMakeWithSize(cell1.leftimagetime.frame.origin.x,(dY+2+1), cell1.leftimagetime.frame.size);
    }
    
    
    cell1.teamName.text=[self getDateTimeForHistory:newEvent.datetime];
    cell1.teamName.hidden=NO;
    cell1.statusLabel.hidden=YES;
    /* cell1.acceptBtn.hidden=YES;
     cell1.declineBtn.hidden=YES;
     cell1.maybeBtn.hidden=YES;
     
     
     [cell1.acceptBtn addTarget:self action:@selector(acceptInvite:) forControlEvents:UIControlEventTouchUpInside];
     
     [cell1.declineBtn addTarget:self action:@selector(declineInvite:) forControlEvents:UIControlEventTouchUpInside];
     
     [cell1.maybeBtn addTarget:self action:@selector(mayBeInvite:) forControlEvents:UIControlEventTouchUpInside];*/
    
    /*if( newEvent.inviteStatus.intValue==0)
     {
     cell1.statusLabel.hidden=YES;
     cell1.acceptBtn.hidden=NO;
     cell1.declineBtn.hidden=NO;
     cell1.maybeBtn.hidden=NO;
     }
     else if( newEvent.inviteStatus.intValue==1)
     {
     cell1.statusLabel.text=@"Accepted";
     }
     else if( newEvent.inviteStatus.intValue==2)
     {
     cell1.statusLabel.text=@"Declined";
     }
     else
     {
     cell1.statusLabel.text=@"May Be";
     }*/
    
    
    /*ImageInfo * info1=nil;
     
     NSLog(@"%i--%i",(self.dataImages.count-1),indexPath.row);
     
     int check=(self.dataImages.count-1);
     
     
     if(indexPath.row<=check)
     {
     info1 = [self.dataImages objectAtIndex:indexPath.row];
     }
     else
     {
     info1=[[ImageInfo alloc] initWithSourceURL:[[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"%@%@",TEAM_LOGO_URL, newEvent.senderProfileImage ]]];
     
     [self.dataImages insertObject:info1 atIndex:indexPath.row];
     }*/
    
    /* if(info1.image)
     {
     [cell1.posted setImage:info1.image   ];
     
     
     }
     else
     {
     cell1.posted.image=self.noImage;
     info1.notificationName=INVITEBYTEAMIMAGELOADED;
     info1.notifiedObject=[NSNumber numberWithInt:indexPath.row];
     if(!info1.isProcessing)
     [info1 getImage];
     }*/
    
    // NSLog(@"TeamInvite%@",[[NSString alloc] initWithFormat:@"%@%@",IMAGELINKTHUMB, newEvent.senderProfileImage ]);
    
    [cell1.posted cleanPhotoFrame];
    if(newEvent.profImg)
    {
        NSURL *url=[[NSURL alloc] initWithString:newEvent.profImg];
        
        [cell1.posted setImageWithURL:url placeholderImage:self.noImage];
        
        [cell1.posted applyPhotoFrame];
        
    }
    else
    {
        [cell1.posted setImage:self.noImage];
    }
    
    
    
    
    
    if( newEvent.viewStatus.boolValue==0)
    {
        cell1.statusimagvw.image=self.dotImage;
        cell1.mainBackgroundVw.backgroundColor=appDelegate.backGroundUnreadGray;
    }
    
    else
    {
        cell1.statusimagvw.image=nil;
        
        cell1.mainBackgroundVw.backgroundColor=self.whitecolor;
    }
    
    
    
    
    
    CGRect btrect=cell1.separator.frame;
    btrect.origin.y=cell1.teamName.frame.origin.y+cell1.teamName.frame.size.height+4;
    
    if (self.isiPad) {
        if(btrect.origin.y<99)
            btrect.origin.y=99;
    }
    else{
        if(btrect.origin.y<58)
            btrect.origin.y=58;
    }
    cell1.separator.frame=btrect;

    
    
    
    
    
    
    
    
}


- (void)configureCellUserTeamEventResponse: (PushByTeamResponseCell *)cell1 atIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    Invite *newEvent= [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //newEvent.senderName;
    NSString *ss=nil;
    if(newEvent && newEvent.inviteStatus.intValue==0)
    {
        ss=@"accepted";
    }
    else if(newEvent.inviteStatus.intValue==2)
    {
        ss=@"declined";
    }
    else if(newEvent.inviteStatus.intValue==3)
    {
        ss=@"Maybe";
    }
    
    
    NSString *acstr=nil;
    
    // “”player” accepted team event invite as a Maybe
    
    
    if(newEvent.inviteStatus.intValue==3)
        acstr= [[NSString alloc] initWithFormat:@"%@ has changed his RSVP for %@ %@ to %@",newEvent.playerName,newEvent.teamName,newEvent.eventName,ss];
    else
        acstr=    [[NSString alloc] initWithFormat:@"%@ %@ %@ event invite for %@",newEvent.playerName,ss,newEvent.eventName,newEvent.teamName];
    
    NSMutableAttributedString *attr=[[NSMutableAttributedString alloc] initWithString:acstr];
    
    
    [attr addAttribute:NSForegroundColorAttributeName value:self.dGrayColor range:NSMakeRange(0, acstr.length)];
    [attr addAttribute:NSFontAttributeName value:self.helveticaFontForte range:NSMakeRange(0, acstr.length)];
    
    if(acstr && newEvent.teamName)
        [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:newEvent.teamName]];
    
    if(acstr && ss){
        
        if ([ss isEqualToString:@"accepted"]) {
            [attr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:74.0/255.0 green:186.0/255.0 blue:111.0/255.0 alpha:1.0] range:[acstr rangeOfString:@"accepted"]];
        }
        else if ([ss isEqualToString:@"declined"]) {
            [attr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:239.0/255.0 green:63.0/255.0 blue:55.0/255.0 alpha:1.0] range:[acstr rangeOfString:@"declined"]];
        }
        [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:ss]];
    }
    
    if(acstr && newEvent.playerName)
        [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:newEvent.playerName]];
    
    
    
    if(acstr && newEvent.eventName)
        [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:newEvent.eventName]];
    
    
    
    cell1.senderName.attributedText=attr;//[[NSString alloc] initWithFormat:@"%@ Team",newEvent.teamName];;
    [cell1.senderName sizeToFit];
    /*if(newEvent.message)
     cell1.teamName.text=newEvent.message;
     else
     cell1.teamName.text=[[NSString alloc] initWithFormat:TEAMINVITECONTENTSHOWROW,newEvent.teamName,newEvent.teamSport,newEvent.creatorName,newEvent.creatorName,newEvent.creatorEmail,newEvent.creatorPhno];*/
    float dY=cell1.senderName.frame.origin.y;
    
    
    
    
    // cell1.senderName.frame=CGRectMake(65, dY, 230, labelTextSize.height);
    
    dY+=cell1.senderName.frame.size.height;
    
    if (self.isiPad) {
        dY+=4;
        cell1.teamName.frame=CGRectMakeWithSize(cell1.teamName.frame.origin.x,(dY+2), cell1.teamName.frame.size);
        cell1.leftimagetime.frame=CGRectMakeWithSize(cell1.leftimagetime.frame.origin.x,(dY+2+2), cell1.leftimagetime.frame.size);
    }
    else{
        cell1.teamName.frame=CGRectMakeWithSize(cell1.teamName.frame.origin.x,(dY+2), cell1.teamName.frame.size);
        cell1.leftimagetime.frame=CGRectMakeWithSize(cell1.leftimagetime.frame.origin.x,(dY+2+1), cell1.leftimagetime.frame.size);
    }
    
    
    cell1.teamName.text=[self getDateTimeForHistory:newEvent.datetime];
    cell1.teamName.hidden=NO;
    cell1.statusLabel.hidden=YES;
    /* cell1.acceptBtn.hidden=YES;
     cell1.declineBtn.hidden=YES;
     cell1.maybeBtn.hidden=YES;
     
     
     [cell1.acceptBtn addTarget:self action:@selector(acceptInvite:) forControlEvents:UIControlEventTouchUpInside];
     
     [cell1.declineBtn addTarget:self action:@selector(declineInvite:) forControlEvents:UIControlEventTouchUpInside];
     
     [cell1.maybeBtn addTarget:self action:@selector(mayBeInvite:) forControlEvents:UIControlEventTouchUpInside];*/
    
    /*if( newEvent.inviteStatus.intValue==0)
     {
     cell1.statusLabel.hidden=YES;
     cell1.acceptBtn.hidden=NO;
     cell1.declineBtn.hidden=NO;
     cell1.maybeBtn.hidden=NO;
     }
     else if( newEvent.inviteStatus.intValue==1)
     {
     cell1.statusLabel.text=@"Accepted";
     }
     else if( newEvent.inviteStatus.intValue==2)
     {
     cell1.statusLabel.text=@"Declined";
     }
     else
     {
     cell1.statusLabel.text=@"May Be";
     }*/
    
    
    /*ImageInfo * info1=nil;
     
     NSLog(@"%i--%i",(self.dataImages.count-1),indexPath.row);
     
     int check=(self.dataImages.count-1);
     
     
     if(indexPath.row<=check)
     {
     info1 = [self.dataImages objectAtIndex:indexPath.row];
     }
     else
     {
     info1=[[ImageInfo alloc] initWithSourceURL:[[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"%@%@",TEAM_LOGO_URL, newEvent.senderProfileImage ]]];
     
     [self.dataImages insertObject:info1 atIndex:indexPath.row];
     }*/
    
    /* if(info1.image)
     {
     [cell1.posted setImage:info1.image   ];
     
     
     }
     else
     {
     cell1.posted.image=self.noImage;
     info1.notificationName=INVITEBYTEAMIMAGELOADED;
     info1.notifiedObject=[NSNumber numberWithInt:indexPath.row];
     if(!info1.isProcessing)
     [info1 getImage];
     }*/
    
    // NSLog(@"TeamInvite%@",[[NSString alloc] initWithFormat:@"%@%@",IMAGELINKTHUMB, newEvent.senderProfileImage ]);
    
    [cell1.posted cleanPhotoFrame];
    if(newEvent.profImg)
    {
        NSURL *url=[[NSURL alloc] initWithString:newEvent.profImg];
        
        [cell1.posted setImageWithURL:url placeholderImage:self.noImage];
        
        [cell1.posted applyPhotoFrame];
        
    }
    else
    {
        [cell1.posted setImage:self.noImage];
    }
    
    
    
    
    
    if( newEvent.viewStatus.boolValue==0)
    {
        cell1.statusimagvw.image=self.dotImage;
        cell1.mainBackgroundVw.backgroundColor=appDelegate.backGroundUnreadGray;
    }
    
    else
    {
        cell1.statusimagvw.image=nil;
        
        cell1.mainBackgroundVw.backgroundColor=self.whitecolor;
    }
    
    
    
    
    
    CGRect btrect=cell1.separator.frame;
    btrect.origin.y=cell1.teamName.frame.origin.y+cell1.teamName.frame.size.height+4;
    if (self.isiPad) {
        if(btrect.origin.y<99)
            btrect.origin.y=99;
    }
    else{
        if(btrect.origin.y<58)
            btrect.origin.y=58;
    }
    cell1.separator.frame=btrect;
    
    
    
}


//////////////////////
- (void)configureCellPushByCoachUpdate:(PushByCoachUpdateCell *)cell1 atIndexPath:(NSIndexPath *)indexPath
{
    
    
    Invite *newEvent = [self.fetchedResultsController  objectAtIndexPath: indexPath];
    
    
    
  //  float dY=22;
    float dY=2;
    CGSize labelTextSize;
  //  @autoreleasepool {
        
    
        NSString *text= nil;//[NSString stringWithFormat:@"\"%@\"", newEvent.message ];
    
 
              //       }
    ////////////////
  
  
    
    NSString *acstr=nil;
    @autoreleasepool {
        
        
        
        text=[NSString stringWithFormat:@"\"%@\"",newEvent.message ];
        acstr=  [[NSString alloc] initWithFormat:@"%@ coach update %@",newEvent.teamName,text];
        
        if (self.isiPad) {
            labelTextSize =[self getSizeOfText:acstr :CGSizeMake (607,10000) :self.helveticaFontForte];
        }
        else
            labelTextSize =[self getSizeOfText:acstr :CGSizeMake (245,10000) :self.helveticaFontForte];
        
        
        //[text sizeWithFont:self.helveticaFontForte constrainedToSize:CGSizeMake (220,10000) lineBreakMode: NSLineBreakByWordWrapping];
        
        
        
        
        // dY=dY+labelTextSize.height+2+15+5;
    }
    
    if(labelTextSize.height<17){
        labelTextSize.height=16;
        dY+=8;
    }
    if (self.isiPad) {
        dY+=6;
        cell1.senderName.frame= CGRectMake(cell1.senderName.frame.origin.x, dY, 607, labelTextSize.height);
    }
    else
        cell1.senderName.frame= CGRectMake(cell1.senderName.frame.origin.x, dY, 245, labelTextSize.height);
   cell1.senderName.font=self.helveticaFont;
    cell1.senderName.textColor=self.darkgraycolor;
    
    
    NSMutableAttributedString *attr=[[NSMutableAttributedString alloc] initWithString:acstr];
    
    
    
    //// AD 19th May
     //[attr addAttribute:NSForegroundColorAttributeName value:self.dGrayColor range:NSMakeRange(0, acstr.length)];
    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:239.0/255.0 green:63.0/255.0 blue:55.0/255.0 alpha:1.0] range:NSMakeRange(0, acstr.length)];
    [attr addAttribute:NSFontAttributeName value:self.helveticaFontForte range:NSMakeRange(0, acstr.length)];
    
    
       if(acstr && newEvent.teamName)
    [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:newEvent.teamName]];
    
    if(acstr && @"update"){
        //[attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[acstr rangeOfString:@"coach update"]];
    [attr addAttribute:NSFontAttributeName value:self.helveticaFontForteBold range:[acstr rangeOfString:@"update"]];
    }
    
    
    cell1.senderName.attributedText=attr;
    
       
    cell1.senderName.tag=10;
    cell1.senderName.numberOfLines=0;
    
    
    [cell1.senderName sizeToFit];
    dY+=cell1.senderName.frame.size.height;
    
    dY+=2;

    
    ////////////////

    /*if(labelTextSize.height<16)
        labelTextSize.height=16;
    
    cell1.teamName.frame= CGRectMake(cell1.teamName.frame.origin.x, dY, 205, labelTextSize.height);*/
    
    
   // cell1.teamName.numberOfLines=0;
   // dY+=labelTextSize.height;
    
   // dY+=2;
    
    
    
    
    
    if (self.isiPad) {
        dY+=3;
        cell1.statusLabel.frame= CGRectMake(cell1.statusLabel.frame.origin.x, dY, 550, 21);
    }
    else
        cell1.statusLabel.frame= CGRectMake(cell1.statusLabel.frame.origin.x, dY, 230, 15);
    
    cell1.imageViewTime.frame=CGRectMakeWithSize(cell1.imageViewTime.frame.origin.x, (dY+3), cell1.imageViewTime.frame.size);
    
    
    
    
  
    
    
  
    
    
    cell1.statusLabel.text=[self getDateTimeForHistory:newEvent.datetime];
    
    @autoreleasepool {
     //   cell1.teamName.text=[NSString stringWithFormat:@"\"%@\"", newEvent.message ];
        
        
        
        
        if(  newEvent.inviteStatus.intValue==0)
        {
            cell1.dotimavw.hidden=NO;
            cell1.mainBackgroundVw.backgroundColor=appDelegate.backGroundUnreadGray;
        }
        
        else
        {
            cell1.dotimavw.hidden=YES;
            cell1.mainBackgroundVw.backgroundColor=self.whitecolor;
        }
    }
    
    
    CGRect btrect=cell1.separator.frame;
    btrect.origin.y=cell1.statusLabel.frame.origin.y+cell1.statusLabel.frame.size.height+3;
    if (self.isiPad) {
        if(btrect.origin.y<99)
            btrect.origin.y=99;
    }
    else{
        if(btrect.origin.y<58)
            btrect.origin.y=58;
    }
    cell1.separator.frame=btrect;
    
    
    /*ImageInfo * info1=nil;
    
    NSLog(@"%i--%i",(self.dataImages.count-1),indexPath.row);
    
    int check=(self.dataImages.count-1);
    
    
    if(indexPath.row<=check)
    {
        info1 = [self.dataImages objectAtIndex:indexPath.row];
    }
    else
    {
        info1=[[ImageInfo alloc] initWithSourceURL:[[NSURL alloc] initWithString:newEvent.senderProfileImage]];
        
        [self.dataImages insertObject:info1 atIndex:indexPath.row];
    }*/
    
    /*if(info1.image)
    {
        [cell1.posted setImage:info1.image   ];
        
        
    }
    else
    {
        cell1.posted.image=self.teamNoImage;
        info1.notificationName=COACHUPDATEPUSHLISTINGIMAGELOADED;
        info1.notifiedObject=[NSNumber numberWithInt:indexPath.row];
        if(!info1.isProcessing)
            [info1 getImage];
    }*/
    
    NSLog(@"CoachUpdate%@",newEvent.senderProfileImage);
     [cell1.posted cleanPhotoFrame];
    if(newEvent.senderProfileImage)
    {
    NSURL *url=[[NSURL alloc] initWithString:newEvent.senderProfileImage];
    
    [cell1.posted setImageWithURL:url placeholderImage:self.teamNoImage];
        
         [cell1.posted applyPhotoFrame];
    }
    else
    {
        [cell1.posted setImage:self.teamNoImage];
    }
    
    
  
   
    
    
    
    
}


///////////////////////////////////////////
-(void)acceptInvite:(UIButton*)sender
{
    if(loadStatus)
        return;
    
    
   
    
    
    
    
       self.loadStatus=1;
    
    
    
    PushByInviteTeamCell *cell=nil;
    
    if(appDelegate.isIos7)
    cell=(PushByInviteTeamCell*) sender.superview.superview.superview.superview;
    else
    cell=(PushByInviteTeamCell*) sender.superview.superview.superview;
    
    
    
    NSIndexPath *indexPath= [self.tabView indexPathForCell:cell ];
    
   
    
    Invite *newinvite=[self.fetchedResultsController objectAtIndexPath:indexPath];
    
    
    //////////////////////////////////////////////////////////////////////////
    
    Invite *invite=(Invite*)  [self objectOfTypeInviteTeamResponseForUser:INVITE forId:newinvite.teamId andManObjCon:self.managedObjectContext];
    
    if(invite)
    {
    
        NSIndexPath *aPath=[self.fetchedResultsController indexPathForObject:invite];
        
        
        /*if(invite.viewStatus.boolValue==0)
        {*/
            self.lastSelRowUserTeamResponse=aPath.row;
            self.loadStatus=1;
            NSMutableDictionary *command = [NSMutableDictionary dictionary];
            [command setObject:invite.playerId forKey:@"player_id"];
            [command setObject:invite.message forKey:@"type"];
            
            
            
            SBJsonWriter *writer = [[SBJsonWriter alloc] init];
            
            
            NSString *jsonCommand = [writer stringWithObject:command];
            
            
            [self showHudView:@"Connecting..."];
            [self showNativeHudView];
            NSLog(@"RequestParamJSON=%@",jsonCommand);
            
            
            
            self.requestDic=command;
            
            
            
            SingleRequest *sinReq=nil;
            sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:USERTEAMRESPONSELINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
            self.sinReq1=sinReq;
            [self.storeCreatedRequests addObject:self.sinReq1];
            sinReq.notificationName=USERTEAMRESPONSE;
            
            [sinReq startRequest];
            
            
             return;
        /*}
        else
        {
            
        }*/

        
        
        
        
       
    
    }
   ////////////////////////////////////////////////////////////////////////////////
    self.lastSelIndexPath=indexPath;
    
    
    
    
    
    
     NSString *str=nil;
     str=@"Accept";
    lastSelStatus=1;
    self.strInviteStatus=str;
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    
    if(newinvite.userId)
        [command setObject:newinvite.userId forKey:@"UserID"];
    else
        [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
    
    if(/*![[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:newinvite.userId]*/newinvite.userId)
        [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"Primary_UserID"];
    else
        [command setObject:@"" forKey:@"Primary_UserID"];
    
    
    [command setObject:str forKey:@"invites"];
    [command setObject:newinvite.teamId forKey:@"team_id"];
    [command setObject:@"0" forKey:@"start"];
    [command setObject:DEFAULTLIMIT forKey:@"limit"];
     [command setObject:@"" forKey:@"view"];
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    
    [self showNativeHudView];
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    
    
    self.requestDic=command;
    
    
   // [appDelegate sendRequestFor:INVITEFRIENDSSTATUS from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
 
    SingleRequest *sinReq=nil;
    sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:TEAMINVITESTATUSLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
    self.sinReq1=sinReq;
    [self.storeCreatedRequests addObject:self.sinReq1];
    sinReq.notificationName=TEAMINVITESTATUSBYPUSH;
    [self showHudView:@"Connecting..."];
    [sinReq startRequest];
}

-(void)declineInvite:(UIButton*)sender
{
    if(loadStatus)
        return;
    
    self.isDeclineAdmin=NO;
    
    self.alertViewBAck.hidden=NO;
    self.alertView.hidden=NO;
    
    
       
    PushByInviteTeamCell *cell=nil;
    if(appDelegate.isIos7)
        cell=(PushByInviteTeamCell*) sender.superview.superview.superview.superview;
    else
   cell= (PushByInviteTeamCell*) sender.superview.superview.superview;
    
   NSIndexPath *indexPath= [self.tabView indexPathForCell:cell ];
    
    
    
    self.lastSelIndexPath=indexPath;
    Invite *newinvite=[self.fetchedResultsController objectAtIndexPath:self.lastSelIndexPath];
    Invite *invite=(Invite*)  [self objectOfTypeInviteTeamResponseForUser:INVITE forId:newinvite.teamId andManObjCon:self.managedObjectContext];
    
    
        self.lblAlert.text=[NSString stringWithFormat:@"Are you sure you what to decline? You will not be able to view your %@ moments",invite.teamName];
        
    
    

    
}

-(void)mayBeInvite:(UIButton*)sender
{
    if(loadStatus)
        return;
    
    
    self.loadStatus=1;
    PushByInviteTeamCell *cell=nil;
    if(appDelegate.isIos7)
    cell=(PushByInviteTeamCell*) sender.superview.superview.superview.superview;
    else
    cell=(PushByInviteTeamCell*) sender.superview.superview.superview;
    
    NSIndexPath *indexPath= [self.tabView indexPathForCell:cell ];
    
    
    Invite *newinvite=[self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //////////////////////////////////////////////////////////////////////////
    
    Invite *invite=(Invite*)  [self objectOfTypeInviteTeamResponseForUser:INVITE forId:newinvite.teamId andManObjCon:self.managedObjectContext];
    
    if(invite)
    {
        
        NSIndexPath *aPath=[self.fetchedResultsController indexPathForObject:invite];
        
        
        /*if(invite.viewStatus.boolValue==0)
        {*/
            self.lastSelRowUserTeamResponse=aPath.row;
            self.loadStatus=1;
            NSMutableDictionary *command = [NSMutableDictionary dictionary];
            [command setObject:invite.playerId forKey:@"player_id"];
            [command setObject:invite.message forKey:@"type"];
            
            
            
            SBJsonWriter *writer = [[SBJsonWriter alloc] init];
            
            
            NSString *jsonCommand = [writer stringWithObject:command];
            
            
            [self showHudView:@"Connecting..."];
            [self showNativeHudView];
            NSLog(@"RequestParamJSON=%@",jsonCommand);
            
            
            
            self.requestDic=command;
            
            
            
            SingleRequest *sinReq=nil;
            sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:USERTEAMRESPONSELINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
            self.sinReq1=sinReq;
            [self.storeCreatedRequests addObject:self.sinReq1];
            sinReq.notificationName=USERTEAMRESPONSE;
            
            [sinReq startRequest];
            
            
            return;
        /*}
        else
        {
            
        }*/
        
        
        
        
        
        
        
    }
    ////////////////////////////////////////////////////////////////////////////////
    
     self.lastSelIndexPath=indexPath;
    
    NSString *str=nil;
    
    str=@"Maybe";
    lastSelStatus=3;
    self.strInviteStatus=str;
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    if(newinvite.userId)
        [command setObject:newinvite.userId forKey:@"UserID"];
    else
        [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
    
    if(/*![[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:newinvite.userId]*/newinvite.userId)
        [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"Primary_UserID"];
    else
        [command setObject:@"" forKey:@"Primary_UserID"];
    
    
    [command setObject:str forKey:@"invites"];
    [command setObject:newinvite.teamId forKey:@"team_id"];
    [command setObject:@"0" forKey:@"start"];
    [command setObject:DEFAULTLIMIT forKey:@"limit"];
     [command setObject:@"" forKey:@"view"];
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    
    [self showNativeHudView];
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    
    
     self.requestDic=command;
    
    
    /*[appDelegate sendRequestFor:INVITEFRIENDSSTATUS from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];*/
    
    SingleRequest *sinReq=nil;
    sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:TEAMINVITESTATUSLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
    self.sinReq3=sinReq;
    [self.storeCreatedRequests addObject:self.sinReq3];
    sinReq.notificationName=TEAMINVITESTATUSBYPUSH;
      [self showHudView:@"Connecting..."];
    [sinReq startRequest];
}
///////////////////////////


-(void)acceptInviteAdmin:(UIButton*)sender
{
    if(loadStatus)
        return;
    
    
    
    
    
    
    
    self.loadStatus=1;
    
    
    
    PushByInviteTeamCell *cell=nil;
    
    if(appDelegate.isIos7)
        cell=(PushByInviteTeamCell*) sender.superview.superview.superview.superview;
    else
        cell=(PushByInviteTeamCell*) sender.superview.superview.superview;
    
    
    
    NSIndexPath *indexPath= [self.tabView indexPathForCell:cell ];
    
    
    
    Invite *newinvite=[self.fetchedResultsController objectAtIndexPath:indexPath];
    
    
    //////////////////////////////////////////////////////////////////////////
    
    
    ////////////////////////////////////////////////////////////////////////////////
    self.lastSelIndexPathAdmin=indexPath;
    
    
    
    
    
    
    NSString *str=nil;
    str=@"Accept";
    lastSelStatusAdmin=1;
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    
    
        [command setObject:[appDelegate.aDef objectForKey:EMAIL] forKey:@"creator_email2"];
    
    
    
    
    [command setObject:str forKey:@"coach2_status"];
    [command setObject:newinvite.teamId forKey:@"team_id"];
    [command setObject:@"0" forKey:@"start"];
    [command setObject:DEFAULTLIMIT forKey:@"limit"];
    
    
    [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    
    [self showNativeHudView];
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    
    
    self.requestDic=command;
    
    
    // [appDelegate sendRequestFor:INVITEFRIENDSSTATUS from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
    
    SingleRequest *sinReq=nil;
    sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:ADMININVITESTATUSBYPUSHLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
    self.sinReq1=sinReq;
    [self.storeCreatedRequests addObject:self.sinReq1];
    sinReq.notificationName=ADMININVITESTATUSBYPUSH;
    [self showHudView:@"Connecting..."];
    [sinReq startRequest];
}

-(void)declineInviteAdmin:(UIButton*)sender
{
    if(loadStatus)
        return;
    self.isDeclineAdmin=YES;
    self.lblAlert.text=@"Are you sure you want to decline?";
    self.alertViewBAck.hidden=NO;
    self.alertView.hidden=NO;
    PushByInviteTeamCell *cell=nil;
    if(appDelegate.isIos7)
        cell=(PushByInviteTeamCell*) sender.superview.superview.superview.superview;
    else
        cell= (PushByInviteTeamCell*) sender.superview.superview.superview;
    
    NSIndexPath *indexPath= [self.tabView indexPathForCell:cell ];
    
    
    //////////////////////////////////////////////////////////////////////////
    
    
    
    ////////////////////////////////////////////////////////////////////////////////
    self.lastSelIndexPathAdmin=indexPath;
    
}

-(void)mayBeInviteAdmin:(UIButton*)sender
{
    if(loadStatus)
        return;
    
    
    self.loadStatus=1;
    PushByInviteTeamCell *cell=nil;
    if(appDelegate.isIos7)
        cell=(PushByInviteTeamCell*) sender.superview.superview.superview.superview;
    else
        cell=(PushByInviteTeamCell*) sender.superview.superview.superview;
    
    NSIndexPath *indexPath= [self.tabView indexPathForCell:cell ];
    
    
    Invite *newinvite=[self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //////////////////////////////////////////////////////////////////////////
    
   
    ////////////////////////////////////////////////////////////////////////////////
    
    self.lastSelIndexPathAdmin=indexPath;
    
    
    NSString *str=nil;
    
    str=@"Maybe";
    lastSelStatusAdmin=3;
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    
    [command setObject:[appDelegate.aDef objectForKey:EMAIL] forKey:@"creator_email2"];
    
    
    
    
    [command setObject:str forKey:@"coach2_status"];
    [command setObject:newinvite.teamId forKey:@"team_id"];
   [command setObject:@"0" forKey:@"start"];
    [command setObject:DEFAULTLIMIT forKey:@"limit"];
    [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    
    [self showNativeHudView];
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    
    
    self.requestDic=command;
    
    
    /*[appDelegate sendRequestFor:INVITEFRIENDSSTATUS from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];*/
    
    SingleRequest *sinReq=nil;
    sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:ADMININVITESTATUSBYPUSHLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
    self.sinReq3=sinReq;
    [self.storeCreatedRequests addObject:self.sinReq3];
    sinReq.notificationName=ADMININVITESTATUSBYPUSH;
    [self showHudView:@"Connecting..."];
    [sinReq startRequest];
}








///////////////////////////


-(void)userListUpdated:(id)sender
{
    
    loadStatus=0;
    [self hideNativeHudView];
    [self hideHudView];
    SingleRequest *sReq=(SingleRequest*)[sender object];
    if([sReq.notificationName isEqualToString:TEAMINVITESTATUSBYPUSH])
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
                        [self loadFourSquareDataTeamPostDetails:sReq.responseString];
                        
                        Invite *newEvent=[self.fetchedResultsController objectAtIndexPath:self.lastSelIndexPath];
                        
                        if ([self.strInviteStatus isEqualToString:@"Accept"]) {
                            appDelegate.isTeamAccept=YES;
                            [(TeamMaintenanceVC*)[appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] loadTeamData];
                        }    ////Arpita..
                        
                        newEvent.inviteStatus=[[NSNumber alloc] initWithInt:lastSelStatus ];
                        
                   
                        
                        [appDelegate saveContext];
                       
                        
                        aDict=[aDict objectForKey:@"response"];
                        aDict=[aDict objectForKey:@"team_details"];
                        
                        NSMutableDictionary *micdic=[NSMutableDictionary dictionaryWithObjectsAndKeys:[aDict objectForKey:CREATORNAME],CREATORNAME,[aDict objectForKey:CREATORPHNO],CREATORPHNO,[aDict objectForKey:CREATOREMAIL],CREATOREMAIL, nil];
                        
                        
                           NSString *teamSportN=@"";
                        
                        if(newEvent.teamSport)
                    teamSportN=newEvent.teamSport;
                        
                        [appDelegate.centerVC updateArrayByAddingOneTeam:[aDict objectForKey:@"team_name"] :[NSString stringWithFormat:@"%@", [aDict objectForKey:@"team_id"] ] :[self.requestDic objectForKey:@"invites"] :[NSNumber numberWithInt:0] :[ NSString stringWithFormat:@"%@%@", TEAM_LOGO_URL,[aDict objectForKey:@"team_logo"] ]:[aDict objectForKey:@"status_update"] :appDelegate.arrItems:micdic:teamSportN];
                        
                        
                        NSDictionary *coachDic=nil;
                        int i=0;
                        
                        
                        for(NSString *str in appDelegate.centerVC.dataArrayUpButtonsIds)
                        {
                            if( [aDict objectForKey:@"team_id"] && [str isEqualToString: [aDict objectForKey:@"team_id"] ])
                            {
                               
                                coachDic=[appDelegate.centerVC.dataArrayUpCoachDetails objectAtIndex:i];
                                break;
                            }
                            i++;
                        }
                        
                        
                        if([coachDic objectForKey:@"creator_id"])
                        {
                            NSMutableDictionary *mdic=[coachDic mutableCopy];
                            
                            [mdic setObject:[self.requestDic objectForKey:@"invites"] forKey:PLAYERINVITESTATUS];
                            
                            [appDelegate.centerVC.dataArrayUpCoachDetails replaceObjectAtIndex:i withObject:mdic];
                            
                              [appDelegate setUserDefaultValue:appDelegate.centerVC.dataArrayUpCoachDetails ForKey:ARRAYCOACHDETAILS];
                        }

                        
                        [appDelegate saveContext];
                        
                        
                        ///////////////////////////////////
                        NSArray *eventDetails=[aDict objectForKey:@"event_details"];
                        NSArray *playerDetails=[aDict objectForKey:@"player_details"];
                        
                        NSDictionary *playerinfo=nil;
                        if(playerDetails.count)
                        {
                            playerinfo= [playerDetails objectAtIndex:0];
                        
                            
                            if((newEvent.inviteStatus.intValue==1 )|| (newEvent.inviteStatus.intValue==3))
                            {
                                if(newEvent.inviteStatus.intValue==3)
                                    [self.appDelegate addEventsAfterLogin:eventDetails:0:[playerinfo objectForKey:@"player_name"]:[playerinfo objectForKey:@"player_id"]:[self.requestDic objectForKey:@"UserID"]:1:0:1:0];
                                else
                                    [self.appDelegate addEventsAfterLogin:eventDetails:0:[playerinfo objectForKey:@"player_name"]:[playerinfo objectForKey:@"player_id"]:[self.requestDic objectForKey:@"UserID"]:0:0:1:0];
                            }
                        
                        }
                        
                        
                       
                       /* MainInviteVC* maininvitevc=  (MainInviteVC*) [appDelegate.navigationControllerTeamInvites.viewControllers objectAtIndex:0];
                        
                        
                         [maininvitevc showAlertViewCustom:[[NSString alloc] initWithFormat:@"Welcome to %@ timeline.\nInteract with team member by posting comments, pictures, videos, etc",newEvent.teamName ]];*/
                        if ([self.strInviteStatus isEqualToString:@"Accept"] || [self.strInviteStatus isEqualToString:@"Maybe"]) {
                            [self goToTimeLine:[[NSString alloc] initWithFormat:@"Welcome to %@ timeline.\nInteract with team member by posting comments, pictures, videos, etc",newEvent.teamName ]];
                        }
                        else
                            [self goToTimeLine:[[NSString alloc] initWithFormat:@"Welcome to %@ timeline.\nYou have a limited time access. Please contact team admin to continue after that",newEvent.teamName ]];
                       
                    
                        
                        
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


-(void)goToTimeLine:(NSString*)msg
{
    [appDelegate.centerViewController showNavController:appDelegate.navigationController];
    
    if(appDelegate.centerVC.dataArrayUpButtonsIds.count==1)
    {
         [appDelegate.centerVC showAlertViewCustom:msg];
    }    
    else if(appDelegate.centerVC.dataArrayUpButtonsIds.count==2)
    {
        [appDelegate.centerVC showAlertViewCustom:@"Congrats, you now belong to multiple Timelines. Scroll through them by swiping left/right"];
    }
}


-(void)adminListUpdated:(id)sender
{
    
    loadStatus=0;
    [self hideNativeHudView];
    [self hideHudView];
    SingleRequest *sReq=(SingleRequest*)[sender object];
    if([sReq.notificationName isEqualToString:ADMININVITESTATUSBYPUSH])
    {
        if(sReq.responseData)
        {
            
            if (sReq.responseString)
            {
                
                NSString *strr=sReq.responseString;
                
                NSLog(@"%@",strr);
                
                SBJsonParser *parser=[[SBJsonParser alloc] init];
                
                id res = [parser objectWithString:sReq.responseString];
                if ([res isKindOfClass:[NSDictionary class]])
                {
                    NSDictionary* aDict = (NSDictionary*) res;
                    
                    
                    if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
                    {
                        
                        
                        Invite *newEvent=[self.fetchedResultsController objectAtIndexPath:self.lastSelIndexPathAdmin];
                        
                        
                        
                        newEvent.inviteStatus=[[NSNumber alloc] initWithInt:lastSelStatusAdmin ];
                        
                        
                        
                        [appDelegate saveContext];
                        
                        
                        if(lastSelStatusAdmin==1)
                        {
                        
                        [self loadFourSquareDataTeamPostDetails:sReq.responseString];
                        aDict=[aDict objectForKey:@"response"];
                        aDict=[aDict objectForKey:@"team_details"];
                        
                        NSMutableDictionary *micdic=[NSMutableDictionary dictionaryWithObjectsAndKeys:[aDict objectForKey:CREATORNAME],CREATORNAME,[aDict objectForKey:CREATORPHNO],CREATORPHNO,[aDict objectForKey:CREATOREMAIL],CREATOREMAIL,[aDict objectForKey:@"creator_id"],@"creator_id", nil];
                        
                        
                        NSString *teamSportN=@"";
                        
                        if(newEvent.teamSport)
                            teamSportN=newEvent.teamSport;
                        
                        [appDelegate.centerVC updateArrayByAddingOneTeam:[aDict objectForKey:@"team_name"] :[NSString stringWithFormat:@"%@", [aDict objectForKey:@"team_id"] ] :[self.requestDic objectForKey:@"coach2_status"] :[NSNumber numberWithInt:1] :[ NSString stringWithFormat:@"%@%@", TEAM_LOGO_URL,[aDict objectForKey:@"team_logo"] ]:[aDict objectForKey:@"status_update"] :appDelegate.arrItems:micdic:teamSportN];
                            
                            
                            NSDictionary *coachDic=nil;
                             NSString *invitesDic=nil;
                              NSNumber *isCreatedDic=nil;
                            int i=0;
                            
                            
                            for(NSString *str in appDelegate.centerVC.dataArrayUpButtonsIds)
                            {
                                if( [aDict objectForKey:@"team_id"] && [str isEqualToString: [aDict objectForKey:@"team_id"] ])
                                {
                                    
                                    coachDic=[appDelegate.centerVC.dataArrayUpCoachDetails objectAtIndex:i];
                                    
                                    invitesDic=[appDelegate.centerVC.dataArrayUpInvites objectAtIndex:i];
                                    
                                      isCreatedDic=[appDelegate.centerVC.dataArrayUpIsCreated objectAtIndex:i];
                                    break;
                                }
                                i++;
                            }
                            
                            
                            if(![coachDic objectForKey:SECONDARYUSERSENDERID])
                            {
                                NSMutableDictionary *mdic=[coachDic mutableCopy];
                                
                                [mdic setObject:invitesDic forKey:PLAYERINVITESTATUS];
                                 [mdic setObject:[aDict objectForKey:@"creator_id"] forKey:@"creator_id"];
                                
                                [appDelegate.centerVC.dataArrayUpCoachDetails replaceObjectAtIndex:i withObject:mdic];
                                
                                [appDelegate setUserDefaultValue:appDelegate.centerVC.dataArrayUpCoachDetails ForKey:ARRAYCOACHDETAILS];
                                
                                
                                
                                 [appDelegate.centerVC.dataArrayUpInvites replaceObjectAtIndex:i withObject:[self.requestDic objectForKey:@"coach2_status"]];
                                
                                 [appDelegate setUserDefaultValue:appDelegate.centerVC.dataArrayUpInvites ForKey:ARRAYSTATUS];
                                
                                [appDelegate.centerVC.dataArrayUpIsCreated replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:1]];
                                
                                
                                 [appDelegate setUserDefaultValue:appDelegate.centerVC.dataArrayUpIsCreated ForKey:ARRAYISCREATES];
                                
                            }
                            

                            
                        [appDelegate saveContext];
                        
                        
                            
                        ///////////////////////////////////
                        NSArray *eventDetails=[aDict objectForKey:@"event_details"];
                        
                        
                        
                     
                            [self.appDelegate addEventsAfterLogin:eventDetails:1:nil:nil:nil:0:1:0:1];
                        
                        
                        NSArray *playerDetails=[aDict objectForKey:@"player_details"];
                        
                            int flag=0;
                        if(playerDetails.count)
                        {
                            
                            for (int i=0; i<playerDetails.count; i++) {
                                NSDictionary *playerinfo=[[NSDictionary alloc] init];
                                playerinfo= [playerDetails objectAtIndex:i];
                                if ([[appDelegate.aDef objectForKey:EMAIL] isEqualToString:[playerinfo objectForKey:@"Email1"]]) {
                                    flag=1;
                                }
                                if ([[appDelegate.aDef objectForKey:EMAIL] isEqualToString:[playerinfo objectForKey:@"Email2"]]) {
                                    flag=1;
                                }
                                if ([[appDelegate.aDef objectForKey:EMAIL] isEqualToString:[playerinfo objectForKey:@"Email3"]]) {
                                    flag=1;
                                }
                                if (flag==1) {
                                    break;
                                }
                            }
                            
                            
                        }
                        
                            /*MainInviteVC* maininvitevc=  (MainInviteVC*) [appDelegate.navigationControllerTeamInvites.viewControllers objectAtIndex:0];
                            
                            
                            [maininvitevc showAlertViewCustom:[[NSString alloc] initWithFormat:@"Welcome to %@ timeline.\nManage this team as an admin",newEvent.teamName ]];*/
                            if (flag==0) {
                                if ([self.strInviteStatus isEqualToString:@"Accept"] || [self.strInviteStatus isEqualToString:@"Maybe"]) {
                                    [self goToTimeLine:[[NSString alloc] initWithFormat:@"Welcome to %@ timeline.\nSay something to your team by posting comments, pictures or videos.",newEvent.teamName ]];
                                }
                                else{
                                    [self goToTimeLine:[[NSString alloc] initWithFormat:@"Welcome to %@ timeline.\nYou have a limited time access. Please contact team admin to continue after that",newEvent.teamName ]];
                                }
                                
                                
                            }
                            
                        
                        }
                        
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






-(void)coachAdminResponse:(id)sender
{


    loadStatus=0;
    [self hideNativeHudView];
    //  [self hideHudView];
    SingleRequest *sReq=(SingleRequest*)[sender object];
    if([sReq.notificationName isEqualToString:COACHADMINRESPONSE])
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
                        @autoreleasepool {
                            
                            
                            Invite *newEvent=[self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:self.lastSelRowAdminResponse inSection:0  ]];
                            newEvent.viewStatus=[[NSNumber alloc] initWithBool:1 ];
                            
                            /////////////ADDDEB
                            [[NSNotificationCenter defaultCenter] postNotificationName:TAPADMINTEAMRESPONSENOTIFY object:newEvent.teamId];
                            
                            ///////////
                            
                        }
                        
                        [appDelegate saveContext];
                        
                        
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

-(void)coachTeamResponse:(id)sender
{
    
    loadStatus=0;
    [self hideNativeHudView];
    //  [self hideHudView];
    SingleRequest *sReq=(SingleRequest*)[sender object];
    if([sReq.notificationName isEqualToString:COACHTEAMRESPONSE])
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
                        @autoreleasepool {
                            
                            
                            Invite *newEvent=[self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:self.lastSelRowTeamResponse inSection:0  ]];
                              newEvent.viewStatus=[[NSNumber alloc] initWithBool:1 ];
                            
                            /////////////ADDDEB
                            [[NSNotificationCenter defaultCenter] postNotificationName:TAPPLAYERTEAMRESPONSENOTIFY object:newEvent.teamId];
                            
                            ///////////
                            
                        }
                        
                        [appDelegate saveContext];
                        
                        
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



-(void)userTeamResponse:(id)sender
{
    
    loadStatus=0;
    [self hideNativeHudView];
     [self hideHudView];
    SingleRequest *sReq=(SingleRequest*)[sender object];
    if([sReq.notificationName isEqualToString:USERTEAMRESPONSE])
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
                    NSLog(@"%@",aDict);
                    
                    if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
                    {
                        @autoreleasepool {
                            
                            
                            Invite *newEvent=[self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:self.lastSelRowUserTeamResponse inSection:0  ]];
                            newEvent.viewStatus=[[NSNumber alloc] initWithBool:1 ];
                            
                      
                        
                        
                        
                           [appDelegate saveContext];
                        
                  //////////////////////////
                        
                    //    MainInviteVC* maininvitevc=  (MainInviteVC*) [appDelegate.navigationControllerTeamInvites.viewControllers objectAtIndex:0];
                        //[maininvitevc view];
                        
                       // PushByInviteTeamVC *pVC=maininvitevc.teamInvitesVC;//[maininvitevc teamInvitesVC];
                        
                       // [pVC view];
                            
                            NSString *inviteStatusStr=nil;
                            if([newEvent.inviteStatus integerValue]==1)
                               inviteStatusStr=@"Accept";
                            else if([newEvent.inviteStatus integerValue]==2)
                                 inviteStatusStr=@"Decline";
                            else if([newEvent.inviteStatus integerValue]==3)
                                inviteStatusStr=@"Maybe";
                            
                        Invite *invite=(Invite*)  [self objectOfTypeTeamInvite:INVITE forTeam1:newEvent.teamId andManObjCon:self.managedObjectContext];
                            if((invite.inviteStatus.integerValue==0) && invite.inviteStatus)
                        [self teamInviteStatusUpdateFromPush:invite :inviteStatusStr];
                        
                        
                        
                        
                  ////////////////////////////
                        
                        
                        }
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



-(void)coachTeamEventResponse:(id)sender
{
    
    loadStatus=0;
    [self hideNativeHudView];
    //  [self hideHudView];
    SingleRequest *sReq=(SingleRequest*)[sender object];
    if([sReq.notificationName isEqualToString:COACHTEAMEVENTRESPONSE])
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
                        @autoreleasepool {
                            
                            
                            Invite *newEvent=[self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:self.lastSelRowTeamEventResponse inSection:0  ]];
                            newEvent.viewStatus=[[NSNumber alloc] initWithBool:1 ];
                            
                            /////////////ADDDEB
                            [[NSNotificationCenter defaultCenter] postNotificationName:TAPPLAYEREVENTRESPONSENOTIFY object:newEvent.eventId];
                            
                            ///////////
                        }
                        
                        [appDelegate saveContext];
                        
                        
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



-(void)userTeamEventResponse:(id)sender
{
    
    loadStatus=0;
    [self hideNativeHudView];
    [self hideHudView];
    SingleRequest *sReq=(SingleRequest*)[sender object];
    if([sReq.notificationName isEqualToString:USERTEAMEVENTRESPONSE])
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
                        @autoreleasepool {
                            
                            
                            Invite *newEvent=nil;
                            
                            if(self.userEventResponseRecord)
                                newEvent=self.userEventResponseRecord;
                            else
                             newEvent=[self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:self.lastSelRowUserTeamEventResponse inSection:0  ]];
                            newEvent.viewStatus=[[NSNumber alloc] initWithBool:1 ];
                            
                            
                            
                            
                            
                            [appDelegate saveContext];
                            
                            //////////////////////////
                            
                            //    MainInviteVC* maininvitevc=  (MainInviteVC*) [appDelegate.navigationControllerTeamInvites.viewControllers objectAtIndex:0];
                            //[maininvitevc view];
                            
                            // PushByInviteTeamVC *pVC=maininvitevc.teamInvitesVC;//[maininvitevc teamInvitesVC];
                            
                            // [pVC view];
                            
                           /* NSString *inviteStatusStr=nil;
                            if([newEvent.inviteStatus integerValue]==1)
                                inviteStatusStr=@"Accept";
                            else if([newEvent.inviteStatus integerValue]==2)
                                inviteStatusStr=@"Decline";
                            else if([newEvent.inviteStatus integerValue]==3)
                                inviteStatusStr=@"Maybe";
                            
                            Invite *invite=(Invite*)  [self objectOfTypeTeamInvite:INVITE forTeam1:newEvent.teamId andManObjCon:self.managedObjectContext];
                            if((invite.inviteStatus.integerValue==0) && invite.inviteStatus)
                                [self teamInviteStatusUpdateFromPush:invite :inviteStatusStr];*/
                            
                            
                           //                            else
                            {
                                Event *dataEvent=[self objectOfType2Event:newEvent.eventId];
                                if(dataEvent)//For Player or Primary
                                {
                                   
                                    
                                    if([dataEvent.isPublicAccept integerValue]==0 && newEvent.inviteStatus.integerValue!=0)
                                       [self deleteEventFromDeviceCalendar:dataEvent];
                                    
                                    dataEvent.isPublicAccept=newEvent.inviteStatus;
                                    [appDelegate saveContext];
                                    
                                }
                            }
                            
                            
                            
                            ////////////////////////////
                            NSPredicate *pre=[NSPredicate predicateWithFormat:@"type==%i AND eventId==%@",5,newEvent.eventId];
                            
                            Invite *event1=nil;
                            NSArray *ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:pre];
                            
                            if(ar.count>0)
                                event1=   [ar objectAtIndex:0];
                           
                            if(event1)
                                [self.managedObjectContext deleteObject:event1];
                            
                            [appDelegate saveContext];
                            
                        }
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
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


-(void)eventUpdateComplete:(id)sender
{
    [self hideHudView];
}

-(void)eventUpdateViewResponse:(id)sender
{
    
    loadStatus=0;
    [self hideNativeHudView];
    [self hideHudView];
    SingleRequest *sReq=(SingleRequest*)[sender object];
    if([sReq.notificationName isEqualToString:EVENTUPDATEVIEWSTATUS])
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
                        Invite *newEvent=nil;
                        @autoreleasepool {
                            
                            
                           newEvent=[self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:self.lastSelRowEventUpdate inSection:0  ]];
                            
                            
                        }
                        
                       
  //////////////////////////////////////////////////////////////
                        
                        if(!(newEvent.playerId && newEvent.playerName && newEvent.playerUserId))
                        {
                        NSString *eId=newEvent.eventId;
                        
                        Event *dataEvent=[self objectOfType2Event:eId];
                        
                        if(dataEvent)
                        {
                            
                            if(dataEvent.isCreated.boolValue==NO)
                            {
                               
                                
                                EventCalendarViewController *evc=(EventCalendarViewController*)[appDelegate.navigationControllerCalendar.viewControllers objectAtIndex:0];
                                
                                evc.evUnreadeventUpdate=newEvent;
                                [self showHudView:@"Connecting..."];
                                [evc processEditEvent:eId:1];
                            }
                            
                        }
                        
/////////////////////////////
                        }
                        else
                        {
                           
                             NSPredicate *pre=[NSPredicate predicateWithFormat:@"type==%i AND eventId==%@",5,newEvent.eventId];
                            
                            
                            Invite *event=nil;
                            NSArray *ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:pre];
                            
                            if(ar.count>0)
                                event=   [ar objectAtIndex:0];
                            
                           
                            
                            
                            
                            EventDetailsViewController *eVC=[[EventDetailsViewController alloc] initWithNibName:@"EventDetailsViewController" bundle:nil];
                            eVC.isFromPushBadge=1;
                            eVC.eventId=event.eventId;
                            eVC.isFromPush=1;
                            eVC.playername=event.playerName;
                            eVC.playerid=event.playerId;
                            eVC.playeruserid=event.playerUserId;
                            
                            eVC.evUnreadevent=event;
                            eVC.evUnreadeventUpdate=newEvent;
                            [appDelegate.navigationControllerTeamInvites pushViewController:eVC animated:YES ];

                        }

                  
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
 ///////////////////////////////////////////////////////////////
                        
                        
                      
                        
                        
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



-(void)eventDeleteViewResponse:(id)sender
{
    
    loadStatus=0;
    [self hideNativeHudView];
  //  [self hideHudView];
    SingleRequest *sReq=(SingleRequest*)[sender object];
    if([sReq.notificationName isEqualToString:EVENTDELETEVIEWSTATUS])
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
                        
                        NSString *eId=nil;
                    
                            
                        
                        Invite *newEvent=[self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:self.lastSelRowEventDelete inSection:0  ]];
                        
                            eId=newEvent.eventId;
                          
                            
                      
                        
                        
                    ///////////////////////
                          Invite *event=nil;
                          Invite *event1=nil;
                        if(!(newEvent.inviteStatus))
                        {
                            
                            
                            
                            Event *dataEvent=[self objectOfType2Event:eId];
                            
                            if(dataEvent)
                            {
                                [self deleteObjectOfTypeEvent:dataEvent];
                                
                                EKEvent *newEvent=nil;
                                
                                
                                newEvent= [appDelegate.eventStore eventWithIdentifier:dataEvent.eventIdentifier];
                                
                                NSError *error=nil;
                                BOOL save=  [appDelegate.eventStore removeEvent:newEvent span:EKSpanFutureEvents commit:YES error:&error ];
                                NSLog(@"DeleteEventStatus=%i \n%@",save,error.description);
                                
                                if(save || dataEvent.isPublicAccept.intValue)
                                {
                                    
                                    
                                    
                                    /*[self showNetworkError:[NSString stringWithFormat:@"%@ Event Deleted for the team %@ on %@",eName,eTeam,eDate]];
                                     
                                     EventCalendarViewController *eCal=(EventCalendarViewController*)[self.navigationControllerCalendar.viewControllers objectAtIndex:0];
                                     
                                     [self.navigationControllerCalendar popViewControllerAnimated:NO];
                                     [eCal.calvc.monthView reloadData];
                                     [eCal.calvc.monthView selectDate:[NSDate date]];*/
                                }
                            }
                        }
                        else
                        {
                            
                            NSPredicate *pre=[NSPredicate predicateWithFormat:@"type==%i AND eventId==%@",5,newEvent.eventId];
                            
                            
                          
                            NSArray *ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:pre];
                            
                            if(ar.count>0)
                                event=   [ar objectAtIndex:0];
                        }
                        /*else
                        {*/
                            NSPredicate *pre=[NSPredicate predicateWithFormat:@"type==%i AND eventId==%@",8,newEvent.eventId];
                            
                        
                            NSArray *ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:pre];
                            
                            if(ar.count>0)
                                event1=   [ar objectAtIndex:0];
                        
                            
                        Invite *event2=nil;
                        Invite *event3=nil;
                        pre=[NSPredicate predicateWithFormat:@"type==%i AND eventId==%@",11,newEvent.eventId];
                        
                        
                        ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:pre];
                        
                        if(ar.count>0)
                            event2=   [ar objectAtIndex:0];
                        
                        
                        pre=[NSPredicate predicateWithFormat:@"type==%i AND eventId==%@",12,newEvent.eventId];
                        
                        
                        ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:pre];
                        
                        if(ar.count>0)
                            event3=   [ar objectAtIndex:0];
                        

                        /*}*/
                        
                        
                        
                 //////////////////////
                   

                        
                        @autoreleasepool {
                            
                            
                            if(event)
                            [self.managedObjectContext deleteObject:event];
                            if(event1)
                                [self.managedObjectContext deleteObject:event1];
                            
                            if(event2)
                                [self.managedObjectContext deleteObject:event2];
                            if(event3)
                                [self.managedObjectContext deleteObject:event3];
                            
                            
                            if(newEvent)
                          [self.managedObjectContext deleteObject:newEvent ];
                        
                        }
                         [appDelegate saveContext];
                        
                      
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
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







-(void)teamInviteStatusUpdateFromPush:(Invite*)newinvite :(NSString*)str
{
    /*if(loadStatus)
        return;
    
    
    self.loadStatus=1;*/
    
    
    
NSMutableDictionary *command = [[NSMutableDictionary alloc] init];
if(newinvite.userId)
[command setObject:newinvite.userId forKey:@"UserID"];
else
[command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];

[command setObject:@"" forKey:@"invites"];
[command setObject:newinvite.teamId forKey:@"team_id"];
[command setObject:@"0" forKey:@"start"];
[command setObject:DEFAULTLIMIT forKey:@"limit"];
[command setObject:@"1" forKey:@"view"];
    [command setObject:@"" forKey:@"Primary_UserID"];
SBJsonWriter *writer = [[SBJsonWriter alloc] init];


NSString *jsonCommand = [writer stringWithObject:command];


    [self showHudView:@"Connecting..."];
[self showNativeHudView];
NSLog(@"RequestParamJSON=%@",jsonCommand);



//self.requestDic=command;

SingleRequest *sinReq=nil;
sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:TEAMINVITESTATUSLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
//self.sinReq3=sinReq;
    
    sinReq.userInfo=[[NSDictionary alloc] initWithObjectsAndKeys:newinvite,INVITECOREDATAOBJECT,str,INVITESTATUSONTEAMRESPONSE, nil];
[self.storeCreatedRequests addObject:sinReq];
sinReq.notificationName=TEAMINVITESTATUSBYPUSHONTEAMINVITERESPONSE;
//[self showHudView:@"Connecting..."];
[sinReq startRequest];
}


-(void)userListUpdatedONTEAMINVITERESPONSE:(id)sender
{
    [self hideNativeHudView];
    [self hideHudView];
    SingleRequest *sReq=(SingleRequest*)[sender object];
    if([sReq.notificationName isEqualToString:TEAMINVITESTATUSBYPUSHONTEAMINVITERESPONSE])
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
                        [self loadFourSquareDataTeamPostDetails:sReq.responseString];
                        
                        Invite *newEvent=[sReq.userInfo objectForKey:INVITECOREDATAOBJECT];
                        
                        NSString *responseStatus= [sReq.userInfo objectForKey:INVITESTATUSONTEAMRESPONSE];
                        
                        
                        if([responseStatus isEqualToString:@"Accept"])
                        newEvent.inviteStatus=[[NSNumber alloc] initWithInt:1 ];
                        else if([responseStatus isEqualToString:@"Decline"])
                        newEvent.inviteStatus=[[NSNumber alloc] initWithInt:2 ];
                        else if([responseStatus isEqualToString:@"Maybe"])
                            newEvent.inviteStatus=[[NSNumber alloc] initWithInt:3 ];
                        
                        [appDelegate saveContext];
                        
                        
                        aDict=[aDict objectForKey:@"response"];
                        aDict=[aDict objectForKey:@"team_details"];
                        
                        NSMutableDictionary *micdic=[NSMutableDictionary dictionaryWithObjectsAndKeys:[aDict objectForKey:CREATORNAME],CREATORNAME,[aDict objectForKey:CREATORPHNO],CREATORPHNO,[aDict objectForKey:CREATOREMAIL],CREATOREMAIL, nil];
                           NSString *teamSportN=@"";
                        
                        if([aDict objectForKey:@"team_sport"])
                       teamSportN= [aDict objectForKey:@"team_sport"];
                        
                        
                        
                        [appDelegate.centerVC updateArrayByAddingOneTeam:[aDict objectForKey:@"team_name"] :[NSString stringWithFormat:@"%@", [aDict objectForKey:@"team_id"] ] :responseStatus :[NSNumber numberWithInt:0] :[ NSString stringWithFormat:@"%@%@", TEAM_LOGO_URL,[aDict objectForKey:@"team_logo"] ]:[aDict objectForKey:@"status_update"] :appDelegate.arrItems:micdic:teamSportN];
                        
                        NSDictionary *coachDic=nil;
                        int i=0;
                        
                        
                        for(NSString *str in appDelegate.centerVC.dataArrayUpButtonsIds)
                        {
                            if( [aDict objectForKey:@"team_id"] && [str isEqualToString: [aDict objectForKey:@"team_id"] ])
                            {
                                
                                coachDic=[appDelegate.centerVC.dataArrayUpCoachDetails objectAtIndex:i];
                                break;
                            }
                            i++;
                        }
                        
                        
                        if([coachDic objectForKey:@"creator_id"])
                        {
                            NSMutableDictionary *mdic=[coachDic mutableCopy];
                            
                            [mdic setObject:[self.requestDic objectForKey:@"invites"] forKey:PLAYERINVITESTATUS];
                            
                            [appDelegate.centerVC.dataArrayUpCoachDetails replaceObjectAtIndex:i withObject:mdic];
                            
                            [appDelegate setUserDefaultValue:appDelegate.centerVC.dataArrayUpCoachDetails ForKey:ARRAYCOACHDETAILS];
                        }
                        

                        
                        
                       
                        
                        
                        [appDelegate saveContext];
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        ///////////////////////////////////
                        NSArray *eventDetails=[aDict objectForKey:@"event_details"];
                        NSArray *playerDetails=[aDict objectForKey:@"player_details"];
                        
                        NSDictionary *playerinfo=nil;
                        if(playerDetails.count)
                        {
                            playerinfo= [playerDetails objectAtIndex:0];
                            
                            
                            if((newEvent.inviteStatus.intValue==1 )|| (newEvent.inviteStatus.intValue==3))
                            {
                                if(newEvent.inviteStatus.intValue==3)
                                    [self.appDelegate addEventsAfterLogin:eventDetails:0:[playerinfo objectForKey:@"player_name"]:[playerinfo objectForKey:@"player_id"]:newEvent.userId:1:0:1:0];
                                else
                                    [self.appDelegate addEventsAfterLogin:eventDetails:0:[playerinfo objectForKey:@"player_name"]:[playerinfo objectForKey:@"player_id"]:newEvent.userId:0:0:1:0];
                            }
                            
                        }
                        
                                               
                        [appDelegate.centerViewController topbarbtapped:appDelegate.centerViewController.timelinesbt];
                        
                        
                        
                        
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









-(void)userListUpdatedForCommantStatus:(id)sender
{
    
    loadStatus=0;
    [self hideNativeHudView];
    [self hideHudView];
    SingleRequest *sReq=(SingleRequest*)[sender object];
    if([sReq.notificationName isEqualToString:UPDATELIKECOMMENTSTATUSVIEW])
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
                        
                        
                        
                        Invite *newEvent=(Invite*)sReq.userInfo;
                        newEvent.inviteStatus=[[NSNumber alloc] initWithInteger:1] ;
                        
                       /* if(appDelegate.allHistoryLikesCounts>0)
                        {
                            appDelegate.allHistoryLikesCounts--;
                            [appDelegate setUserDefaultValue:[NSNumber numberWithLongLong:appDelegate.allHistoryLikesCounts] ForKey:ALLHISTORYLIKECOUNTS ];
                        
                        }
                        [self reloadTableView];*/
                        
                        [appDelegate saveContext];
                        
                        /*if(newEvent.isComment.boolValue)
                        {*/
                            [self goToComment:newEvent];
                        /*}
                        else
                        {
                            
                            
                            PostLikeViewController *commentView=[[PostLikeViewController alloc] initWithNibName:@"PostLikeViewController" bundle:nil];
                            
                            self.postLikeVC=commentView;
                            commentView.postId=newEvent.data1;
                            
                            [appDelegate.navigationControllerTeamInvites pushViewController:commentView animated:YES];
                            
                            commentView=nil;
                        }*/
                        
                        
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


-(void)userListUpdatedForComment:(id)sender
{
    
    loadStatus=0;
    [self hideNativeHudView];
    [self hideHudView];
    SingleRequest *sReq=(SingleRequest*)[sender object];
    if([sReq.notificationName isEqualToString:INDIVIDUALPOST])
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
                    
                    NSLog(@"IndividualpostresponseStringData=%@",sReq.responseString);
                    if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
                    {
                        
                        aDict=[aDict objectForKey:@"response"];
                        
                        if(((NSArray*)[aDict objectForKey:@"post_details"]).count>0)
                        {
                            aDict=[[aDict objectForKey:@"post_details"] objectAtIndex:0];
                            
                            
                            
                            
                            
                            
                            
                            CommentVC *commentView=[[CommentVC alloc] initWithNibName:@"CommentVC" bundle:nil];
                            self.commVC=commentView;
                            commentView.isFromHome=1;
                            commentView.hvcData=[self getPostData:aDict];
                            [appDelegate.navigationControllerTeamInvites pushViewController:commentView animated:YES];
                        }
                        
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



-(HomeVCTableData*)getPostData:(NSDictionary*)diction
{
    
    HomeVCTableData *dvca=[[HomeVCTableData alloc] init];
    ImageInfo *imauser=nil;
    ImageInfo *imaposted=nil;
    ImageInfo *imapostedsecondary=nil;
    NSString *likecountstr=nil;
    NSString *commentcountstr=nil;
    NSString *comnt=nil;
    
    BOOL existuserima=0;
    BOOL existpostedima=0;
    BOOL existpostedimasecondary=0;
    
    
    
    if(![[diction objectForKey:@"ProfileImage"] isEqualToString:@""])
    {
        imauser= [[ImageInfo alloc] initWithSourceURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGELINKTHUMB,[diction objectForKey:@"ProfileImage"]]]];
        existuserima=1;
    }
    dvca.imageWidth=0.0;
    dvca.imageHeight=0.0;
    dvca.videoUrlStr=nil;
    if(![[diction objectForKey:@"image"] isEqualToString:@""])
    {
        imaposted= [[ImageInfo alloc] initWithSourceURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",POSTIMAGELINK,[diction objectForKey:@"image"]]]];
        existpostedima=1;
        
        
        /*if([[diction objectForKey:@"image_width"] isKindOfClass:[NSDecimalNumber class]])
         {*/
        dvca.imageWidth=[[diction objectForKey:@"image_width"] floatValue] ;
        dvca.imageHeight=[[diction objectForKey:@"image_height"] floatValue] ;
        /*}
         else  if([[diction objectForKey:@"image_width"] isKindOfClass:[NSString class]])
         {
         if(![[diction objectForKey:@"image_width"] isEqualToString:@""])
         {
         dvca.imageWidth=[[diction objectForKey:@"image_width"] floatValue] ;
         dvca.imageHeight=[[diction objectForKey:@"image_height"] floatValue] ;
         }
         
         }*/
    }
    else  if(![[diction objectForKey:@"video_thumb"] isEqualToString:@""])
    {
        NSString *stringToSearch=@"http";
        NSString *myString= [diction objectForKey:@"video"];
        
        if ([myString rangeOfString:stringToSearch].location != NSNotFound)
        {
            // stringToSearch is present in myString
            dvca.videoUrlStr=[diction objectForKey:@"video"] ;
            
            
        }
        else
        {
            
            dvca.videoUrlStr=[NSString stringWithFormat:@"%@%@",VIDEOLINK , [diction objectForKey:@"video"] ];
        }
        
        
        
        imaposted=[[ImageInfo alloc] initWithSourceURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",POSTVIDEOIMAGELINK,[diction objectForKey:@"video_thumb"]]]];
        existpostedima=1;
        
        
        /* if([[diction objectForKey:@"video_thumb_width"] isMemberOfClass:[NSDecimalNumber class]])
         {*/
        dvca.imageWidth=[[diction objectForKey:@"video_thumb_width"] floatValue] ;
        dvca.imageHeight=[[diction objectForKey:@"video_thumb_height"] floatValue] ;
        
        
        
        /*}
         else  if([[diction objectForKey:@"video_thumb_width"] isMemberOfClass:[NSString class]])
         {
         if(![[diction objectForKey:@"video_thumb_width"] isEqualToString:@""])
         {
         dvca.imageWidth=[[diction objectForKey:@"video_thumb_width"] floatValue] ;
         dvca.imageHeight=[[diction objectForKey:@"video_thumb_height"] floatValue] ;
         }
         
         }*/
        
    }
    
    //imapostedsecondary= [[ImageInfo alloc] initWithSourceURL:[NSURL URLWithString:@""]];
    existpostedimasecondary=0;
    
    
    comnt=[diction objectForKey:@"comment_text"];
    
    commentcountstr=[NSString stringWithFormat:@"%@",[diction objectForKey:@"number_of_comment"]];//()
    
    NSString *s=[[NSString alloc] initWithFormat:@"%@",[diction objectForKey:@"number_of_likes"] ];
    likecountstr=s;
    
    if([[diction objectForKey:@"Islike"] isEqualToString:@"Y"])
        dvca.isLike=1;
    else
        dvca.isLike=0;
    
    dvca.post_id=[diction objectForKey:@"post_id"];
    dvca.number_of_likes=[likecountstr intValue];
    NSMutableArray *marray=[[diction objectForKey:@"comment_user_details"] mutableCopy];
    dvca.commentdetailsarr=marray;
    
    dvca.number_of_comment=dvca.commentdetailsarr.count;
    dvca.adddate=[diction objectForKey:@"adddate"];
    
    
    /*marray=[[diction objectForKey:@"like_user_details"] mutableCopy];
     dvca.likedetailsarr=marray;
     [marray release];*/
    
    dvca.userId=[diction objectForKey:@"user_id"];
    dvca.playerfname=[diction objectForKey:@"FirstName"];
    dvca.playerlname=[diction objectForKey:@"LastName"];
    
    
    NSDictionary *diction1=[diction objectForKey:@"playerdetails"];
    
    @autoreleasepool
    {
        dvca.isPlayer=[[diction1 objectForKey:@"IsPlayer"] boolValue];
        dvca.isPrimary=[[diction1 objectForKey:@"Is_Primary"] boolValue];
        dvca.isCoach=[[diction1 objectForKey:@"Is_Coach"] boolValue];
        
        if(!dvca.isCoach)
        {
            NSString *playerNameArray=[[[[[NSString stringWithFormat:@"%@",[diction1 objectForKey:@"player_name"]] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            
            playerNameArray=[playerNameArray stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            
            NSString *playerIdArray=[[[[[NSString stringWithFormat:@"%@",[diction1 objectForKey:@"player_id"]] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            playerIdArray=[playerIdArray stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            
            dvca.playerNameTeam=playerNameArray;
            dvca.playerIdTeam=playerIdArray;
        }
        
        if(dvca.isPrimary)
        {
            NSString *playerNameArray=[[[[[NSString stringWithFormat:@"%@",[diction1 objectForKey:@"Primary_User_Name"]] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            playerNameArray=[playerNameArray stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            NSString *playerIdArray=[[[[[NSString stringWithFormat:@"%@",[diction1 objectForKey:@"Relation"]] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            playerIdArray=[playerIdArray stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            
            dvca.primaryUserName=playerNameArray;
            dvca.primaryRelation=playerIdArray;
        }
        
        
        
        if((dvca.isPlayer==0) && (dvca.isPrimary==0) && (dvca.isCoach==0))
        {
            if([diction1 objectForKey:@"secondary_sender_name"])
                dvca.playerNameTeam=[diction1 objectForKey:@"secondary_sender_name"];
            
        }
        
        
        
        
        
        
        
        
    }
    
    
    dvca.secondaryImageInfo=imapostedsecondary;
    dvca.postedImageInfo=imaposted;
    dvca.userImageInfo=imauser;
    dvca.likecountlab=likecountstr;
    dvca.commentstr= comnt;
    dvca.commentcountlab=commentcountstr;
    dvca.isExistUserImageInfo=existuserima;
    dvca.isExistPostedImageInfo=existpostedima;
    dvca.isExistSecondaryImageInfo=existpostedimasecondary;
    
    
    
    return dvca;
    
}




-(void)goToComment:(Invite*)ldata
{
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    
    
    [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
    [command setObject:ldata.data1 forKey:@"post_id"];
    
    
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    
    SingleRequest *sinReq=[[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:INDIVIDUALPOSTLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
    self.sinReq3=sinReq;
    
    [self.storeCreatedRequests addObject:self.sinReq3];
    sinReq.notificationName=INDIVIDUALPOST;
    sinReq.userInfo=ldata;
    
    [self showHudView:@"Connecting..."];
    [sinReq startRequest];
    
    
}






-(void)userListUpdatedCoachUpdate:(id)sender
{
    
    loadStatus=0;
    [self hideNativeHudView];
    SingleRequest *sReq=(SingleRequest*)[sender object];
    if([sReq.notificationName isEqualToString:COACHUPDATEVIEWSTATUS])
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
                        
                        
                        
                        Invite *newEvent=[self.fetchedResultsController.fetchedObjects objectAtIndex:self.lastSelRowCoach];
                        newEvent.inviteStatus=[[NSNumber alloc] initWithInt:1 ];
                        
                        [appDelegate saveContext];
                        
                        
                        
                        
                        
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




-(void)loadFourSquareDataTeamPostDetails:(NSString*)responses
{
    
    ///////Added by Debattam
    /*self.dataArray=[[NSMutableArray alloc] init];
     [dataArray release];*/
    appDelegate.arrItems=nil;
    
    
    NSString *str=responses;
    
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
                
                
                aDict=[aDict objectForKey:@"response"];
                aDict=[aDict objectForKey:@"team_details"];
                NSArray   *array=[aDict objectForKey:@"post_details"];
                
                NSMutableArray *marrat=[[NSMutableArray alloc] init];
                appDelegate.arrItems=marrat;
                
                
                
                
                for(NSDictionary *diction in array)
                {
                    HomeVCTableData *dvca=[[HomeVCTableData alloc] init];
                    ImageInfo *imauser=nil;
                    ImageInfo *imaposted=nil;
                    ImageInfo *imapostedsecondary=nil;
                    NSString *likecountstr=nil;
                    NSString *commentcountstr=nil;
                    NSString *comnt=nil;
                    
                    BOOL existuserima=0;
                    BOOL existpostedima=0;
                    BOOL existpostedimasecondary=0;
                    
                    
                    
                    if(![[diction objectForKey:@"ProfileImage"] isEqualToString:@""])
                    {
                        imauser= [[ImageInfo alloc] initWithSourceURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGELINKTHUMB,[diction objectForKey:@"ProfileImage"]]]];
                        existuserima=1;
                    }
                    dvca.imageWidth=0.0;
                    dvca.imageHeight=0.0;
                    if(![[diction objectForKey:@"image"] isEqualToString:@""])
                    {
                        imaposted= [[ImageInfo alloc] initWithSourceURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",POSTIMAGELINK,[diction objectForKey:@"image"]]]];
                        existpostedima=1;
                        
                        
                        /* if([[diction objectForKey:@"image_width"] isMemberOfClass:[NSDecimalNumber class]])
                         {*/
                        dvca.imageWidth=[[diction objectForKey:@"image_width"] floatValue] ;
                        dvca.imageHeight=[[diction objectForKey:@"image_height"] floatValue] ;
                        /*}
                         else  if([[diction objectForKey:@"image_width"] isMemberOfClass:[NSString class]])
                         {
                         if(![[diction objectForKey:@"image_width"] isEqualToString:@""])
                         {
                         dvca.imageWidth=[[diction objectForKey:@"image_width"] floatValue] ;
                         dvca.imageHeight=[[diction objectForKey:@"image_height"] floatValue] ;
                         }
                         
                         }*/
                        
                    }
                    else  if(![[diction objectForKey:@"video_thumb"] isEqualToString:@""])
                    {
                        imaposted=[[ImageInfo alloc] initWithSourceURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",POSTVIDEOIMAGELINK,[diction objectForKey:@"video_thumb"]]]];
                        existpostedima=1;
                        
                        
                        /*if([[diction objectForKey:@"video_thumb_width"] isMemberOfClass:[NSDecimalNumber class]])
                         {*/
                        dvca.imageWidth=[[diction objectForKey:@"video_thumb_width"] floatValue] ;
                        dvca.imageHeight=[[diction objectForKey:@"video_thumb_height"] floatValue] ;
                        /*}
                         else  if([[diction objectForKey:@"video_thumb_width"] isMemberOfClass:[NSString class]])
                         {
                         if(![[diction objectForKey:@"video_thumb_width"] isEqualToString:@""])
                         {
                         dvca.imageWidth=[[diction objectForKey:@"video_thumb_width"] floatValue] ;
                         dvca.imageHeight=[[diction objectForKey:@"video_thumb_height"] floatValue] ;
                         }
                         
                         }*/
                        
                    }
                    
                    //imapostedsecondary= [[ImageInfo alloc] initWithSourceURL:[NSURL URLWithString:@""]];
                    existpostedimasecondary=0;
                    
                    
                    comnt=[diction objectForKey:@"comment_text"];
                    
                    commentcountstr=[NSString stringWithFormat:@"%@",[diction objectForKey:@"number_of_comment"]];//ch
                    
                    NSString *s=[[NSString alloc] initWithFormat:@"%@",[diction objectForKey:@"number_of_likes"] ];
                    likecountstr=s;
                    
                    if([[diction objectForKey:@"Islike"] isEqualToString:@"Y"])
                        dvca.isLike=1;
                    else
                        dvca.isLike=0;
                    dvca.post_id=[diction objectForKey:@"post_id"];
                    dvca.number_of_likes=[likecountstr intValue];
                    NSMutableArray *marray=[[diction objectForKey:@"comment_user_details"] mutableCopy];
                    dvca.commentdetailsarr=marray;
                    
                    dvca.number_of_comment=dvca.commentdetailsarr.count;
                    dvca.adddate=[diction objectForKey:@"adddate"];
                    
                    /*marray=[[diction objectForKey:@"like_user_details"] mutableCopy];
                     dvca.likedetailsarr=marray;
                     [marray release];*/
                    
                    dvca.userId=[diction objectForKey:@"user_id"];
                    dvca.playerfname=[diction objectForKey:@"FirstName"];
                    dvca.playerlname=[diction objectForKey:@"LastName"];
                    
                    NSDictionary *diction1=[diction objectForKey:@"playerdetails"];
                    @autoreleasepool
                    {
                        dvca.isPlayer=[[diction1 objectForKey:@"IsPlayer"] boolValue];
                        dvca.isPrimary=[[diction1 objectForKey:@"Is_Primary"] boolValue];
                        dvca.isCoach=[[diction1 objectForKey:@"Is_Coach"] boolValue];
                        
                        if(!dvca.isCoach)
                        {
                            NSString *playerNameArray=[[[[NSString stringWithFormat:@"%@",[diction1 objectForKey:@"player_name"]] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
                            
                            playerNameArray=[playerNameArray stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                            
                            
                            NSString *playerIdArray=[[[[NSString stringWithFormat:@"%@",[diction1 objectForKey:@"player_id"]] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
                            
                            playerIdArray=[playerIdArray stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                            
                            dvca.playerNameTeam=playerNameArray;
                            dvca.playerIdTeam=playerIdArray;
                        }
                        
                        if(dvca.isPrimary)
                        {
                            NSString *playerNameArray=[[[[NSString stringWithFormat:@"%@",[diction1 objectForKey:@"Primary_User_Name"]] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
                            
                            playerNameArray=[playerNameArray stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                            
                            
                            NSString *playerIdArray=[[[[NSString stringWithFormat:@"%@",[diction1 objectForKey:@"Relation"]] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
                            
                            playerIdArray=[playerIdArray stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                            dvca.primaryUserName=playerNameArray;
                            dvca.primaryRelation=playerIdArray;
                        }
                        
                        
                        if((dvca.isPlayer==0) && (dvca.isPrimary==0) && (dvca.isCoach==0))
                        {
                            if([diction1 objectForKey:@"secondary_sender_name"])
                                dvca.playerNameTeam=[diction1 objectForKey:@"secondary_sender_name"];
                            
                        }
                        
                    }
                    

                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    dvca.secondaryImageInfo=imapostedsecondary;
                    dvca.postedImageInfo=imaposted;
                    dvca.userImageInfo=imauser;
                    dvca.likecountlab=likecountstr;
                    dvca.commentstr= comnt;
                    dvca.commentcountlab=commentcountstr;
                    dvca.isExistUserImageInfo=existuserima;
                    dvca.isExistPostedImageInfo=existpostedima;
                    dvca.isExistSecondaryImageInfo=existpostedimasecondary;
                    [appDelegate.arrItems addObject:dvca];
                }
                
                
                
            }
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
    Invite *newInvite= [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    if(newInvite.type.intValue==0)
    {
    if( newInvite.inviteStatus.intValue==0)
    {
        
    
   /* InviteDetailsViewController *eVC=[[InviteDetailsViewController alloc] initWithNibName:@"InviteDetailsViewController" bundle:nil];
    
        self.detViewController=eVC;
   
    eVC.newinvite=newInvite;
    
    
        
        [appDelegate.navigationControllerTeamInvites pushViewController:self.detViewController animated:YES];
        eVC=nil;*/
    }
    
    
    
    
    }
    else if(newInvite.type.intValue==3)
    {
    
    if(loadStatus)
        return;
    
    
    
    
    
    Invite *newinvite=[self.fetchedResultsController objectAtIndexPath:indexPath];
    
    if(newinvite.inviteStatus.intValue==0)
    {
        self.lastSelRowCoach=indexPath.row;
        self.loadStatus=1;
        NSMutableDictionary *command = [NSMutableDictionary dictionary];
        [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"user_id"];
        [command setObject:newinvite.postId forKey:@"update_id"];
        [command setObject:@"1" forKey:@"status"];
        SBJsonWriter *writer = [[SBJsonWriter alloc] init];
        
        
        NSString *jsonCommand = [writer stringWithObject:command];
        
        
        
        [self showNativeHudView];
        NSLog(@"RequestParamJSON=%@",jsonCommand);
        
        
        
        self.requestDic=command;
        
        
        
        SingleRequest *sinReq=nil;
        sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:COACHUPDATEVIEWSTATUSLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
        self.sinReq1=sinReq;
        [self.storeCreatedRequests addObject:self.sinReq1];
        sinReq.notificationName=COACHUPDATEVIEWSTATUS;
        
        [sinReq startRequest];
    }
    }
    else if(newInvite.type.intValue==5)
    {
       Invite *event=newInvite;
        
        
        
        
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"type==%i AND eventId==%@",8,event.eventId];
        
        Invite *event1=nil;
        NSArray *ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:pre];
        
        if(ar.count>0)
            event1=   [ar objectAtIndex:0];
        // [self.centerViewController showNavController:self.navigationControllerCalendar];
         Invite *event2=nil;
        pre=[NSPredicate predicateWithFormat:@"type==%i AND eventId==%@",9,event.eventId];
        
        
        ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:pre];
        
      /*  BOOL flag=0;
        
        int i=0;
        
        for(NSString *str in appDelegate.centerVC.dataArrayUpButtonsIds)
        {
            if([str isEqualToString: event.teamId ])
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
        */
        
        
        if(ar.count>0)
            event2=   [ar objectAtIndex:0];
        
        if(event2)
        {
             NSIndexPath *newinvitepath=[self.fetchedResultsController indexPathForObject:event2];
            
            /*if(newinvite.viewStatus.boolValue==0)
             {*/
            self.lastSelRowEventDelete=newinvitepath.row;
            self.loadStatus=1;
            NSMutableDictionary *command = [NSMutableDictionary dictionary];
            [command setObject:newInvite.eventId forKey:@"event_id"];
            [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
            [command setObject:@"D" forKey:@"Type"];
            SBJsonWriter *writer = [[SBJsonWriter alloc] init];
            
            
            NSString *jsonCommand = [writer stringWithObject:command];
            
            
            
            [self showNativeHudView];
            NSLog(@"RequestParamJSON=%@",jsonCommand);
            
            
            
            self.requestDic=command;
            
            
            
            SingleRequest *sinReq=nil;
            sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:EVENTDELETEVIEWSTATUSLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
            self.sinReq1=sinReq;
            [self.storeCreatedRequests addObject:self.sinReq1];
            sinReq.notificationName=EVENTDELETEVIEWSTATUS;
            
            [sinReq startRequest];

        }
        
        else if(event1)
        {
            
            event1.playerId= newInvite.playerId;
            event1.playerName= newInvite.playerName;
            event1.playerUserId= newInvite.userId;
            [appDelegate saveContext];
            NSIndexPath *newinvitepath=[self.fetchedResultsController indexPathForObject:event1];
            
            /*if(newinvite.viewStatus.boolValue==0)
             {*/
            self.lastSelRowEventUpdate=newinvitepath.row;
            self.loadStatus=1;
            NSMutableDictionary *command = [NSMutableDictionary dictionary];
            [command setObject:newInvite.eventId forKey:@"event_id"];
            [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
            [command setObject:@"U" forKey:@"Type"];
            SBJsonWriter *writer = [[SBJsonWriter alloc] init];
            
            
            NSString *jsonCommand = [writer stringWithObject:command];
            
            
            [self showHudView:@"Connecting..."];
            [self showNativeHudView];
            NSLog(@"RequestParamJSON=%@",jsonCommand);
            
            
            
            self.requestDic=command;
            
            
            
            SingleRequest *sinReq=nil;
            sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:EVENTUPDATEVIEWSTATUSLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
            self.sinReq1=sinReq;
            [self.storeCreatedRequests addObject:self.sinReq1];
            sinReq.notificationName=EVENTUPDATEVIEWSTATUS;
            
            [sinReq startRequest];
        }
        else
        {
            EventDetailsViewController *eVC=[[EventDetailsViewController alloc] initWithNibName:@"EventDetailsViewController" bundle:nil];
            eVC.isFromPushBadge=1;
            eVC.eventId=event.eventId;
            eVC.isFromPush=1;
            eVC.playername=event.playerName;
            eVC.playerid=event.playerId;
            eVC.playeruserid=event.playerUserId;
            
            eVC.evUnreadevent=event;
            eVC.evUnreadeventUpdate=event1;
            [appDelegate.navigationControllerTeamInvites pushViewController:eVC animated:YES ];
        }
    }
    else if(newInvite.type.intValue==7)
    {
        
        if(loadStatus)
            return;
        
        
        
        
        
        Invite *newinvite=[self.fetchedResultsController objectAtIndexPath:indexPath];
        
        if(newinvite.viewStatus.boolValue==0)
        {
            self.lastSelRowTeamResponse=indexPath.row;
            self.loadStatus=1;
            NSMutableDictionary *command = [NSMutableDictionary dictionary];
            [command setObject:newInvite.playerId forKey:@"player_id"];
             [command setObject:@"coach" forKey:@"type"];
            
            SBJsonWriter *writer = [[SBJsonWriter alloc] init];
            
            
            NSString *jsonCommand = [writer stringWithObject:command];
            
            
            
            [self showNativeHudView];
            NSLog(@"RequestParamJSON=%@",jsonCommand);
            
            
            
            self.requestDic=command;
            
            
            
            SingleRequest *sinReq=nil;
            sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:COACHTEAMRESPONSELINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
            self.sinReq1=sinReq;
            [self.storeCreatedRequests addObject:self.sinReq1];
            sinReq.notificationName=COACHTEAMRESPONSE;
            
            [sinReq startRequest];
        }
        else
        {
            /////////////ADDDEB
            [[NSNotificationCenter defaultCenter] postNotificationName:TAPPLAYERTEAMRESPONSENOTIFY object:newinvite.teamId];
            
            ///////////
        }
    }
    else if(newInvite.type.intValue==15)
    {
        
        if(loadStatus)
            return;
        
        
        
        
        
        Invite *newinvite=[self.fetchedResultsController objectAtIndexPath:indexPath];
        
        if(newinvite.viewStatus.boolValue==0)
        {
            self.lastSelRowAdminResponse=indexPath.row;
            self.loadStatus=1;
            NSMutableDictionary *command = [NSMutableDictionary dictionary];
           // [command setObject:newInvite.playerId forKey:@"player_id"];
           // [command setObject:@"coach" forKey:@"type"];
            [command setObject:newinvite.teamId forKey:@"team_id"];
            SBJsonWriter *writer = [[SBJsonWriter alloc] init];
            
            
            NSString *jsonCommand = [writer stringWithObject:command];
            
            
            
            [self showNativeHudView];
            NSLog(@"RequestParamJSON=%@",jsonCommand);
            
            
            
            self.requestDic=command;
            
            
            
            SingleRequest *sinReq=nil;
            sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:COACHADMINRESPONSELINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
            self.sinReq1=sinReq;
            [self.storeCreatedRequests addObject:self.sinReq1];
            sinReq.notificationName=COACHADMINRESPONSE;
            
            [sinReq startRequest];
        }
        else
        {
            /////////////ADDDEB
            [[NSNotificationCenter defaultCenter] postNotificationName:TAPADMINTEAMRESPONSENOTIFY object:newinvite.teamId];
            
            ///////////
        }
    }
    else if(newInvite.type.intValue==10)///////////UserResponseForTeam
    {
        
        if(loadStatus)
            return;
        
        
        
        
        
        Invite *newinvite=[self.fetchedResultsController objectAtIndexPath:indexPath];
        
        if(newinvite.viewStatus.boolValue==0)
        {
            self.lastSelRowUserTeamResponse=indexPath.row;
            self.loadStatus=1;
            NSMutableDictionary *command = [NSMutableDictionary dictionary];
            [command setObject:newInvite.playerId forKey:@"player_id"];
             [command setObject:newInvite.message forKey:@"type"];
            
            
            
            SBJsonWriter *writer = [[SBJsonWriter alloc] init];
            
            
            NSString *jsonCommand = [writer stringWithObject:command];
            
            
            [self showHudView:@"Connecting..."];
            [self showNativeHudView];
            NSLog(@"RequestParamJSON=%@",jsonCommand);
            
            
            
            self.requestDic=command;
            
            
            
            SingleRequest *sinReq=nil;
            sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:USERTEAMRESPONSELINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
            self.sinReq1=sinReq;
            [self.storeCreatedRequests addObject:self.sinReq1];
            sinReq.notificationName=USERTEAMRESPONSE;
            
            [sinReq startRequest];
        }
        else
        {
            
        }
    }
    else if(newInvite.type.intValue==12)
    {
        
        if(loadStatus)
            return;
        
        
        
        
        
        Invite *newinvite=[self.fetchedResultsController objectAtIndexPath:indexPath];
        
        Invite *event2=nil;
        NSPredicate  *pre=[NSPredicate predicateWithFormat:@"type==%i AND eventId==%@",9,newinvite.eventId];
        
        
        NSArray * ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:pre];
        
        if(ar.count>0)
            event2=   [ar objectAtIndex:0];
        if(event2)
        {
            NSIndexPath *newinvitepath=[self.fetchedResultsController indexPathForObject:event2];
            
            /*if(newinvite.viewStatus.boolValue==0)
             {*/
            self.lastSelRowEventDelete=newinvitepath.row;
            self.loadStatus=1;
            NSMutableDictionary *command = [NSMutableDictionary dictionary];
            [command setObject:newInvite.eventId forKey:@"event_id"];
            [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
            [command setObject:@"D" forKey:@"Type"];
            SBJsonWriter *writer = [[SBJsonWriter alloc] init];
            
            
            NSString *jsonCommand = [writer stringWithObject:command];
            
            
            
            [self showNativeHudView];
            NSLog(@"RequestParamJSON=%@",jsonCommand);
            
            
            
            self.requestDic=command;
            
            
            
            SingleRequest *sinReq=nil;
            sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:EVENTDELETEVIEWSTATUSLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
            self.sinReq1=sinReq;
            [self.storeCreatedRequests addObject:self.sinReq1];
            sinReq.notificationName=EVENTDELETEVIEWSTATUS;
            
            [sinReq startRequest];
            
            
            return;
        }
        
        
        ////////////

        
        if(newinvite.viewStatus.boolValue==0)
        {
            self.lastSelRowTeamEventResponse=indexPath.row;
            self.loadStatus=1;
            NSMutableDictionary *command = [NSMutableDictionary dictionary];
            [command setObject:newInvite.playerId forKey:@"player_id"];
           //  [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
             [command setObject:newInvite.eventId forKey:@"event_id"];
            [command setObject:@"coach" forKey:@"type"];
            
            SBJsonWriter *writer = [[SBJsonWriter alloc] init];
            
            
            NSString *jsonCommand = [writer stringWithObject:command];
            
            
            
            [self showNativeHudView];
            NSLog(@"RequestParamJSON=%@",jsonCommand);
            
            
            
            self.requestDic=command;
            
            
            
            SingleRequest *sinReq=nil;
            sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:COACHTEAMEVENTRESPONSELINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
            self.sinReq1=sinReq;
            [self.storeCreatedRequests addObject:self.sinReq1];
            sinReq.notificationName=COACHTEAMEVENTRESPONSE;
            
            [sinReq startRequest];
        }
        else
        {
            /////////////ADDDEB
            [[NSNotificationCenter defaultCenter] postNotificationName:TAPPLAYEREVENTRESPONSENOTIFY object:newinvite.eventId];
            
            ///////////
        }
    }
    else if(newInvite.type.intValue==11)///////////UserResponseForTeamEvent
    {
        
        if(loadStatus)
            return;
        
           Invite *newinvite=[self.fetchedResultsController objectAtIndexPath:indexPath];
        Invite *event2=nil;
      NSPredicate  *pre=[NSPredicate predicateWithFormat:@"type==%i AND eventId==%@",9,newinvite.eventId];
        
        
      NSArray * ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:pre];
        
        if(ar.count>0)
            event2=   [ar objectAtIndex:0];
        if(event2)
        {
            NSIndexPath *newinvitepath=[self.fetchedResultsController indexPathForObject:event2];
            
            /*if(newinvite.viewStatus.boolValue==0)
             {*/
            self.lastSelRowEventDelete=newinvitepath.row;
            self.loadStatus=1;
            NSMutableDictionary *command = [NSMutableDictionary dictionary];
            [command setObject:newInvite.eventId forKey:@"event_id"];
            [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
            [command setObject:@"D" forKey:@"Type"];
            SBJsonWriter *writer = [[SBJsonWriter alloc] init];
            
            
            NSString *jsonCommand = [writer stringWithObject:command];
            
            
            
            [self showNativeHudView];
            NSLog(@"RequestParamJSON=%@",jsonCommand);
            
            
            
            self.requestDic=command;
            
            
            
            SingleRequest *sinReq=nil;
            sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:EVENTDELETEVIEWSTATUSLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
            self.sinReq1=sinReq;
            [self.storeCreatedRequests addObject:self.sinReq1];
            sinReq.notificationName=EVENTDELETEVIEWSTATUS;
            
            [sinReq startRequest];
            
            
            return;
        }
        
        
     ////////////
        
        if(newinvite.viewStatus.boolValue==0)
        {
            
            Invite *dataEvent=nil;
            Invite *anObj = nil;
            NSFetchRequest * request = [[NSFetchRequest alloc] init];
            [request setEntity:[NSEntityDescription entityForName:EVENTUNREAD inManagedObjectContext:self.managedObjectContext]];
            
            [request setPredicate:[NSPredicate predicateWithFormat:@"(eventId==%@) AND (userId=%@) AND (type==%i)",newinvite.eventId,[appDelegate.aDef objectForKey:LoggedUserID],5]];
            
            NSArray* ar =nil;
            ar= [self.managedObjectContext executeFetchRequest:request error:nil];
            if ([ar count]>=1)
            {
                anObj= (Invite *) [ar objectAtIndex:0];
            }
            
            
            dataEvent=anObj;
            
            
            
            
            if(dataEvent)
            {
                 self.userEventResponseRecord=newInvite;
                [self showHudView:@"Connecting..."];
                EventCalendarViewController *evc=(EventCalendarViewController*)[appDelegate.navigationControllerCalendar.viewControllers objectAtIndex:0];
                
                
                
                [evc processAcceptEvent:dataEvent];
                
                
            }
            else
            {
            self.userEventResponseRecord=newInvite;
            self.lastSelRowUserTeamEventResponse=indexPath.row;
            self.loadStatus=1;
            NSMutableDictionary *command = [NSMutableDictionary dictionary];
            [command setObject:newInvite.playerId forKey:@"player_id"];
            [command setObject:newInvite.eventId forKey:@"event_id"];
            [command setObject:newInvite.message forKey:@"type"];
            // [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
            
            
            SBJsonWriter *writer = [[SBJsonWriter alloc] init];
            
            
            NSString *jsonCommand = [writer stringWithObject:command];
            
            
            [self showHudView:@"Connecting..."];
            [self showNativeHudView];
            NSLog(@"RequestParamJSON=%@",jsonCommand);
            
            
            
            self.requestDic=command;
            
            
            
            SingleRequest *sinReq=nil;
            sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:USERTEAMEVENTRESPONSELINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
            self.sinReq1=sinReq;
            [self.storeCreatedRequests addObject:self.sinReq1];
            sinReq.notificationName=USERTEAMEVENTRESPONSE;
            
            [sinReq startRequest];
            }
        }
        else
        {
            
        }
    }

    else if(newInvite.type.intValue==8)///////////UpdateEvent
    {
        
        if(loadStatus)
            return;
         Invite *newinvite=[self.fetchedResultsController objectAtIndexPath:indexPath];
        
        //////////////////
        Invite *event1=nil;
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"type==%i AND eventId==%@",5,newinvite.eventId];
        
        
        NSArray *ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:pre];
        
        if(ar.count>0)
        {
            event1=   [ar objectAtIndex:0];
         newInvite.playerId=event1.playerId;
        newInvite.playerName=event1.playerName;
         newInvite.userId=event1.playerUserId;
            [appDelegate saveContext];
        
        }
        
        
        //////////////////
        
        Invite *event2=nil;
       pre=[NSPredicate predicateWithFormat:@"type==%i AND eventId==%@",9,newinvite.eventId];
        
        
       ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:pre];
        
        if(ar.count>0)
            event2=   [ar objectAtIndex:0];
        
        if(event2)
        {
            NSIndexPath *newinvitepath=[self.fetchedResultsController indexPathForObject:event2];
            
            /*if(newinvite.viewStatus.boolValue==0)
             {*/
            self.lastSelRowEventDelete=newinvitepath.row;
            self.loadStatus=1;
            NSMutableDictionary *command = [NSMutableDictionary dictionary];
            [command setObject:newInvite.eventId forKey:@"event_id"];
            [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
            [command setObject:@"D" forKey:@"Type"];
            SBJsonWriter *writer = [[SBJsonWriter alloc] init];
            
            
            NSString *jsonCommand = [writer stringWithObject:command];
            
            
            
            [self showNativeHudView];
            NSLog(@"RequestParamJSON=%@",jsonCommand);
            
            
            
            self.requestDic=command;
            
            
            
            SingleRequest *sinReq=nil;
            sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:EVENTDELETEVIEWSTATUSLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
            self.sinReq1=sinReq;
            [self.storeCreatedRequests addObject:self.sinReq1];
            sinReq.notificationName=EVENTDELETEVIEWSTATUS;
            
            [sinReq startRequest];
            
        }
        else
        {
       
        
        /*if(newinvite.viewStatus.boolValue==0)
        {*/
            self.lastSelRowEventUpdate=indexPath.row;
            self.loadStatus=1;
            NSMutableDictionary *command = [NSMutableDictionary dictionary];
            [command setObject:newInvite.eventId forKey:@"event_id"];
             [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
         [command setObject:@"U" forKey:@"Type"];
            SBJsonWriter *writer = [[SBJsonWriter alloc] init];
            
            
            NSString *jsonCommand = [writer stringWithObject:command];
            
            
            [self showHudView:@"Connecting..."];
            [self showNativeHudView];
            NSLog(@"RequestParamJSON=%@",jsonCommand);
            
            
            
            self.requestDic=command;
            
            
            
            SingleRequest *sinReq=nil;
            sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:EVENTUPDATEVIEWSTATUSLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
            self.sinReq1=sinReq;
            [self.storeCreatedRequests addObject:self.sinReq1];
            sinReq.notificationName=EVENTUPDATEVIEWSTATUS;
            
            [sinReq startRequest];
        }
        /*}
        else
        {
            
        }*/
    }
    else if(newInvite.type.intValue==9)//DeleteEvent
    {
        
        if(loadStatus)
            return;
        
        
        
        
        
        Invite *newinvite=[self.fetchedResultsController objectAtIndexPath:indexPath];
        
        /*if(newinvite.viewStatus.boolValue==0)
        {*/
            self.lastSelRowEventDelete=indexPath.row;
            self.loadStatus=1;
            NSMutableDictionary *command = [NSMutableDictionary dictionary];
        [command setObject:newInvite.eventId forKey:@"event_id"];
        [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
        [command setObject:@"D" forKey:@"Type"];
            SBJsonWriter *writer = [[SBJsonWriter alloc] init];
            
            
            NSString *jsonCommand = [writer stringWithObject:command];
            
            
            
            [self showNativeHudView];
            NSLog(@"RequestParamJSON=%@",jsonCommand);
            
            
            
            self.requestDic=command;
            
            
            
            SingleRequest *sinReq=nil;
            sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:EVENTDELETEVIEWSTATUSLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
            self.sinReq1=sinReq;
            [self.storeCreatedRequests addObject:self.sinReq1];
            sinReq.notificationName=EVENTDELETEVIEWSTATUS;
            
            [sinReq startRequest];
        /*}
        else
        {
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

        }*/
    }

    else if(newInvite.type.intValue==6)
    {
        if(loadStatus)
            return;
        
       
        
        
        
        Invite *newinvite=newInvite;
        
        if(newinvite.inviteStatus.integerValue==0)
        {
            self.lastSelRow=indexPath.row;
            self.loadStatus=1;
            NSMutableDictionary *command = [NSMutableDictionary dictionary];
            
            [command setObject:newinvite.last_id forKey:@"id"];
            [command setObject:@"1" forKey:@"view_status"];
            SBJsonWriter *writer = [[SBJsonWriter alloc] init];
            
            
            NSString *jsonCommand = [writer stringWithObject:command];
            
            
            
            [self showNativeHudView];
            NSLog(@"RequestParamJSON=%@",jsonCommand);
            
            
            
            self.requestDic=command;
            
            
            
            SingleRequest *sinReq=nil;
            sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:UPDATELIKECOMMENTSTATUSVIEWLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
            self.sinReq1=sinReq;
            [self.storeCreatedRequests addObject:self.sinReq1];
            sinReq.notificationName=UPDATELIKECOMMENTSTATUSVIEW;
            sinReq.userInfo=newinvite;
            [self showHudView:@"Connecting..."];
            [sinReq startRequest];
        }
        else
        {
            
            
            /*if(newinvite.isComment)
            {*/
                [self goToComment:newinvite];
            /*}
            else
            {
                
                
                PostLikeViewController *commentView=[[PostLikeViewController alloc] initWithNibName:@"PostLikeViewController" bundle:nil];
                self.postLikeVC=commentView;
                
                commentView.postId=newinvite.data1;
                
                
                [appDelegate.navigationControllerTeamInvites pushViewController:commentView animated:YES];
                
                commentView=nil;
            }*/
            
            
            
            
        }

    }

}


-(void)processEventUpdated:(id)sender
{
    
    [self hideHudView];
  NSNumber *aNum=  (NSNumber*)[sender object];
    
    if(aNum.boolValue)
    {
        Invite *newInvite=self.userEventResponseRecord;
        
        //=indexPath.row;
        self.loadStatus=1;
        NSMutableDictionary *command = [NSMutableDictionary dictionary];
        [command setObject:newInvite.playerId forKey:@"player_id"];
        [command setObject:newInvite.message forKey:@"type"];
        [command setObject:newInvite.eventId forKey:@"event_id"];
        
        
        SBJsonWriter *writer = [[SBJsonWriter alloc] init];
        
        
        NSString *jsonCommand = [writer stringWithObject:command];
        
        
        [self showHudView:@"Connecting..."];
        [self showNativeHudView];
        NSLog(@"RequestParamJSON=%@",jsonCommand);
        
        
        
        self.requestDic=command;
        
        
        
        SingleRequest *sinReq=nil;
        sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:USERTEAMEVENTRESPONSELINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
        self.sinReq1=sinReq;
        [self.storeCreatedRequests addObject:self.sinReq1];
        sinReq.notificationName=USERTEAMEVENTRESPONSE;
        
        [sinReq startRequest];

        
        
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
    NSEntityDescription *entity = [NSEntityDescription entityForName:INVITE inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    // [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
  
    NSPredicate *pre=[NSPredicate predicateWithFormat:@"type==%i OR type==%i OR type==%i OR type==%i OR type==%i OR type==%i OR type==%i OR type==%i OR type==%i OR type==%i OR type==%i OR type==%i",0,3,5,6,7,8,9,10,11,12,14,15];//15a
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"datetime" ascending:NO /*selector:@selector(localizedCaseInsensitiveCompare:)*/];//@"inviteStatus"
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
   // [self.tabView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
           // [self.tabView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
          //  [self.tabView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
          //  [self.tabView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
           // [self.tabView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
        /*{
            Invite *newEvent= [self.fetchedResultsController objectAtIndexPath:indexPath];
            
            if(newEvent.type.integerValue==0)
            {
                  [self configureCell:(PushByInviteTeamCell*)[self.tabView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            }
           else if(newEvent.type.integerValue==14)
            {
                [self configureCellAdminInvite:(PushByInviteTeamCell*)[self.tabView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            }
            else if(newEvent.type.integerValue==3)
            {
                [self configureCellPushByCoachUpdate:(PushByCoachUpdateCell*)[self.tabView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
               
            }
            else if(newEvent.type.integerValue==6)
            {
                [self configureCellLike:(LikesAndCommentsVCCell*)[self.tabView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            }
            else if(newEvent.type.integerValue==7)
            {
                [self configureCellTeamResponse:(PushByTeamResponseCell*)[self.tabView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            }
            else if(newEvent.type.integerValue==15)//15a
            {
                [self configureCellAdminResponse:(PushByTeamResponseCell*)[self.tabView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            }
            else if(newEvent.type.integerValue==8)
            {
                [self configureCellUpdateEvent:(PushByEventsVCCell*)[self.tabView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            }
            else if(newEvent.type.integerValue==9)
            {
                [self configureCellDeleteEvent:(PushByEventsVCCell*)[self.tabView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            }
            else if(newEvent.type.integerValue==10)
            {
                [self configureCellUserTeamResponse:(PushByTeamResponseCell*)[self.tabView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            }
            else if(newEvent.type.integerValue==12)
            {
                [self configureCellTeamEventResponse:(PushByTeamResponseCell*)[self.tabView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            }
            else if(newEvent.type.integerValue==11)
            {
                [self configureCellUserTeamEventResponse:(PushByTeamResponseCell*)[self.tabView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            }
            else
            {
              [self configureCellNewEvent:(PushByEventsVCCell*)[self.tabView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            }
            
            
            
        }*/
          
            break;
            
        case NSFetchedResultsChangeMove:
            /*[self.tabView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tabView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];*/
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
     NSLog(@"controllerDidChangeContent:2");
   // [self.tabView endUpdates];
    //controller=nil;
    [self.dataImages removeAllObjects];
    [self.tabView reloadData];
    
    if(delegate )
    {
    if([delegate respondsToSelector:@selector(didChangeNumberOfTeamInvites:)])
    {
       NSArray *ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"inviteStatus==0 AND type==%i",0]];
        
        [delegate didChangeNumberOfTeamInvites:[NSString stringWithFormat:@"%i",ar.count]];
    }
    }
    
    
    if(delegate )
    {
        if([delegate respondsToSelector:@selector(didChangeNumberOfAdminInvites:)])
        {
            NSArray *ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"inviteStatus==0 AND type==%i",14]];
            
            [delegate didChangeNumberOfAdminInvites:[NSString stringWithFormat:@"%i",ar.count]];
        }
    }
    
    
    if(delegate)
    {
        if([delegate respondsToSelector:@selector(didChangeNumberOfCoachUpdates:)])
        {
            NSArray *ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"inviteStatus==0 AND type==%i",3]];
            
            [delegate didChangeNumberOfCoachUpdates:[NSString stringWithFormat:@"%i",ar.count]];
        }
    }
    
    
    
    if(delegate )
    {
        if([delegate respondsToSelector:@selector(didChangeNumberOfEvents:)])
        {
            NSArray *ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"viewStatus==0 AND type==%i",5]];    /////  AD 27th May
            
            [delegate didChangeNumberOfEvents:[NSString stringWithFormat:@"%i",ar.count]];
        }
    }
    
    if(delegate )
    {
        if([delegate respondsToSelector:@selector(didChangeNumberOfEventsUpdate:)])
        {
            NSArray *ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"viewStatus==0 AND type==%i",8]];    /////  AD 27th May
            
            [delegate didChangeNumberOfEventsUpdate:[NSString stringWithFormat:@"%i",ar.count]];
        }
    }
    
    if(delegate )
    {
        if([delegate respondsToSelector:@selector(didChangeNumberOfEventsDelete:)])
        {
            NSArray *ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"viewStatus==0 AND type==%i",9]];   /////  AD 27th May
            
            [delegate didChangeNumberOfEventsDelete:[NSString stringWithFormat:@"%i",ar.count]];
        }
    }
    
    
    if(delegate)
    {
       
        
        
        if([delegate respondsToSelector:@selector(didChangeNumberLikeComments:)])
        {
             NSArray *ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"inviteStatus==0 AND type==%i",6]];
            
            
            [delegate didChangeNumberLikeComments:[NSString stringWithFormat:@"%i",ar.count]];
        }
    }
    
    if(delegate)
    {
        
        
        
        if([delegate respondsToSelector:@selector(didChangeNumberOfCoachNotifiedForTeamInvite:)])
        {
            NSArray *ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"viewStatus==0 AND type==%i",7]];
            
            
            [delegate didChangeNumberOfCoachNotifiedForTeamInvite:[NSString stringWithFormat:@"%i",ar.count]];
        }
    }
    
    
    if(delegate)
    {
        
        
        
        if([delegate respondsToSelector:@selector(didChangeNumberOfUserNotifiedForTeamInviteResponse:)])
        {
            NSArray *ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"viewStatus==0 AND type==%i",10]];
            
            
          
            [delegate didChangeNumberOfUserNotifiedForTeamInviteResponse:[NSString stringWithFormat:@"%i",ar.count]];
        }
    }
    
    if(delegate)
    {
        
        
        
        if([delegate respondsToSelector:@selector(didChangeNumberOfCoachNotifiedForAdminInvite:)])
        {
            NSArray *ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"viewStatus==0 AND type==%i",15]];
            
            
            [delegate didChangeNumberOfCoachNotifiedForAdminInvite:[NSString stringWithFormat:@"%i",ar.count]];
        }
    }
    
    
    if(delegate)
    {
        
        
        
        if([delegate respondsToSelector:@selector(didChangeNumberOfCoachNotifiedForTeamEventInvite:)])
        {
            NSArray *ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"viewStatus==0 AND type==%i",12]];
            
            
            [delegate didChangeNumberOfCoachNotifiedForTeamEventInvite:[NSString stringWithFormat:@"%i",ar.count]];
        }
    }
    
    if(delegate)
    {
        
        
        
        if([delegate respondsToSelector:@selector(didChangeNumberOfUserNotifiedForTeamEventInviteResponse:)])
        {
            NSArray *ar= [self.fetchedResultsController.fetchedObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"viewStatus==0 AND type==%i",11]];
            
            
            [delegate didChangeNumberOfUserNotifiedForTeamEventInviteResponse:[NSString stringWithFormat:@"%i",ar.count]];
        }
    }
    
    
    
    if(self.fetchedResultsController.fetchedObjects.count>0)
    {
        self.nolbl.hidden=YES;
        self.nonotificationvw.hidden=YES;
    }
    else
    {
        self.nolbl.hidden=NO;
         self.nonotificationvw.hidden=NO;
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

- (IBAction)topBarAction:(id)sender
{
    int tag=[sender tag];
    
    if(tag==0)
    {
         [self.navigationController.view setHidden:YES];
    }
    else if(tag==1)
    {
        [self.navigationController pushViewController:self.selContactNew animated:YES];
        
        [self.selContactNew resetData];
    }
    
    
}

/*-(void)tableReloadData{
    
    [self.tabView reloadData];
}*/

- (IBAction)doneAlert:(UIButton *)sender {
    
    self.alertViewBAck.hidden=YES;
    self.alertView.hidden=YES;
    
    if (sender.tag==1) {
        
        self.loadStatus=1;
        
        if (self.isDeclineAdmin==YES) {
            Invite *newinvite=[self.fetchedResultsController objectAtIndexPath:self.lastSelIndexPathAdmin];
            
            
            NSString *str=nil;
            
            str=@"Decline";
            lastSelStatusAdmin=2;
            NSMutableDictionary *command = [NSMutableDictionary dictionary];
            
            [command setObject:[appDelegate.aDef objectForKey:EMAIL] forKey:@"creator_email2"];
            
            
            
            
            [command setObject:str forKey:@"coach2_status"];
            [command setObject:newinvite.teamId forKey:@"team_id"];
            
            
            [command setObject:newinvite.teamId forKey:@"team_id"];
            [command setObject:@"0" forKey:@"start"];
            [command setObject:DEFAULTLIMIT forKey:@"limit"];
            [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
            SBJsonWriter *writer = [[SBJsonWriter alloc] init];
            
            
            NSString *jsonCommand = [writer stringWithObject:command];
            
            
            
            [self showNativeHudView];
            NSLog(@"RequestParamJSON=%@",jsonCommand);
            
            
            
            self.requestDic=command;
            
            
            /*[appDelegate sendRequestFor:INVITEFRIENDSSTATUS from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];*/
            
            SingleRequest *sinReq=nil;
            sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:ADMININVITESTATUSBYPUSHLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
            self.sinReq2=sinReq;
            [self.storeCreatedRequests addObject:self.sinReq2];
            sinReq.notificationName=ADMININVITESTATUSBYPUSH;
            [self showHudView:@"Connecting..."];
            [sinReq startRequest];
        }
        else if (self.isDeclineAdmin==NO){
            
            self.loadStatus=1;
            Invite *newinvite=[self.fetchedResultsController objectAtIndexPath:self.lastSelIndexPath];
            //////////////////////////////////////////////////////////////////////////
            
            Invite *invite=(Invite*)  [self objectOfTypeInviteTeamResponseForUser:INVITE forId:newinvite.teamId andManObjCon:self.managedObjectContext];
            
            if(invite)
            {
                
                NSIndexPath *aPath=[self.fetchedResultsController indexPathForObject:invite];
                
                
                /*if(invite.viewStatus.boolValue==0)
                 {*/
                self.lastSelRowUserTeamResponse=aPath.row;
                self.loadStatus=1;
                NSMutableDictionary *command = [NSMutableDictionary dictionary];
                [command setObject:invite.playerId forKey:@"player_id"];
                [command setObject:invite.message forKey:@"type"];
                
                
                SBJsonWriter *writer = [[SBJsonWriter alloc] init];
                
                
                NSString *jsonCommand = [writer stringWithObject:command];
                
                
                [self showHudView:@"Connecting..."];
                [self showNativeHudView];
                NSLog(@"RequestParamJSON=%@",jsonCommand);
                
                
                
                self.requestDic=command;
                
                
                
                SingleRequest *sinReq=nil;
                sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:USERTEAMRESPONSELINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
                self.sinReq1=sinReq;
                [self.storeCreatedRequests addObject:self.sinReq1];
                sinReq.notificationName=USERTEAMRESPONSE;
                
                [sinReq startRequest];
                
                
                return;
                /*}
                 else
                 {
                 
                 }*/
                
                
                
                
                
                
                
            }
            ////////////////////////////////////////////////////////////////////////////////
            
            
            
            
            
            
            
            
            
            NSString *str=nil;
            
            str=@"Decline";
            lastSelStatus=2;
            self.strInviteStatus=str;
            NSMutableDictionary *command = [NSMutableDictionary dictionary];
            if(newinvite.userId)
                [command setObject:newinvite.userId forKey:@"UserID"];
            else
                [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
            
            if(/*![[appDelegate.aDef objectForKey:LoggedUserID] isEqualToString:newinvite.userId]*/newinvite.userId)
                [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"Primary_UserID"];
            else
                [command setObject:@"" forKey:@"Primary_UserID"];
            
            
            [command setObject:str forKey:@"invites"];
            [command setObject:newinvite.teamId forKey:@"team_id"];
            [command setObject:@"0" forKey:@"start"];
            [command setObject:DEFAULTLIMIT forKey:@"limit"];
            [command setObject:@"" forKey:@"view"];
            SBJsonWriter *writer = [[SBJsonWriter alloc] init];
            
            
            NSString *jsonCommand = [writer stringWithObject:command];
            
            
            
            [self showNativeHudView];
            NSLog(@"RequestParamJSON=%@",jsonCommand);
            
            
            
            self.requestDic=command;
            
            
            /*[appDelegate sendRequestFor:INVITEFRIENDSSTATUS from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];*/
            
            SingleRequest *sinReq=nil;
            sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:TEAMINVITESTATUSLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
            self.sinReq2=sinReq;
            [self.storeCreatedRequests addObject:self.sinReq2];
            sinReq.notificationName=TEAMINVITESTATUSBYPUSH;
            [self showHudView:@"Connecting..."];
            [sinReq startRequest];
        }
        
       
    }
    
    
}



#pragma mark - AdBannerViewDelegate method implementation

-(void)bannerViewWillLoadAd:(ADBannerView *)banner
{
    NSLog(@"Ad Banner will load ad.");
}


-(void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    NSLog(@"Ad Banner did load ad.");
    
    // Show the ad banner.
    
    self.adBanner.hidden=NO;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.adBanner.alpha = 1.0;
    }];
}


-(BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    NSLog(@"Ad Banner action is about to begin.");
    
    //self.pauseTimeCounting = YES;
    
    return YES;
}


-(void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    NSLog(@"Ad Banner action did finish");
    
    // self.pauseTimeCounting = NO;
}


-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"Unable to show ads. Error: %@", [error localizedDescription]);
    
    // Hide the ad banner.
    [UIView animateWithDuration:0.5 animations:^{
        self.adBanner.alpha = 0.0;
    }completion:^(BOOL finished) {
        self.adBanner.hidden=YES;
    }];
    
}


@end
