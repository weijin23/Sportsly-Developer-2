//
//  InviteViewController.h
//  Wall
//
//  Created by Sukhamoy on 21/11/13.
//
//

#import <UIKit/UIKit.h>
@class SaveTeamViewController;
@interface InviteViewController : BaseVC

@property(nonatomic,strong) NSString *inviteMessage;
@property(nonatomic,strong)NSString *selectedIdList;
@property(nonatomic,assign)int selectEdTeamIndex;

@property(nonatomic,retain) UIImage *reminderImage;
@property(nonatomic,retain) UIImage *acceptdeImage;
@property(nonatomic,retain) UIImage *inviteSelectedImage;
@property(nonatomic,retain)UIImage *noResponeImage;
@property(nonatomic,retain) UIImage *declinedImage;
@property(nonatomic,retain)NSMutableArray *selectedInvitePlayer;
@property (strong, nonatomic) IBOutlet UILabel *custmLbl;

- (IBAction)back:(id)sender;




@property (strong, nonatomic) IBOutlet UITableView *inviteTbl;


@property (strong, nonatomic) IBOutlet UIView *popupalertvwback;

@property (strong, nonatomic) IBOutlet UIButton *selectedBtn;

@property (strong, nonatomic) IBOutlet UIView *popupalertvw;
- (IBAction)popuptapped:(id)sender;
-(void)showAlertViewCustom;
- (IBAction)selectedAllplayer:(id)sender;

@end
