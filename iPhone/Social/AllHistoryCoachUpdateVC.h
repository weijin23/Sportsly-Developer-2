//
//  AllHistoryCoachUpdateVC.h
//  Wall
//
//  Created by Mindpace on 10/01/14.
//
//

#import "BaseVC.h"

@interface AllHistoryCoachUpdateVC : BaseVC<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSArray *dataArray;
@property(nonatomic,strong) NSArray *dataArrayOrg;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@property(nonatomic,strong) UIImage *dotImage;

@property(nonatomic,strong) UIFont *timeFont;
- (IBAction)cancelAction:(id)sender;
@property(nonatomic,assign) int lastSelRow;
@property (strong, nonatomic) IBOutlet UITableView *tableVw;
@property(nonatomic,assign) BOOL loadStatus;
-(void)reloadTableView;
@end
