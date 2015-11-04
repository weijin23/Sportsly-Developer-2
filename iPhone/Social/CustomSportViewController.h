//
//  CustomSportViewController.h
//  Wall
//
//  Created by Mindpace on 20/05/14.
//
//

#import "BaseVC.h"

typedef void(^CustomSportname)(int upatedIndex,NSString *name);

@interface CustomSportViewController : BaseVC

@property (retain, nonatomic) IBOutlet UITextField *customTextField;

@property (strong, nonatomic) IBOutlet UIView *animatedView;
@property (retain, nonatomic) IBOutlet UILabel *titleLbl;
@property(nonatomic,retain)NSArray *tableDataArr;
@property(nonatomic,assign) int selectedIndex;
@property(nonatomic,copy)CustomSportname customSport;
@property (retain, nonatomic) IBOutlet UITableView *modalTable;
@property(nonatomic,retain)NSArray *sportsImageArr;

- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;

@end
