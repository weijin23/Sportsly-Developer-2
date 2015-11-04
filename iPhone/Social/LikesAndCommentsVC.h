//
//  AllHistoryCoachUpdateVC.h
//  Wall
//
//  Created by Mindpace on 10/01/14.
//
//
@class FPPopoverController;
#import "BaseVC.h"
#import "LikeCommentData.h"
#import "HomeVCTableData.h"

@protocol PushByLikeCommentsVCDelegate <NSObject>
-(void)didChangeNumberLikeComments:(NSString*)number;


-(void)didSelectLikeComments:(LikeCommentData*)newInvite :(FPPopoverController*)popOverController;


@end

@interface LikesAndCommentsVC : BaseVC<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,strong) NSMutableArray *dataArrayOrg;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@property(nonatomic,strong) UIImage *dotImage;

@property(nonatomic,strong) UIFont *timeFont;
- (IBAction)cancelAction:(id)sender;
@property(nonatomic,assign) int lastSelRow;
@property (strong, nonatomic) IBOutlet UITableView *tableVw;
@property(nonatomic,assign) BOOL loadStatus;
-(void)reloadTableView;



@property(nonatomic,weak) id <PushByLikeCommentsVCDelegate> delegate;
;
@property(nonatomic,strong) FPPopoverController* popOver;

@property (assign, nonatomic) long long int start;
@property (assign, nonatomic) long long int limit;
@property (assign, nonatomic) BOOL isFinishData;

@property (strong, nonatomic) IBOutlet UIView *wallfooterview;



@property (strong, nonatomic) IBOutlet UIImageView *wallfootervwgreydot;


@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *wallfootervwactivind;
-(void)requestForTableViewFooterLoading:(NSNumber*)index;
-(NSMutableArray*)parseLikeAndComments:(NSArray*)arr;
-(void)addFromPush:(NSDictionary*)userInfo;
-(void)likeCommentArrayUpdated:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *nolbl;

-(void)goToComment:(LikeCommentData*)ldata;
-(HomeVCTableData*)getPostData:(NSDictionary*)diction;

@end
