//
//  ToDoByEventsVC.h
//  LinkBook
//
//  Created by Piyali on 06/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "EventPushCell.h"
#import "FPPopoverController.h"

@protocol PushListingViewControllerDelegate <NSObject>

-(void)didChangeNumberOfEvents:(NSString*)number;
-(void)didSelectEvent:(Event*)newEvent :(FPPopoverController*)popOverController;
@end



@interface PushByEventsVC1 : BaseVC  <UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate>
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
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
-(void)setDataView;
@property (weak, nonatomic) IBOutlet UILabel *nolbl;

@property(nonatomic,weak) id <PushListingViewControllerDelegate> delegate;
;
@property(nonatomic,strong) FPPopoverController* popOver;

@property(nonatomic,assign) BOOL isExistData;
@end
