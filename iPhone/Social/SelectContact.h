//
//  ContactsVC.h
//  LinkBook
//
//  Created by Piyali on 21/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <UIKit/UIKit.h>
#import "CustomMailViewController.h"
#import "SaveTeamViewController.h"
#import "Contacts.h"
#import "AddAFriend.h"

@class PushByInviteFriendVC;
@class ContactsUser;
/*#import "Groups.h"
#import "ToDo.h"
#import "ContactDetails.h"*/

@interface SelectContact :BaseVC <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate ,NSFetchedResultsControllerDelegate,ABPeoplePickerNavigationControllerDelegate,UITextFieldDelegate,UIAlertViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    UITableView *tabView;
    UILabel *headerl;
    UISearchBar *mysearch;
    UIButton *addb;
    UIButton *deleteb;
    UIFont *font;
    UIButton *doneb;
    UIButton *alldeleteb;
    UIButton *cancelSearch;
    NSMutableArray *alldelarr;
    BOOL isShowCancel;
    BOOL isSearchOn;
    BOOL canSelectRow;
    BOOL isCancelTappable;
    NSFetchedResultsController *fetchSearchResultsController;
    BOOL isGroup;
    NSString *mainGroup;
    UIImage *nontick;
    UIImage *tick;
   // Groups *mygroup;
    NSMutableArray *contacts;
    NSString *mobile;
    NSMutableArray *indexes;
    NSArray *mygroupContacts;
   UIButton *backb;
    SaveTeamViewController *__weak phvc;
     CustomMailViewController * phFriend;
}

@property(nonatomic,strong) NSString *teamName;
@property(nonatomic,strong) NSString *emailName;
@property(nonatomic,strong) NSString *emailtotftext;
@property(nonatomic,strong) CustomMailViewController *phFriend;
@property(nonatomic,weak) SaveTeamViewController *phvc;
@property(nonatomic,strong) NSString *searchString;

@property(nonatomic,weak) PushByInviteFriendVC *pushInviteFriendvc;
@property(nonatomic,weak) AddAFriend *addAFriendVC;
@property(nonatomic,strong) NSString *teamId;
@property(nonatomic,strong) NSString *strofbody;
@property(nonatomic,strong) IBOutlet UIButton *backb;
@property(nonatomic,strong) NSArray *mygroupContacts;
@property(nonatomic,strong) NSMutableArray *indexes;
@property(nonatomic,strong) NSString *mobile;
@property(nonatomic,strong) NSMutableArray *contacts;
//@property(nonatomic,retain) Groups *mygroup;
@property(nonatomic,strong) UIImage *nontick;
@property(nonatomic,strong) UIImage *tick;
@property(nonatomic,assign) BOOL isGroup;
-(IBAction) cancelSearch:(id)sender;
@property(nonatomic,strong) NSString *mainGroup;
@property(nonatomic,strong) IBOutlet UIButton *cancelSearch;
@property(nonatomic,strong) NSFetchedResultsController *fetchSearchResultsController;
@property(nonatomic,strong) NSMutableArray *alldelarr;
@property(nonatomic,strong) UIFont *font;
@property(nonatomic,strong) IBOutlet UITableView *tabView;
@property(nonatomic,strong) IBOutlet UILabel *headerl;
@property(nonatomic,strong) IBOutlet UISearchBar *mysearch;
@property(nonatomic,strong) IBOutlet UIButton *addb;
@property(nonatomic,strong) IBOutlet UIButton *deleteb;
@property(nonatomic,strong) IBOutlet UIButton *doneb;
@property(nonatomic,strong) IBOutlet UIButton *alldeleteb;


@property (assign, nonatomic) long long int start;
@property (assign, nonatomic) long long int limit;
@property (assign, nonatomic) BOOL isFinishData;

- (void) searchMoviesTableView;
-(IBAction)btapped:(id)sender;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (BOOL)isOdd:(int)no;
-(IBAction) backf:(id)sender;
-(void)showAlertForNotSending:(NSString*)msg;
@property(strong,nonatomic) UIImage *suggestionimagegrey;
@property(strong,nonatomic) UIImage *searchimagegrey;
@property(strong,nonatomic) UIImage *contactsimagegrey;
@property(strong,nonatomic) UIImage *emailimagegrey;
@property(strong,nonatomic) UIImage *suggestionimagered;
@property(strong,nonatomic) UIImage *searchimagered;
@property(strong,nonatomic) UIImage *contactsimagered;
@property(strong,nonatomic) UIImage *emailimagered;

- (IBAction)plusAction:(id)sender;

- (void)displayPerson:(ABRecordRef)person;

@property (weak, nonatomic) IBOutlet UIView *besidesearchvw;

@property (weak, nonatomic) IBOutlet UIButton *backf;


@property (strong, nonatomic) IBOutlet UIButton *showAddressBook;

- (IBAction)showAddressBookAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *cancelb;
- (IBAction)cancelAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *backbmain;

-(void)resetData;


@property (strong, nonatomic) IBOutlet UITextField *emailtotf;

@property (strong, nonatomic) NSMutableArray *dataAllArray;
-(int)showAddAFriend;

-(void)populateField:(ContactsUser*)contact;

-(void)showAddAFriendNative:(BOOL)isShow;
-(void)hideAddAFriendNative;
-(void)storeUsers:(NSArray*)userarray;
@property (strong, nonatomic) IBOutlet UIView *pickertop;

@property (strong, nonatomic) IBOutlet UIView *wallfooterview;



@property (strong, nonatomic) IBOutlet UIImageView *wallfootervwgreydot;


@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *wallfootervwactivind;

@property (strong, nonatomic) IBOutlet UIView *pickercontainer;

@property (strong, nonatomic) IBOutlet UIPickerView *picker;

@property (strong, nonatomic) NSString *selectedTeamId;
@property(nonatomic,assign) int currentmode;
@property(nonatomic,assign) int buttonMode;
@property(nonatomic,assign) int selectedRow;
@property(nonatomic,assign) int currentrow;

- (IBAction)pickerAction:(id)sender;
-(void)requestServerData;
-(void)resetInHide;


@property (strong, nonatomic) IBOutlet UIView *searchbottomvw;



@property (strong, nonatomic) IBOutlet UIView *topviewthird;


-(void)requestServerDataSearch;
- (IBAction)suggestAction:(id)sender;


- (IBAction)searchTopBtAction:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *suggestLabel;
@property (strong, nonatomic) IBOutlet UIButton *suggestioncenterbt;



@property (strong, nonatomic) IBOutlet UILabel *suggestionslab;
@property (strong, nonatomic) IBOutlet UIButton *searchcenterbt;

@property (strong, nonatomic) IBOutlet UILabel *searchlab;

@property (strong, nonatomic) IBOutlet UILabel *contactslab;
@property (strong, nonatomic) IBOutlet UIButton *contactscenterbt;

@property (strong, nonatomic) IBOutlet UILabel *emaillab;
@property (strong, nonatomic) IBOutlet UIButton *emailcenterbt;

@property (weak, nonatomic) IBOutlet UIImageView *searchbarbackgrndimgvw;
-(void)setSelectedItem:(int)num;



@property (strong, nonatomic) IBOutlet UIView *popupalertvwback;
@property (strong, nonatomic) IBOutlet UIView *popupalertvw;

///////  22/7/14  ///////
@property (strong, nonatomic) IBOutlet UIView *popupAlertVwInvite;
@property (strong, nonatomic) IBOutlet UILabel *custompopuplabInvite;
- (IBAction)cancelPopup:(id)sender;
- (IBAction)popuptappedInvite:(id)sender;

-(void)showAlertViewCustomInvite:(NSString*)labText;
///////  22/7/14  ///////


- (IBAction)popuptapped:(id)sender;
-(void)showAlertViewCustom:(NSString*)labText;



@property (strong, nonatomic) IBOutlet UILabel *custompopuplab;

//// AD july for member  /////

@property (nonatomic,retain) NSMutableDictionary *dictMemberSpectator;

@property (strong, nonatomic) IBOutlet UITextField *fName;

@property (strong, nonatomic) IBOutlet UITextField *lName;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *phoneNo;

@property (strong, nonatomic) IBOutlet UIButton *spectatorInviteBtn;

///////////////////////////////



@end
