//
//  ChatViewController.h
//  Wall
//
//  Created by Sukhamoy on 06/01/14.
//
//

#import <UIKit/UIKit.h>

@interface ChatViewController : BaseVC{
    
    BOOL isBannerLoaded;
}

@property (retain, nonatomic) UIColor *msgRightColor;
@property (retain, nonatomic) IBOutlet UITableView *chatTableView;
@property (strong, nonatomic) IBOutlet UITextView *chatTextView;

@property(nonatomic,retain) NSString *groupId;
@property(nonatomic,retain) NSString *reciverUserId;
@property(nonatomic,retain) NSString *phoneNumber;
@property(nonatomic,retain) NSString *emailId;
@property(nonatomic,retain)NSString *reciverTeam;
@property(nonatomic,retain)NSString *reciverName;
@property(nonatomic,assign)int isList;
@property(nonatomic,retain) NSMutableArray *messageList;
@property (strong, nonatomic) IBOutlet UILabel *titleLbl;
@property (strong, nonatomic) IBOutlet UIView *toolBar;
@property (strong, nonatomic) IBOutlet UIButton *sendBtn;
@property (strong, nonatomic) IBOutlet UIButton *btnReceiverContact;

@property(strong ,nonatomic) NSMutableDictionary *messageGroup;

- (IBAction)sendComent:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)contactWithReceiver:(id)sender;


-(void)getMessageListforSender:(NSString *)senderId andReciver:(NSString *)reciverId;

@property (strong, nonatomic) IBOutlet ADBannerView *adBanner;

@end
