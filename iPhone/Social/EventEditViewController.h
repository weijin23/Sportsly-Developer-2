//
//  EventEditViewController.h
//  Social
//
//  Created by Sukhamoy Hazra on 06/09/13.
//
//
#import "Event.h"
#import <UIKit/UIKit.h>

@interface EventEditViewController : BaseVC<UITextFieldDelegate,UIScrollViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate,UIAlertViewDelegate>
{
    CGRect kb;
    CGRect af;
    CGSize svos;
    CGPoint point;
}

////////////////Location

@property BOOL isTapp;

@property (strong,nonatomic) NSDate *defaultDate;
@property(nonatomic,assign) int  selectedTeamIndex;

@property (strong, nonatomic) NSString *firstTimeDefaultCurrentAddress;
@property (strong, nonatomic) NSString *lastSelectedAddress;
@property (strong, nonatomic) CLLocation *selectedLocation;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (assign, nonatomic) BOOL isEditFirstTime;

@property (assign) int isFieldTap;  /// 23/7/14  ///

- (void)geocodeAddress;

-(void)sendDataToServer;
///////////////
@property (strong, nonatomic) IBOutlet UIView *secondtopview;
@property (strong, nonatomic) IBOutlet UILabel *tobbarlab;

@property (strong, nonatomic) UIAlertView *alertViewForSubmit;

@property (assign, nonatomic) BOOL isEditMode;
@property (strong, nonatomic) Event *dataEvent;

@property(nonatomic,strong) NSString *dateformatdbString;
@property(nonatomic,strong) NSArray *arrPickerItems1;
@property(nonatomic,strong) NSArray *arrPickerItems2;
@property(nonatomic,strong) NSArray *arrPickerItems3;
@property(nonatomic,strong) NSArray *arrPickerItems4;
@property(nonatomic,strong) NSArray *arrPickerItems5;
@property(nonatomic,strong) NSMutableArray *arrPickerItems6;
@property(nonatomic,strong) NSMutableArray *arrPickerItems6Dic;
@property(nonatomic,strong) NSMutableArray *pickerArr7;
@property(nonatomic,strong) NSMutableArray *arrPickerItems8;
@property(nonatomic,strong) NSMutableArray *arrPickerItems10;
@property(nonatomic,strong) NSMutableArray *teamLocation;
@property(nonatomic,strong) NSMutableArray *teamUniformColor;
@property(nonatomic,strong) NSMutableArray *teamFieldName;;



@property (assign, nonatomic) int selectedRow;
@property (assign, nonatomic) int selectedRow1;

@property (assign, nonatomic) int selectedRow2;
@property (assign, nonatomic) int selectedRow3;

@property (assign, nonatomic) int selectedRow4;
@property (assign, nonatomic) int selectedRow5;
@property (assign, nonatomic) int selRow7;
@property (assign, nonatomic) int selectedRow8;
@property (assign, nonatomic) int selectedRow10;
@property(nonatomic,strong) IBOutlet UIView *top;
@property(nonatomic,strong) IBOutlet UIView *pickercontainer;
@property(nonatomic,strong) IBOutlet UIPickerView *picker;
@property(nonatomic,strong) IBOutlet UIDatePicker *dpicker;
@property (assign, nonatomic) int buttonMode;

@property(nonatomic,strong) NSDate *eventDate;
@property(nonatomic,strong) NSDate *startDate;
@property(nonatomic,strong) NSDate *endDate;
@property(nonatomic,strong) NSDate *arrivalDate;

@property(nonatomic,strong) UIToolbar *keyboardToolbar;
@property(nonatomic,strong) UIView *keyboardToolbarView;
-(void)moveScrollView:(UIView *)theView;
-(void)hideKeyTool;
@property(nonatomic,strong) NSString *currbodytext;
@property (assign, nonatomic) BOOL mode;
@property (strong, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) IBOutlet UIView *view2;
@property (strong, nonatomic) IBOutlet UIView *view3;
@property (strong, nonatomic) IBOutlet UIView *view4;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)TeamPlayerSwitch:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *privateBtn;
@property (strong, nonatomic) IBOutlet UIButton *publicBtn;
-(void)showViewMode:(BOOL)viewMode;
-(NSDate*)getAlertDateForAlertString:(NSString*)str;

- (IBAction)toolbarBtapped:(id)sender;

-(void)getTaemListing;
- (IBAction)btapped:(id)sender;

-(void)checkEventStoreAccessForCalendar;
-(void)requestCalendarAccess;
-(void)accessGrantedForCalendar;
-(Event*)saveMessageEvent:(NSString*)eventId;
/////////////////ADDDEBNEW
@property (assign, nonatomic) BOOL isLoadingLocations;
/////////////////
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *teamnameindicator;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *fieldnameindicator;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *opponentteamindicator;

@property (strong, nonatomic) IBOutlet UILabel *showaslab;

- (IBAction)segActionTapped:(id)sender;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segpripub;


@property (strong, nonatomic) IBOutlet UIView *view5;


@property (strong, nonatomic) IBOutlet UILabel *noteslab;



@property (strong, nonatomic) IBOutlet UITextView *notestxtvw;

///// 06/03/2015  ///////

- (IBAction)invitePlayerForEvent:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *inviteViewPlayer;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@property (strong, nonatomic) IBOutlet UIButton *btnAddCancel;
@property (strong, nonatomic) IBOutlet UIButton *btnUpdate;

@property (strong, nonatomic) IBOutlet UIView *alertViewBack;
@property (strong, nonatomic) IBOutlet UIView *alertView;
@property (strong, nonatomic) IBOutlet UIView *alertViewCancel;
- (IBAction)updateAlertDone:(id)sender;


///////  AD  //////////



@property (strong, nonatomic) IBOutlet UILabel *homegamelab;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segyesno;

@property (strong, nonatomic) UIImage *yesredima;
@property (strong, nonatomic) UIImage *noredima;
@property (strong, nonatomic) UIImage *yesgreyima;
@property (strong, nonatomic) UIImage *nogreyima;

@property (strong, nonatomic) IBOutlet UIView *view6;

@property (strong, nonatomic) IBOutlet UIButton *yesbt;
@property (strong, nonatomic) IBOutlet UIButton *nobt;
- (IBAction)segBtAction:(id)sender;

-(void)setYesNoBtn:(int)tag;

-(void)setEventType;

-(void)resignAllTextFields;


@property (strong, nonatomic) IBOutlet UIView *topBarFromTeamAdmin;

- (IBAction)topBarTeamAdminAction:(id)sender;

- (IBAction)eventNamebtAction:(id)sender;
-(void)setSingleTeam;

@property (assign, nonatomic) BOOL isFindPlaygroundProcess;


@property (assign, nonatomic) BOOL loadStatusReturn;

@property (strong, nonatomic) IBOutlet UIButton *donepbt;

@property (strong, nonatomic) IBOutlet UIButton *deletebt;

- (IBAction)deleteAction:(id)sender;



-(void)hideHudViewHereDelete;
@end
