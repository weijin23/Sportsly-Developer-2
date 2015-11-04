//
//  HomeVC.m
//  Social
//
//  Created by Mindpace on 12/08/13.
//

//
#import "ToDoByEventsVC.h"
#import "LeftViewController.h"
#import "PageControlExampleViewControl.h"
#import "EventCalendarViewController.h"
#import "MainInviteVC.h"
#import "PushByInviteFriendVC.h"
#import "PlayerRelationVC.h"
#import "FPPopoverController.h"
#import "TeamUpdateCreateVC.h"
#import "CreatePostViewController.h"
#import "CommentVC.h"
#import "TeamMaintenanceVC.h"
#import "CenterViewController.h"
#import "ASIHTTPRequest.h"
#import "HomeVC.h"
#import "HomeVCTableData.h"
#import "HomeVCTableCell.h"
#import "PostLikeViewController.h"
#import "FeedBackViewController.h"
#import "InviteCoachViewController.h"
#import "UIView+Toast.h"

#import "ALAssetsLibrary+CustomPhotoAlbum.h"

@interface HomeVC ()
{
    ALAssetsLibrary* libraryFolder,*library ;
    
    
    UIImageView *imagevw;
    
}

@end

@interface HomeVC (oritation)


@end

@implementation HomeVC (oritation)
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
-(BOOL)shouldAutorotate {
    return YES;
}
@end

@implementation HomeVC




@synthesize loadStatus, dataArrayUpButtons,updateslabtext,dataArray,isSelectedImage,isSelectedVideo,keyboardToolbar,keyboardToolbarView,scrollview,currbodytext,dataVideo,dataArrayUpButtonsIds,lastSelectedTeam,buttonfirstinscroll,allpostdataDic,dataArrayUpInvites,dataArrayUpIsCreated,dataArrayUpTexts,dataArrayUpImages,pull,isFromPullToRefresh,currenttextvw,likedImage,nonLikedImage,animationtogreensets,animationtowhitesets,isProcessingLikeOrUnlike,dataArrayUpCoachDetails,postVC,currenttextField,currDelCell,start,limit,createPostVC,dataArrayUpTeamSports,kNumberOfPages,scrollView,pageControl,pageControlUsed;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    ///////Added by Debattam
   /* CGRect r= appDelegate.navigationController.view.frame;
    r.origin.y=36;
    appDelegate.navigationController.view.frame=r;*/
    //  [appDelegate.centerViewController showNavController:appDelegate.navigationController];
    
    
    libraryFolder = [[ALAssetsLibrary alloc] init];
    
    library=[[ALAssetsLibrary alloc] init];

    
    self.scrlvw.delegate = self;
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(keyboardDidShow:)
     name:UIKeyboardDidShowNotification object:self.view.window];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification
                                               object:nil];
    
       NSLog(@"selfViewFrame1=%@",[NSValue valueWithCGRect:self.view.frame]);
    
    // [self.appDelegate.centerViewController.view bringSubviewToFront:appDelegate.centerViewController.tabBarContainervw];
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    ///////Added by Debattam
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
     
                                                    name:UIKeyboardWillHideNotification object:nil];
    
    
   
  
}


-(void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self name:HANDLERECEIVEDMEMORYWARNING object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HOMEVIEWCONTROLLERIMAGELOADED object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TEAMLOGOIMAGELOADED object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TEAMINVITESTATUS object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LIKEUNLIKEUPDATED object:nil];
    
      [[NSNotificationCenter defaultCenter] removeObserver:self name:POSTLISTING object:nil];
    
    
      [[NSNotificationCenter defaultCenter] removeObserver:self name:SHOWNAVIGATIONCONTROLLER object:nil];
}


- (void)imageUpdated:(NSNotification *)notif
{
    
    
    
    HomeVCTableData * info = [notif object];
    
    if([self.dataArray containsObject:info])
    {
        int row = [self.dataArray indexOfObject:info];
        @autoreleasepool {
            
            
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:row inSection:0];
            
            // NSLog(@"Image for row %d updated! Count=%i", row,[self.dataArray count]);
            
         //   NSLog(@"HomeVC1reloadRows");
            
            if([[self.tableView indexPathsForVisibleRows] containsObject:indexPath])
            {
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
               // [self.tableView reloadData];
          //      NSLog(@"HomeVC1.2reloadRows");
            }
            else
            {
                info.userImageInfo.image=nil;
                info.postedImageInfo.image=nil;
            }
         //   NSLog(@"HomeVC2reloadRows");
            // [self.tableView reloadData];
        }

    }
    
    
}



- (void)teamlogoUpdated:(NSNotification *)notif
{
    
    
    
  ImageInfo * info = [notif object];
    
    if([((NSNumber*)info.userInfo) intValue ]==lastSelectedTeam)
    {
        self.teamlogoimaview.image=info.image;
    }
    
    
}



- (void)statusUpdated:(NSNotification *)notif
{
    loadStatus=1;
    [self hideMiddleActivityInd];
    
    if(isFromPullToRefresh)
    {
        isFromPullToRefresh=0;
        [pull finishedLoading];
    }
    
      self.wallblankconvw.hidden=NO;
    
    
  
    
    SingleRequest *sReq=(SingleRequest*)[notif object];
      NSLog(@"%@", sReq.responseString);
    @autoreleasepool {
        
    
    if([sReq.notificationName isEqualToString:TEAMINVITESTATUS])
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
                          self.start+=self.limit;
                        isProcessingLikeOrUnlike=0;
                        [self loadFourSquareDataTeamPostDetails:sReq.responseString];
                        
                       
                        
                        int index=[(NSNumber*)[sReq userInfo] intValue];
                        [self setDataFromDelegateArray:index :appDelegate.arrItems];
                        
                        if(index==lastSelectedTeam)
                        [self reloadDataFromDelegateArray:appDelegate.arrItems];
                        
//                         self.dataArray=appDelegate.arrItems;
//                        [self.allpostdataDic setObject:self.dataArray forKey:[self.dataArrayUpButtonsIds objectAtIndex:index]];
//                        [self.tableView reloadData];
                        
                    }
                    else
                    {
                        [self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
                    }
                    
                 
                    
                    
                    
                
                    
                    
                }
                else
                {
                  //  NSString *message=CONNFAILMSG;
                    //Change in status updated  [self showAlertMessage:message title:@""];
                    // [self showHudAlert:message];
                    // [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
                }
                
            }
            else
            {
              //  NSString *message=CONNFAILMSG;
                //Change in status updated  [self showAlertMessage:message title:@""];
                // [self showHudAlert:message];
                // [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
            }
            
        }
        else
        {
       //     NSString *message=CONNFAILMSG;
          //Change in status updated     [self showAlertMessage:message title:@""];
           // [self showHudAlert:message];
           // [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
        }
    }
    }
}



-(void)loadFourSquareDataTeamPostDetails:(NSString*)responses
{
    
    ///////Added by Debattam
    /*self.dataArray=[[NSMutableArray alloc] init];
     [dataArray release];*/
    
    
    
    NSString *str=responses;
    
    if (str)
    {
       //__block NSDictionary *res=nil;
        SBJsonParser *parser=[[SBJsonParser alloc] init];
        
        id res = [parser objectWithString:str];
        
//    //    NSLog(<#NSString *format, ...#>)
//        /*if([res isAu])
//        {
//            
//        }*/
//        dispatch_queue_t highqueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
//        
//        dispatch_sync(highqueue, ^{
//            
//            
//            res = [str JSONValue];
//            NSLog(@"1.--%i-----%i",str.retainCount,res.retainCount);
//        
//            
//        });
//        
//          NSLog(@"2.--%i-----%i",str.retainCount,res.retainCount);
//       // NSLog(@"%@--%@",res,str);
        
        if ([res isKindOfClass:[NSDictionary class]])
        {
            NSDictionary* aDict = (NSDictionary*) res;
            // aDict=[aDict objectForKey:@"responseData"];
            
            
            if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
            {
                
                
                aDict=[aDict objectForKey:@"response"];
                aDict=[aDict objectForKey:@"team_details"];
                NSArray   *array=[aDict objectForKey:@"post_details"];
                
                
                NSMutableArray *marr=[[NSMutableArray alloc] init];
                
                appDelegate.arrItems=marr;
                
                
                
                
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
                    dvca.number_of_likes=[likecountstr longLongValue];
                    NSMutableArray *marray=[[diction objectForKey:@"comment_user_details"] mutableCopy];
                    dvca.commentdetailsarr=marray;
                    
                    dvca.number_of_comment=[commentcountstr longLongValue];
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
                            NSString *playerNameArray=[[[[NSString stringWithFormat:@"%@",[diction1 objectForKey:@"player_name"]] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@"" withString:@""];
                            
                            playerNameArray=[playerNameArray stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                            
                            
                             NSString *playerIdArray=[[[[NSString stringWithFormat:@"%@",[diction1 objectForKey:@"player_id"]] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@"" withString:@""];
                            
                              playerIdArray=[playerIdArray stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                            
                            dvca.playerNameTeam=playerNameArray;
                            dvca.playerIdTeam=playerIdArray;
                        }
                        
                        if(dvca.isPrimary)
                        {
                            NSString *playerNameArray=[[[[NSString stringWithFormat:@"%@",[diction1 objectForKey:@"Primary_User_Name"]] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@"" withString:@""];
                            
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



- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.view.layer.borderWidth=1.0;
    //self.view.layer.borderColor=[appDelegate.themeCyanColor CGColor];
//    self.navigationController.hidesBarsWhenVerticallyCompact=YES;
//    self.navigationController.hidesBarsWhenVerticallyCompact=NO;
    self.navigationController.navigationBarHidden=YES;
    self.topContainerView.backgroundColor=appDelegate.themeCyanColor;
    self.horidividervw.backgroundColor=[UIColor grayColor];
    
    
    self.horidividervw.hidden=YES;
    
    self.blankwallactlab.text=@"Be the first to Write on this wall";//@"No one has made a post in this team yet";
    
    
    PushByInviteFriendVC *efVC=(PushByInviteFriendVC*)[appDelegate.navigationControllerAddAFriend.viewControllers objectAtIndex:0];
      [efVC view];
    efVC.plusbuttoninvitefriendbt.hidden=YES;
    efVC.isExistTeam=0;
    EventCalendarViewController *efVC1=(EventCalendarViewController*)[appDelegate.navigationControllerCalendar.viewControllers objectAtIndex:0];
    [efVC1 view];
  
    ////////////////////
   // self.tableView.tableFooterView=self.wallfootervw;
   // tableView.sectionFooterHeight=self.wallfootervw.frame.size.height;
   
    
    ///////////////////
    self.relationVC=[[PlayerRelationVC alloc] initWithNibName:@"PlayerRelationVC" bundle:nil];
    self.isFinishData=0;
    FPPopoverController *popover = [[FPPopoverController alloc] initWithViewController:self.relationVC];
    
    self.relationPopover=popover;
    [self.relationVC view];
    self.relationPopover.contentSize = CGSizeMake(270,90);
    self.relationPopover.tint=FPPopoverLightGrayTint;
    ///////////////////
     self.menuupscrollview.hidden=YES;
      self.postlabel.hidden=YES;
    self.postNewContainerView.hidden=YES;
    [self moveTableViewBasisOnPostPermission:0];
    
    self.postBackground.hidden=YES;
    self.updatebackgr.hidden=YES;
    self.redbackindicator.hidden=YES;
       self.redbackindicator1.hidden=YES;
    self.rednextindicator.hidden=YES;
    self.rednextindicator1.hidden=YES;
    self.tapGesture=[[UITapGestureRecognizer alloc] init];
    self.tapGesture.numberOfTapsRequired=1;
    [self.tapGesture addTarget:self action:@selector(videoTapped:)];
    
    ///////  AD 15th june
    tapgesture2=[[UITapGestureRecognizer alloc] init];
    tapgesture2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTapped:)];
    tapgesture2.numberOfTapsRequired=1;
    ///////
    
    if(isiPad)
        self.helveticaFont=[UIFont fontWithName:@"Helvetica" size:18.0];
    else
        self.helveticaFont=[UIFont fontWithName:@"Helvetica" size:14.0];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageUpdated:) name:HOMEVIEWCONTROLLERIMAGELOADED object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(teamlogoUpdated:) name:TEAMLOGOIMAGELOADED object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusUpdated:) name:TEAMINVITESTATUS object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(likeunlikeUpdated:) name:LIKEUNLIKEUPDATED object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postListingUpdated:) name:POSTLISTING object:nil];
    
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNavigationControllerUpdated:) name:SHOWNAVIGATIONCONTROLLER object:nil];
    
    
    ///////////////////ADDDEB
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRosterByTeamAdmin:) name:TAPADMINTEAMRESPONSENOTIFY object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRosterByTeam:) name:TAPPLAYERTEAMRESPONSENOTIFY object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showCalendarByEvent:) name:TAPPLAYEREVENTRESPONSENOTIFY object:nil];
    ///////////////////
    
    ////// ORIENTATION  ///// AD 10th june

    /*[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerWillEnterFullscreenNotification:) name:MPMoviePlayerWillEnterFullscreenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerWillExitFullscreenNotification:) name:MPMoviePlayerWillExitFullscreenNotification object:nil];
    
    ////////////////*/
    
      [self setDiavloFont:self.postlabel withSize:14.0  ];
    //self.view.backgroundColor=appDelegate.barGrayColor;
    self.menuupscrollview.backgroundColor=appDelegate.topBarRedColor;
    self.postBackground.backgroundColor=appDelegate.topBarRedColor;
    self.updatebackgr.backgroundColor=appDelegate.topBarRedColor;
    self.menuupscrollview.layer.cornerRadius=1.0;
    self.teamlistdivider.hidden=YES;
    NSMutableArray *marray=[[NSMutableArray alloc] init];
    self.storeCreatedRequests=marray;
  // self.updatetextvw.contentOffset=CGPointMake(0,10);
//    [self.updatetextvw setContentOffset:CGPointMake(0,10) animated:NO];
   
     self.tableviewupvw.hidden=YES;
     self.tableupview1.hidden=YES;
    self.updatetablehideview.hidden=YES;
    self.updateuphideview.hidden=YES;
    self.teamstatusupdatemainview.layer.cornerRadius=3.0;
   // self.teamstatusupdatemainview.layer.borderColor=[[UIColor grayColor] CGColor];
   // self.teamstatusupdatemainview.layer.borderWidth=2.0;
     self.tableView.hidden=YES;
    
    
    NSArray *arrgreensets=nil;
    NSArray *arrwhitesets=nil;
    
    if(!isiPad)
    {
        self.likedImage=[UIImage imageNamed:@"likewritesel.png"];
        self.nonLikedImage=[UIImage imageNamed:@"likewrite.png"];
        
        arrgreensets=[[NSArray alloc] initWithObjects:[UIImage imageNamed:@"likewrite1.png"],[UIImage imageNamed:@"likewrite2.png"],[UIImage imageNamed:@"likewrite3.png"],[UIImage imageNamed:@"likewrite4.png"],[UIImage imageNamed:@"likewrite5.png"],[UIImage imageNamed:@"likewrite6.png"],[UIImage imageNamed:@"likewrite7.png"] ,nil];
        
        
        
        
        arrwhitesets=[[NSArray alloc] initWithObjects:[UIImage imageNamed:@"likewrite7.png"],[UIImage imageNamed:@"likewrite6.png"],[UIImage imageNamed:@"likewrite5.png"],[UIImage imageNamed:@"likewrite4.png"],[UIImage imageNamed:@"likewrite3.png"],[UIImage imageNamed:@"likewrite2.png"],[UIImage imageNamed:@"likewrite1.png"] ,nil];
    }
    else
    {
        self.likedImage=[UIImage imageNamed:@"likewritesel_ipad.png"];
        self.nonLikedImage=[UIImage imageNamed:@"likewrite_ipad.png"];
        
        arrgreensets=[[NSArray alloc] initWithObjects:[UIImage imageNamed:@"likewrite1_ipad.png"],[UIImage imageNamed:@"likewrite2_ipad.png"],[UIImage imageNamed:@"likewrite3_ipad.png"],[UIImage imageNamed:@"likewrite4_ipad.png"],[UIImage imageNamed:@"likewrite5_ipad.png"],[UIImage imageNamed:@"likewrite6_ipad.png"],[UIImage imageNamed:@"likewrite7_ipad.png"] ,nil];
        
        
        
        
        arrwhitesets=[[NSArray alloc] initWithObjects:[UIImage imageNamed:@"likewrite7_ipad.png"],[UIImage imageNamed:@"likewrite6_ipad.png"],[UIImage imageNamed:@"likewrite5_ipad.png"],[UIImage imageNamed:@"likewrite4_ipad.png"],[UIImage imageNamed:@"likewrite3_ipad.png"],[UIImage imageNamed:@"likewrite2_ipad.png"],[UIImage imageNamed:@"likewrite1_ipad.png"] ,nil];
        
    }
    
    
    self.animationtogreensets=arrgreensets;
    
    self.animationtowhitesets=arrwhitesets;
    
    
    
   /* self.newloginpopupview.layer.borderColor=[[UIColor darkGrayColor] CGColor];
    self.newloginpopupview.layer.borderWidth=2.0;*/
    self.newloginpopupview.layer.cornerRadius=8.0;
    self.newloginpopupview.hidden=YES;
    self.newloginpopupviewbackground.hidden=YES;
    self.activityindicatormiddle.hidden=YES;
    self.teamlistdivider.hidden=YES;
    self.smsnumbertextl.hidden=YES;
    // Do any additional setup after loading the view from its nib.
    self.teamtopview.hidden=YES;
    self.myavatar.image=self.noImage;
    lastSelectedTeam=0;
    loadStatus=1;
   //   self.view.layer.cornerRadius=0.0;
    self.activindicatorpost.hidden=YES;
   // [self disablepost];
    [self moveTableView:0];
    
    PullToRefreshView *pul= [[PullToRefreshView alloc] initWithScrollView:(UIScrollView *) self.tableView ];
    self.pull =pul;
    [pull setDelegate:self];
    [self.tableView addSubview:pull];
    
   //////////cut and paste
    NSMutableDictionary *mdic=[[NSMutableDictionary alloc] init];
    self.allpostdataDic=mdic;
   
    NSMutableArray *marr=[[NSMutableArray alloc] init];
    self.dataArray=marr;
   //////////
    /*self.updateslabtext=@"gdfrgergdergdfghdfrtyretgfewfsdgvdfhnhgfjtuyertewfasfdsgbdfhdtgyw4e5y6ergsfsfreryhgdegw4ter4yghrtdfhdgsefrtewrw4tergdhtdegyher4y6t5tuhjyjkmghjmndfgsert4ewtygrehdfghbd";
    
    
     CGSize labelTextSize = [self.updateslabtext sizeWithFont:self.updateslab.font constrainedToSize:CGSizeMake (self.updateslab.frame.size.width,10000) lineBreakMode: NSLineBreakByWordWrapping];
    
    CGRect rect= self.updateslab.frame;
    rect.size=labelTextSize;
    self.updateslab.frame=rect;
    
    self.updateslab.text=self.updateslabtext;
    
    self.updatesScrollView.contentSize=CGSizeMake(self.updatesScrollView.frame.size.width, labelTextSize.height);
    
    
    */
    
    
   ////////////
    
    
  /////////////
    
    [self.tableView reloadData];
    

    
    
    if(keyboardToolbar == nil && keyboardToolbarView==nil)
    {
        if(self.isiPad)
        {
            keyboardToolbarView=[[UIView alloc] initWithFrame:CGRectMake(0, 500, 768, 84)];
        }
        else
        {
            keyboardToolbarView=[[UIView alloc] initWithFrame:CGRectMake(0, 372, 320, 84)];
        }
        
        //keyboardToolbarView=[[UIView alloc] initWithFrame:CGRectMake(0, 372, 320, 84)];
        keyboardToolbarView.backgroundColor=self.blackcolor;
        keyboardToolbarView.alpha=0.8;
        
        
        if(self.isiPad)
        {
            keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,448,40)];
        }
        else
        {
            keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,40)];
        }
		//keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,40)];
		keyboardToolbar.barStyle = UIBarStyleBlackTranslucent;
        
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(dissmissCanKeyboard:)];
        cancel.tag=0;
        
        UIBarButtonItem *fspace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        
        UIBarButtonItem *done =[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(dissmissCanKeyboard:)];
        done.tintColor=[UIColor blueColor];
        done.tag=1;
        
        NSArray *items = [[NSArray alloc] initWithObjects:cancel,fspace ,done, nil];
        [keyboardToolbar setItems:items];
        [keyboardToolbar setAlpha:1.0];
        
        [keyboardToolbarView addSubview:keyboardToolbar];
	}
   // self.scrollview. contentSize=CGSizeMake(320,416);
   // svos= self.scrollview.contentSize;
    point=CGPointMake(0,0);
    af=[[UIScreen mainScreen] applicationFrame];
    
    
    self.postmainview.layer.cornerRadius=3.0;
    self.postmainview.layer.borderColor=[[appDelegate cellRedColor] CGColor];
    self.postmainview.layer.borderWidth=1.0;
    
    self.commentTextVw.layer.borderColor=[[UIColor grayColor] CGColor];
    self.commentTextVw.layer.borderWidth=1.0;
    
    
    self.divider1.backgroundColor=[appDelegate cellRedColor];
     self.divider2.backgroundColor=[appDelegate cellRedColor];
    
    
    [self setPostAvatarsImage:appDelegate.userOwnImage :nil];
    
    ///////////////////////Related to Team Wall
   //   NSLog(@"ARR6COACH0==%@",[appDelegate.aDef objectForKey:ARRAYCOACHDETAILS]);
    
    
    if([appDelegate.aDef objectForKey:ARRAYNAMES] && [appDelegate.aDef objectForKey:ARRAYIDS] && [appDelegate.aDef objectForKey:ARRAYSTATUS] && [appDelegate.aDef objectForKey:ARRAYCOACHDETAILS] && [appDelegate.aDef objectForKey:ARRAYISCREATES] && [appDelegate.aDef objectForKey:ARRAYIMAGES] && [appDelegate.aDef objectForKey:ARRAYTEXTS] && [appDelegate.aDef objectForKey:ARRAYTEAMSPORTS])
    {
    NSMutableArray *arraynames=[NSMutableArray arrayWithArray:[appDelegate.aDef objectForKey:ARRAYNAMES]];
    NSMutableArray *arrayids=[NSMutableArray arrayWithArray:[appDelegate.aDef objectForKey:ARRAYIDS]];
    NSMutableArray *arrayStatus=[NSMutableArray arrayWithArray:[appDelegate.aDef objectForKey:ARRAYSTATUS]];
        
         NSMutableArray *arrayTeamSports=[NSMutableArray arrayWithArray:[appDelegate.aDef objectForKey:ARRAYTEAMSPORTS]];
        
        
         NSMutableArray *arraycoachdetails=[NSMutableArray arrayWithArray:[appDelegate.aDef objectForKey:ARRAYCOACHDETAILS]];
        
        NSMutableArray *arrayiscreate=[NSMutableArray arrayWithArray:[appDelegate.aDef objectForKey:ARRAYISCREATES]];
        NSMutableArray *arrayimages=[NSMutableArray arrayWithArray:[appDelegate.aDef objectForKey:ARRAYIMAGES]];
        NSMutableArray *arraytexts=[NSMutableArray arrayWithArray:[appDelegate.aDef objectForKey:ARRAYTEXTS]];
    
    if(arraynames.count>0 && arrayids.count>0 && arrayStatus.count>0 && arraycoachdetails.count>0 && arrayiscreate.count>0 && arrayimages.count>0 && arraytexts.count>0 && arrayTeamSports>0)
    {
//        NSLog(@"1.%@",arraynames);
//          NSLog(@"2.%@",arrayids);
//          NSLog(@"3.%@",arrayStatus);
//          NSLog(@"4.%@",arrayiscreate);
//          NSLog(@"5.%@",arrayimages);
//          NSLog(@"6.%@",arraytexts);
        
        
       
        [self addTeamListing:arraynames :arrayids:arrayStatus:arrayiscreate:arrayimages:arraytexts:arraycoachdetails:arrayTeamSports];
        
        [self showParticularTeam:0];
       /* [self.buttonfirstinscroll setTitleColor:self.redcolor forState:UIControlStateNormal];
        
        lastSelectedTeam=self.buttonfirstinscroll.tag;
        
      
        [self requestFirst];*/
              
      
    }
      
    }
    else
    {
      //  [appDelegate setUserDefaultValue:@"1" ForKey:NEWLOGIN];
        
        
        if([[appDelegate.aDef objectForKey:NEWLOGIN] integerValue]==1)
        {
            self.newloginpopupview.hidden=YES;//Ch to y
             self.newloginpopupviewbackground.hidden=YES;//Ch to y
        }
        
        
        
        
        
        
        self.scrollView.hidden=YES;
        self.pageControl.hidden=YES;
    }

    
    
    
    
    
    
    //////////////////////
    if( dataArrayUpButtons.count>0)
    {
    }
    else
    {
    MainInviteVC *mainvc= (MainInviteVC*)[appDelegate.navigationControllerTeamInvites.viewControllers objectAtIndex:0];
        
        [mainvc view];
    int flag=0;
        
        NSString *msgstr=nil;
        
        if( mainvc.totalunreadnumbersAdmin>0)
        {
            msgstr= [[NSString alloc] initWithFormat:@"Welcome to Sportsly\nYay, you have a team invite!" ];
            
            flag=1;
            [appDelegate.navigationControllerTeamInvites popToRootViewControllerAnimated:NO];
            [appDelegate.centerViewController showNavController:appDelegate.navigationControllerTeamInvites];
            
            
            self.appDelegate.centerViewController.timelineimavw.image=self.appDelegate.centerViewController.timelineima;
            self.appDelegate.centerViewController.fsttablab.textColor=self.appDelegate.centerViewController.lightgraycolor;
            self.appDelegate.centerViewController.eventsimavw.image=self.appDelegate.centerViewController.eventsima;
            self.appDelegate.centerViewController.sectablab.textColor=self.appDelegate.centerViewController.lightgraycolor;
            self.appDelegate.centerViewController.msgimavw.image=self.appDelegate.centerViewController.msgima;
            self.appDelegate.centerViewController.msgtablab.textColor=self.appDelegate.centerViewController.lightgraycolor;
            self.appDelegate.centerViewController.invitesimavw.image=self.appDelegate.centerViewController.invitesima;
            self.appDelegate.centerViewController.invtablab.textColor=self.appDelegate.centerViewController.lightgraycolor;
            self.appDelegate.centerViewController.notificationimavw.image=self.appDelegate.centerViewController.notificationima;
            self.appDelegate.centerViewController.notificlab.textColor=self.appDelegate.centerViewController.lightgraycolor;
            self.appDelegate.centerViewController.notificationimavw.image=self.appDelegate.centerViewController.notificationimasel;
            self.appDelegate.centerViewController.notificlab.textColor=self.appDelegate.themeCyanColor;
            
            
            
            
            
        }
        
        
        if(flag==0)
        
        {
            if( mainvc.totalunreadnumbersTeam>0)
            {
                
                msgstr= [[NSString alloc] initWithFormat:@"Welcome to Sportsly\nYay, you have a team invite!" ];
                
                flag=1;
                [appDelegate.navigationControllerTeamInvites popToRootViewControllerAnimated:NO];
                [appDelegate.centerViewController showNavController:appDelegate.navigationControllerTeamInvites];
                
                
                self.appDelegate.centerViewController.timelineimavw.image=self.appDelegate.centerViewController.timelineima;
                self.appDelegate.centerViewController.fsttablab.textColor=self.appDelegate.centerViewController.lightgraycolor;
                self.appDelegate.centerViewController.eventsimavw.image=self.appDelegate.centerViewController.eventsima;
                self.appDelegate.centerViewController.sectablab.textColor=self.appDelegate.centerViewController.lightgraycolor;
                self.appDelegate.centerViewController.msgimavw.image=self.appDelegate.centerViewController.msgima;
                self.appDelegate.centerViewController.msgtablab.textColor=self.appDelegate.centerViewController.lightgraycolor;
                self.appDelegate.centerViewController.invitesimavw.image=self.appDelegate.centerViewController.invitesima;
                self.appDelegate.centerViewController.invtablab.textColor=self.appDelegate.centerViewController.lightgraycolor;
                self.appDelegate.centerViewController.notificationimavw.image=self.appDelegate.centerViewController.notificationima;
                self.appDelegate.centerViewController.notificlab.textColor=self.appDelegate.centerViewController.lightgraycolor;
                self.appDelegate.centerViewController.notificationimavw.image=self.appDelegate.centerViewController.notificationimasel;
                self.appDelegate.centerViewController.notificlab.textColor=self.appDelegate.themeCyanColor;
                
                
                
                
                
            }
    }
        
        
        
    if(flag==0)
    {
        
      
      int k=  [[appDelegate.centerViewController.invitefriendlabelbt titleForState:UIControlStateNormal] intValue];
        
          if(k>0)
          {
             
              
              flag=1;
              
               msgstr= [[NSString alloc] initWithFormat:@"Welcome to Sportsly\nYay, you have a team invite!" ];
              
              [appDelegate.navigationControllerAddAFriend popToRootViewControllerAnimated:NO];
              //   [adF.tbllView reloadData];
              NSLog(@"1.%@",appDelegate.navigationControllerAddAFriend);
              
              //  [self presentViewController:appDelegate.navigationControllerAddAFriend animated:YES completion:nil ];
              [appDelegate.centerViewController showNavController:appDelegate.navigationControllerAddAFriend];
              self.appDelegate.centerViewController.timelineimavw.image=self.appDelegate.centerViewController.timelineima;
              self.appDelegate.centerViewController.fsttablab.textColor=self.appDelegate.centerViewController.lightgraycolor;
              self.appDelegate.centerViewController.eventsimavw.image=self.appDelegate.centerViewController.eventsima;
              self.appDelegate.centerViewController.sectablab.textColor=self.appDelegate.centerViewController.lightgraycolor;
              self.appDelegate.centerViewController.msgimavw.image=self.appDelegate.centerViewController.msgima;
              self.appDelegate.centerViewController.msgtablab.textColor=self.appDelegate.centerViewController.lightgraycolor;
              self.appDelegate.centerViewController.invitesimavw.image=self.appDelegate.centerViewController.invitesima;
              self.appDelegate.centerViewController.invtablab.textColor=self.appDelegate.centerViewController.lightgraycolor;
              self.appDelegate.centerViewController.notificationimavw.image=self.appDelegate.centerViewController.notificationima;
              self.appDelegate.centerViewController.notificlab.textColor=self.appDelegate.centerViewController.lightgraycolor;
              self.appDelegate.centerViewController.invitesimavw.image=self.appDelegate.centerViewController.invitesimasel;
              self.appDelegate.centerViewController.invtablab.textColor=self.appDelegate.themeCyanColor;
              
              
              
              

          }
    }
        
        
        if(flag)
        {
            mainvc.isWelcomeAlert=1;
             [mainvc showAlertViewCustom:msgstr];
        }
    }
    
    
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:SHOWNAVIGATIONCONTROLLER object:nil];
    
    
    
    
  //  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    NSLog(@"centerViewControllerViewBounds=%@",[NSValue valueWithCGRect:appDelegate.centerViewController.view.bounds]);
      NSLog(@"centerViewControllerViewFrame=%@",[NSValue valueWithCGRect:appDelegate.centerViewController.view.frame]);
    
    
    
    self.navigationController.delegate=self;
    
    
   
    
       NSLog(@"selfViewFrame=%@",[NSValue valueWithCGRect:self.view.frame]);
    [self addPanGestureToView:nil];
}





- (IBAction)popuptapped:(id)sender
{
    self.popupalertvw.hidden=YES;
    self.popupalertvwback.hidden=YES;
    
    
    if(appDelegate.centerVC.dataArrayUpButtonsIds.count==1)
    {
    /* PlayerRelationVC *pvc=   [[PlayerRelationVC alloc] initWithNibName:@"PlayerRelationVC" bundle:nil];
        
      
        
        FPPopoverController *popover = [[FPPopoverController alloc] initWithViewController:pvc];
        
        [pvc view];
          pvc.namelab.text=@"Tap to get Roster Details";
        if (self.isiPad) {
            popover.contentSize = CGSizeMake(300,110);
            [popover presentPopoverFromPoint:CGPointMake(650,50)];
        }
        else{
            popover.contentSize = CGSizeMake(220,90);
            [popover presentPopoverFromPoint:CGPointMake(293,40)];
        }

        
        popover.tint=FPPopoverLightGrayTint;
        */
    }
  
    
   
}

-(void)showAlertViewCustom:(NSString*)labText
{
    
    self.custompopuplab.text=labText;
    
    self.popupalertvw.hidden=NO;
    self.popupalertvwback.hidden=NO;
    
    [self.view bringSubviewToFront:self.popupalertvwback];
    [self.view bringSubviewToFront:self.popupalertvw];
}







- (void)addPanGestureToView:(UIView *)view
{
    /*UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(_handlePan:)];
    panGesture.delegate = self;
    panGesture.maximumNumberOfTouches = 1;
    panGesture.minimumNumberOfTouches = 1;
    [view addGestureRecognizer:panGesture];*/
    
    
    UISwipeGestureRecognizer *sgleft=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeDone)];
    sgleft.direction=UISwipeGestureRecognizerDirectionRight;
     [self.view addGestureRecognizer:sgleft];
    
    
    UISwipeGestureRecognizer *sgright=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeDone)];
    sgright.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:sgright];
    
    sgright=nil;
    sgleft=nil;
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
  [[NSNotificationCenter defaultCenter] postNotificationName:SHOWNAVIGATIONCONTROLLER object:nil];
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
        
        if(self.dataArrayUpButtons.count>0)
        {
            appDelegate.centerViewController.navigationItem.title=[self.dataArrayUpButtons objectAtIndex:lastSelectedTeam];
            [self loadScrollViewWithPage:lastSelectedTeam];
        }
        else
        appDelegate.centerViewController.navigationItem.title=PRODUCT_NAME;
            
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
        if (self.isiPad) {
            self.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"teamRosterWall_ipad.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleRightPanel:)];
        }
        else{
            self.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"teamRosterWall.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleRightPanel:)];
        }
        [self.btnTeamCreate addTarget:self action:@selector(toggleRightPanel:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    appDelegate.centerViewController.navigationItem.title=nil;
    appDelegate.centerViewController.navigationItem.titleView=nil;
    
    //appDelegate.centerViewController.navigationItem.title=nil;
   // appDelegate.centerViewController.navigationItem.titleView=nil;
    
    appDelegate.centerViewController.navigationItem.leftBarButtonItem=self.leftBarButtonItem;
    
     appDelegate.centerViewController.navigationItem.rightBarButtonItem=self.rightBarButtonItem;
    
    
    [self setStatusBarStyleOwnApp:1];
    
    
//    //// AD...iAd
//    self.adBanner.delegate = self;
//    self.adBanner.alpha = 0.0;
//    self.canDisplayBannerAds=YES;
//    ////
    
}

-(void)toggleLeftPanel:(id)sender
{
    [appDelegate.slidePanelController showLeftPanelAnimated:YES];
   
}


-(void)toggleRightPanel:(id)sender
{
    // [appDelegate.slidePanelController showRightPanelAnimated:YES];
    
    
    /////  change message to roster  18/02/2015 /////
    
    ////// AD 15th june
    /*appDelegate.centerViewController.timelineimavw.image=self.appDelegate.centerViewController.timelineima;
    self.appDelegate.centerViewController.fsttablab.textColor=self.lightgraycolor;*/
    
    
    if([[appDelegate.navigationControllerTeamMaintenance.viewControllers lastObject] isMemberOfClass:[TeamMaintenanceVC class]]){
        [(TeamMaintenanceVC*)[appDelegate.navigationControllerTeamMaintenance.viewControllers lastObject] loadTeamData];
        [(TeamMaintenanceVC*)[appDelegate.navigationControllerTeamMaintenance.viewControllers lastObject] showAllSporstlyUsers];
    }
        TeamMaintenanceVC *teamVc=  (TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0];
        teamVc.isShowFristTime=YES;
   // teamVc.whichSegmentTap=1;
    
    //////////////ADDDEB
    teamVc.isShowFromNotification=NO;
    /////////////
    
     [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerTeamMaintenance];
     
    
    
   /* appDelegate.centerViewController.timelineimavw.image=self.appDelegate.centerViewController.timelineima;
    self.appDelegate.centerViewController.fsttablab.textColor=self.lightgraycolor;
    
    [appDelegate.navigationControllerChatMessage popToRootViewControllerAnimated:NO];
    
    [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerChatMessage];
    //[self showNavController:appDelegate.navigationControllerChatMessage];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:SHOWNAVIGATIONCONTROLLERCHATMESSAGE object:nil];
    ChatMessageViewController *chat=(ChatMessageViewController *)[appDelegate.navigationControllerChatMessage.viewControllers objectAtIndex:0];
    [chat getUpdatedRegisterUserListing];
    
    [(ChatMessageViewController*)[self.appDelegate.navigationControllerChatMessage.viewControllers objectAtIndex:0] refreshChatMessageList];*/
    
    
    
    
}

///////////////////ADDDEB
-(void)showCalendarByEvent:(id)sender
{
    
    
    [appDelegate.leftVC resetTableViewIndex];
    NSString *eventId=(NSString*)[sender object];
    
    
    
    
    EventCalendarViewController *eVC=(EventCalendarViewController*) [appDelegate.navigationControllerCalendar.viewControllers objectAtIndex:0];
    [appDelegate.navigationControllerCalendar popToRootViewControllerAnimated:NO];
    
    eVC.evpopVC.datelab.font=self.helveticaFont;
    eVC.evpopVC.teamandeventlab.font=self.helveticaFont;
    eVC.evpopVC.playerlab.font=self.helveticaFont;
    eVC.evpopVC.statuslab.font=self.helveticaFont;
    
    
    
    
    eVC.eventheaderlab.text=CREATETEAMEVENTINVITATION;
    eVC.isMonth=0;
    eVC.topSegCntrl.selectedSegmentIndex=eVC.isMonth;
    
    eVC.custompopuptopselectionvw.hidden=YES;
    eVC.custompopupbottomvw.hidden=YES;
    eVC.callistvc.fetchFirstDate=nil;
    eVC.callistvc.fetchLastDate=nil;
    eVC.callistvc.selTeamId=nil;
    eVC.callistvc.selplayerId=nil;
    eVC.callistvc.selShowByStatus=0;
    eVC.callistvc.isSelShowByStatus=0;
    eVC.callistvc.fetchedResultsController=nil;
    [eVC.callistvc loadTable];
    eVC.calvc.view.hidden=YES;
    eVC.callistvc.view.hidden=NO;
    
    eVC.downarrowfilterimavw.hidden=NO;
    eVC.downarrowfilterbt.hidden=NO;
    
    [eVC.calvc.monthView reloadData];
    
    [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerCalendar];
    
    
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:SHOWEVENTATTENDANCENOTIFY object:eventId];
    
    
    
    
    
}
-(void)showRosterByTeam:(id)sender
{
    [appDelegate.leftVC resetTableViewIndex];
    NSString *teamId=(NSString*)[sender object];
    
    appDelegate.centerViewController.timelineimavw.image=self.appDelegate.centerViewController.timelineima;
    self.appDelegate.centerViewController.fsttablab.textColor=self.lightgraycolor;
    
    if([[appDelegate.navigationControllerTeamMaintenance.viewControllers lastObject] isMemberOfClass:[TeamMaintenanceVC class]])
        [(TeamMaintenanceVC*)[appDelegate.navigationControllerTeamMaintenance.viewControllers lastObject] loadTeamData];
    TeamMaintenanceVC *teamVc=  (TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0];
    teamVc.isShowFristTime=NO;
    teamVc.isShowFromNotification=YES;
    teamVc.teamIdForShowingNotification=teamId;
    //int indx=[self.appDelegate.JSONDATAarr indexOfObject:teamId];
    //[teamVc getFromMyTeams:[]];
    [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerTeamMaintenance];
    
    
     [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFYROSTERTAPSEGCONTROL object:nil];
    
}


-(void)showRosterByTeamAdmin:(id)sender
{
    [appDelegate.leftVC resetTableViewIndex];
    NSString *teamId=(NSString*)[sender object];
    
    appDelegate.centerViewController.timelineimavw.image=self.appDelegate.centerViewController.timelineima;
    self.appDelegate.centerViewController.fsttablab.textColor=self.lightgraycolor;
    
    if([[appDelegate.navigationControllerTeamMaintenance.viewControllers lastObject] isMemberOfClass:[TeamMaintenanceVC class]])
        [(TeamMaintenanceVC*)[appDelegate.navigationControllerTeamMaintenance.viewControllers lastObject] loadTeamData];
    TeamMaintenanceVC *teamVc=  (TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0];
    teamVc.isShowFristTime=NO;
    teamVc.isShowFromNotification=YES;
    teamVc.teamIdForShowingNotification=teamId;
    
    [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerTeamMaintenance];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFYADMINTAPSEGCONTROL object:nil ];
    
    
}
///////////////////


// AD 19th MyTeams
-(void)getFromMyTeams:(int)page{
    if (page==-1) {
        pageControl.currentPage=1;
        [self leftSwipeDone];
    }
    else{
        pageControl.currentPage=page;
        
        [self rightSwipeDone];
    }
}

////////





-(void)leftSwipeDone
{
    
    
    int page = pageControl.currentPage;
    
    page--;
    
    if(page>=0 && page< self.dataArrayUpButtons.count)
    {
    pageControl.currentPage=page;
    
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    pageControlUsed = YES;
    [scrollView scrollRectToVisible:frame animated:YES];
    
    [self loadScrollViewWithPage:page];

    
    }
    self.hiddenvw.hidden=YES;
    
    self.scrlvw.zoomScale=1.0;
    
}

-(void)rightSwipeDone
{
    
    
    int page = pageControl.currentPage;
    
    page++;
    
    if(page>=0 && page< self.dataArrayUpButtons.count)
    {
        pageControl.currentPage=page;
        
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        pageControlUsed = YES;
        [scrollView scrollRectToVisible:frame animated:YES];
        
        [self loadScrollViewWithPage:page];

        
    }
    self.hiddenvw.hidden=YES;
    
    self.scrlvw.zoomScale=1.0;

    
}


-(void)updateArrayByAddingOneTeam:(NSString*)str :(NSString*)str1 :(NSString*)str2 :(NSNumber*)str3 :(NSString*)str4 :(NSString*)str5 :(NSMutableArray*)arr :(NSDictionary*)detDic :(NSString*)str6
{
    
    BOOL fl=0;
    
    if(dataArrayUpButtonsIds)
    {
      
        
        
        for(NSString *str in dataArrayUpButtonsIds)
        {
            if( str1 && [str isEqualToString: str1 ])
            {
                fl=1;
            
                break;
            }
            
        }
        
      
     
        
        
        
    
    if(fl==1)
    {
        return;
        
    }
    }
    
    NSMutableArray *arraynames=[NSMutableArray array];
    NSMutableArray *arrayids=[NSMutableArray array];
    NSMutableArray *arrayStatus=[NSMutableArray array];
    NSMutableArray *arrayiscreate=[NSMutableArray array];
    NSMutableArray *arrayimages=[NSMutableArray array];
    NSMutableArray *arraytexts=[NSMutableArray array];
     NSMutableArray *arraycoachdetails=[NSMutableArray array];
  NSMutableArray *arrayteamSports=[NSMutableArray array];
    
    
    
    
    
    
    NSLog(@"str,str1,str2,str3,str4,str5=%@-%@-%@-%@-%@-%@",str,str1,str2,str3,str4,str5);
    
    [arraynames addObject:str];
    [arrayids addObject:str1];
    [arrayStatus addObject:str2];
    [arrayiscreate addObject:str3];
    [arrayimages addObject:str4];
    [arraytexts addObject:str5];
    [arraycoachdetails addObject:detDic];
    [arrayteamSports addObject:str6];
    
  //  NSLog(@"%@-%@-%@-%@-%@-%@",arraynames,arrayids,arrayStatus,arrayiscreate,arrayimages,arraytexts);
    
    [self addTeamListing:arraynames :arrayids:arrayStatus:arrayiscreate:arrayimages:arraytexts:arraycoachdetails:arrayteamSports];
    
    
    
    [appDelegate setUserDefaultValue:self.appDelegate.centerVC.dataArrayUpButtons ForKey:ARRAYNAMES];
    [appDelegate setUserDefaultValue:self.appDelegate.centerVC.dataArrayUpButtonsIds ForKey:ARRAYIDS];
    [appDelegate setUserDefaultValue:self.appDelegate.centerVC.dataArrayUpInvites ForKey:ARRAYSTATUS];
    [appDelegate setUserDefaultValue:self.appDelegate.centerVC.dataArrayUpTeamSports ForKey:ARRAYTEAMSPORTS];

    
     [appDelegate setUserDefaultValue:self.appDelegate.centerVC.dataArrayUpCoachDetails ForKey:ARRAYCOACHDETAILS];
    if([appDelegate.aDef objectForKey:ARRAYIMAGES])
    [appDelegate setUserDefaultValue:[(NSArray*)[appDelegate.aDef objectForKey:ARRAYIMAGES] arrayByAddingObjectsFromArray:arrayimages] ForKey:ARRAYIMAGES];
    else
     [appDelegate setUserDefaultValue:arrayimages ForKey:ARRAYIMAGES];
    
    [appDelegate setUserDefaultValue:self.appDelegate.centerVC.dataArrayUpIsCreated ForKey:ARRAYISCREATES];
    [appDelegate setUserDefaultValue:self.appDelegate.centerVC.dataArrayUpTexts ForKey:ARRAYTEXTS];
    
    
    
    if(arr)
    {
        ///////////////
        [self resetPostView];
        [self.updatetextvw resignFirstResponder];
        
        
        self.updatetablehideview.hidden=YES;
        self.updateuphideview.hidden=YES;
        
        
        self.tableviewupvw.hidden=YES;
        self.tableupview1.hidden=YES;
        [self.commentTextVw resignFirstResponder];
        
        isProcessingLikeOrUnlike=0;
      
        
        
        
        
        ///////////////
        
        loadStatus=1;
        [self hideMiddleActivityInd];
      
        
        
             int tag=(appDelegate.centerVC.dataArrayUpButtons.count-1);
        
        if(arr.count>0)
        {
        [self setDataFromDelegateArray:tag :arr];
        [self reloadDataFromDelegateArray:arr];
        }
        
        
        
            [self showParticularTeam:tag];
    }
}





-(void)updateArrayByDeletingOneTeam:(NSString*)str
{
    NSMutableArray *arraynames=nil;
    NSMutableArray *arrayids=nil;
    NSMutableArray *arrayStatus=nil;
    NSMutableArray *arrayiscreate=nil;
    NSMutableArray *arrayimages=nil;
    NSMutableArray *arraytexts=nil;
    NSMutableArray *arraycoachdetails=nil;
    NSMutableArray *arrayteamSports=nil;
    
  //  [self addTeamListing:arraynames :arrayids:arrayStatus:arrayiscreate:arrayimages:arraytexts];
    
    int i=0;
    int f=0;
    
    for(NSString *str1 in self.appDelegate.centerVC.dataArrayUpButtonsIds)
    {
        if([str isEqualToString:str1])
        {
            
            
            [self.dataArrayUpButtons removeObjectAtIndex:i];
            [self.dataArrayUpButtonsIds removeObjectAtIndex:i];
            [self.dataArrayUpInvites removeObjectAtIndex:i];
            [self.dataArrayUpTeamSports removeObjectAtIndex:i];
            [self.dataArrayUpCoachDetails removeObjectAtIndex:i];
            [self.dataArrayUpIsCreated removeObjectAtIndex:i];
            [self.dataArrayUpImages removeObjectAtIndex:i];
            if([appDelegate.aDef objectForKey:ARRAYIMAGES])
            {
                NSMutableArray *marr=[[appDelegate.aDef objectForKey:ARRAYIMAGES] mutableCopy];
                [marr removeObjectAtIndex:i];
                
                [appDelegate setUserDefaultValue:marr  ForKey:ARRAYIMAGES];
            }
            
            [self.dataArrayUpTexts removeObjectAtIndex:i];
            f=1;
            
            arraynames=[NSMutableArray array];
           arrayids=[NSMutableArray array];
           arrayStatus=[NSMutableArray array];
           arrayiscreate=[NSMutableArray array];
            arrayimages=[NSMutableArray array];
            arraytexts=[NSMutableArray array];
              arraycoachdetails=[NSMutableArray array];
            arrayteamSports=[NSMutableArray array];
            break;
        }
        i++;
    }
    
    if(f==1)
    {
    if((dataArrayUpButtons && dataArrayUpButtonsIds && dataArrayUpInvites && dataArrayUpCoachDetails && dataArrayUpIsCreated && dataArrayUpImages && dataArrayUpTexts && dataArrayUpTeamSports) && (dataArrayUpButtons.count>0 && dataArrayUpButtonsIds.count>0 && dataArrayUpInvites.count>0 && dataArrayUpCoachDetails.count>0 && dataArrayUpIsCreated.count>0 && dataArrayUpImages.count>0 && dataArrayUpTexts.count>0 && dataArrayUpTeamSports.count>0))
    {
    [appDelegate setUserDefaultValue:self.appDelegate.centerVC.dataArrayUpButtons ForKey:ARRAYNAMES];
    [appDelegate setUserDefaultValue:self.appDelegate.centerVC.dataArrayUpButtonsIds ForKey:ARRAYIDS];
    [appDelegate setUserDefaultValue:self.appDelegate.centerVC.dataArrayUpInvites ForKey:ARRAYSTATUS];
     [appDelegate setUserDefaultValue:self.appDelegate.centerVC.dataArrayUpTeamSports ForKey:ARRAYTEAMSPORTS];
        
     [appDelegate setUserDefaultValue:self.appDelegate.centerVC.dataArrayUpCoachDetails ForKey:ARRAYCOACHDETAILS];
    if([appDelegate.aDef objectForKey:ARRAYIMAGES])
        [appDelegate setUserDefaultValue:[(NSArray*)[appDelegate.aDef objectForKey:ARRAYIMAGES] arrayByAddingObjectsFromArray:arrayimages] ForKey:ARRAYIMAGES];
    else
        [appDelegate setUserDefaultValue:arrayimages ForKey:ARRAYIMAGES];
    
    [appDelegate setUserDefaultValue:self.appDelegate.centerVC.dataArrayUpIsCreated ForKey:ARRAYISCREATES];
    [appDelegate setUserDefaultValue:self.appDelegate.centerVC.dataArrayUpTexts ForKey:ARRAYTEXTS];
    
    }
    else
    {
        self.dataArrayUpButtons=nil;
        self.dataArrayUpButtonsIds=nil;
        self.dataArrayUpInvites=nil;
        self.dataArrayUpTeamSports=nil;
        self.dataArrayUpCoachDetails=nil;
        self.dataArrayUpIsCreated=nil;
        self.dataArrayUpImages=nil;
        self.dataArrayUpTexts=nil;
        
        
        
        
        
        
        [appDelegate removeUserDefaultValueForKey:ARRAYNAMES];
           [appDelegate removeUserDefaultValueForKey:ARRAYIDS];
           [appDelegate removeUserDefaultValueForKey:ARRAYSTATUS];
        [appDelegate removeUserDefaultValueForKey:ARRAYTEAMSPORTS];
        [appDelegate removeUserDefaultValueForKey:ARRAYCOACHDETAILS];
           [appDelegate removeUserDefaultValueForKey:ARRAYIMAGES];
           [appDelegate removeUserDefaultValueForKey:ARRAYISCREATES];
           [appDelegate removeUserDefaultValueForKey:ARRAYTEXTS];
    }
    
    
    
        [self addTeamListing:arraynames :arrayids:arrayStatus:arrayiscreate:arrayimages:arraytexts:arraycoachdetails:arrayteamSports];
    }

    if(f==1)
    {
         int tag=0;
        if([self.allpostdataDic objectForKey:str])
            [self.allpostdataDic removeObjectForKey:str];
        
        
        
        if(i==lastSelectedTeam)
        {
            [self resetPostView];
            [self.updatetextvw resignFirstResponder];
            
            
            self.updatetablehideview.hidden=YES;
            self.updateuphideview.hidden=YES;
            
            
            self.tableviewupvw.hidden=YES;
            self.tableupview1.hidden=YES;
            [self.commentTextVw resignFirstResponder];
            
            isProcessingLikeOrUnlike=0;
            loadStatus=1;
            [self hideMiddleActivityInd];
            
            
              if((dataArrayUpButtons && dataArrayUpButtonsIds && dataArrayUpInvites && dataArrayUpCoachDetails && dataArrayUpIsCreated && dataArrayUpImages && dataArrayUpTexts && dataArrayUpTeamSports) && (dataArrayUpButtons.count>0 && dataArrayUpButtonsIds.count>0 && dataArrayUpInvites.count>0 && dataArrayUpCoachDetails.count>0 && dataArrayUpIsCreated.count>0 && dataArrayUpImages.count>0 && dataArrayUpTexts.count>0 && dataArrayUpTeamSports.count>0))
              {
            [self showParticularTeam:tag];
              }
            else
                lastSelectedTeam=0;
        }
        else if(i<lastSelectedTeam)
        {
              if((dataArrayUpButtons && dataArrayUpButtonsIds && dataArrayUpInvites && dataArrayUpCoachDetails && dataArrayUpIsCreated && dataArrayUpImages && dataArrayUpTexts && dataArrayUpTeamSports) && (dataArrayUpButtons.count>0 && dataArrayUpButtonsIds.count>0 && dataArrayUpInvites.count>0 && dataArrayUpCoachDetails.count>0 && dataArrayUpIsCreated.count>0 && dataArrayUpImages.count>0 && dataArrayUpTexts.count>0 && dataArrayUpTeamSports.count>0))
              {
           lastSelectedTeam--;
                  
                   [self showParticularTeam:lastSelectedTeam];
              }
            else
                lastSelectedTeam=0;
        }
        else if(i>lastSelectedTeam)
        {
            if((dataArrayUpButtons && dataArrayUpButtonsIds && dataArrayUpInvites && dataArrayUpCoachDetails && dataArrayUpIsCreated && dataArrayUpImages && dataArrayUpTexts && dataArrayUpTeamSports) && (dataArrayUpButtons.count>0 && dataArrayUpButtonsIds.count>0 && dataArrayUpInvites.count>0 && dataArrayUpCoachDetails.count>0 && dataArrayUpIsCreated.count>0 && dataArrayUpImages.count>0 && dataArrayUpTexts.count>0 && dataArrayUpTeamSports.count>0))
            {
                 [self showParticularTeam:lastSelectedTeam];
            }
            else
                lastSelectedTeam=0;
        }
    
    
    
    ///////////////
    
    
    
   
      
    
  
    
    
    
    ///////////////
    }
}



-(void)showMiddleActivityInd
{
    self.activityindicatormiddle.hidden=NO;
    [self.activityindicatormiddle startAnimating];
}
-(void)hideMiddleActivityInd
{
     self.activityindicatormiddle.hidden=YES;
    [self.activityindicatormiddle stopAnimating];
}

-(void)setDataFromDelegateArray:(int)index :(NSMutableArray*) arr
{
  
    [self.allpostdataDic setObject:arr forKey:[self.dataArrayUpButtonsIds objectAtIndex:index]];
  
}

-(void)reloadDataFromDelegateArray:(NSMutableArray*) arr
{
   
    
    self.dataArray=arr;
    
    
    if(dataArray && dataArray.count)
      self.wallblankconvw.hidden=YES;
    else
      self.wallblankconvw.hidden=NO;
    
    
    [self.tableView reloadData];
    
  /*  //// AD...iAd
    self.adBanner.delegate = self;
    self.adBanner.alpha = 0.0;
    self.canDisplayBannerAds=YES;
    ////*/
}


-(void)showParticularTeam:(int)index
{
    
    
    if(index==0)
         [self upBtappedNew:index];
    else
        [self upBtappedNew:index];
    
    
   pageControl.currentPage=index;
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    /*[self loadScrollViewWithPage:page - 1];
     [self loadScrollViewWithPage:page];
     [self loadScrollViewWithPage:page + 1];*/
    // update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * index;
    frame.origin.y = 0;
    pageControlUsed = YES;
    [scrollView scrollRectToVisible:frame animated:YES];
    // Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    
        
}

-(void)parseAndSaveTeam:(NSArray*)admindetails :(NSArray*)playerdetails :(NSArray*)teamdetails :(NSArray*)frnddetails :(NSArray*)primarydetails
{
  //  NSLog(@"ARR6COACH1");
    NSMutableArray *arraynames=[NSMutableArray array];
    NSMutableArray *arrayids=[NSMutableArray array];
    NSMutableArray *arrayStatus=[NSMutableArray array];
    NSMutableArray *arraycoachdetails=[NSMutableArray array];
    NSMutableArray *arrayiscreate=[NSMutableArray array];
    NSMutableArray *arrayimages=[NSMutableArray array];
    NSMutableArray *arraytexts=[NSMutableArray array];
    NSMutableArray *arrayteamSports=[NSMutableArray array];
    
    for(NSDictionary* dic in teamdetails)
    {
        [arraynames addObject:[dic objectForKey:@"team_name"]];
        [arrayteamSports addObject:[dic objectForKey:@"team_sport"]];
        [arrayids addObject:[NSString stringWithFormat:@"%@", [dic objectForKey:@"team_id"] ]];
        [arrayStatus addObject:@"Accept"];
        [arrayiscreate addObject:[NSNumber numberWithInt:1 ]];
        NSDictionary *cDic=[[NSDictionary alloc] initWithObjectsAndKeys: [dic objectForKey:CREATORNAME],CREATORNAME ,[dic objectForKey:CREATOREMAIL],CREATOREMAIL, [dic objectForKey:CREATORPHNO],CREATORPHNO, nil];
        //   NSLog(@"ARR6Dic=%@",cDic);
        [arraycoachdetails addObject:cDic];
        
        [arrayimages addObject:[ NSString stringWithFormat:@"%@%@", TEAM_LOGO_URL,[dic objectForKey:@"team_logo"] ]];
        [arraytexts addObject:[dic objectForKey:@"status_update"]];
        
        
        
        
        NSArray *teamUpdateListing=[dic objectForKey:@"team_update_listing"];
        
        for(NSDictionary *diction in teamUpdateListing)
        {
            
            Invite *invite=(Invite*)  [self objectOfTypeInvite:INVITE forTeam:[NSString stringWithFormat:@"%@", [dic objectForKey:@"team_id"] ] forUpdate:3 forUpdateId:[diction objectForKey:@"update_id"] andManObjCon:self.managedObjectContext];
            if(!invite)
            {
                invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
                
                
                
                invite.teamName=[dic objectForKey:@"team_name"];
                invite.teamId=[NSString stringWithFormat:@"%@", [dic objectForKey:@"team_id"] ];
                invite.message=[diction objectForKey:@"status_update"];//[NSString stringWithFormat:@"New status update for %@ team",invite.teamName];
                invite.type=[NSNumber numberWithInt:3];
                
                invite.postId=[diction objectForKey:@"update_id"];
                invite.inviteStatus=[NSNumber numberWithInt:1/*[[diction objectForKey:@"view_status"] integerValue]*/];
                
                
                int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                
                NSDate *datetime=   [[appDelegate.dateFormatFullOriginalComment dateFromString:[diction objectForKey:@"adddate"]] dateByAddingTimeInterval:difftime]  ;
                invite.datetime=datetime;
                invite.senderProfileImage=[ [NSString alloc] initWithFormat:@"%@%@", TEAM_LOGO_URL,[dic objectForKey:@"team_logo"] ];
                
            }
            
            
            
            
        }
        
        [appDelegate saveContext];
    }
    
    
    
    for(NSDictionary* dic in admindetails)
    {
        
        int flag=1;
        
        NSLog(@"team_nameplayer=%@",[dic objectForKey:@"team_name"]);
        
        for(NSString *str in arrayids)
        {
            if([str isEqualToString: [NSString stringWithFormat:@"%@", [dic objectForKey:@"team_id"] ] ])
            {
                flag=0;
            }
        }
        
        if(flag==1)
        {
            if(!([[dic objectForKey:@"invites"] isEqualToString:NORESPONSE] || [[dic objectForKey:@"invites"] isEqualToString:PENDING] || [[dic objectForKey:@"invites"] isEqualToString:@"Decline"]))
            {
                
                [arraynames addObject:[dic objectForKey:@"team_name"]];
                [arrayteamSports addObject:[dic objectForKey:@"team_sport"]];
                [arrayids addObject:[NSString stringWithFormat:@"%@", [dic objectForKey:@"team_id"] ]];
                [arrayStatus addObject:[dic objectForKey:@"invites"]];
                [arrayiscreate addObject:[NSNumber numberWithInt:1 ]];
                NSDictionary *cDic=[[NSDictionary alloc] initWithObjectsAndKeys: [dic objectForKey:CREATORNAME],CREATORNAME ,[dic objectForKey:CREATOREMAIL],CREATOREMAIL, [dic objectForKey:CREATORPHNO],CREATORPHNO, [dic objectForKey:@"creator_id"],@"creator_id",nil];
                
                //     NSLog(@"ARR6Dic=%@",cDic);
                [arraycoachdetails addObject:cDic];
                [arrayimages addObject:[ NSString stringWithFormat:@"%@%@", TEAM_LOGO_URL,[dic objectForKey:@"team_logo"] ]];
                [arraytexts addObject:@""/*[dic objectForKey:@"status_update"]*/];
                
                ///////////////////////////////////////////////////////////////////////
                
                
                
                
                
                
                Invite *invite=(Invite*)  [self objectOfTypeInvite:INVITE forTeam:[NSString stringWithFormat:@"%@", [dic objectForKey:@"team_id"] ] forUpdate:14 andManObjCon:self.managedObjectContext];
                
                
                
                
                if(!invite)
                {
                    invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
                    invite.teamName=[dic objectForKey:@"team_name"];
                    invite.teamId=[NSString stringWithFormat:@"%@", [dic objectForKey:@"team_id"] ];
                    invite.creatorEmail=[dic objectForKey:@"creator_email"];
                    if([dic objectForKey:TEAMSPORTKEY])
                        invite.teamSport=[dic objectForKey:TEAMSPORTKEY];
                    invite.creatorName=[dic objectForKey:@"creator_name"];
                    invite.creatorPhno=[dic objectForKey:@"creator_phno"];
                    
                    /*if([dic objectForKey:@"invite_text"] && (![[dic objectForKey:@"invite_text"] isEqualToString:@""]))
                        invite.message=[dic objectForKey:@"invite_text"];*///[NSString stringWithFormat:@"Team invite from %@",invite.teamName];
                    invite.type=[NSNumber numberWithInt:14];
                    
                    /////////////
                    
                    if([[dic objectForKey:@"invites"] isEqualToString:@"Accept"])
                    {
                        invite.inviteStatus=[[NSNumber alloc] initWithInteger:1];
                    }
                    else  if([[dic objectForKey:@"invites"] isEqualToString:@"Decline"])
                    {
                        invite.inviteStatus=[[NSNumber alloc] initWithInteger:2];
                    }
                    else
                    {
                        invite.inviteStatus=[[NSNumber alloc] initWithInteger:3];
                    }
                    
                    if([dic objectForKey:@"adddate"])
                    {
                        int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                        
                        NSDate *datetime=   [[appDelegate.dateFormatFullOriginalComment dateFromString:[dic objectForKey:@"adddate"]] dateByAddingTimeInterval:difftime]  ;
                        
                        
                        invite.datetime=datetime;
                        
                    }
                    
                    
                    if([dic objectForKey:@"team_logo"])
                        invite.senderProfileImage=[dic objectForKey:@"team_logo"];
                    else
                        invite.senderProfileImage=@"";
                    
                    
                    invite.userId= [dic objectForKey:@"creator_id"];
                    
                    
                    //////////////////
                    
                    
                    [appDelegate saveContext];
                }
                
                
                
                
                
               // [appDelegate saveContext];
                
            }
            
        }
    }

    
    
    
    

    
    
    
    
    
    for(NSDictionary* dic in playerdetails)
    {
        
        int flag=1;
        
        NSLog(@"team_nameplayer=%@",[dic objectForKey:@"team_name"]);
        
        NSDictionary *coachDic=nil;
        int i=0;
        for(NSString *str in arrayids)
        {
            if([str isEqualToString: [NSString stringWithFormat:@"%@", [dic objectForKey:@"team_id"] ] ])
            {
                flag=0;
                
                coachDic=[arraycoachdetails objectAtIndex:i];
                
                break;
            }
            
            i++;
        }
        
        
        
        
        
        if(flag==1 || ([coachDic objectForKey:@"creator_id"]))
        {
        if(!([[dic objectForKey:@"invites"] isEqualToString:NORESPONSE] || [[dic objectForKey:@"invites"] isEqualToString:PENDING]))
        {
           
            
            if(flag==1)
            {
            [arraynames addObject:[dic objectForKey:@"team_name"]];
            [arrayteamSports addObject:[dic objectForKey:@"team_sport"]];
            [arrayids addObject:[NSString stringWithFormat:@"%@", [dic objectForKey:@"team_id"] ]];
            [arrayStatus addObject:[dic objectForKey:@"invites"]];
            [arrayiscreate addObject:[NSNumber numberWithInt:0 ]];
             NSDictionary *cDic=[[NSDictionary alloc] initWithObjectsAndKeys: [dic objectForKey:CREATORNAME],CREATORNAME ,[dic objectForKey:CREATOREMAIL],CREATOREMAIL, [dic objectForKey:CREATORPHNO],CREATORPHNO, nil];
            
        //     NSLog(@"ARR6Dic=%@",cDic);
            [arraycoachdetails addObject:cDic];
            [arrayimages addObject:[ NSString stringWithFormat:@"%@%@", TEAM_LOGO_URL,[dic objectForKey:@"team_logo"] ]];
            [arraytexts addObject:[dic objectForKey:@"status_update"]];
            }
            else
            {
                NSMutableDictionary *mdic=[coachDic mutableCopy];
                
                [mdic setObject:[dic objectForKey:@"invites"] forKey:PLAYERINVITESTATUS];
                
                [arraycoachdetails replaceObjectAtIndex:i withObject:mdic];
            }
            
            ///////////////////////////////////////////////////////////////////////
            
            
            
            
            
            
            Invite *invite=(Invite*)  [self objectOfTypeInvite:INVITE forTeam:[NSString stringWithFormat:@"%@", [dic objectForKey:@"team_id"] ] forUpdate:0 andManObjCon:self.managedObjectContext];
            
            
            
            
            if(!invite)
            {
                invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
                invite.teamName=[dic objectForKey:@"team_name"];
                invite.teamId=[NSString stringWithFormat:@"%@", [dic objectForKey:@"team_id"] ];
                invite.creatorEmail=[dic objectForKey:@"creator_email"];
                if([dic objectForKey:TEAMSPORTKEY])
                    invite.teamSport=[dic objectForKey:TEAMSPORTKEY];
                invite.creatorName=[dic objectForKey:@"creator_name"];
                invite.creatorPhno=[dic objectForKey:@"creator_phno"];
                
                if([dic objectForKey:@"invite_text"] && (![[dic objectForKey:@"invite_text"] isEqualToString:@""]))
                invite.message=[dic objectForKey:@"invite_text"];//[NSString stringWithFormat:@"Team invite from %@",invite.teamName];
                invite.type=[NSNumber numberWithInt:0];
                
                /////////////
                
                if([[dic objectForKey:@"invites"] isEqualToString:@"Accept"])
                {
                    invite.inviteStatus=[[NSNumber alloc] initWithInteger:1];
                }
                else  if([[dic objectForKey:@"invites"] isEqualToString:@"Decline"])
                {
                    invite.inviteStatus=[[NSNumber alloc] initWithInteger:2];
                }
                else
                {
                    invite.inviteStatus=[[NSNumber alloc] initWithInteger:3];
                }
                
                if([dic objectForKey:@"adddate"])
                {
                int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                
                NSDate *datetime=   [[appDelegate.dateFormatFullOriginalComment dateFromString:[dic objectForKey:@"adddate"]] dateByAddingTimeInterval:difftime]  ;
                
                
                invite.datetime=datetime;
                
                }
                
                
                if([dic objectForKey:@"team_logo"])
                    invite.senderProfileImage=[dic objectForKey:@"team_logo"];
                else
                    invite.senderProfileImage=@"";
                
                
               
                
                
                //////////////////
                
                
                [appDelegate saveContext];
            }

            
            
            
            
            
            
            
            
            
            
            
            
            //////////////////////////////////////////////////////////////////////////
            NSArray *teamUpdateListing=[dic objectForKey:@"team_update_listing"];
            
            
                
            
            NSDate *replyDate=nil;
            @autoreleasepool {
                
            
            if([dic objectForKey:@"Invite_rply_Date"])
            {
                replyDate=[self dateFromGMTStringDate:[dic objectForKey:@"Invite_rply_Date"]];
            }
            
            }
            
            for(NSDictionary *diction in teamUpdateListing)
            {
                NSDate *comparedatetime= nil;
                @autoreleasepool {
                    
                
                int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                
                comparedatetime=   [[appDelegate.dateFormatFullOriginalComment dateFromString:[diction objectForKey:@"adddate"]] dateByAddingTimeInterval:difftime]  ;
                }
                
                if(replyDate!=nil)
                {
                    if(comparedatetime!=nil)
                    {
                if([comparedatetime compare:replyDate]!=NSOrderedAscending)
                {
                    
                }
                else
                {
                    continue;
                }
                    }
                }
                    
               
                Invite *invite=(Invite*)  [self objectOfTypeInvite:INVITE forTeam:[NSString stringWithFormat:@"%@", [dic objectForKey:@"team_id"] ] forUpdate:3 forUpdateId:[diction objectForKey:@"update_id"] andManObjCon:self.managedObjectContext];
                if(!invite)
                {
                    invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
                
                
                    @autoreleasepool {
                        
                    
                invite.teamName=[dic objectForKey:@"team_name"];
                invite.teamId=[NSString stringWithFormat:@"%@", [dic objectForKey:@"team_id"] ];
                    invite.message=[diction objectForKey:@"status_update"];//[NSString stringWithFormat:@"New status update for %@ team",invite.teamName];
                invite.type=[NSNumber numberWithInt:3];
                    
                    invite.postId=[diction objectForKey:@"update_id"];
                    invite.inviteStatus=[NSNumber numberWithInt:[[diction objectForKey:@"view_status"] integerValue]];
                    
                    
                    int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                    
                    NSDate *datetime=   [[appDelegate.dateFormatFullOriginalComment dateFromString:[diction objectForKey:@"adddate"]] dateByAddingTimeInterval:difftime]  ;
                    invite.datetime=datetime;
                    invite.senderProfileImage=[ [NSString alloc] initWithFormat:@"%@%@", TEAM_LOGO_URL,[dic objectForKey:@"team_logo"] ];
                    }
                
                }
              
                
                
                
            }
            
              [appDelegate saveContext];
            
        }
        
    }
    }
    
   
    for(NSDictionary* dic in primarydetails)
    {
        
        int flag=1;
        
        NSDictionary *coachDic=nil;
        int i=0;
       
      
        
        for(NSString *str in arrayids)
        {
            if([str isEqualToString: [NSString stringWithFormat:@"%@", [dic objectForKey:@"team_id"] ] ])
            {
                flag=0;
                coachDic=[arraycoachdetails objectAtIndex:i];
                
                break;
                
            }
              i++;
        }
        
        
        if(flag==1 || ([coachDic objectForKey:@"creator_id"]))
        {
        
        if(!([[dic objectForKey:@"invites"] isEqualToString:NORESPONSE] || [[dic objectForKey:@"invites"] isEqualToString:PENDING]))
        {
            
            
            if(flag==1)
            {
            [arraynames addObject:[dic objectForKey:@"team_name"]];
            [arrayteamSports addObject:[dic objectForKey:@"team_sport"]];
            [arrayids addObject:[NSString stringWithFormat:@"%@", [dic objectForKey:@"team_id"] ]];
            [arrayStatus addObject:[dic objectForKey:@"invites"]];
            [arrayiscreate addObject:[NSNumber numberWithInt:0 ]];
            NSDictionary *cDic=[[NSDictionary alloc] initWithObjectsAndKeys: [dic objectForKey:CREATORNAME],CREATORNAME ,[dic objectForKey:CREATOREMAIL],CREATOREMAIL, [dic objectForKey:CREATORPHNO],CREATORPHNO,[dic objectForKey:@"player_id"],@"player_id",[dic objectForKey:@"player_name"],@"player_name", nil];
            
            //     NSLog(@"ARR6Dic=%@",cDic);
            [arraycoachdetails addObject:cDic];
            [arrayimages addObject:[ NSString stringWithFormat:@"%@%@", TEAM_LOGO_URL,[dic objectForKey:@"team_logo"] ]];
            [arraytexts addObject:[dic objectForKey:@"status_update"]];
            }
            else
            {
                NSMutableDictionary *mdic=[coachDic mutableCopy];
                
                [mdic setObject:[dic objectForKey:@"invites"] forKey:PLAYERINVITESTATUS];
                
                [arraycoachdetails replaceObjectAtIndex:i withObject:mdic];
            }

            ////////////////////////////////
        
            
            
            Invite *invite=(Invite*)  [self objectOfTypeInvite:INVITE forTeam:[NSString stringWithFormat:@"%@", [dic objectForKey:@"team_id"] ] forUpdate:0 andManObjCon:self.managedObjectContext];
            
            
            
            
            if(!invite)
            {
                invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
                invite.teamName=[dic objectForKey:@"team_name"];
                invite.teamId=[NSString stringWithFormat:@"%@", [dic objectForKey:@"team_id"] ];
                invite.creatorEmail=[dic objectForKey:@"creator_email"];
                if([dic objectForKey:TEAMSPORTKEY])
                    invite.teamSport=[dic objectForKey:TEAMSPORTKEY];
                invite.creatorName=[dic objectForKey:@"creator_name"];
                invite.creatorPhno=[dic objectForKey:@"creator_phno"];
                
                if([dic objectForKey:@"invite_text"] && (![[dic objectForKey:@"invite_text"] isEqualToString:@""]))
                    invite.message=[dic objectForKey:@"invite_text"];//[NSString stringWithFormat:@"Team invite from %@",invite.teamName];
                invite.type=[NSNumber numberWithInt:0];
                
                invite.userId=[dic objectForKey:@"user_id"];
                
                
                /////////////
                if([dic objectForKey:@"adddate"])
                {
                    int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                    
                    NSDate *datetime=   [[appDelegate.dateFormatFullOriginalComment dateFromString:[dic objectForKey:@"adddate"]] dateByAddingTimeInterval:difftime]  ;
                    
                    
                    invite.datetime=datetime;
                }
              
                
                
                
                if([[dic objectForKey:@"invites"] isEqualToString:@"Accept"])
                {
                    invite.inviteStatus=[[NSNumber alloc] initWithInteger:1];
                }
                else  if([[dic objectForKey:@"invites"] isEqualToString:@"Decline"])
                {
                    invite.inviteStatus=[[NSNumber alloc] initWithInteger:2];
                }
                else  
                {
                    invite.inviteStatus=[[NSNumber alloc] initWithInteger:3];
                }
                
                
                if([dic objectForKey:@"team_logo"])
                    invite.senderProfileImage=[dic objectForKey:@"team_logo"];
                else
                    invite.senderProfileImage=@"";
                
               
                
                
                //////////////////
                [appDelegate saveContext];
            }

            
            
            
            
            
            
            
            
            
            //////////////////////////////////
            NSDate *replyDate=nil;
            @autoreleasepool {
                
                
                if([dic objectForKey:@"Invite_rply_Date"])
                {
                    replyDate=[self dateFromGMTStringDate:[dic objectForKey:@"Invite_rply_Date"]];
                }
                
            }

            NSArray *teamUpdateListing=[dic objectForKey:@"team_update_listing"];
            
            for(NSDictionary *diction in teamUpdateListing)
            {
                
                NSDate *comparedatetime= nil;
                @autoreleasepool {
                    
                    
                    int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                    
                    comparedatetime=   [[appDelegate.dateFormatFullOriginalComment dateFromString:[diction objectForKey:@"adddate"]] dateByAddingTimeInterval:difftime]  ;
                }
                
                if(replyDate!=nil)
                {
                    if(comparedatetime!=nil)
                    {
                        if([comparedatetime compare:replyDate]!=NSOrderedAscending)
                        {
                            
                        }
                        else
                        {
                            continue;
                        }
                    }
                }
                
                
                Invite *invite=(Invite*)  [self objectOfTypeInvite:INVITE forTeam:[NSString stringWithFormat:@"%@", [dic objectForKey:@"team_id"] ] forUpdate:3 forUpdateId:[diction objectForKey:@"update_id"] andManObjCon:self.managedObjectContext];
                if(!invite)
                {
                    invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
                    
                    
                    
                    invite.teamName=[dic objectForKey:@"team_name"];
                    invite.teamId=[NSString stringWithFormat:@"%@", [dic objectForKey:@"team_id"] ];
                    invite.message=[diction objectForKey:@"status_update"];//[NSString stringWithFormat:@"New status update for %@ team",invite.teamName];
                    invite.type=[NSNumber numberWithInt:3];
                    
                    invite.postId=[diction objectForKey:@"update_id"];
                    invite.inviteStatus=[NSNumber numberWithInt:[[diction objectForKey:@"view_status"] integerValue]];
                    
                    
                    int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                    
                    NSDate *datetime=   [[appDelegate.dateFormatFullOriginalComment dateFromString:[diction objectForKey:@"adddate"]] dateByAddingTimeInterval:difftime]  ;
                    invite.datetime=datetime;
                    invite.senderProfileImage=[ [NSString alloc] initWithFormat:@"%@%@", TEAM_LOGO_URL,[dic objectForKey:@"team_logo"] ];
                    
                }
                
                
                
                
            }
            
            [appDelegate saveContext];
            
        }
        
    }
    }

    
    
    
    for(NSDictionary* dic in frnddetails)
    {
        /*int f=1;
        
        if([[dic objectForKey:@"team_details"] isKindOfClass:[NSArray class]])
            f=0;
        
        if(f)
        {*/
        NSDictionary *teamDetails=[dic objectForKey:@"team_details"];

        
        
        if([teamDetails respondsToSelector:@selector(allKeys)])
        
        {
        if(teamDetails.allKeys.count>0)
        {
        int flag=1;
        
        
        
        for(NSString *str in arrayids)
        {
            if([str isEqualToString: [NSString stringWithFormat:@"%@", [teamDetails objectForKey:@"team_id"] ] ])
            {
                flag=0;
            }
        }
        
        if(flag==1)
        {
        if(!([[dic objectForKey:@"status"] isEqualToString:NORESPONSE] || [[dic objectForKey:@"status"] isEqualToString:PENDING]))
        {
            
            [arraynames addObject:[teamDetails objectForKey:@"team_name"]];
            [arrayteamSports addObject:[teamDetails objectForKey:@"team_sport"]];
            [arrayids addObject:[NSString stringWithFormat:@"%@", [teamDetails objectForKey:@"team_id"] ]];
            [arrayStatus addObject:[dic objectForKey:@"status"]];
            [arrayiscreate addObject:[NSNumber numberWithInt:0 ]];
            
            
            NSNumber *frresstatus=nil;
            
            if( [[dic objectForKey:@"status"] isEqualToString:@"Accept"])
            {
                frresstatus=[[NSNumber alloc] initWithBool:1];
            }
            else
            {
                frresstatus=[[NSNumber alloc] initWithBool:0];
            }
            
            
            
            NSDictionary *cDic=[[NSDictionary alloc] initWithObjectsAndKeys:frresstatus,SECONDARYUSERSENDERID,nil];//WithObjectsAndKeys: [dic objectForKey:CREATORNAME],CREATORNAME ,[dic objectForKey:CREATOREMAIL],CREATOREMAIL, [dic objectForKey:CREATORPHNO],CREATORPHNO, nil];
            
            //     NSLog(@"ARR6Dic=%@",cDic);
            [arraycoachdetails addObject:cDic];
            [arrayimages addObject:[ NSString stringWithFormat:@"%@%@", TEAM_LOGO_URL,[teamDetails objectForKey:@"team_logo"] ]];
            [arraytexts addObject:[teamDetails objectForKey:@"status_update"]];
            
            
            /////////////////////////
            /*
            Invite *invite=(Invite*)  [self objectOfTypeInvite:INVITE forTeam:[NSString stringWithFormat:@"%@", [teamDetails objectForKey:@"team_id"] ] forUpdate:4 andManObjCon:self.managedObjectContext];
            
          
            
            
            if(!invite)
            {
                invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
                invite.teamName=[teamDetails objectForKey:@"team_name"];
                invite.teamId=[NSString stringWithFormat:@"%@", [teamDetails objectForKey:@"team_id"] ];
                invite.creatorEmail=@"";//[dic objectForKey:@"creator_email"];
                invite.creatorName=@"";//[dic objectForKey:@"creator_name"];
                invite.creatorPhno=@"";//[dic objectForKey:@"creator_phno"];
                invite.message=[NSString stringWithFormat:@"Friend invite from %@",invite.teamName];
                
                
                NSArray *namearr= [[dic objectForKey:@"message"] componentsSeparatedByString:APPURL];
                
                NSString *contentMessage=@"A Friend";
                
                if(namearr.count>1)
                    contentMessage= [namearr objectAtIndex:1];
                
                
                NSString *sendername=[contentMessage stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                
                NSString *body=nil;
                if(![sendername isEqualToString:@""])
                {
                    // body= [[NSString alloc] initWithFormat:@"%@ has invited you to join his team, %@, wall on SidelineHeroes.\n\n%@",sendername,invite.teamName,APPURL];
                    body= [NSString stringWithFormat:@"Hi,\n\nI'd like to invite you to join team, %@ on SidelineHeroes (%@)\n\n%@",invite.teamName,APPURL,sendername];
                }
                else
                {
                    //body=  [[NSString alloc] initWithFormat:@"A Coach has invited you to join his team, %@, wall on SidelineHeroes.\n\n%@",invite.teamName,APPURL];
                    body=  [NSString stringWithFormat:@"Hi,\n\nI'd like to invite you to join team, %@ on SidelineHeroes (%@)",invite.teamName,APPURL];
                }
                
                invite.contentMessage=body;
                body=nil;
                
                NSLog(@"2====%@",[dic objectForKey:@"status"]);
                
                
              
                
                
                 if([[dic objectForKey:@"status"] isEqualToString:@"Accept"])
                 {
                 invite.inviteStatus=[[NSNumber alloc] initWithInteger:1];
                 }
                 else
                 {
                 invite.inviteStatus=[[NSNumber alloc] initWithInteger:2];
                 }
                
                
                
                invite.type=[NSNumber numberWithInt:4];
                invite.postId=[dic objectForKey:@"id"];
                invite.userId=[dic objectForKey:SECONDARYUSERSENDERID];
                ////////
                int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                
                NSDate *datetime=   [[appDelegate.dateFormatFullOriginalComment dateFromString:[dic objectForKey:@"datetime"]] dateByAddingTimeInterval:difftime]  ;
                
                
                invite.datetime=datetime;
                
              
                
                invite.senderName=[dic objectForKey:@"user_name"];
                invite.senderProfileImage=[dic objectForKey:PROFILEIMAGE];
                ////////
                
                
                  NSLog(@"managedObjectContext1=%@----%@------%@",appDelegate,appDelegate.managedObjectContext,self.managedObjectContext);
           //     [appDelegate saveContext];
            }

            */
            
            
            
            
           
            //////////////////////////
            /*
             NSArray *teamUpdateListing=[teamDetails objectForKey:@"team_update_listing"];
            
             for(NSDictionary *diction in teamUpdateListing)
             {
             
             Invite *invite=(Invite*)  [self objectOfTypeInvite:INVITE forTeam:[NSString stringWithFormat:@"%@", [teamDetails objectForKey:@"team_id"] ] forUpdate:3 forUpdateId:[diction objectForKey:@"update_id"] andManObjCon:self.managedObjectContext];
             if(!invite)
             {
             invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
             
             
             
             invite.teamName=[teamDetails objectForKey:@"team_name"];
             invite.teamId=[NSString stringWithFormat:@"%@", [teamDetails objectForKey:@"team_id"] ];
             invite.message=[diction objectForKey:@"status_update"];//[NSString stringWithFormat:@"New status update for %@ team",invite.teamName];
             invite.type=[NSNumber numberWithInt:3];
             
             invite.postId=[diction objectForKey:@"update_id"];
             invite.inviteStatus=[NSNumber numberWithInt:[[diction objectForKey:@"view_status"] integerValue]];
             
             
             int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
             
             NSDate *datetime=   [[appDelegate.dateFormatFullOriginalComment dateFromString:[diction objectForKey:@"adddate"]] dateByAddingTimeInterval:difftime]  ;
             invite.datetime=datetime;
             invite.senderProfileImage=[ [NSString alloc] initWithFormat:@"%@%@", TEAM_LOGO_URL,[teamDetails objectForKey:@"team_logo"] ];
             
             }
             
             
             
             
             }
            */
            
            
            NSLog(@"managedObjectContext2=%@----%@------%@",appDelegate,appDelegate.managedObjectContext,self.managedObjectContext);
             
             [appDelegate saveContext];
            
            
            
            
            
            
        }
        
    }
    
        
    }
    }
    //}
    }
    
    
    
    
    
    
    
    
    
    if(arraynames.count>0 && arrayids.count>0 && arrayStatus.count>0 && arraycoachdetails.count>0 && arrayiscreate.count>0 && arrayimages.count>0 && arraytexts.count>0 && arrayteamSports>0)
    {
        //[appDelegate.centerVC addTeamListing:arraynames :arrayids:arrayStatus];
        
        // [appDelegate.centerVC upBtapped:appDelegate.centerVC.buttonfirstinscroll];
        
        [appDelegate setUserDefaultValue:arraynames ForKey:ARRAYNAMES];
        [appDelegate setUserDefaultValue:arrayids ForKey:ARRAYIDS];
        [appDelegate setUserDefaultValue:arrayStatus ForKey:ARRAYSTATUS];
        [appDelegate setUserDefaultValue:arrayteamSports ForKey:ARRAYTEAMSPORTS];
        [appDelegate setUserDefaultValue:arraycoachdetails ForKey:ARRAYCOACHDETAILS];
        [appDelegate setUserDefaultValue:arrayimages ForKey:ARRAYIMAGES];
        [appDelegate setUserDefaultValue:arrayiscreate ForKey:ARRAYISCREATES];
        [appDelegate setUserDefaultValue:arraytexts ForKey:ARRAYTEXTS];
    }
}

-(void)fireBackgroundExecuting                 //19th.................june
{
    // _bgexec_actInd.hidden=NO;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSLog(@"starting background execution.....");
    
}


-(void)finishBackgroundExecuting                   //19th.................june
{
    //_bgexec_actInd.hidden=YES;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    NSLog(@"finishing background execution.....");
    
}

- (IBAction)saveBtnAction:(id)sender {
    
    [libraryFolder addAssetsGroupAlbumWithName:@"Sportsly" resultBlock:^(ALAssetsGroup *group)           // CREATE CUSTOM ALBUM
     {
         NSLog(@"*****************Adding Folder:'Sportsly', success: %s", group.editable ? "Success" : "**********************Already created: Not Success");
         //        Handler(group,nil);
     } failureBlock:^(NSError *error)
     {
         NSLog(@"Error: Adding on Folder");
     }];
    
    
    
    void (^completion)(NSURL *, NSError *) = ^(NSURL *assetURL, NSError *error)
    {
        if (error)
        {
            NSLog(@"%s: Write the image data to the assets library (camera roll): %@",
                  __PRETTY_FUNCTION__, [error localizedDescription]);
        }
        
    };
    
    
    void (^failure)(NSError *) = ^(NSError *error)
    {
        if (error) NSLog(@"%s: Failed to add the asset to the custom photo album: %@",
                         __PRETTY_FUNCTION__, [error localizedDescription]);
    };
    
    
    [library saveImage:_hiddenimgvw.image toAlbum:@"Sportsly" completion:completion failure:failure  ] ; //SAVE IMAGE TO CUSTOM ALBUM
    [self.view makeToast:@"Save" duration:3.0 position:CSToastPositionCenter];
    
}



-(void)requestFirst:(int)index
{
    self.wallblankconvw.hidden=YES;
    
    
        loadStatus=0;
    
    if(self.dataArray==nil)
        [self showMiddleActivityInd];
    
    NSString *teamId=   [self.dataArrayUpButtonsIds objectAtIndex:index];
    
    
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
    [command setObject:@"" forKey:@"invites"];
    [command setObject:teamId forKey:@"team_id"];
    [command setObject:@"" forKey:@"view"];
     [command setObject:@"" forKey:@"Primary_UserID"];
    
    
    self.isFinishData=0;
    self.start=0;
    self.limit=[DEFAULTLIMIT longLongValue];
    
    @autoreleasepool {
        
    
    [command setObject:[NSString stringWithFormat:@"%lli",self.start] forKey:@"start"];
     [command setObject:[NSString stringWithFormat:@"%lli",self.limit] forKey:@"limit"];
    }
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    
    SingleRequest *sinReq=[[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:TEAMINVITESTATUSLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
        self.sinReq2=sinReq;
    
    [self.storeCreatedRequests addObject:self.sinReq2];
    sinReq.notificationName=TEAMINVITESTATUS;
    sinReq.userInfo=[NSNumber numberWithInt:index];
    [sinReq startRequest];
    
    

}






-(void)requestForTableViewFooterLoading:(NSNumber*)index
{
    loadStatus=0;
    
  /*  if(self.dataArray==nil)
        [self showMiddleActivityInd];*/
    
    NSString *teamId=   [self.dataArrayUpButtonsIds objectAtIndex:[index intValue]];
    
    
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
   // [command setObject:@"" forKey:@"invites"];
    [command setObject:teamId forKey:@"team_id"];
    
  
    //self.limit+=[DEFAULTLIMIT longLongValue];
    
    @autoreleasepool {
        
        
        [command setObject:[NSString stringWithFormat:@"%lli",self.start] forKey:@"start"];
        [command setObject:[NSString stringWithFormat:@"%lli",self.limit] forKey:@"limit"];
    }

    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    
    SingleRequest *sinReq=[[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:POSTLISTINGLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
    self.sinReq4=sinReq;
    
    [self.storeCreatedRequests addObject:self.sinReq4];
    sinReq.notificationName=POSTLISTING;
    sinReq.userInfo=[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithLongLong:self.start],@"StartIndex",index,@"Index", nil ];
    [sinReq startRequest];
    
    
    
}

- (void)postListingUpdated:(NSNotification *)notif
{
    loadStatus=1;
    [self hideMiddleActivityInd];
    
    /*if(isFromPullToRefresh)
    {
        isFromPullToRefresh=0;
        [pull finishedLoading];
    }*/
    
    
    SingleRequest *sReq=(SingleRequest*)[notif object];
    
    @autoreleasepool {
        
        
        if([sReq.notificationName isEqualToString:POSTLISTING])
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
                           
                          //  isProcessingLikeOrUnlike=0;
                            self.wallfootervwgreydot.hidden=NO;
                            [self.wallfootervwactivind stopAnimating];
                            
                            long long int indexStart=[[(NSDictionary*)[sReq userInfo] objectForKey:@"StartIndex"] longLongValue];
                            
                            if(indexStart!=self.start)
                            {
                                return;
                            }
                            
                               self.start+=self.limit;
                            /////////////////////
                            int index=[[(NSDictionary*)[sReq userInfo] objectForKey:@"Index"] intValue];
                            
                          NSMutableArray *mar= [self loadListingPostDetails:sReq.responseString];
                            
                            [(NSMutableArray*)[self.allpostdataDic objectForKey:[self.dataArrayUpButtonsIds objectAtIndex:index]] addObjectsFromArray:mar];
                           // [self setDataFromDelegateArray:index :mar];
                            
                            if(index==lastSelectedTeam)
                                [self reloadDataFromDelegateArray:[self.allpostdataDic objectForKey:[self.dataArrayUpButtonsIds objectAtIndex:index]]];
                            /////////////////////
                            
                            
                        }
                        else
                        {
                           // [self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
                            self.isFinishData=1;
                            
                            self.wallfootervwgreydot.hidden=NO;
                            [self.wallfootervwactivind stopAnimating];
                        }
                        
                        
                        
                        
                        
                        
                        
                        
                    }
                    else
                    {
                          self.isFinishData=1;
                        //  NSString *message=CONNFAILMSG;
                        //Change in status updated  [self showAlertMessage:message title:@""];
                        // [self showHudAlert:message];
                        // [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
                    }
                    
                }
                else
                {
                      self.isFinishData=1;
                    //  NSString *message=CONNFAILMSG;
                    //Change in status updated  [self showAlertMessage:message title:@""];
                    // [self showHudAlert:message];
                    // [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
                }
                
            }
            else
            {
                  self.isFinishData=1;
                //     NSString *message=CONNFAILMSG;
                //Change in status updated     [self showAlertMessage:message title:@""];
                // [self showHudAlert:message];
                // [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
            }
        }
    }
}

-(NSMutableArray*)loadListingPostDetails:(NSString*)responses
{
    
    ///////Added by Debattam
    /*self.dataArray=[[NSMutableArray alloc] init];
     [dataArray release];*/
    
        NSMutableArray *marr=[[NSMutableArray alloc] init];
    
    NSString *str=responses;
    
    if (str)
    {
        //__block NSDictionary *res=nil;
        SBJsonParser *parser=[[SBJsonParser alloc] init];
        
        id res = [parser objectWithString:str];
        
        //    //    NSLog(<#NSString *format, ...#>)
        //        /*if([res isAu])
        //        {
        //
        //        }*/
        //        dispatch_queue_t highqueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        //
        //        dispatch_sync(highqueue, ^{
        //
        //
        //            res = [str JSONValue];
        //            NSLog(@"1.--%i-----%i",str.retainCount,res.retainCount);
        //
        //
        //        });
        //
        //          NSLog(@"2.--%i-----%i",str.retainCount,res.retainCount);
        //       // NSLog(@"%@--%@",res,str);
        
        if ([res isKindOfClass:[NSDictionary class]])
        {
            NSDictionary* aDict = (NSDictionary*) res;
            // aDict=[aDict objectForKey:@"responseData"];
            
            
            if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
            {
                
                
                aDict=[aDict objectForKey:@"response"];
               // aDict=[aDict objectForKey:@"team_details"];
                NSArray   *array=[aDict objectForKey:@"post_details"];
                
                
            
                
                /*appDelegate.arrItems=*///marr;
                
                
                
                
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
                    dvca.number_of_likes=[likecountstr longLongValue];
                    NSMutableArray *marray=[[diction objectForKey:@"comment_user_details"] mutableCopy];
                    dvca.commentdetailsarr=marray;
                    
                    dvca.number_of_comment=[commentcountstr longLongValue];
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
                    [marr addObject:dvca];
                }
                
                
                
            }
        }
    }
    
    
    return marr;
}

-(void)addTeamListing:(NSMutableArray*)arr :(NSMutableArray*)arr1 :(NSMutableArray*)arr2 :(NSMutableArray*)arr3 :(NSMutableArray*)arr4 :(NSMutableArray*)arr5 :(NSMutableArray*)arr6 :(NSMutableArray*)arr7
{
  //  NSLog(@"ARR6COACH==%@",arr6);
    
    
    
    
   
    
    if(!(dataArrayUpButtons && dataArrayUpButtonsIds && dataArrayUpInvites && dataArrayUpCoachDetails && dataArrayUpIsCreated && dataArrayUpImages && dataArrayUpTexts && dataArrayUpTeamSports))
    {
       
    //self.dataArrayUpButtons=[[NSMutableArray alloc] initWithObjects:@"Bercelona",@"Internal Basketball",@"Chess Club",@"Cricket",@"Football",@"Baseball",@"MotionUI",@"htcSense",@"TimespaceUI",@"Kolkata", nil];
      
       NSMutableArray *marr1=[[NSMutableArray alloc] initWithArray:arr];
        self.dataArrayUpButtons=marr1;
        
         marr1=[[NSMutableArray alloc] initWithArray:arr1];
        self.dataArrayUpButtonsIds=marr1;
        
        marr1=[[NSMutableArray alloc] initWithArray:arr2];
        self.dataArrayUpInvites=marr1;
        
        marr1=[[NSMutableArray alloc] initWithArray:arr7];
        self.dataArrayUpTeamSports=marr1;
        
        marr1=[[NSMutableArray alloc] initWithArray:arr6];
        self.dataArrayUpCoachDetails=marr1;
        
         marr1=[[NSMutableArray alloc] initWithArray:arr3];
        self.dataArrayUpIsCreated=marr1;
        
        self.dataArrayUpImages=[self getImageInfoArrayThroughConvert:arr4];
      
           marr1=[[NSMutableArray alloc] initWithArray:arr5];
        self.dataArrayUpTexts=marr1;
        
      
    }
    else
    {
        [dataArrayUpButtons addObjectsFromArray:arr];
        [dataArrayUpButtonsIds addObjectsFromArray:arr1];
        [dataArrayUpInvites addObjectsFromArray:arr2];
        [dataArrayUpTeamSports addObjectsFromArray:arr7];
        [dataArrayUpCoachDetails addObjectsFromArray:arr6];
        [dataArrayUpIsCreated addObjectsFromArray:arr3];
        [dataArrayUpImages addObjectsFromArray:[self getImageInfoArrayThroughConvert:arr4]];
        [dataArrayUpTexts addObjectsFromArray:arr5];
    }
    
    int m=0;
    for(int i=0;i<self.dataArrayUpInvites.count;i++ )
   {
       if([[self.dataArrayUpInvites objectAtIndex:i] isEqualToString:@"Accept"])
       {
           m=1;
           break;
       }
   }
    
    
    PushByInviteFriendVC *efVC=(PushByInviteFriendVC*)[appDelegate.navigationControllerAddAFriend.viewControllers objectAtIndex:0];
    
    
   if( dataArrayUpButtons.count>0)
   {
       
       self.teamtopview.hidden=YES;////ch
    self.teamlistdivider.hidden=YES;//Change-NO
       self.newloginpopupview.hidden=YES;
        self.newloginpopupviewbackground.hidden=YES;
       [appDelegate removeUserDefaultValueForKey:NEWLOGIN];
       self.tableView.hidden=NO;
      
       self.firsttimeFirstvw.hidden=YES;   /// 13/02/2015
       
       self.firsttimesecondvw.hidden=YES;
       [[NSNotificationCenter defaultCenter] postNotificationName:TOTALTEAMLISTUPDATED object:self];
       
       self.postlabel.hidden=NO;
         self.postNewContainerView.hidden=NO;
        [self moveTableViewBasisOnPostPermission:1];
       self.menuupscrollview.hidden=NO;
       self.postBackground.hidden=NO;
       self.updatebackgr.hidden=NO;
       
       if(m==1)
       {
       efVC.plusbuttoninvitefriendbt.hidden=NO;
       efVC.isExistTeam=1;
       }
       
         self.horidividervw.hidden=NO;
       
      // self.topContainerView.hidden=NO;
       
       self.scrollView.hidden=NO;
       self.pageControl.hidden=NO;
       [self.view bringSubviewToFront:self.topContainerView];
   }
    else
    {
         //appDelegate.centerViewController.coachupdatevw.hidden=YES;
         [self setTopBarText];
        self.wallblankconvw.hidden=YES;
        self.redbackindicator.hidden=YES;
           self.redbackindicator1.hidden=YES;
        self.rednextindicator.hidden=YES;
        self.rednextindicator1.hidden=YES;
         //self.blankwalllabel.hidden=NO;
        
       // self.firsttimeFirstvw.hidden=NO; /// 13/02/2015
        
          self.firsttimesecondvw.hidden=NO;
        self.teamtopview.hidden=YES;
        self.teamlistdivider.hidden=YES;
          self.tableView.hidden=YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:TOTALTEAMLISTUPDATED object:self];
        
        self.postNewContainerView.hidden=YES;
         [self moveTableViewBasisOnPostPermission:0];
            self.postlabel.hidden=YES;
        
         self.menuupscrollview.hidden=YES;
        self.postBackground.hidden=YES;
        self.updatebackgr.hidden=YES;
        
          efVC.plusbuttoninvitefriendbt.hidden=YES;
        efVC.isExistTeam=0;
        
          self.horidividervw.hidden=YES;
        
        
        self.scrollView.hidden=YES;
        self.pageControl.hidden=YES;
    }
    
    
    
    
     [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview) ];
    ////////////////////////////////////////////////////////
    kNumberOfPages=dataArrayUpButtons.count;
    
    
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < kNumberOfPages; i++) {
        [controllers addObject:[NSNull null]];
    }
    self.arrayControllers = controllers;
    controllers=nil;
	
    // a page is the width of the scroll view
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * kNumberOfPages, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
   
	
    pageControl.numberOfPages = kNumberOfPages;
  //  pageControl.currentPage = 0;
	
    // pages are created on demand
    // load the visible page
    // load the page on either side to avoid flashes when the user starts scrolling
    
    for (unsigned i = 0; i < kNumberOfPages; i++) {
        [self loadScrollViewWithPage:i];
       
    }
   

    
    
    
 ////////////////////////////////////////////////////////
    
     /*[self.menuupscrollview.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    
    float x=0;
    float y=1;
    float btag=0;
    int j=0;
    for(NSString* str in dataArrayUpButtons)
    {
        UIView *btvw=[[UIView alloc] init];
        btvw.backgroundColor=appDelegate.topBarRedColor;
        
        UIButton *bt=[UIButton buttonWithType:UIButtonTypeCustom];
        [bt.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
        bt.titleLabel.textAlignment=UITextAlignmentLeft;
        [bt setTitleColor:self.whitecolor forState:UIControlStateNormal];
        [bt setTitle:str forState:UIControlStateNormal];
        bt.tag=btag++;
        
        if(bt.tag==0)
            self.buttonfirstinscroll=bt;
        [bt addTarget:self action:@selector(upBtapped:) forControlEvents:UIControlEventTouchUpInside];
        CGSize s=[str sizeWithFont:bt.titleLabel.font constrainedToSize:CGSizeMake(190, 14)];
        
       
        
        if((x+s.width+20)>(240*y))
        {
            
            x=(y*240);
            y++;
        }
        
        
        bt.frame=CGRectMake(0,0, (s.width+20), 24);
          btvw.frame=CGRectMake(x,0, (s.width+20), 24);
        
          [self.menuupscrollview addSubview:btvw];
        [btvw addSubview:bt];
        btvw.clipsToBounds=NO;
      
        
        
        x+=(s.width+20);
       
        if(!(j>=self.dataArrayUpButtons.count))
        {
            
            int f=0;
            
            
            if((j+1)<self.dataArrayUpButtons.count)
            {
                NSString *nextstr=[self.dataArrayUpButtons objectAtIndex:(j+1)];
                
                
                
                CGSize s1=[nextstr sizeWithFont:bt.titleLabel.font constrainedToSize:CGSizeMake(190, 14)];
             
                
                
                if((x+s1.width+20)>(240*y))
                {
                    f=1;
                   
                }
            }
            
            
            
            if(f==0)
            {
                if((j+1)<self.dataArrayUpButtons.count)
                {
                    UIView *divider=[[UIView alloc] initWithFrame:CGRectMake((btvw.frame.size.width-1), 0, 1, 24)];
                    divider.backgroundColor=appDelegate.veryLightGrayColor;
                    [btvw addSubview:divider];
                    [btvw bringSubviewToFront:bt];
                }
            }
        }
        j++;
    }
    
    self.menuupscrollview.contentSize=CGSizeMake((y*240), 24);
    */
    
    
    
    
    
}



- (void)loadScrollViewWithPage:(int)page {
    
    if (page < 0) return;
    if (page >= kNumberOfPages) return;
	
    // replace the placeholder if necessary
    PageControlExampleViewControl *controller = [_arrayControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null]) {
        controller = [[PageControlExampleViewControl alloc] initWithNibName:@"PageControllerExample" bundle:nil];
      
        controller.sportsName=[self.dataArrayUpTeamSports objectAtIndex:page];
          controller.pageNumberLabel.text=controller.sportsName;
        [controller loadImage:controller.sportsName];
        NSLog(@"loadScrollViewWithPage=%@",controller.sportsName);
        [_arrayControllers replaceObjectAtIndex:page withObject:controller];
       
    }
    else
    {
         controller.sportsName=[self.dataArrayUpTeamSports objectAtIndex:page];
          controller.pageNumberLabel.text=controller.sportsName;
        [controller loadImage:controller.sportsName];
    }
	
    // add the controller's view to the scroll view
    if (nil == controller.view.superview) {
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        
        [scrollView addSubview:controller.view];
    }
     controller=nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    
    if([sender isEqual:self.scrollView])
    {
    if (pageControlUsed) {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
	}
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    /*[self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];*/
	
    // A possible optimization would be to unload the views+controllers which are no longer visible
    
    
    //[self changePage:pageControl];
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
/*- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView1
{
    if([scrollView1 isEqual:self.scrollView] )
    
    {
    
    pageControlUsed = NO;
    
     [self upBtappedNew:pageControl.currentPage];
    }
}*/

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView1
{
    if([scrollView1 isEqual:self.scrollView])
        
    {
        
        pageControlUsed = NO;
        
        [self upBtappedNew:pageControl.currentPage];
    }
}

- (IBAction)changePage:(id)sender
{
    int page = pageControl.currentPage;
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    /*[self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];*/
    // update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    pageControlUsed = YES;
    [scrollView scrollRectToVisible:frame animated:YES];
    // Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
 
    
    
    // [self upBtappedNew:page];
}


- (void)pullToRefreshViewShouldRefresh:(PullToRefreshView *)view;
{
    [self reloadTableData];
}


- (void)reloadTableData
{
    isFromPullToRefresh=1;
    [self requestFirst:lastSelectedTeam];
    //[self showParticularTeam:lastSelectedTeam];
}


-(void)upBtapped:(id)sender
{
    
    if(loadStatus==0)
    {
        return;
    }
    
    if(isProcessingLikeOrUnlike)
        return;
    
    
    
   
    
    
    NSLog(@"%i",[sender tag]);
    
    int tag=[sender tag];
    
    
    for(id v in self.menuupscrollview.subviews)
    {
        if([v isMemberOfClass:[UIView class]])
        {
            UIView *vw=(UIView*)v;
           
          
            
            
            UIButton *bt= nil;
           for(id viww in vw.subviews)
               if([viww isMemberOfClass:[UIButton class]])
            bt=(UIButton*)viww;//(UIButton*)v;
            
            
            if(tag==[bt tag])
            {
                CGPoint orgPoint= vw.frame.origin;
                CGFloat orgX=orgPoint.x;
                CGFloat flo=240;
                
                orgX=    orgX -((int)orgX % (int)flo);
                
                self.menuupscrollview.contentOffset=CGPointMake(orgX,orgPoint.y);
                
                if(orgX<240)
                {
                    self.redbackindicator.hidden=YES;
                       self.redbackindicator1.hidden=YES;
                }
                else if(orgX>=240)
                {
                      self.redbackindicator.hidden=NO;
                       self.redbackindicator1.hidden=NO;
                }
                
                if((orgX+240+10)> self.menuupscrollview.contentSize.width)
                {
                      self.rednextindicator.hidden=YES;
                    self.rednextindicator1.hidden=YES;
                }
                else
                {
                   self.rednextindicator.hidden=NO;
                    self.rednextindicator1.hidden=NO;
                }
                
                [bt setTitleColor:self.whitecolor forState:UIControlStateNormal];
                [bt.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
                bt.superview.backgroundColor=appDelegate.topBarRedColor;
                
                int previous=lastSelectedTeam;
                
                lastSelectedTeam=tag;
                
                [self resetPostView];
                
                if(  [[self.dataArrayUpInvites objectAtIndex:lastSelectedTeam] isEqualToString:@"Accept"])
                    
                    [self enablepost];
                else
                    [self disablepost];
                
                ///////////////////////set other things
                [self.updatetextvw resignFirstResponder];
                self.updateuphideview.hidden=YES;
                self.updatetablehideview.hidden=YES;
                
                
                if([[self.dataArrayUpIsCreated objectAtIndex:lastSelectedTeam] integerValue])
                {
                    self.updateplusbt.hidden=NO;
                      self.updatetextvw.editable=YES;
                    NSString *str=[[NSString alloc] initWithFormat:@"(%i chracters remaining)",(TOTALCHARACTERS-[[self.dataArrayUpTexts objectAtIndex:lastSelectedTeam] length])];
                    self.smsnumbertextl.text=str;
                    
                }
                else
                {
                     self.updateplusbt.hidden=YES;
                      self.updatetextvw.editable=NO;
                }
              //ch
                self.smsnumbertextl.hidden=YES;
               
                self.updatetextvw.text=[self textForUpdateField:[self.dataArrayUpTexts objectAtIndex:lastSelectedTeam] ];
               
                
             ImageInfo *im=   [self.dataArrayUpImages objectAtIndex:lastSelectedTeam];
                
                if(im.image)
                {
                self.teamlogoimaview.image=im.image;
                }
                else
                {
                   // NSLog(@"upBtappedImageURL=%@=%@",im.sourceURL,im.imageName);
                    
                self.teamlogoimaview.image=[UIImage imageNamed:@"no_image.png"];
                    im.notificationName=TEAMLOGOIMAGELOADED;
                    im.userInfo=[NSNumber numberWithInt:lastSelectedTeam];
                    
                    if(!im.isProcessing)
                    [im getImage];
                }
                
                
                ///////////////////////
                if(previous!=lastSelectedTeam)
                {
                    [self.allpostdataDic removeObjectForKey:[self.dataArrayUpButtonsIds objectAtIndex:lastSelectedTeam]];
                }
                if( [self.allpostdataDic objectForKey:[self.dataArrayUpButtonsIds objectAtIndex:lastSelectedTeam]])
                {
                    
                 
                    
                    self.dataArray= [self.allpostdataDic objectForKey:[self.dataArrayUpButtonsIds objectAtIndex:lastSelectedTeam]];
                    [self.tableView reloadData];
                }
                else
                {
                    self.dataArray=nil;
                    [self.tableView reloadData];
                    // [self sendRequestForTeamWall];
                    
                    [self requestFirst:lastSelectedTeam];
                }
                
                
               /* //// AD...iAd
                self.adBanner.delegate = self;
                self.adBanner.alpha = 0.0;
                self.canDisplayBannerAds=YES;
                ////
            */
            
            }
            else
            {
                [bt setTitleColor:self.whitecolor forState:UIControlStateNormal];
                [bt.titleLabel setFont:[UIFont systemFontOfSize:12]];
                bt.superview.backgroundColor=appDelegate.topBarRedColor;
            }
        }
    }
    
}


-(void)upBtappedNew:(int)indexNo
{
    
    if(loadStatus==0)
    {
        return;
    }
    
    if(isProcessingLikeOrUnlike)
        return;
    
    
    
    
    
    
    NSLog(@"%i",indexNo);
    
    int tag=indexNo;
    
    
   
    
               
                
                int previous=lastSelectedTeam;
                
                lastSelectedTeam=tag;
    
    
    [self setTopBarText];
    
                
                [self resetPostView];
                
                if(  [[self.dataArrayUpInvites objectAtIndex:lastSelectedTeam] isEqualToString:@"Accept"])
                    
                    [self enablepost];
                else
                    [self disablepost];
                
                ///////////////////////set other things
                [self.updatetextvw resignFirstResponder];
                self.updateuphideview.hidden=YES;
                self.updatetablehideview.hidden=YES;
                
                
                if([[self.dataArrayUpIsCreated objectAtIndex:lastSelectedTeam] integerValue])
                {
                    self.updateplusbt.hidden=NO;
                    self.updatetextvw.editable=YES;
                    NSString *str=[[NSString alloc] initWithFormat:@"(%i chracters remaining)",(TOTALCHARACTERS-[[self.dataArrayUpTexts objectAtIndex:lastSelectedTeam] length])];
                    self.smsnumbertextl.text=str;
                    
                }
                else
                {
                    self.updateplusbt.hidden=YES;
                    self.updatetextvw.editable=NO;
                }
                //ch
                self.smsnumbertextl.hidden=YES;
                
                self.updatetextvw.text=[self textForUpdateField:[self.dataArrayUpTexts objectAtIndex:lastSelectedTeam] ];
                
                
                ImageInfo *im=   [self.dataArrayUpImages objectAtIndex:lastSelectedTeam];
                
                if(im.image)
                {
                    self.teamlogoimaview.image=im.image;
                }
                else
                {
                    // NSLog(@"upBtappedImageURL=%@=%@",im.sourceURL,im.imageName);
                    
                    self.teamlogoimaview.image=[UIImage imageNamed:@"no_image.png"];
                    im.notificationName=TEAMLOGOIMAGELOADED;
                    im.userInfo=[NSNumber numberWithInt:lastSelectedTeam];
                    
                    if(!im.isProcessing)
                        [im getImage];
                }
                
                
                ///////////////////////
                if(previous!=lastSelectedTeam)
                {
                    [self.allpostdataDic removeObjectForKey:[self.dataArrayUpButtonsIds objectAtIndex:lastSelectedTeam]];
                }
                if( [self.allpostdataDic objectForKey:[self.dataArrayUpButtonsIds objectAtIndex:lastSelectedTeam]])
                {
                    
                    
                    
                    self.dataArray= [self.allpostdataDic objectForKey:[self.dataArrayUpButtonsIds objectAtIndex:lastSelectedTeam]];
                    [self.tableView reloadData];
                }
                else
                {
                    self.dataArray=nil;
                    [self.tableView reloadData];
                    // [self sendRequestForTeamWall];
                    
                    [self requestFirst:lastSelectedTeam];
                }
                
                
                
   /* //// AD...iAd
    self.adBanner.delegate = self;
    self.adBanner.alpha = 0.0;
    self.canDisplayBannerAds=YES;
    ////
    */
    
    
    
    
}



/*- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"scrollViewDidEndDragging");
}*/
/*- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSLog(@"scrollViewDidEndDecelerating");
    
   float orgX= self.menuupscrollview.contentOffset.x;
    
    if(orgX<240)
    {
        self.redbackindicator.hidden=YES;
           self.redbackindicator1.hidden=YES;
    }
    else if(orgX>=240)
    {
        self.redbackindicator.hidden=NO;
           self.redbackindicator1.hidden=NO;
    }
    
    if((orgX+240+10)> self.menuupscrollview.contentSize.width)
    {
        self.rednextindicator.hidden=YES;
        self.rednextindicator1.hidden=YES;
    }
    else
    {
        self.rednextindicator.hidden=NO;
        self.rednextindicator1.hidden=NO;
    }
}*/



-(void)sendRequestForTeamWall
{
 NSString *teamId=   [self.dataArrayUpButtonsIds objectAtIndex:lastSelectedTeam];
    
    
  
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
    [command setObject:@"" forKey:@"invites"];
    [command setObject:teamId forKey:@"team_id"];
    [command setObject:@"0" forKey:@"start"];
    [command setObject:DEFAULTLIMIT forKey:@"limit"];
    [command setObject:@"" forKey:@"view"];
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    
    
    [appDelegate sendRequestFor:TEAMINVITESTATUS from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
    
    
    
    
    
    
}

-(void)postUpdate:(NSString*)text
{
   
    
NSMutableDictionary *command = [NSMutableDictionary dictionary];
[command setObject:text forKey:@"status_update"];

[command setObject:[self.dataArrayUpButtonsIds objectAtIndex:lastSelectedTeam] forKey:@"team_id"];
SBJsonWriter *writer = [[SBJsonWriter alloc] init];


NSString *jsonCommand = [writer stringWithObject:command];


[self showHudView:@"Connecting..."];
[self showNativeHudView];
NSLog(@"RequestParamJSON=%@",jsonCommand);



[appDelegate sendRequestFor:UPDATEPOST from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];

}


-(void)setPostAvatarsImage:(UIImage*)image1 :(UIImage*)image2
{
    if(image1)
    {
    self.myavatar.image=image1;
    self.secondaryavatar.image=image2;
    }
    else
    {
        self.myavatar.image=self.noImage;
        self.secondaryavatar.image=self.noImage;
    }
}

-(void)resetPostView
{
    self.previewimavw.image=nil;
    [self showPostView:0];
    isSelectedVideo=0;
    isSelectedImage=0;
    self.currbodytext=nil;
    self.commentTextVw.text=@"";
    self.dataVideo=nil;
}


-(void)enablepost
{
 
    UIButton *bt =(UIButton*)[self.postbuttonscontainervw viewWithTag:1];
    
    bt.enabled=YES;
    
    bt =(UIButton*)[self.postbuttonscontainervw viewWithTag:2];
    
    bt.enabled=YES;
    
    self.postnormtextbt.enabled=YES;
    
    
    self.postlabel.hidden=NO;
      self.postNewContainerView.hidden=NO;
     [self moveTableViewBasisOnPostPermission:1];
    
}

-(void)disablepost
{
    UIButton *bt =(UIButton*)[self.postbuttonscontainervw viewWithTag:1];
    
    bt.enabled=NO;
    
    bt =(UIButton*)[self.postbuttonscontainervw viewWithTag:2];
    
    bt.enabled=NO;
    
    self.postnormtextbt.enabled=NO;
    
    
     self.postlabel.hidden=YES;
      self.postNewContainerView.hidden=YES;
     [self moveTableViewBasisOnPostPermission:0];
}

-(void)showPostView:(int)mode
{
    
    
    CGRect r=self.postmainview.frame;
    
    if(mode==0)
    {
        self.postedmaintopview.hidden=YES;
    }
    else if(mode==1)
    {
        self.cambt.hidden=NO;
        self.videobt.hidden=NO;
         self.postedmaintopview.hidden=NO;
        self.previewimavw.hidden=YES;
        self.crosspreviewbt.hidden=YES;
        self.denecmntb.frame=CGRectMake(self.denecmntb.frame.origin.x,(150-71),self.denecmntb.frame.size.width,self.denecmntb.frame.size.height);
        self.cancelcmntb.frame=CGRectMake(self.cancelcmntb.frame.origin.x,(150-71),self.cancelcmntb.frame.size.width,self.cancelcmntb.frame.size.height);
      //  self.divider2.frame=CGRectMake(0,(146-45),257,1);
          self.divider2.hidden=YES;
          self.activindicatorpost.frame=CGRectMake(self.activindicatorpost.frame.origin.x,(153-71),20,20);
        r.size.height=180-71;
    }
    else if(mode==2)
    {
        self.cambt.hidden=YES;
        self.videobt.hidden=YES;
         self.postedmaintopview.hidden=NO;
        self.previewimavw.hidden=NO;
        self.crosspreviewbt.hidden=NO;
        self.denecmntb.frame=CGRectMake(self.denecmntb.frame.origin.x,115,self.denecmntb.frame.size.width,self.denecmntb.frame.size.height);
         self.cancelcmntb.frame=CGRectMake(self.cancelcmntb.frame.origin.x,115,self.cancelcmntb.frame.size.width,self.cancelcmntb.frame.size.height);
      //  self.divider2.frame=CGRectMake(0,146,257,1);
       //   self.divider2.hidden=NO;
        self.activindicatorpost.frame=CGRectMake(self.activindicatorpost.frame.origin.x,118,20,20);
        r.size.height=180-32;
      //    [self hideHudView];
    }
    self.postmainview.frame=r;
    
    r=self.postedmaintopview.frame;
    r.size.height= self.postmainview.frame.origin.y+ self.postmainview.frame.size.height+4;
    self.postedmaintopview.frame=r;
    
    [self moveTableView:mode];
}


-(void)moveTableViewBasisOnPostPermission:(int)mode
{
    CGRect r=self.tableView.frame;
    float dH=0;
    if(self.isiPad)
    {
      //  dH=753;   //// iAd 8/05
        dH=753;
    }
    else
    {
    
         dH=277;
        
        if(appDelegate.isIphone5)
         dH+=88; //  dH+=88;     //// iAd 8/05
    }
    
    
    if(mode)
    {
        if (self.isiPad) {
            r.origin.y=29+51+10+20;
        }
        else
            r.origin.y=29+51+10;
        r.size.height=dH;
    }
    else
    {
        if (self.isiPad) {
            r.origin.y=54+20;
        }
        else
            r.origin.y=54;
        dH+=36;
        r.size.height=dH;
    }
    self.tableView.frame=r;
}

-(void)moveTableView:(int)mode
{
    CGRect r=self.tableView.frame;
    
    float dH=0;
    if(self.isiPad)
    {
      //  dH=753; //// iAd 8/05
        dH=753;
    }
    else
    {
        
        
        dH=277;
        
        if(appDelegate.isIphone5)
          dH+=88; // dH+=88;   //// iAd 8/05
    }
    
    /*float dH=277;
    
    if(appDelegate.isIphone5)
        dH+=88;*/
    
if(mode==0)
{
    if (self.isiPad) {
        r.origin.y=29+51+10+20;
    }
    else
        r.origin.y=29+51+10;
    r.size.height=dH;
    
    self.tableviewupvw.hidden=YES;
      self.tableupview1.hidden=YES;
    [self.commentTextVw resignFirstResponder];
}
else if(mode==1)
{
    if (self.isiPad) {
        r.origin.y=29+178+10-71+51+10+20;
        r.size.height=dH-(178+10-71);
    }
    else{
        r.origin.y=29+178+10-71+51+10;
        r.size.height=dH-(178+10-71);
    }
     self.tableviewupvw.hidden=NO;
       self.tableupview1.hidden=NO;
}
else if(mode==2)
{
    if (self.isiPad) {
        r.origin.y=29+178+10-32+51+10+20;
        r.size.height=dH-(178+10-32+20);
    }
    else{
        r.origin.y=29+178+10-32+51+10;
        r.size.height=dH-(178+10-32);
    }
     self.tableviewupvw.hidden=NO;
       self.tableupview1.hidden=NO;
}
    self.tableView.frame=r;
    self.tableviewupvw.frame=r;
}


- (IBAction)postbTapped:(id)sender
{
    int tag=[sender tag];
    
    
    if(tag==0)
    {
        [self.commentTextVw resignFirstResponder];
          [self takeImage];
    }
    else if(tag==1)
    {
        [self.commentTextVw resignFirstResponder];
          self.isShowTrainningVideoOption=1;
        [self takeVideo];
    }
    else if(tag==2)
    {
        if(isSelectedImage)
            isSelectedImage=0;
        
        if(isSelectedVideo)
            isSelectedVideo=0;
        
        self.previewimavw.image=nil;
        self.dataVideo=nil;
        [self showPostView:1];
    }
    else if(tag==3)
    {
        [self resetPostView];
    }
    else if(tag==4)
    {
        if((![self.commentTextVw.text isEqualToString:@""]) || self.previewimavw.hidden==NO)
        {
            NSMutableDictionary *command = [NSMutableDictionary dictionary];
            [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"user_id"];
            [command setObject:self.commentTextVw.text forKey:@"comment_text"];
              [command setObject:[self.dataArrayUpButtonsIds objectAtIndex:lastSelectedTeam] forKey:@"team_id"];
            
            
            SBJsonWriter *writer = [[SBJsonWriter alloc] init];
            
            
            NSString *jsonCommand = [writer stringWithObject:command];
            
            
        //    [self showHudView:@"Connecting..."];
            [self showActiveIndicatorOwnPost];
            [self showNativeHudView];
            NSLog(@"RequestParamJSON=%@",jsonCommand);
            
           
            if(isSelectedVideo==1)
                [self sendRequestForPost:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam",UIImageJPEGRepresentation(self.previewimavw.image,1.0),@"video_thumb",self.dataVideo,@"video", nil]];
            else if(isSelectedImage==1)
                [self sendRequestForPost:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam",UIImageJPEGRepresentation(self.previewimavw.image,1.0),@"image", nil]];
            /*else if(isSelectedVideo==1)
                [appDelegate sendRequestFor:POST from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam",self.dataVideo,@"video", nil]];*/
            else
                [self sendRequestForPost:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
        }
        else
        {
            [self showAlertMessage:@"Text can't be left blank."];
        }
    }
    
    
}



-(void)sendRequestForPost:(NSDictionary*)dic
{
   // NSString *str=POST;
    
    NSURL* url = [NSURL URLWithString:POSTLINK];
  ASIFormDataRequest *aRequest=  [[ASIFormDataRequest alloc] initWithURL:url] ;
    self.myFormRequest1=aRequest;
    [self.storeCreatedRequests addObject:self.myFormRequest1];
    
    
    [aRequest setShouldContinueWhenAppEntersBackground:YES];
    
    [aRequest setDelegate:self];
    [aRequest setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt: lastSelectedTeam ],@"Index", nil]];
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
    
    [aRequest startAsynchronous];
    
}


- (void)requestFinished:(ASIHTTPRequest *)request
{
	NSLog(@"Data Received in Connection Manager.... %@ ",[request responseString]);
     [self hideActiveIndicatorOwnPost];
    [self resetPostView];
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
                int index=[[[request userInfo] objectForKey:@"Index"] integerValue];
                
                [self requestFirst:index];
                
              /*int tag=lastSelectedTeam;
                for(id v in self.menuupscrollview.subviews)
                {
                    if([v isMemberOfClass:[UIButton class]])
                    {
                        UIButton *bt=(UIButton*)v;
                        if(tag==[v tag])
                        {
                            [bt setTitleColor:self.redcolor forState:UIControlStateNormal];
                            
                        }
                        else
                        {
                            [bt setTitleColor:self.darkgraycolor forState:UIControlStateNormal];
                        }
                    }
                }
                
                if(lastSelectedTeam==0)
                 [self upBtapped:appDelegate.centerVC.buttonfirstinscroll];
                else
                    [self upBtapped:[self.menuupscrollview viewWithTag:lastSelectedTeam]];*/
                
                
            //    [self showHudAlert:[aDict objectForKey:@"message"]];
              //  [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
                
                
            }
            else
            {
                [self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
            }
        }
    }

  
	
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
      [self hideActiveIndicatorOwnPost];
     // [self resetPostView];
//	NSLog(@"Error receiving data : %@ ",[request.error description]);
	//[self showAlertMessage:CONNFAILMSG];ChAfter
	
}



-(void)showActiveIndicatorOwnPost
{
    self.denecmntb.hidden=YES;
    self.cancelcmntb.hidden=YES;
    UIButton *bt=nil;
    self.postnormtextbt.enabled=NO;
    
    bt=(UIButton*)   [self.postbuttonscontainervw viewWithTag:1];
    bt.enabled=NO;
    
    bt=(UIButton*)   [self.postbuttonscontainervw viewWithTag:2];
    bt.enabled=NO;
    
    self.activindicatorpost.hidden=NO;
    [self.activindicatorpost startAnimating];
}

-(void)hideActiveIndicatorOwnPost
{
    self.denecmntb.hidden=NO;
    self.cancelcmntb.hidden=NO;
    UIButton *bt=nil;
      self.postnormtextbt.enabled=YES;
    
    bt=(UIButton*)   [self.postbuttonscontainervw viewWithTag:1];
    bt.enabled=YES;
    
    bt=(UIButton*)   [self.postbuttonscontainervw viewWithTag:2];
    bt.enabled=YES;
    
    self.activindicatorpost.hidden=YES;
    [self.activindicatorpost stopAnimating];
}

- (IBAction)upUserPostBTapped:(id)sender
{
    

    int tag=[sender tag];
    
    
   /* self.previewimavw.image=nil;
    isSelectedVideo=0;
    isSelectedImage=0;
    self.currbodytext=nil;
    self.commentTextVw.text=@"";
    self.dataVideo=nil;
    [self showPostView:1];*/


    
    /*if(tag==0)
    {
        CreatePostViewController *cVC=nil;
        if(  [[self.dataArrayUpInvites objectAtIndex:lastSelectedTeam] isEqualToString:@"Accept"])
        {
            cVC=[[CreatePostViewController alloc] initWithNibName:@"CreatePostViewController" bundle:nil];
            
            
            self.createPostVC=cVC;
            cVC.homeVC=self;
            cVC.teamName=[self.dataArrayUpButtons objectAtIndex:lastSelectedTeam];
            cVC.teamId=[self.dataArrayUpButtonsIds objectAtIndex:lastSelectedTeam];
            [self.navigationController pushViewController:cVC animated:YES];
            
            cVC=nil;
            
            
            
            
        }
        else
        {
            [self showAlertMessage:@"Access Denied." title:@""];
        }
        
    }
    else*/ if(tag==0 || tag==1)
    {
        CreatePostViewController *cVC=nil;
        if(  [[self.dataArrayUpInvites objectAtIndex:lastSelectedTeam] isEqualToString:@"Accept"])
        {
            cVC=[[CreatePostViewController alloc] initWithNibName:@"CreatePostViewController" bundle:nil];
            
            
            self.createPostVC=cVC;
            cVC.homeVC=self;
            cVC.teamName=[self.dataArrayUpButtons objectAtIndex:lastSelectedTeam];
            cVC.teamId=[self.dataArrayUpButtonsIds objectAtIndex:lastSelectedTeam];
            
            UINavigationController *navv=[[UINavigationController alloc] initWithRootViewController:cVC];
            /*[UIView beginAnimations:nil context:NULL];
            
            [UIView setAnimationDuration:0.75];
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.appDelegate.centerViewController.navigationController.view cache:NO];*/
            //[self.appDelegate.centerViewController.navigationController pushViewController:navv animated:NO];
            self.isModallyPresentFromCenterVC=1;
            [self showModal:navv];
           // [UIView commitAnimations];
            
           
            
            navv=nil;
            cVC=nil;
            
            
            
            
        }
        else
        {
            [self showAlertMessage:@"Access Denied." title:@""];
        }
      
    }
    else if(tag==2)
    {
      
    }

}


- (void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{
    isSelectedVideo=1;
    [self dismissModal];
      [appDelegate setHomeView];
    [self showPostView:2];
}
- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker
{
    [super mediaPickerDidCancel:mediaPicker];
    
    [appDelegate setHomeView];
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)  picker
{
    
    [super imagePickerControllerDidCancel:picker];
    
 
    self.camActionSheet=nil;
    
    [appDelegate setHomeView];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissModal];
    [appDelegate setHomeView];
    NSString *choice = [self.camActionSheet buttonTitleAtIndex:0];
     if ([choice isEqualToString:@"Take Video"] || [choice isEqualToString:@"Choose From Library "])
    {
        @autoreleasepool {
            
        
        NSURL *outputurl=nil;
   
        NSURL *videoURL=[info objectForKey:UIImagePickerControllerMediaURL];
        outputurl=videoURL;
        self.dataVideo=[NSData dataWithContentsOfURL:outputurl];
           self.previewimavw.image=[self getThumnailForVideo:[info objectForKey:UIImagePickerControllerMediaURL]];
        
        
        isSelectedVideo=1;
        [self showPostView:2];
        
       
        
        NSURL *aUrl=  [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"]];
        NSLog(@"VideoPath=%@",aUrl);
        self.dataVideo=[NSData dataWithContentsOfURL:aUrl];

       ///////////////
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:@"socialvideo.mp4"];
        [[NSFileManager defaultManager] removeItemAtPath:savedImagePath error:nil];
        
      __block NSData *videoData=nil;
        
        
        AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:videoURL options:nil];
        
        NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
          [self showHudView:@"Converting..."];
        if ([compatiblePresets containsObject:AVAssetExportPresetMediumQuality])
            
        {
            
            AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
            
           outputurl=[NSURL fileURLWithPath:savedImagePath];
            
            exportSession.outputURL = outputurl;
            
            exportSession.outputFileType = AVFileTypeMPEG4;
            
           /* CMTime start = CMTimeMakeWithSeconds(1.0, 600);
            
            CMTime duration = CMTimeMakeWithSeconds(3.0, 600);
            
            CMTimeRange range = CMTimeRangeMake(start, duration);
            
            exportSession.timeRange = range;*/
          
             
            
            [exportSession exportAsynchronouslyWithCompletionHandler:^{
                
             
                switch ([exportSession status]) {
                        
                    
                     
                        
                    /*case AVAssetExportSessionStatusFailed:
                        NSLog(@"Export failed: %@", [[exportSession error] localizedDescription]);
                        
                        break;
                        
                    case AVAssetExportSessionStatusCancelled:
                        
                        NSLog(@"Export canceled");
                        
                        break;
                    case AVAssetExportSessionStatusExporting:
                        
                        NSLog(@"Export exporting");
                        
                        break;*/
                    case AVAssetExportSessionStatusCompleted:
                        
                        NSLog(@"Export completed");
                       /* videoData=[NSData dataWithContentsOfURL:outputurl];
                        self.dataVideo=videoData;*/
                                            
                        
                        
                     //  [self finishedVideoConvert];
                           [self hideHudView];
                        
                    
                        break;
                        
                        
                    default:
                        NSLog(@"Export Default");
                         // [self finishedVideoConvert];
                           [self hideHudView];
                        break;
                        
                }
                
                
            }];
            
        }
        else
        {
          // [self finishedVideoConvert];
              [self hideHudView]; 
            
            
            
            
        }
        
        
        
        
        
      
        
        
        
        
        
        
        
       ///////////////
    }
        info=nil;
        self.camActionSheet=nil;
    }
    else 
    {
        isSelectedImage=1;
        
        @autoreleasepool {
            
        
            UIImage *ima1=nil;
            
            
              if([info objectForKey:UIImagePickerControllerEditedImage])
            ima1=[[UIImage alloc] initWithData:UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerEditedImage], 0.1)];
             else
            ima1=[[UIImage alloc] initWithData:UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], 0.1)];
            
       /* if([info objectForKey:UIImagePickerControllerEditedImage])
            self.previewimavw.image=[self getImage:[info objectForKey:UIImagePickerControllerEditedImage] isWidth:1 length:296   ];
        else
            self.previewimavw.image=[self getImage:[info objectForKey:UIImagePickerControllerOriginalImage] isWidth:1 length:296   ];*/
            self.previewimavw.image=ima1;
            
            ima1=nil;
        }
        [self dismissModal];
        [appDelegate setHomeView];
        [self showPostView:2];
        
        
        info=nil;
        self.camActionSheet=nil;
        
    }
    
}



-(void)finishedVideoConvert
{
   
    [self hideHudView];
}


-(UIImage*)getThumnailForVideo:(NSURL*)url
{
    UIImage *orgImage=nil;
    
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetIG =
    [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetIG.appliesPreferredTrackTransform = YES;
    assetIG.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
     CMTime time = CMTimeMakeWithSeconds(0.0, 600);
   // CFTimeInterval thumbnailImageTime = 60.0;
   // CMTime time=  CMTimeMake(thumbnailImageTime, 60);
    NSError *igError = nil;
    thumbnailImageRef =
    [assetIG copyCGImageAtTime:time
                    actualTime:NULL
                         error:&igError];
    
    if (!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@", igError );
    
    
    UIImage *thumbnailImage = thumbnailImageRef
    ? [[UIImage alloc] initWithCGImage:thumbnailImageRef]
    : nil;
    
      CGSize sz= CGSizeMake(((thumbnailImage.size.width/thumbnailImage.size.height)*400),400);
    UIGraphicsBeginImageContextWithOptions(sz, FALSE, 0.0);
    //[thumbnailImage drawInRect:CGRectMake( 0, 0, thumbnailImage.size.width, thumbnailImage.size.height)];
      [thumbnailImage drawInRect:CGRectMake( 0, 0, ((thumbnailImage.size.width/thumbnailImage.size.height)*400),400)];
    
    UIImage *fgImage=[UIImage imageNamed:THUMBIMAGENAME];
     
   CGPoint p= CGPointMake(((sz.width-fgImage.size.width)/2), ((sz.height-fgImage.size.height)/2));
  
    [fgImage drawInRect:CGRectMake(p.x,p.y,fgImage.size.width, fgImage.size.height)];
    orgImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    if(thumbnailImageRef)
    CFRelease(thumbnailImageRef);
    
    
    
    
    
    return orgImage;
}



-(void)notifyRequesterWithData:(id) aData :(id)aData1
{
    
    [self hideHudView];
    [self hideActiveIndicatorOwnPost];
    [self hideNativeHudView];
    
    if([aData isKindOfClass:[ConnectionManager class]])
    {
        ConnectionManager *aR=(ConnectionManager*)aData;
        if([aR.requestSingleId isEqualToString:POST])
        {
           // [self resetPostView];
        }
        else if([aR.requestSingleId isEqualToString:TEAMINVITESTATUS])
        {
            
        }
        else if([aR.requestSingleId isEqualToString:UPDATEPOST])
        {
            self.updatetextvw.text=[self textForUpdateField:[self.dataArrayUpTexts objectAtIndex:lastSelectedTeam]];
            
           // self.updatetextvw.editable=NO;//ch
            self.smsnumbertextl.hidden=YES;
        
        }
       
        
        return;
    }
    
    ConnectionManager *aR=(ConnectionManager*)aData1;
    NSString *str=(NSString*)aData;
    
    @autoreleasepool {
        
    
    
    if([aR.requestSingleId isEqualToString:POST ])
    {
        [self resetPostView];
        
        
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
                  
                    
                    [self showHudAlert:[aDict objectForKey:@"message"]];
                    [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
                    
                    
                }
                else
                {
                    [self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
                }
            }
        }
        
    }
    else if([aR.requestSingleId isEqualToString:TEAMINVITESTATUS ])
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
                    
                    
                    
                   // [self showHudAlert:[aDict objectForKey:@"message"]];
                   // [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
                    
                    int index=lastSelectedTeam;
                    [self setDataFromDelegateArray:index :appDelegate.arrItems];
                    [self reloadDataFromDelegateArray:appDelegate.arrItems];
//                    self.dataArray=appDelegate.arrItems;
//                    [self.allpostdataDic setObject:self.dataArray forKey:[self.dataArrayUpButtonsIds objectAtIndex:lastSelectedTeam]];
//                    [self.tableView reloadData];
                  
                    
                }
                else
                {
                    [self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
                }
            }
        }
        
        
    }
    else if([aR.requestSingleId isEqualToString:UPDATEPOST ])
    {
       
        
        
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
                    
                    
                    [self.dataArrayUpTexts replaceObjectAtIndex:lastSelectedTeam withObject:self.updatetextvw.text];
                    [appDelegate setUserDefaultValue:self.appDelegate.centerVC.dataArrayUpTexts ForKey:ARRAYTEXTS];
                 //   [self showHudAlert:[aDict objectForKey:@"message"]];
                  //  [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
                   // self.updatetextvw.editable=NO;//ch
                    self.smsnumbertextl.hidden=YES;
                  
                    
                }
                else
                {
                    [self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
                     self.updatetextvw.text=[self textForUpdateField:[self.dataArrayUpTexts objectAtIndex:lastSelectedTeam]];
                   // self.updatetextvw.editable=NO; //ch
                    self.smsnumbertextl.hidden=YES;
                   
                }
            }
        }
        
    }
    
    }
    
    
    
    
    
}

-(void)hideHudViewHere
{
    [self hideHudView];
    
    
}


-(void)loadVC
{
    
}


-(void)resetVC
{
}




-(void) keyboardDidShow:(NSNotification *) notification
{
    
    
    
    NSDictionary* info = [notification userInfo];
    
    NSValue *aValue =
    [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    [aValue getValue:&kb];
    
    
    
    
    
    
    
    
    
}





//---when the keyboard disappears---



-(void) keyboardDidHide:(NSNotification *) notification {
    
    
   }


-(void)hideKeyTool
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    CGRect rect = keyboardToolbarView.frame;
    rect.origin.y = 372;
    keyboardToolbarView.frame = rect;
    [keyboardToolbarView removeFromSuperview];
    [UIView commitAnimations];
}
-(void)moveScrollView:(UIView *)theView
{
    CGFloat vcy=theView.center.y;
    
    
    CGFloat fsh=af.size.height;
    
   
    CGFloat sa;//=vcy-fsh/5.8;
    
    
    if(isiPhone5)
    sa=vcy-fsh/5.8;   //sa=vcy-fsh/3.2;
    else
    sa=vcy-fsh/6.8;    //sa=vcy-fsh/5.2;
    
    if(sa<0)
        sa=0;
    
    self.scrollview.contentSize=CGSizeMake(af.size.width,af.size.height+kb.size.height);
    
    [ self.scrollview setContentOffset:CGPointMake(0,sa) animated:YES];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if([textView isEqual:_updatetextvw])
    {
    TeamUpdateCreateVC *teamupdateVC=[[TeamUpdateCreateVC alloc] initWithNibName:@"TeamUpdateCreateVC" bundle:nil];
    teamupdateVC.defaultText=[self.dataArrayUpTexts objectAtIndex:lastSelectedTeam];
    //   NSLog(@"1.%@----2.%@",teamupdateVC.defaultText,self.updatetextvw.text);
    [teamupdateVC view];
    
    teamupdateVC.mylab1.text=[self.dataArrayUpButtons objectAtIndex:lastSelectedTeam];
    [self.navigationController pushViewController:teamupdateVC animated:YES];
    }
    return NO;
}


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.currenttextvw=textView;
    if([textView.text isEqualToString:GOTEAM])
        textView.text=@"";
    
    
    NSString *str=[[NSString alloc] initWithFormat:@"(%i chracters remaining)",(TOTALCHARACTERS-[[textView text] length])];
    self.smsnumbertextl.text=str;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    CGRect rect = keyboardToolbarView.frame;
    
    
    
    //rect.origin.y = 204;
    
    if(appDelegate.isIphone5)
        rect.origin.y = (170+88);
    else
        rect.origin.y = 170;
    
    
    
    
    
    
    keyboardToolbarView.frame = rect;
    
    //NSLog(@"Toolbar Frame=%f,%f,%f,%f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
    
    [self.view addSubview:keyboardToolbarView];
    [UIView commitAnimations];
    
    
    //[self moveScrollView:textField];

}
- (void)textViewDidEndEditing:(UITextView *)textView
{
     [self hideKeyTool];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([textView isEqual:self.updatetextvw])
    {
        if([text isEqualToString:@""])
        {
            if([textView.text length]==0)
                return NO;
            
            NSString *str=[[NSString alloc] initWithFormat:@"(%i %@)",(TOTALCHARACTERS-(textView.text.length-1)), @"characters remaining"];
            self.smsnumbertextl.text= str;
            return YES;
        }
        
        
        if([textView.text length]>=TOTALCHARACTERS)
            return NO;
        
        
        NSString *str=[[NSString alloc] initWithFormat:@"(%i %@)",(TOTALCHARACTERS-(textView.text.length+text.length)), @"characters remaining"];
        self.smsnumbertextl.text= str;
    }
    
    return YES;

}
//////////
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //int tag = [textField tag];
    self.currenttextField=textField;
    
    
    if(![textField isEqual:self.updatetextvw])
    {
     self.currbodytext=textField.text;
    }
    else
    {
        
        
        
        if([textField.text isEqualToString:GOTEAM])
            textField.text=@"";
        
        
        NSString *str=[[NSString alloc] initWithFormat:@"(%i chracters remaining)",(TOTALCHARACTERS-[[textField text] length])];
        self.smsnumbertextl.text=str;
        
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    CGRect rect = keyboardToolbarView.frame;
    
   
    
        //rect.origin.y = 204;
        
        if(appDelegate.isIphone5)
            rect.origin.y = (170+88);
        else
            rect.origin.y = 170;
   
    
    
    
    
    
    keyboardToolbarView.frame = rect;
    
    //NSLog(@"Toolbar Frame=%f,%f,%f,%f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
    
    [self.view addSubview:keyboardToolbarView];
    [UIView commitAnimations];
    
    
    //[self moveScrollView:textField];
}

- (BOOL)textField:(UITextField *)textView shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)text
{
    if([textView isEqual:self.updatetextvw])
    {
    if([text isEqualToString:@""])
    {
        if([textView.text length]==0)
            return NO;
        
        NSString *str=[[NSString alloc] initWithFormat:@"(%i %@)",(TOTALCHARACTERS-(textView.text.length-1)), @"characters remaining"];
        self.smsnumbertextl.text= str;
        return YES;
    }
    
    
    if([textView.text length]>=TOTALCHARACTERS)
        return NO;
    
    
    NSString *str=[[NSString alloc] initWithFormat:@"(%i %@)",(TOTALCHARACTERS-(textView.text.length+text.length)), @"characters remaining"];
    self.smsnumbertextl.text= str;
    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
   
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    /*if([textField isEqual:self.updatetextvw])
    {
        self.updatetextvw.editable=NO;
        self.smsnumbertextl.hidden=YES;
        self.updatetextvw.text=[self textForUpdateField:[self.dataArrayUpTexts objectAtIndex:lastSelectedTeam]];
     
    }*/
    
    
    [self hideKeyTool];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return NO;
}

-(void)dissmissCanKeyboard:(id)sender
{
    int tag=[sender tag];
    
    
        if(![currenttextvw isEqual:self.updatetextvw])
        {
    if(tag==0)
    {
        self.commentTextVw.text=self.currbodytext;
        
    }
    
    [self.commentTextVw resignFirstResponder];
        }
    else
    {
       // self.updatetextvw.editable=NO;//ch
         self.smsnumbertextl.hidden=YES;
        
        if(tag==0)
        {
            self.updatetextvw.text=[self textForUpdateField:[self.dataArrayUpTexts objectAtIndex:lastSelectedTeam]];
            
        }
        else
        {
            if(self.updatetextvw.text)
            {
                if(( [self.updatetextvw.text isEqualToString:@""]))
                {
                    [self showAlertMessage:@"Team Status update field can't be left blank."];
                   self.updatetextvw.text=[self textForUpdateField:[self.dataArrayUpTexts objectAtIndex:lastSelectedTeam]];
                }
                else
                {
                    [self postUpdate:self.updatetextvw.text];
                }
            }
        }
        
        [self.updatetextvw resignFirstResponder];
        
        
        self.updatetablehideview.hidden=YES;
        self.updateuphideview.hidden=YES;
    }
   // self.scrollview.contentSize=svos;
   // self.scrollview.contentOffset=point;
    
    
   
}


-(NSString*)textForUpdateField:(NSString*)str
{
   // NSLog(@"CurrUpdateText=%@",str);
    
    
    if(str && (![str isEqualToString:@""]))
        return str;
    else
        return GOTEAM;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark - Table View


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // return 2;
    return ([self.dataArray count]+1);
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if(indexPath.row==[self.dataArray count])
    {
        return self.wallfootervw.frame.size.height;
    }
    else
    {
        HomeVCTableData *data=[self.dataArray objectAtIndex:indexPath.row];
        
        float dY=0;
        if(isiPad)
        {
            dY=17;
            dY=dY+80+18;
        }
        else
        {
            dY=8;
            dY=dY+40+7;
        }
        
        
        
        
        
        
        //NSLog(@"TestAfterCommentFrameinTableViewHeight%f----%i",dY,indexPath.row);
        
        //   NSLog(@"HeightInRow=%f",dY);
        
        
        //  NSLog(@"HeightInRowSpecial=%f,%f",data.imageWidth,data.imageHeight);
        
        //  NSLog(@",%f",[self getImageLengthOfWidth:data.imageWidth OfHeight:data.imageHeight isWidth:1 length:296] );
        
        if(data.isExistPostedImageInfo)
        {
            float size;
           // UIImage *img=data.postedImageInfo.image;
            NSLog(@"%f",data.postedImageInfo.image.size.width);
            NSLog(@"%f",data.postedImageInfo.image.size.height);
            
            ImageInfo * info1 = data.postedImageInfo;
            if(info1.image)
            {
                UIImage *image=info1.image;
                /*if(isiPad)
                    size= [self getImageLengthOfWidth:image.size.width OfHeight:image.size.height isWidth:2 length:680];
                else
                    size= [self getImageLengthOfWidth:data.imageWidth OfHeight:data.imageHeight isWidth:1 length:280];*/
                CGFloat hgt=200;
                
                if (self.isiPad) {
                    hgt=400;
                }
                size=image.size.height;
                if (image.size.height>hgt) {
                    size=hgt;
                }
                
                if(isiPad)
                {
                    dY=dY+size+18;
                }
                else
                {
                    CGFloat hgt1=0;
                    
                    hgt1=280*image.size.height/image.size.width;
                    
                    size=hgt;
                    dY=dY+size+7;
                }
            
            }
            
            else{
                /*if(isiPad)
                    size= [self getImageLengthOfWidth:data.imageWidth OfHeight:data.imageHeight isWidth:2 length:680];
                else
                    size= [self getImageLengthOfWidth:data.imageWidth OfHeight:data.imageHeight isWidth:1 length:280];*/
                
                CGFloat hgt=200;
                
                if (self.isiPad) {
                    hgt=400;
                }
                
                size= data.imageHeight;
                if (data.imageHeight>hgt) {
                    size=hgt;
                }
                if(isiPad)
                {
                    dY=dY+size+18;
                }
                else
                {
//                    CGFloat hgt1=0;
//                    
//                    hgt1=220;
                    CGFloat hgt1=0;
                    
                    hgt1=280*data.imageHeight/data.imageWidth;
                    
                    size=hgt;
                    //size=hgt;
                    dY=dY+size+7;
                }
            }
            
        }
        
        CGSize labelTextSize;
        
        if(isiPad)
            labelTextSize =[self getSizeOfText:data.commentstr :CGSizeMake (676,10000) :self.helveticaFont];
        else
            labelTextSize =[self getSizeOfText:data.commentstr :CGSizeMake (278,10000) :self.helveticaFont];
        
        
        
        
        
        /* if(labelTextSize.height<51)
         {
         labelTextSize.height=51;
         }*/
        //  NSLog(@"HeightInRow=%f",dY);
        
        if(isiPad)
        {
            dY=dY+labelTextSize.height+18;
        }
        else
        {
            dY=dY+labelTextSize.height+7;
        }
        
        
        
        // NSLog(@"HeightInRow=%f",dY);
        //+7;//+5;//add-7-5
        if(isiPad)
        {
            dY=(dY+100-18);
        }
        else
        {
            dY=(dY+42-7);
        }
        
        
         NSLog(@"HeightInRow=%f-----IndexpathRow=%i",dY,indexPath.row);
        
        
        return dY;
    }
}


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    tableView.sectionHeaderHeight=0.0;
    
    return 0.0;
    
}






-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    /*if(self.dataArray.count>0 && self.dataArray)
    {
    tableView.sectionFooterHeight=self.wallfootervw.frame.size.height;
    return self.wallfootervw.frame.size.height;
    }
    else
    {
        tableView.sectionFooterHeight=0.0;
        return 0;
    }*/
    tableView.sectionFooterHeight=0.0;
    return 0;
}




- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NSLog(@"CallTableFooterView");
   /* if(self.dataArray.count>0 && self.dataArray)
    {

    self.wallfootervwgreydot.hidden=YES;
      self.wallfootervwactivind.hidden=NO;
    [self.wallfootervwactivind startAnimating];
     [self performSelector:@selector(requestForTableViewFooterLoading:) withObject:[NSNumber numberWithInt:lastSelectedTeam] afterDelay:0.0];
        
    return self.wallfootervw;
    }
    else
    {
    return nil;
    }*/
    
       return nil;
}





-(void)likeComment:(UIButton *)sender
{
    
    HomeVCTableCell *cell=nil;
    
    if(appDelegate.isIos7)
        cell=(HomeVCTableCell*)sender.superview.superview.superview.superview.superview;
    else
        cell=(HomeVCTableCell*)sender.superview.superview.superview.superview;
    
    NSIndexPath *indexPath= [self.tableView indexPathForCell:cell];
    HomeVCTableData *hdata=[self.dataArray objectAtIndex:indexPath.row];
    
    
    NSString *s=nil;
    
    int f=0;
    int m;
    if(!hdata.isLike)
    {
        
    //    [self processlikeOrUnlike:0 :cell];
         [self takeAction:hdata.isLike :cell];
        
         m=[[cell.likecountlab.text stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]] intValue];
       s=[[NSString alloc] initWithFormat:@"%i",++m];
       
      
    }
    else
    {
        
        
    //   [self processlikeOrUnlike:1 :cell];
        
        [self takeAction:hdata.isLike :cell];
        
          m=[[cell.likecountlab.text stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]] intValue];
   //     NSLog(@"%i",m);
        
       s=[[NSString alloc] initWithFormat:@"%i",--m];
       
        
        f++;
    }
  
    if(m>0)
    {
       
        cell.likecountlab.hidden=NO;
        cell.likeslab.hidden=NO;
         cell.likeslabima.hidden=NO;
        
        cell.viewLikesbt.hidden=NO;
        
        if(m==1)
            cell.likeslab.text=@"Like";
        else
            cell.likeslab.text=@"Likes";
    }
    else
    {
        cell.likecountlab.hidden=YES;
        cell.likeslab.hidden=YES;
        cell.likeslabima.hidden=YES;
           cell.viewLikesbt.hidden=YES;
    }
      cell.likecountlab.text=s;
      [[NSNotificationCenter defaultCenter] postNotificationName:LIKECOUNTCHANGEFORTEXT object:s];
    
    
   
    hdata.isLike=!(hdata.isLike);
    
    if(hdata.isLike)
        (hdata.number_of_likes)++;
    else
        (hdata.number_of_likes)--;
    
    s=[[NSString alloc] initWithFormat:@"%lli",hdata.number_of_likes];
    hdata.likecountlab=s;
    

    
     [self processlikeOrUnlike:f :cell];
    
    
    
    
   // NSLog(@"1.%@,%@,%i,%i" ,hdata.likecountlab,cell.likecountlab.text,hdata.number_of_likes,hdata.isLike );
}


-(void)processlikeOrUnlike:(BOOL)like :(HomeVCTableCell*)cell
{
    isProcessingLikeOrUnlike=1;
     NSIndexPath *indexPath= [self.tableView indexPathForCell:cell];
    HomeVCTableData *hdata=[self.dataArray objectAtIndex:indexPath.row];
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"user_id"];
    
    
    
    
    if(!like)
    [command setObject:@"Y" forKey:@"islike"];
    else
    [command setObject:@"N" forKey:@"islike"];
    
    [command setObject:hdata.post_id forKey:@"post_id"];
    
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    
  //  NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    
    SingleRequest *sinReq=nil;
    
    if(!like)
  sinReq=  [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:LIKELINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]]  ;
    else
       sinReq=  [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:UNLIKELINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
        
         self.sinReq3=sinReq;
    [self.storeCreatedRequests addObject:self.sinReq3];
    
    
    sinReq.notificationName=LIKEUNLIKEUPDATED;
    sinReq.userInfo=cell;
    [sinReq startRequest];
    

    
  
    
    
}



- (void)likeunlikeUpdated:(NSNotification *)notif
{
    SingleRequest *sReq=(SingleRequest*)[notif object];
   
    
    if([sReq.notificationName isEqualToString:LIKEUNLIKEUPDATED])
    {
        NSIndexPath *indexPath= [self.tableView indexPathForCell:(HomeVCTableCell*)sReq.userInfo];
        HomeVCTableData *hdata=[self.dataArray objectAtIndex:indexPath.row];
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
                         isProcessingLikeOrUnlike=0;
//                          NSIndexPath *indexPath= [self.tableView indexPathForCell:(HomeVCTableCell*)sReq.userInfo];
//                          HomeVCTableData *hdata=[self.dataArray objectAtIndex:indexPath.row];
                        
                        
                   //change   [self takeAction:hdata.isLike :(HomeVCTableCell*)sReq.userInfo];
                         /*later change hdata.isLike=!(hdata.isLike);
                        
                        if(hdata.isLike)
                        (hdata.number_of_likes)++;
                        else
                          (hdata.number_of_likes)--;
                        
                        NSString *s=[[NSString alloc] initWithFormat:@"%i",hdata.number_of_likes];
                        hdata.likecountlab=s;
                      
                        [s release];*/
//                        HomeVCTableCell *cell=  (HomeVCTableCell*)sReq.userInfo;
//                        cell.likecountlab.text=hdata.likecountlab;
                    }
                    else
                    {
                        [self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
                        [self takeAction:hdata.isLike :(HomeVCTableCell*)sReq.userInfo];
                        [self changeCellLikeUnlikeValue:hdata.isLike :(HomeVCTableCell*)sReq.userInfo];
                    
                    }
                }
                else
                {
                    //[self showAlertMessage:CONNFAILMSG title:@""];ChAfter
                     [self takeAction:hdata.isLike :(HomeVCTableCell*)sReq.userInfo];
                    [self changeCellLikeUnlikeValue:hdata.isLike :(HomeVCTableCell*)sReq.userInfo];
                }
                
            }
            else
            {
               // [self showAlertMessage:CONNFAILMSG title:@""];ChAfter
                 [self takeAction:hdata.isLike :(HomeVCTableCell*)sReq.userInfo];
                [self changeCellLikeUnlikeValue:hdata.isLike :(HomeVCTableCell*)sReq.userInfo];
            }
            
        }
        else
        {
           // [self showAlertMessage:CONNFAILMSG title:@""];ChAfter
             [self takeAction:hdata.isLike :(HomeVCTableCell*)sReq.userInfo];
            [self changeCellLikeUnlikeValue:hdata.isLike :(HomeVCTableCell*)sReq.userInfo];
        }
    }
}




-(void)changeCellLikeUnlikeValue:(int)n :(HomeVCTableCell*)cell
{
    
    if(isProcessingLikeOrUnlike)
    {
     isProcessingLikeOrUnlike=0;
    }
    else
    {
        return;
    }
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:LIKEFAILED object:self];
    
    NSIndexPath *indexPath= [self.tableView indexPathForCell:cell];
    HomeVCTableData *hdata=[self.dataArray objectAtIndex:indexPath.row];
    
    NSString *s=nil;
    int m=[[cell.likecountlab.text stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]] intValue];
   
    
    
    
    if(!n)
    {
         s=[[NSString alloc] initWithFormat:@"%i",++m];//()
    }
    else
    {
         s=[[NSString alloc] initWithFormat:@"%i",--m];//()
    }
    
    if(m >0)
    {
         
        cell.likecountlab.hidden=NO;
        
        cell.likeslab.hidden=NO;
        cell.likeslabima.hidden=NO;
           cell.viewLikesbt.hidden=NO;
        
        if(m==1)
            cell.likeslab.text=@"Like";
        else
            cell.likeslab.text=@"Likes";
    }
    else
    {
        cell.likecountlab.hidden=YES;
        cell.likeslab.hidden=YES;
        cell.likeslabima.hidden=YES;
           cell.viewLikesbt.hidden=YES;
    }
   cell.likecountlab.text=s;
    [[NSNotificationCenter defaultCenter] postNotificationName:LIKECOUNTCHANGEFORTEXT object:s];
    
    
    
    hdata.isLike=!(hdata.isLike);
    
    if(hdata.isLike)
        (hdata.number_of_likes)++;
    else
        (hdata.number_of_likes)--;
    
    s=[[NSString alloc] initWithFormat:@"%lli",hdata.number_of_likes];
    hdata.likecountlab=s;
    

    
    
   //  NSLog(@"2.%@,%@,%i,%i" ,hdata.likecountlab,cell.likecountlab.text,hdata.number_of_likes,hdata.isLike );
}

-(void)takeAction:(BOOL)like :(HomeVCTableCell*)cell
{
    [[NSNotificationCenter defaultCenter] postNotificationName:LIKECOUNTCHANGEFORANIMATION object:[NSNumber numberWithBool:like]];
    
    if(!like)
    {
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         
                         CGRect theFrame = cell.likeImage.frame;
                         theFrame.origin.x -= 2;
                         theFrame.origin.y -= 2;
                         theFrame.size.height += 4;
                         theFrame.size.width += 4;
                         
                         
                         cell.likeImage.frame = theFrame;
                         
                         cell.likeImage.image=self.likedImage;
                         cell.likeorunlikelab.text=@"Unlike";
                         cell.likeImage.animationRepeatCount=1;
                         cell.likeImage.animationDuration=0.5;
                         cell.likeImage.animationImages=animationtogreensets;
                         [cell.likeImage startAnimating];
                         
                         
                     } completion:^(BOOL finished) {
                         
                         cell.likeImage.image=self.likedImage;
                         cell.likeorunlikelab.text=@"Unlike";
                         [UIView animateWithDuration:0.5
                                               delay:0.0
                                             options:UIViewAnimationOptionBeginFromCurrentState
                                          animations:^{
                                              CGRect theFrame = cell.likeImage.frame;
                                              theFrame.origin.x += 2;
                                              theFrame.origin.y += 2;
                                              theFrame.size.height -= 4;
                                              theFrame.size.width -= 4;
                                              cell.likeImage .frame = theFrame;
                                              
                                              
                                          }completion:^(BOOL finished) {
                                              
                                              
                                              cell.likeImage.image=self.likedImage;
                                              cell.likeorunlikelab.text=@"Unlike";
                                          }];
                     }];
    
    }
    else
    {
        cell.likeImage.image=self.nonLikedImage;
        cell.likeorunlikelab.text=@"Like";
        cell.likeImage.animationImages=animationtowhitesets;
        cell.likeImage.animationDuration=1.0;
        cell.likeImage.animationRepeatCount=1;
        [cell.likeImage startAnimating];
    }
    
}



-(void)postComment:(UIButton *)sender
{
    
    HomeVCTableCell *cell=nil;
    
    
    if(appDelegate.isIos7)
    cell=(HomeVCTableCell*)sender.superview.superview.superview.superview.superview;
    else
    cell=(HomeVCTableCell*)sender.superview.superview.superview.superview;
    
    NSIndexPath *indexPath= [self.tableView indexPathForCell:cell];
  
    

    
    
    
    CommentVC *commentView=[[CommentVC alloc] initWithNibName:@"CommentVC" bundle:nil];
    self.commVC=commentView;
    commentView.hvcData=[self.dataArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:commentView animated:YES];
    
    [commentView.postTxtVw becomeFirstResponder];
    
    
    
    
    
    
}

-(void)viewComment:(UIButton *)sender
{
    
    HomeVCTableCell *cell=nil;
    
    if(appDelegate.isIos7)
    cell=(HomeVCTableCell*)sender.superview.superview.superview.superview;
    else
    cell=(HomeVCTableCell*)sender.superview.superview.superview;
    
    NSIndexPath *indexPath= [self.tableView indexPathForCell:cell];
    
    
    
    
    
    
    CommentVC *commentView=[[CommentVC alloc] initWithNibName:@"CommentVC" bundle:nil];
    self.commVC=commentView;
    commentView.hvcData=[self.dataArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:commentView animated:YES];
    
       
    
    
    
    
    
}


-(void)viewLikes:(UIButton *)sender
{
    
    
    HomeVCTableCell *cell=nil;
    
    if(appDelegate.isIos7)
    cell=(HomeVCTableCell*)sender.superview.superview.superview.superview;
    else
    cell=(HomeVCTableCell*)sender.superview.superview.superview;
        
    NSIndexPath *indexPath= [self.tableView indexPathForCell:cell];
    
    
    
    
    
    
    PostLikeViewController *commentView=[[PostLikeViewController alloc] initWithNibName:@"PostLikeViewController" bundle:nil];
    self.postLikeVC=commentView;
    HomeVCTableData *hvcData=[self.dataArray objectAtIndex:indexPath.row];
       commentView.no_of_likesStr=[[NSString alloc] initWithFormat:@"%lli",hvcData.number_of_likes];
    commentView.postId=hvcData.post_id;
    
    [self.navigationController pushViewController:commentView animated:YES];
    
    commentView=nil;
    
}



-(void)delComment:(UIButton *)sender
{
   // HomeVCTableCell  *cell=(HomeVCTableCell*)[tableView cellForRowAtIndexPath:indexPath];
//    HomeVCTableCell *cellH=self.currDelCell;
//    NSIndexPath *indexPath= [self.tableView indexPathForCell:cellH];
//    HomeVCTableData *hvcData   =[self.dataArray objectAtIndex:indexPath.row];
    UIButton *btn=(UIButton *)sender;
    HomeVCTableData *hvcData   =[self.dataArray objectAtIndex:btn.tag];

     UIActionSheet *acsh= nil;
    if([hvcData.userId isEqualToString:[appDelegate.aDef objectForKey:LoggedUserID]]){
        acsh= [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Delete",@"Report Abuse",nil];
        acsh.tag=999;
    }
        //    {
    
    else{
   
        acsh= [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Report Abuse",nil];
        acsh.tag=998;
    }
    
    [acsh showInView:appDelegate.centerViewController.view];
    
    
   
    
    HomeVCTableCell *cell=nil;
    
    if(appDelegate.isIos7)
    cell=(HomeVCTableCell*)sender.superview.superview.superview.superview;
    else
    cell=(HomeVCTableCell*)sender.superview.superview.superview;
    
    self.currDelCell=cell;
    
       
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==999) {
        if(buttonIndex==0)
        {
            
            UIAlertView *alertDelete=[[UIAlertView alloc] initWithTitle:@"" message:@"Are you sure want to delete?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
            
            [alertDelete show];
        }
        else if(buttonIndex==1)
        {
            HomeVCTableCell *cell=self.currDelCell;
            
            
            NSIndexPath *indexPath= [self.tableView indexPathForCell:cell];
            
            HomeVCTableData *hvcData   =[self.dataArray objectAtIndex:indexPath.row];
            
            [self showHudAlert:@"Connecting..."];
            [self showNativeHudView];
            
            NSMutableDictionary *command = [NSMutableDictionary dictionary];
            [command setObject:hvcData.post_id forKey:@"post_id"];
            [command setObject:[self.dataArrayUpButtonsIds objectAtIndex:lastSelectedTeam] forKey:@"team_id"];
            [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
            
            SBJsonWriter *writer = [[SBJsonWriter alloc] init];
            
            
            NSString *jsonCommand = [writer stringWithObject:command];
            
            [self reqForReportAbuse:[NSDictionary dictionaryWithObject:jsonCommand forKey:@"requestParam"]];
            
            
            
        }
    }
    else if (actionSheet.tag==998){
        
        if(buttonIndex==0)
        {
            HomeVCTableCell *cell=self.currDelCell;
            
            
            NSIndexPath *indexPath= [self.tableView indexPathForCell:cell];
            
            
            
            
            
            HomeVCTableData *hvcData   =[self.dataArray objectAtIndex:indexPath.row];
            
            
            
            
            
            
            
            [self showHudAlert:@"Connecting..."];
            [self showNativeHudView];
            
            NSMutableDictionary *command = [NSMutableDictionary dictionary];
            [command setObject:hvcData.post_id forKey:@"post_id"];
            [command setObject:[self.dataArrayUpButtonsIds objectAtIndex:lastSelectedTeam] forKey:@"team_id"];
            [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
            SBJsonWriter *writer = [[SBJsonWriter alloc] init];
            NSString *jsonCommand = [writer stringWithObject:command];
            
            [self reqForReportAbuse:[NSDictionary dictionaryWithObject:jsonCommand forKey:@"requestParam"   ]];
            
            
            
        }
    }
    
    
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        HomeVCTableCell *cell=self.currDelCell;
        
        
        NSIndexPath *indexPath= [self.tableView indexPathForCell:cell];
        
        
        
        
        
        HomeVCTableData *hvcData   =[self.dataArray objectAtIndex:indexPath.row];
        
        
        
        
        
        
        hvcData.isShowDelete=0;
        
        /*if(hvcData.isShowDelete)
         cell.closebt.hidden=NO;
         else*/
        //cell.closebt.hidden=YES;   ///AD
        
        
        [self showHudAlert:@"Connecting..."];
        [self showNativeHudView];
        
        NSMutableDictionary *command = [NSMutableDictionary dictionary];
        [command setObject:hvcData.post_id forKey:@"post_id"];
        SBJsonWriter *writer = [[SBJsonWriter alloc] init];
        
        
        NSString *jsonCommand = [writer stringWithObject:command];
        
        [self reqForDelete:[NSDictionary dictionaryWithObject:jsonCommand forKey:@"requestParam"   ]:indexPath.row];

    }
}

-(void)reqForDelete:(NSDictionary*)dic :(int)row
{
    
    
    
    NSURL* url = [NSURL URLWithString:DELETEPOSTLINK];
    ASIFormDataRequest *aRequest=  [[ASIFormDataRequest alloc] initWithURL:url] ;
    self.myFormRequest1=aRequest;
    [self.storeCreatedRequests addObject:self.myFormRequest1];
    [aRequest setShouldContinueWhenAppEntersBackground:YES];
    
    [aRequest setDelegate:self];
    [aRequest setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt: lastSelectedTeam ],@"Index1",[NSNumber numberWithInt: row ],@"Index2" ,nil]];
    [aRequest setValidatesSecureCertificate:NO];
    [ASIFormDataRequest setShouldThrottleBandwidthForWWAN:YES];
    [aRequest addPostValue:[dic objectForKey:[[dic allKeys] objectAtIndex:0]] forKey:[[dic allKeys] objectAtIndex:0]];
    [aRequest setDidFinishSelector:@selector(requestDeleteFinished:)];
    [aRequest setDidFailSelector:@selector(requestDeleteFailed:)];
    
    [aRequest startAsynchronous];
}

-(void)reqForReportAbuse:(NSDictionary*)dic 
{
    
    
    
    NSURL* url = [NSURL URLWithString:REPORTABUSELINK];
    ASIFormDataRequest *aRequest=  [[ASIFormDataRequest alloc] initWithURL:url] ;
    self.myFormRequest2=aRequest;
    [self.storeCreatedRequests addObject:self.myFormRequest2];
    [aRequest setShouldContinueWhenAppEntersBackground:YES];
    
    [aRequest setDelegate:self];
  //  [aRequest setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt: lastSelectedTeam ],@"Index1",[NSNumber numberWithInt: row ],@"Index2" ,nil]];
    [aRequest setValidatesSecureCertificate:NO];
    [ASIFormDataRequest setShouldThrottleBandwidthForWWAN:YES];
    [aRequest addPostValue:[dic objectForKey:[[dic allKeys] objectAtIndex:0]] forKey:[[dic allKeys] objectAtIndex:0]];
    [aRequest setDidFinishSelector:@selector(requestRAbusedFinished:)];
    [aRequest setDidFailSelector:@selector(requestRAbusedFailed:)];
    
    [aRequest startAsynchronous];
}

- (void)requestRAbusedFinished:(ASIHTTPRequest *)request
{
	NSLog(@"Data Received in Connection Manager.... %@ ",[request responseString]);
    // [self hideActiveIndicatorOwnPost];
    //  [self resetPostView];
    [self hideHudView];
    [self hideNativeHudView];
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
            }
            else
            {
                [self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
            }
        }
    }
    
    
	
}
- (void)requestRAbusedFailed:(ASIHTTPRequest *)request
{
    [self hideHudView];
    [self hideNativeHudView];
    //[self hideActiveIndicatorOwnPost];
    // [self resetPostView];
    //	NSLog(@"Error receiving data : %@ ",[request.error description]);
	//[self showAlertMessage:CONNFAILMSG];ChAfter
	
}

- (IBAction)updateAction:(id)sender
{
    
    TeamUpdateCreateVC *teamupdateVC=[[TeamUpdateCreateVC alloc] initWithNibName:@"TeamUpdateCreateVC" bundle:nil];
    
   /* if([[self.dataArrayUpIsCreated objectAtIndex:lastSelectedTeam] integerValue])
       teamupdateVC.isEditMode=1;
    else*///Add Latest Ch 
      teamupdateVC.isEditMode=0;
    
    teamupdateVC.defaultText=[self.dataArrayUpTexts objectAtIndex:lastSelectedTeam];
    //   NSLog(@"1.%@----2.%@",teamupdateVC.defaultText,self.updatetextvw.text);
    [teamupdateVC view];
    
    teamupdateVC.mylab1.text=[NSString stringWithFormat:@"%@ Coach Updates", [self.dataArrayUpButtons objectAtIndex:lastSelectedTeam] ];
    
  
    
    [self.navigationController popToRootViewControllerAnimated:NO];
    [self.navigationController pushViewController:teamupdateVC animated:NO];
}


- (void)requestDeleteFinished:(ASIHTTPRequest *)request
{
	NSLog(@"Data Received in Connection Manager.... %@ ",[request responseString]);
   // [self hideActiveIndicatorOwnPost];
  //  [self resetPostView];
    [self hideHudView];
    [self hideNativeHudView];
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
              /*  int index=[[[request userInfo] objectForKey:@"Index1"] integerValue];
                
                [self requestFirst:index];*/
                
                
               int index2=[[[request userInfo] objectForKey:@"Index2"] integerValue];
                
                [self.dataArray removeObjectAtIndex:index2];
                
                [self.tableView reloadData];
                
               /*
                //// AD...iAd
                self.adBanner.delegate = self;
                self.adBanner.alpha = 0.0;
                self.canDisplayBannerAds=YES;
                ////
                */
                /*int tag=lastSelectedTeam;
                 for(id v in self.menuupscrollview.subviews)
                 {
                 if([v isMemberOfClass:[UIButton class]])
                 {
                 UIButton *bt=(UIButton*)v;
                 if(tag==[v tag])
                 {
                 [bt setTitleColor:self.redcolor forState:UIControlStateNormal];
                 
                 }
                 else
                 {
                 [bt setTitleColor:self.darkgraycolor forState:UIControlStateNormal];
                 }
                 }
                 }
                 
                 if(lastSelectedTeam==0)
                 [self upBtapped:appDelegate.centerVC.buttonfirstinscroll];
                 else
                 [self upBtapped:[self.menuupscrollview viewWithTag:lastSelectedTeam]];*/
                
                
                //    [self showHudAlert:[aDict objectForKey:@"message"]];
                //  [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
                
                
            }
            else
            {
                [self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
            }
        }
    }
    
    
	
}

- (void)requestDeleteFailed:(ASIHTTPRequest *)request
{
    [self hideHudView];
    [self hideNativeHudView];
    //[self hideActiveIndicatorOwnPost];
    // [self resetPostView];
    //	NSLog(@"Error receiving data : %@ ",[request.error description]);
	//[self showAlertMessage:CONNFAILMSG];ChAfter
	
}


- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    static NSString *CellIdentifier = @"HomeVCTableCell";
    static NSString *CellIdentifier1 = @"HomeVCTableCell1";
    
  
//    else
//    {
//      NSIndexPath *indexp=  [tableView1 indexPathForCell:cell];
//        
//     HomeVCTableData *hvcData=  [self.dataArray objectAtIndex:indexp.row];
//        
//        hvcData.postedImageInfo.image=nil;
//        hvcData.userImageInfo.image=nil;
//        
//    }
    
    
    
    //////////////////
    
    
    
    if(indexPath.row==[self.dataArray count])
    {
       UITableViewCell *cell = [tableView1 dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
            
            cell.backgroundColor=[UIColor clearColor];
          cell.selectionStyle=UITableViewCellSelectionStyleNone;  
        }
        
        if(!self.wallfootervw.superview)
        {
            [cell addSubview:self.wallfootervw];
        }
        
        if(tableView1.contentSize.height>tableView1.frame.size.height &&   self.isFinishData==0)
        {
            self.wallfootervwgreydot.hidden=YES;
            self.wallfootervwactivind.hidden=NO;
            [self.wallfootervwactivind startAnimating];
            [self performSelector:@selector(requestForTableViewFooterLoading:) withObject:[NSNumber numberWithInt:lastSelectedTeam] afterDelay:0.0];
        }
        else
        {
            self.wallfootervwactivind.hidden=YES;
            if(self.isFinishData==1)
                self.wallfootervwgreydot.hidden=NO;
            else
                self.wallfootervwgreydot.hidden=YES;
        }
        
         return cell;
        
    }
    else
    {
        HomeVCTableCell *cell = [tableView1 dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            /*if(isiPad)
                cell = (HomeVCTableCell *)[HomeVCTableCell cellFromNibNamed:@"HomeVCTableCell_iPad"];
            else*/
                cell = (HomeVCTableCell *)[HomeVCTableCell cellFromNibNamed:@"HomeVCTableCell"];
            
        }
        cell.backgroundColor=[UIColor clearColor];
          [self configureCell:cell atIndexPath:indexPath];
        
          return cell;
    }
    
    //////////////////
    
    
  
  
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    @autoreleasepool {
        
        
        HomeVCTableCell *scell=(HomeVCTableCell *)cell;
        
        scell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        
        
        /* scell.likecountlab.text=@"0";
         scell.commentcountlab.text=@"0";
         scell.cmnts.text=@"";
         scell.posted.image=nil;
         scell.userima.image=self.noImage;*/
        
        NSUInteger row = [indexPath row];
        
        [scell.likebt addTarget:self action:@selector(likeComment:) forControlEvents:UIControlEventTouchUpInside];
        // [data.commentstr sizeWithFont:scell.cmnts.font constrainedToSize:CGSizeMake (scell.cmnts.frame.size.width,10000) lineBreakMode: NSLineBreakByWordWrapping];
        [scell.commentbt addTarget:self action:@selector(postComment:) forControlEvents:UIControlEventTouchUpInside];
        
        scell.closebt.tag=indexPath.row;
        [scell.closebt addTarget:self action:@selector(delComment:) forControlEvents:UIControlEventTouchUpInside];
        //scell.closebt.hidden=YES;  ///AD
        
        [scell.viewCommentsbt addTarget:self action:@selector(viewComment:) forControlEvents:UIControlEventTouchUpInside];
        
        [scell.viewLikesbt addTarget:self action:@selector(viewLikes:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [scell.profileimabt addTarget:self action:@selector(showRelation:) forControlEvents:UIControlEventTouchUpInside];
        
        /* if(selectedRow!=(indexPath.row+1))
         {
         [scell.btn_del setImage:[UIImage imageNamed:@"delete_icon.png"] forState:UIControlStateNormal];
         scell.editcommentview.hidden = YES;
         }
         else
         {
         [scell.btn_del setImage:[UIImage imageNamed:@"delete_icon_blue.png"] forState:UIControlStateNormal];
         scell.editcommentview.hidden = NO;
         }*/
        
        HomeVCTableData *data=[self.dataArray objectAtIndex:row];
        
        float dY=0;
        if(self.isiPad)
        {
            dY=17;
            dY=dY+80+18;
        }
        else
        {
            dY=8;
            dY=dY+40+7;
        }
        
        scell.posted.clipsToBounds=YES;  //// AD 9th july
        
        if(data.isExistPostedImageInfo)
        {
            ImageInfo * info1 = data.postedImageInfo;
            
            if(info1.image)
            {
                UIImage *image=info1.image;
                
                
                CGRect fr=scell.posted.frame;
                fr.origin.y=dY;
                CGFloat hgt=200;    //height of scell.posted imageView in iPhone
                CGFloat wid=280;    //width of scell.posted imageView in iPhone
                
                if (self.isiPad) {
                    wid=680;    //width of scell.posted imageView in iPad
                    hgt=400;    //height of scell.posted imageView in iPad
                }
                //            fr.size.width=data.imageWidth/appDelegate.deviceScale;
                //            fr.size.height=data.imageHeight/appDelegate.deviceScale;  //// 8/12/14
                
                //Subhasish..20th April
                if (self.isiPad) {
                    if (fr.size.width>data.imageWidth) {
                        fr.origin.x += (fr.size.width-data.imageWidth)/2;
                    }
                }
                /*else{
                 if (fr.size.width>data.imageWidth) {
                 fr.origin.x=(fr.size.width-data.imageWidth)/2;
                 }
                 }*/
                
                fr.size.width=data.imageWidth;
                fr.size.height=data.imageHeight;
                if (data.imageHeight>hgt) {
                    fr.size.height=hgt;
                }
                //Subhasish..19th March
                if (data.imageWidth>wid) {
                    fr.size.width=wid;
                }
                scell.posted.frame=fr;
                
                NSLog(@"IfPartImaViewSize=%@",[NSValue valueWithCGSize:image.size]);
                
                ///// AD Image july
                
                
                
                
                [scell.posted setImage:image];
                
                if(data.videoUrlStr)
                {
                    float x=0.0;
                    float y=0.0;
                    
                    
                    x= scell.posted.center.x-(scell.videoplayimavw.frame.size.width/2);
                    y= scell.posted.center.y-(scell.videoplayimavw.frame.size.height/2);
                    scell.videoplayimavw.frame=CGRectMake(x,y,scell.videoplayimavw.frame.size.width,scell.videoplayimavw.frame.size.height);
                    
                    
                    scell.videoplayimavw.hidden=NO;
                }
                
                scell.posted.hidden=NO;
                scell.acindviewposted.hidden=YES;
                [scell.acindviewposted stopAnimating];
                
            }
            else
            {
                CGRect fr=scell.posted.frame;
                fr.origin.y=dY;
                
                CGFloat hgt=200;    //height of scell.posted imageView in iPhone
                CGFloat wid=280;    //width of scell.posted imageView in iPhone
                
                if (self.isiPad) {
                    wid=680;    //width of scell.posted imageView in iPad
                    hgt=400;    //height of scell.posted imageView in iPad
                }
                
                /* CGSize size=CGSizeMake(fr.size.width, [self getImageLengthOfWidth:data.imageWidth OfHeight:data.imageHeight isWidth:1 length:fr.size.width]); //[self getImage:info1.image isWidth:1 length:scell.posted.frame.size.width];
                 fr.size=size;
                 NSLog(@"ElsePartImaViewSize=%@",[NSValue valueWithCGSize:size]);*/   /// 8/12/14
                
                if (fr.size.width>data.imageWidth) {
                    fr.origin.x += (fr.size.width-data.imageWidth)/2;
                }
                
                fr.size.width=data.imageWidth;
                fr.size.height=data.imageHeight;
                if (data.imageHeight>hgt) {
                    fr.size.height=hgt;
                }
                //Subhasish..19th March
                if (data.imageWidth>wid) {
                    fr.size.width=wid;
                }
                scell.posted.frame=fr;
                
                scell.acindviewposted.hidden=NO;
                scell.posted.hidden=YES;
                scell.videoplayimavw.hidden=YES;
                float x=0.0;
                float y=0.0;
                
                if (self.isiPad) {
                    x= scell.posted.center.x-(scell.acindviewposted.frame.size.width/2);
                    y= scell.posted.center.y-(scell.acindviewposted.frame.size.height/2);
                }
                else{
                    
                    if (data.imageWidth>280) {
                        x=280/2;
                        x= x-(scell.acindviewposted.frame.size.width/2);
                    }
                    
                    // x= scell.posted.center.x-(scell.acindviewposted.frame.size.width/2);
                    y= scell.posted.center.y-(scell.acindviewposted.frame.size.height/2);
                }
                scell.acindviewposted.frame=CGRectMake(x,y,scell.acindviewposted.frame.size.width,scell.acindviewposted.frame.size.height);
                
                [scell.acindviewposted startAnimating];
                info1.notificationName=HOMEVIEWCONTROLLERIMAGELOADED;
                info1.notifiedObject=data;
                info1.isSmall=0;
                
                if(!info1.isProcessing)
                    [info1 getImage];
                
            }
            
            
            if(self.isiPad)
            {
                if (scell.posted.frame.size.height>400) {
                    dY=scell.posted.frame.origin.y+400+18;
                }
                else{
                    dY=scell.posted.frame.origin.y+scell.posted.frame.size.height+18;
                }
            }
            else
            {
                if (scell.posted.frame.size.height>200) {
                    dY=scell.posted.frame.origin.y+200+7;
                }
                else{
                    dY=scell.posted.frame.origin.y+scell.posted.frame.size.height+7;
                }
                
            }
            
            //dY=scell.posted.frame.origin.y+scell.posted.frame.size.height+7;
            
        }
        else
        {
            scell.posted.hidden=YES;
            scell.acindviewposted.hidden=YES;
            [scell.acindviewposted stopAnimating];
            
        }
        
        if(data.videoUrlStr)
        {
            scell.posted.userInteractionEnabled=YES;
            [scell.posted addGestureRecognizer:self.tapGesture];
        }
        else
        {
//            scell.posted.userInteractionEnabled=NO;
//            [scell.posted removeGestureRecognizer:self.tapGesture];
            scell.posted.userInteractionEnabled=YES;
            [scell.posted addGestureRecognizer:tapgesture2];
            
            scell.videoplayimavw.hidden=YES;
        }
        
        
        
        CGSize   labelTextSize = [self getSizeOfText:data.commentstr :CGSizeMake (scell.cmnts.frame.size.width,10000) :scell.cmnts.font];
        
        /*if(labelTextSize.height<51)
         {
         labelTextSize.height=51;
         }*/
        
        CGRect fr1=scell.cmnts.frame;
        fr1.origin.y=dY;
        fr1.size=labelTextSize;
        scell.cmnts.frame=fr1;
        scell.cmnts.text=data.commentstr;
        
        if(self.isiPad)
        {
            dY=(scell.cmnts.frame.origin.y+scell.cmnts.frame.size.height+18);
        }
        else
        {
            dY=(scell.cmnts.frame.origin.y+scell.cmnts.frame.size.height+7);
        }
        
        CGRect fr=scell.subContainer.frame;
        
        fr.origin.y=dY;
        scell.subContainer.frame=fr;
        dY=(scell.subContainer.frame.origin.y+scell.subContainer.frame.size.height+0);//ch 7 to 0
        
        fr=scell.mainContainer.frame;
        
        fr.size.height=dY;
        scell.mainContainer.frame=fr;
        
        NSLog(@"%f",dY);
        
        scell.mainContainer.layer.borderWidth=1.0;
        scell.mainContainer.layer.borderColor=[self.lightgraycolor CGColor];
        scell.mainContainer.layer.cornerRadius=3.0;
        
        BOOL isLike=data.isLike;
        
        if(isLike)
        {
            scell.likeImage.image=self.likedImage;
            
            scell.likeorunlikelab.text=@"Unlike";
        }
        else
        {
            scell.likeImage.image=self.nonLikedImage;
            
            scell.likeorunlikelab.text=@"Like";
        }
        
        NSString *s=[[NSString alloc] initWithFormat:@"%@",data.likecountlab];//()
        if([data.likecountlab integerValue]>0)
        {
            
            scell.likecountlab.hidden=NO;
            scell.likeslab.hidden=NO;
            scell.likeslabima.hidden=NO;
            scell.viewLikesbt.hidden=NO;
            
            if(data.likecountlab.intValue==1)
                scell.likeslab.text=@"Like";
            else
                scell.likeslab.text=@"Likes";
        }
        else
        {
            
            scell.likecountlab.hidden=YES;
            scell.likeslab.hidden=YES;
            scell.likeslabima.hidden=YES;
            scell.viewLikesbt.hidden=YES;
        }
        scell.likecountlab.text=s;
        [[NSNotificationCenter defaultCenter] postNotificationName:LIKECOUNTCHANGEFORTEXT object:s];
        
        if(data.number_of_comment>0)
        {
            
            scell.commentcountlab.hidden=NO;
            scell.cmntslab.hidden=NO;
            scell.commentslabima.hidden=NO;
            scell.viewCommentsbt.hidden=NO;
            
            if(data.number_of_comment==1)
                scell.cmntslab.text=@"Comment";
            else
                scell.cmntslab.text=@"Comments";
        }
        else
        {
            scell.commentcountlab.hidden=YES;
            scell.cmntslab.hidden=YES;
            scell.commentslabima.hidden=YES;
            scell.viewCommentsbt.hidden=YES;
        }
        scell.commentcountlab.text=data.commentcountlab;
        
        [scell.userima cleanPhotoFrame];
        
        
        if(data.isExistUserImageInfo)
        {
            ImageInfo * info = data.userImageInfo;
            
            if(info.image)
            {
                [scell.userima setImage:info.image];
                [scell.userima applyPhotoFrame];
                scell.userima.hidden=NO;
                scell.acindviewuser.hidden=YES;
                [scell.acindviewuser stopAnimating];
                
            }
            else
            {
                scell.acindviewuser.hidden=NO;
                scell.userima.hidden=YES;
                [scell.acindviewuser startAnimating];
                info.notificationName=HOMEVIEWCONTROLLERIMAGELOADED;
                info.notifiedObject=data;
                
                if(!info.isProcessing)
                    [info getImage];
                
            }
        }
        else
        {
            [scell.userima setImage:self.noImage  ];
            scell.userima.hidden=NO;
            scell.acindviewuser.hidden=YES;
            [scell.acindviewuser stopAnimating];
            
            
        }
        
        
        
        /*if(data.isExistSecondaryImageInfo)
         {
         ImageInfo * info = data.secondaryImageInfo;
         
         if(info.image)
         {
         [scell.userimasecondary setImage:info.image    ];
         scell.userimasecondary.hidden=NO;
         scell.acindviewsecondary.hidden=YES;
         [scell.acindviewsecondary stopAnimating];
         
         }
         else
         {
         scell.acindviewsecondary.hidden=NO;
         scell.userimasecondary.hidden=YES;
         [scell.acindviewsecondary startAnimating];
         info.notificationName=HOMEVIEWCONTROLLERIMAGELOADED;
         info.notifiedObject=data;
         [info getImage];
         }
         }
         else
         {
         [scell.userimasecondary setImage:self.noImage  ];
         scell.userimasecondary.hidden=NO;
         scell.acindviewsecondary.hidden=YES;
         [scell.acindviewsecondary stopAnimating];
         
         
         }*/
        scell.playernamelab.hidden=YES;
        
        
        if(data.playerfname && ((!([data.playerfname isEqualToString:@""])) || (!([data.playerlname isEqualToString:@""]))))
        {
            scell.playernamelab.text=[[NSString alloc] initWithFormat:@"%@ %@",data.playerfname, data.playerlname ];
            
            CGSize labelTextSize11;
            
            if(isiPad)
                labelTextSize11 =[self getSizeOfText:scell.playernamelab.text :CGSizeMake (320,26) :scell.playernamelab.font];
            else
                labelTextSize11 =[self getSizeOfText:scell.playernamelab.text :CGSizeMake (160,20) :scell.playernamelab.font];
            
            
            if(isiPad)
            {
                if(labelTextSize11.width>320)
                    labelTextSize11.width=320;
            }
            else
            {
                if(labelTextSize11.width>160)
                    labelTextSize11.width=160;
            }
            
            scell.playernamelab.frame=CGRectMakeWithSize(scell.playernamelab.frame.origin.x, scell.playernamelab.frame.origin.y, labelTextSize11);
            
            if(isiPad)
            {
                if(appDelegate.isIos7 || appDelegate.isIos8)
                    scell.closebt.frame=CGRectMakeWithSize(((scell.playernamelab.frame.origin.x+scell.playernamelab.frame.size.width)-20),( scell.closebt.frame.origin.y -6),scell.closebt.frame.size);
                else
                    scell.closebt.frame=CGRectMakeWithSize(((scell.playernamelab.frame.origin.x+scell.playernamelab.frame.size.width)-50), scell.closebt.frame.origin.y,scell.closebt.frame.size);
            }
            else
            {
                if(appDelegate.isIos7 || appDelegate.isIos8)
                    scell.closebt.frame=CGRectMakeWithSize(((scell.playernamelab.frame.origin.x+scell.playernamelab.frame.size.width)-10),( scell.closebt.frame.origin.y -3),scell.closebt.frame.size);
                else
                    scell.closebt.frame=CGRectMakeWithSize(((scell.playernamelab.frame.origin.x+scell.playernamelab.frame.size.width)-25), scell.closebt.frame.origin.y,scell.closebt.frame.size);
            }
            
            /*if(appDelegate.isIos7 || appDelegate.isIos8)
             scell.closebt.frame=CGRectMakeWithSize(((scell.playernamelab.frame.origin.x+scell.playernamelab.frame.size.width)-10),( scell.closebt.frame.origin.y -3),scell.closebt.frame.size);
             else
             scell.closebt.frame=CGRectMakeWithSize(((scell.playernamelab.frame.origin.x+scell.playernamelab.frame.size.width)-25), scell.closebt.frame.origin.y,scell.closebt.frame.size);*/
            
            scell.playernamelab.hidden=NO;
        }
        
        
        if(data.isPlayer)
        {
            if(data.playerNameTeam && ((!([data.playerNameTeam isEqualToString:@""])) ))
            {
                scell.playernamelab.text=data.playerNameTeam;
                
                CGSize labelTextSize11;
                
                if(isiPad)
                {
                    labelTextSize11 =[self getSizeOfText:scell.playernamelab.text :CGSizeMake ( 320,26) :scell.playernamelab.font];
                }
                else
                {
                    labelTextSize11 =[self getSizeOfText:scell.playernamelab.text :CGSizeMake ( 160,20) :scell.playernamelab.font];
                }
                
                
                if(isiPad)
                {
                    if(labelTextSize11.width>320)
                        labelTextSize11.width=320;
                }
                else
                {
                    if(labelTextSize11.width>160)
                        labelTextSize11.width=160;
                }
                
                scell.playernamelab.frame=CGRectMakeWithSize(scell.playernamelab.frame.origin.x, scell.playernamelab.frame.origin.y, labelTextSize11);
                
                
                
                if(isiPad)
                {
                    if(appDelegate.isIos7 || appDelegate.isIos8)
                        scell.closebt.frame=CGRectMakeWithSize(((scell.playernamelab.frame.origin.x+scell.playernamelab.frame.size.width)-20),( scell.closebt.frame.origin.y -6),scell.closebt.frame.size);
                    else
                        scell.closebt.frame=CGRectMakeWithSize(((scell.playernamelab.frame.origin.x+scell.playernamelab.frame.size.width)-50), scell.closebt.frame.origin.y,scell.closebt.frame.size);
                }
                else
                {
                    if(appDelegate.isIos7 || appDelegate.isIos8)
                        scell.closebt.frame=CGRectMakeWithSize(((scell.playernamelab.frame.origin.x+scell.playernamelab.frame.size.width)-10),( scell.closebt.frame.origin.y -3),scell.closebt.frame.size);
                    else
                        scell.closebt.frame=CGRectMakeWithSize(((scell.playernamelab.frame.origin.x+scell.playernamelab.frame.size.width)-25), scell.closebt.frame.origin.y,scell.closebt.frame.size);
                }
                scell.playernamelab.hidden=NO;
            }
        }
        scell.postedondatelab.text=/*[appDelegate.dateFormatFullHome stringFromDate:[appDelegate.dateFormatFullOriginalComment dateFromString:data.adddate] ];*/[self getTimeString:[self getTimeStampFromDateString:data.adddate] ];
        
        
        // scell.subContainer.layer.cornerRadius=3.0;
        /* if(!data.isExistPostedImageInfo)
         {*/
        
        [scell.cmnts sizeToFit];
        // }
        
        
        
        //  NSLog(@"mainContainer's Height=%f--------%i",scell.mainContainer.frame.size.height,indexPath.row);
    }
} 






-(void)videoTapped:(UITapGestureRecognizer*)gesture
{
    UIImageView *imaView= (UIImageView*)gesture.view;
    
    
    HomeVCTableCell *cell=(HomeVCTableCell*)imaView.superview.superview.superview;
    
    NSIndexPath *indexPath= [self.tableView indexPathForCell:cell];
    
    
    
    
    
    HomeVCTableData *hvcData   =[self.dataArray objectAtIndex:indexPath.row];
    
    [self btnVideoClicked:hvcData.videoUrlStr ];
    
}


-(void)showRelation:(id)sender
{
    UIButton *bt=(UIButton*)sender;
    HomeVCTableCell *hCell=nil;
    
    
    if(appDelegate.isIos7)
    hCell=(HomeVCTableCell*)bt.superview.superview.superview.superview;
    else
    hCell=(HomeVCTableCell*)bt.superview.superview.superview;
 
    NSIndexPath *indexPath= [self.tableView indexPathForCell:hCell];
    
    
    
    
    
    HomeVCTableData *hvcData =[self.dataArray objectAtIndex:indexPath.row];
    
    
    if([hvcData.userId isEqualToString:[appDelegate.aDef objectForKey:LoggedUserID]])
        return;
    
    if(hvcData.isCoach)
    {
      //[self.relationVC setData:COACH :@"" :0];
    }
    else if(hvcData.isPlayer)
    {
       // [self.relationVC setData:PLAYER :@"" :0];
    }
    else if(hvcData.isPrimary)
    {
  CGSize m1=  [self.relationVC setData:hvcData.playerNameTeam :hvcData.primaryRelation :1];
       // self.relationVC.view.frame=CGRectMakeWithSize(self.relationVC.view.frame.origin.x, self.relationVC.view.frame.origin.y, m1);
         self.relationPopover.contentSize=CGSizeMake(m1.width+20, m1.height+20);
           [self.relationPopover presentPopoverFromView:sender];
    }
    else
    {
      CGSize m1= [self.relationVC setData:hvcData.playerNameTeam :@"" :2];
        //self.relationVC.view.frame=CGRectMakeWithSize(self.relationVC.view.frame.origin.x, self.relationVC.view.frame.origin.y, m1);
        self.relationPopover.contentSize=CGSizeMake(m1.width+20, m1.height+20);
           [self.relationPopover presentPopoverFromView:sender];
    }
    
  
    
    
    //the popover will be presented from the okButton view
 
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // selectedRow=indexPath.row+1;
    
   /*CommentVC *commentView=[[CommentVC alloc] initWithNibName:@"CommentVC" bundle:nil];
    commentView.hvcData=[self.dataArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:commentView animated:YES];*/
    
   
    if(indexPath.row==[self.dataArray count])
    {
        return;
    }
    
    HomeVCTableCell  *cell=(HomeVCTableCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    
    HomeVCTableData *hvcData   =[self.dataArray objectAtIndex:indexPath.row];
    
    NSLog(@"%@",hvcData);
    NSLog(@"%@",self.dataArrayUpIsCreated);
    
//    if([hvcData.userId isEqualToString:[appDelegate.aDef objectForKey:LoggedUserID]] || [[self.dataArrayUpIsCreated objectAtIndex:lastSelectedTeam] integerValue])
//    {    ////AD
    
        hvcData.isShowDelete=!(hvcData.isShowDelete);
        
        if(hvcData.isShowDelete)
            cell.closebt.hidden=NO;
        else
            //cell.closebt.hidden=YES;  ///AD
    cell.closebt.tag=indexPath.row;
//    }
}


- (void)viewDidUnload
{
    self.currenttextvw=nil;
    self.buttonfirstinscroll=nil;
    self.pull=nil;
    [self setMenuupscrollview:nil];
    [self setUpdatesScrollView:nil];
    [self setUpdateslab:nil];
    [self setTableView:nil];
    [self setTeamstatusupdatemainview:nil];
    [self setTableviewupvw:nil];
    [self setTableupview1:nil];
    [self setUpdatetablehideview:nil];
    [self setUpdateuphideview:nil];
    [self setNewloginpopupviewbackground:nil];
    [self setBlankwalllabel:nil];
    [self setPostBackground:nil];
    [self setUpdatebackgr:nil];
    [self setRedbackindicator:nil];
    [self setRednextindicator:nil];
    [self setPostlabel:nil];
    [self setRedbackindicator1:nil];
    [self setRednextindicator1:nil];
    [self setWallfootervw:nil];
    [self setWallfootervwgreydot:nil];
    [self setWallfootervwactivind:nil];
    [self setFirsttimesecondvw:nil];
   // [self setBlankwalllabel:nil];
    [self setBlankwallactlab:nil];
    [self setWallblankconvw:nil];
    [super viewDidUnload];
}

- (IBAction)editupdateTapped:(id)sender
{
    //  self.updatetextvw.editable=NO;//ch
//     self.smsnumbertextl.hidden=NO;
//    [self.updatetextvw becomeFirstResponder];
//    
//    
//    self.updatetablehideview.hidden=NO;
//    self.updateuphideview.hidden=NO;
    TeamUpdateCreateVC *teamupdateVC=[[TeamUpdateCreateVC alloc] initWithNibName:@"TeamUpdateCreateVC" bundle:nil];
    teamupdateVC.defaultText=[self.dataArrayUpTexts objectAtIndex:lastSelectedTeam];
 //   NSLog(@"1.%@----2.%@",teamupdateVC.defaultText,self.updatetextvw.text);
    [teamupdateVC view];

    teamupdateVC.mylab1.text=[self.dataArrayUpButtons objectAtIndex:lastSelectedTeam];
    [self.navigationController pushViewController:teamupdateVC animated:YES];
    
    
}




- (IBAction)newloginviewTapped:(id)sender
{
    int tag=[sender tag];
    
    if(tag==1)
    {
       
      /*  [self.appDelegate.centerViewController showNavController:appDelegate.navigationControllerTeamMaintenance];
        
        [(TeamMaintenanceVC*)[appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] AddTeam:nil];*/
        [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerTeamMaintenance];
        
        if([[appDelegate.navigationControllerTeamMaintenance.viewControllers lastObject] isMemberOfClass:[TeamMaintenanceVC class]])
            [(TeamMaintenanceVC*)[appDelegate.navigationControllerTeamMaintenance.viewControllers lastObject] loadTeamData];
        
            TeamMaintenanceVC *teamVc=  (TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0];
            teamVc.isShowFristTime=YES;
        }
    else if(tag==2)
    {
        
        NSString *body=@"Hi <Receiver's Name>,\n\n         Kindly create team of name <Team Name>, <League Name>, etc.\n\n                                 Thanks,\n                               <Sender's Name>";
        
        [self sendMail:CREATETEAMNOTIFICATION :body];
        
      
    }
      [appDelegate removeUserDefaultValueForKey:NEWLOGIN];
    
    
    [UIView animateWithDuration:1.0 animations:^{
        self.newloginpopupview.alpha=0.0;
    } completion:^(BOOL finished) {
         self.newloginpopupview.hidden=YES;
         self.newloginpopupviewbackground.hidden=YES;
    }];
    
    
}




- (IBAction)postupperviewbtaction:(id)sender
{
    
    [self.commentTextVw resignFirstResponder];
}
- (IBAction)firsttimesecondAction:(id)sender {
    
    //// 16/02/2015 ////
    
    
    InviteCoachViewController *player=[[InviteCoachViewController alloc] initWithNibName:@"InviteCoachViewController" bundle:nil];
//    player.selectedTeamIndex=itemno;
//    player.playerMode=0;
    // [self.navigationController pushViewController:player animated:YES];
    [self.appDelegate.centerViewController presentViewControllerForModal:player];
    
    
    ///////// AD /////////
    
    /*[self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerTeamMaintenance];
    
    if([[appDelegate.navigationControllerTeamMaintenance.viewControllers lastObject] isMemberOfClass:[TeamMaintenanceVC class]]){
        [(TeamMaintenanceVC*)[appDelegate.navigationControllerTeamMaintenance.viewControllers lastObject] loadTeamData];
        TeamMaintenanceVC *teamVc=  (TeamMaintenanceVC*)[self.appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0];
        teamVc.isShowFristTime=YES;
    }*/
     /* [(TeamMaintenanceVC*)[appDelegate.navigationControllerTeamMaintenance.viewControllers objectAtIndex:0] AddTeam:nil];*/
}
- (IBAction)firsttimeFirstAction:(id)sender {
    
    self.firsttimeFirstvw.hidden=YES;
}

- (void)handlePinch2:(UIPinchGestureRecognizer *)recognizer {               //19th......june
    
    self.scrlvw.minimumZoomScale = 1.0;
    self.scrlvw.maximumZoomScale = 5.0;
    
    
}

#pragma mark- scrollvwDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView        //19th......june
{
    return self.hiddenimgvw;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale     //19th......june
{
    //self.scrlvw.contentSize=_hiddenvw.frame.size;
    NSLog(@"zooming in/zooming out ended");
    
}


- (IBAction)closeaction:(id)sender {
    
    
    _hiddenvw.hidden=YES;
    
    self.scrlvw.zoomScale = 1.0;
    
}

-(void)imageTapped:(UITapGestureRecognizer*)gesture           //19th.....june
{
    
    UIImageView *imaView= (UIImageView*)gesture.view;
    
    
    HomeVCTableCell *cell=(HomeVCTableCell*)imaView.superview.superview.superview;
    
    NSIndexPath *indexPath= [self.tableView indexPathForCell:cell];
    
    
    HomeVCTableData *hvcData =[self.dataArray objectAtIndex:indexPath.row];
    
    
    _hiddenvw.hidden=NO;
    
    
    _hiddenimgvw.image=hvcData.postedImageInfo.image;
    
    pinchgesture=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handlePinch2:)];
    // doubleTapgesture.numberOfTapsRequired=2;
    
    [_hiddenvw addGestureRecognizer:pinchgesture];
    
    
    
    CGFloat img_height=hvcData.postedImageInfo.image.size.height;
    
    CGFloat img_width=hvcData.postedImageInfo.image.size.width;
    
    
    
    //    CGFloat imgvw_w=_hiddenimgvw.image.size.width;
    //    CGFloat imgvw_h=_hiddenimgvw.image.size.height;
    
    CGFloat imgvw_w=320;
    
    CGFloat imgvw_h=385;
    
    
    CGFloat new_imgvwWidth;
    
    CGFloat new_imgvwHeight;
    
    CGFloat y=0,x=0;
    
    if(imgvw_w<img_width)
    {
        
        
        new_imgvwHeight=(imgvw_w*img_height)/img_width;
        
        
        
        
        // imgvw_w=img_width;
        
        if(new_imgvwHeight<img_height)
        {
            y=(imgvw_h-new_imgvwHeight)/2;
            
            x=0;
            
            _hiddenimgvw.frame=CGRectMake(x, y, imgvw_w, new_imgvwHeight);
            
        }
        
    }
    
    
    else if (imgvw_w>img_width)
    {
        y=(imgvw_h-img_height)/2;
        
        x=(imgvw_w-img_width)/2;
        
        
        
        _hiddenimgvw.frame=CGRectMake(x, y, img_width, img_height);
        
    }
    
    
    
    else if (imgvw_w==img_width)
    {
        if(img_height<imgvw_h)
        {
            y=(imgvw_h-img_height)/2;
        }
        
        
        _hiddenimgvw.frame=CGRectMake(x, y, img_width, img_height);
    }
    
    
    _hiddenvw.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    
    
    [UIView animateWithDuration:0.4 animations:^{
        _hiddenvw.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    
}


/*
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

*/

@end
