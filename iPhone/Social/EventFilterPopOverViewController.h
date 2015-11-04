//
//  PopOverViewController.h
//  Social
//
//  Created by Mindpace on 13/09/13.
//
//
#import "FPPopoverController.h"
#import <UIKit/UIKit.h>

@protocol EventFilterPopOverViewControllerDelegate <NSObject>


-(void)didSelectFilterAction:(int)filterNum :(FPPopoverController*)popOverController;
@end


@interface EventFilterPopOverViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSArray *dataArray;
@property(nonatomic,weak) id <EventFilterPopOverViewControllerDelegate> delegate;
;
@property(nonatomic,strong) FPPopoverController* popOver;

- (IBAction)tapAction:(id)sender;


@property (strong, nonatomic) IBOutlet UILabel *datelab;

@property (strong, nonatomic) IBOutlet UILabel *teamandeventlab;

@property (strong, nonatomic) IBOutlet UILabel *playerlab;

@property (strong, nonatomic) IBOutlet UILabel *statuslab;


@end
