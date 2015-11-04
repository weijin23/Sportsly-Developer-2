//
//  TeamMaintenanceVC.h
//  Social
//
//  Created by Animesh@Mindpace on 09/09/13.
//
//

#import <UIKit/UIKit.h>
@class SelectContact;
@interface AddAFriend : BaseVC <UITableViewDelegate,UITableViewDataSource,UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,strong) IBOutlet UITableView *tbllView;
@property (nonatomic,strong) IBOutlet UILabel *msgLabel;

@property (nonatomic,strong) IBOutlet UIImage *tickimage;
@property (nonatomic,strong) IBOutlet UIImage *nontickimage;

@property (nonatomic,strong) NSMutableArray *teamNames;
@property (nonatomic,strong) NSMutableArray *teamIds;
@property (nonatomic,strong) NSMutableArray *JSONDATAarr;
@property (nonatomic,strong) NSMutableArray *JSONDATAImages;
-(IBAction)AddTeam:(UIButton*)sender;
-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)delBtnTapped:(UIButton*)sender;
-(void)sendRequestForTeamData:(NSDictionary*)dic;
-(void)loadTeamData;
-(void)resetData;

@property(nonatomic,strong) NSString *sendEmailName;
@property(nonatomic,strong) NSString *sendEmailId;
@property(nonatomic,strong) NSString *teamId;
@property(nonatomic,strong) NSString *strofbody;

@property(nonatomic,weak) id selectContact;

- (IBAction)doneTapped:(id)sender;


- (IBAction)cancelTapped:(id)sender;

-(void)sendToServer;

@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property(assign,nonatomic) int currentrow;
@property(assign,nonatomic) int selectedRow;


@property (strong, nonatomic) IBOutlet UILabel *toolbartitle;

-(void)hideHudViewHereOnly;
-(void)hideHudViewHere;


@end
