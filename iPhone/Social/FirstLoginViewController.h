//
//  FirstLoginViewController.h
//  Wall
//
//  Created by Mindpace on 14/04/14.
//
//

#import "BaseVC.h"

@interface FirstLoginViewController : BaseVC

@property (assign) int isFacebook;


@property (strong, nonatomic) IBOutlet UIButton *tellAFriendBtn;

- (IBAction)loginAction:(id)sender;

- (IBAction)signUpAction:(id)sender;

- (IBAction)tellAFriendAction:(id)sender;


//-(void)loginWithFacebook:(NSString*)emailstr :(NSString*)fstname :(NSString*)lastname :(NSString*)fid;
//////////////////////////////ADDDEBNEW
-(void)getEmailIdForFacebookLogin:(ACAccount*)account;
//////////////////////////////
@end
