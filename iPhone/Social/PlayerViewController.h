//
//  PlayerViewController.h
//  Wall
//
//  Created by Sukhamoy on 20/11/13.
//
//

#import <UIKit/UIKit.h>
#import "Contacts.h"
@interface PlayerViewController : BaseVC{
    
    CGRect kb;
    CGRect af;
    CGSize svos;
}

@property(nonatomic,assign) BOOL isPlayerEmailIDRegster;
@property(nonatomic,assign) BOOL isPrimary1EmailIDRegster;
@property(nonatomic,assign) BOOL isPrimary2EmailIDRegster;



@property(nonatomic,assign) BOOL isPlayer;
@property(nonatomic,assign) BOOL isPrimary1;
@property(nonatomic,assign) BOOL isPrimary2;

@property(nonatomic,retain) UITextField *currrentTextFiled;
@property (retain, nonatomic) IBOutlet UITableView *playerTable;
@property (strong, nonatomic) IBOutlet UIButton *addBtn;
@property (strong, nonatomic) IBOutlet UILabel *titleLbl;

@property(nonatomic,assign) int isNoPlayer;
@property(nonatomic,retain)NSMutableArray *playerName;
@property(nonatomic,retain)NSMutableArray *lastName;
@property(nonatomic,retain)NSMutableArray *emailIdValue;
@property(nonatomic,retain)NSMutableArray *emailIdValue1;
@property(nonatomic,retain)NSString *last_emailId;
@property(nonatomic,retain)NSMutableArray *phoneNoValue;
@property (retain, nonatomic) IBOutlet UIScrollView *playerScrollView;

@property (strong, nonatomic) IBOutlet UIView *playerHeaderView;
@property(nonatomic,assign)int playerMode;
@property(nonatomic,assign)int CountPlayer;
@property(nonatomic,assign)int selectedTeamIndex;
@property(nonatomic,assign)int selectedPlayerIndex;
@property (retain, nonatomic) IBOutlet UIView *playerDetailView;
@property(nonatomic,retain) Contacts *selectedContact;

@property(nonatomic,retain)NSMutableDictionary *command;
@property (strong, nonatomic) IBOutlet UILabel *addPlayerViewlbl;

@property (assign) int isTapBack;  ////  23/7/14  /////
@property (assign) int isValidEmailCheck;  ////  23/7/14  /////
@property (nonatomic, strong) NSIndexPath *selectedTextIndex;  ////  11/9/14  /////

@property (assign) BOOL isGetName;  ////  8/10/14  /////

//Subhasish..24th March
@property (strong, nonatomic) IBOutlet UIView *popupAlertVw;
@property (strong, nonatomic) IBOutlet UIView *popupBackVw;
- (IBAction)popupAlertTapped:(id)sender;

- (IBAction)done:(id)sender;
- (IBAction)addPlayer:(id)sender;
-(void)getFullName:(NSString*)email;

//// Arpita ... 27th March
@property (strong, nonatomic) IBOutlet UITextField *gupiTextField;   ///// for keyboard hidden


@property (nonatomic,retain) NSMutableDictionary *dictMemberPlayer;   //// AD july for member

@end
