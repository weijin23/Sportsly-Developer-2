//
//  PostLikeViewController.h
//  Wall
//
//  Created by Sukhamoy on 26/12/13.
//
//

#import <UIKit/UIKit.h>

@interface PostLikeViewController : BaseVC

@property(nonatomic,strong) NSString *no_of_likesStr;
@property (strong, nonatomic) IBOutlet UITableView *postLikeTable;
@property(nonatomic,strong)NSString *postId;
@property(nonatomic,strong)NSMutableArray *postLikeArr;
- (IBAction)back:(id)sender;




@property (strong, nonatomic) IBOutlet UIView *nolikesvw;



@property (assign, nonatomic) long long int start;
@property (assign, nonatomic) long long int limit;
@property (assign, nonatomic) BOOL isFinishData;
@property (strong, nonatomic) IBOutlet UIView *wallfooterview;



@property (strong, nonatomic) IBOutlet UIImageView *wallfootervwgreydot;
-(void)showStatusBasisofNumber;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *wallfootervwactivind;
@end
