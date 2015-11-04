//
//  BaseVC.h
//  LinkBook
//
//  Created by Piyali on 21/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//#import "SMSRECORDPD.h"

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MessageUI.h>
#import "WebViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "Reachability.h"
#import <iAd/iAd.h>

@class CommentVC;
@class PlayerRelationVC;
@class FPPopoverController;
@class PostLikeViewController;
@class NSFetchedResultsController;
@class Event;
@class Invite;
@class NSManagedObject;
/*@protocol MFMessageComposeViewControllerCustomDelegate < MFMessageComposeViewControllerDelegate>

    - (void)loadViewDidLoad;

@end*/
@class Contacts;
@class SingleRequest;
@class ASIHTTPRequest;
@class ASIFormDataRequest;
@class PlayerListViewController;
@interface BaseVC : UIViewController <MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPopoverControllerDelegate,MPMediaPickerControllerDelegate,ADBannerViewDelegate>
{
AppDelegate* __weak appDelegate;

NSManagedObjectContext *__weak managedObjectContext;
    NSTimeZone *ctimezone;
    NSCalendar *calender;
    BOOL isLandscape;
     BOOL isiPhone5;
     BOOL isiPhone;
     BOOL isiPad;
     NSTimer *basetimer;
     UIView *baseview;
 
   
    UILabel *mylab1;
 
    UIButton *mybt1;
   

    IBOutlet UIImageView *topimav;
    IBOutlet UIView *topview;
    
    
    UIColor *whitecolor;
     UIColor *blackcolor;
     UIColor *clearcolor;
    UIColor *darkgraycolor;
    UIColor *cellgreencolor;
     UIColor *graycolor;
    UIColor *lightgraycolor;
     UIColor *lightbluecolor;
    UIColor *lightblackcolor;
    float systemVersion;
    NSFetchedResultsController *fetchedResultsController;
    BOOL isFromEmailShare;
    BOOL isFromSMSShare;
    NSMutableArray *storeCreatedRequests;
    
    UITapGestureRecognizer *tapGesture;
    
    FPPopoverController *relationPopover;
    PlayerRelationVC *relationVC;
    
    
    UIImage *crossImage;
     UIImage *tickImage;
    UIImage *questionmarkImage;
    
    UIImage *teamNoImage;
}

@property BOOL landscapeOnlyOrientation;

-(void)storeUser:(NSArray*)userarray;
-(void)getUserListing:(NSString*)teamId :(NSString*)search :(NSString*)limit :(NSString*)start :(BOOL)mode;
-(void)btnVideoClicked:(NSString*)videoPath;

@property(nonatomic,strong) PlayerListViewController *playerAttendance;
@property(nonatomic,strong) UIImage *teamNoImage;
@property(nonatomic,strong)UIImage *imageDtae;
@property(nonatomic,strong)UIImage *playerImage;
@property(nonatomic,strong)UIImage *sportsImage;
@property(nonatomic,strong) UIImage *photoImage;
@property(nonatomic,strong) UIImage *videoImage;



@property(nonatomic,strong) UIImage *teamGrayImage;
@property(nonatomic,strong) UIImage *teamRedImage;
@property(nonatomic,strong) UIImage *dateGrayImage;
@property(nonatomic,strong) UIImage *dateRedImage;
@property(nonatomic,strong) UIImage *playergrayImage;
@property(nonatomic,strong) UIImage *playerRedImage;



@property(nonatomic,strong) PostLikeViewController *postLikeVC;
@property(nonatomic,strong) CommentVC *commVC;




@property(nonatomic,strong) UIFont *helveticaFontBold;



@property(nonatomic,strong)NSMutableArray *sportsImageArr;

@property(nonatomic,strong)NSMutableArray *adminTypeArr;  //// 13/01/2015


@property(nonatomic,strong) UIImage *cricketImage;
@property(nonatomic,strong) UIImage *americanfotballImage;
@property(nonatomic,strong) UIImage *basketballImage;
@property(nonatomic,strong) UIImage *baseballImage;
@property(nonatomic,strong) UIImage *hockeyImage;
@property(nonatomic,strong) UIImage *lacrosseImage;
@property(nonatomic,strong) UIImage *soccerImage;
@property(nonatomic,strong) UIImage *volleyballImage;

@property(nonatomic,strong) UIImage *badmintonImage;
@property(nonatomic,strong) UIImage *bicyclingImage;
@property(nonatomic,strong) UIImage *chessImage;
@property(nonatomic,strong) UIImage *fieldhockeyImage;
@property(nonatomic,strong) UIImage *fishingImage;
@property(nonatomic,strong) UIImage *footballImage;
@property(nonatomic,strong) UIImage *iceHockeyImage;
@property(nonatomic,strong) UIImage *kayakingImage;
@property(nonatomic,strong) UIImage *picnicImage;
@property(nonatomic,strong) UIImage *reunionImage;
@property(nonatomic,strong) UIImage *rowingImage;
@property(nonatomic,strong) UIImage *runningImage;
@property(nonatomic,strong) UIImage *skiingImage;
@property(nonatomic,strong) UIImage *tabletennisImage;
@property(nonatomic,strong) UIImage *tennisImage;
@property(nonatomic,strong) UIImage *walkingImage;



@property (nonatomic,strong) UIFont *helveticaFontForte;
@property (nonatomic,strong) UIFont *helveticaFontForteBold;

@property (nonatomic,strong) FPPopoverController *relationPopover;
@property (nonatomic,strong) PlayerRelationVC *relationVC;
@property (nonatomic,strong) UIFont *helveticaFont;
@property (nonatomic,strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic,strong) UIImage *privateDotImage;
@property (nonatomic,strong) UIImage *publicDotImage;
//@property(nonatomic,strong) WebViewController *wview;
@property (nonatomic ,strong) NSMutableDictionary *requestDic;
@property (assign)  float systemVersion;
@property (nonatomic,assign) BOOL isBusy;
@property (nonatomic ,strong) UIColor *whitecolor;
@property (nonatomic ,strong) UIColor *blackcolor;
@property (nonatomic ,strong) UIColor *clearcolor;
@property (nonatomic ,strong) UIColor *darkgraycolor;
@property (nonatomic ,strong) UIColor *cellgreencolor;
@property (nonatomic ,strong) UIColor *graycolor;
@property (nonatomic ,strong) UIColor *lightgraycolor;
@property (nonatomic ,strong) UIColor *lightbluecolor;
@property (nonatomic ,strong) UIColor *lightblackcolor;
@property (nonatomic ,strong)  IBOutlet UIButton *mybt1;
@property (nonatomic ,strong) NSArray *arrPickerItemsRepeat;
@property (nonatomic ,strong) NSArray *arrPickerItemsAlert;

@property (nonatomic ,strong)  IBOutlet UILabel *mylab1;
-(void)deleteObjectOfTypeEvent:(Event*) identifier;
//@property (nonatomic ,strong) ProgressViewController *tmvc;
@property (strong, nonatomic) UIColor *darkGrayColor;
@property(nonatomic,assign) BOOL isFromSMSShare;
@property(nonatomic,assign) BOOL isFromEmailShare;

@property(nonatomic,assign) BOOL isShowActionSheetFromSelf;

@property(nonatomic,assign) BOOL isLandscape;
@property(nonatomic,assign) BOOL isiPhone5;
@property(nonatomic,assign) BOOL isiPhone;
@property(nonatomic,assign) BOOL isiPad;
@property (nonatomic ,strong) NSTimer *basetimer;
@property (nonatomic ,strong) UIView *baseview;
@property(nonatomic, weak) AppDelegate* appDelegate;
@property (nonatomic,strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, weak) NSManagedObjectContext *managedObjectContext;
@property (nonatomic ,strong) NSTimeZone *ctimezone;
@property (nonatomic ,strong) NSCalendar *calender;

@property (nonatomic,strong) NSDate *smsfiringdate;
@property(nonatomic,strong) UIAlertView *noofbatchalertview;
/////////////remainning
@property (nonatomic,strong) UIAlertView *inappalert;
@property(nonatomic,assign) BOOL isModallyPresentFromCenterVC;
@property (nonatomic ,strong) IBOutlet UIImageView *topimav;
@property (nonatomic ,strong) IBOutlet UIView *topview;
@property (strong, nonatomic) UIColor *redcolor;
@property (nonatomic ,strong) NSTimer *loadingtimer;

@property (nonatomic ,strong) SingleRequest *sinReq1;
@property (nonatomic ,strong) SingleRequest *sinReq2;
@property (nonatomic ,strong) SingleRequest *sinReq3;
@property (nonatomic ,strong) SingleRequest *sinReq4;
@property (nonatomic ,strong) ASIFormDataRequest *myFormRequest1;
@property (nonatomic ,strong) ASIFormDataRequest *myFormRequest2;
@property (nonatomic ,strong) ASIHTTPRequest *myPlainRequest1;
@property (nonatomic ,strong) ASIHTTPRequest *myPlainRequest2;

@property (nonatomic ,strong) NSMutableArray *storeCreatedRequests;

@property(nonatomic,strong) UIImage *itemdefaultImage;
@property (strong, nonatomic) UIImage *crossImage;
@property (strong, nonatomic) UIImage *tickImage;
@property (strong, nonatomic) UIImage *questionmarkImage;
@property (strong, nonatomic) UIImage *maybeQuestionmarkImage;

@property(nonatomic,assign) BOOL isShowTrainningVideoOption;
-(void)setLogOut;
-(BOOL) validEmail:(NSString*) emailString;

-(void)setuporientation;
//-(int)getRangeForAtATime;
-(void)showAlertMessage:(NSString*) msg;
/////////////
-(void)sendSMS:(NSString *)emailstr :(NSString*)emailbody;
-(NSString *)userDocDirPath;
-(NSString *)getDateTime:(NSDate *)cdate;
-(void)showAlertMessage:(NSString*) msg title:(NSString *)titl;
-(NSDate *)getFirstWeekDay:(NSDate *)date;
//-(NSManagedObject*)objectOfType:(NSString*) aType forKey:(NSNumber*) aKey andValue:(NSDate*) anId andTruck:(NSString*)truckId;
-(void)setRegFont:(id)obj withSize:(CGFloat)size;
/*-(void)setItaFont:(id)obj withSize:(CGFloat)size;
-(void)setRegBoldFont:(id)obj withSize:(CGFloat)size;
-(void)setItaBoldFont:(id)obj withSize:(CGFloat)size;*/
-(void)openTrainningVideos;
-(void)myoverride;
-(void)showImageStatus:(NSString *)imageName;
-(NSString*)selectXib:(NSString*)xibName;
-(void)bottombtapped:(id)sender;
-(void)createBottomView;
-(void)showHudView:(NSString*)str;
-(void)hideHudView;
-(void)showNativeHudView;
-(void)hideNativeHudView;
-(void)changeSubviewsFrame;
-(void)showModal:(id)vc;
-(void)dismissModal;

-(void)showModalEventInvite:(id)vc;    ////   06/03/2015
-(void)dismissModalEventInvte;        ////   06/03/2015

-(NSString *)getDateTimeCan:(NSDate *)cdate;
-(void)takeVideo;
-(void)dismissModalArg:(UIViewController*)sender;
/*-(void)bringProgress:(int)seconds;
-(void)hideProgress;
-(int)getTimeRangeForAtATime;*/
-(void)getCameraPictureVideo:(id)sender;
- (void)useCameraRollVideo: (id)sender;
-(NSDate *)dateFromSD:(NSDate *)date;
-(NSDate *)dateFromSDLast:(NSDate *)date;
-(Event*)objectOfType1Event:(NSString*) identifier;
-(void)selectExitingVideo;

-(NSString *)getDateTimeForHistory:(NSDate *)cdate;
////////
- (IBAction)sharebtapped:(id)sender;
//- (IBAction)popupbtapped:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *popupview;
@property (strong, nonatomic) MFMailComposeViewController *fvc2;

@property (strong, nonatomic) MFMessageComposeViewController *fvc1;
-(void)displayComposerEmailSheet:(NSString *)emailstr :(NSString *)bodycontent;
-(void)displaySMSComposerSheet:(NSString *)emailstr :(NSString *)bodycontent;
-(void)sendMail:(NSString *)emailstr :(NSString*)emailbody;
-(Contacts*)objectOfType:(NSString*) aType forName:(NSString*) aKey  andManObjCon:(NSManagedObjectContext*)managedobjectContext;
-(void)userListUpdated:(id)sender;
//-(SMSRECORDPD*)objectOfType1CapLimitSMSCheck:(NSDate*) aType;

-(Event*)objectOfType2Event:(NSString*) identifier;
-(void)setLayOutForLanguage;
@property (strong, nonatomic) UIImage *noImage;
@property(nonatomic,strong) UIImage *noVideThumbImage;
@property(nonatomic,strong)UIImage *noAlbumImage;

/////////Camera Related
-(NSString *)getDateTimeCanName:(NSDate *)cdate;
@property(nonatomic,strong) UIActionSheet *camActionSheet;
@property(nonatomic,strong) UIActionSheet *logoutActionSheet;
@property(nonatomic,strong) UIImagePickerController *imagepicker;
-(void)getCameraPicture:(id)sender;
- (void)useCameraRoll: (id)sender;
-(void)selectExitingPicture;
-(void)takeImage;
@property(nonatomic,strong) UIPopoverController *popoverController;
-(NSArray*)objectOfType1EventStartDate:(NSDate*) start EndDate:(NSDate*) end :(NSString*)teamId :(NSString*)playerId :(BOOL)isStatusAcceptence :(int)statusAcceptence;


-(NSManagedObject*)objectOfTypeInvite:(NSString*) aType forTeam:(NSString*) aKey forUpdate:(int)m forUpdateId:(NSString*)updateid andManObjCon:(NSManagedObjectContext*)managedobjectContext;
/////////
-(void)showHudAlert:(NSString*)text ;
-(void)resetVC;
-(void)loadVC;
-(Invite*)objectOfTypeInvite:(NSString*) aType forTeam:(NSString*) aKey  andManObjCon:(NSManagedObjectContext*)managedobjectContext;
//-(void)storeInvites:(NSArray*)userarray;
-(void)deleteAllInvites;
-(NSMutableArray*)getImageInfoArrayThroughConvert:(NSMutableArray*)marray;
-(void)setCalibriFont:(id)obj withSize:(CGFloat)size;
-(void)setDiavloFont:(id)obj withSize:(CGFloat)size;
-(void)deleteAllEvents:(NSString*)teamId;
-(NSDate*)getAlertDateForAlertString:(NSString*)str :(NSDate*)date;
-(UIImage*)getImage:(UIImage*)image isWidth:(BOOL)isWidth length:(int)length;
-(NSString*)getTimeString:(long long int)timestamp;
-(NSString*)getPartTimeString:(long long int)timestamp;
-(long long int)getTimeStampFromDateString:(NSString*)datestr;
-(float)getImageLengthOfWidth:(float)orgLength1 OfHeight:(float)orgLength2 isWidth:(BOOL)isWidth length:(int)length;
-(UIColor*)colorWithHexString:(NSString*)hex;
-(Invite*)objectOfTypeInvite:(NSString*) aType forPost:(NSString*) aKey forUser:(NSString*) aKey1 forType:(int) type andManObjCon:(NSManagedObjectContext*)managedobjectContext;
-(Invite*)objectOfTypeInvite:(NSString*) aType forTeam:(NSString*) aKey forUpdate:(int)m andManObjCon:(NSManagedObjectContext*)managedobjectContext;
-(void)reqlogout;
-(void)callNumber:(NSString*)phoneNo;

-(void)disableSlidingAndHideTopBar;
-(void)enableSlidingAndShowTopBar;
-(void)getUserListingPush:(NSString*)teamId :(NSString*)search :(NSString*)limit :(NSString*)start :(BOOL)mode;
-(NSDate*)dateFromGMTStringDate:(NSString*)datestr;


-(Invite*)objectOfTypeInvite:(NSString*) aType forTeam1:(NSString*) aKey  andManObjCon:(NSManagedObjectContext*)managedobjectContext;



-(Invite*)objectOfTypeInviteTeamResponse:(NSString*) aType forTeam:(NSString*) aKey  andManObjCon:(NSManagedObjectContext*)managedobjectContext;



-(void)showNavigationBarButtons;

-(NSString *)getDateTimeForHistoryWithoutDate:(NSDate *)cdate;
-(void)setStatusBarStyleOwnApp:(BOOL)isLightContent;

@property (strong, nonatomic) UIBarButtonItem *leftBarButtonItem;
@property (strong, nonatomic) UIBarButtonItem *rightBarButtonItem;

-(void)disableMySwipes;
-(void)enableMyHomeSwipe;
-(void)enableMyTeamSwipe;

-(Invite*)objectOfTypeInvite:(NSString*) aType forType:(int) type andManObjCon:(NSManagedObjectContext*)managedobjectContext;

-(CGSize)getSizeOfText:(NSString*)textStr :(CGSize) constsize :(UIFont*)textFont;

-(Invite*)objectOfTypeTeamInvite:(NSString*) aType forTeam1:(NSString*) aKey  andManObjCon:(NSManagedObjectContext*)managedobjectContext;



-(Invite*)objectOfTypeInviteTeamResponseForUser:(NSString*) aType forId:(NSString*) aKey  andManObjCon:(NSManagedObjectContext*)managedobjectContext;


-(Invite*)objectOfTypeInviteTeamEventResponse:(NSString*) aType forTeam:(NSString*) aKey forEventId:(NSString*) aKey1 andManObjCon:(NSManagedObjectContext*)managedobjectContext;


-(Invite*)objectOfTypeInviteTeamEventResponseForUser:(NSString*) aType forId:(NSString*) aKey  forEventId:(NSString*) aKey1 andManObjCon:(NSManagedObjectContext*)managedobjectContext;

-(Invite*)objectOfTypeAdminInvite:(NSString*) aType forTeam1:(NSString*) aKey  andManObjCon:(NSManagedObjectContext*)managedobjectContext;


-(Invite*)objectOfTypeInviteAdminResponse:(NSString*) aType forTeam:(NSString*) aKey forAdmin:(NSString*) aKey1 andManObjCon:(NSManagedObjectContext*)managedobjectContext;

-(void)parseLikeAndComments:(NSArray*)arr;
-(void)parseLastTenPrimary:(NSArray*)arrays;
-(void)parseLastTenPlayer:(NSArray*)arrays;
-(void)parseLastUpdateEvent:(NSArray*)arrays;
-(void)parseLastDeleteEvent:(NSArray*)arrays;
-(void)parseLastTenEventPrimary:(NSArray*)arrays;
-(void)parseLastTenEventPlayer:(NSArray*)arrays;
-(void)parseLastTenEventCoach:(NSArray*)arrays;
-(void)parseLastTenAdminStatusResponse:(NSArray*)arrays;

-(BOOL)checkInternetConnection;

@end
