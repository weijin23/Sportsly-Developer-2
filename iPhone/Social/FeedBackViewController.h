//
//  FeedBackViewController.h
//  Wall
//
//  Created by Sukhamoy on 02/01/14.
//
//

#import <UIKit/UIKit.h>
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"

@interface FeedBackViewController : BaseVC<SKPSMTPMessageDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    CGRect kb;
    CGRect af;
    CGSize svos;
    CGPoint point;
}
@property (strong, nonatomic) IBOutlet UITextView *feedBacktextView;
@property (strong, nonatomic) SKPSMTPMessage *testMsg;
@property (strong, nonatomic) IBOutlet UITextField *emailTxt;
@property (strong, nonatomic) IBOutlet UITextField *passwordTxt;

@property(nonatomic,strong) UIToolbar *keyboardToolbar;
@property(nonatomic,strong) UIView *keyboardToolbarView;
@property (strong, nonatomic) IBOutlet UIView *viewTranpernt;
@property (strong, nonatomic) IBOutlet UIView *viewAlert;

- (IBAction)okAlertMessege:(id)sender;


- (IBAction)sendAction:(id)sender;
-(void)firstTime;
-(void)hideKeyTool;
@end
