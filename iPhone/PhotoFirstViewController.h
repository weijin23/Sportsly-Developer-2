//
//  PhotoFirstViewController.h
//  Wall
//
//  Created by Mindpace on 03/03/14.
//
//

#import "BaseVC.h"

@interface PhotoFirstViewController : BaseVC
@property (strong, nonatomic) IBOutlet UIView *cutomView;
@property (strong, nonatomic) IBOutlet UIImageView *photoAlbumsImage;
@property (strong, nonatomic) IBOutlet UIImageView *videoAlbumImage;

@property(nonatomic,strong)NSArray * AllPhotos;
@property(nonatomic,strong)NSArray * AllVideos;

@property(nonatomic,strong)NSArray *AllPhotosArr;
@property(nonatomic,strong)NSArray *AllVideosArr;


@property(nonatomic,strong)NSMutableArray *userName;
@property(nonatomic,strong)NSMutableArray *TeamNameArr;

@property(nonatomic,strong)NSMutableArray *videoUserName;
@property(nonatomic,strong)NSMutableArray *videoTeamNameArr;

@property (nonatomic,strong) NSMutableArray *albumNameList;
@property (nonatomic,strong) NSMutableArray *videoNameList;

@property(nonatomic,retain)NSMutableArray *allVideosLink;


-(void)getUpdateData;
- (IBAction)videoAlbum:(id)sender;
- (IBAction)photoAlbum:(id)sender;

@end
