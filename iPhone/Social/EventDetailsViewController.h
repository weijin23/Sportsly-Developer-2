//
//  EventDetailsViewController.h
//  Social
//
//  Created by Sukhamoy Hazra on 09/09/13.
//
//

#import "EventUnread.h"
#import "Event.h"
#import <UIKit/UIKit.h>
#import "EventPlayerStatusVC.h"
@interface EventDetailsViewController : BaseVC  <UIAlertViewDelegate>


- (IBAction)bTapped:(id)sender;


@property (assign, nonatomic) BOOL isFromPushBadge;
@property (assign, nonatomic) BOOL isTeamAccept;

@property (strong, nonatomic) NSString *eventId;
@property (assign, nonatomic) BOOL isFromPush;
@property (strong, nonatomic) Event *dataEvent;
@property (weak, nonatomic) IBOutlet UIButton *rosterbt;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIView *mainview;

@property (strong, nonatomic) Invite *evUnreadevent;
@property (strong, nonatomic) Invite *evUnreadeventUpdate;
@property (strong, nonatomic) IBOutlet UIButton *acceptb;
@property (strong, nonatomic) IBOutlet UIButton *declineb;
@property (strong, nonatomic) IBOutlet UIButton *maybebtn;
@property (strong, nonatomic) EventPlayerStatusVC *evStatusVC;


- (IBAction)actionTapped:(id)sender;

-(void)populateDataField;

@property (strong, nonatomic) NSString* playername;
@property (strong, nonatomic) NSString* playerid;
@property (strong, nonatomic) NSString* playeruserid;
@property (strong, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) IBOutlet UILabel *view1evname;
@property (strong, nonatomic) IBOutlet UILabel *view1evloc;

@property (strong, nonatomic) IBOutlet UIView *view2;
@property (strong, nonatomic) IBOutlet UILabel *view2datelab;
@property (strong, nonatomic) IBOutlet UILabel *view2timelab;
@property (strong, nonatomic) IBOutlet UILabel *view2repeatlab;
@property (strong, nonatomic) IBOutlet UILabel *view2eventtimelab;

@property (strong, nonatomic) IBOutlet UIView *view3;
@property (strong, nonatomic) IBOutlet UILabel *view3addresslab;

@property (assign, nonatomic) BOOL isShowDelete;
@property (assign, nonatomic) BOOL isGesturePositive;
@property (assign, nonatomic) BOOL isShowAccept;
@property (strong, nonatomic) IBOutlet UIView *view4;
@property (strong, nonatomic) IBOutlet UILabel *view4uniform;
@property (strong, nonatomic) IBOutlet UIView *view4uniformdivider;

@property (strong, nonatomic) IBOutlet UIView *view5;
@property (strong, nonatomic) IBOutlet UILabel *view5team;

@property (strong, nonatomic) IBOutlet UIView *view6;
@property (strong, nonatomic) IBOutlet UILabel *view6thingtobring;
@property (strong, nonatomic) IBOutlet UIView *view6divider;

@property (strong, nonatomic) IBOutlet UIView *view7;

@property (strong, nonatomic) IBOutlet UIView *view8;

@property (strong, nonatomic) IBOutlet UILabel *view8team;
- (IBAction)actionbtn:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *statusimavw;


@property (strong, nonatomic) IBOutlet UILabel *view7alertlab;
-(void)saveToMyDatabase:(NSDictionary*)dic;

-(void)saveToDeviceCalendarForDecline:(Event*)eventvar;
-(void)saveToDeviceCalendar:(Event*)eventvar;


@property (strong, nonatomic) IBOutlet UIView *view9;
@property (strong, nonatomic) IBOutlet UILabel *noteslab;



@property (strong, nonatomic) IBOutlet UIView *view8divider;
@property (strong, nonatomic) IBOutlet UILabel *notestxtview;
@property (strong, nonatomic) IBOutlet UIView *view9divider;


@property (weak, nonatomic) IBOutlet UIImageView *rosterimavw;

- (IBAction)rosterAction:(id)sender;
-(void)deleteEventFromDeviceCalendar:(Event *)dataEvent1;

@property (strong, nonatomic) IBOutlet UILabel *viewPlayerLab;


-(void)saveToDeviceCalendarForMayBe:(Event*)eventvar;


@property (strong, nonatomic) IBOutlet UIButton *inviteplayerbt;

- (IBAction)inviteAction:(id)sender;


@property (strong, nonatomic) IBOutlet UILabel *eventDetailsLab;


@property (strong, nonatomic) IBOutlet UIButton *locationBt;


@property (strong, nonatomic) IBOutlet UIImageView *locationbtimavw;


-(void)setTopTextAndRightBarButton:(NSString*)toptext :(BOOL)isShowUpdate;



@property (strong, nonatomic) IBOutlet UILabel *isHomeLabel;
@property (strong, nonatomic) IBOutlet UILabel *endtimeLabel;



@property (strong, nonatomic) IBOutlet UIView *view3lstdivider;



@property (strong, nonatomic) IBOutlet UIView *attendingvw;


@property (strong, nonatomic) IBOutlet UIView *maybevw;

@property (strong, nonatomic) IBOutlet UIView *notattendingvw;


@property (strong, nonatomic) IBOutlet UIView *inviteplayerbtvw;

@property (strong, nonatomic) IBOutlet UIButton *chStatusBt;

- (IBAction)chStatusAction:(id)sender;

- (void)inviteActionData:(NSString*)titletext;


@property (strong, nonatomic) IBOutlet UIImageView *addimageinvitebt;

@property (strong, nonatomic) IBOutlet UILabel *stlbl;

@property (strong, nonatomic) IBOutlet UIView *chStatusbtvw;

@property (strong, nonatomic) IBOutlet UILabel *lblCoachEmail;  //// 23/7/14

@property (strong, nonatomic) IBOutlet UIView *backAlertView;
@property (strong, nonatomic) IBOutlet UIView *alertView;
@property (strong, nonatomic) IBOutlet UILabel *lblMessage;

- (IBAction)doneAlert:(id)sender;

@end
