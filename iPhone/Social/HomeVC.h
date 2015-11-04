//
//  HomeVC.h
//  Social
//
//  Created by Mindpace on 12/08/13.
//
//

#import "PullToRefreshView.h"

@class HomeVCTableCell,CreatePostViewController;
@interface HomeVC : BaseVC<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UITextFieldDelegate,PullToRefreshViewDelegate,UIScrollViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
{
    CGRect kb;
    CGRect af;
    CGSize svos;
    CGPoint point;

    UITapGestureRecognizer *tapgesture2;
    UIPinchGestureRecognizer *pinchgesture;

}


@property (strong, nonatomic) IBOutlet ADBannerView *adBanner;

@property (strong, nonatomic) IBOutlet UIView *hiddenvw;
@property (strong, nonatomic) IBOutlet UIImageView *hiddenimgvw;
@property (strong, nonatomic) IBOutlet UIScrollView *scrlvw;

- (IBAction)closeaction:(id)sender;
-(void)getFromMyTeams:(int)page;   /// AD 19th MyTeams

@property(nonatomic,strong) HomeVCTableCell *currDelCell;
@property(nonatomic,strong) PullToRefreshView *pull;
@property(nonatomic,strong) UIToolbar *keyboardToolbar;
@property(nonatomic,strong) UIView *keyboardToolbarView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;
@property(nonatomic,strong) NSMutableArray *dataArrayUpButtons;
@property(nonatomic,strong) NSMutableArray *dataArrayUpButtonsIds;
@property(nonatomic,strong) NSMutableArray *dataArrayUpInvites;
@property(nonatomic,strong) NSMutableArray *dataArrayUpTeamSports;

@property(nonatomic,strong) NSMutableArray *dataArrayUpIsCreated;
@property(nonatomic,strong) NSMutableArray *dataArrayUpTexts;
@property(nonatomic,strong) NSMutableArray *dataArrayUpImages;
@property(nonatomic,strong) NSMutableArray *dataArrayUpCoachDetails;

@property (strong, nonatomic) NSMutableDictionary *allpostdataDic;
@property (strong, nonatomic) IBOutlet UIScrollView *menuupscrollview;

@property (strong, nonatomic) NSArray *animationtowhitesets;
@property (strong, nonatomic) NSArray *animationtogreensets;
@property (strong, nonatomic) IBOutlet UIScrollView *updatesScrollView;
@property (strong, nonatomic) IBOutlet UILabel *updateslab;
@property (strong, nonatomic) NSString *updateslabtext;
@property (strong, nonatomic) UIImage *likedImage;
@property (strong, nonatomic) UIImage *nonLikedImage;
@property (strong, nonatomic) CreatePostViewController *postVC;
@property(nonatomic,strong) NSMutableArray *dataArray;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
-(void)changeCellLikeUnlikeValue:(int)n :(HomeVCTableCell*)cell;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@property (strong, nonatomic) IBOutlet UIView *newloginpopupviewbackground;

- (void)reloadTableData;
//////////////
-(void)resetPostView;
-(void)likeComment:(UIButton *)sender;
-(void)processlikeOrUnlike:(BOOL)like :(HomeVCTableCell*)cell;
-(void)setPostAvatarsImage:(UIImage*)image1 :(UIImage*)image2;

@property (strong, nonatomic) CreatePostViewController *createPostVC;
@property (assign, nonatomic) BOOL isFromPullToRefresh;
@property (assign, nonatomic) BOOL isSelectedImage;
@property (assign, nonatomic) BOOL isSelectedVideo;
@property (strong, nonatomic) NSData *dataVideo;
-(void)moveTableView:(int)mode;
-(void)showPostView:(int)mode;
@property (assign, nonatomic) long long int start;
@property (assign, nonatomic) long long int limit;
@property (assign, nonatomic) BOOL isFinishData;
@property (assign, nonatomic) BOOL isProcessingLikeOrUnlike;
@property (strong,nonatomic) NSString *currbodytext;
@property (strong, nonatomic) IBOutlet UIView *postmainview;
@property (strong, nonatomic) IBOutlet UITextView *commentTextVw;
@property (strong, nonatomic) IBOutlet UIButton *cambt;
@property (strong, nonatomic) IBOutlet UIButton *videobt;
@property (strong, nonatomic) IBOutlet UIImageView *previewimavw;
@property (strong, nonatomic) IBOutlet UIView *divider2;
@property (strong, nonatomic) IBOutlet UIView *divider1;

@property (strong, nonatomic) IBOutlet UIButton *crosspreviewbt;
@property (strong, nonatomic) IBOutlet UIButton *denecmntb;
@property (strong, nonatomic) IBOutlet UIButton *cancelcmntb;

@property (strong, nonatomic) IBOutlet UIButton *btnTeamCreate;

@property (weak, nonatomic) IBOutlet UIView *postBackground;

-(void)requestForTableViewFooterLoading:(NSNumber*)index;
- (IBAction)postbTapped:(id)sender;
- (IBAction)upUserPostBTapped:(id)sender;
-(void)hideKeyTool;
-(void)moveScrollView:(UIView *)theView;
@property (assign, nonatomic) int lastSelectedTeam;
-(void)loadFourSquareDataTeamPostDetails:(NSString*)responses;
@property (strong, nonatomic) IBOutlet UIView *postedmaintopview;
-(void)requestFirst:(int)index;
@property (strong, nonatomic) IBOutlet UIImageView *myavatar;
@property (strong, nonatomic) IBOutlet UIImageView *secondaryavatar;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activindicatorpost;
@property (strong, nonatomic) IBOutlet UIButton *postnormtextbt;
@property (strong, nonatomic) UIButton *buttonfirstinscroll;
//////////////
@property (strong, nonatomic) IBOutlet UIView *postbuttonscontainervw;
-(void)showActiveIndicatorOwnPost;
-(void)hideActiveIndicatorOwnPost;
-(void)addTeamListing:(NSMutableArray*)arr :(NSMutableArray*)arr1 :(NSMutableArray*)arr2 :(NSMutableArray*)arr3 :(NSMutableArray*)arr4 :(NSMutableArray*)arr5 :(NSMutableArray*)arr6 :(NSMutableArray*)arr7;
-(void)upBtapped:(id)sender;
-(UIImage*)getThumnailForVideo:(NSURL*)url;
-(void)sendRequestForTeamWall;
-(void)enablepost;
-(void)disablepost;
@property (assign, nonatomic) BOOL loadStatus;
-(void)sendRequestForPost:(NSDictionary*)dic;
-(void)finishedVideoConvert;
-(void)parseAndSaveTeam:(NSArray*)admindetails :(NSArray*)playerdetails :(NSArray*)teamdetails :(NSArray*)frnddetails :(NSArray*)primarydetails;
-(void)showParticularTeam:(int)index;
-(void)updateArrayByAddingOneTeam:(NSString*)str :(NSString*)str1 :(NSString*)str2 :(NSNumber*)str3 :(NSString*)str4 :(NSString*)str5 :(NSMutableArray*)arr :(NSDictionary*)detDic :(NSString*)str6;
-(void)setDataFromDelegateArray:(int)index :(NSMutableArray*) arr;
-(void)reloadDataFromDelegateArray:(NSMutableArray*) arr;


@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityindicatormiddle;

-(void)showMiddleActivityInd;
-(void)hideMiddleActivityInd;
@property (strong, nonatomic) IBOutlet UILabel *smsnumbertextl;


@property (strong, nonatomic) IBOutlet UIView *teamlistdivider;


@property (strong, nonatomic) IBOutlet UIView *teamtopview;

@property (strong, nonatomic) IBOutlet UIImageView *teamlogoimaview;
@property (strong, nonatomic) IBOutlet UITextView *updatetextvw;
@property (strong, nonatomic) IBOutlet UITextView *currenttextvw;
@property (strong, nonatomic) IBOutlet UITextField *currenttextField;
- (IBAction)editupdateTapped:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *updateplusbt;
-(NSString*)textForUpdateField:(NSString*)str;


@property (strong, nonatomic) IBOutlet UIView *newloginpopupview;
@property (strong, nonatomic) IBOutlet UIButton *popupTapped;


@property (strong, nonatomic) IBOutlet UIButton *popupTapped1;


- (IBAction)newloginviewTapped:(id)sender;
-(void)takeAction:(BOOL)like :(HomeVCTableCell*)cell;
-(void)updateArrayByDeletingOneTeam:(NSString*)str;
@property (strong, nonatomic) IBOutlet UIView *teamstatusupdatemainview;



@property (strong, nonatomic) IBOutlet UIView *tableviewupvw;



@property (strong, nonatomic) IBOutlet UIView *tableupview1;

@property (strong, nonatomic) IBOutlet UIView *updatetablehideview;
@property (strong, nonatomic) IBOutlet UIView *updateuphideview;

- (IBAction)postupperviewbtaction:(id)sender;
-(void)reqForDelete:(NSDictionary*)dic :(int)row;



- (IBAction)updateAction:(id)sender;
-(void)reqForReportAbuse:(NSDictionary*)dic ;


@property (weak, nonatomic) IBOutlet UIView *updatebackgr;

@property (weak, nonatomic) IBOutlet UIImageView *redbackindicator;
@property (weak, nonatomic) IBOutlet UIImageView *rednextindicator;

@property (weak, nonatomic) IBOutlet UILabel *postlabel;


@property (weak, nonatomic) IBOutlet UIImageView *redbackindicator1;

@property (weak, nonatomic) IBOutlet UIImageView *rednextindicator1;





@property (strong, nonatomic) IBOutlet UIView *wallfootervw;


@property (strong, nonatomic) IBOutlet UIImageView *wallfootervwgreydot;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *wallfootervwactivind;
-(NSMutableArray*)loadListingPostDetails:(NSString*)responses;




@property (strong, nonatomic) IBOutlet UIView *firsttimesecondvw;

- (IBAction)firsttimesecondAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *firsttimeFirstvw;
- (IBAction)firsttimeFirstAction:(id)sender;




@property (strong, nonatomic) IBOutlet UILabel *blankwalllabel;

@property (strong, nonatomic) IBOutlet UIView *wallblankconvw;


@property (strong, nonatomic) IBOutlet UILabel *blankwallactlab;

@property (strong, nonatomic) IBOutlet UIView *horidividervw;



@property (strong, nonatomic) IBOutlet UIView *topContainerView;


@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;



@property (assign, nonatomic) int kNumberOfPages;
@property (assign, nonatomic) BOOL pageControlUsed;
@property (nonatomic, retain) NSMutableArray *arrayControllers;
- (IBAction)changePage:(id)sender;

- (void)loadScrollViewWithPage:(int)page;
-(void)upBtappedNew:(int)indexNo;

-(void)setTopBarText;


-(void)moveTableViewBasisOnPostPermission:(int)mode;
@property (strong, nonatomic) IBOutlet UIView *postNewContainerView;


-(void)leftSwipeDone;
-(void)rightSwipeDone;
- (void)addPanGestureToView:(UIView *)view;



@property (strong, nonatomic) IBOutlet UIView *popupalertvwback;


@property (strong, nonatomic) IBOutlet UIView *popupalertvw;
- (IBAction)popuptapped:(id)sender;
-(void)showAlertViewCustom:(NSString*)labText;


@property (strong, nonatomic) IBOutlet UILabel *custompopuplab;

// 19th.....june

-(void)fireBackgroundExecuting;
-(void)finishBackgroundExecuting;

- (IBAction)saveBtnAction:(id)sender;



@end
