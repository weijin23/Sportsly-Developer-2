//
//  InvitePlayerListViewController.h
//  Wall
//
//  Created by Sukhamoy on 21/11/13.
//
//

#import <UIKit/UIKit.h>

@interface InvitePlayerListViewController : BaseVC

@property (assign,nonatomic) BOOL editMode;
@property (assign,nonatomic) int itemno;
@property(nonatomic,assign) int selectedTeamIndex;
@property (retain, nonatomic) IBOutlet UIButton *inviteBtn;

@property (retain, nonatomic) IBOutlet UIButton *createEventBtn;

@property (retain, nonatomic) IBOutlet UIButton *teamDetailSbtn;
- (IBAction)teamDetails:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *playerDetailsBtn;
- (IBAction)playerDetails:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *teamNameLbl;
- (IBAction)createEvent:(id)sender;
- (IBAction)inviteTracker:(id)sender;

@end
