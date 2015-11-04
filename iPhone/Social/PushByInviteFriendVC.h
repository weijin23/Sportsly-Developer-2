//
//  ToDoByEventsVC.h
//  LinkBook
//
//  Created by Piyali on 06/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "AddAFriend.h"
#import <UIKit/UIKit.h>
#import "Invite.h"
#import "ContactsUser.h"
@class FPPopoverController;
@class SelectContact;
@class PushByInviteFriendCell;
@protocol PushByInviteFriendVCDelegate <NSObject>
-(void)didChangeNumberOfFriendInvites:(NSString*)number;


-(void)didSelectFriendInvite:(Invite*)newInvite :(FPPopoverController*)popOverController;


@end



@interface PushByInviteFriendVC : BaseVC  <UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
{
    UITableView *tabView;
    NSMutableArray *alldelarr;
    
   

}
@property (nonatomic,strong) NSDate *todayFDate;
@property (nonatomic,strong) NSIndexPath *todayIndexpath;
@property (nonatomic,strong) UIImage *privateDotImage;
@property (nonatomic,strong) UIImage *publicDotImage;
@property(nonatomic,strong) NSMutableArray *alldelarr;
@property(nonatomic,strong) IBOutlet UITableView *tabView;
@property(nonatomic,strong) UIColor *grayColor;
@property(nonatomic,strong) UIColor *dGrayColor;
@property(nonatomic,strong) UIFont *grayf;
@property(nonatomic,strong) UIFont *redf;

@property(nonatomic,strong) SelectContact *selContactNew;
-(void)showAlertForNotSending:(NSString*)msg;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
-(void)setDataView;

@property(nonatomic,weak) id <PushByInviteFriendVCDelegate> delegate;
;
@property(nonatomic,strong) FPPopoverController* popOver;


@property (weak, nonatomic) IBOutlet UILabel *nolbl;
@property(nonatomic,assign) BOOL isExistData;

@property(nonatomic,assign) BOOL loadStatus;

- (IBAction)topBarAction:(id)sender;

@property(nonatomic,strong) NSMutableArray *dataImages;

@property(nonatomic,strong) NSIndexPath *lastSelIndexPath;
@property(nonatomic,assign) int lastSelStatus;

@property(nonatomic,assign) NSString *strInviteStatus;


@property (strong, nonatomic) IBOutlet UIButton *plusbuttoninvitefriendbt;

@property (strong, nonatomic) NSMutableArray *dataAllArray;

@property (assign, nonatomic) long long int start;
@property (assign, nonatomic) long long int limit;
@property (assign, nonatomic) BOOL isFinishData;
@property (assign, nonatomic) BOOL isLoadSuccessMayKnowPeople;

-(void)requestServerData;
-(void)storeUsers:(NSArray*)userarray;

@property (strong, nonatomic) IBOutlet UIView *wallfooterview;



@property (strong, nonatomic) IBOutlet UIImageView *wallfootervwgreydot;


@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *wallfootervwactivind;


@property (strong, nonatomic) IBOutlet UIView *firstsectionheadervw;

@property(nonatomic,strong) AddAFriend *addAFriendVC;

@property (strong, nonatomic) NSString *emailtotftext;

-(void)populateField:(ContactsUser*)contact;
-(void)resetInHide;
-(int)showAddAFriend;
-(void)showAddAFriendNative:(BOOL)isShow;
-(void)hideAddAFriendNative;

@property (strong, nonatomic) IBOutlet UIView *pickertop;

@property(nonatomic,strong) NSString *emailName;
@property (strong, nonatomic) IBOutlet UIView *firstsectionheaderviewextended;
@property (strong, nonatomic) IBOutlet UILabel *tappluslabel;
@property (strong, nonatomic) IBOutlet UILabel *tappluslabelm;
@property (assign, nonatomic) BOOL isExistTeam;
-(void)setRightBarButton;
-(void)moveStatusLabelBasisOfNumber:(BOOL)isExist;


@property (strong, nonatomic) IBOutlet UIImageView *nofriendinvitesimavw;

@property (strong, nonatomic) IBOutlet UIView *popupalertvwback;


@property (strong, nonatomic) IBOutlet UIView *popupalertvw;
- (IBAction)popuptapped:(id)sender;
-(void)showAlertViewCustom:(NSString*)labText;


@property (strong, nonatomic) IBOutlet UILabel *custompopuplab;

-(void)goToTimeLine:(NSString*)msg;

///////  22/7/14  ///////

@property (assign) BOOL isDecline;

@property (strong, nonatomic) IBOutlet UIView *popupAlertVwInvite;
@property (strong, nonatomic) IBOutlet UILabel *custompopuplabInvite;
- (IBAction)cancelPopup:(id)sender;
- (IBAction)popuptappedInvite:(id)sender;

-(void)showAlertViewCustomInvite:(NSString*)labText;

///////  22/7/14  ///////

@end
