//
//  PhotoMainVC.m
//  Wall
//
//  Created by Sukhamoy Hazra on 26/09/13.
//
//

#import "PhotoVC.h"
#import "PhotoListVCTableCell.h"
#import "UIImageView+AFNetworking.h"
#import "AFHTTPClient.h"

@interface PhotoVC ()

@end

@implementation PhotoVC

@synthesize backToPhotoListBtn,pvc,selectedPhotoNo,photoCount,isEditEnabled,photoNameList,photoName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.pvc=[[PhotoListVC alloc] init];
    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden=YES;
    
    self.photoNameList=[[NSMutableArray alloc]init];
    //self.photoCount=arc4random()%25;//29;//say /// Assigned when entering this class
    //self.maxPhotoNo=photoCount;
    self.isEditEnabled=NO;
    
    photoNameList=[[NSMutableArray alloc] initWithCapacity:photoCount];
    
    self.navigationController.navigationBarHidden=YES;
    
    // ===================== To be removed when we get names from the server ===================
    for(int i=1;i<=photoCount;i++)
    {
        [self.photoNameList addObject:[NSString stringWithFormat:@"Photo%d",i]];
    }
    //==========================================================================================
    
    
    _carousel.type = iCarouselTypeLinear;
    _carousel.pagingEnabled = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
//    self.backToAlbumBtn.titleLabel.text=[self.pmvc.albumNameList objectAtIndex:self.selectedAlbumNo];
//    NSLog(@"Album Name :: %@",[self.pmvc.albumNameList objectAtIndex:self.selectedAlbumNo]);
    
//    self.photoName.text=[self.pvc.photoNameList objectAtIndex:self.selectedPhotoNo];
    
    
//    [self.photoVw setImageWithURL:[NSURL URLWithString:@"http://i.imgur.com/r4uwx.jpg"] placeholderImage:[UIImage imageNamed:@"placeholder-avatar"]];
    
//    if(self.isEditEnabled==YES)
//    {
//        self.editBtn.imageView.image=[UIImage imageNamed:@"Album button.png"];
//    }
//    else
//    {
//        self.editBtn.imageView.image=[UIImage imageNamed:@"button.png"];
//    }
}




#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return photoCount;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        view = [[UIView alloc] initWithFrame:self.carousel.bounds];
        
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set background color
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    view.backgroundColor = [UIColor colorWithRed:red
                                           green:green
                                            blue:blue
                                           alpha:1.0];
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
//    label.text = [photoNameList[index] stringValue];
    
    return view;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backToPhotoList:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//- (IBAction)previousPhoto:(id)sender {
//    [self.photoVw setImageWithURL:[NSURL URLWithString:@"http://i.imgur.com/r4uwx.jpg"] placeholderImage:[UIImage imageNamed:@"placeholder-avatar"]];
//}
//
//- (IBAction)nextPhoto:(id)sender {
//    [self.photoVw setImageWithURL:[NSURL URLWithString:@"http://i.imgur.com/r4uwx.jpg"] placeholderImage:[UIImage imageNamed:@"placeholder-avatar"]];
//}

//- (void)dealloc {
//    [backToPhotoListBtn release];
//    [photoName release];
//    [_carousel release];
//    [super dealloc];
//}

@end
