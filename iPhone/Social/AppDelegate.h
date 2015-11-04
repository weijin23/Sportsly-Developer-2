//
//  AppDelegate.h
//  Social
//
//  Created by Mindpace on 08/08/13.
//
//
#import "SingleRequest.h"
#import "SBJson.h"
#import "JASidePanelController.h"
#import <UIKit/UIKit.h>
#import "DataModel.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>
#import <CoreLocation/CoreLocation.h>
//#import <FacebookSDK/FacebookSDK.h>


@class HomeVC;
@class LeftViewController;
@class RightViewController;
@class CenterViewController;
@class EventEditViewController;
@class ShowVideoViewController;
@class NSManagedObject;
@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>
{
    double locationLat;
    double locationLong;
    CLLocationManager* locationManager;
    CLLocation *currentLocation;
}
@property(nonatomic,retain) NSMutableArray *myFriendList;
@property(nonatomic,retain) NSArray *messageUserList;
@property(nonatomic,assign) BOOL isIos7;
@property(nonatomic,assign) BOOL isIos8;
@property(nonatomic,assign) float commonHeight;

@property(nonatomic,strong) NSMutableArray *storeCreatedRequests;
@property(nonatomic,assign) double locationLat;
@property(nonatomic,assign) double locationLong;
@property(nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;
-(void)createLocationManager;
-(void)getNewUpdate;

@property (nonatomic ,strong) UIColor *backgroundPinkColor;
@property (nonatomic ,strong) UIColor *barGrayColor;
@property (nonatomic ,strong) UIColor *clearcolor;

@property(nonatomic,assign) int deviceScale;
@property(nonatomic,assign) BOOL isProcessEventPublic;

@property (nonatomic,strong) UIColor *themeCyanColor;
@property (nonatomic,strong) UIColor *veryLightGrayColor;
@property (nonatomic,strong) UIColor *cellRedColor;
@property (nonatomic,strong) UIColor *topBarRedColor;
@property (nonatomic,strong) UIColor *labelRedColor;
@property (nonatomic,strong) UIColor *leftPanelGrayColor;
@property (nonatomic,strong) NSMutableArray *JSONDATAarr;
@property (nonatomic,strong) NSMutableArray *JSONDATAMemberarr;
@property (nonatomic,strong) NSMutableArray *JSONDATAImages;
@property (nonatomic, strong) NSMutableArray* arrItems;
@property (nonatomic, strong) NSMutableArray* allHistoryLikesComments;
@property (nonatomic,assign) long int allHistoryLikesCounts;
@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
- (void)saveContext;
@property (strong, nonatomic) EKEventStore *eventStore;
// Default calendar associated with the above event store
@property (nonatomic, strong) EKCalendar *defaultCalendar;
@property (nonatomic, strong) NSMutableArray *teamList;
// Array of all events happening within the next 24 hours
@property (nonatomic, strong) NSMutableArray *eventsList;
@property (nonatomic, strong) NSMutableArray *eventsTempStoreArr;
@property (strong, nonatomic) UINavigationController *navigationControllerfirst;
@property (strong, nonatomic) UINavigationController *navigationControllerCalendar;
@property (strong, nonatomic) UINavigationController *navigationControllerTeamMaintenance;
@property (strong, nonatomic) UINavigationController *navigationControllerMyTeams;  ////AD july For Myteam
@property (strong, nonatomic) UINavigationController *navigationControllerAddAFriend;
@property (strong, nonatomic) UINavigationController *navigationControllerFindTeam;
@property (strong, nonatomic) UINavigationController *navigationControllerMyPhoto;
@property (strong, nonatomic) UINavigationController *navigationControllerSettings;
@property(nonatomic,retain)   UINavigationController *navigationControllerClubLeague;
@property(nonatomic,retain) UINavigationController *navigationControllerMyContact;
@property(nonatomic,retain) UINavigationController *navigationControllerMySchdule;
@property(nonatomic,retain)UINavigationController *navigationControllerTrainingVideo;
@property(nonatomic,retain)UINavigationController *navigationControllerBuySell;
@property(nonatomic,retain)UINavigationController *navigationControllerFaq;
@property(nonatomic,retain)UINavigationController *navigationControllerFeedBack;
@property(nonatomic,retain)UINavigationController *navigationControllerTutorial;
@property(nonatomic,retain)UINavigationController *navigationControllerCoachUpdate;
@property(nonatomic,retain)UINavigationController *navigationControllerTeamInvites;
@property(nonatomic,retain) UINavigationController *navigationControllerEventNews;
@property(nonatomic,retain)UINavigationController *navigationControllerChatMessage;
@property(nonatomic,retain) UINavigationController *navigationControllerPrimaryMemeber;
@property(nonatomic,retain) UINavigationController *navigationControllerTeamEvents;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) UINavigationController *navigationControllerCenter;
@property (strong, nonatomic) UINavigationController *navigationControllerLeft;
@property (strong, nonatomic) UINavigationController *navigationControllerRight;
@property (assign, nonatomic) float systemVersion;
@property (assign, nonatomic) float locationLatPlayground;
@property (assign, nonatomic) float locationLongPlayground;
- (NSURL *)applicationDocumentsDirectory;
-(void)addRootVC:(UIViewController*)vc;
@property (nonatomic, strong) NSUserDefaults *aDef;
-(void)setUserDefaultValue:(id)value ForKey:(NSString *)key;
-(void)removeUserDefaultValueForKey:(NSString *)key;
@property (strong, nonatomic) NSDateFormatter* dateFormatM;
@property (strong, nonatomic) NSDateFormatter* dateFormatDb;
@property (nonatomic ,strong) SingleRequest *sinReq1;
@property (nonatomic ,strong) SingleRequest *sinReq2;
@property (strong, nonatomic) NSDateFormatter* dateFormatDbAmerican;
@property (strong, nonatomic) NSDateFormatter* dateFormatFullHome;
@property (strong, nonatomic) NSDateFormatter* dateFormatFull;
@property (strong, nonatomic) NSDateFormatter* dateFormatFullOriginal;
@property (strong, nonatomic) NSDateFormatter* dateFormatFullOriginalComment;
@property (strong, nonatomic) NSDateFormatter* dateFormatEvent;
@property (strong, nonatomic) NSDateFormatter* dateFormatEventShort;
@property (strong, nonatomic) JASidePanelController *slidePanelController;
@property (strong, nonatomic) DataModel *dataModel;
@property (strong, nonatomic) LeftViewController *leftVC;
@property (strong, nonatomic) RightViewController *rightVC;
@property (strong, nonatomic) HomeVC *centerVC;
@property (strong, nonatomic) CenterViewController *centerViewController;
@property (strong, nonatomic) EventEditViewController *eventEditViewController;
@property (assign,nonatomic)  BOOL isIphone5;
@property (assign,nonatomic)  BOOL currentSendDeviceTokenStatus;
@property (strong, nonatomic) UIImage *userOwnImage;
@property (strong, nonatomic) ShowVideoViewController *trainningVideoVC;
@property (strong, nonatomic) UIColor *backGroundUnreadGray;
@property (strong, nonatomic) NSData *faceBookImageData;

@property (assign, nonatomic) BOOL isFromAlbumForVideoPost;
@property (strong, nonatomic) NSString *faceBookVideoPath;

//// 30th March ////

//@property (nonatomic, strong) NSString *strNewAddTeamMessage;

@property BOOL isTeamCreate;
@property BOOL isTeamAccept;

///// ARPITA /////


-(void)registerForGetttingDTForPushNotificationServiceStatus:(BOOL)status;
-(BOOL)sendMultipleRequestFor:(NSMutableArray*)aRequestPages from:(id)aSource;
-(void)showNetworkError:(NSString*) errorMsg;
-(BOOL)sendRequestFor:(NSString *)aRequestPage from:(id)aSource parameter:(NSDictionary*)dic;
-(void)sendDeviceToServerDeviceToken:(NSString*)dToken UserId:(NSString*)userId CheckStatus:(BOOL)status;
-(void)createAndSetAllCenterNavController;
-(void)createEventStore;
-(void)setTeamMaintenanceViewToUp;
-(void)setMyTeamViewToUp;  ////AD july For Myteam

-(void)setSettingsViewTopup;
-(void)setHomeView;
-(void)setHomeViewToUp;
-(void)savependingMessage:(NSArray*)messageList;
@property(nonatomic,retain) NSMutableArray *allPendingMessage;

-(void)saveAllUserDataFirstName:(NSString*)FirstName LastName:(NSString*)LastName Address:(NSString*)Address Email:(NSString*)Email Password:(NSString*)Password ContactNo:(NSString*)ContactNo PrimaryEmail1:(NSString*)PrimaryEmail1 PrimaryEmail2:(NSString*)PrimaryEmail2 SecondaryEmail1:(NSString*)SecondaryEmail1 SecondaryEmail2:(NSString*)SecondaryEmail2 SecondaryEmail3:(NSString*)SecondaryEmail3 SecondaryEmail4:(NSString*)SecondaryEmail4 SecondaryEmail5:(NSString*)SecondaryEmail5 SecondaryEmail6:(NSString*)SecondaryEmail6 ProfileImage:(NSString*)ProfileImage teamNotification:(NSString*)teamNotification friendNotification:(NSString *)friendNotification eventNotification:(NSString*)eventNotification messageNotification:(NSString *)messageNotification teamNotificationEmail:(NSString*)teamNotificationEmail friendNotificationEmail:(NSString *)friendNotificationEmail eventNotificationEmail:(NSString*)eventNotificationEmail messageNotificationEmail:(NSString *)messageNotificationEmail;
-(void)removeAllUserData;//FirstName:(NSString*)FirstName LastName:(NSString*)LastName Address:(NSString*)Address Email:(NSString*)Email Password:(NSString*)Password ContactNo:(NSString*)ContactNo PrimaryEmail1:(NSString*)PrimaryEmail1 PrimaryEmail2:(NSString*)PrimaryEmail2 SecondaryEmail1:(NSString*)SecondaryEmail1 SecondaryEmail2:(NSString*)SecondaryEmail2 SecondaryEmail3:(NSString*)SecondaryEmail3 SecondaryEmail4:(NSString*)SecondaryEmail4 SecondaryEmail5:(NSString*)SecondaryEmail5 SecondaryEmail6:(NSString*)SecondaryEmail6 ProfileImage:(NSString*)ProfileImage;
-(void)addEventsAfterLogin:(NSArray*)arr :(BOOL) createdby :(NSString*)playername :(NSString*)playerid :(NSString*)playeruserid :(BOOL)isTeamMayBe :(BOOL)isTeamAdmin :(BOOL)isPlayerAndAdmin :(BOOL)isAdminAndPlayer;
-(UIColor*)colorWithHexString:(NSString*)hex;
-(void)savePushDataForLike:(NSDictionary*)userInfo :(NSString*)alertStr;
-(void)savePushDataForComment:(NSDictionary*)userInfo :(NSString*)alertStr;

-(NSManagedObject*)isExistObjectOfTypeEventUnread:(NSString*)eId;
-(void)addFromPush:(NSDictionary*)dic;

-(void)removeAllDataOfLoggedInUser;
-(void)deleteAllInvites;
-(void)deleteAllEvents;
//////////Facebook
//- (void)sessionStateChanged:(FBSession *)session :(FBSessionState)state error:(NSError *)error;  //// facebook sdk change 8th july
- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;

-(void)facebookpostmessage:(NSString *)str;
- (void)showAlert:(NSString *)message
           result:(id)result
            error:(NSError *)error ;
- (void) closeSession;
//////////
-(void)updateAllEvents:(NSString*)teamId :(BOOL)isConvertToPlayer;

-(void)comingFriendInvitesListUpdated:(id)sender;

-(void)parseFriendInvites:(NSString*)data;


@property BOOL alreadyRegisteredMember;


@end
