//
//  PhotoMainVC.h
//  Wall
//
//  Created by Sukhamoy Hazra on 26/09/13.
//
//

#import <UIKit/UIKit.h>
#import "PhotoMainVC.h"
#import "PhotoListVC.h"
#import "iCarousel.h"

@interface PhotoVC : UIViewController<iCarouselDataSource, iCarouselDelegate>
@property (retain,nonatomic) NSMutableArray *photoNameList;
@property (retain, nonatomic) IBOutlet UIButton *backToPhotoListBtn;

@property (retain, nonatomic) PhotoListVC *pvc;

@property BOOL isEditEnabled;
@property int selectedPhotoNo;
@property int photoCount;

//@property (retain, nonatomic) IBOutlet UIButton *backBtn;
@property (retain, nonatomic) IBOutlet UILabel *photoName;
//@property (retain, nonatomic) IBOutlet UIButton *forwardBtn;
//@property (retain, nonatomic) IBOutlet UIImageView *photoVw;
@property (retain, nonatomic) IBOutlet iCarousel *carousel;

- (IBAction)backToPhotoList:(id)sender;
//- (IBAction)previousPhoto:(id)sender;
//- (IBAction)nextPhoto:(id)sender;

@end
