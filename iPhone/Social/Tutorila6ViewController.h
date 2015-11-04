//
//  Tutorila6ViewController.h
//  Wall
//
//  Created by Mindpace on 04/07/14.
//
//

#import <UIKit/UIKit.h>

@interface Tutorila6ViewController : BaseVC
- (IBAction)signup:(id)sender;
- (IBAction)sinin:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *image6;
@property (strong, nonatomic) IBOutlet UIButton *btnSignup;
@property (strong, nonatomic) IBOutlet UIButton *btnSignIn;
@property (strong, nonatomic) IBOutlet UIButton *btnInvite;

- (IBAction)inviteACoach:(id)sender;
@end
