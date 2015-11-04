//
//  LeftViewController.h
//  Social
//
//  Created by Mindpace on 12/08/13.
//
//



@interface LeftViewController : BaseVC <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong) NSMutableArray *dataArray;

//@property (retain, nonatomic) ImageInfo *userImainfo;
@property (strong, nonatomic) UIImage *orgImage;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIImageView *avatarimavw;
@property (assign, nonatomic) BOOL isConnectionProgressing;
-(void)loadImage;

@property (strong, nonatomic) IBOutlet UITextField *searchtf;
@property (strong, nonatomic) ImageInfo *profpicloadingimainfo;
@property (nonatomic,assign) BOOL isSelectedImage;

@property (assign) BOOL hudFlag1;


- (IBAction)changeImageAction:(id)sender;

-(void)sendRequestForImageChange:(NSDictionary*)dic;

@property (strong, nonatomic) IBOutlet UIButton *crossbt;
@property (strong, nonatomic) IBOutlet UIButton *donebt;
@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;


- (IBAction)photoActionTapped:(id)sender;

-(void)sendImageChangeNew;



@property (strong, nonatomic) IBOutlet UILabel *leftvctappiclab;


-(void)selectTableViewIndex:(int)row :(BOOL)isSel;

-(void)sendImageChangeNewForFaceBook;

-(void)resetTableViewIndex;


- (IBAction)leftBtapped:(id)sender;



//@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *leftviewsarrat;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *leftviewsarrat;



-(void)sendRequestForImageChangeWithAFNetWorking:(NSDictionary*)dic;


@end
