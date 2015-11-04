//
//  PrimaryMemeberViewController.h
//  Wall
//
//  Created by Sukhamoy on 11/04/14.
//
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"
@interface PrimaryMemeberViewController : BaseVC<UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UILabel *titleLbl;
@property(nonatomic,strong) NSMutableDictionary *playerDict;
@property(nonatomic) int selectedIndex;
@property(nonatomic) int count;
@property (strong, nonatomic) IBOutlet UITableView *tblVw;
@property (strong, nonatomic) IBOutlet UIView *noPrimaryVw;
@property (strong, nonatomic) IBOutlet UILabel *primaryLbl;
@property(nonatomic,retain) UIImage *commonImage;


-(void)setIntialized;
@end
