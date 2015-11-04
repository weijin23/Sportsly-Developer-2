//
//  PhotoMainVC.h
//  Wall
//
//  Created by Sukhamoy Hazra on 26/09/13.
//
//

#import <UIKit/UIKit.h>
#import "PhotoMainVC.h"

@interface PhotoListVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (retain,nonatomic) NSMutableArray *photoNameList;
@property (retain, nonatomic) IBOutlet UIButton *backToAlbumBtn;
@property (retain, nonatomic) PhotoMainVC *pmvc;
@property BOOL isEditEnabled;
@property int selectedAlbumNo;
@property int photoCount,maxPhotoNo;
@property (retain, nonatomic) IBOutlet UITableView *tableVw;
@property (retain, nonatomic) IBOutlet UIButton *editBtn;
@property (retain, nonatomic) IBOutlet UILabel *albName;
@property (retain, nonatomic) IBOutlet UIButton *addBtn;
- (IBAction)backToAlbum:(id)sender;
-(void)viewPhoto:(UIButton *)sender;
-(void)deletePhoto:(UIButton *)sender;
- (IBAction)addPhoto:(id)sender ;
- (IBAction)albumNameTouch:(id)sender;
-(void)updateServerData;
@end
