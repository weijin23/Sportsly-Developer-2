//
//  Tutorila1ViewController.h
//  Wall
//
//  Created by Mindpace on 04/07/14.
//
//

#import <UIKit/UIKit.h>

@interface Tutorila1ViewController : BaseVC

@property (strong, nonatomic) IBOutlet UIImageView *image1;
@property (strong, nonatomic) IBOutlet UIButton *btnSignIn;
@property (strong, nonatomic) IBOutlet UIButton *btnSignup;
@property (strong, nonatomic) IBOutlet UIButton *btnInvite;

- (IBAction)singin:(id)sender;
- (IBAction)signUpWithFacebook:(id)sender;
- (IBAction)inviteACoach:(id)sender;


@end
