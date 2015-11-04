//
//  RightViewController.h
//  Social
//
//  Created by Mindpace on 12/08/13.
//
//



@interface RightViewController : BaseVC


@property (retain, nonatomic) IBOutlet UITableView *contactTable;
@property(nonatomic,retain) NSArray *allUserList;
@property (retain, nonatomic) IBOutlet UIView *fotterView;
@property (strong, nonatomic) IBOutlet UILabel *msLbl;
@property(nonatomic,strong) UIFont *timeFont;

- (IBAction)showMoreContact:(id)sender;
-(void)getAllUserDetailsFoRUser;
- (IBAction)settingsbTapped:(id)sender;
- (IBAction)messageToPlayer:(id)sender;

@end
