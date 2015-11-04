//
//  SaveTeamViewController.h
//  Social
//
//  Created by Mindpace on 28/08/13.
//
//

#import "BaseVC.h"
#import "AppDelegate.h"

@class TeamDetailsViewController;
@class Contacts;
@interface SaveTeamViewController : BaseVC<UIScrollViewDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
   
}

@property (assign) int isCheckMsg;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentContr;
@property(nonatomic,assign) int isShowStatus;
@property (strong, nonatomic) IBOutlet UIView *teamTrackerView;
@property (retain, nonatomic) IBOutlet UIButton *inviteBtn;
@property(nonatomic,assign) int isInvite;

@property(nonatomic,assign) BOOL isTeamView;
@property(nonatomic,retain) UIImage *acceptdeImage;
@property(nonatomic,retain) UIImage *inviteDeselectedImage;
@property(nonatomic,retain) UIImage *inviteSelectedImage;
@property(nonatomic,retain) UIImage *noResponeImage;
@property(nonatomic,retain) UIImage *declinedImage;
@property(nonatomic,retain) NSString *selectedPlayerId;

@property (retain, nonatomic) UIImage *questionmarkimage;
@property (retain, nonatomic) UIImage *rightmarkimage;
@property (retain, nonatomic) UIImage *crossmarkimage;
@property (strong, nonatomic) UIImage *maybeQuestionmarkImage;

@property (strong, nonatomic) IBOutlet UIView *noPlayerView;

@property(nonatomic,retain)NSString *coachId;

@property(nonatomic,retain)NSMutableDictionary *cludLeageInfo;
@property(nonatomic,retain)NSString *cludId;
@property(nonatomic,retain)NSString *leagugeId;
@property (retain, nonatomic) IBOutlet UILabel *leagueLbl;
@property (retain, nonatomic) IBOutlet UILabel *clubLbl;
@property(nonatomic,retain)NSMutableArray *selectedInvitePlayer;

@property(nonatomic,assign)int moreFiledAddCount;
@property(nonatomic,assign) int selectedTeamIndex;


@property (retain, nonatomic) IBOutlet UIScrollView *teamScroll;
@property (retain, nonatomic) IBOutlet UIView *playerView;



@property (retain, nonatomic) IBOutlet UILabel *teamNameLabel;
@property (nonatomic,retain) IBOutlet UITableView *tblView;
@property (strong, nonatomic) IBOutlet UIView *viewMessage;
@property (strong, nonatomic) IBOutlet UIView *viewInviteMessage;


@property(nonatomic,retain) Contacts *selectedContact;
@property (retain,nonatomic) TeamDetailsViewController *teamDetailsVC;
@property (nonatomic,assign) BOOL isSelectedImage;
@property (assign,nonatomic) BOOL editMode;
@property (assign,nonatomic) BOOL btnTapped;
@property (assign,nonatomic) int itemno;

@property (strong, nonatomic) IBOutlet UIButton *sendBtn;
@property(nonatomic,assign)int selectedPlayer;


@property (retain, nonatomic) IBOutlet UIButton *inviteAction;
@property (assign,nonatomic) BOOL isLoadImage;
@property (assign,nonatomic) UIImage *originalImage;
@property (retain,nonatomic) UIImage *noimage;
@property (strong, nonatomic) IBOutlet UIView *separetorView;
@property (strong, nonatomic) IBOutlet UIButton *addPlayerBtn;
@property (strong, nonatomic) IBOutlet UIButton *invitePlayerBtn;

@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) IBOutlet UIView *buttonView;

@property (strong, nonatomic) IBOutlet UIView *noplaerVw;

@property (strong, nonatomic) IBOutlet UIImageView *imageViewAddTeamMsg;

-(void)populateField:(Contacts*)contact;


- (IBAction)saveTeam:(id)sender;
- (IBAction)back:(id)sender;
-(IBAction)addPlayer:(id)sender;

- (IBAction)invitePlayer:(id)sender;

- (IBAction)cacelInviteAction:(id)sender;

- (IBAction)playerDetailsTaped:(id)sender;

- (IBAction)inviteBTapped:(id)sender;
- (IBAction)TeamDetails:(id)sender;
-(void)realoadPlayerTable:(id)sender;
- (IBAction)showPlayerStatus:(id)sender;

- (IBAction)segmentValueChange:(id)sender;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath andTableView:(UITableView*)tableview;

@property (strong, nonatomic) IBOutlet UILabel *hardPressLab;

@property (strong, nonatomic) IBOutlet UIView *leftHardView;

//////  04/03/2015  Combine Invite//////

@property(nonatomic,retain) UIImage *normalImage;
@property(nonatomic,retain) UIImage *noResponeTickImage;
@property(nonatomic,retain) UIImage *mayBeImage;

@property(nonatomic,strong) NSString *inviteMessage;
@property(nonatomic,strong) NSString *selectedIdList;
//@property(nonatomic,assign)int selectEdTeamIndex;
@property (strong, nonatomic) IBOutlet UIView *viewTopSelectall;


@property (strong, nonatomic) IBOutlet UIButton *selectedBtn;
@property (strong, nonatomic) IBOutlet UIButton *btnInvitePlayer;
@property (strong, nonatomic) IBOutlet UIView *popupalertvw;
@property (strong, nonatomic) IBOutlet UIView *popupalertvwBack;
@property (strong, nonatomic) IBOutlet UIView *popupinvitealertvw;
@property (strong, nonatomic) IBOutlet UILabel *custmLbl;

- (IBAction)selectedAllplayer:(id)sender;

- (IBAction)inviteSubmit:(id)sender;
- (IBAction)popuptapped:(id)sender;

@property (assign) BOOL admin;

//@property (assign) BOOL isAdminInvite;

//////////// AD //////////////


@property (strong, nonatomic) IBOutlet ADBannerView *adBanner;


@end
