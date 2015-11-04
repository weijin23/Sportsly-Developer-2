//
//  AddVideoViewController.h
//  Wall
//
//  Created by Sukhamoy on 10/12/13.
//
//

#import <UIKit/UIKit.h>

@interface AddVideoViewController : BaseVC

@property(nonatomic,retain)NSDictionary *editVideoDict;
@property (retain, nonatomic) IBOutlet UITextField *nameTxt;
@property (retain, nonatomic) IBOutlet UITextField *sportTxt;
@property (retain, nonatomic) IBOutlet UITextField *urlTxt;
@property (retain, nonatomic) IBOutlet UIView *firstView;
@property (retain, nonatomic) IBOutlet UIImageView *thumpImageView;
@property (strong, nonatomic) NSData *dataVideo;
@property (retain, nonatomic) IBOutlet UISegmentedControl *segment;
@property(nonatomic,assign) int isLink;
@property (retain, nonatomic) IBOutlet UIView *videoLink;
@property (retain, nonatomic) IBOutlet UIView *uploadVideoView;
@property (retain, nonatomic) IBOutlet UITextField *linkTeamName;
@property (retain, nonatomic) IBOutlet UITextField *linkSportName;
@property (retain, nonatomic) IBOutlet UITextField *videoTeamName;
@property (retain, nonatomic) IBOutlet UITextField *videoSportName;
@property(nonatomic,retain)NSMutableArray *sportNameArr;
@property (retain, nonatomic) IBOutlet UITextField *enterUrl;
- (IBAction)enterVideoLink:(id)sender;

@property (retain, nonatomic) IBOutlet UIView *videoView;
@property(nonatomic,assign) BOOL isCreated;
- (IBAction)done:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)uploadVideo:(id)sender;
- (IBAction)segmentValueChange:(id)sender;
- (IBAction)selectedSport:(id)sender;
-(void)finishedVideoConvert;
-(UIImage*)getThumnailForVideo:(NSURL*)url;
-(void)loadVideoAfterConvert:(NSURL*)outputurl;
@end
