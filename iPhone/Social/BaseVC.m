//
//  BaseVC.m
//  LinkBook
//
//  Created by Piyali on 21/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PostLikeViewController.h"
#import "CommentVC.h"
#import "Invite.h"
#import "Contacts.h"
#import "MBProgressHUD.h"
#import "BaseVC.h"
#import "Event.h"
#import "PlayerRelationVC.h"
#import "FPPopoverController.h"
#import "ShowVideoViewController.h"
#import "CenterViewController.h"
#import "EventEditViewController.h"
#import "PlayerListViewController.h"

//#import "MPMoviePlayerController.h"
//#import "ProgressViewController.h"
//#import "FacebookVC.h"
/*#import <sys/utfconv.h>
#import <sys/utfname.h>*/
//#import "UIDevice-Hardware.h"

/*@interface MPMoviePlayerViewController (oritation)


@end

@implementation MPMoviePlayerViewController (oritation)

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape | UIInterfaceOrientationMaskPortrait;
}

@end*/

@implementation BaseVC
@synthesize privateDotImage,publicDotImage,landscapeOnlyOrientation;
@synthesize appDelegate,fetchedResultsController,managedObjectContext,calender,ctimezone,baseview,basetimer,isiPad,isiPhone,isiPhone5,isLandscape,mybt1,mylab1,darkgraycolor,graycolor,lightgraycolor,whitecolor,blackcolor,clearcolor,isBusy,lightbluecolor,lightblackcolor,/*tmvc,*/popupview,fvc2,fvc1,smsfiringdate,inappalert/*,wview*/,isFromEmailShare,isFromSMSShare,darkGrayColor,redcolor,camActionSheet,imagepicker,popoverController,noImage,requestDic,arrPickerItemsAlert,arrPickerItemsRepeat,sinReq1,sinReq2,sinReq3,sinReq4,tapGesture,helveticaFont,relationPopover,crossImage,tickImage,questionmarkImage,isShowTrainningVideoOption,teamNoImage,postLikeVC,commVC,helveticaFontForte,helveticaFontForteBold,helveticaFontBold,isShowActionSheetFromSelf;

@synthesize topimav,topview,cellgreencolor,systemVersion,loadingtimer,noofbatchalertview,myFormRequest1,myFormRequest2,myPlainRequest1,myPlainRequest2,storeCreatedRequests,logoutActionSheet,noVideThumbImage,relationVC,noAlbumImage,maybeQuestionmarkImage,teamGrayImage,teamRedImage,dateGrayImage,dateRedImage,playergrayImage,playerRedImage,isModallyPresentFromCenterVC,leftBarButtonItem,rightBarButtonItem;

@synthesize imageDtae,photoImage,videoImage,playerImage,sportsImage;

@synthesize adminTypeArr; //// 13/01/2015

@synthesize itemdefaultImage;
@synthesize playerAttendance;

@synthesize sportsImageArr;
@synthesize baseballImage,basketballImage,cricketImage,americanfotballImage,hockeyImage,soccerImage,lacrosseImage;
@synthesize badmintonImage,bicyclingImage,chessImage,fieldhockeyImage,fishingImage,footballImage,iceHockeyImage,kayakingImage,picnicImage,reunionImage,rowingImage,runningImage,skiingImage,tabletennisImage,tennisImage,walkingImage;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    NSString *xibName=nil;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        
    {
        xibName=[NSString stringWithFormat:@"%@_iPad",nibNameOrNil];
        
    }
    else{
        xibName=[NSString stringWithFormat:@"%@",nibNameOrNil];
    }
   /* if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        
    {
        
        CGSize result = [[UIScreen mainScreen] bounds].size;
        
        if(result.height == 480)
            
        {
            
            xibName=[NSString stringWithFormat:@"%@",nibNameOrNil];
            
        }
        
        if(result.height == 568)
            
        {
            
            xibName=[NSString stringWithFormat:@"%@_568",nibNameOrNil];
            
    
        }
        
    }*/
    
    /*self = [super initWithNibName:xibName bundle:nibBundleOrNil];
    
    if (self) {
        
        // Custom initialization
        
    }*/
    

    
    self = [super initWithNibName:xibName bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        @autoreleasepool {
            
        
        self.arrPickerItemsRepeat=[NSArray arrayWithObjects:@"Never",@"Every Day",@"Every Week",@"Every Month",@"Every Year", nil];
        self.arrPickerItemsAlert=[NSArray arrayWithObjects:@"Never",@"At time of event",@"5 mintues before",@"15 mintues before",@"30 mintues before",@"1 hour before",@"2 hours before",@"1 day before",@"2 days before", nil];
        }
        
        self.requestDic=nil;
        isFromSMSShare=0;
        isFromEmailShare=0;
        self.appDelegate = (AppDelegate* )[[UIApplication sharedApplication] delegate];
        self.managedObjectContext = appDelegate.managedObjectContext;
        self.systemVersion=[[[UIDevice currentDevice] systemVersion] floatValue];
        self.ctimezone=[NSTimeZone localTimeZone];
        self.calender=[NSCalendar currentCalendar];
        
        self.basetimer=nil;
        
        sinReq1=nil;
        sinReq2=nil;
        sinReq3=nil;
        sinReq4=nil;
        
        
        myFormRequest1=nil;
        myFormRequest2=nil;
        myPlainRequest1=nil;
        myPlainRequest2=nil;
    }
    return self;
}
- (void)dealloc
{
    
   // self.wview=nil;
   // self.fvc1=nil;
  
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HANDLERECEIVEDMEMORYWARNING object:nil];
    
    
    [basetimer invalidate];
    [loadingtimer invalidate];
//    self.tmvc=nil;
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
   // NSLog(@"ReceiveMemoryWarningClass=%@",NSStringFromClass([self class]));
    
    [[NSNotificationCenter defaultCenter] postNotificationName:HANDLERECEIVEDMEMORYWARNING object:nil];
    
    
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




-(void)showModal:(id)vc
{
    UIViewController *vv=nil;
   
    if(isModallyPresentFromCenterVC)
    vv=appDelegate.centerViewController;
    else
        vv=self;
    
    if(systemVersion>=5.0)
    {
        [vv presentViewController:vc animated:YES completion:nil];
    }
    else
    {
        [vv presentModalViewController:vc animated:YES];
    }
}

-(void)dismissModal
{
    UIViewController *vv=nil;
    
    if(isModallyPresentFromCenterVC)
        vv=appDelegate.centerViewController;
    else
        vv=self;
    
    
    
    if(systemVersion>=5.0)
    {
        
        [vv dismissViewControllerAnimated:YES completion:nil];
       
    }
    else
    {
        [vv dismissModalViewControllerAnimated:YES];
    }
    
    isModallyPresentFromCenterVC=0;
}

///////  6/03/2015  ///////

-(void)showModalEventInvite:(id)vc
{
    UIViewController *vv=nil;
    
    if(isModallyPresentFromCenterVC)
        vv=appDelegate.eventEditViewController;
    else
        vv=self;
    
    if(systemVersion>=5.0)
    {
        [vv presentViewController:vc animated:YES completion:nil];
    }
    else
    {
        [vv presentModalViewController:vc animated:YES];
    }
}

-(void)dismissModalEventInvte
{
    UIViewController *vv=nil;
    
    if(isModallyPresentFromCenterVC)
        vv=appDelegate.eventEditViewController;
    else
        vv=self;
    
    
    
    if(systemVersion>=5.0)
    {
        
        [vv dismissViewControllerAnimated:YES completion:nil];
        
    }
    else
    {
        [vv dismissModalViewControllerAnimated:YES];
    }
    
    isModallyPresentFromCenterVC=0;
}

////////  AD ///////


-(void)dismissModalArg:(UIViewController*)sender
{
    if(systemVersion>=5.0)
    {
        
        [sender dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [sender dismissModalViewControllerAnimated:YES];
    }
}


#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidUnload
{
    [self setPopupview:nil];
    [loadingtimer invalidate];
    self.loadingtimer=nil;
    [basetimer invalidate];
          self.mybt1=nil;
       self.mylab1=nil;
       self.topview=nil;
    self.topimav=nil;
    
    self.noofbatchalertview=nil;
    
    self.leftBarButtonItem=nil;
    self.rightBarButtonItem=nil;
    
      [super viewDidUnload];
}

-(void)setStatusBarStyleOwnApp:(BOOL)isLightContent
{
    
    if(appDelegate.isIos7 || appDelegate.isIos8)
    {
        
        if (isLightContent)
      [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        else
      [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handelMemoryWarning) name:HANDLERECEIVEDMEMORYWARNING object:nil];
    
    isModallyPresentFromCenterVC=0;
    
    
    
    @autoreleasepool {
        
      
       self.privateDotImage=[UIImage imageNamed:@"Dot-Image-with-P-text.png"];
    self.publicDotImage=[UIImage imageNamed:@"Grey dot.png"];
    self.noImage=[UIImage imageNamed:@"avatarnewround.png"];
        self.teamNoImage=[UIImage imageNamed:@"no_image.png"];
    ////////////////
    self.noVideThumbImage=[UIImage imageNamed:@"default video.png"];
    self.noAlbumImage=[UIImage imageNamed:@"default image.png"];
    ////////////////
        self.itemdefaultImage=[UIImage imageNamed:@"item_upload_image.png"];
     self.darkGrayColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"darkgray.png"]];
      self.lightbluecolor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"redcolor.png"]];
        
        
        // Sport Images
        
        
       
        self.baseballImage=[UIImage imageNamed:@"sport_baseball.png"];
        self.basketballImage=[UIImage imageNamed:@"sport_basketball.png"];
        self.cricketImage=[UIImage imageNamed:@"sport_cricket.png"];
        self.americanfotballImage=[UIImage imageNamed:@"sport_american football.png"];
        self.hockeyImage=[UIImage imageNamed:@"sport_hockey.png"];
        self.lacrosseImage=[UIImage imageNamed:@"sport_lacrosse.png"];
        self.soccerImage=[UIImage imageNamed:@"sport_soccer.png"];
        self.volleyballImage=[UIImage imageNamed:@"sport_volley ball.png"];
        
        
        self.badmintonImage=[UIImage imageNamed:@"sport_badminton.png"];
        self.bicyclingImage=[UIImage imageNamed:@"sport_bicycling.png"];
        self.chessImage=[UIImage imageNamed:@"sport_chess.png"];
        self.fishingImage=[UIImage imageNamed:@"sport_fishing.png"];
        self.footballImage=[UIImage imageNamed:@"sport_football.png"];
        self.iceHockeyImage=[UIImage imageNamed:@"sport_ice_hockey.png"];
        self.kayakingImage=[UIImage imageNamed:@"sport_kayaking.png"];
        self.picnicImage=[UIImage imageNamed:@"sport_picnic.png"];
        self.reunionImage=[UIImage imageNamed:@"sport_reunion.png"];
        self.rowingImage=[UIImage imageNamed:@"sport_rowing.png"];
        self.runningImage=[UIImage imageNamed:@"sport_running.png"];
        self.skiingImage=[UIImage imageNamed:@"sport_skiing.png"];
        self.tabletennisImage=[UIImage imageNamed:@"sport_table_tennis.png"];
        self.tennisImage=[UIImage imageNamed:@"sport_tennis.png"];
        self.walkingImage=[UIImage imageNamed:@"sport_walking.png"];
        
        
      

        
       self.sportsImageArr=[[NSMutableArray alloc] initWithObjects:self.americanfotballImage,self.badmintonImage,self.baseballImage,self.basketballImage,self.bicyclingImage,self.chessImage, self.cricketImage,self.hockeyImage,self.fishingImage,self.footballImage,self.iceHockeyImage,self.kayakingImage,self.lacrosseImage,self.picnicImage,self.reunionImage,self.rowingImage,self.runningImage,self.skiingImage,self.soccerImage,self.tabletennisImage,self.tennisImage,self.volleyballImage,self.walkingImage, nil];


        self.adminTypeArr=[[NSMutableArray alloc] initWithObjects:@"coach",@"manager",@"team parent",@"other", nil];   //// 13/01/2015
       
        
        
        
        self.imageDtae=[UIImage imageNamed:@"photo_date.png"];
        self.playerImage=[UIImage imageNamed:@"photo_player.png"];
        self.photoImage=[UIImage imageNamed:@"photo_camera.png"];
        self.sportsImage=[UIImage imageNamed:@"photo_sport.png"];
        self.videoImage=[UIImage imageNamed:@"photo_video.png"];
        
        
        
        
        self.clearcolor=[UIColor clearColor];
        self.blackcolor=[UIColor blackColor];
        self.whitecolor=[UIColor whiteColor];
        self.graycolor=[UIColor grayColor];
        self.lightgraycolor=[UIColor lightGrayColor];
        self.darkgraycolor=[UIColor darkGrayColor];
        self.cellgreencolor=[UIColor whiteColor];
         self.redcolor=[UIColor redColor];
    }
     
    [self.view addSubview:self.popupview ];
    self.popupview.hidden=YES;
    
   
    
    
  
    
   
    
  
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
  
    
    
    
    
  
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        // iPad-specific interface here
        isiPad=1;
        isiPhone=0;
        isiPhone5=0;
        
      
        
        
    }
    else
    {
        // iPhone and iPod touch interface here
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        if (screenBounds.size.height == 568)
        {
            isiPhone5=1;
            isiPhone=0;
            isiPad=0;
        }
        else
        {
            isiPhone5=0;
            isiPad=0;
            isiPhone=1;
        }
    }
    
    
   /* if([self interfaceOrientation]==UIDeviceOrientationLandscapeLeft || [self interfaceOrientation]==UIDeviceOrientationLandscapeRight)
    {
        isLandscape=1;
       
    }
    else
    {
         isLandscape=0;
    }*/
    
    
   
    
    
    [self createBottomView];
    self.topimav.userInteractionEnabled=YES;
    
    
    
   
    
  
    //@"blueborder.png"
  //  self.lightbluecolor=[[UIColor alloc] initWithRed:1.11 green:1.32 blue:1.85 alpha:1.0];
// self.lightblackcolor=[[UIColor alloc] initWithRed:0.51 green:0.51 blue:0.51 alpha:1.0];
  
    //[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundpattern.png"]];
}



-(void)showNavigationBarButtons
{
    
}



-(void)handelMemoryWarning
{
    
   // NSLog(@"NotifiedHandleMemoryWarning");
    NSMutableArray *ar=[[NSMutableArray alloc] init];
    
    for(id m in self.storeCreatedRequests)
    {
        
        if([m isMemberOfClass:[SingleRequest class]])
        {
            SingleRequest *m1=(SingleRequest*)m;
            
            if(![m1.myRequest isExecuting])
            {
                [ar addObject:m1];
            }
            
        }
        else if([m isMemberOfClass:[ASIHTTPRequest class]])
        {
            ASIHTTPRequest *m1=(ASIHTTPRequest*)m;
            
            if(![m1 isExecuting])
            {
                [ar addObject:m1];
            }
        }
        else if([m isMemberOfClass:[ASIFormDataRequest class]])
        {
            ASIFormDataRequest *m1=(ASIFormDataRequest*)m;
            
            if(![m1 isExecuting])
            {
                [ar addObject:m1];
            }
        }
        
        
        
    }
    
    
    
    for(id m1 in ar)
    {
        [self.storeCreatedRequests removeObject:m1];
    }
    
   
#if __has_feature(objc_arc)
   
#else
     [ar release];
#endif
    
    
    ar=nil;
    
}



-(void)setLayOutForLanguage
{
    
}

/**/

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setuporientation ];
    
  //  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userListUpdated:) name:USERLISTING object:nil];
  
  /*  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageUpdated:) name:SESSIONSTATEOPEN object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(facebookRequestFinished:) name:SESSIONLogIn object:nil];*/
    
}


-(void)userListUpdated:(id)sender
{
    SingleRequest *sReq=(SingleRequest*)[sender object];
    if([sReq.notificationName isEqualToString:USERLISTING])
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
                        NSArray *userList=[aDic1 objectForKey:@"user_list"];
                        
                        [self storeUser:userList];
                        
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



-(void)storeUser:(NSArray*)userarray
{
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
	
    [request setEntity:[NSEntityDescription entityForName:CONTACTS inManagedObjectContext:self.managedObjectContext]];
	
       NSArray* ar = [self.managedObjectContext executeFetchRequest:request error:nil];
    for(NSManagedObject *anObj in ar)
    {
        [self.managedObjectContext deleteObject:anObj];
    }
  
    [appDelegate saveContext];
     for(NSDictionary *dic in userarray)
     {
         
         if(![[dic objectForKey:@"UserID"] isEqualToString:[appDelegate.aDef objectForKey:LoggedUserID]])
         {
             
             
             NSString *userid=[dic objectForKey:@"UserID"];
             NSPredicate *predcate=[NSPredicate predicateWithFormat:@"userId==%@",userid];
             [request setPredicate:predcate];
             NSArray* ar = [self.managedObjectContext executeFetchRequest:request error:nil];
             
             if(ar.count==0)
             {
                 
                 
                 
                 
                 Contacts *aContact=  [NSEntityDescription insertNewObjectForEntityForName:CONTACTS inManagedObjectContext:self.managedObjectContext];
                 
                 
                 NSString *name=[dic objectForKey:@"Name"];//[NSString stringWithFormat:@"%@ %@", [dic objectForKey:@"FirstName"] ,[dic objectForKey:@"LastName"]];
                 
                 aContact.contactName=name;
                  aContact.email=[dic objectForKey:@"Email"];
                 char ch;
                 if (name.length > 0)
                 {
                     
                   ch = [name characterAtIndex:0];
                     
                  
                     
                 }
                 else
                 {
                     ch = [aContact.email characterAtIndex:0];
                 }
                 NSString* fc = [[NSString stringWithFormat:@"%c",ch] uppercaseString];
                 
                 aContact.cFirstChar=fc;
                
                 aContact.userId=userid;
                 
             }
         }
     }
      [appDelegate saveContext];
}




-(NSMutableArray*)getImageInfoArrayThroughConvert:(NSMutableArray*)marray
{
    NSMutableArray *arr=[NSMutableArray array];
    
    
    ImageInfo *userImainfo=nil;
    
    
    for(NSString* str in marray)
    {
        userImainfo=  [[ImageInfo alloc] initWithSourceURL:[NSURL URLWithString:str]];
        
        
        [arr addObject:userImainfo];
        
    }
    
    
    return arr;
}



-(void)deleteAllInvites//:(NSArray*)userarray
{
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
	
    [request setEntity:[NSEntityDescription entityForName:INVITE inManagedObjectContext:self.managedObjectContext]];
	NSArray* ar = [self.managedObjectContext executeFetchRequest:request error:nil];
    
    for(NSManagedObject *anObj in ar)
    {
        [self.managedObjectContext deleteObject:anObj];
    }
    
    [appDelegate saveContext];
    
   /* for(NSDictionary *dic in userarray)
    {
        
        if(![[dic objectForKey:@"UserID"] isEqualToString:[appDelegate.aDef objectForKey:LoggedUserID]])
        {
            Contacts *aContact=  [NSEntityDescription insertNewObjectForEntityForName:CONTACTS inManagedObjectContext:self.managedObjectContext];
            
            
            NSString *name=[NSString stringWithFormat:@"%@ %@", [dic objectForKey:@"FirstName"] ,[dic objectForKey:@"LastName"]];
            
            aContact.contactName=name;
            if (name.length > 0)
            {
                
                char ch = [name characterAtIndex:0];
                
                NSString* fc = [[NSString stringWithFormat:@"%c",ch] uppercaseString];
                
                aContact.cFirstChar=fc;
                
            }
            else
            {
                aContact.cFirstChar=nil;
            }
            aContact.email=[dic objectForKey:@"Email"];
            aContact.userId=[dic objectForKey:@"UserID"];
            
            [appDelegate saveContext];
        }
    }
    
    */
}



-(NSDate*)getAlertDateForAlertString:(NSString*)str :(NSDate*)date
{
    
    
    
    NSDate *retDate=nil;
    
    if([str isEqualToString:@"At time of event"])
    {
        retDate= date;
    }
    else if([str isEqualToString:@"5 mintues before"])
    {
        retDate=  [date dateByAddingTimeInterval:(-(5*60))];
    }
    else if([str isEqualToString:@"15 mintues before"])
    {
        retDate=  [date dateByAddingTimeInterval:(-(15*60))];
    }
    else if([str isEqualToString:@"30 mintues before"])
    {
        retDate= [date dateByAddingTimeInterval:(-(30*60))];
    }
    else if([str isEqualToString:@"1 hour before"])
    {
        retDate= [date dateByAddingTimeInterval:(-(60*60))];
    }
    else if([str isEqualToString:@"2 hours before"])
    {
        retDate= [date dateByAddingTimeInterval:(-(2*60*60))];
    }
    else if([str isEqualToString:@"1 day before"])
    {
        retDate=  [date dateByAddingTimeInterval:(-(24*60*60))];
    }
    else if([str isEqualToString:@"2 days before"])
    {
        retDate=  [date dateByAddingTimeInterval:(-(2*24*60*60))];
    }
    
    
    return retDate;
}

-(void)deleteAllEvents:(NSString*)teamId
{
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
	
    [request setEntity:[NSEntityDescription entityForName:EVENT inManagedObjectContext:self.managedObjectContext]];
    
    if(teamId)
    [request setPredicate:[NSPredicate predicateWithFormat:@"isPublic==%i && teamId==%@",1,teamId]];
    else
    [request setPredicate:[NSPredicate predicateWithFormat:@"isPublic==%i",1]];
    
    
	NSArray* ar = [self.managedObjectContext executeFetchRequest:request error:nil];
    
    for(Event *dataEvent in ar)
    {
        if(dataEvent)
        {
            EKEvent *newEvent=nil;
            
            
            newEvent= [appDelegate.eventStore eventWithIdentifier:((Event*)dataEvent).eventIdentifier];
            
            NSError *error=nil;
            BOOL save=  [appDelegate.eventStore removeEvent:newEvent span:EKSpanFutureEvents commit:YES error:&error ];
            NSLog(@"DeleteEventStatus=%i \n%@",save,error.description);
            
            /*if(save || dataEvent.isPublicAccept.intValue)
            {*/
                [self.managedObjectContext deleteObject:dataEvent];
            //}
        }
    }
    
    [appDelegate saveContext];
    
    
  
    
    
    
    
    
    
   /* NSFetchRequest * request1 = [[NSFetchRequest alloc] init];
	
    [request1 setEntity:[NSEntityDescription entityForName:EVENTUNREAD inManagedObjectContext:self.managedObjectContext]];
    [request1 setPredicate:[NSPredicate predicateWithFormat:@"type==%i",5]];
	NSArray* ar1 = [self.managedObjectContext executeFetchRequest:request1 error:nil];
    
    for(Invite *dataEvent in ar1)
    {
        if(dataEvent)
        {
            
                [self.managedObjectContext deleteObject:dataEvent];
            
        }
    }
    
    [appDelegate saveContext];
    
    */

}






-(NSManagedObject*)objectOfType:(NSString*) aType forName:(NSString*) aKey  andManObjCon:(NSManagedObjectContext*)managedobjectContext
{
    id anObj = nil;
	
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
	
    [request setEntity:[NSEntityDescription entityForName:aType inManagedObjectContext:managedobjectContext]];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"email == %@",aKey]];
    
	NSArray* ar = [managedobjectContext executeFetchRequest:request error:nil];
	if ([ar count]>0)
    {
		
		
        anObj=  [ar objectAtIndex:0];
		
	}
	
	
	
    return anObj;
	
}

-(Invite*)objectOfTypeInvite:(NSString*) aType forTeam:(NSString*) aKey  andManObjCon:(NSManagedObjectContext*)managedobjectContext
{
    id anObj = nil;
	
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
	
    [request setEntity:[NSEntityDescription entityForName:aType inManagedObjectContext:managedobjectContext]];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"teamId == %@ AND type==%i",aKey,0]];
    
	NSArray* ar = [managedobjectContext executeFetchRequest:request error:nil];
	if ([ar count]>0)
    {
		
		
        anObj=  [ar objectAtIndex:0];
		
	}
	
	
	
    return anObj;
	
}



-(Invite*)objectOfTypeInviteTeamResponse:(NSString*) aType forTeam:(NSString*) aKey  andManObjCon:(NSManagedObjectContext*)managedobjectContext
{
    id anObj = nil;
	
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
	
    [request setEntity:[NSEntityDescription entityForName:aType inManagedObjectContext:managedobjectContext]];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"playerId == %@ AND type==%i",aKey,7]];
    
	NSArray* ar = [managedobjectContext executeFetchRequest:request error:nil];
	if ([ar count]>0)
    {
		
		
        anObj=  [ar objectAtIndex:0];
		
	}
	
	
	
    return anObj;
	
}


-(Invite*)objectOfTypeInviteAdminResponse:(NSString*) aType forTeam:(NSString*) aKey forAdmin:(NSString*) aKey1 andManObjCon:(NSManagedObjectContext*)managedobjectContext
{
    id anObj = nil;
	
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
	
    [request setEntity:[NSEntityDescription entityForName:aType inManagedObjectContext:managedobjectContext]];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"playerId == %@ AND teamId == %@ AND type==%i",aKey1,aKey,15]];
    
	NSArray* ar = [managedobjectContext executeFetchRequest:request error:nil];
	if ([ar count]>0)
    {
		
		
        anObj=  [ar objectAtIndex:0];
		
	}
	
	
	
    return anObj;
	
}


-(Invite*)objectOfTypeInviteTeamEventResponse:(NSString*) aType forTeam:(NSString*) aKey forEventId:(NSString*) aKey1 andManObjCon:(NSManagedObjectContext*)managedobjectContext
{
    id anObj = nil;
	
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
	
    [request setEntity:[NSEntityDescription entityForName:aType inManagedObjectContext:managedobjectContext]];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"playerId == %@ AND eventId == %@ AND type==%i",aKey,aKey1,12]];
    
	NSArray* ar = [managedobjectContext executeFetchRequest:request error:nil];
	if ([ar count]>0)
    {
		
		
        anObj=  [ar objectAtIndex:0];
		
	}
	
	
	
    return anObj;
	
}



-(Invite*)objectOfTypeInviteTeamResponseForUser:(NSString*) aType forId:(NSString*) aKey  andManObjCon:(NSManagedObjectContext*)managedobjectContext
{
    id anObj = nil;
	
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
	
    [request setEntity:[NSEntityDescription entityForName:aType inManagedObjectContext:managedobjectContext]];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"teamId == %@ AND type==%i",aKey,10]];
    //player
	NSArray* ar = [managedobjectContext executeFetchRequest:request error:nil];
	if ([ar count]>0)
    {
		
		
        anObj=  [ar objectAtIndex:0];
		
	}
	
	
	
    return anObj;
	
}



-(Invite*)objectOfTypeInviteTeamEventResponseForUser:(NSString*) aType forId:(NSString*) aKey  forEventId:(NSString*) aKey1 andManObjCon:(NSManagedObjectContext*)managedobjectContext
{
    id anObj = nil;
	
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
	
    [request setEntity:[NSEntityDescription entityForName:aType inManagedObjectContext:managedobjectContext]];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"teamId == %@ AND eventId==%@ AND type==%i",aKey,aKey1,11]];
    //player
	NSArray* ar = [managedobjectContext executeFetchRequest:request error:nil];
	if ([ar count]>0)
    {
		
		
        anObj=  [ar objectAtIndex:0];
		
	}
	
	
	
    return anObj;
	
}


-(Invite*)objectOfTypeInvite:(NSString*) aType forTeam1:(NSString*) aKey  andManObjCon:(NSManagedObjectContext*)managedobjectContext
{
    id anObj = nil;
	
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
	
    [request setEntity:[NSEntityDescription entityForName:aType inManagedObjectContext:managedobjectContext]];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"teamId == %@ AND (type==%i OR type==%i)",aKey,0,4]];
    
	NSArray* ar = [managedobjectContext executeFetchRequest:request error:nil];
	if ([ar count]>0)
    {
		
		
        anObj=  [ar objectAtIndex:0];
		
	}
	
	
	
    return anObj;
	
}


-(Invite*)objectOfTypeTeamInvite:(NSString*) aType forTeam1:(NSString*) aKey  andManObjCon:(NSManagedObjectContext*)managedobjectContext
{
    id anObj = nil;
	
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
	
    [request setEntity:[NSEntityDescription entityForName:aType inManagedObjectContext:managedobjectContext]];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"teamId == %@ AND type==%i",aKey,0]];
    
	NSArray* ar = [managedobjectContext executeFetchRequest:request error:nil];
	if ([ar count]>0)
    {
		
		
        anObj=  [ar objectAtIndex:0];
		
	}
	
	
	
    return anObj;
	
}


-(Invite*)objectOfTypeAdminInvite:(NSString*) aType forTeam1:(NSString*) aKey  andManObjCon:(NSManagedObjectContext*)managedobjectContext
{
    id anObj = nil;
	
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
	
    [request setEntity:[NSEntityDescription entityForName:aType inManagedObjectContext:managedobjectContext]];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"teamId == %@ AND type==%i",aKey,14]];
    
	NSArray* ar = [managedobjectContext executeFetchRequest:request error:nil];
	if ([ar count]>0)
    {
		
		
        anObj=  [ar objectAtIndex:0];
		
	}
	
	
	
    return anObj;
	
}


-(Invite*)objectOfTypeInvite:(NSString*) aType forTeam:(NSString*) aKey forUpdate:(int)m andManObjCon:(NSManagedObjectContext*)managedobjectContext
{
    id anObj = nil;
	
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
	
    [request setEntity:[NSEntityDescription entityForName:aType inManagedObjectContext:managedobjectContext]];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"teamId == %@ AND type==%i",aKey,m]];
    
	NSArray* ar = [managedobjectContext executeFetchRequest:request error:nil];
	if ([ar count]>0)
    {
		
		
        anObj=  [ar objectAtIndex:0];
		
	}
	
	
	
    return anObj;
	
}


-(NSManagedObject*)objectOfTypeInvite:(NSString*) aType forTeam:(NSString*) aKey forUpdate:(int)m forUpdateId:(NSString*)updateid andManObjCon:(NSManagedObjectContext*)managedobjectContext
{
    id anObj = nil;
	
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
	
    [request setEntity:[NSEntityDescription entityForName:aType inManagedObjectContext:managedobjectContext]];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"teamId == %@ AND type==%i AND postId==%@",aKey,m,updateid]];
    
	NSArray* ar = [managedobjectContext executeFetchRequest:request error:nil];
	if ([ar count]>0)
    {
		
		
        anObj=  [ar objectAtIndex:0];
		
	}
	
	
	
    return anObj;
	
}


-(Invite*)objectOfTypeInvite:(NSString*) aType forPost:(NSString*) aKey forUser:(NSString*) aKey1 forType:(int) type andManObjCon:(NSManagedObjectContext*)managedobjectContext
{
    id anObj = nil;
	
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
	
    [request setEntity:[NSEntityDescription entityForName:aType inManagedObjectContext:managedobjectContext]];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"postId==%@ AND userId==%@ AND type == %i",aKey,aKey1,type]];
    
	NSArray* ar = [managedobjectContext executeFetchRequest:request error:nil];
	if ([ar count]>0)
    {
		
		
        anObj=  [ar objectAtIndex:0];
		
	}
	
	
	
    return anObj;
	
}


-(Invite*)objectOfTypeInvite:(NSString*) aType forType:(int) type andManObjCon:(NSManagedObjectContext*)managedobjectContext
{
    id anObj = nil;
	
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
	
    [request setEntity:[NSEntityDescription entityForName:aType inManagedObjectContext:managedobjectContext]];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"userId==%@ AND type == %i",[appDelegate.aDef objectForKey:LoggedUserID],type]];
    
	NSArray* ar = [managedobjectContext executeFetchRequest:request error:nil];
	if ([ar count]>0)
    {
		
		
        anObj=  [ar objectAtIndex:0];
		
	}
	
	
	
    return anObj;
	
}


-(void)setLogOut
{
}

-(void)changeSubviewsFrame
{
if(!isLandscape)
{
   
    
    
    
    
    
    
}
else
{
    
}
}


-(void)getUserListing:(NSString*)teamId :(NSString*)search :(NSString*)limit :(NSString*)start :(BOOL)mode
{
    
    if(!storeCreatedRequests)
        storeCreatedRequests=[[NSMutableArray alloc] init];
    
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    if(mode)
    {
    [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
        
    [command setObject:teamId forKey:@"team_id"];
    }
     [command setObject:search forKey:@"search"];
     [command setObject:limit forKey:@"limit"];
     [command setObject:start forKey:@"start"];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    
    SingleRequest *sinReq=nil;
    
    if(mode)
    sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:FILTEREDUSERLISTINGLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
    else
    sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:USERLISTINGLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
    
     self.sinReq1=sinReq;
    [self.storeCreatedRequests addObject:self.sinReq1];
    sinReq.notificationName=USERLISTING;
    
    [sinReq startRequest];
    
   
   
    
}


-(void)getUserListingPush:(NSString*)teamId :(NSString*)search :(NSString*)limit :(NSString*)start :(BOOL)mode
{
    
    if(!storeCreatedRequests)
        storeCreatedRequests=[[NSMutableArray alloc] init];
    
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    if(mode)
    {
        [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
        [command setObject:teamId forKey:@"team_id"];
    }
    [command setObject:search forKey:@"search"];
    [command setObject:limit forKey:@"limit"];
    [command setObject:start forKey:@"start"];
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    
    SingleRequest *sinReq=nil;
    
    if(mode)
        sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:FILTEREDUSERLISTINGLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
    else
        sinReq= [[SingleRequest alloc] initWithSourceURL:[NSURL URLWithString:USERLISTINGLINK] parameterDic:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]] ;
    
    self.sinReq1=sinReq;
    [self.storeCreatedRequests addObject:self.sinReq1];
    sinReq.notificationName=USERLISTINGPUSHBYINVITEFRIEND;
    
    [sinReq startRequest];
    
    
    
    
}



-(BOOL) validEmail:(NSString*) emailString
{
    /*  NSString *regExPattern = @"^[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}$";
     NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
     NSUInteger regExMatches = [regEx numberOfMatchesInString:emailString options:0 range:NSMakeRange(0, [emailString length])];
     NSLog(@"%i", regExMatches);
     if (regExMatches == 0) {
     return NO;
     } else
     return YES;*/
    
    //Quick return if @ Or . not in the string
    if([emailString rangeOfString:@"@"].location==NSNotFound || [emailString rangeOfString:@"."].location==NSNotFound)
        return NO;
    
    //Break email address into its components
    NSString *accountName=[emailString substringToIndex: [emailString rangeOfString:@"@"].location];
    emailString=[emailString substringFromIndex:[emailString rangeOfString:@"@"].location+1];
    
    //’.’ not present in substring
    if([emailString rangeOfString:@"."].location==NSNotFound)
        return NO;
    NSString *domainName=[emailString substringToIndex:[emailString rangeOfString:@"."].location];
    NSString *subDomain=[emailString substringFromIndex:[emailString rangeOfString:@"."].location+1];
    
    //username, domainname and subdomain name should not contain the following charters below
    //filter for user name
    NSString *unWantedInUName = @" ~!@#$^&*()={}[]|;’:\"<>,?/`";
    //filter for domain
    NSString *unWantedInDomain = @" ~!@#$%^&*()={}[]|;’:\"<>,+?/`";
    //filter for subdomain
    NSString *unWantedInSub = @" `~!@#$%^&*()={}[]:\";’<>,?/1234567890";
    
    //subdomain should not be less that 2 and not greater 6
    if(!(subDomain.length>=2 && subDomain.length<=6)) return NO;
    
    if([accountName isEqualToString:@""] || [accountName rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:unWantedInUName]].location!=NSNotFound || [domainName isEqualToString:@""] || [domainName rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:unWantedInDomain]].location!=NSNotFound || [subDomain isEqualToString:@""] || [subDomain rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:unWantedInSub]].location!=NSNotFound)
        return NO;
    
    return YES;
    
    
    
    
    
}


-(void)showHudView:(NSString*)str
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode= MBProgressHUDModeIndeterminate;
    hud.labelText =str;
    [self.view bringSubviewToFront:hud];
}

-(void)hideHudView
{
      [MBProgressHUD hideHUDForView:self.view animated:YES];
}


-(void)showNativeHudView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(void)hideNativeHudView
{
   [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


-(void)setuporientation
{
    
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
   if(orientation ==  UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
           
        {
             isLandscape=0;
        }
   else if(orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight)
        {
             isLandscape=1;
        }
                
    
   /* if([self interfaceOrientation]==UIDeviceOrientationLandscapeLeft || [self interfaceOrientation]==UIDeviceOrientationLandscapeRight)
    {
        isLandscape=1;
        
    }
    else
    {
        isLandscape=0;
    }*/
}

-(void)createBottomView
{

}


-(void)createTopView
{





}

-(void)bottombtapped:(id)sender
{
    int tag=[sender tag];
    
    if(tag==0)
    {
        
        
    }
    else if(tag==1)
    {
        
        
    }
    else if(tag==2)
    {
        
        
    }
    else if(tag==3)
    {
        
        
    }
    else if(tag==4)
    {
        
        
    }
    else if(tag==5)
    {
        
        
    }
}


-(NSString*)selectXib:(NSString*)xibName
{
    NSString *str=nil;
    
    if (isiPad)
    {
        // iPad-specific interface here
       str=  [[NSString alloc] initWithFormat:@"%@_iPad",xibName];
        
        return str;
    }
    else if (isiPhone)
    {
        // iPhone and iPod touch interface here
        str=  [[NSString alloc] initWithFormat:@"%@_iPhone",xibName];
        
        return str;
    }
    else 
    {
        // iPhone5 interface here
        str=  [[NSString alloc] initWithFormat:@"%@_iPhone5",xibName];
        
        return str;
    }
}

/*-(NSManagedObject*)objectOfType:(NSString*) aType forKey:(NSNumber*) aKey andValue:(NSDate*) anId andTruck:(NSString*)truckId
{
    id anObj = nil;
	
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
	
    [request setEntity:[NSEntityDescription entityForName:aType inManagedObjectContext:self.managedObjectContext]];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"hour == %@ AND date>=%@ AND truckid == %@",aKey,anId,truckId]];
    
    [request setReturnsObjectsAsFaults:NO];
    
	NSArray* ar = [managedObjectContext executeFetchRequest:request error:nil];
    
    NSLog(@"Arr Count=%i",[ar count]);
     NSLog(@"Arr Count=%@",ar);
    
	if ([ar count]>0) {
		
		
        anObj=  [ar objectAtIndex:0];
        
        TrackingData *a=anObj;
        
		NSLog(@"%i",[a.slot15 intValue]);
        NSLog(@"%i",[a.slot30 intValue]);
        NSLog(@"%i",[a.slot45 intValue]);
        NSLog(@"%i",[a.slot60 intValue]);
	}
	
	if (anObj == nil) {
     anObj = [NSEntityDescription insertNewObjectForEntityForName:aType inManagedObjectContext:self.managedObjectContext];
     
     }
	[request release];
	
    return anObj;
	
}*/
/*-(AfterBaseLogs*)objectOfType1:(NSString*) aType 
{
    AfterBaseLogs *anObj = nil;
	
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
	
    [request setEntity:[NSEntityDescription entityForName:aType inManagedObjectContext:appDelegate.managedObjectContext]];
    
    
    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES] autorelease];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [request setSortDescriptors:sortDescriptors];
    
    
	NSArray* ar = [appDelegate.managedObjectContext executeFetchRequest:request error:nil];
	if ([ar count]>=1) 
    {
		
		
        anObj= (AfterBaseLogs *) [ar lastObject];
		
	}
	
	
	[request release];	
	
    
    
    return anObj ;
	
}
*/


-(NSArray*)objectOfType1EventStartDate:(NSDate*) start EndDate:(NSDate*) end :(NSString*)teamId :(NSString*)playerId :(BOOL)isStatusAcceptence :(int)statusAcceptence
{
     //Event *anObj = nil;
	
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
	
    [request setEntity:[NSEntityDescription entityForName:EVENT inManagedObjectContext:appDelegate.managedObjectContext]];
    
    
  
    
//    if(isStatusAcceptence)
//    {
//    if(playerId)
//    {
//     if(teamId && [teamId isEqualToString:@"Private"])
//        [request setPredicate:[NSPredicate predicateWithFormat:@"(startTime >= %@) AND (startTime <= %@) AND (userId==%@) AND ((teamId==%@) OR (isPublic==0)) AND (playerId==%@ )",start,end,[appDelegate.aDef objectForKey:LoggedUserID],teamId,playerId/*,[NSNull null]*/]];//OR playerId==\"\" OR playerId==%@
//   else if(teamId)
//        [request setPredicate:[NSPredicate predicateWithFormat:@"(startTime >= %@) AND (startTime <= %@) AND (userId==%@) AND ((teamId==%@)) AND (playerId==%@) AND (isPublicAccept==%i)",start,end,[appDelegate.aDef objectForKey:LoggedUserID],teamId,playerId,statusAcceptence]];
//    else
//    [request setPredicate:[NSPredicate predicateWithFormat:@"(startTime >= %@) AND (startTime <= %@) AND (userId==%@) AND (isPublic==1) AND (playerId==%@) AND (isPublicAccept==%i)",start,end,[appDelegate.aDef objectForKey:LoggedUserID],playerId,statusAcceptence]];
//    
//    }
//    else
//    {
//        if(teamId && [teamId isEqualToString:@"Private"])
//            [request setPredicate:[NSPredicate predicateWithFormat:@"(startTime >= %@) AND (startTime <= %@) AND (userId==%@) AND ((teamId==%@) OR (isPublic==0))",start,end,[appDelegate.aDef objectForKey:LoggedUserID],teamId]];
//        else if(teamId)
//            [request setPredicate:[NSPredicate predicateWithFormat:@"(startTime >= %@) AND (startTime <= %@) AND (userId==%@) AND ((teamId==%@)) AND (isPublicAccept==%i)",start,end,[appDelegate.aDef objectForKey:LoggedUserID],teamId,statusAcceptence]];
//        else
//            [request setPredicate:[NSPredicate predicateWithFormat:@"(startTime >= %@) AND (startTime <= %@) AND (userId==%@) AND (isPublic==1) AND (isPublicAccept==%i)",start,end,[appDelegate.aDef objectForKey:LoggedUserID],statusAcceptence]];
//        
//        
//        
//        
//        
//    }
//    }
//    else
//    {
//        if(playerId)
//        {
//            if(teamId && [teamId isEqualToString:@"Private"])
//                [request setPredicate:[NSPredicate predicateWithFormat:@"(startTime >= %@) AND (startTime <= %@) AND (userId==%@) AND ((teamId==%@) OR (isPublic==0)) AND (playerId==%@ )",start,end,[appDelegate.aDef objectForKey:LoggedUserID],teamId,playerId/*,[NSNull null]*/]];//OR playerId==\"\" OR playerId==%@
//            else if(teamId)
//                [request setPredicate:[NSPredicate predicateWithFormat:@"(startTime >= %@) AND (startTime <= %@) AND (userId==%@) AND ((teamId==%@)) AND (playerId==%@)",start,end,[appDelegate.aDef objectForKey:LoggedUserID],teamId,playerId]];
//            else
//                [request setPredicate:[NSPredicate predicateWithFormat:@"(startTime >= %@) AND (startTime <= %@) AND (userId==%@) AND (isPublic==1) AND (playerId==%@)",start,end,[appDelegate.aDef objectForKey:LoggedUserID],playerId]];
//            
//        }
//        else
//        {
//            if(teamId && [teamId isEqualToString:@"Private"])
//                [request setPredicate:[NSPredicate predicateWithFormat:@"(startTime >= %@) AND (startTime <= %@) AND (userId==%@) AND ((teamId==%@) OR (isPublic==0))",start,end,[appDelegate.aDef objectForKey:LoggedUserID],teamId]];
//            else if(teamId)
//                [request setPredicate:[NSPredicate predicateWithFormat:@"(startTime >= %@) AND (startTime <= %@) AND (userId==%@) AND ((teamId==%@))",start,end,[appDelegate.aDef objectForKey:LoggedUserID],teamId]];
//            else
//                [request setPredicate:[NSPredicate predicateWithFormat:@"(startTime >= %@) AND (startTime <= %@) AND (userId==%@) AND (isPublic==1)",start,end,[appDelegate.aDef objectForKey:LoggedUserID]]];
//            
//            
//            
//            
//            
//        }
//    }
    
      [request setPredicate:[NSPredicate predicateWithFormat:@"(startTime >= %@) AND (startTime <= %@) AND (userId==%@)",start,end,[appDelegate.aDef objectForKey:LoggedUserID]]];// AND (isPublic==1)
    
	NSArray* ar =nil;
   ar= [appDelegate.managedObjectContext executeFetchRequest:request error:nil];
	
	
	
    
    
    return ar ;
	
}



-(float)getImageLengthOfWidth:(float)orgLength1 OfHeight:(float)orgLength2 isWidth:(BOOL)isWidth length:(int)length
{
    float m=0;
    
    
    float factor= 0;
    
    if(isWidth)
    {
    factor= orgLength2/orgLength1;
        
    }
    else
    {
          factor= orgLength1/orgLength2;
    }
   
     m=  length*factor;
    
    
    if(m==NAN)
        m=0;
    return m;
}



-(UIImage*)getImage:(UIImage*)image isWidth:(BOOL)isWidth length:(int)length
{
    UIImage *orgImage=nil;
    UIImage *thumbnailImage = image;
    
    CGSize sz;
    
    
    if(isWidth)
        sz= CGSizeMake(length,((thumbnailImage.size.height/thumbnailImage.size.width)*length));
    else
        sz= CGSizeMake(((thumbnailImage.size.width/thumbnailImage.size.height)*length),length);
    
    
    UIGraphicsBeginImageContextWithOptions(sz, FALSE, 0.0);
    //[thumbnailImage drawInRect:CGRectMake( 0, 0, thumbnailImage.size.width, thumbnailImage.size.height)];
    if(isWidth)
        [thumbnailImage drawInRect:CGRectMake( 0, 0,length, ((thumbnailImage.size.height/thumbnailImage.size.width)*length))];
    else
        [thumbnailImage drawInRect:CGRectMake( 0, 0, ((thumbnailImage.size.width/thumbnailImage.size.height)*length),length)];
    
    //        UIImage *fgImage=[UIImage imageNamed:THUMBIMAGENAME];
    //
    //        CGPoint p= CGPointMake(((sz.width-fgImage.size.width)/2), ((sz.height-fgImage.size.height)/2));
    //
    //        [fgImage drawInRect:CGRectMake(p.x,p.y,fgImage.size.width, fgImage.size.height)];
    orgImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return orgImage;
    
}




-(Event*)objectOfType1Event:(NSString*) identifier
{
    Event *anObj = nil;
	
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
	
    [request setEntity:[NSEntityDescription entityForName:EVENT inManagedObjectContext:appDelegate.managedObjectContext]];
    
    
    
    
    // NSDate *stdate=[self dateFromSD:aType];;
    //NSDate *edate=[self dateFromSDLast:aType];
    
    //NSArray* arrall = [appDelegate.managedObjectContext executeFetchRequest:request error:nil];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"(eventIdentifier==%@) AND (userId==%@)",identifier,[appDelegate.aDef objectForKey:LoggedUserID]]];
    
    
    
    
	NSArray* ar =nil;
    ar= [appDelegate.managedObjectContext executeFetchRequest:request error:nil];
	if ([ar count]>=1)
     {
     
     
     anObj= (Event *) [ar objectAtIndex:0];
     
     }
     
     
	
	
	
    
    
    return anObj ;
	
}


-(Event*)objectOfType2Event:(NSString*) identifier
{
    Event *anObj = nil;
	
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
	
    [request setEntity:[NSEntityDescription entityForName:EVENT inManagedObjectContext:appDelegate.managedObjectContext]];
    
    
    
    
    // NSDate *stdate=[self dateFromSD:aType];;
    //NSDate *edate=[self dateFromSDLast:aType];
    
    //NSArray* arrall = [appDelegate.managedObjectContext executeFetchRequest:request error:nil];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"(eventId==%@) AND (userId=%@)",identifier,[appDelegate.aDef objectForKey:LoggedUserID]]];
    
    
    
    
	NSArray* ar =nil;
    ar= [appDelegate.managedObjectContext executeFetchRequest:request error:nil];
	if ([ar count]>=1)
    {
        
        
        anObj= (Event *) [ar objectAtIndex:0];
        
    }
    
    
	
	
	
    
    
    return anObj ;
	
}

-(void)deleteObjectOfTypeEvent:(NSManagedObject*) identifier
{
    
    [self.managedObjectContext deleteObject:identifier];
    [appDelegate saveContext];
}

-(NSDate *)dateFromSD:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
    
    NSDateComponents *components1 = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:date];
    
    components1.hour=0;
    components1.second=0;
    components1.minute=0;
    
    NSDate *d=[calendar dateFromComponents:components1];
    
    
    
    return d;
}

-(NSDate *)dateFromSDLast:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
    
    NSDateComponents *components1 = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:date];
    
    components1.hour=23;
    components1.second=59;
    components1.minute=59;
    
    NSDate *d=[calendar dateFromComponents:components1];
    
    
    
    return d;
}


-(void)showImageStatus:(NSString *)imageName
{
    UIView *baseview1=[[UIView alloc] initWithFrame:CGRectMake(0,0,320,460)];
    self.baseview=baseview1;
    
    UIButton *bt=[UIButton buttonWithType:UIButtonTypeCustom];
    
    bt.frame=CGRectMake(0,0,320,460);
    
    [bt setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    [bt addTarget:self action:@selector(mybtapped:) forControlEvents:UIControlEventTouchUpInside];
    bt.adjustsImageWhenHighlighted=NO;
    [baseview addSubview:bt];
    
    
    [self.view addSubview:baseview];
    [self.view bringSubviewToFront:baseview];
    
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:1.75 target:self selector:@selector(mttimerf:) userInfo:nil repeats:NO];
    
    self.basetimer=timer;
 
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

-(void)mttimerf:(id)sender
{
    [sender invalidate];
    [self myoverride];
}

-(void)mybtapped:(id)sender
{
    
    [basetimer invalidate];
    
    [self myoverride];
}

-(void)myoverride
{
    [self.baseview removeFromSuperview];
}

-(void)setRegFont:(id)obj withSize:(CGFloat)size
{
   // [obj setFont:[UIFont fontWithName:RegFont size:size]];
}

/*-(void)setItaFont:(id)obj withSize:(CGFloat)size
{
    [obj setFont:[UIFont fontWithName:ItaFont size:size]];
}

-(void)setRegBoldFont:(id)obj withSize:(CGFloat)size
{
    [obj setFont:[UIFont fontWithName:RegBoldFont size:size]];
}

-(void)setItaBoldFont:(id)obj withSize:(CGFloat)size
{
    [obj setFont:[UIFont fontWithName:ItaBoldFont size:size]];
}*/


-(void)setCalibriFont:(id)obj withSize:(CGFloat)size
{
     [obj setFont:[UIFont fontWithName:FONTCALIBRI size:size]];
}

-(void)setDiavloFont:(id)obj withSize:(CGFloat)size
{
     [obj setFont:[UIFont fontWithName:FONTDIAVLOMEDIUM size:size]];
}

/*-(void)setDiavloBoldFont:(id)obj withSize:(CGFloat)size
{
    [obj setFont:[UIFont fontWithName:FONTDIAVLOBLACK size:size]];
}*/

-(NSString *)getDateTime:(NSDate *)cdate
{
   
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
           
    [formatter setTimeZone:ctimezone];
    
    [formatter setDateFormat:@"dd MMM, yyyy"];
   
    [calender setTimeZone:ctimezone];
    NSDateComponents *weekdayComponents = [calender components:(NSWeekdayCalendarUnit) fromDate:cdate];
    NSInteger todayDayNum = [weekdayComponents weekday];    
    
    NSArray *weekdays=[[NSArray alloc] initWithObjects:@"",@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday",nil];
    NSString *str=[NSString stringWithFormat:@"%@, %@",[weekdays objectAtIndex:todayDayNum],[formatter stringFromDate:cdate]];
    
    
    return str;   
    
}

-(NSString *)getDateTimeCan:(NSDate *)cdate
{
   
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    
   
    [formatter setTimeZone:ctimezone];
    
      [formatter setDateFormat:@"dd MMM"];
   
    [calender setTimeZone:ctimezone];
    NSDateComponents *weekdayComponents = [calender components:(NSWeekdayCalendarUnit) fromDate:cdate];
    NSInteger todayDayNum = [weekdayComponents weekday];
    
    NSArray *weekdays=[[NSArray alloc] initWithObjects:@"",@"Sun",@"Mon",@"Tue",@"Wed",@"Thu",@"Fri",@"Sat",nil];
    NSString *str=[NSString stringWithFormat:@"%@, %@",[weekdays objectAtIndex:todayDayNum],[formatter stringFromDate:cdate]];
    
    return str;   
    
    
}

-(NSString *)getDateTimeForHistory:(NSDate *)cdate
{
    
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    
    [formatter setTimeZone:ctimezone];
    
     [formatter setDateFormat:@"dd MMM, yyyy"];
    
    NSDateFormatter *formatter1=[[NSDateFormatter alloc] init];
    
    [formatter1 setTimeZone:ctimezone];
    
    [formatter1 setDateFormat:@"hh:mm a"];
    
    NSString *s=[[NSString alloc] initWithFormat:@"%@ %@",[formatter stringFromDate:cdate],[formatter1 stringFromDate:cdate]];
    
    [calender setTimeZone:ctimezone];
    /*NSDateComponents *weekdayComponents = [calender components:(NSWeekdayCalendarUnit) fromDate:cdate];
    NSInteger todayDayNum = [weekdayComponents weekday];
    
    NSArray *weekdays=[[NSArray alloc] initWithObjects:@"",@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday",nil];*/
    
    
    
    NSString *str=s;
   

    
    return str;
    
}


-(NSString *)getDateTimeForHistoryWithoutDate:(NSDate *)cdate
{
    
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    
    [formatter setTimeZone:ctimezone];
    
    [formatter setDateFormat:@"dd MMM"];
    
    NSDateFormatter *formatter1=[[NSDateFormatter alloc] init];
    
    [formatter1 setTimeZone:ctimezone];
    
    [formatter1 setDateFormat:@"hh:mm a"];
    
    NSString *s=[[NSString alloc] initWithFormat:@"%@ %@",[formatter stringFromDate:cdate],[formatter1 stringFromDate:cdate]];
    
    [calender setTimeZone:ctimezone];
    /*NSDateComponents *weekdayComponents = [calender components:(NSWeekdayCalendarUnit) fromDate:cdate];
     NSInteger todayDayNum = [weekdayComponents weekday];
     
     NSArray *weekdays=[[NSArray alloc] initWithObjects:@"",@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday",nil];*/
    
    
    
    NSString *str=s;
    
    
    
    return str;
    
}


-(NSString *)getDateTimeCanName:(NSDate *)cdate
{
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    
    
    [formatter setTimeZone:ctimezone];
    
    [formatter setDateFormat:@"MMM dd,yyyy"];
    
    [calender setTimeZone:ctimezone];
    NSDateComponents *weekdayComponents = [calender components:(NSWeekdayCalendarUnit) fromDate:cdate];
    NSInteger todayDayNum = [weekdayComponents weekday];
    
    NSArray *weekdays=[[NSArray alloc] initWithObjects:@"",@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday",nil];
    NSString *str=[NSString stringWithFormat:@"%@-%@",[weekdays objectAtIndex:todayDayNum],[formatter stringFromDate:cdate]];
    
    return str;
    
    
}

-(long long int)getTimeStampFromDateString:(NSString*)datestr
{
    long long int timestamp=0;
    
   //  NSLog(@"TimestampFirst=%@-%@-%@",appDelegate.dateFormatFullOriginalComment,datestr,[appDelegate.dateFormatFullOriginalComment dateFromString:datestr]);
  /* NSDateFormatter *dF=[[NSDateFormatter alloc ] init];
    NSTimeZone *tZone=[[NSTimeZone alloc] initWithName:@"UTC"];
    
    [dF setTimeZone:tZone];
    
    [dF setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *utcDate=  [dF dateFromString:datestr];
    
   int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
    NSDate *matchingsysdate=[utcDate dateByAddingTimeInterval:difftime];
    
    dF=nil;
    tZone=nil;*/
      int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
    
timestamp=   [[[appDelegate.dateFormatFullOriginalComment dateFromString:datestr] dateByAddingTimeInterval:difftime] timeIntervalSinceNow] ;
    
    if(timestamp<0)
        timestamp=timestamp * (-1);
    
    //NSLog(@"Timestamp=%lli",timestamp);
    return timestamp;
}



-(NSDate*)dateFromGMTStringDate:(NSString*)datestr
{
    
int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
    NSDate *dt= nil;
    
    BOOL f=0;
    @autoreleasepool
    {
        NSString *dtstr=[datestr stringByReplacingOccurrencesOfString:@"0" withString:@""];
        dtstr=[datestr stringByReplacingOccurrencesOfString:@":" withString:@""];
        dtstr=[datestr stringByReplacingOccurrencesOfString:@" " withString:@""];
        dtstr=[datestr stringByReplacingOccurrencesOfString:@"-" withString:@""];
        
        if(dtstr && (![dtstr isEqualToString:@""]))
            f=1;
    }
    
    
    if(f)
    dt=[[appDelegate.dateFormatFullOriginalComment dateFromString:datestr] dateByAddingTimeInterval:difftime];
    
    
    return dt;
}



-(NSString*)getTimeString:(long long int)timestamp
{
    NSMutableString *str=[NSMutableString string];
    
    if(timestamp<60)
    {
        [str appendFormat:@"%@ ago",[self getPartTimeString:timestamp]];
    }
    else if(timestamp>=60 && timestamp<3600)
    {
        
        
       // int seconds=timestamp%60;
        
        //if(seconds==0)
            [str appendFormat:@"%@ ago",[self getPartTimeString:timestamp]];
       /* else
            [str appendFormat:@"%@ %@ ago",[self getPartTimeString:timestamp],[self getPartTimeString:seconds]];*/
    }
    else if(timestamp>=3600 && timestamp<(24*60*60))
    {
        int minutes=(timestamp%3600)/60;
        int seconds=(timestamp%3600)%60;
        
        if(minutes!=0 && seconds!=0)
        {
            // [str appendFormat:@"%@ %@ %@ ago",[self getPartTimeString:timestamp],[self getPartTimeString: (timestamp%3600)],[self getPartTimeString:seconds]];
            [str appendFormat:@"%@ ago",[self getPartTimeString:timestamp]/*,[self getPartTimeString: (timestamp%3600)]*/];
        }
        else if(minutes)
        {
            [str appendFormat:@"%@ ago",[self getPartTimeString:timestamp]/*,[self getPartTimeString: (timestamp%3600)]*/];
        }
        else if(seconds)
        {
            [str appendFormat:@"%@ ago",[self getPartTimeString:timestamp]/*,[self getPartTimeString:seconds]*/];
        }
        else
        {
            [str appendFormat:@"%@ ago",[self getPartTimeString:timestamp]];
        }
    }
    else if(timestamp>=(24*60*60) && timestamp<(24*60*60*30))
    {
        long long int timestamp1=timestamp;
        timestamp=timestamp%(24*60*60);
       // int hours=timestamp/3600;
       // int minutes=(timestamp%3600)/60;
        // int seconds=(timestamp%3600)%60;
        
        [str appendFormat:@"%@",[self getPartTimeString:timestamp1]];
        
       /* if(hours)
        {
            [str appendFormat:@" %@",[self getPartTimeString:timestamp]];
        }*/
        
        /*if(minutes)
        {
            [str appendFormat:@" %@",[self getPartTimeString:(timestamp%3600)]];
        }*/
        
        /*   if(seconds)
         {
         [str appendFormat:@" %@",[self getPartTimeString:seconds]];
         }*/
        
        
        [str appendFormat:@" ago"];
    }
    else if(timestamp>=(24*60*60*30) && timestamp<(24*60*60*365))
    {
        
        
        long long int timestamp2=timestamp;
        int timestamp1=timestamp%(24*60*60*30);
        
       // int days=timestamp1/(3600*24);
        
        timestamp=timestamp1%(24*60*60);
        //int hours=timestamp/3600;
        // int minutes=(timestamp%3600)/60;
        // int seconds=(timestamp%3600)%60;
        
        [str appendFormat:@"%@",[self getPartTimeString:timestamp2]];
        
       /* if(days)
        {
            [str appendFormat:@" %@",[self getPartTimeString:timestamp1]];
        }*/
        
        
        /*if(hours)
        {
            [str appendFormat:@" %@",[self getPartTimeString:timestamp]];
        }*/
        
        /*  if(minutes)
         {
         [str appendFormat:@" %@",[self getPartTimeString:(timestamp%3600)]];
         }
         
         if(seconds)
         {
         [str appendFormat:@" %@",[self getPartTimeString:seconds]];
         }*/
        
        
        [str appendFormat:@" ago"];
        
        
        
    }
    else
    {
        
        long long int timestamp3=timestamp;
        long long int timestamp2=timestamp%(24*60*60*365);
       // int months=timestamp2/(24*60*60*30);
        
        long long int timestamp1=timestamp2%(24*60*60*30);
        
       // int days=timestamp1/(3600*24);
        
        timestamp=timestamp1%(24*60*60);
        // int hours=timestamp/3600;
        //  int minutes=(timestamp%3600)/60;
        //  int seconds=(timestamp%3600)%60;
        
        [str appendFormat:@"%@",[self getPartTimeString:timestamp3]];
        
        
       /* if(months)
        {
            [str appendFormat:@" %@",[self getPartTimeString:timestamp2]];
        }*/
        
        
        /*  if(days)
         {
         [str appendFormat:@" %@",[self getPartTimeString:timestamp1]];
         }*/
        
        
        /* if(hours)
         {
         [str appendFormat:@" %@",[self getPartTimeString:timestamp]];
         }
         
         if(minutes)
         {
         [str appendFormat:@" %@",[self getPartTimeString:(timestamp%3600)]];
         }
         
         if(seconds)
         {
         [str appendFormat:@" %@",[self getPartTimeString:seconds]];
         }*/
        
        
        [str appendFormat:@" ago"];
        
        
        
        
        
        
    }
    
    
    
    
    return str;
}


-(NSString*)getPartTimeString:(long long int)timestamp
{
    NSString *str=nil;
    
    if(timestamp<60)
    {
        if(timestamp==1)
            str=[NSString stringWithFormat:@"%lli sec",timestamp];
        else
            str=[NSString stringWithFormat:@"%lli secs",timestamp];
    }
    else if(timestamp>=60 && timestamp<3600)
    {
        int minute=timestamp/60;
        
        if(minute==1)
            str=[NSString stringWithFormat:@"%i min",minute];
        else
            str=[NSString stringWithFormat:@"%i mins",minute];
    }
    else if(timestamp>=3600 && timestamp<(24*60*60))
    {
        int hour=timestamp/(60*60);
        
        if(hour==1)
            str=[NSString stringWithFormat:@"%i hr",hour];
        else
            str=[NSString stringWithFormat:@"%i hrs",hour];
    }
    else if(timestamp>=(24*60*60) && timestamp<(24*60*60*30))
    {
        int day=timestamp/(24*60*60);
        
        if(day==1)
            str=[NSString stringWithFormat:@"%i day",day];
        else
            str=[NSString stringWithFormat:@"%i days",day];
    }
    else if(timestamp>=(24*60*60*30) && timestamp<(24*60*60*365))
    {
        int month=timestamp/(24*60*60*30);
        
        if(month==1)
            str=[NSString stringWithFormat:@"%i month",month];
        else
            str=[NSString stringWithFormat:@"%i months",month];
    }
    else
    {
        int year=timestamp/(24*60*60*365);
        
        if(year==1)
            str=[NSString stringWithFormat:@"%i yr",year];
        else
            str=[NSString stringWithFormat:@"%i yrs",year];
    }
    
    return str;
}


-(NSDate *)getFirstWeekDay:(NSDate *)date
{
   
    NSDate *d;
    NSCalendar *calendar=[NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone localTimeZone]];
    
    NSDateComponents *com=[calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekdayCalendarUnit|NSWeekCalendarUnit|NSWeekdayOrdinalCalendarUnit fromDate:date];
    
    
    
  
    [com setWeekday:1];
    
    d=[calendar dateFromComponents:com];
    
      /*NSDateComponents *com1=[calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekdayCalendarUnit|NSWeekdayOrdinalCalendarUnit fromDate:d];
    
    NSDate *d1=[calendar dateFromComponents:com1];
    
    NSLog(@"%i",com1.weekday);
 NSLog(@"%i",com1.day);*/
 
    return d;

    
}
//M====
/*-(void)bringProgress:(int)seconds
{
    ProgressViewController *tmvc1=nil;
    if(appDelegate.isIphone5)
       tmvc1= [[ProgressViewController alloc] initWithNibName:@"ProgressViewController_iPhone5" bundle:nil]  ;  
        else
     tmvc1= [[ProgressViewController alloc] initWithNibName:@"ProgressViewController" bundle:nil]  ;
    
    
    NSLog(@"TrackCount====%i",seconds);
    
      tmvc1.trackcount=seconds;
    self.tmvc=tmvc1;
    
    CGRect m=tmvc.view.frame;
    m.origin.y+=20;
    
    if(appDelegate.isIphone5)
    {
      
        
        m.size.height+=108;
       
    }
    
     tmvc.view.frame=m;
    
    [appDelegate.window addSubview:tmvc.view];
    [appDelegate.window bringSubviewToFront:tmvc.view];
    //appDelegate.window.rootViewController=self.tmvc;
    [tmvc1 release];
}*/


/*-(void)hideProgress
{
    [tmvc.view removeFromSuperview ];
   // [appDelegate addRootVC];
}


-(int)getRangeForAtATime
{
    //NSLog(@"Device platform=%@ \n Device hwmodel=%@\n Device platformType=%i\n Device platformString=%@\n Device totalMemory=%i\n Device userMemory=%i", [[UIDevice currentDevice] platform],[[UIDevice currentDevice] hwmodel], [[UIDevice currentDevice] platformType],[[UIDevice currentDevice] platformString], [[UIDevice currentDevice] totalMemory],[[UIDevice currentDevice] userMemory]);
    
    
    int ramsize=([[UIDevice currentDevice] totalMemory]/1000)/1000;
    
    NSLog(@"Ram Size=%i",ramsize);
    
     NSLog(@"CPU Count=%i",[[UIDevice currentDevice] cpuCount]);
    
     NSLog(@"CPU Frequency=%i",[[UIDevice currentDevice] cpuFrequency]);
    
    if(ramsize >=250 && ramsize < 500)
    {
         return 200;
    }
    else if(ramsize >=500 && ramsize < 1000)
    {
         return 400;
    }
    else if(ramsize >=1000 && ramsize < 1500)
    {
         return 1000;
    }
     else if(ramsize >=1500 && ramsize < 2000)
    {
         return 1500;
    }
    else if (ramsize >=2000 )
    {
         return 2000;
    }
    else
    
    return 100;
}

-(int)getTimeRangeForAtATime
{
    int ramsize=([[UIDevice currentDevice] totalMemory]/1000)/1000;
    
    NSLog(@"Ram Size=%i",ramsize);
    
    NSLog(@"CPU Count=%i",[[UIDevice currentDevice] cpuCount]);
    
    NSLog(@"CPU Frequency=%i",[[UIDevice currentDevice] cpuFrequency]);
    
    if(ramsize >=250 && ramsize < 500)
    {
        return 35;
    }
    else if(ramsize >=500 && ramsize < 1000)
    {
        return 50;
    }
    else if(ramsize >=1000 && ramsize < 1500)
    {
        return 60;
    }
    else if(ramsize >=1500 && ramsize < 2000)
    {
        return 70;
    }
    else if (ramsize >=2000 )
    {
        return 80;
    }
    else
        
        return 50;

}*/

-(NSString *)userDocDirPath
{
    
    
    
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString *docsDir=[paths objectAtIndex:0];
    return docsDir;
}


-(void)showAlertMessage:(NSString*) msg title:(NSString *)titl
{
    UIAlertView* av = [[UIAlertView alloc] initWithTitle:titl message:msg delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
    [av show];
    return;
}


-(void)showAlertMessage:(NSString*) msg
{
    UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
    [av show];
    return;
}





///////////////////////////////////////////////////Sharing
/*- (IBAction)popupbtapped:(id)sender
{
    
    
    int tag=[sender tag];
    
    
    if(tag==0)
    {
          FacebookVC *fvcon=[[FacebookVC alloc] initWithNibName:@"FacebookVC" bundle:nil];
         [self showModal:fvcon];
         [fvcon release];
//        UIActionSheet *acsh=nil;
//        
//        if([[FBSession activeSession] isOpen])
//        {
//            acsh=[[UIActionSheet alloc] initWithTitle:@"Facebook" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Logout",@"Share", nil];
//        }
//        else
//        {
//            acsh=[[UIActionSheet alloc] initWithTitle:@"Facebook" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Login", nil];
//        }
//        [acsh showInView:self.popupview];
//        [acsh release];
    }
    else if(tag==1)
    {
        Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
        
        if (messageClass != nil)
        {
            // Check whether the current device is configured for sending SMS messages
            if ([messageClass canSendText])
            {
                [self displaySMSComposerSheet:nil];
            }
            else
            {
                [self showAlertMessage:MYLocalizedString(@"This feature is not supported in this device.", nil) ];
                
            }
        }
        
    }
    else if(tag==2)
    {
        [self sendMail:nil:nil];
        
    }
    else if(tag==3)
    {
        self.popupview.hidden=YES;
    }
    
}*/

- (IBAction)sharebtapped:(id)sender
{
    /*self.popupview.hidden=NO;
    [self.view bringSubviewToFront:self.popupview];*/
    [self sendMail:nil:nil];
}








-(void)facebookRequestFinished:(id)sender
{
    [self hideHudView];
}

-(void)imageUpdated:(id)sender
{
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
   /* [[NSNotificationCenter defaultCenter] removeObserver:self name:SESSIONSTATEOPEN object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SESSIONLogIn object:nil];*/
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    /* [[NSNotificationCenter defaultCenter] removeObserver:self name:SESSIONSTATEOPEN object:nil];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:SESSIONLogIn object:nil];*/
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:USERLISTING object:nil];
}



-(void)disableSlidingAndHideTopBar
{
    
    
    appDelegate.centerViewController.uptopbarvw.hidden=NO;
    
    
   appDelegate.slidePanelController.allowLeftOverpan=NO;
   
    
    /*appDelegate.slidePanelController.allowRightOverpan=NO;
   appDelegate.slidePanelController.allowLeftSwipe=NO;
   appDelegate.slidePanelController.allowRightSwipe=NO;*/
}


-(void)enableSlidingAndShowTopBar
{
    appDelegate.centerViewController.uptopbarvw.hidden=YES;
    
   appDelegate.slidePanelController.allowLeftOverpan=YES;
    
    
    /*appDelegate.slidePanelController.allowRightOverpan=YES;
    appDelegate.slidePanelController.allowLeftSwipe=YES;
    appDelegate.slidePanelController.allowRightSwipe=YES;*/
    
}

-(void)disableMySwipes
{
appDelegate.slidePanelController.allowLeftSwipeMyHome=NO;
appDelegate.slidePanelController.allowRightSwipeMyHome=NO;


appDelegate.slidePanelController.allowLeftSwipeMyTeam=NO;
appDelegate.slidePanelController.allowRightSwipeMyTeam=NO;
}

-(void)enableMyHomeSwipe
{
    appDelegate.slidePanelController.allowLeftSwipeMyHome=YES;
    appDelegate.slidePanelController.allowRightSwipeMyHome=YES;
}
-(void)enableMyTeamSwipe
{

    appDelegate.slidePanelController.allowLeftSwipeMyTeam=YES;
    appDelegate.slidePanelController.allowRightSwipeMyTeam=YES;
}


-(void)callNumber:(NSString*)phoneNo
{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNo]]];
    
}

-(void)sendSMS:(NSString *)emailstr :(NSString*)emailbody
{
    Class mailClass = (NSClassFromString(@"MFMessageComposeViewController"));
    if (mailClass != nil)
    {
        // We must always check whether the current device is configured for sending emails
        if ([mailClass canSendText])
        {
            [self displaySMSComposerSheet:emailstr:emailbody];
        }
        else
        {
            [self showAlertMessage:@"Text Messaging is not supported in this device."];
        }
    }
}


-(void)sendMail:(NSString *)emailstr :(NSString*)emailbody
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (mailClass != nil)
    {
        // We must always check whether the current device is configured for sending emails
        if ([mailClass canSendMail])
        {
            [self displayComposerEmailSheet:emailstr:emailbody];
        }
        else
        {
            [self showAlertMessage:@"Your device is not configured for sending emails."];
        }
    }
}

-(void)displaySMSComposerSheet:(NSString *)emailstr :(NSString *)bodycontent
{
    
    
    MFMessageComposeViewController*  fv = [[MFMessageComposeViewController alloc] init];
    
    
	self.fvc1 =fv;
	fvc1.messageComposeDelegate = self;
    [fvc1.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    NSArray *arr=[[NSArray alloc] initWithObjects:emailstr, nil] ;
    fvc1.recipients=arr;
    [fvc1 setTitle:@"SMS"  ];
    
    
	// Set up recipients
    fvc1.body = @"Hi.....";
    
    
    
    // fvc1.recipients = phnos;
    isFromSMSShare=1;
    
    
    
	if (fvc1 != nil)
    {
        
        // [self presentModalViewController:fvc1 animated:YES];
        
        [self showModal:fvc1];
    }
    
}



-(void)displayComposerEmailSheet:(NSString *)emailstr :(NSString *)bodycontent
{
    
    
    
    MFMailComposeViewController*  fv = [[MFMailComposeViewController alloc] init];
    
	self.fvc2 = fv;
	fvc2.mailComposeDelegate = self;
    [fvc2.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    
	[fvc2 setTitle:@"Email"  ];
    //  fvc2.navigationItem.rightBarButtonItem.style=UIBarButtonItemStyleBordered;
    //  fvc2.navigationItem.rightBarButtonItem.tintColor=[UIColor grayColor];
    
    [fvc2 setMessageBody:@""  isHTML:NO];
    
	// Set up recipients
    if(emailstr)
    {
       /* NSArray *toRecipients = [NSArray arrayWithObject:emailstr];
        [fvc2 setToRecipients:toRecipients];*/
        
        if([emailstr isEqualToString:CREATETEAMNOTIFICATION])
        {
            [fvc2 setSubject:CREATETEAMNOTIFICATION];
        }
        else if([emailstr isEqualToString:ADDMYFRIEND])
        {
            [fvc2 setSubject:ADDMYFRIEND];
        }
        else if([emailstr isEqualToString:INVITEMYFRIEND])
        {
            [fvc2 setSubject:INVITEMYFRIEND];
        }
        
        
        NSString *emailBody =bodycontent;
         [fvc2 setMessageBody:emailBody isHTML:NO];
	}
	else
	{
        // Fill out the email body text
      //  NSString *emailBody = [NSString stringWithFormat:@"%@\n    %@",MYLocalizedString(@"Hi,", nil) , MYLocalizedString(SHAREDEFAULTMESSAGE, nil) ];
       // [fvc2 setMessageBody:emailBody isHTML:NO];
        
       // isFromEmailShare=1;
        NSArray *arr=[[NSArray alloc] initWithObjects:bodycontent, nil] ;
        [fvc2 setToRecipients:arr];
    }
    
    
	if (fvc2 != nil)
    {
        
        //[self presentModalViewController:fvc animated:YES];
        
        self.isModallyPresentFromCenterVC=1;
        [self showModal:fvc2];
    }
}





- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    
    
    
    
    switch (result)
    {
        case MessageComposeResultCancelled:
        {
            
            UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"Message"  message:@"SMS sending canceled."  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
            [alert1 show];
        }
            
            break;
            
        case MessageComposeResultSent:
        {
            
            
            UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"Message"  message:@"SMS sent." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
            [alert2 show];
            
         
         
            
        }
            
            
            
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:@"Message"  message:@"SMS sending failed." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
            [alert3 show];
        }
            
            
            break;
            
        default:
        {
            UIAlertView *alert4 = [[UIAlertView alloc] initWithTitle:@"Message" message:@"SMS not sent." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Okay" , nil];
            [alert4 show];
        }
            
            
            break;
    }
    
    //[self dismissModalViewControllerAnimated: YES];
    
    
    [self dismissModal];
    
     [appDelegate setHomeView];
}





- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	
    
	switch (result)
	{
		case MFMailComposeResultCancelled:
        {
			//[self showAlertMessage:@"Email cancelled." ];
        }
			break;
		case MFMailComposeResultSaved:
        {
			//[self showAlertMessage:@"Email saved."];
        }
			break;
		case MFMailComposeResultSent:
        {
			//[self showAlertMessage:@"Email sent."];
            
            
            
            
        }
			break;
		case MFMailComposeResultFailed:
        {
			//[self showAlertMessage:@"Error, please try again." ];
        }
			break;
		default:
           // [self showAlertMessage:@"Email not sent, please try again." ];
			
			break;
	}
	
    // [self dismissModalViewControllerAnimated:YES];
    
    [self dismissModal];
   
    [appDelegate setHomeView];
}



//////////////


-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation

{
    
    
    
    
    
   // if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        
        
        
        return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
    
   /* else
       
        return YES;*/
        //return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
    
    
    
}

-(void)resetVC
{
    
}
-(void)loadVC
{
    
}

- (BOOL)shouldAutorotate

{
    
    //if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        
        return YES;
    
  
    
    
    
}

- (NSUInteger)supportedInterfaceOrientations

{
    
    
    
    //if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        
        
        
        return ( UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown);
    
  
    
}



-(CGSize)getSizeOfText:(NSString*)textStr :(CGSize) constsize :(UIFont*)textFont
{
    CGRect expectedFrame ;
    
    CGSize expectedSize ;
    
    if(appDelegate.isIos7)
    {
        NSDictionary *fdic=[[NSDictionary alloc] initWithObjectsAndKeys:
                            textFont, NSFontAttributeName,
                            nil];
        
        
        /*NSAttributedString *attributedText=[[NSAttributedString alloc]
         initWithString:textStr
         attributes:fdic];*/
        
        
       
        
        
        
        expectedFrame=[textStr boundingRectWithSize:constsize
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:fdic context:nil];
        
        fdic=nil;
        
        
        CGFloat height = ceilf( expectedFrame.size.height);
        CGFloat width  = ceilf(expectedFrame.size.width);
        
        expectedSize = CGSizeMake(width,height);
    }
    else
    {
        expectedSize= [textStr sizeWithFont:textFont constrainedToSize:constsize lineBreakMode: NSLineBreakByWordWrapping];
    }
    
    
    NSLog(@"%f %f",expectedSize.width,expectedSize.height);
    
    return expectedSize;
    
}

////////////////////Camera Related

-(void)takeImage
{
    UIActionSheet *acsh=  [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Choose From Library",nil];
    self.camActionSheet=acsh;
    
    if(isShowActionSheetFromSelf)
       [self.camActionSheet showInView:self.view];
        else
    [self.camActionSheet showInView:self.appDelegate.centerViewController.view];
    
    isShowActionSheetFromSelf=0;
}

-(void)takeVideo
{
    UIActionSheet *acsh= nil;
    
    if(isShowTrainningVideoOption==1)
    acsh= [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Video",@"Choose From Library ",@"Choose From Trainning Videos",nil];
    else
           acsh= [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Video",@"Choose From Library ",nil];
    
    self.camActionSheet=acsh;
    [self.camActionSheet showInView:self.view];
    
    
    
  
}

-(void)getCameraPictureVideo:(id)sender
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        NSArray *arr=[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        int f=0;
        for(NSString *s in arr)
        {
            if([s isEqualToString:((NSString*)kUTTypeMovie)])
            {
                f=1;
                break;
            }
        }
        
        if(f==1)
        {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        self.imagepicker=picker;
        imagepicker.delegate =self;
        imagepicker.allowsEditing = YES;
        imagepicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        
        
        NSArray *mTypes =[[NSArray alloc] initWithObjects:(NSString*)kUTTypeMovie,nil];
        imagepicker.mediaTypes=mTypes;
            
            
        imagepicker.cameraCaptureMode=UIImagePickerControllerCameraCaptureModeVideo;
        imagepicker.cameraFlashMode=UIImagePickerControllerCameraFlashModeAuto;
       
            
            
        [self showModal:imagepicker];
        }
        else
        {
            [self showAlertMessage:@"Camera is not available." title:@""];
        }
    }
    else
    {
        [self showAlertMessage:@"Camera is not available." title:@""];
    }
}
- (void)useCameraRollVideo: (id)sender
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        [self selectExitingVideo];
    }
    else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [self selectExitingVideo];
    }
    else
    {
       /* MPMediaPickerController *picker =
        [[MPMediaPickerController alloc]
         initWithMediaTypes:(MPMediaTypeMovie|MPMediaTypeTVShow|MPMediaTypeVideoPodcast|MPMediaTypeMusicVideo|  MPMediaTypeVideoITunesU)];                   // 1
        
        [picker setDelegate: self];                                         // 2
        [picker setAllowsPickingMultipleItems:NO];                        // 3
        picker.prompt =
        NSLocalizedString (@"Select video to post",
                           "Prompt in media item picker");*/
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            NSArray *arr=[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
            int f=0;
            for(NSString *s in arr)
            {
                if([s isEqualToString:((NSString*)kUTTypeMovie)])
                {
                    f=1;
                    break;
                }
            }
            
            if(f==1)
            {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                self.imagepicker=picker;
                imagepicker.delegate =self;
                imagepicker.allowsEditing = YES;
                imagepicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                
                
                
                NSArray *mTypes =[[NSArray alloc] initWithObjects:(NSString*)kUTTypeMovie,nil];
                imagepicker.mediaTypes=mTypes;
                
                
                UIPopoverController *popv= [[UIPopoverController alloc] initWithContentViewController:imagepicker];
                self.popoverController =popv;
                popoverController.delegate = self;
                
                [self.popoverController presentPopoverFromRect:CGRectMake(125,875, 200, 300) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            }
            else
            {
                [self showAlertMessage:@"Camera is not available." title:@""];
            }
        }
        else
        {
            [self showAlertMessage:@"Camera is not available." title:@""];
        }

       
        
        
        
        
        
        
        
        
      
    }
}


-(void)selectExitingVideo
{
    
    
   /* MPMediaPickerController *picker =
    [[MPMediaPickerController alloc]
     initWithMediaTypes:(MPMediaTypeMovie|MPMediaTypeTVShow|MPMediaTypeVideoPodcast|MPMediaTypeMusicVideo|  MPMediaTypeVideoITunesU)];                   // 1
    
    [picker setDelegate: self];                                         // 2
    [picker setAllowsPickingMultipleItems:NO];                        // 3
    picker.prompt =
    NSLocalizedString (@"Select video to post",
                       "Prompt in media item picker");
    
    [self showModal:picker];   // 4
    [picker release];*/
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
    NSArray *arr=[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    int f=0;
    for(NSString *s in arr)
    {
        if([s isEqualToString:((NSString*)kUTTypeMovie)])
        {
            f=1;
            break;
        }
    }
    
    if(f==1)
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        self.imagepicker=picker;
        imagepicker.delegate =self;
        imagepicker.allowsEditing = YES;
        imagepicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        
        
        NSArray *mTypes =[[NSArray alloc] initWithObjects:(NSString*)kUTTypeMovie,nil];
        imagepicker.mediaTypes=mTypes;
        [self showModal:imagepicker];
    }
    else
    {
        [self showAlertMessage:@"Camera is not available." title:@""];
    }
    }
    else
    {
        [self showAlertMessage:@"Camera is not available." title:@""];
    }
}
- (void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{
    //[mediaItemCollection valueForProperty:<#(NSString *)#>]
}
- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker
{
     [self dismissModal];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if([actionSheet isEqual:self.camActionSheet])
    {
    NSString *choice = [self.camActionSheet buttonTitleAtIndex:buttonIndex];
    if ([choice isEqualToString:@"Take Photo"])
    {
        // do something else
        [self getCameraPicture:choice];
        NSLog(@"Camera will open");
        
    }
    else if ([choice isEqualToString:@"Choose From Library"])
    {
        // do something else
        [self useCameraRoll:actionSheet];
        NSLog(@"Library will open");
        
    }
    else if ([choice isEqualToString:@"Take Video"])
    {
        // do something else
        [self getCameraPictureVideo:choice];
        NSLog(@"Video will open");
        
    }
    else if ([choice isEqualToString:@"Choose From Library "])
    {
        // do something else
        [self useCameraRollVideo:actionSheet];
        NSLog(@"Video Library will open");
        
    }
    else if ([choice isEqualToString:@"Choose From Trainning Videos"])
    {
        // do something else
        [self openTrainningVideos];
        NSLog(@"Choose From Trainning Videos");
        
    }
        
        
    }
    else if([actionSheet isEqual:self.logoutActionSheet])
    {
        
        if(buttonIndex==0)
        [self reqlogout];
    }
}


-(void)openTrainningVideos
{
   appDelegate.trainningVideoVC.isFromHomeVC=1;
    [appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerTrainingVideo];
}

-(void)reqlogout
{
    
}

-(void)getCameraPicture:(id)sender
{
    
    
   
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        self.imagepicker=picker;
        imagepicker.delegate =self;
        imagepicker.allowsEditing = YES;
        imagepicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
        [self showModal:imagepicker];
        
    }
    else
    {
        [self showAlertMessage:@"Camera is not available." title:@""];
    }
   
}
- (void)useCameraRoll: (id)sender
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        [self selectExitingPicture];
    }
    else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [self selectExitingPicture];
    }
    else
    {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        self.imagepicker=picker;
        imagepicker.delegate = self;
        imagepicker.allowsEditing = YES;
        imagepicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        UIPopoverController *popv= [[UIPopoverController alloc] initWithContentViewController:imagepicker];
        self.popoverController =popv;
        popoverController.delegate = self;
        
        [self.popoverController presentPopoverFromRect:CGRectMake(125,875, 200, 300) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
        else
        {
            [self showAlertMessage:@"Library is not available." title:@""];
        }
    }
}
-(void)selectExitingPicture
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        //if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        //{
            UIImagePickerController *picker= [[UIImagePickerController alloc]init];
            self.imagepicker=picker;
            imagepicker.delegate = self;
            imagepicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
          
            [self showModal:imagepicker];
       // }
    }
    else
    {
        [self showAlertMessage:@"Library is not available." title:@""];
    }
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)  picker
{
    //  [picker dismissModalViewControllerAnimated:YES];
    // [self dismissModal:picker];
    [self dismissModal];
}




////////////////////
-(void)showHudAlert:(NSString*)text 
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode=MBProgressHUDModeText;
    hud.labelText =text;
    [self.view bringSubviewToFront:hud];
  
}




-(void)btnVideoClicked:(NSString*)videoPath
{
    if(videoPath==nil)
        return;
    
    @try
    {
        @autoreleasepool {
            
            
            NSLog(@"VideoPathWallPlaying=%@",[videoPath stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]);
        
        MPMoviePlayerViewController *moviePlayerViewController = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:videoPath]];
        [moviePlayerViewController.moviePlayer setControlStyle:MPMovieControlStyleFullscreen];
        [moviePlayerViewController.moviePlayer setShouldAutoplay:YES];
        [moviePlayerViewController.moviePlayer setFullscreen:NO animated:YES];
        [moviePlayerViewController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [moviePlayerViewController.moviePlayer setScalingMode:MPMovieScalingModeNone];
        [moviePlayerViewController.moviePlayer setUseApplicationAudioSession:NO];
        // Register to receive a notification when the movie has finished playing.
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlaybackStateDidChange:)
                                                     name:MPMoviePlayerPlaybackStateDidChangeNotification
                                                   object:nil];
        // Register to receive a notification when the movie has finished playing.
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayBackDidFinish:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:nil];
            ////// ORIENTATION  ///// AD 10th june
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerWillEnterFullscreenNotification:) name:MPMoviePlayerWillEnterFullscreenNotification object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerWillExitFullscreenNotification:) name:MPMoviePlayerWillExitFullscreenNotification object:nil];
            
            ////////////////
            
        [appDelegate.centerViewController presentMoviePlayerViewControllerAnimated:moviePlayerViewController];
        moviePlayerViewController.moviePlayer.movieSourceType = MPMovieSourceTypeStreaming;
        }
       
    }
    @catch (NSException *exception) {
        // throws exception
    }
}

////// ORIENTATION  ///// AD 10th june
-(NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    if (self.landscapeOnlyOrientation) {
        return UIInterfaceOrientationMaskLandscape | UIInterfaceOrientationMaskPortrait;
    }
    
    return UIInterfaceOrientationMaskPortrait;
}

- (void)moviePlayerWillEnterFullscreenNotification:(NSNotification*)notification {
    self.landscapeOnlyOrientation = YES;
}

- (void)moviePlayerWillExitFullscreenNotification:(NSNotification*)notification {
    self.landscapeOnlyOrientation = NO;
   // [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
}



#pragma mark -----------------------
#pragma mark MPMoviePlayer Notification Methods

-(void)moviePlaybackStateDidChange:(NSNotification *)notification
{
    MPMoviePlayerController *moviePlayerController = [notification object];
    
    
    NSLog(@"%@",NSStringFromClass([[notification object] class]));
    
    if (moviePlayerController.loadState == MPMovieLoadStatePlayable &&
        moviePlayerController.playbackState != MPMoviePlaybackStatePlaying)
    {
        [moviePlayerController play];
    }
    
    // Register to receive a notification when the movie has finished playing.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackStateDidChangeNotification
                                                  object:nil];
    moviePlayerController = nil;
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification
{
    MPMoviePlayerController *moviePlayerViewController = [notification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:nil];
    [appDelegate.centerViewController dismissMoviePlayerViewControllerAnimated];
    moviePlayerViewController = nil;
    
    
   // [appDelegate setHomeView];
}  



-(void)parseLikeAndComments:(NSArray*)arr
{
    
    // NSMutableArray *mar=[[NSMutableArray alloc] init];
    
    for(NSDictionary* dic in arr)
    {
        
        
        
        id mlike=nil;
        
        mlike= [dic objectForKey:@"Like_user_id" ] ;
        
        if(!mlike)
        {
            mlike= [dic objectForKey:@"Comment_user_id" ] ;
        }
        
        int flagg=0;
        if(mlike)
        {
            if([mlike isEqualToString:[appDelegate.aDef objectForKey:LoggedUserID] ])
                flagg=1;
        }
        
        if(mlike)
        {
            if(flagg)
            {
                
                continue;
            }
        }
        
        Invite   *data = nil;
        data= (Invite *)[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
        
        // LikeCommentData *data=[[LikeCommentData alloc] init];
        
        
        data.data1=[dic objectForKey:@"post_id"];
        data.last_id=[dic objectForKey:@"id"];
        data.isComment=[[NSNumber alloc] initWithBool:[[dic objectForKey:@"IsComment"] boolValue] ];
        if([dic objectForKey:@"adddate"])
        {
            int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
            
            NSDate *datetime=   [[appDelegate.dateFormatFullOriginalComment dateFromString:[dic objectForKey:@"adddate"]] dateByAddingTimeInterval:difftime]  ;
            
            
            
            data.datetime=datetime;
            
        }
        else
        {
            data.datetime=[[NSDate alloc] init];
        }
        
        
        if(![[dic objectForKey:PROFILEIMAGE] isEqualToString:@""])
        {
            NSString *profimg=[[NSString alloc] initWithFormat:@"%@%@",IMAGELINKTHUMB,[dic objectForKey:PROFILEIMAGE]];
            
            
            data.profImg=profimg;
            profimg=nil;
            
        }
        else
        {
            data.profImg=@"";
        }
        
        data.teamName= [dic objectForKey:@"t_n"];
        
        
        data.message=[dic objectForKey:@"message"];
        data.inviteStatus=[[NSNumber alloc] initWithInt:[[dic objectForKey:@"view_status"] integerValue] ];
        
        data.type=[[NSNumber alloc] initWithInt:6];
        // [mar addObject:data];
    }
    
    
    
    [appDelegate saveContext];
    
    
    
    
    /* MainInviteVC* maininvitevc=  (MainInviteVC*) [appDelegate.navigationControllerTeamInvites.viewControllers objectAtIndex:0];
     
     [maininvitevc.likeCommentsVC likeCommentArrayUpdated:mar];
     appDelegate.allHistoryLikesComments=mar;*/
    
    
    
}


-(void)parseLastTenPrimary:(NSArray*)arrays
{
    
    for(NSDictionary *dic in arrays)
    {
        
        
        NSString *tId= [ [NSString alloc] initWithFormat:@"%@", [dic objectForKey:@"t_id"]];
        Invite *invite=nil;/*(Invite*)  [self.centerViewController objectOfTypeInviteTeamResponseForUser:INVITE forId:tId andManObjCon:self.managedObjectContext];
                            
                            if(!invite)
                            {*/
        invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
        invite.teamName=[dic objectForKey:@"t_n"];
        invite.teamId=tId;
        
        
        invite.playerId=[dic objectForKey:@"p_id"];
        
        
        invite.playerName=[dic objectForKey:@"a_n"];
        invite.profImg=[[NSString alloc] initWithFormat:@"%@%@",IMAGELINKTHUMB,[dic objectForKey:@"a_img"]];
        invite.type=[NSNumber numberWithInt:10];
        ////////
        int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
        
        NSDate *datetime=   [[self.appDelegate.dateFormatFullOriginalComment dateFromString:[dic objectForKey:@"a_dt"]] dateByAddingTimeInterval:difftime]  ;
        
        
        invite.datetime=datetime;
        
        invite.viewStatus=[[NSNumber alloc] initWithBool:[[dic objectForKey:@"primary_view_inv"] boolValue]];
        
        
        
        invite.message=@"primary";
        
        
        
        if([[dic objectForKey:@"inv"] isEqualToString:@"Accept"])
            invite.inviteStatus=[[NSNumber alloc] initWithInt:1 ];
        else if([[dic objectForKey:@"inv"] isEqualToString:@"Decline"])
            invite.inviteStatus=[[NSNumber alloc] initWithInt:2 ];
        else if([[dic objectForKey:@"inv"] isEqualToString:@"Maybe"])
            invite.inviteStatus=[[NSNumber alloc] initWithInt:3 ];
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
}


-(void)parseLastTenPlayer:(NSArray*)arrays
{
    
    for(NSDictionary *dic in arrays)
    {
        
        
        NSString *tId= [ [NSString alloc] initWithFormat:@"%@", [dic objectForKey:@"t_id"]];
        Invite *invite=nil;/*(Invite*)  [self.centerViewController objectOfTypeInviteTeamResponseForUser:INVITE forId:tId andManObjCon:self.managedObjectContext];
                            
                            if(!invite)
                            {*/
        invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
        invite.teamName=[dic objectForKey:@"t_n"];
        invite.teamId=tId;
        
        
        invite.playerId=[dic objectForKey:@"p_id"];
        
        
        invite.playerName=[dic objectForKey:@"a_n"];
        invite.profImg=[[NSString alloc] initWithFormat:@"%@%@",IMAGELINKTHUMB,[dic objectForKey:@"a_img"]];
        invite.type=[NSNumber numberWithInt:10];
        ////////
        int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
        
        NSDate *datetime=   [[self.appDelegate.dateFormatFullOriginalComment dateFromString:[dic objectForKey:@"a_dt"]] dateByAddingTimeInterval:difftime]  ;
        
        
        invite.datetime=datetime;
        
        invite.viewStatus=[[NSNumber alloc] initWithBool:[[dic objectForKey:@"player_view_inv"] boolValue]];
        
        
        
        invite.message=@"player";
        
        
        
        if([[dic objectForKey:@"inv"] isEqualToString:@"Accept"])
            invite.inviteStatus=[[NSNumber alloc] initWithInt:1 ];
        else if([[dic objectForKey:@"inv"] isEqualToString:@"Decline"])
            invite.inviteStatus=[[NSNumber alloc] initWithInt:2 ];
        else if([[dic objectForKey:@"inv"] isEqualToString:@"Maybe"])
            invite.inviteStatus=[[NSNumber alloc] initWithInt:3 ];
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
}



-(void)parseLastTenEventPrimary:(NSArray*)arrays
{
    
        
        
        for(NSDictionary *dic in arrays)
        {
            
            NSString *tId= [ [NSString alloc] initWithFormat:@"%@", [dic objectForKey:@"team_id"]];
            Invite *invite=nil/*(Invite*)  [self objectOfTypeInviteTeamEventResponseForUser:INVITE forId:tId forEventId:[dic objectForKey:@"event_id"] andManObjCon:self.managedObjectContext]*/;
            
            if(!invite)
            {
                invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
                
                
                invite.teamName=[dic objectForKey:@"team_name"];
                invite.playerName=[dic objectForKey:@"Accepter_name"];
                
                
                invite.teamId=tId;
                
                
                invite.playerId=[dic objectForKey:@"player_id"];
                
                
                
                invite.profImg=[[NSString alloc] initWithFormat:@"%@%@",IMAGELINKTHUMB,[dic objectForKey:@"Accepter_image"]];
                invite.type=[NSNumber numberWithInt:11];
                ////////
                int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                
                NSDate *datetime=   [[appDelegate.dateFormatFullOriginalComment dateFromString:[dic objectForKey:@"Event_rply_Date"]] dateByAddingTimeInterval:difftime]  ;
                
                
                invite.datetime=datetime;
                
                
                if([[dic objectForKey:@"primary_view_event_invite"] boolValue])
                    invite.viewStatus=[[NSNumber alloc] initWithBool:1];
                else
                    invite.viewStatus=[[NSNumber alloc] initWithBool:0];
                
                
                
                invite.message=@"primary";
                
                
                
                if([[dic objectForKey:@"Status"] isEqualToString:@"Accept"])
                    invite.inviteStatus=[[NSNumber alloc] initWithInt:0 ];
                else if([[dic objectForKey:@"Status"] isEqualToString:@"Decline"])
                    invite.inviteStatus=[[NSNumber alloc] initWithInt:2 ];
                else if([[dic objectForKey:@"Status"] isEqualToString:@"Maybe"])
                    invite.inviteStatus=[[NSNumber alloc] initWithInt:3 ];
                
                invite.eventId=[dic objectForKey:@"event_id"];
                invite.eventName=[dic objectForKey:@"event_name"];
            }
            
            
        }
        
    


}


-(void)parseLastTenEventCoach:(NSArray*)arrays
{
    
    
    
    for(NSDictionary *dic in arrays)
    {
        
        
        NSString *tId= [ [NSString alloc] initWithFormat:@"%@", [dic objectForKey:@"team_id"]];
        
        
        
        Invite *invite=nil/*(Invite*)  [self objectOfTypeInviteTeamEventResponse:INVITE forTeam:[dic objectForKey:@"player_id"] forEventId:[dic objectForKey:@"event_id"] andManObjCon:self.managedObjectContext]*/;
        
        if(!invite)
        {
            invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
            
            
            
            invite.teamName=[dic objectForKey:@"team_name"];
            invite.playerName=[dic objectForKey:@"Accepter_name"];
            
            invite.teamId=tId;
            
            invite.playerId=[dic objectForKey:@"player_id"];
            
            invite.profImg=[[NSString alloc] initWithFormat:@"%@%@",IMAGELINKTHUMB,[dic objectForKey:@"Accepter_image"]];
            invite.type=[NSNumber numberWithInt:12];
            ////////
            int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
            
            NSDate *datetime=   [[appDelegate.dateFormatFullOriginalComment dateFromString:[dic objectForKey:@"Event_rply_Date"]] dateByAddingTimeInterval:difftime]  ;
            
            
            invite.datetime=datetime;
            
            if([[dic objectForKey:@"coach_view_event_invite"] boolValue])
                invite.viewStatus=[[NSNumber alloc] initWithBool:1];
            else
                invite.viewStatus=[[NSNumber alloc] initWithBool:0];
            
           
            
            if([[dic objectForKey:@"Status"] isEqualToString:@"Accept"])
                invite.inviteStatus=[[NSNumber alloc] initWithInt:0 ];
            else if([[dic objectForKey:@"Status"] isEqualToString:@"Decline"])
                invite.inviteStatus=[[NSNumber alloc] initWithInt:2 ];
            else if([[dic objectForKey:@"Status"] isEqualToString:@"Maybe"])
                invite.inviteStatus=[[NSNumber alloc] initWithInt:3 ];
            
            
            invite.eventId=[dic objectForKey:@"event_id"];
            invite.eventName=[dic objectForKey:@"event_name"];
        }
        
        

    }
}


-(void)parseLastTenAdminStatusResponse:(NSArray*)arrays
{
    
    
    for(NSDictionary *dic in arrays)
       {
        Invite *invite=nil;
        
       
        
        
      
          
            
            
            
            
            if(!invite)
            {
                invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
                invite.teamName=[dic objectForKey:@"t_n"];
                invite.teamId=[NSString stringWithFormat:@"%@", [dic objectForKey:@"t_id"] ];
                
                invite.playerId=[dic objectForKey:@"p_id"];
                invite.playerName=[dic objectForKey:@"a_n"];
                invite.profImg=[[NSString alloc] initWithFormat:@"%@%@",IMAGELINKTHUMB,[dic objectForKey:@"a_img"]];
                invite.type=[NSNumber numberWithInt:15];//15a
                ////////
                int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                
                NSDate *datetime=   [[self.appDelegate.dateFormatFullOriginalComment dateFromString:[dic objectForKey:@"a_dt"]] dateByAddingTimeInterval:difftime]  ;
                
                
                invite.datetime=datetime;
                
                invite.viewStatus=[[NSNumber alloc] initWithBool:0];
                
                if([[dic objectForKey:@"inv"] isEqualToString:@"Accept"])
                    invite.inviteStatus=[[NSNumber alloc] initWithInt:1 ];
                else if([[dic objectForKey:@"inv"] isEqualToString:@"Decline"])
                    invite.inviteStatus=[[NSNumber alloc] initWithInt:2 ];
                else if([[dic objectForKey:@"inv"] isEqualToString:@"Maybe"])
                    invite.inviteStatus=[[NSNumber alloc] initWithInt:3 ];
                
                
                
                
                if([[dic objectForKey:@"v_admin2_st"] boolValue])
                    invite.viewStatus=[[NSNumber alloc] initWithBool:1];
                else
                    invite.viewStatus=[[NSNumber alloc] initWithBool:0];
                
            }
            
            
            
            
            
            
            
            
            
            
            
            ///////////////////////////
            
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
}




-(void)parseLastTenEventPlayer:(NSArray*)arrays
{
    
    for(NSDictionary *dic in arrays)
    {
        
        NSString *tId= [[NSString alloc] initWithFormat:@"%@", [dic objectForKey:@"team_id"]];
        Invite *invite=(Invite*)  [self objectOfTypeInviteTeamEventResponseForUser:INVITE forId:tId forEventId:[dic objectForKey:@"event_id"] andManObjCon:self.managedObjectContext];
        
        if(!invite)
        {
            invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
            
            
            invite.teamName=[dic objectForKey:@"team_name"];
            invite.playerName=[dic objectForKey:@"Accepter_name"];
            
            
            invite.teamId=[dic objectForKey:@"team_id"];    ///// ARPITA 29th
            
            
            invite.playerId=[dic objectForKey:@"player_id"];
            
            
            
            invite.profImg=[[NSString alloc] initWithFormat:@"%@%@",IMAGELINKTHUMB,[dic objectForKey:@"Accepter_image"]];
            invite.type=[NSNumber numberWithInt:11];
            ////////
            int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
            
            NSDate *datetime=   [[appDelegate.dateFormatFullOriginalComment dateFromString:[dic objectForKey:@"Event_rply_Date"]] dateByAddingTimeInterval:difftime]  ;
            
            
            invite.datetime=datetime;
            
            
            if([[dic objectForKey:@"player_view_event_invite"] boolValue])
            invite.viewStatus=[[NSNumber alloc] initWithBool:1];
            else
            invite.viewStatus=[[NSNumber alloc] initWithBool:0];
            
            
           
                invite.message=@"player";
            
            
            
            if([[dic objectForKey:@"Status"] isEqualToString:@"Accept"])
                invite.inviteStatus=[[NSNumber alloc] initWithInt:0 ];
            else if([[dic objectForKey:@"Status"] isEqualToString:@"Decline"])
                invite.inviteStatus=[[NSNumber alloc] initWithInt:2 ];
            else if([[dic objectForKey:@"Status"] isEqualToString:@"Maybe"])
                invite.inviteStatus=[[NSNumber alloc] initWithInt:3 ];
            
            invite.eventId=[dic objectForKey:@"event_id"];
            invite.eventName=[dic objectForKey:@"event_name"];
        }
        

    }
    
    
}


-(void)parseLastUpdateEvent:(NSArray*)arrays
{
    
    NSString *strId=@"";
    //////////////////
    for(NSDictionary *eventUpdateDetails in arrays)
    {
        
        
        if(![[eventUpdateDetails objectForKey:@"event_id"] isEqualToString:strId])
        {
            strId=[eventUpdateDetails objectForKey:@"event_id"];
            Invite   *eventvar = nil;
            
            eventvar= (Invite *)[NSEntityDescription insertNewObjectForEntityForName:EVENTUNREAD inManagedObjectContext:self.managedObjectContext];
            
            /////////////////////////Add Event Record for same event if exist
            Invite *anObj1 = nil;
            NSFetchRequest * request1 = [[NSFetchRequest alloc] init];
            [request1 setEntity:[NSEntityDescription entityForName:EVENTUNREAD inManagedObjectContext:self.managedObjectContext]];
            
            [request1 setPredicate:[NSPredicate predicateWithFormat:@"(eventId==%@) AND (userId==%@) AND (type==%i)",[eventUpdateDetails objectForKey:@"event_id"],[appDelegate.aDef objectForKey:LoggedUserID],5]];
           // [request1 setPredicate:[NSPredicate predicateWithFormat:@"(eventId==%@) AND (view_status==%@) AND (userId==%@) AND (type==%i)",[eventUpdateDetails objectForKey:@"event_id"],1,[appDelegate.aDef objectForKey:LoggedUserID],5]];
            
            NSArray* ar1 =nil;
            ar1= [self.managedObjectContext executeFetchRequest:request1 error:nil];
            if ([ar1 count]>=1)
            {
                anObj1= (Invite *) [ar1 objectAtIndex:0];
            }
            
            
        
            
            ///////
            
            eventvar.viewStatus=[NSNumber numberWithInt:[[eventUpdateDetails objectForKey:EUpdtVIEWSTATUS] intValue]];
            eventvar.last_id=[eventUpdateDetails objectForKey:EUpdtLASTID];
            eventvar.inviteStatus=[NSNumber numberWithInt:1];
            eventvar.isPublic=[NSNumber numberWithBool:1];
            if(anObj1)
            {
                eventvar.playerName=anObj1.playerName;
                eventvar.playerId= anObj1.playerId ;
                eventvar.playerUserId=anObj1.playerUserId ;
            }
            if([eventUpdateDetails objectForKey:@"event_name"])
                eventvar.eventName=[eventUpdateDetails objectForKey:@"event_name"];
            eventvar.eventId=[eventUpdateDetails objectForKey:@"event_id"];
            
            if([eventUpdateDetails objectForKey:@"team_name"])
                eventvar.teamName=[eventUpdateDetails objectForKey:@"team_name"];
            if([eventUpdateDetails objectForKey:@"team_logo"])
                eventvar.teamLogo=[eventUpdateDetails objectForKey:@"team_logo"];
            eventvar.userId=[appDelegate.aDef objectForKey:LoggedUserID];
            if([eventUpdateDetails objectForKey:@"update_date"])
            {
                int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                
                NSDate *datetime=   [[appDelegate.dateFormatFullOriginalComment dateFromString:[eventUpdateDetails objectForKey:@"update_date"]] dateByAddingTimeInterval:difftime]  ;
                
                
                eventvar.datetime=datetime;
            }
            eventvar.type=[[NSNumber alloc] initWithInt:8];
            
            NSString *eDate=nil;
            eDate=[eventUpdateDetails objectForKey:@"event_date"];
            
            if(eDate)
            {
                int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                
                NSDate *datetime=   [[appDelegate.dateFormatFullOriginalComment dateFromString:eDate] dateByAddingTimeInterval:difftime]  ;
                
                
                eventvar.eventDate=datetime;
            }
            
            
        }
        
        
        
    }
    [appDelegate saveContext];
    
    
}



-(void)parseLastDeleteEvent:(NSArray*)arrays
{
    for(NSDictionary *eventDetails in arrays)
    {
        
        if([[eventDetails objectForKey:EDelVIEWSTATUS] intValue]==0)
        {
            
            Invite   *eventvar = nil;
            eventvar= (Invite *)[NSEntityDescription insertNewObjectForEntityForName:EVENTUNREAD inManagedObjectContext:self.managedObjectContext];
            
            
            /////////////////////////Add Event Record for same event if exist
            Invite *anObj1 = nil;
            NSFetchRequest * request1 = [[NSFetchRequest alloc] init];
            [request1 setEntity:[NSEntityDescription entityForName:EVENTUNREAD inManagedObjectContext:self.managedObjectContext]];
            
            [request1 setPredicate:[NSPredicate predicateWithFormat:@"(eventId==%@) AND (userId==%@) AND (type==%i)",[eventDetails objectForKey:@"event_id"],[appDelegate.aDef objectForKey:LoggedUserID],5]];
            
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
            
            eventvar.viewStatus=[NSNumber numberWithInt:[[eventDetails objectForKey:EDelVIEWSTATUS] intValue]];
            eventvar.last_id=[eventDetails objectForKey:EDelLASTID];
            
            eventvar.eventName=[eventDetails objectForKey:@"event_name"];//[eventUpdateDetails objectForKey:@"event_name"];
            eventvar.eventId=[eventDetails objectForKey:@"event_id"];
            
            // if([eventUpdateDetails objectForKey:@"team_name"])
            eventvar.teamName=[eventDetails objectForKey:@"team_name"];
            if([eventDetails objectForKey:@"team_logo"])
                eventvar.teamLogo=[eventDetails objectForKey:@"team_logo"];
            eventvar.userId=[appDelegate.aDef objectForKey:LoggedUserID];
            if([eventDetails objectForKey:@"update_date"])
            {
                int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                
                NSDate *datetime=   [[appDelegate.dateFormatFullOriginalComment dateFromString:[eventDetails objectForKey:@"update_date"]] dateByAddingTimeInterval:difftime]  ;
                
                
                eventvar.datetime=datetime;
            }
            eventvar.type=[[NSNumber alloc] initWithInt:9];
            
            
            NSString *eDate=[eventDetails objectForKey:@"event_date"];
            if(eDate)
            {
                int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                
                NSDate *datetime=   [[appDelegate.dateFormatFullOriginalComment dateFromString:eDate] dateByAddingTimeInterval:difftime]  ;
                
                
                eventvar.eventDate=datetime;
            }
            
        }
    }
    [appDelegate saveContext];
    
    
}

-(BOOL)checkInternetConnection{
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        return NO;
        //
        NSLog(@"There IS NO internet connection");
    } else {
        
        return YES;
        NSLog(@"There IS internet connection");
    }
    
}




@end
