//
//  SettingsViewController.h
//  Social
//
//  Created by Mindpace on 09/09/13.
//
//

#import "BaseVC.h"
#import "AppDelegate.h"

@interface SettingsViewController : BaseVC<UITextFieldDelegate,UIScrollViewDelegate>
{
    CGRect kb;
    CGRect af;
    CGSize svos;
    CGPoint point,offset;
}


@property(nonatomic,retain) UIColor *backgroundColorGrey;

@property(nonatomic,retain)NSString *eventEmailNotifaction;
@property(nonatomic,retain)NSString *eventPushNotifaction;

@property(nonatomic,retain)NSString *teamEmailNotifaction;
@property(nonatomic,retain)NSString *teamPushNotifaction;


@property(nonatomic,retain)NSString *friendEmailNotification;
@property(nonatomic,retain)NSString *friendPushNotification;


@property(nonatomic,retain)NSString *messageEmailNotifaction;
@property(nonatomic,retain)NSString *messagePushNotifaction;

@property (nonatomic,assign) BOOL isSelectedImage;
@property (strong, nonatomic) IBOutlet UIScrollView *settingsScroll;
@property (nonatomic,assign) BOOL isSelectedChPass;
@property (strong, nonatomic) IBOutlet UIView *settingsFirstView;
@property (strong, nonatomic) IBOutlet UITextField *fnameTxt;
@property (strong, nonatomic) IBOutlet UITextField *lnameTxt;
@property (strong, nonatomic) IBOutlet UITextField *emailTxt;
@property (strong, nonatomic) IBOutlet UITextField *phoneTxt;
@property (strong, nonatomic) IBOutlet UIView *notificationView;

@property (strong, nonatomic) IBOutlet UIView *settingsSecondView;
@property (strong, nonatomic) IBOutlet UITextField *pEmail1Txt;
@property (strong, nonatomic) IBOutlet UITextField *pEmail2Txt;

@property (strong, nonatomic) IBOutlet UIView *settingsThirdView;
@property (strong, nonatomic) IBOutlet UITextField *sEmail1Txt;
@property (strong, nonatomic) IBOutlet UITextField *sEmail2Txt;
@property (strong, nonatomic) IBOutlet UITextField *sEmail3Txt;
@property (strong, nonatomic) IBOutlet UITextField *sEmail4Txt;
@property (strong, nonatomic) IBOutlet UITextField *sEmail5Txt;
@property (strong, nonatomic) IBOutlet UITextField *sEmail6Txt;

@property (strong, nonatomic) IBOutlet UIView *settingsForthView;
@property (strong, nonatomic) IBOutlet UITextField *oldPswdTxt;
@property (strong, nonatomic) IBOutlet UITextField *nwPswdTxt;
@property (strong, nonatomic) IBOutlet UITextField *reNwPswdTxt;

@property (strong, nonatomic) UITextField *activeField;
@property BOOL keyboardVisible;


@property (strong, nonatomic) IBOutlet UISwitch *eventInvitePushSwh;
@property (strong, nonatomic) IBOutlet UISwitch *eventInviteEmailSwh;
@property (strong, nonatomic) IBOutlet UISwitch *friendInvitePushSwh;
@property (strong, nonatomic) IBOutlet UISwitch *friendInviteEmailSwh;
@property (strong, nonatomic) IBOutlet UISwitch *teamInvitePushSwh;
@property (strong, nonatomic) IBOutlet UISwitch *teamInviteEmailSwh;
@property (strong, nonatomic) IBOutlet UISwitch *messagePushSwh;
@property (strong, nonatomic) IBOutlet UISwitch *messageEmailSwh;
@property (strong, nonatomic) IBOutlet UIView *passContView;
@property (strong, nonatomic) IBOutlet UIView *chPassView;

- (IBAction)eventInvitePushValueChange:(id)sender;

- (IBAction)eventInviteEmailValueChange:(id)sender;

- (IBAction)friendInvitePushValueChange:(id)sender;
- (IBAction)friendInviteEmailValueChange:(id)sender;
- (IBAction)teamInvitePushValueChange:(id)sender;
- (IBAction)teamInviteEmailValueChange:(id)sender;

- (IBAction)messagePushValueChange:(id)sender;
- (IBAction)messageEmailValueChange:(id)sender;



- (IBAction)saveSettings:(id)sender;
-(void)populateData;








@end
