//
//  ClubViewController.h
//  Wall
//
//  Created by Sukhamoy on 26/11/13.
//
//

#import <UIKit/UIKit.h>
typedef void(^slectedLeagugeBlock)(NSString *selectedLeage,NSString *url,NSString *iD);

@interface ClubViewController : BaseVC
@property (retain, nonatomic) IBOutlet UITextField *customTxt;
@property (retain, nonatomic) IBOutlet UILabel *titleLbl;
@property (retain, nonatomic) IBOutlet UIView *customView;
@property (strong, nonatomic) IBOutlet UIView *animatedView;

@property (retain, nonatomic) IBOutlet UITableView *dropDwonTable;
@property(nonatomic,copy) slectedLeagugeBlock leaguge;
@property(nonatomic,assign) int selectedtag;
@property(nonatomic,retain)NSArray *tableDataSorce;
- (IBAction)addCustom:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;
@end
