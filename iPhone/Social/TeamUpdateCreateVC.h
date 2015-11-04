//
//  TeamUpdateCreateVC.h
//  Wall
//
//  Created by Mindpace on 18/11/13.
//
//

#import "BaseVC.h"

@interface TeamUpdateCreateVC : BaseVC <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *updateTextVw;

@property (assign, nonatomic) BOOL isEditMode;
@property (strong, nonatomic) IBOutlet UIButton *cancelbt;
@property (strong, nonatomic) IBOutlet UIButton *donebt;
@property (strong, nonatomic) IBOutlet UILabel *smsnumbertextl;
@property (strong, nonatomic) NSString *defaultText;
- (IBAction)bTapped:(id)sender;
-(void)postUpdate:(NSString*)text;

@property (weak, nonatomic) IBOutlet UIView *keyboardTopbarvw;

@property (weak, nonatomic) IBOutlet UIImageView *backred;
@property (weak, nonatomic) IBOutlet UILabel *backredlab;


@end
