//
//  PlayerListViewController.h
//  Wall
//
//  Created by Sukhamoy on 12/11/13.
//
//

#import <UIKit/UIKit.h>

@interface PlayerListViewController : BaseVC<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain) NSString *eventId;
@property(nonatomic,retain) NSString *teamId;

@property(nonatomic, strong) NSString *strTitle;  //// 16/01/15

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) UIImage *questionmarkimage;
@property (retain, nonatomic) UIImage *rightmarkimage;
@property (retain, nonatomic) UIImage *crossmarkimage;
@property (strong, nonatomic) UIImage *maybeQuestionmarkImage;
@property(nonatomic,retain) NSMutableArray *dataArray1;

@property(nonatomic,retain) NSMutableArray *dataArray;
@property (strong, nonatomic) IBOutlet UIView *viewMessage;

- (IBAction)back:(id)sender;





@property (strong, nonatomic) IBOutlet UISegmentedControl *segControl;

- (IBAction)segAction:(id)sender;



@property (strong, nonatomic) IBOutlet UIView *updivider;

@property (strong, nonatomic) IBOutlet UIView *noplayersvw;


@property (strong, nonatomic) IBOutlet UIView *sendbt;


- (IBAction)sendInviteAction:(id)sender;


-(void)teamPlayerList;


@end
