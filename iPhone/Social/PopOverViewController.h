//
//  PopOverViewController.h
//  Social
//
//  Created by Mindpace on 13/09/13.
//
//
#import "FPPopoverController.h"
#import <UIKit/UIKit.h>

@protocol PopOverViewControllerDelegate <NSObject>


-(void)didSelectString:(NSString*)msg :(NSString*)msg1 :(FPPopoverController*)popOverController;
@end


@interface PopOverViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSArray *dataArray;
@property(nonatomic,weak) id <PopOverViewControllerDelegate> delegate;
;
@property(nonatomic,strong) FPPopoverController* popOver;

@end
