//
//  ToDoByEventsVC.h
//  LinkBook
//
//  Created by Piyali on 06/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Invite.h"
@class FPPopoverController;
@class SelectContact;
@class PushByCoachUpdateCell;
@class AllHistoryCoachUpdateVC;
@protocol PushByCoachUpdateDelegate <NSObject>
-(void)didChangeNumberOfCoachUpdates:(NSString*)number;


-(void)didSelectCoachUpdates:(Invite*)newInvite :(FPPopoverController*)popOverController;


@end



@interface PushByCoachUpdateVC : BaseVC  <UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate>
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

@property(nonatomic,strong) SelectContact *selContactNew;

- (void)configureCell:(PushByCoachUpdateCell *)cell atIndexPath:(NSIndexPath *)indexPath;
-(void)setDataView;

@property(nonatomic,weak) id <PushByCoachUpdateDelegate> delegate;
;
@property(nonatomic,strong) FPPopoverController* popOver;


@property (weak, nonatomic) IBOutlet UILabel *nolbl;
@property(nonatomic,assign) BOOL isExistData;

@property(nonatomic,assign) BOOL loadStatus;

- (IBAction)topBarAction:(id)sender;

@property(nonatomic,strong) NSMutableArray *dataImages;
@property(nonatomic,strong) AllHistoryCoachUpdateVC *coachUpdateDetails;
@property(nonatomic,strong) NSIndexPath *lastSelIndexPath;
@property(nonatomic,assign) int lastSelStatus;

@property(nonatomic,assign) int lastSelRow;


/*@property(nonatomic,assign) int lastSelRow;
@property(nonatomic,assign) BOOL loadStatus;
-(void)reloadTableView;*/
@end
