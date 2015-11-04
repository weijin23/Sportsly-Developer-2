//
//  MainInviteVC.h
//  Wall
//
//  Created by Mindpace on 14/01/14.
//
//

#import "BaseVC.h"
#import "PushByInviteTeamVC.h"
#import "LikesAndCommentsVC.h"
#import "PushByEventsVC.h"
#import "PushByCoachUpdateVC.h"



@protocol MainInviteVCDelegate <NSObject>
-(void)didChangeNumberOfMainInvites:(NSString*)number;


-(void)didSelectMainInvite:(Invite*)newInvite :(FPPopoverController*)popOverController;


@end
/*PushListingViewControllerDelegate
PushByCoachUpdateDelegate*/

@interface MainInviteVC : BaseVC <PushByInviteTeamVCDelegate,PushByLikeCommentsVCDelegate,PushListingViewControllerDelegate,
PushByCoachUpdateDelegate,UINavigationControllerDelegate,PushByCoachNotifiedForTeamInviteVCDelegate>

@property(nonatomic,strong) UINavigationController *teamInvitesVCNavController;
@property(nonatomic,strong) PushByInviteTeamVC *teamInvitesVC;
@property(nonatomic,strong) LikesAndCommentsVC *likeCommentsVC;
@property(nonatomic,strong) PushByCoachUpdateVC *coachUpdatesVC;
@property(nonatomic,strong) PushByEventsVC *eventsVC;


@property(nonatomic,strong) UINavigationController *teamInvitesVCNav;
@property(nonatomic,strong) UINavigationController *likeCommentsVCNav;
@property(nonatomic,strong) UINavigationController *coachUpdatesVCNav;
@property(nonatomic,strong) UINavigationController *eventsVCNav;


@property(nonatomic,strong) UIImage *uparrow;
@property(nonatomic,strong) UIImage *downarrow;

@property(nonatomic,weak) id <MainInviteVCDelegate> delegate;
;
@property(nonatomic,strong) FPPopoverController* popOver;
@property(nonatomic,assign) long int totalunreadnumbers;
@property(nonatomic,assign) long int totalunreadnumbersTeam;
@property(nonatomic,assign) long int totalunreadnumbersAdmin;
@property(nonatomic,assign) long int totalunreadnumbersLike;
@property(nonatomic,assign) long int totalunreadnumbersComment;
@property(nonatomic,assign) long int totalunreadnumbersEvent;
@property(nonatomic,assign) long int totalunreadnumbersEventUpdate;
@property(nonatomic,assign) long int totalunreadnumbersEventDelete;
@property(nonatomic,assign) long int totalunreadnumbersCoachUpdates;
@property(nonatomic,assign) long int totalunreadnumbersCoachNotifiedForAdmin;
@property(nonatomic,assign) long int totalunreadnumbersCoachNotifiedForTeam;
@property(nonatomic,assign) long int totalunreadnumbersUserNotifiedForTeamResponse;
@property(nonatomic,assign) long int totalunreadnumbersCoachNotifiedForTeamEvent;
@property(nonatomic,assign) long int totalunreadnumbersUserNotifiedForTeamEventResponse;
@property (strong, nonatomic) IBOutlet UIView *topsecondvw;
@property (strong, nonatomic) UIFont *timeFont;


- (IBAction)cancelAction:(id)sender;


- (IBAction)selectionAction:(id)sender;




@property (strong, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) IBOutlet UIView *view2;
@property (strong, nonatomic) IBOutlet UIView *view3;
@property (strong, nonatomic) IBOutlet UIView *view4;

@property (strong, nonatomic) IBOutlet UILabel *view1unreadlab;
@property (strong, nonatomic) IBOutlet UILabel *view2unreadlab;
@property (strong, nonatomic) IBOutlet UILabel *view3unreadlab;
@property (strong, nonatomic) IBOutlet UILabel *view4unreadlab;



@property(nonatomic,assign) BOOL isTeamInViteOpen;
@property(nonatomic,assign) BOOL isLikeCommentsOpen;
@property(nonatomic,assign) BOOL isCoachUpdatesOpen;
@property(nonatomic,assign) BOOL isEventsOpen;

@property(nonatomic,assign) int screenHeight;

@property (strong, nonatomic) IBOutlet UIImageView *eventsindicatorimavw;

@property (strong, nonatomic) IBOutlet UIImageView *coachupdatesindicatorimavw;
@property (strong, nonatomic) IBOutlet UIImageView *likecommentsindicatorimavw;
@property (strong, nonatomic) IBOutlet UIImageView *teaminvitesindicatorimavw;
-(void)setTeamInvitesStructure;
-(void)setLikeCommentsStructure;
-(void)setCoachUpdatesStructure;
-(void)setEventsStructure;



@property (strong, nonatomic) IBOutlet UIButton *eventvwbt;

@property (strong, nonatomic) IBOutlet UIView *eventvw;

@property (strong, nonatomic) IBOutlet UIView *cupdatevw;
@property (strong, nonatomic) IBOutlet UIButton *cupdatevwbt;

@property (strong, nonatomic) IBOutlet UIView *likescmntsvw;

@property (strong, nonatomic) IBOutlet UIButton *likescmntsbt;

@property (strong, nonatomic) IBOutlet UIView *teaminvitevw;
@property (strong, nonatomic) IBOutlet UIButton *teaminvitevwbt;








@property (strong, nonatomic) IBOutlet UIView *popupalertvwback;

@property(nonatomic,assign) BOOL isWelcomeAlert;
@property (strong, nonatomic) IBOutlet UIView *popupalertvw;
- (IBAction)popuptapped:(id)sender;
-(void)showAlertViewCustom:(NSString*)labText;


@property (strong, nonatomic) IBOutlet UILabel *custompopuplab;







@end
