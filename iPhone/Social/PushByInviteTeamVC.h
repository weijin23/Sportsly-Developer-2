//
//  ToDoByEventsVC.h
//  LinkBook
//
//  Created by Piyali on 06/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Invite.h"
@class FPPopoverController;
@class SelectContact;
@class PushByInviteTeamCell;
@class PushByTeamResponseCell;
@class InviteDetailsViewController;
@class PushByCoachUpdateCell;
@class PushByEventsVCCell;
@class LikesAndCommentsVCCell;
@class LikeCommentData;
@class PostLikeViewController;
@class CommentVC;

@class HomeVCTableData;



@protocol PushByCoachNotifiedForTeamInviteVCDelegate <NSObject>
-(void)didChangeNumberOfCoachNotifiedForTeamInvite:(NSString*)number;
-(void)didChangeNumberOfUserNotifiedForTeamInviteResponse:(NSString*)number;
-(void)didChangeNumberOfCoachNotifiedForTeamEventInvite:(NSString*)number;
-(void)didChangeNumberOfUserNotifiedForTeamEventInviteResponse:(NSString*)number;
-(void)didSelectCoachNotifiedForTeamInvite:(Invite*)newInvite :(FPPopoverController*)popOverController;

-(void)didChangeNumberOfCoachNotifiedForAdminInvite:(NSString*)number;


@end




@protocol PushByInviteTeamVCDelegate <NSObject>
-(void)didChangeNumberOfTeamInvites:(NSString*)number;
-(void)didChangeNumberOfAdminInvites:(NSString*)number;


-(void)didSelectTeamInvite:(Invite*)newInvite :(FPPopoverController*)popOverController;


@end

@protocol PushByCoachUpdateDelegate <NSObject>
-(void)didChangeNumberOfCoachUpdates:(NSString*)number;
-(void)didChangeNumberOfEventsUpdate:(NSString*)number;
-(void)didChangeNumberOfEventsDelete:(NSString*)number;

-(void)didSelectCoachUpdates:(Invite*)newInvite :(FPPopoverController*)popOverController;


@end

@protocol PushListingViewControllerDelegate <NSObject>

-(void)didChangeNumberOfEvents:(NSString*)number;
-(void)didSelectEvent:(Event*)newEvent :(FPPopoverController*)popOverController;
@end

@protocol PushByLikeCommentsVCDelegate <NSObject>
-(void)didChangeNumberLikeComments:(NSString*)number;


-(void)didSelectLikeComments:(LikeCommentData*)newInvite :(FPPopoverController*)popOverController;


@end

@interface PushByInviteTeamVC : BaseVC  <UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate>
{
    UITableView *tabView;
    NSMutableArray *alldelarr;

}

@property (nonatomic,strong) InviteDetailsViewController* detViewController;
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
@property(nonatomic,strong) UIFont *timeFont;
@property(nonatomic,strong) SelectContact *selContactNew;
@property(nonatomic,strong) UIImage *dotImage;

@property (nonatomic, strong) NSString *strInviteStatus; //// 31st March

- (void)configureCell:(PushByInviteTeamCell *)cell atIndexPath:(NSIndexPath *)indexPath;
-(void)setDataView;

@property(nonatomic,weak) id <PushByInviteTeamVCDelegate,PushByCoachUpdateDelegate,PushListingViewControllerDelegate,PushByLikeCommentsVCDelegate,PushByCoachNotifiedForTeamInviteVCDelegate> delegate;
;
@property(nonatomic,strong) FPPopoverController* popOver;


@property (weak, nonatomic) IBOutlet UILabel *nolbl;
@property(nonatomic,assign) BOOL isExistData;

@property(nonatomic,assign) BOOL loadStatus;

- (IBAction)topBarAction:(id)sender;

@property(nonatomic,strong) NSMutableArray *dataImages;

@property(nonatomic,strong) NSIndexPath *lastSelIndexPath;
@property(nonatomic,assign) int lastSelStatus;
-(void)loadFourSquareDataTeamPostDetails:(NSString*)responses;


///////

@property(nonatomic,assign) int lastSelRowCoach;
@property(nonatomic,assign) int lastSelRowTeamResponse;
@property(nonatomic,assign) int lastSelRowUserTeamResponse;
@property(nonatomic,assign) int lastSelRowTeamEventResponse;
@property(nonatomic,assign) int lastSelRowUserTeamEventResponse;
@property(nonatomic,assign) int lastSelRowEventUpdate;
@property(nonatomic,assign) int lastSelRowEventDelete;

@property(nonatomic,assign) int lastSelRowAdminResponse;

@property(nonatomic,strong) NSIndexPath *lastSelIndexPathAdmin;
@property(nonatomic,assign) int lastSelStatusAdmin;



- (void)configureCellPushByCoachUpdate:(PushByCoachUpdateCell *)cell1 atIndexPath:(NSIndexPath *)indexPath;

- (void)configureCellNewEvent:(PushByEventsVCCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)configureCellLike:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

-(void)goToComment:(Invite*)ldata;

-(HomeVCTableData*)getPostData:(NSDictionary*)diction;
-(void)teamInviteStatusUpdateFromPush:(Invite*)newinvite :(NSString*)str;
@property(nonatomic,assign) int lastSelRow;

- (void)configureCellTeamResponse:(PushByTeamResponseCell *)cell1 atIndexPath:(NSIndexPath *)indexPath;
- (void)configureCellUserTeamResponse: (PushByTeamResponseCell *)cell1 atIndexPath:(NSIndexPath *)indexPath;

- (void)configureCellAdminInvite:(PushByInviteTeamCell *)cell1 atIndexPath:(NSIndexPath *)indexPath;
- (void)configureCellTeamEventResponse:(PushByTeamResponseCell *)cell1 atIndexPath:(NSIndexPath *)indexPath;
- (void)configureCellUserTeamEventResponse: (PushByTeamResponseCell *)cell1 atIndexPath:(NSIndexPath *)indexPath;


-(void)deleteEventFromDeviceCalendar:(Event *)dataEvent1;

- (void)configureCellUpdateEvent:(PushByEventsVCCell *)cell1 atIndexPath:(NSIndexPath *)indexPath;
- (void)configureCellDeleteEvent:(PushByEventsVCCell *)cell1 atIndexPath:(NSIndexPath *)indexPath;

- (void)configureCellAdminResponse: (PushByTeamResponseCell *)cell1 atIndexPath:(NSIndexPath *)indexPath;

@property (strong, nonatomic) IBOutlet UIView *nonotificationvw;

@property (weak, nonatomic) Invite *userEventResponseRecord;

@property(strong,nonatomic) UIImage *likeTimeImavw;
@property(strong,nonatomic) UIImage *commentTimeImavw;



-(void)goToTimeLine:(NSString*)msg;

-(void)tableReloadData;


////////  AD  /////

@property (strong, nonatomic) IBOutlet UILabel *lblSize;
@property (assign) BOOL isDeclineAdmin;

//////////////////

@property (strong, nonatomic) IBOutlet UIView *alertViewBAck;
@property (strong, nonatomic) IBOutlet UIView *alertView;
@property (strong, nonatomic) IBOutlet UILabel *lblAlert;

- (IBAction)doneAlert:(id)sender;

@property (strong, nonatomic) IBOutlet ADBannerView *adBanner;

@end
