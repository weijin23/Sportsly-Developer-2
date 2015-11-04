//
//  EventCalendarViewController.h
//  Social
//
//  Created by Sukhamoy Hazra on 23/08/13.
//
//
#import "PopOverViewController.h"
#import <UIKit/UIKit.h>
#import "CalendarViewController.h"
#import "FilteredPlayerClass.h"
#import "EventFilterPopOverViewController.h"
//@class CalendarViewController;
@class ToDoByEventsVC;
@class EventUnread;

@interface EventCalendarViewController : BaseVC <PopOverViewControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIActionSheetDelegate,FilteredPlayerClassProtocol,EventFilterPopOverViewControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,assign) int  selectedTeamIndex;
@property (strong, nonatomic) IBOutlet UIImageView *allTeamsImg;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (assign,nonatomic ) BOOL isMonth;
@property (strong, nonatomic) CalendarViewController *calvc;
@property (strong, nonatomic) ToDoByEventsVC *callistvc;
@property(nonatomic,strong) NSMutableArray *arrPickerItems5;
@property(nonatomic,strong) NSArray *arrPickerItems6;
@property(nonatomic,strong) NSArray *arrPickerItems7;
@property(nonatomic,strong) NSArray *arrPickerItems8;
@property (strong, nonatomic) Invite *evUnreadeventUpdate;

@property (nonatomic, retain) UILabel *lblUserEmail;

- (IBAction)bTapped:(id)sender;

- (IBAction)segTapped:(id)sender;



@property (strong,nonatomic) NSDate *selectedDate;
@property (strong,nonatomic) NSDate *currentSelectedDate;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentbottom;
-(void)getTaemListing;

-(void)processEditEvent:(NSString*)eventId :(BOOL)isExist;
-(void)sendRequestForPost:(NSDictionary*)dic :(BOOL)isExist;
-(Event*)saveEditEvent:(NSDictionary*)dic :(NSString*)eventId;



- (IBAction)actionMonth:(id)sender;


@property (strong, nonatomic) IBOutlet UIView *firstenterview;

@property (weak, nonatomic) IBOutlet UIView *middleviewfirst;


- (IBAction)firstAction:(id)sender;

- (void)showFirstEnterView:(BOOL)mode;

@property (weak, nonatomic) IBOutlet UILabel *eventheaderlab;

@property (weak, nonatomic) IBOutlet UIView *cellvw2;
@property (weak, nonatomic) IBOutlet UIView *cellvw3;


@property (weak, nonatomic) IBOutlet UIView *cellvw1;


@property (strong, nonatomic) IBOutlet UIView *pickercontainer;

@property (strong, nonatomic) IBOutlet UIView *top;
@property (strong, nonatomic) IBOutlet UIDatePicker *dpicker;

@property (strong, nonatomic) UIFont *helveticaLargeFont;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) UIActionSheet *dateActionSheet;

- (IBAction)picerAction:(id)sender;

-(void)showDate;
-(void)showTeam;
-(void)showPlayer;
-(void)showByStatus;

////////ADDDEBNEW
-(BOOL)checkEventExist;
////////

@property(nonatomic,assign) int buttonMode;
@property(nonatomic,assign) int selectedRow;
@property(nonatomic,assign) int selectedRow1;
@property(nonatomic,assign) int selectedRow2;
@property(nonatomic,assign) int currentrow;

@property(nonatomic,assign) BOOL isFromTeamAdmin;

@property (strong, nonatomic) IBOutlet UIImageView *backimgvw;

@property (strong, nonatomic) IBOutlet UIButton *backimgvwbt;

- (IBAction)backAction:(id)sender;
-(void)processAcceptEvent:(Invite*)eventToDelete;

-(void)setOwnViewDependOnFlag:(BOOL)isOne;
-(void)saveFailedEvent:(NSString*)eventId;

@property (strong, nonatomic) EventFilterPopOverViewController *evpopVC;

@property (strong, nonatomic) IBOutlet UIView *topSelectionViewForAdmin;

@property (strong, nonatomic) IBOutlet UILabel *createeventlab;

@property (strong, nonatomic) IBOutlet UILabel *trackeventlab;

@property (strong, nonatomic) IBOutlet UILabel *trackteamlab;
- (IBAction)topSelectionAdminAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *todaybt;


- (IBAction)dropDownBtAction:(id)sender;


@property (strong, nonatomic) IBOutlet UIImageView *downarrowfilterimavw;
@property (strong, nonatomic) IBOutlet UIButton *downarrowfilterbt;


@property (strong, nonatomic) IBOutlet UIImageView *downarrowimavw;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControlCalSel;

@property (strong, nonatomic) IBOutlet UIView *custompopupbottomvw;
@property (strong, nonatomic) IBOutlet UIView *custompopuptopselectionvw;

@property (strong, nonatomic) IBOutlet UIView *viewAddEvent;

@property (strong, nonatomic) IBOutlet UIButton *btnAddEvent;

- (IBAction)custompopupbTapped:(id)sender;


- (IBAction)hideCustomPopupTapped:(id)sender;

@property(nonatomic,assign) BOOL isAscendingDate;

@property(nonatomic,assign) BOOL isExistOwnTeam;


- (IBAction)topSegTapped:(id)sender;


@property (strong, nonatomic) IBOutlet UISegmentedControl *topSegCntrl;
-(void)setRightBarButton;
-(void)setLeftBarButton;
@end
