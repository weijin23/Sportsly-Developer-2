//
//  SportViewController.h
//  Wall
//
//  Created by Sukhamoy on 11/12/13.
//
//

#import <UIKit/UIKit.h>
typedef void(^SlectesSports)(NSString *name);

@interface SportViewController : BaseVC
@property(nonatomic,assign) int selectedTag;
@property(nonatomic,copy)SlectesSports sportBlock;
@property(nonatomic,retain) NSMutableArray *sportArr;
@property(nonatomic,assign) int selectedIndex;
- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
