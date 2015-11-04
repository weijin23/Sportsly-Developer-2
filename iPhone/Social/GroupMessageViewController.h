//
//  GroupMessageViewController.h
//  Wall
//
//  Created by Sukhamoy on 26/05/14.
//
//

#import "BaseVC.h"

@interface GroupMessageViewController : BaseVC

@property (strong, nonatomic) IBOutlet UITextField *nameSearchText;
@property (strong, nonatomic) IBOutlet UITextView *messageTxtView;

@property (strong, nonatomic) IBOutlet UITableView *tableVw;
@property (strong, nonatomic) IBOutlet UIButton *sendBtn;
@property(nonatomic,strong) NSMutableArray *reciverId;
@property(nonatomic,strong) NSMutableArray *selectedreciverId;
@property (strong, nonatomic) IBOutlet UIView *toolBar;
@property(nonatomic ,strong) NSString *proFileImageLink;
@property(nonatomic,strong) NSArray *filterList;
@property (strong, nonatomic) IBOutlet UILabel *useListLbl;

- (IBAction)backf:(id)sender;
- (IBAction)sendMessage:(id)sender;

@end
