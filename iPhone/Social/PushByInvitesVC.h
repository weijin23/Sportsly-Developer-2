//
//  ToDoByEventsVC.h
//  LinkBook
//
//  Created by Piyali on 06/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Invite.h"
//#import "EventPushCell.h"
#import "FPPopoverController.h"

@protocol PushListingInviteViewControllerDelegate <NSObject>

-(void)didSelectInvite:(Invite*)newInvite :(FPPopoverController*)popOverController;
-(void)didChangeNumberOfInvites:(NSString*)number;

@end



@interface PushByInvitesVC : BaseVC  <UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate>
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

@property(nonatomic,weak) id <PushListingInviteViewControllerDelegate> delegate;
;
@property(nonatomic,strong) FPPopoverController* popOver;


@property (weak, nonatomic) IBOutlet UILabel *nolbl;
@property(nonatomic,assign) BOOL isExistData;

@end
