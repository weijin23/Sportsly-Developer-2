//
//  ChatMessageViewController.h
//  Wall
//
//  Created by Mindpace on 18/01/14.
//
//

#import <UIKit/UIKit.h>
//#import <iAd/iAd.h>

@protocol ChatMessageDelegate <NSObject>

-(void)didChangeNumberMessage:(NSString*)number;

@end


@interface ChatMessageViewController : BaseVC<UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *messageListTable;
@property(nonatomic,strong) NSMutableArray *pendingMessage;
@property(nonatomic,weak) id <ChatMessageDelegate> delegate;

@property(nonatomic,strong) UIFont *timeFont;
@property(nonatomic,strong) NSMutableArray *getFilterUser;
@property (weak, nonatomic) IBOutlet UIView *noMessageView;
@property(nonatomic,strong)NSMutableArray *myAllFriend;
@property(nonatomic,strong)NSMutableArray *userAllTeam;
@property (strong, nonatomic) IBOutlet UIView *myMessageView;

- (IBAction)groupMessage:(id)sender;
- (IBAction)singleMessage:(id)sender;

-(void)collectDataForGroupChat:(NSString*)groupId;
-(void)refreshChatMessageList;
- (IBAction)messageToplayer:(id)sender;
-(void)getUpdatedRegisterUserListing;

////////  17/03/2015/ ////

@property (strong, nonatomic) IBOutlet UIView *viewTransparent;
@property (strong, nonatomic) IBOutlet UIView *viewAlert;

- (IBAction)alertDone:(id)sender;
@property (strong, nonatomic) IBOutlet ADBannerView *adBanner;

////////  AD  ///////////
@end
