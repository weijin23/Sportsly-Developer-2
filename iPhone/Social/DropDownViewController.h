//
//  DropDownViewController.h
//  Wall
//
//  Created by Sukhamoy on 18/12/13.
//
//

#import <UIKit/UIKit.h>

typedef void(^updateSelectedIndex)(int upatedIndex,NSString *name);

@interface DropDownViewController : BaseVC

@property(nonatomic,retain) NSString *type;
@property (retain, nonatomic) IBOutlet UITextField *customTextField;
@property (strong, nonatomic) IBOutlet UIView *animatedView;
@property (retain, nonatomic) IBOutlet UILabel *titleLbl;
@property(nonatomic,retain)NSArray *tableDataArr;
@property(nonatomic,assign) int selectedIndex;
@property(nonatomic,copy)updateSelectedIndex updateBlock;
@property (retain, nonatomic) IBOutlet UITableView *modalTable;

- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;
@end
