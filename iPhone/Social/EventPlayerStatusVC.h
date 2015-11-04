//
//  EventPlayerStatusVC.h
//  Wall
//
//  Created by Mindpace on 22/01/14.
//
//

#import "BaseVC.h"
#import "InvitePlayerListCell.h"
@interface EventPlayerStatusVC : BaseVC<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,retain) UIImage *tickimage;
@property(nonatomic,retain) UIImage *nontickimage;
@property(nonatomic,retain) UIImage *acceptdeImage;
@property(nonatomic,retain) UIImage *inviteDeselectedImage;
@property(nonatomic,retain) UIImage *inviteSelectedImage;
@property(nonatomic,retain) UIImage *noResponeImage;
@property(nonatomic,retain) UIImage *declinedImage;
@property(nonatomic,retain) UIImage *mayBeImage;
@property(nonatomic,retain) UIImage *reminderImage;
@property(nonatomic,retain) UIImage *normalImage;

@property (nonatomic,strong) IBOutlet UITableView *tbllView;
@property (nonatomic,strong) IBOutlet UILabel *msgLabel;
@property (nonatomic,strong) NSMutableArray *playerIds;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSString *eventTeamId;
@property (nonatomic,strong) NSString *eventId;
@property (assign) int isAddEvent;

@property (nonatomic,strong) NSString *headerTitle;

@property(nonatomic,retain)NSMutableArray *selectedInvitePlayer;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath andTableView:(UITableView*)tableview;


- (IBAction)tobBarAction:(id)sender;

-(void)getPlayerListings;
-(void)invitePlayerToServer;


@property (assign, nonatomic) BOOL flagEventSelect;

@property (strong, nonatomic) IBOutlet UIButton *selectAllEvent;

@property (assign, nonatomic) BOOL isFromAttendance;

- (IBAction)selectAllEventAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *sendbt;

@property (strong, nonatomic) IBOutlet UILabel *selectallbt;
-(void)hideAllRelatedViews;


@property (strong, nonatomic) IBOutlet UIImageView *noplayersimgvw;


@property (strong, nonatomic) IBOutlet UIView *popupalertvwback;
@property (strong, nonatomic) IBOutlet UIView *popupalertvw;

- (IBAction)popuptapped:(id)sender;
-(void)showAlertViewCustom;

//////  07/03/2015  //////

@property (strong, nonatomic) IBOutlet UIView *viewSelectAll;
@property (strong, nonatomic) IBOutlet UIView *viewMsg;
@property (strong, nonatomic) IBOutlet UIView *popupEventalertvw;

//@property (assign) BOOL isAdminInvite;

/////////  AD  //////////

@end
