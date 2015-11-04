//
//  TeamPlayerViewController.h
//  Wall
//
//  Created by Sukhamoy on 09/12/13.
//
//

#import <UIKit/UIKit.h>

@interface TeamPlayerViewController : BaseVC

@property (strong, nonatomic) IBOutlet UIImageView *phoneNoImageView;
@property (strong, nonatomic) IBOutlet UILabel *phoneNoLbl;
@property (strong, nonatomic) IBOutlet UIButton *teamRosterBtn;

@property (strong, nonatomic) IBOutlet UIView *callPopUp;
@property (retain, nonatomic) IBOutlet UILabel *teamNameLbl;
@property (retain, nonatomic) IBOutlet UIImageView *sportLogoImage;
@property (retain, nonatomic) IBOutlet UIImageView *teamLogoImage;
@property (strong, nonatomic) IBOutlet UIImageView *calProfileImage;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *teamRosterFilterImageView;
@property (strong, nonatomic) IBOutlet UILabel *teamRosterLbl;

@property(nonatomic,assign)int selectedRow;
@property (retain, nonatomic) IBOutlet UITableView *playerListTable;
@property(nonatomic,retain)NSMutableArray *pikerData;
@property(nonatomic,retain) NSArray * allTeamList;
@property(nonatomic,retain) NSArray *sportname;
@property(nonatomic,retain) NSMutableDictionary *groupDict;
@property (retain, nonatomic) IBOutlet UIView *pickerView;
@property (retain, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) IBOutlet UILabel *msgLbl;
@property(nonatomic,retain) NSArray *saveAllTeam;
@property(nonatomic,strong)NSMutableArray *myAllFriend;



- (IBAction)filterDataUsingTeam:(id)sender;
- (IBAction)pickerCancel:(id)sender;
- (IBAction)pickerDone:(id)sender;
-(void)getAllTemaDetailsFoeUser;

- (IBAction)callToNumber:(id)sender;
- (IBAction)touchDetected:(id)sender;

@end
