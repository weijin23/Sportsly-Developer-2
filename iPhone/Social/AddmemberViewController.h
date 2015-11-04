//
//  AddmemberViewController.h
//  Wall
//
//  Created by Mindpace on 30/06/15.
//
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "TeamMaintenanceVC.h"

@interface AddmemberViewController : BaseVC<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchControllerDelegate,UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tablvw;

@property (strong, nonatomic) NSMutableArray *fbUserArr;
@property (strong, nonatomic) NSMutableArray *contactUser;
@property (strong, nonatomic) NSMutableArray *allRegUserArr;
@property (strong, nonatomic) NSDictionary *contactDict;
@property (strong, nonatomic) NSArray *memberEmailArr;
@property (strong, nonatomic) NSArray *memberPhoneNumArr;
@property (strong, nonatomic) NSString *selectedEmail;
@property (strong, nonatomic) NSString *selectedPhoneNum;

@property (strong, nonatomic) NSString *nonMemberEmailId;

@property (strong, nonatomic) NSMutableDictionary *selectedMemberDetailsDict;

@property (strong, nonatomic) TeamMaintenanceVC *teamMaintenanceMemberDetailsVC;

@property int segmentNumberTapped;
@property int singleDetailPresent;

- (IBAction)cancelBtnAction:(id)sender;
- (IBAction)skipBtnAction:(id)sender;

@end
