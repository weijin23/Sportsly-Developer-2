//
//  SpectatorViewController.h
//  Wall
//
//  Created by User on 11/06/15.
//
//

#import "BaseVC.h"

@class SelectContact; ///////   AD 16th June

@interface SpectatorViewController : BaseVC


@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentContr;
@property (strong, nonatomic) IBOutlet UIView *teamTrakerView;
@property (strong, nonatomic) IBOutlet UITableView *tableSpectator;
@property (strong, nonatomic) IBOutlet UIView *viewNoPlayer;
@property (strong, nonatomic) IBOutlet ADBannerView *adBanner;

@property(nonatomic,assign) int selectedTeamIndex;
@property (assign) BOOL admin;
@property (assign,nonatomic) int itemno;
@property int selectedSpectator;

@property(nonatomic,retain) UIImage *acceptdeImage;
@property(nonatomic,retain) UIImage *noResponeImage;
@property(nonatomic,retain) UIImage *declineImage;
@property (strong, nonatomic) IBOutlet UIView *popupAlertBck;
@property (strong, nonatomic) IBOutlet UIView *popupAlertVw;
@property (strong, nonatomic) IBOutlet UILabel *lblPopupCstm;
- (IBAction)popupTapped:(id)sender;

- (IBAction)segmentValueChange:(id)sender;
- (IBAction)addSpectators:(id)sender;

@end
