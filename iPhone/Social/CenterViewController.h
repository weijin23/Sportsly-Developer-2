//
//  WALLVC.h
//  Social
//
//  Created by Mindpace on 07/09/13.
//
//
#import "PopOverViewController.h"
#import "BaseVC.h"
#import "PushByEventsVC.h"
#import "PushByInvitesVC.h"
#import "PushByInviteFriendVC.h"
#import "PushByCoachUpdateVC.h"
#import "MainInviteVC.h"
#import "ChatMessageViewController.h"
#import <iAd/iAd.h>

@interface CenterViewController : BaseVC  <PushListingViewControllerDelegate,PushListingInviteViewControllerDelegate,PushByInviteFriendVCDelegate,PushByCoachUpdateDelegate,MainInviteVCDelegate,ChatMessageDelegate,UINavigationControllerDelegate,ADBannerViewDelegate>


-(IBAction)topbarbtapped:(id)sender;
- (IBAction)slidebTapped:(id)sender;
-(void)showNavController:(UINavigationController*)navigationController;

@property (assign, nonatomic) BOOL isShowMainCalendarFirstScreeen;
@property (strong, nonatomic) PushByEventsVC *pusheventcontroller;
@property (strong, nonatomic) PushByInvitesVC    *pushinvitecontroller;
@property (strong, nonatomic) PushByInviteFriendVC *pushinvitefriendcontroller;
@property (strong, nonatomic) IBOutlet UIButton *pendingMessage;

@property (strong, nonatomic) IBOutlet UIButton *calenderlabelbt;
@property (strong, nonatomic) IBOutlet UIButton *calenderbt;
- (IBAction)calendarbTapped:(id)sender;


@property (strong, nonatomic) IBOutlet UIButton *postlabelbt;
@property (strong, nonatomic) IBOutlet UIButton *postbt;
- (IBAction)postbtapped:(id)sender;



@property (strong, nonatomic) IBOutlet UIView *uptopbarvw;


@property (strong, nonatomic) IBOutlet UIView *coachupdatevw;
@property (strong, nonatomic) IBOutlet UIButton *invitefriendlabelbt;
@property (strong, nonatomic) IBOutlet UIButton *coachupdatelabelbt;

@property (strong, nonatomic) IBOutlet UIView *mainredtopbar;


@property (strong, nonatomic) IBOutlet UILabel *fsttablab;
@property (strong, nonatomic) IBOutlet UILabel *sectablab;

@property (strong, nonatomic) IBOutlet UILabel *msgtablab;
@property (strong, nonatomic) IBOutlet UILabel *teamtablab;

@property (strong, nonatomic) IBOutlet UILabel *invtablab;

@property (strong, nonatomic) IBOutlet UILabel *notificlab;

@property (strong, nonatomic) IBOutlet UIImageView *timelineimavw;

@property (strong, nonatomic) IBOutlet UIImageView *eventsimavw;

@property (strong, nonatomic) IBOutlet UIImageView *msgimavw;
@property (strong, nonatomic) IBOutlet UIImageView *teamimavw;

@property (strong, nonatomic) IBOutlet UIImageView *invitesimavw;

@property (strong, nonatomic) IBOutlet UIImageView *notificationimavw;



@property (strong, nonatomic)  UIImage *timelineima;

@property (strong, nonatomic)  UIImage *eventsima;

@property (strong, nonatomic)  UIImage *msgima;

@property (strong, nonatomic)  UIImage *teamima;

@property (strong, nonatomic)  UIImage *invitesima;

@property (strong, nonatomic)  UIImage *notificationima;

@property (strong, nonatomic)  UIImage *timelineimasel;

@property (strong, nonatomic)  UIImage *eventsimasel;

@property (strong, nonatomic)  UIImage *msgimasel;

@property (strong, nonatomic)  UIImage *teamimasel;

@property (strong, nonatomic)  UIImage *invitesimasel;

@property (strong, nonatomic)  UIImage *notificationimasel;
-(BOOL)getShowStatus:(UINavigationController*)navigationController;
-(void)presentViewControllerForModal:(UIViewController*)vc;


@property (strong, nonatomic) IBOutlet UIView *tabBarContainervw;
-(void)setTabBar:(BOOL)isReset :(int)setIndex;
-(void)setBarBlue;

@property (strong, nonatomic) IBOutlet UIButton *timelinesbt;

@property (strong, nonatomic) IBOutlet UIView *coverView;    ////////  17/3/2015

@property (strong, nonatomic) IBOutlet ADBannerView *adBanner;

@end
