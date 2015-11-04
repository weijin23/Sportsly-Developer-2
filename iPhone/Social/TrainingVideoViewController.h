//
//  TrainingVideoViewController.h
//  Wall
//
//  Created by Sukhamoy on 10/12/13.
//
//

#import <UIKit/UIKit.h>

@interface TrainingVideoViewController : BaseVC
@property (retain, nonatomic) IBOutlet UIButton *viewBtn;
@property (retain, nonatomic) IBOutlet UIButton *addBtn;
- (IBAction)showVideo:(id)sender;
- (IBAction)addVideo:(id)sender;

@end
