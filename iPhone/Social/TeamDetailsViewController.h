//
//  TeamDetailsViewController.h
//  Social
//
//  Created by Mindpace on 21/08/13.
//
//

#import "BaseVC.h"
#import "AppDelegate.h"
#import "SaveTeamViewController.h"
#import "TeamMaintenanceVC.h"

typedef void (^AddNewTeamIndex)( int selectedTeamIndex);


@interface TeamDetailsViewController : BaseVC<UIScrollViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    CGRect kb;
    CGRect af;
    CGSize svos;
    CGPoint point;
    
}

@property BOOL isTapp;
@property BOOL isAddTeam;
@property BOOL isMyTeam;  //// AD july MyTeam

@property(nonatomic,copy) AddNewTeamIndex newTeamIndex;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentCtrl;

@property (strong, nonatomic) IBOutlet UILabel *playerLbl;
@property (strong, nonatomic) IBOutlet UILabel *teaamLbl;
@property(nonatomic,retain) UIButton *selectedTeamButton;
@property (retain, nonatomic) IBOutlet UIImageView *backImageView;
@property (retain, nonatomic) IBOutlet UIButton *backBtn;

@property (retain, nonatomic) IBOutlet UIView *addMinView;
@property(nonatomic,assign)BOOL isAddminOne;
@property (retain, nonatomic) IBOutlet UITextField *clubNameTxt;
@property (retain, nonatomic) IBOutlet UITextField *leagueNameTxt;

/// 17/02/2015 ////

@property (strong, nonatomic) IBOutlet UIView *viewTransparentMsg;
@property (strong, nonatomic) IBOutlet UIView *viewMessage;
@property (strong, nonatomic) IBOutlet UILabel *lblAlertMessage;
- (IBAction)alertMessageDone:(id)sender;


@property (strong, nonatomic) IBOutlet UIView *viewDeleteMessage;
@property (strong, nonatomic) IBOutlet UILabel *lblDeleteAlertMsg;

- (IBAction)deleteAlertMessageDone:(id)sender;


///// AD 19th june

@property (strong, nonatomic) IBOutlet UIButton *btnOkay;
@property (strong, nonatomic) IBOutlet UIButton *btnOk;
@property (strong, nonatomic) IBOutlet UIButton *btnCancl;

//////////

@property (assign,nonatomic) BOOL isLoadImage;
@property (assign,nonatomic) UIImage *originalImage;
@property (retain,nonatomic) UIImage *noimage;
@property(nonatomic,retain)NSMutableArray *addMin1Info;
@property(nonatomic,retain)NSMutableArray *addMin2Info;
@property(nonatomic,retain)TeamMaintenanceVC *teamVc;
@property(nonatomic,retain)NSMutableDictionary *cludLeageInfo;
@property(nonatomic,strong)NSMutableArray *myAllFriend;
@property (strong, nonatomic) IBOutlet UIButton *deletebtn;

@property(nonatomic,assign) int selectedTeamIndex;

@property (retain, nonatomic) IBOutlet UITextField *email2Txt;
@property(nonatomic,retain)NSString *cludId;
@property(nonatomic,retain)NSString *leagueId;

@property (retain, nonatomic) NSString *firstTimeDefaultCurrentAddress;
@property (retain, nonatomic) NSString *lastSelectedAddress;
@property (retain, nonatomic) CLLocation *selectedLocation;
@property (retain, nonatomic) CLGeocoder *geocoder;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *fieldnameindicator;

@property(nonatomic,retain) NSArray *arrPickerItems4;
@property(nonatomic,assign)int selectedFiledIndex;

@property(nonatomic,assign) int selRow1;
@property(nonatomic,assign) int selRow2;
@property(nonatomic,assign) int selRow3;
@property(nonatomic,assign) int selRow4;
@property(nonatomic,assign) int selRow5;
@property(nonatomic,assign) int selRow6;
@property(nonatomic,assign) int selRow7;
@property(nonatomic,assign) int selRow8;
@property (strong, nonatomic) IBOutlet UILabel *ownerLbl;

@property(nonatomic,assign) int pickerSelectTag;
@property(nonatomic,retain) IBOutlet UIPickerView *picker;
@property(nonatomic,retain) IBOutlet UIView *pickerContainer;
@property (retain, nonatomic) IBOutlet UIScrollView *teamScroll;
@property (retain, nonatomic) IBOutlet UIView *teamEditView;
@property (retain, nonatomic) IBOutlet UIButton *teamDetailsBtn;
@property (retain, nonatomic) IBOutlet UITextField *teamColorText2;
@property (retain, nonatomic) IBOutlet UIButton *playerDetailsBtn;
@property (retain, nonatomic) IBOutlet UIView *teamFirstView;
@property (retain, nonatomic) IBOutlet UIView *teamSecondView;
@property (retain, nonatomic) IBOutlet UIView *teamThirdView;
@property (retain, nonatomic) IBOutlet UITextField *teamNameTxt;
@property (retain, nonatomic) IBOutlet UITextField *sportTxt;
@property (retain, nonatomic) IBOutlet UITextField *clubTxt;
@property (retain, nonatomic) IBOutlet UITextField *leagueTxt;
@property (retain, nonatomic) IBOutlet UITextField *zipCodeTxt;
@property (retain, nonatomic) IBOutlet UITextField *ageGrpTxt;
@property (retain, nonatomic) IBOutlet UITextField *genderTxt;
@property (retain, nonatomic) IBOutlet UITextField *uniformColorTxt;
@property (retain, nonatomic) IBOutlet UITextField *creatorNameTxt;
@property (retain, nonatomic) IBOutlet UITextField *emailTxt;
@property (retain, nonatomic) IBOutlet UITextField *phoneTxt;

@property(nonatomic,retain) UIView *keyboardToolbarView;

@property (retain, nonatomic) IBOutlet UIImageView *avatarimavw;
@property (retain, nonatomic) IBOutlet UITextField *fieldNameTxt;

@property (retain, nonatomic) IBOutlet UILabel *fdashlab;
@property (retain, nonatomic) IBOutlet UIButton *betweenfbt;
@property (retain, nonatomic) IBOutlet UILabel *andlab;
@property (retain, nonatomic) IBOutlet UILabel *sdashlab;

@property (retain, nonatomic) IBOutlet UIButton *sportbt;

@property (retain,nonatomic) SaveTeamViewController *saveTeamVC;

@property (retain,nonatomic) NSArray *pickerArr;
@property (retain,nonatomic) NSArray *pickerArr2;
@property (retain,nonatomic) NSArray *pickerArr3;
@property (retain,nonatomic) NSArray *pickerArr4;
@property (retain,nonatomic) NSArray *pickerArr5;
@property (retain,nonatomic) NSArray *pickerArr6;
@property (retain,nonatomic) NSArray *pickerArr7;
@property (strong, nonatomic) IBOutlet UIButton *addBtn;
@property (strong, nonatomic) IBOutlet UIButton *editBtn;

@property (retain,nonatomic) NSMutableDictionary *teamForm;
@property (assign,nonatomic) BOOL btnTapped;
@property (nonatomic,assign) BOOL isSelectedImage;
@property(nonatomic,assign) int addTeamId;
@property (retain, nonatomic) IBOutlet UILabel *titleLbl;
@property (strong, nonatomic) IBOutlet UIView *toggleView;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *dropDownArroImage;
@property (strong, nonatomic) IBOutlet UIView *deleteView;

@property (strong, nonatomic) IBOutlet UIImageView *imageVwEnterName;

@property (assign) int isFieldTap; // 25/7/14


- (IBAction)deleteteam:(id)sender;

- (IBAction)uploadPhoto:(id)sender;
-(IBAction)ShowPicker:(int)tag;
-(IBAction)HidePicker:(UIBarButtonItem*)sender;
-(IBAction)DonePicker:(UIBarButtonItem*)sender;
- (IBAction)doneBtn:(id)sender;
- (IBAction)cancelBtn:(id)sender;
- (void)geocodeAddress;

-(void)moveScrollView:(UIView *)theView;


- (IBAction)addNewTeam:(id)sender;

- (IBAction)teamDetailsTaped:(id)sender;

- (IBAction)segmentValueChange:(id)sender;


-(void)resignAllTextFields;
-(void)goToTimeLine:(NSString*)msg;

@property (assign, nonatomic) BOOL isLoadingLocations;
@property (strong, nonatomic) IBOutlet ADBannerView *adBanner;
@end
