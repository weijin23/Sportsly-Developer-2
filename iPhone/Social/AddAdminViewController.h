//
//  AddAdminViewController.h
//  Wall
//
//  Created by Sukhamoy on 12/04/14.
//
//

#import "BaseVC.h"

@interface AddAdminViewController : BaseVC


@property (strong, nonatomic) NSString *firstEmail;

@property (strong, nonatomic) IBOutlet UITextField *addMinNameText;
@property (strong, nonatomic) IBOutlet UITextField *addMinEmailText;
@property (strong, nonatomic) IBOutlet UITextField *addMinPhoneText;
@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UITextField *adminTypeText;

@property (weak, nonatomic) IBOutlet UIButton *addminBtn;
@property(nonatomic,assign) int selectedAddmin;
@property(nonatomic,assign) int selectedTeamIndex;
@property(nonatomic,assign) BOOL isAddAdmin;
@property (nonatomic, strong) NSArray *pickerArrType;


/////   22/7/14  ////////

@property (strong, nonatomic) IBOutlet UIView *viewAlert;
@property (strong, nonatomic) IBOutlet UIView *viewAlertBack;
- (IBAction)doneAlert:(id)sender;
- (IBAction)cancelAlert:(id)sender;

@property (assign) BOOL isBack;

/////   22/7/14  ////////

@property (nonatomic,retain) NSMutableDictionary *dictMemberAdmin;   //// AD july for member

@property (strong, nonatomic) IBOutlet UIView *viewPickerContainer;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerAdminType;

- (IBAction)donePicker:(id)sender;




- (IBAction)contactList:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)addAdminToTeam:(id)sender;
@end
