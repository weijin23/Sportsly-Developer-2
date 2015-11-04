//
//  InviteCoachViewController.h
//  Wall
//
//  Created by User on 16/02/15.
//
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"

@interface InviteCoachViewController : BaseVC{
    CGRect kb;
    CGRect af;
    CGSize svos;
    CGPoint point;
}

@property (strong, nonatomic) IBOutlet UITextField *txtCoachEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtYourEmail;
@property (strong, nonatomic) IBOutlet UITextView *txtViewComment;

@property (strong, nonatomic) IBOutlet UIView *viewTranpernt;
@property (strong, nonatomic) IBOutlet UIView *viewAlert;

@property(nonatomic,strong) UIToolbar *keyboardToolbar;
@property(nonatomic,strong) UIView *keyboardToolbarView;
@property(nonatomic,strong) NSString *strName;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollCoach;

- (IBAction)sendYourCoachInvite:(id)sender;
- (IBAction)cancelCoachInvite:(id)sender;

-(void)firstTime;
-(void)hideKeyTool;
@end
