//
//  TeamEventsVC.h
//  Wall
//
//  Created by Mindpace on 12/02/14.
//
//

#import "BaseVC.h"

@interface TeamEventsVC : BaseVC  <UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *teamScroll;
@property (strong, nonatomic) IBOutlet UIImageView *redbackindicator;
@property (strong, nonatomic) IBOutlet UIImageView *rednextindicator;
@property (strong, nonatomic) IBOutlet UIImageView *redbackindicator1;

@property (strong, nonatomic) IBOutlet UIImageView *rednextindicator1;
@property (strong, nonatomic) IBOutlet UIView *scrollBackView;

@property (strong, nonatomic) UIButton *buttonfirstinscroll;
@property(nonatomic,strong)UINavigationController *teamNavController;
-(void)createEvent;
- (IBAction)firsttimesecondAction:(id)sender;
@end
