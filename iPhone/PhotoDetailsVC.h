//
//  PhotoDetailsVC.h
//  Wall
//
//  Created by Mindpace on 12/12/13.
//
//

#import "BaseVC.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIView+Toast.h"

@interface PhotoDetailsVC : BaseVC<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrlvw;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic,retain) NSString *imageUrl;

- (IBAction)saveBtnAction:(id)sender;
- (IBAction)closeaction:(id)sender;

- (IBAction)back:(id)sender;
@end
