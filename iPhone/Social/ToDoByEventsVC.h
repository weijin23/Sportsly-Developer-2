//
//  ToDoByEventsVC.h
//  LinkBook
//
//  Created by Piyali on 06/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "EventCell.h"
@class EventCalendarViewController;


@interface ToDoByEventsVC : BaseVC  <UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate>
{
    UITableView *tabView;
    NSMutableArray *alldelarr;

}

@property (nonatomic,strong) NSDate *fetchFirstDate;
@property (nonatomic,strong) NSDate *fetchLastDate;
@property (nonatomic,weak) EventCalendarViewController *eventCalVC;
@property (nonatomic,strong) NSString *selTeamId;
@property (nonatomic,strong) NSString *selplayerId;
@property (nonatomic,assign) int selShowByStatus;
@property (nonatomic,assign) BOOL isSelShowByStatus;
@property (nonatomic,strong) NSDate *todayFDate;
@property (nonatomic,strong) NSIndexPath *todayIndexpath;
@property (nonatomic,strong) UIImage *privateDotImage;
@property (nonatomic,strong) UIImage *publicDotImage;
@property(nonatomic,strong) NSMutableArray *alldelarr;
@property(nonatomic,strong) IBOutlet UITableView *tabView;
@property(nonatomic,strong) UIColor *grayColor;
@property(nonatomic,strong) UIColor *dGrayColor;
@property(nonatomic,strong) UIFont *grayf;
@property(nonatomic,strong) UIFont *redf;

@property(nonatomic,assign) BOOL isAscendingDate;


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@property (strong, nonatomic) IBOutlet UILabel *noeventslab;

-(void)loadTable;


- (IBAction)topBarAction:(id)sender;


@property (strong, nonatomic) IBOutlet UILabel *noeventsfilterlab;
@property (strong, nonatomic) IBOutlet UILabel *lblPlus;

@property (strong, nonatomic) IBOutlet UIImageView *noeventsimagevw;
@property (nonatomic,strong) NSString *normalmsgnoevent;
@property (nonatomic,strong) NSString *adminmsgnoevent;


@property (strong, nonatomic) IBOutlet UIButton *allfilterbt;


- (IBAction)allFilterAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *viewMessage;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewMessage;

- (IBAction)addEvent:(id)sender;

-(void)manageViewMessage:(BOOL)animated;

@property (strong, nonatomic) IBOutlet ADBannerView *adBanner;
@end
