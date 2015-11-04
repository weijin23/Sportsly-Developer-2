//
//  InviteDetailsViewController.h
//  Wall
//
//  Created by Mindpace on 26/09/13.
//
//

#import "AddAFriend.h"

@interface CustomMailViewController : BaseVC<UITextFieldDelegate,UITextViewDelegate>
{
    CGRect kb;
    CGRect af;
    CGSize svos;
    CGPoint point;
    
    
}
@property(nonatomic,strong) UIToolbar *keyboardToolbar;
@property(nonatomic,strong) UIView *keyboardToolbarView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;
@property (nonatomic,strong) Contacts *selectedContact;
@property(nonatomic,strong) AddAFriend *addAFriendVC;

- (IBAction)backf:(id)sender;


- (IBAction)bTapped:(id)sender;

-(void)populateField:(Contacts*)contact;
@property (strong, nonatomic) IBOutlet UITextView *textVw;
@property (strong, nonatomic) NSString *strofbody;
@property (strong, nonatomic) NSString *teamId;
@property (strong, nonatomic) NSString *currbodytext;
@property (strong, nonatomic) IBOutlet UIView *receipientmainview;
@property (strong, nonatomic) IBOutlet UITextField *emailtotf;
- (IBAction)dropDownTapped:(id)sender;

@end
