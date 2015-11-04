//
//  CreatePostViewController.h
//  Wall
//
//  Created by Mindpace on 18/11/13.
//
//

#import "BaseVC.h"
@class HomeVC;
@interface CreatePostViewController : BaseVC  <UIActionSheetDelegate,UITextViewDelegate>
{
    BOOL isbgExec;
}

@property (nonatomic,weak) HomeVC *homeVC;
@property (strong, nonatomic) IBOutlet UIImageView *previewimavw;
@property (strong, nonatomic) IBOutlet UITextView *commentTextVw;

@property (strong, nonatomic) IBOutlet UIImageView *imageViewCoachUpdate;  //// 29/01/15


@property (strong, nonatomic) IBOutlet UIActionSheet *actionSheetChoicePost;

@property (assign, nonatomic) BOOL isFirstTimeEnter;
@property (assign, nonatomic) BOOL isCompleteFinishCoachPost;
@property (assign, nonatomic) BOOL isCompleteFinishWallPost;
@property (assign, nonatomic) BOOL isCompleteCoachPost;
@property (assign, nonatomic) BOOL isCompleteWallPost;

@property (strong, nonatomic) IBOutlet UIButton *cambt;
@property (strong, nonatomic) IBOutlet UIButton *videobt;
@property (strong, nonatomic) IBOutlet UIButton *crosspreviewbt;
@property (strong, nonatomic) IBOutlet UIButton *denecmntb;
@property (strong, nonatomic) IBOutlet UIButton *cancelcmntb;
@property (assign, nonatomic) BOOL isSelectedImage;
@property (assign, nonatomic) BOOL isSelectedVideo;
@property (assign, nonatomic) BOOL isSelectedVideoFromURL;
@property (strong,nonatomic) NSString *videoURLStr;
@property (strong, nonatomic) NSData *dataVideo;
@property (assign, nonatomic) BOOL isSelectedCoachUpdate;
@property (strong, nonatomic) UIImage *tickimage;
@property (strong, nonatomic) UIImage *nontickimage;
@property (strong,nonatomic) NSString *teamName;
@property (strong,nonatomic) NSString *teamId;
-(void)sendRequestForPost:(NSDictionary*)dic;
-(void)showPostView:(int)mode;
-(IBAction)postbTapped:(id)sender;
-(void)resetPostView;
-(void)finishedVideoConvert;
-(UIImage*)getThumnailForVideo:(NSURL*)url;
-(void)loadVideoURL :(NSString*)videourlstr :(NSString*)thumburlstr :(ImageInfo*)thumbInfo;
@property (strong, nonatomic) IBOutlet UIView *keyboardtopVw;
@property (weak, nonatomic) IBOutlet UIView *topbarvw;
-(void)loadVideoAfterConvert:(NSURL*)outputurl;
-(void)postOnWall;
-(void)showPostActionSheet;
-(void)postCoachUpdate;
-(void)postUpdate:(NSString*)text;
-(void)takeActionAfterCompleted;
-(void)openTrainningVideos;
//-(void)loadVideoURL :(NSString*)videourlstr :(NSString*)thumburlstr :(ImageInfo*)thumbInfo;

- (IBAction)alsoCoachUpdateAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *checkbt;

@property (strong, nonatomic) IBOutlet UILabel *checkbtlabel;

@property (assign, nonatomic) BOOL isTakeImageFromWall;


@property (strong, nonatomic) IBOutlet UIButton *camsecbt;


@property (nonatomic,assign) BOOL isVideoSelected;



@end
