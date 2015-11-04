//
//  TeamMaintenanceVC.h
//  Social
//
//  Created by Animesh@Mindpace on 09/09/13.
//
//

#import <UIKit/UIKit.h>

@interface PhotoAlbumTeamSelectionVC : BaseVC <UITableViewDelegate,UITableViewDataSource>

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


- (IBAction)doneTapped:(id)sender;


- (IBAction)cancelTapped:(id)sender;




@end
