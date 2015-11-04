//
//  CalendarViewController.h
//  Social
//
//  Created by Sukhamoy Hazra on 22/08/13.
//
//

#import <UIKit/UIKit.h>


@class PlayerListViewController;
@interface CalendarViewController : TKCalendarMonthTableViewController<TKCalendarMonthViewDelegate>
@property (nonatomic,strong) NSString *selTeamId;
@property (nonatomic,strong) NSString *selplayerId;
@property (nonatomic,assign) int selShowByStatus;
@property (nonatomic,assign) BOOL isSelShowByStatus;
@property (nonatomic,strong) UIImage *privateDotImage;
@property (nonatomic,strong) UIImage *publicDotImage;
@property(nonatomic,strong)PlayerListViewController *playerAttendance;

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableDictionary *dataDictionary;
@property (nonatomic,strong) UIImage *crossImage;
@property (nonatomic,strong) UIImage *tickImage;
@property (nonatomic,strong) UIImage *questionmarkImage;
@property (strong, nonatomic) UIImage *maybeQuestionmarkImage;
- (void) generateRandomDataForStartDate:(NSDate*)start endDate:(NSDate*)end;
@end
