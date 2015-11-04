//
//  CommentVC.h
//  Social
//
//  Created by Mindpace on 07/09/13.
//
//
#import "HomeVCTableData.h"
#import "BaseVC.h"
#import "ASIHTTPRequest.h"
#import "MBProgressHUD.h"

@class CommentVCTableCell;

@interface CommentVC : BaseVC<ASIHTTPRequestDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>

@property (strong, nonatomic) UIButton *moreBtn;
@property (strong, nonatomic) UIButton *cellMoreBtn;
@property (strong, nonatomic) IBOutlet UITableView *commentTableVw;
@property (strong, nonatomic) IBOutlet UIView *postCommentVw;
@property (strong, nonatomic) IBOutlet UITextView *postTxtVw;
@property (strong, nonatomic) IBOutlet UIButton *postCommentBtn;

@property (strong, nonatomic) IBOutlet UIView *firstCommentCell;
@property (strong, nonatomic) IBOutlet UIView *mainContainer;
@property (strong, nonatomic) IBOutlet UIImageView *userImg;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *acindviewuser;
@property (strong, nonatomic) IBOutlet UILabel *mainPostedByLbl;
@property (strong, nonatomic) IBOutlet UILabel *mainPostedOnLbl;
@property (strong, nonatomic) IBOutlet UIButton *closeBtn;
@property (strong, nonatomic) IBOutlet UIImageView *userPost;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *acindviewpost;

@property (strong, nonatomic) IBOutlet UIView *subContainer;
@property (strong, nonatomic) IBOutlet UILabel *likeCountLbl;
@property (strong, nonatomic) IBOutlet UIButton *likeBtn;
@property (strong, nonatomic) IBOutlet UILabel *commentCountLbl;
@property (strong, nonatomic) IBOutlet UIButton *commentBtn;
@property (strong, nonatomic) IBOutlet UILabel *mainCommentsLbl;
@property (strong, nonatomic) NSString *mainLblTxt;
@property (strong, nonatomic) NSString *pDateString;
@property (strong, nonatomic) NSString *pTimeString;


@property (strong, nonatomic) UIImage *normalpost;
@property (strong, nonatomic) UIImage *normalSelpost;


@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) MBProgressHUD *hud;

@property (nonatomic,strong) CommentVCTableCell *commentCell;
@property int selectedRow;

@property BOOL isFromHome;
@property (strong, nonatomic) NSString *orgComment;
@property (strong, nonatomic) HomeVCTableData *hvcData;
@property (strong, nonatomic) NSMutableArray *commentDetailsData;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (IBAction)commentPost:(id)sender;
- (void) showFullComment: (UIButton *) sender;
-(void) showFullCellComment: (UIButton *) sender;
- (IBAction)backf:(id)sender;
@property (strong, nonatomic) UIImage *likedImage;
@property (strong, nonatomic) UIImage *nonLikedImage;
@property (strong, nonatomic) IBOutlet UIImageView *likeImage;
@property (strong, nonatomic) NSArray *animationtowhitesets;
@property (strong, nonatomic) NSArray *animationtogreensets;
@property (strong, nonatomic)   NSIndexPath * previousIndexPath ;
- (IBAction)likeComment:(id)sender;

-(void)postComment:(NSString*)strforpost;
-(void)reloadAfterComment:(NSString*)cmnt :(NSString*)datestr :(NSString*)profileImage;
-(void)processAllComments;
-(void)resizeAfterImageDownload:(UIImage*)image1;

@property (assign, nonatomic) BOOL isFinishData;
@property (strong, nonatomic) IBOutlet UIButton *commentcancelbt;

- (IBAction)commentCancelbTapped:(id)sender;



@property (strong, nonatomic) IBOutlet UILabel *teamNamelab;

@property (weak, nonatomic) IBOutlet UILabel *likeorunlikelab;

@property (weak, nonatomic) IBOutlet UILabel *commentlabel;

@property (weak, nonatomic) IBOutlet UILabel *likeslabel;

@property (weak, nonatomic) IBOutlet UILabel *comntslabel;


@property (assign, nonatomic) long long int start;
@property (assign, nonatomic) long long int limit;
@property (assign, nonatomic) int totalCellCount;


- (IBAction)showRelationPlayer:(id)sender;

- (IBAction)relationActionPlayer:(id)sender;


@property (strong, nonatomic) IBOutlet UIButton *viewLikesBt;
- (IBAction)viewLikes:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *wallfootervw;


@property (strong, nonatomic) IBOutlet UIImageView *wallfootervwgreydot;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *wallfootervwactivind;
-(NSMutableArray*)loadListingCommentDetails:(NSArray*)responses;
-(void)requestForTableViewFooterLoading:(NSNumber*)index;



@property (strong, nonatomic) IBOutlet UIImageView *videoplayimavw;


@property (strong, nonatomic) IBOutlet UIImageView *likestatusimage;
@property (strong, nonatomic) IBOutlet UIImageView *commentsstatusimagevw;



@end
