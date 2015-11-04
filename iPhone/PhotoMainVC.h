//
//  PhotoMainVC.h
//  Wall
//
//  Created by Sukhamoy Hazra on 26/09/13.
//
//

#import <UIKit/UIKit.h>

@class PhotoMainVCTableCell;
@interface PhotoMainVC : BaseVC<UITableViewDataSource,UITableViewDelegate,UIPrintInteractionControllerDelegate,UIDocumentInteractionControllerDelegate>
{
    UIDocumentInteractionController *documentInteractionController;
   
}
 @property (strong, atomic) UIDocumentInteractionController *documentInteractionController;
@property BOOL isEditEnabled;

-(UIImage*)getThumnailForVideo:(NSURL*)url;
@property (retain, nonatomic) IBOutlet UITextField *teamNametxt;
@property (retain, nonatomic) IBOutlet UITextField *dateTxt;
@property (retain, nonatomic) IBOutlet UITextField *nameTxt;
@property (retain, nonatomic) IBOutlet UIImageView *teamImageView;
@property (retain, nonatomic) IBOutlet UIImageView *dateImageView;
@property (retain, nonatomic) IBOutlet UIImageView *playerImageView;

@property(nonatomic,assign) int teamSelectEdRow;
@property(nonatomic,assign) int userSelectedRow;
@property(nonatomic,assign) int Selectedtag;
@property(nonatomic,assign)BOOL isTeam;
@property(nonatomic,assign)BOOL isName;
@property(nonatomic,assign)BOOL isDate;

@property (strong, nonatomic) IBOutlet UIImageView *changeImage;
@property (strong, nonatomic) IBOutlet UILabel *changeLbl;
@property(nonatomic,assign)BOOL isPostPhotos;
@property (strong, nonatomic) IBOutlet UILabel *dateLbl;
@property (strong, nonatomic) IBOutlet UILabel *playerLbl;

@property (strong, nonatomic) IBOutlet UIButton *allPhotoBtn;

@property (retain, nonatomic) IBOutlet UILabel *titleLbl;

@property(nonatomic,retain)NSMutableArray *userName;
@property(nonatomic,retain)NSMutableArray *TeamNameArr;

@property(nonatomic,retain)NSString *sportName;
@property(nonatomic,retain)NSString *selectedUsername;
@property(nonatomic,retain)NSString *selectedDate;

@property(nonatomic,retain) NSMutableDictionary *selectedImageDict;

@property (nonatomic,retain) NSMutableArray *teamIds;

@property(nonatomic,retain)NSMutableArray * AllPhotos;
@property(nonatomic,retain)NSMutableArray * AllVideos;

@property(nonatomic,retain)NSMutableArray *AllPhotosArr;
@property(nonatomic,retain)NSMutableArray *AllVideosArr;

@property (nonatomic,retain) NSMutableArray *albumNameList;
@property (nonatomic,retain) NSMutableArray *videoNameList;

@property(nonatomic,retain)NSMutableArray *allVideosLink;
@property(nonatomic,retain)UIColor *customRedColor;

@property (retain, nonatomic) IBOutlet UITableView *tableVw;
@property (retain, nonatomic) IBOutlet UIButton *editBtn;
@property (retain, nonatomic) IBOutlet UIButton *addBtn;
@property(nonatomic,retain) UITextField *currtf;
@property (nonatomic,retain) PhotoMainVCTableCell *currcell;
@property (strong, nonatomic) IBOutlet UIView *filterView;

@property (retain, nonatomic) IBOutlet UIView *printView;
@property (retain, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (retain, nonatomic) IBOutlet UIView *datePickerview;

@property (retain, nonatomic) IBOutlet UILabel *msgLabel;
@property (retain, nonatomic) IBOutlet UIButton *selectBtn;
@property (retain, nonatomic) IBOutlet UIButton *refreshBtn;

@property (strong, nonatomic) IBOutlet UIView *pickerContainerView;
@property (strong, nonatomic) IBOutlet UILabel *teamlbl;

@property (strong, nonatomic) IBOutlet UIPickerView *picker;

- (IBAction)pickercancel:(id)sender;
- (IBAction)donePicker:(id)sender;
-(void)showDatePicker;

- (IBAction)back:(id)sender;

- (IBAction)selectordoneAction:(id)sender;

-(void)sendRequestForPhotoAlbums:(NSDictionary*)dic;

-(void)viewAllPhotos:(UIButton *)sender;
- (IBAction)doneWithPicker:(id)sender;
- (IBAction)cancelWithPicker:(id)sender;

- (IBAction)mailSelectedPhoto:(id)sender;
-(void)updateServerData;
- (IBAction)printPhoto:(id)sender;
- (IBAction)RefreshList:(id)sender;
- (IBAction)sharephoto:(id)sender;
- (IBAction)sharePhotoFacebook:(id)sender;
- (IBAction)sharePhotoInstragram:(id)sender;
- (IBAction)allPhotos:(id)sender;

- (IBAction)cancelShareAction:(id)sender;

@property (retain, nonatomic) IBOutlet UIView *shareView;

@property (strong, nonatomic) IBOutlet UIView *sharevwmain;


@property (strong, nonatomic) UIImage *noAlbum;
//////////////////////////////
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentcontrl;



- (IBAction)chSegAction:(id)sender;




-(void)getUpdateData;


@property (strong, nonatomic) IBOutlet UIView *nodatavw;
@property (strong, nonatomic) IBOutlet UIImageView *nodataimgvw;


-(void)setNoDataView;
-(void)setRightBarButton:(BOOL)isShow;
-(void)setLeftBarButton:(BOOL)isShow;
@property (assign, nonatomic) BOOL isAscendingDate;

@property (strong, nonatomic) IBOutlet UIView *custompopuptopselectionvw;


@property (strong, nonatomic) IBOutlet UIView *custompopupbottomvw;

@property (strong, nonatomic) NSString *selVideoPath;

- (IBAction)custompopupbTapped:(id)sender;

- (IBAction)hideCustomPopupTapped:(id)sender;



-(void)setRightBarButtonItemText:(NSString*)str;

-(void)grabImage:(NSURL*)url;
@property (strong, nonatomic) NSDate *selDate;
//////////////////////////////


@property (strong, nonatomic) IBOutlet UIView *popupalertvwback;


@property (strong, nonatomic) IBOutlet UIView *popupalertvw;
- (IBAction)popuptapped:(id)sender;
-(void)showAlertViewCustom:(int)noOfPhotos;


@property (strong, nonatomic) IBOutlet UIButton *printbt;

@property (strong, nonatomic) IBOutlet UIButton *mailbt;

@property (strong, nonatomic) IBOutlet UIButton *facebookbt;

@property (strong, nonatomic) IBOutlet UIButton *instagrambt;

- (void)facebookLoginActionP;

@property (strong, nonatomic) IBOutlet UILabel *popupalertlab;

@property int photoToBeSharedCount; //// facebook sdk change 8th july

@end
