//
//  TeamAdminVCViewController.h
//  Wall
//
//  Created by Sukhamoy on 12/04/14.
//
//

#import "BaseVC.h"

@interface TeamAdminVCViewController : BaseVC

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmnetCtrl;
@property(nonatomic) int selectedIndex;
@property(nonatomic) int count;
@property(nonatomic,assign) int selectedTeamIndex;
@property (weak, nonatomic) IBOutlet UITableView *tblVw;
@property (weak, nonatomic) IBOutlet UIButton *addAdminBtn;
@property (strong, nonatomic) IBOutlet UIView *viewMessage;  ///  23/7/14 //

@property(nonatomic,retain) UIImage *acceptdeImage;
@property(nonatomic,retain) UIImage *noResponeImage;

@property (assign) BOOL admin;

- (IBAction)addAdmin:(id)sender;
- (IBAction)segmentValueChange:(id)sender;
@end
