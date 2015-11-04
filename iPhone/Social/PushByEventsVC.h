//
//  ToDoByEventsVC.h
//  LinkBook
//
//  Created by Piyali on 06/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventUnread.h"
@class FPPopoverController;
@class Invite;
@class PushByEventsVCCell;
@protocol PushListingViewControllerDelegate <NSObject>

-(void)didChangeNumberOfEvents:(NSString*)number;
-(void)didSelectEvent:(Event*)newEvent :(FPPopoverController*)popOverController;
@end



@interface PushByEventsVC : BaseVC  <UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate>
{
    UITableView *tabView;
    NSMutableArray *alldelarr;

}
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

//@property(nonatomic,strong) SelectContact *selContactNew;

- (void)configureCell:(PushByEventsVCCell *)cell atIndexPath:(NSIndexPath *)indexPath;
-(void)setDataView;


@property(nonatomic,weak) id <PushListingViewControllerDelegate> delegate;
;
@property(nonatomic,strong) FPPopoverController* popOver;


@property (weak, nonatomic) IBOutlet UILabel *nolbl;
@property(nonatomic,assign) BOOL isExistData;

@property(nonatomic,assign) BOOL loadStatus;

- (IBAction)topBarAction:(id)sender;

@property(nonatomic,strong) NSMutableArray *dataImages;

@property(nonatomic,strong) NSIndexPath *lastSelIndexPath;
@property(nonatomic,assign) int lastSelStatus;



@property (strong, nonatomic) IBOutlet UIButton *plusbuttoninvitefriendbt;

@end
