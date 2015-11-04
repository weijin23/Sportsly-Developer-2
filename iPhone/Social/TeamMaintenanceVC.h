//
//  TeamMaintenanceVC.h
//  Social
//
//  Created by Animesh@Mindpace on 09/09/13.
//
//

#import <UIKit/UIKit.h>
#import "AddAFriend.h"

@class SelectContact; ///////   AD 16th June

@interface TeamMaintenanceVC : BaseVC <UIAlertViewDelegate,UINavigationControllerDelegate>


@property(nonatomic,assign) int selectedTeamTag;
@property(nonatomic,retain) UIButton *selectedBut;
@property(nonatomic,retain)UINavigationController *teamNavController;
@property (nonatomic,assign) int lastSelectedRow;
@property (strong, nonatomic) UIButton *buttonfirstinscroll;
@property(strong,nonatomic) UIButton *selectedButton;
@property(nonatomic,strong) UIImage *crossImage1;
@property(nonatomic,assign) BOOL isShowFristTime;

//////////////ADDDEB
@property(nonatomic,assign) BOOL isShowFromNotification;
@property(nonatomic,strong) NSString *teamIdForShowingNotification;
//////////////


//////////////ADDARPI

///////   AD 16th June
@property(nonatomic,strong) SelectContact *selContactNew;
@property(nonatomic,strong) AddAFriend *addAFriendVC;
/////

@property (assign) int whichSegmentTap;
@property (assign) int countAdmin;
-(void)setSegmentIndex:(int)segIndx adminCount:(int)adminCount isAdmin:(BOOL)isadmin;
//-(void)setSegmentIndex:(int)segIndx;

//////////////

@property (strong, nonatomic) IBOutlet UIView *scrollBackView;
@property (assign, nonatomic) int lastSelectedTeam;
@property(nonatomic,strong)NSMutableArray *myAllFriend;
@property (strong, nonatomic) IBOutlet UIView *noTeamVw;
@property (strong, nonatomic) IBOutlet UIView *horidividervw;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

@property (assign, nonatomic) int kNumberOfPages;
@property (assign, nonatomic) BOOL pageControlUsed;
@property (nonatomic, retain) NSMutableArray *arrayControllers;

@property (nonatomic, strong) NSMutableDictionary *memberDetailDict;



- (void)loadScrollViewWithPage:(int)page;
-(void)upBtappedNew:(int)indexNo;
-(void)showRightButton:(BOOL)isShow;

-(void)setTopBarText;
-(void)leftSwipeDone;
-(void)rightSwipeDone;
- (void)addPanGestureToView:(UIView *)view;
-(void)loadTeamData;

- (void)showAllSporstlyUsers; /// User list 14th july

-(IBAction)AddTeam:(UIButton*)sender;

//-(void)upBtapped:(id)sender;

-(void)createTeamScroll;

- (IBAction)changePage:(id)sender;
-(void)checkNoteam;

-(void)getFromMyTeams:(int)page;  // AD 19th MyTeams
-(void)toggleRightPanel:(id)sender;  /// AD 9th july

-(void)selectProperClassForSegmentTap:(NSMutableDictionary *)dictMember; // AD 6th july

-(void)addSpectator:(UIButton *)sender;

@end
