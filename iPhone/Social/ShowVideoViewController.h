//
//  ShowVideoViewController.h
//  Wall
//
//  Created by Sukhamoy on 10/12/13.
//
//

#import <UIKit/UIKit.h>

@interface ShowVideoViewController : BaseVC

@property (retain, nonatomic) IBOutlet UIView *datePickerView;
@property (retain, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (retain, nonatomic) IBOutlet UIImageView *sportImageview;
@property (retain, nonatomic) IBOutlet UIImageView *dateImageview;
@property (retain, nonatomic) IBOutlet UIImageView *playerImageView;

@property(nonatomic,retain) NSArray *allVideos;
@property (retain, nonatomic) IBOutlet UITableView *tablView;
@property (retain, nonatomic) IBOutlet UITextField *dateTxt;
@property (retain, nonatomic) IBOutlet UITextField *nameTxt;
@property(nonatomic,retain)NSArray *allAlphabet;
@property (nonatomic, retain) NSArray *indexTitles;
@property(nonatomic,retain)NSMutableDictionary *thumbImageDict;
@property (retain, nonatomic) IBOutlet UITextField *searchTxt;
@property(nonatomic,retain)NSMutableDictionary *allVideosDict;
@property(nonatomic,retain)NSString *sportName;
@property(nonatomic,retain)NSString *selectedUsername;
@property(nonatomic,retain)NSString *selectedDate;
@property(nonatomic,retain) NSArray *allVideosArr;
@property(nonatomic,retain) NSDictionary *selectedVideoDict;
@property(nonatomic,retain)NSMutableArray *userName;
@property(nonatomic,retain)NSMutableArray *sportNameArr;
@property(nonatomic,assign)BOOL isSport;
@property(nonatomic,assign)BOOL isName;
@property(nonatomic,assign)BOOL isDate;
@property(nonatomic,assign)BOOL isFromHomeVC;
- (IBAction)back:(id)sender;
-(void)getAllTrainingVideos;
- (IBAction)addNewVideo:(id)sender;
- (IBAction)datePickercancel:(id)sender;
- (IBAction)datePickerDone:(id)sender;
-(void)showDatePicker;
@end
