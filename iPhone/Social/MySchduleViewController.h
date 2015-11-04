//
//  MySchduleViewController.h
//  Wall
//
//  Created by Sukhamoy on 28/11/13.
//
//

#import <UIKit/UIKit.h>

@interface MySchduleViewController : BaseVC

@property (nonatomic,retain) NSString *selTeamId;
@property (nonatomic,retain) NSDate *todayFDate;
@property (nonatomic,retain) NSIndexPath *todayIndexpath;
@property (nonatomic,retain) UIImage *privateDotImage;
@property (nonatomic,retain) UIImage *publicDotImage;
@property(nonatomic,retain) NSMutableArray *alldelarr;
@property(nonatomic,retain) UIColor *grayColor;
@property(nonatomic,retain) UIColor *dGrayColor;
@property(nonatomic,retain) UIFont *grayf;
@property(nonatomic,retain) UIFont *redf;


@property (retain, nonatomic) IBOutlet UITableView *rosterTable;

@property (retain, nonatomic) IBOutlet UIButton *showSettings;

- (IBAction)settingsbTapped:(id)sender;
-(void)updateEventList;
- (IBAction)back:(id)sender;


@end
