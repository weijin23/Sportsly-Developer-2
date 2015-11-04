//
//  MessageVC.h
//  Wall
//
//  Created by Mindpace on 30/01/14.
//
//

#import "BaseVC.h"

@interface MessageVC : BaseVC  <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *nameSearchText;
@property (strong, nonatomic) IBOutlet UITableView *tableVw;
@property (strong, nonatomic) IBOutlet UITextView *messageTxtView;
@property (strong, nonatomic) IBOutlet UIButton *sendBtn;
@property(nonatomic,strong) NSMutableArray *reciverId;
@property (strong, nonatomic) IBOutlet UIView *toolBar;
@property(nonatomic ,strong) NSString *proFileImageLink;
@property(nonatomic,assign) BOOL isSearching;
@property(nonatomic,strong) NSArray *filterList;

- (IBAction)backf:(id)sender;
- (IBAction)sendMessage:(id)sender;

@end
