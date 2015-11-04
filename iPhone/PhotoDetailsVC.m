//
//  PhotoDetailsVC.m
//  Wall
//
//  Created by Mindpace on 12/12/13.
//
//
#import "CenterViewController.h"
#import "PhotoDetailsVC.h"
#import "UIImageView+AFNetworking.h"

@interface PhotoDetailsVC ()
{
    ALAssetsLibrary* libraryFolder,*library ;
    
    UIPinchGestureRecognizer *pinchgesture;

}

@end

@implementation PhotoDetailsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.imageView setImageWithURL:[NSURL URLWithString:self.imageUrl] placeholderImage:self.noAlbumImage];
    
   // self.topview.backgroundColor=appDelegate.barGrayColor;
  //  self.view.backgroundColor=appDelegate.backgroundPinkColor;

    
}


-(void)viewWillAppear:(BOOL)animated                    //pradip....july
{
    
    libraryFolder = [[ALAssetsLibrary alloc] init];
    
    library=[[ALAssetsLibrary alloc] init];
    
    self.scrlvw.delegate = self;
    
    pinchgesture=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handlePinch2:)];
    // doubleTapgesture.numberOfTapsRequired=2;
    
    [self.view addGestureRecognizer:pinchgesture];


}



- (void)handlePinch2:(UIPinchGestureRecognizer *)recognizer  //pradip.........july
{
    
    self.scrlvw.minimumZoomScale = 1.0;
    
    self.scrlvw.maximumZoomScale = 5.0;
    
}

#pragma mark- scrollvwDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView                   //pradip.........july
{
    return self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale     //pradip.........july
{
    //self.scrlvw.contentSize=_hiddenvw.frame.size;
    
    NSLog(@"zooming in/zooming out ended");
    
}

-(void)showNavigationBarButtons
{
    if(!self.leftBarButtonItem)
    {
        self.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backwhite.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleLeftPanel:)];
    }
    
    if(!self.rightBarButtonItem)
    {
        //self.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"eventfilter.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleRightPanel:)];
    }
    
    
    //appDelegate.centerViewController.navigationItem.title=nil;
    appDelegate.centerViewController.navigationItem.titleView=nil;
    
     appDelegate.centerViewController.navigationItem.title=@"Photo";
    // appDelegate.centerViewController.navigationItem.titleView=nil;
    
    appDelegate.centerViewController.navigationItem.leftBarButtonItem=self.leftBarButtonItem;
    
    appDelegate.centerViewController.navigationItem.rightBarButtonItem=self.rightBarButtonItem;
    
    
 //   [self setStatusBarStyleOwnApp:1];
    
}

-(void)toggleLeftPanel:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveBtnAction:(id)sender                          //pradip........july
{
    
    [libraryFolder addAssetsGroupAlbumWithName:@"Sportsly" resultBlock:^(ALAssetsGroup *group)           // CREATE CUSTOM ALBUM
     {
         NSLog(@"*****************Adding Folder:'Sportsly', success: %s", group.editable ? "Success" : "**********************Already created: Not Success");
         //        Handler(group,nil);
     } failureBlock:^(NSError *error)
     {
         NSLog(@"Error: Adding on Folder");
     }];
    
    
    void (^completion)(NSURL *, NSError *) = ^(NSURL *assetURL, NSError *error)
    {
        if (error)
        {
            NSLog(@"%s: Write the image data to the assets library (camera roll): %@",
                  __PRETTY_FUNCTION__, [error localizedDescription]);
        }
        
    };
    
    void (^failure)(NSError *) = ^(NSError *error)
    {
        if (error) NSLog(@"%s: Failed to add the asset to the custom photo album: %@",
                         __PRETTY_FUNCTION__, [error localizedDescription]);
    };
    
    
    
    
    [library saveImage:_imageView.image toAlbum:@"Sportsly" completion:completion failure:failure  ] ; //SAVE IMAGE TO CUSTOM ALBUM
    [self.view makeToast:@"Save" duration:3.0 position:CSToastPositionCenter];
    
    
    
}

- (IBAction)closeaction:(id)sender               //pradip......july
{
    //_imageView.hidden=YES;
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    self.scrlvw.zoomScale = 1.0;

    
}

- (IBAction)back:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    self.scrlvw.zoomScale=1.0;                    //pradip............july
    
}
@end
