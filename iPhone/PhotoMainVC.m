//
//  PhotoMainVC.m
//  Wall
//
//  Created by Sukhamoy Hazra on 26/09/13.
//
//
#import "CenterViewController.h"
#import "PhotoMainVC.h"
#import "PhotoMainVCTableCell.h"
#import "UIButton+AFNetworking.h"
#import "AFHTTPClient.h"
#import "PhotoDetailsVC.h"
#import "SportViewController.h"
#import <MessageUI/MFMailComposeViewController.h>
#import <Social/Social.h>


@interface PhotoMainVC ()

@end

@implementation PhotoMainVC

@synthesize tableVw,isEditEnabled,albumNameList,editBtn,addBtn,currtf,currcell,teamIds,selectedImageDict,documentInteractionController;
@synthesize isTeam,isDate,isName,TeamNameArr,userName,isPostPhotos,allVideosLink;
@synthesize customRedColor,isAscendingDate,selDate,noAlbum,selVideoPath;
UILongPressGestureRecognizer *longPress;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)dealloc
{
      [[NSNotificationCenter defaultCenter] removeObserver:self name:SHOWNAVIGATIONCONTROLLERPHOTOALBUM object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.isiPad) {
        NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:20], UITextAttributeFont, nil];
        [self.segmentcontrl setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    }
    
    self.custompopuptopselectionvw.backgroundColor=appDelegate.themeCyanColor;
    isAscendingDate=0;
    self.isPostPhotos=YES;
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNavigationControllerUpdated:) name:SHOWNAVIGATIONCONTROLLERPHOTOALBUM object:nil];
    
   // [self chSegAction:self.segmentcontrl];
    self.navigationController.delegate=self;
    
    //self.topview.backgroundColor=appDelegate.barGrayColor;
   // self.view.backgroundColor=appDelegate.backgroundPinkColor;
    
    self.filterView.backgroundColor=appDelegate.barGrayColor;
    self.shareView.backgroundColor=appDelegate.barGrayColor;
    self.sharevwmain.backgroundColor=appDelegate.barGrayColor;
    
    storeCreatedRequests=[[NSMutableArray alloc] init];
    isEditEnabled=NO;
    self.printView.hidden=YES;
    self.printView.layer.cornerRadius=3.0f;
    [self.printView.layer setMasksToBounds:YES];

    self.dateImageView.image=self.imageDtae;
    self.playerImageView.image=self.playerImage;
    self.changeImage.image=self.videoImage;
    
    [self.nodatavw setHidden:YES];
    
    self.pickerContainerView.hidden=YES;
    self.customRedColor=[UIColor colorWithRed:190.0/255.0 green:0.0/255.0 blue:2.0/255.0 alpha:1.0f];
    
    
    @autoreleasepool
    {
        self.teamGrayImage=[UIImage imageNamed:@"team_deselected.png"];
        self.teamRedImage=[UIImage imageNamed:@"team_selected.png"];
        self.dateGrayImage=[UIImage imageNamed:@"dategrey.png"];
        self.dateRedImage=[UIImage imageNamed:@"date.png"];
        self.playergrayImage=[UIImage imageNamed:@"player_deselected.png"];
        self.playerRedImage=[UIImage imageNamed:@"player_selected.png"];
        
        if (self.isiPad) {
            self.helveticaFontForteBold=[UIFont fontWithName:@"Helvetica-Bold" size:18.0];
            self.helveticaFont=[UIFont fontWithName:@"Helvetica" size:16.0];
            self.noAlbum=[UIImage imageNamed:@"defaultalbum_ipad.png"];
        }
        else{
            self.helveticaFontForteBold=[UIFont fontWithName:@"Helvetica-Bold" size:12.0];
            self.helveticaFont=[UIFont fontWithName:@"Helvetica" size:10.0];
            self.noAlbum=[UIImage imageNamed:@"defaultalbum.png"];
        }
    }
    
    
   // [self allPhotos:nil];
    //[self RefreshList:nil];
}

- (void)showAlertViewCustom:(int)noOfPhotos
{
    
    if(self.isPostPhotos)
    {
        if(noOfPhotos == 1)
        {
            self.popupalertlab.text = @"Picture has been posted on Facebook";
        }
        else
        {
            self.popupalertlab.text = @"Pictures have been posted on Facebook";
        }
        
    }
    else
    {
        self.popupalertlab.text=@"Video has been posted on Facebook";
    }
    
    self.popupalertvw.hidden=NO;
    self.popupalertvwback.hidden=NO;
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SHOWNAVIGATIONCONTROLLERPHOTOALBUM object:nil];
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated;
{
    
}


-(void)showNavigationControllerUpdated:(id)sender
{
    
    
    if(self.navigationController.view.hidden==NO)//[appDelegate.centerViewController getShowStatus:self.navigationController])
    {
        if([[self.navigationController.viewControllers lastObject] isMemberOfClass:[self class]])
        {
            [self showNavigationBarButtons];
            //[self setTopBarText];
            
        }
        else
        {
            [[self.navigationController.viewControllers lastObject] showNavigationBarButtons];
        }
    }
    
    
}

-(void)setTopBarText
{
    if(self.navigationController.view.hidden==NO)//([appDelegate.centerViewController getShowStatus:self.navigationController])
    {
        if([[self.navigationController.viewControllers lastObject] isMemberOfClass:[self class]])
        {
            appDelegate.centerViewController.navigationItem.title=nil;
            appDelegate.centerViewController.navigationItem.titleView=nil;
            
            if(isPostPhotos)
            appDelegate.centerViewController.navigationItem.title=@"Team Photos";
            else
            appDelegate.centerViewController.navigationItem.title=@"Team Photos";
        }
    }
}

-(void)setRightBarButtonItemText:(NSString*)str
{
    if(self.navigationController.view.hidden==NO)//([appDelegate.centerViewController getShowStatus:self.navigationController])
    {
        if([[self.navigationController.viewControllers lastObject] isMemberOfClass:[self class]])
        {
             [self.rightBarButtonItem setTitle:str];
        }
    }
}

-(void)showNavigationBarButtons
{
    
    if(!self.leftBarButtonItem)
    {
        self.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"eventfilter.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleLeftPanel:)];
    }
    
    if(!self.rightBarButtonItem)
    {
        self.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"Select" style:UIBarButtonItemStylePlain target:self action:@selector(toggleRightPanel:)];
    }
    
    
    appDelegate.centerViewController.navigationItem.title=nil;
    appDelegate.centerViewController.navigationItem.titleView=nil;
    appDelegate.centerViewController.leftBarButtonItem=nil;
    appDelegate.centerViewController.rightBarButtonItem=nil;
    //appDelegate.centerViewController.navigationItem.title=nil;
    // appDelegate.centerViewController.navigationItem.titleView=nil;
    
    [self setLeftBarButton:1];
    
    
    
    
    [self setNoDataView];
    
}


-(void)setRightBarButton:(BOOL)isShow
{
    
    if(self.navigationController.view.hidden==NO)
    {
        if([[self.navigationController.viewControllers lastObject] isMemberOfClass:[self class]])
        {
           
            if(isShow)
                appDelegate.centerViewController.navigationItem.rightBarButtonItem=self.rightBarButtonItem;
            else
                appDelegate.centerViewController.navigationItem.rightBarButtonItem=nil;
            
        }
    }
}


-(void)setLeftBarButton:(BOOL)isShow
{
    
    if(self.navigationController.view.hidden==NO)
    {
        if([[self.navigationController.viewControllers lastObject] isMemberOfClass:[self class]])
        {
           
            if(isShow)
                appDelegate.centerViewController.navigationItem.leftBarButtonItem=self.leftBarButtonItem;
            else
                appDelegate.centerViewController.navigationItem.leftBarButtonItem=nil;
        }
    }
}

-(void)toggleLeftPanel:(id)sender
{
    if(self.custompopupbottomvw.hidden==YES && self.custompopuptopselectionvw.hidden==YES)
    {
        self.custompopupbottomvw.hidden=NO;
        self.custompopuptopselectionvw.hidden=NO;
        
        [self.view bringSubviewToFront:self.custompopupbottomvw];
        [self.view bringSubviewToFront:self.custompopuptopselectionvw];
        
        self.datePickerview.hidden=YES;
        self.pickerContainerView.hidden=YES;
       // self.top.hidden=YES;
    }
    else
    {
        self.custompopupbottomvw.hidden=YES;
        self.custompopuptopselectionvw.hidden=YES;
    }
    
    
}


-(void)toggleRightPanel:(id)sender
{
    if(self.custompopupbottomvw.hidden==NO && self.custompopuptopselectionvw.hidden==NO)
    {
        return;
    }
    
    
    
    if (isPostPhotos){
        
        if ([self.rightBarButtonItem.title  isEqualToString:@"Select"]) {
            
            [self setRightBarButtonItemText:@"Cancel"];
            isEditEnabled=YES;
            self.selectedImageDict=[[NSMutableDictionary alloc] init];
             self.selVideoPath=nil;
            self.printView.hidden=NO;
            //self.allPhotoBtn.hidden=YES;
            self.filterView.hidden=YES;
            
        }else{
            [self setRightBarButtonItemText:@"Select"];
            isEditEnabled=NO;
            self.selectedImageDict=nil;
            self.selVideoPath=nil;
            self.printView.hidden=YES;
            self.shareView.hidden=YES;
            self.sharevwmain.hidden=YES;
            self.allPhotoBtn.hidden=NO;
            self.filterView.hidden=NO;
            
            [self.tableVw reloadData];
            
        }
        
    }
    else
    {
        
        if ([self.rightBarButtonItem.title  isEqualToString:@"Select"]) {
            
            [self setRightBarButtonItemText:@"Cancel"];
            isEditEnabled=YES;
            self.selectedImageDict=[[NSMutableDictionary alloc] init];
             self.selVideoPath=nil;
            self.printView.hidden=NO;
            //self.allPhotoBtn.hidden=YES;
            self.filterView.hidden=YES;
            
        }else{
            [self setRightBarButtonItemText:@"Select"];
            isEditEnabled=NO;
            self.selectedImageDict=nil;
            self.selVideoPath=nil;
            self.printView.hidden=YES;
            self.shareView.hidden=YES;
            self.sharevwmain.hidden=YES;
            self.allPhotoBtn.hidden=NO;
            self.filterView.hidden=NO;
            
            [self.tableVw reloadData];
            
        }
        
    }
    
    
    
    
    
}




//////////////////////////////////////////////From PhotoFirstViewController
- (IBAction)chSegAction:(id)sender
{
    
    UISegmentedControl *sg=(UISegmentedControl*)sender;
    
   // PhotoMainVC *mainVc=[[PhotoMainVC alloc] initWithNibName:@"PhotoMainVC" bundle:nil];
    if(sg.selectedSegmentIndex==0)
    {
        self.isPostPhotos=YES;
        /*self.AllPhotos=self.AllPhotos;
        self.AllPhotosArr=self.AllPhotosArr;
        self.userName=self.userName;
        self.TeamNameArr=self.TeamNameArr;
        self.albumNameList=self.albumNameList;*/
        
        [self.tableVw reloadData];
        
        [self setNoDataView];
        
        
        
        
        if(!self.AllPhotos.count)
        {
            
            [self setLeftBarButton:0];
        }
        else
        {
            [self setLeftBarButton:1];
        }
        
       
    }
    else
    {
   // [self.navigationController pushViewController:mainVc animated:YES];
    
    
  //  PhotoMainVC *mainVc=[[PhotoMainVC alloc] initWithNibName:@"PhotoMainVC" bundle:nil];
  
        
        self.isPostPhotos=NO;
        /*self.AllVideos=self.AllVideos;
        self.AllVideosArr=self.AllVideosArr;
        self.userName=self.userName;
        self.TeamNameArr=self.TeamNameArr;
        self.videoNameList=self.videoNameList;
        self.allVideosLink=self.allVideosLink;*/
        
        
        [self.tableVw reloadData];
        
        [self setNoDataView];
        
        [self setRightBarButtonItemText:@"Select"];
        isEditEnabled=NO;
        self.selectedImageDict=nil;
        self.selVideoPath=nil;
        self.printView.hidden=YES;
        self.shareView.hidden=YES;
        self.sharevwmain.hidden=YES;
        self.allPhotoBtn.hidden=NO;
        self.filterView.hidden=NO;
        
        
        
        if(!self.AllVideos.count)
        {
            [self setLeftBarButton:0];
            
        }
        else
        {
             [self setLeftBarButton:1];
        }
    }
   // [self.navigationController pushViewController:mainVc animated:YES];
    
    
    
   
}

-(void)getUpdateData
{
    [self sendRequestForPhotoAlbums];
    [self sendRequestForVideoAlbums];
}

-(void)sendRequestForVideoAlbums{
    
    NSMutableDictionary *command = [[NSMutableDictionary alloc] init];
    [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
    [command setObject:@"0" forKey:@"start"];
    [command setObject:@"1000" forKey:@"limit"];
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    NSString *jsonCommand = [writer stringWithObject:command];
    NSDictionary *dic= [NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil];
    
    [self showNativeHudView];
    NSURL* url =nil;
    
    url= [NSURL URLWithString:VIDEOALBUMSLINK];
    
    
    ASIFormDataRequest *aRequest=  [[ASIFormDataRequest alloc] initWithURL:url] ;
    self.myFormRequest1=aRequest;
    [self.storeCreatedRequests addObject:self.myFormRequest1];
    
    
    [aRequest setShouldContinueWhenAppEntersBackground:YES];
    
    [aRequest setDelegate:self];
    
    [aRequest setValidatesSecureCertificate:NO];
    [ASIFormDataRequest setShouldThrottleBandwidthForWWAN:YES];
    
    
    if([[dic allKeys] count]>0)
    {
        
        
        for(int i=0;i<[[dic allKeys] count];i++)
        {
            // NSLog(@"RequestParam=%@",[[dic allKeys] objectAtIndex:i]);
            
            if([[dic objectForKey:[[dic allKeys] objectAtIndex:i]] isKindOfClass:[NSData class]])
            {
                [aRequest setPostFormat:ASIMultipartFormDataPostFormat];
                [aRequest addRequestHeader:@"Content-Type" value:@"multipart/form-data"];
                
                
                if([[[dic allKeys] objectAtIndex:i] isEqualToString:@"video"])
                {
                    [aRequest addData:[dic objectForKey:[[dic allKeys] objectAtIndex:i]] withFileName:@"user" andContentType:@"video/*" forKey:[[dic allKeys] objectAtIndex:i]];
                }
                else
                {
                    [aRequest addData:[dic objectForKey:[[dic allKeys] objectAtIndex:i]] withFileName:@"user.jpg" andContentType:@"image/*" forKey:[[dic allKeys] objectAtIndex:i]];
                    
                }
            }
            else
            {
                NSLog(@"RequestParam=%@ and Key=%@",[dic objectForKey:[[dic allKeys] objectAtIndex:i]],[[dic allKeys] objectAtIndex:i]);
                [aRequest addPostValue:[dic objectForKey:[[dic allKeys] objectAtIndex:i]] forKey:[[dic allKeys] objectAtIndex:i]];
                
                
                
            }
            
        }
        
        
    }
    [aRequest setDidFinishSelector:@selector(requestFinishedVideo:)];
    [aRequest setDidFailSelector:@selector(requestFailedVideo:)];
    
    [aRequest startAsynchronous];
    
}


-(void)sendRequestForPhotoAlbums
{
    
    NSMutableDictionary *command = [[NSMutableDictionary alloc] init];
    [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
    [command setObject:@"0" forKey:@"start"];
    [command setObject:@"1000" forKey:@"limit"];
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    NSDictionary *dic= [NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil];
    
    [self showNativeHudView];
    NSURL* url =nil;
    
    url= [NSURL URLWithString:PHOTOALBUMSLINK];
    
    
    
    ASIFormDataRequest *aRequest=  [[ASIFormDataRequest alloc] initWithURL:url] ;
    self.myFormRequest1=aRequest;
    [self.storeCreatedRequests addObject:self.myFormRequest1];
    
    
    [aRequest setShouldContinueWhenAppEntersBackground:YES];
    
    [aRequest setDelegate:self];
    
    [aRequest setValidatesSecureCertificate:NO];
    [ASIFormDataRequest setShouldThrottleBandwidthForWWAN:YES];
    
    
    if([[dic allKeys] count]>0)
    {
        
        
        for(int i=0;i<[[dic allKeys] count];i++)
        {
            // NSLog(@"RequestParam=%@",[[dic allKeys] objectAtIndex:i]);
            
            if([[dic objectForKey:[[dic allKeys] objectAtIndex:i]] isKindOfClass:[NSData class]])
            {
                [aRequest setPostFormat:ASIMultipartFormDataPostFormat];
                [aRequest addRequestHeader:@"Content-Type" value:@"multipart/form-data"];
                
                
                if([[[dic allKeys] objectAtIndex:i] isEqualToString:@"video"])
                {
                    [aRequest addData:[dic objectForKey:[[dic allKeys] objectAtIndex:i]] withFileName:@"user" andContentType:@"video/*" forKey:[[dic allKeys] objectAtIndex:i]];
                }
                else
                {
                    [aRequest addData:[dic objectForKey:[[dic allKeys] objectAtIndex:i]] withFileName:@"user.jpg" andContentType:@"image/*" forKey:[[dic allKeys] objectAtIndex:i]];
                    
                }
            }
            else
            {
                NSLog(@"RequestParam=%@ and Key=%@",[dic objectForKey:[[dic allKeys] objectAtIndex:i]],[[dic allKeys] objectAtIndex:i]);
                [aRequest addPostValue:[dic objectForKey:[[dic allKeys] objectAtIndex:i]] forKey:[[dic allKeys] objectAtIndex:i]];
                
                
                
            }
            
        }
        
        
    }
    [aRequest setDidFinishSelector:@selector(requestFinished:)];
    [aRequest setDidFailSelector:@selector(requestFailed:)];
    
    [aRequest startAsynchronous];
    
}


- (void)requestFinished:(ASIHTTPRequest *)request
{
    @autoreleasepool {
        
        NSLog(@"Data Received in Connection Manager.... %@ ",[request responseString]);
        
        
        self.AllPhotos=nil;
        self.AllPhotosArr=nil;
        
        
        
        
       
        self.albumNameList=nil;
        
        self.TeamNameArr=nil ;
        self.userName=nil ;
        
         [self.tableVw reloadData];
        
        NSString *str=[request responseString];
        
        NSLog(@"Data=%@",str);
        [self hideNativeHudView];
        [self setLeftBarButton:0];
        
        if (str)
        {
            SBJsonParser *parser=[[SBJsonParser alloc] init];
            
            id res = [parser objectWithString:str];
            
            if ([res isKindOfClass:[NSDictionary class]])
            {
                NSDictionary* aDict = (NSDictionary*) res;
                
                if([[NSString stringWithFormat:@"%@",[[aDict objectForKey:@"status"] objectForKey:@"status"]] isEqualToString:@"1"])
                {
                    
                    
                    aDict=[aDict objectForKey:@"response"];
                    
                    
                    self.AllPhotos=[[aDict objectForKey:@"post_details"] mutableCopy];
                    self.AllPhotosArr=self.AllPhotos;
                    
                    
                  
                    
                    NSLog(@"alll Post Photos %@",self.AllPhotos);
                    NSMutableArray *s=[[NSMutableArray alloc] init];
                    self.albumNameList=s;
                    
                    self.TeamNameArr=[[NSMutableArray alloc] init] ;
                    self.userName=[[NSMutableArray alloc] init] ;
                    
                    for (NSMutableDictionary *d in  self.AllPhotos)
                    {
                        @autoreleasepool {
                            
                        
                        
                       NSDate *dd= [appDelegate.dateFormatFullOriginalComment dateFromString:[d objectForKey:@"adddate"]];
                            [d setObject:dd forKey:@"adddate"];
                            
                             NSLog(@"all Post Photos Dic=%@",d);
                        
                        NSString *image=  [d objectForKey:@"image"];
                        
                        if(![image isEqualToString:@""])
                        {
                            NSString *str=[[NSString alloc] initWithFormat:@"%@%@",POSTIMAGELINKTHUMB,image];
                            [self.albumNameList addObject:str];
                        }
                        
                        if (![self.userName containsObject:[d valueForKey:@"Name"]]) {
                            [self.userName addObject:[d valueForKey:@"Name"]];
                        }
                        if (![self.TeamNameArr containsObject:[d valueForKey:@"team_name"]]) {
                            [self.TeamNameArr addObject:[d valueForKey:@"team_name"]];
                        }
                        }
                    }
                    
                    NSArray *sortedArray = [self.TeamNameArr sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
                    NSArray *sortedArray1 = [self.userName sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
                    self.TeamNameArr=[sortedArray mutableCopy];
                    self.userName=[sortedArray1 mutableCopy];
                    
                    [self.TeamNameArr addObject:@"All Teams"];
                    [self.userName addObject:@"All Player"];
                   // [self.photoAlbumsImage setImageWithURL:[NSURL URLWithString:[self.albumNameList objectAtIndex:0]] placeholderImage:self.noAlbumImage];//Replace in FirstViewController
                    if(self.AllPhotosArr.count>0)
                    {
                       // [self chSegAction:self.segmentcontrl];
                        [self setLeftBarButton:1];
                        [self.tableVw reloadData];
                    }
                    else
                    {
                        
                    }
                }
                else
                {
                    
                }
            }
        }
        
        
	}
    
    self.segmentcontrl.selectedSegmentIndex=0;
    
    [self setNoDataView];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [self hideNativeHudView];
	//[self showAlertMessage:CONNFAILMSG];ChAfter
    self.AllPhotos=nil;
    self.AllPhotosArr=nil;
    
    
    
    
    
    self.albumNameList=nil;
    
    self.TeamNameArr=nil ;
    self.userName=nil ;
    
    [self.tableVw reloadData];
    [self setLeftBarButton:0];
    self.segmentcontrl.selectedSegmentIndex=0;
    [self setNoDataView];
	
}


- (void)requestFinishedVideo:(ASIHTTPRequest *)request
{
    @autoreleasepool {
        
        NSLog(@"Data Received in Connection Manager.... %@ ",[request responseString]);
        self.AllVideos=nil;
        self.AllVideosArr=nil;
        self.videoNameList=nil;
        self.TeamNameArr=nil;
        self.userName=nil;
        self.allVideosLink=nil;
        
        [self.tableVw reloadData];
        NSString *str=[request responseString];
        
        NSLog(@"Data=%@",str);
        [self hideNativeHudView];
         [self setLeftBarButton:0];
        
        if (str)
        {
            SBJsonParser *parser=[[SBJsonParser alloc] init];
            
            id res = [parser objectWithString:str];
            
            if ([res isKindOfClass:[NSDictionary class]])
            {
                NSDictionary* aDict = (NSDictionary*) res;
                
                if([[NSString stringWithFormat:@"%@",[[aDict objectForKey:@"status"] objectForKey:@"status"]] isEqualToString:@"1"])
                {
                    
                    
                    aDict=[aDict objectForKey:@"response"];
                    
                    
                    
                    
                    self.AllVideos=[[aDict objectForKey:@"post_details"] mutableCopy];
                    self.AllVideosArr=self.AllVideos;
                    NSLog(@"all post Videos %@",self.AllVideos);
                    
                  
                    
                    
                    NSMutableArray *s=[[NSMutableArray alloc] init];
                    self.videoNameList=s;
                    
                    self.TeamNameArr=[[NSMutableArray alloc] init] ;
                    self.userName=[[NSMutableArray alloc] init] ;
                    
                    self.allVideosLink=[[NSMutableArray alloc] init] ;
                    
                    for (NSMutableDictionary *d in  self.AllVideos)
                    {
                        @autoreleasepool {
                            
                        
                        
                        NSDate *dd= [appDelegate.dateFormatFullOriginalComment dateFromString:[d objectForKey:@"adddate"]];
                        [d setObject:dd forKey:@"adddate"];
                        
                        
                        
                        NSString *image=  [d objectForKey:@"video_thumb"];
                        
                        if(![image isEqualToString:@""])
                        {
                            NSString *str=[[NSString alloc] initWithFormat:@"%@%@",POSTVIDEOIMAGELINK,image];
                            [self.videoNameList addObject:str];
                        }
                        NSString *videoLink=[[NSString alloc] initWithFormat:@"%@%@",VIDEOLINK,[d objectForKey:@"video"]];
                        [self.allVideosLink addObject:videoLink];
                        
                        if (![self.userName containsObject:[d valueForKey:@"Name"]]) {
                            [self.userName addObject:[d valueForKey:@"Name"]];
                        }
                        if (![self.TeamNameArr containsObject:[d valueForKey:@"team_name"]]) {
                            [self.TeamNameArr addObject:[d valueForKey:@"team_name"]];
                        }
                        }
                    }
                    
                   NSArray *sortedArray = [self.TeamNameArr sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
                    NSArray *sortedArray1 = [self.userName sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
                    self.TeamNameArr=[sortedArray mutableCopy];
                    self.userName=[sortedArray1 mutableCopy];
                    
                    [self.TeamNameArr addObject:@"All Teams"];
                    [self.userName addObject:@"All Player"];
                    
                    
                    
                    
                    
                   // [self.videoAlbumImage setImageWithURL:[NSURL URLWithString:[self.videoNameList objectAtIndex:0]] placeholderImage:self.noAlbumImage];//Replace in FirstViewController
                    if(self.AllVideosArr.count>0)
                    {
                         [self setLeftBarButton:1];
                         [self.tableVw reloadData];
                    }
                    else
                    {
                        
                    }
                    
                }
                else
                {
                    
                }
            }
        }
        
        
	}
    

     [self setNoDataView];
}


- (void)requestFailedVideo:(ASIHTTPRequest *)request
{
    [self hideNativeHudView];
	//[self showAlertMessage:CONNFAILMSG];ChAfter
    self.AllVideos=nil;
    self.AllVideosArr=nil;
    self.videoNameList=nil;
    self.TeamNameArr=nil;
    self.userName=nil;
    self.allVideosLink=nil;
    
    [self.tableVw reloadData];
    [self setLeftBarButton:0];
    [self setNoDataView];
}


//////////////////////////////////////////////

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionStateOpen:) name:SESSIONSTATEOPEN object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionStateOpenExtended:) name:SESSIONSTATEOPENEXTENDED object:nil];
 
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SESSIONSTATEOPEN object:nil];
       [[NSNotificationCenter defaultCenter] removeObserver:self name:SESSIONSTATEOPENEXTENDED object:nil];
    
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)viewDidUnload {
    [self setMsgLabel:nil];
    [self setChangeLbl:nil];
    [self setChangeImage:nil];
    [self setPickerContainerView:nil];
    [self setPicker:nil];
    [self setTeamlbl:nil];
    [self setDateLbl:nil];
    [self setPlayerLbl:nil];
    [self setAllPhotoBtn:nil];
    [self setSharevwmain:nil];
    [super viewDidUnload];
}


#pragma mark - GetAll PostPhotos && Videos

-(void)setNoDataView
{
    BOOL m;
    
    
    if (isPostPhotos){
        
        if(self.AllPhotos.count){
            
            self.nodatavw.hidden=YES;
            self.tableVw.hidden=NO;
            m=1;
        }else{
            self.nodatavw.hidden=NO;
            self.nodataimgvw.image=self.noAlbum;
            self.msgLabel.text=@"You currently have no photos.\nPhotos will appear here from all your Timelines.";//@"View photos posted on Team Walls";
              self.tableVw.hidden=YES;
            m=0;
        }
        
        [self setTopBarText];
      
        [self setRightBarButton:m];
        
        //[self setLeftBarButton:m];
        
    }else{
        
        if(self.AllVideos.count)
        {
            
            self.nodatavw.hidden=YES;
            self.tableVw.hidden=NO;
            m=1;
            
        }
        else
        {
            
            self.nodatavw.hidden=NO;
            self.nodataimgvw.image=self.noAlbum;
            self.msgLabel.text=@"You currently have no videos";//@"View videos posted on Team Walls";
            self.tableVw.hidden=YES;
            m=0;
        }
        
        
          [self setTopBarText];
       
          [self setRightBarButton:m];
        
        //  [self setLeftBarButton:m];
        
        
    }

}

- (IBAction)RefreshList:(id)sender {
    
    [self.teamlbl setFont:[UIFont fontWithName:@"Helvetica" size:10.0f]];
    [self.playerLbl setFont:[UIFont fontWithName:@"Helvetica" size:10.0f]];
    [self.dateLbl setFont:[UIFont fontWithName:@"Helvetica" size:10.0f]];
    self.playerLbl.textColor=[UIColor lightGrayColor];
    self.teamlbl.textColor=[UIColor lightGrayColor];
    self.dateLbl.textColor=[UIColor lightGrayColor];
    
    if (isPostPhotos){
        
        if(self.AllPhotos.count){
            
            self.msgLabel.hidden=YES;
          

        }else{
            self.msgLabel.hidden=NO;
            self.msgLabel.text=@"View photos posted on Team Walls";
        }
        
        self.titleLbl.text=@"Photos";
        self.changeImage.image=self.photoImage;
        self.changeLbl.text=@"Image";
        self.selectBtn.hidden=NO;
        
    }else{
        
        if(self.AllVideos.count){
            
            self.msgLabel.hidden=YES;
            
        }else{
            
            self.msgLabel.hidden=NO;
            self.msgLabel.text=@"View videos posted on Team Walls";

        }

        
        self.titleLbl.text=@"Videos";
        self.changeImage.image=self.videoImage;
        self.changeLbl.text=@"Video";
        self.selectBtn.hidden=YES;
        

    }
    
   
}

- (IBAction)printPhoto:(id)sender {
    
    NSMutableArray *printPhotoImage=[[NSMutableArray alloc] init];
    
    for (int i=0;i<[[self.selectedImageDict allKeys] count] ; i++) {
        
        if ([[self.selectedImageDict valueForKey:[[self.selectedImageDict allKeys] objectAtIndex:i]] integerValue]) {
            
            NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.albumNameList objectAtIndex:[[[self.selectedImageDict allKeys] objectAtIndex:i] integerValue]]]];
            [printPhotoImage addObject:imageData];
        }
    }
    
    if ([printPhotoImage count]>0) {
        
        
        UIPrintInteractionController *printController = [UIPrintInteractionController sharedPrintController];
        
        if(printController && [UIPrintInteractionController canPrintData:[printPhotoImage objectAtIndex:0]]) {
            
            printController.delegate = self;
            
            UIPrintInfo *printInfo = [UIPrintInfo printInfo];
            printInfo.outputType = UIPrintInfoOutputGeneral;
            printInfo.jobName = @"Sportsly";
            printInfo.duplex = UIPrintInfoDuplexLongEdge;
            printController.printInfo = printInfo;
            printController.showsPageRange = YES;
            printController.printingItems = printPhotoImage;
            
            void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) = ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
                
                if (completed ) {
                    
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Print Success" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
                    [alert show];
                    
                }else{
                    
                    NSLog(@"FAILED! due to error in domain %@ with error code %u", error.domain, error.code);
                    
                    
                }
            };
            
            [printController presentAnimated:YES completionHandler:completionHandler];
            
        }
        
        
    }else{
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Please select a photo" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
        [alert show];
    }
    
    
}




- (IBAction)sharephoto:(id)sender {
    
    if(self.isPostPhotos)
    {
    NSMutableArray *sharePhotoImage=[[NSMutableArray alloc] init];
    
    for (int i=0;i<[[self.selectedImageDict allKeys] count] ; i++){
        
        if ([[self.selectedImageDict valueForKey:[[self.selectedImageDict allKeys] objectAtIndex:i]] integerValue]) {
            
          //  NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.albumNameList objectAtIndex:[[[self.selectedImageDict allKeys] objectAtIndex:i] integerValue]]]];
            
            //// 9th july for Image
            
            NSString *path1=[[self.albumNameList objectAtIndex:[[[self.selectedImageDict allKeys] objectAtIndex:i] integerValue] ]lastPathComponent];
            
            
            NSString *path=[[[[self.albumNameList objectAtIndex:[[[self.selectedImageDict allKeys] objectAtIndex:i] integerValue] ]stringByDeletingLastPathComponent]stringByDeletingLastPathComponent]stringByAppendingFormat:@"/%@",path1];
            
            NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:path]];
            
            [sharePhotoImage addObject:imageData];
        }
    }

     if(sharePhotoImage.count>0) {
         
         self.printView.hidden=YES;
         self.shareView.hidden=NO;
         self.sharevwmain.hidden=NO;
         self.mailbt.hidden=NO;
         self.instagrambt.hidden=NO;
         self.printbt.hidden=NO;
         
     }else{
         
          [self showAlertMessage:@"Select photo"];
     }
    }
    else
    {
        if(self.selVideoPath) {
            
            self.printView.hidden=YES;
            self.shareView.hidden=NO;
            self.sharevwmain.hidden=NO;
            self.mailbt.hidden=YES;
            self.instagrambt.hidden=YES;
             self.printbt.hidden=YES;
            
            
        }else{
            
            [self showAlertMessage:@"Select video"];
        }
    }

}

- (IBAction)mailSelectedPhoto:(id)sender {
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate=self;
    picker.navigationBar.tintColor=[UIColor blackColor];
    [picker setSubject:@""];
    [picker setMessageBody:nil isHTML:NO];
    [picker setToRecipients:[NSArray arrayWithObjects:@"", nil]];
    
    NSMutableArray *sharePhotoImage=[[NSMutableArray alloc] init];
    
    for (int i=0;i<[[self.selectedImageDict allKeys] count] ; i++){
        
        if ([[self.selectedImageDict valueForKey:[[self.selectedImageDict allKeys] objectAtIndex:i]] integerValue]) {
            
           // NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.albumNameList objectAtIndex:[[[self.selectedImageDict allKeys] objectAtIndex:i] integerValue]]]];
           
            //// 9th july for Image
            
            NSString *path1=[[self.albumNameList objectAtIndex:[[[self.selectedImageDict allKeys] objectAtIndex:i] integerValue] ]lastPathComponent];
            
            NSString *path=[[[[self.albumNameList objectAtIndex:[[[self.selectedImageDict allKeys] objectAtIndex:i] integerValue] ]stringByDeletingLastPathComponent]stringByDeletingLastPathComponent]stringByAppendingFormat:@"/%@",path1];
            
            NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:path]];
            
            [sharePhotoImage addObject:imageData];
        }
    }
    if (sharePhotoImage.count>0) {
        
        for (int i=0; i < sharePhotoImage.count; i++) {
            
             [picker addAttachmentData:[sharePhotoImage objectAtIndex:i] mimeType:@"image/png" fileName:@"reading.png"];
        }
    }
    
   
   
    //NSString *pdfPath =[AppToolBox getDoccumentPath:[NSString stringWithFormat:@"%@.pdf",@"Report"]];
    //NSString *sFileName=[NSString stringWithFormat:@"%@.pdf",@"Report"];
    //NSData *pdfData = [NSData dataWithContentsOfFile:pdfPath];
    //[picker addAttachmentData:pdfData mimeType:@"application/pdf" fileName:sFileName];
    
    
    Class mailclass = (NSClassFromString(@"MFMailComposeViewController"));
    
    if([mailclass canSendMail]){
        [appDelegate.centerViewController presentViewController:picker animated:YES completion:nil];
       // [self presentModalViewController:picker animated:YES];
    }

    
}


- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error {
    if (result == MFMailComposeResultSent) {
        
        ///// AD 7th july
        
        [self showHudView:@"Email sent successfully"];
        [self performSelector:@selector(hideHudView) withObject:self afterDelay:1.0];
        /*UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"" message:@"Email sent successfully" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Okay",nil];
        [alert1 show];*/
        
    }
    
    [appDelegate.centerViewController dismissViewControllerAnimated:YES completion:nil];
   // [self.appDelegate setHomeView];
}




- (IBAction)sharePhotoFacebook:(id)sender
{
    
    if(self.isPostPhotos)
    {
        NSMutableArray *sharePhotoImage=[[NSMutableArray alloc] init];
        
        for (int i=0;i<[[self.selectedImageDict allKeys] count] ; i++){
            
            if ([[self.selectedImageDict valueForKey:[[self.selectedImageDict allKeys] objectAtIndex:i]] integerValue]) {
                
               // NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.albumNameList objectAtIndex:[[[self.selectedImageDict allKeys] objectAtIndex:i] integerValue]]]];
                
                //// 9th july for Image
                
                NSString *path1=[[self.albumNameList objectAtIndex:[[[self.selectedImageDict allKeys] objectAtIndex:i] integerValue] ]lastPathComponent];
                
                NSString *path=[[[[self.albumNameList objectAtIndex:[[[self.selectedImageDict allKeys] objectAtIndex:i] integerValue] ]stringByDeletingLastPathComponent]stringByDeletingLastPathComponent]stringByAppendingFormat:@"/%@",path1];
                
                NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:path]];
                
                
                [sharePhotoImage addObject:imageData];
            }
        }
        
        //// facebook sdk change 8th july
        
        if(sharePhotoImage.count > 0)
        {
            self.photoToBeSharedCount = (int)sharePhotoImage.count;
            
           /* FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
            for (int i=0; i < sharePhotoImage.count; i++)
            {
                photo.image = [UIImage imageWithData:[sharePhotoImage objectAtIndex:i]];
            }
            
            photo.caption = [NSString stringWithFormat:@"Via %@",PRODUCT_NAME];
            photo.userGenerated = YES;
            FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
            content.photos = @[photo];
            
            [FBSDKShareDialog showFromViewController:self withContent:content delegate:nil];            //[self showHudView:@"Loading..."];
            
            */
            
            SLComposeViewController *controller=[[SLComposeViewController alloc] init];
            controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            
            
            //[controller setInitialText:[[NSString alloc] initWithFormat:@"Posted from %@. %@ is available on Apple Store and Google Play. This app enables you to share team pictures and videos on a common wall and also schedule games and team events",PRODUCT_NAME,PRODUCT_NAME ]];
            
            //[controller setInitialText:[[NSString alloc] initWithFormat:@"Posted from %@.\n%@ and %@",PRODUCT_NAME ,[NSURL URLWithString:FACEBOOKURLSTRING],[NSURL URLWithString:GOOGLEPLAYSTORE]]];
            
           // [controller setInitialText:[[NSString alloc] initWithFormat:@"Via %@",PRODUCT_NAME]];
            
            //[controller addImage:[UIImage imageNamed:@"socialsharing-facebook-image.jpg"]];
            
            if (sharePhotoImage.count>0) {
                
                for (int i=0; i < sharePhotoImage.count; i++) {
                    
                    [controller addImage:[UIImage imageWithData:[sharePhotoImage objectAtIndex:i]]];
                }
            }
            [controller setInitialText:[[NSString alloc] initWithFormat:@"Via %@",PRODUCT_NAME]];
            [controller setCompletionHandler:^(SLComposeViewControllerResult result) {
                // [self hideHudView];
                switch (result) {
                    case 0:
                    {
                    SLComposeViewControllerResultCancelled:
                        NSLog(@"Post Canceled");
                        
                        [self setRightBarButtonItemText:@"Select"];
                        isEditEnabled=NO;
                        self.selectedImageDict=nil;
                        self.selVideoPath=nil;
                        self.printView.hidden=YES;
                        self.shareView.hidden=YES;
                        self.sharevwmain.hidden=YES;
                        [self.tableVw reloadData];
                    }
                        break;
                    case 1:
                    {
                        
                    SLComposeViewControllerResultDone:
                        NSLog(@"Post Sucessful");
                        [self showAlertViewCustom:self.photoToBeSharedCount];
                        
                    }
                        [self setRightBarButtonItemText:@"Select"];
                        isEditEnabled=NO;
                        self.selectedImageDict=nil;
                        self.selVideoPath=nil;
                        self.printView.hidden=YES;
                        self.shareView.hidden=YES;
                        self.sharevwmain.hidden=YES;
                        [self.tableVw reloadData];
                        break;
                    default:
                        break;
                        
                }
                
            }];
            
            [self presentViewController:controller animated:YES completion:Nil];
            
            [self setRightBarButtonItemText:@"Select"];
            isEditEnabled=NO;
            self.selectedImageDict=nil;
            self.selVideoPath=nil;
            self.printView.hidden=YES;
            self.shareView.hidden=YES;
            self.sharevwmain.hidden=YES;
            [self.tableVw reloadData];
            
        }else{
            
            [self showAlertMessage:@"Select atleast one photo"];
        }
        
        
    }
    else
    {
       
        NSString *filePath = self.selVideoPath;
        NSURL *videoURL = [[NSURL alloc] initWithString:filePath];
        UIImage * thumbimage = [self getThumnailForVideo:videoURL];
        
      /*  FBSDKShareVideo *video = [[FBSDKShareVideo alloc] init];
        video.videoURL = videoURL;
        FBSDKShareVideoContent *content = [[FBSDKShareVideoContent alloc] init];
        content.video = video;
        
        [FBSDKShareDialog showFromViewController:self withContent:content delegate:nil];
        
        */
        
        SLComposeViewController *fbComposer =
        [SLComposeViewController
         composeViewControllerForServiceType:SLServiceTypeFacebook];
        
       
        
        
            SLComposeViewControllerCompletionHandler __block completionHandler=
            ^(SLComposeViewControllerResult result){
                
                [fbComposer dismissViewControllerAnimated:YES completion:nil];
                
                switch(result){
                    case SLComposeViewControllerResultCancelled:
                    default:
                    {
                        NSLog(@"Cancelled.....");
                    }
                        break;
                    case SLComposeViewControllerResultDone:
                    {
                        NSLog(@"Posted....");
                        
                        [self hideHudView];
                        self.selVideoPath=nil;
                        
                        
                        [self showAlertViewCustom:self.photoToBeSharedCount];
                        [self setRightBarButtonItemText:@"Select"];
                        isEditEnabled=NO;
                        self.selectedImageDict=nil;
                        self.selVideoPath=nil;
                        self.printView.hidden=YES;
                        self.shareView.hidden=YES;
                        self.sharevwmain.hidden=YES;
                        [self.tableVw reloadData];
                        
                    }
                        break;
                }};
            NSString *message=@"posting to FB test";
            [fbComposer setInitialText:message];
         ///////////////ADDDEBNEW
            [fbComposer addImage:thumbimage];
         ///////////////
            [fbComposer addURL:[NSURL URLWithString:filePath]];
            [fbComposer setCompletionHandler:completionHandler];
            [self presentViewController:fbComposer animated:YES completion:nil];
        
    }
    
}

//// facebook sdk change 8th july

#pragma mark - FBSDKSharingDelegate

- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results
{
    NSLog(@"completed share:%@", results);
    
    [self showAlertViewCustom:self.photoToBeSharedCount];
    
    [self setRightBarButtonItemText:@"Select"];
    isEditEnabled=NO;
    self.selectedImageDict=nil;
    self.selVideoPath=nil;
    self.printView.hidden=YES;
    self.shareView.hidden=YES;
    self.sharevwmain.hidden=YES;
    [self.tableVw reloadData];
}

- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error
{
    NSLog(@"sharing error:%@", error);
    NSString *message = error.userInfo[FBSDKErrorLocalizedDescriptionKey] ?:
    @"There was a problem sharing, please try again later.";
    NSString *title = error.userInfo[FBSDKErrorLocalizedTitleKey] ?: @"Oops!";
    
    [[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer
{
    NSLog(@"share cancelled");
    
    [self setRightBarButtonItemText:@"Select"];
    isEditEnabled=NO;
    self.selectedImageDict=nil;
    self.selVideoPath=nil;
    self.printView.hidden=YES;
    self.shareView.hidden=YES;
    self.sharevwmain.hidden=YES;
    [self.tableVw reloadData];
}

//////

-(UIImage*)getThumnailForVideo:(NSURL*)url
{
    UIImage *orgImage=nil;
    
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetIG =
    [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetIG.appliesPreferredTrackTransform = YES;
    assetIG.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    // CFTimeInterval thumbnailImageTime = 60.0;
    // CMTime time=  CMTimeMake(thumbnailImageTime, 60);
    NSError *igError = nil;
    thumbnailImageRef =
    [assetIG copyCGImageAtTime:time
                    actualTime:NULL
                         error:&igError];
    
    if (!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@", igError );
    
    
    UIImage *thumbnailImage = thumbnailImageRef
    ? [[UIImage alloc] initWithCGImage:thumbnailImageRef]
    : nil;
    
    CGSize sz= CGSizeMake(((thumbnailImage.size.width/thumbnailImage.size.height)*400),400);
    UIGraphicsBeginImageContextWithOptions(sz, FALSE, 0.0);
    //[thumbnailImage drawInRect:CGRectMake( 0, 0, thumbnailImage.size.width, thumbnailImage.size.height)];
    [thumbnailImage drawInRect:CGRectMake( 0, 0, ((thumbnailImage.size.width/thumbnailImage.size.height)*400),400)];
    
    UIImage *fgImage=[UIImage imageNamed:THUMBIMAGENAME];
    
    CGPoint p= CGPointMake(((sz.width-fgImage.size.width)/2), ((sz.height-fgImage.size.height)/2));
    
    [fgImage drawInRect:CGRectMake(p.x,p.y,fgImage.size.width, fgImage.size.height)];
    orgImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    if(thumbnailImageRef)
        CFRelease(thumbnailImageRef);
    
    
    
    
    
    return orgImage;
}



- (IBAction)sharePhotoInstragram:(id)sender
{
    
    NSLog(@"Connect With Instagram");
    
    
    if([[self.selectedImageDict allKeys] count]>1)
    {
        
        [self showAlertMessage:@"You must select only one photo for Instagram Sharing"];
        return;
    }
  
    
    
    for (int i=0;i<[[self.selectedImageDict allKeys] count] ; i++){
        
        if ([[self.selectedImageDict valueForKey:[[self.selectedImageDict allKeys] objectAtIndex:i]] integerValue]) {
            
            [self showHudView:@"Connecting..."];
            
            //// 9th july for Image
            
            NSString *path1=[[self.albumNameList objectAtIndex:[[[self.selectedImageDict allKeys] objectAtIndex:i] integerValue] ]lastPathComponent];
            
            NSString *path=[[[[self.albumNameList objectAtIndex:[[[self.selectedImageDict allKeys] objectAtIndex:i] integerValue] ]stringByDeletingLastPathComponent]stringByDeletingLastPathComponent]stringByAppendingFormat:@"/%@",path1];
            
            
            
            
            [self performSelectorInBackground:@selector(grabImage:)withObject:[NSURL URLWithString:path]];
            
           // [self performSelectorInBackground:@selector(grabImage:) withObject:[NSURL URLWithString:[self.albumNameList objectAtIndex:[[[self.selectedImageDict allKeys] objectAtIndex:i] integerValue]]]];
            
            
            break;
        }
    }
    
    
    
    
    
}

-(void)grabImage:(NSURL*)url
{
    
    
    
    @autoreleasepool {
        
    
    
    NSData *imageData=[NSData dataWithContentsOfURL:url];
    
    [self hideHudView];
    
    UIImage * screenshot =[UIImage imageWithData:imageData];
    NSString *savePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Screenshot.igo"];
    
    // Write image to PNG
    [UIImageJPEGRepresentation(screenshot, 1.0) writeToFile:savePath atomically:YES];
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://app"];
    
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
        //imageToUpload is a file path with .ig file extension
        documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:savePath]];
        documentInteractionController.UTI = @"com.instagram.exclusivegram";
        documentInteractionController.delegate = self;
        
        documentInteractionController.annotation = [NSDictionary dictionaryWithObject:@"via Sportsly" forKey:@"InstagramCaption"];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            CGRect padRect = CGRectMake(350,955,200,100);
            [documentInteractionController presentOpenInMenuFromRect:padRect inView:self.view animated:YES];
        }
        else
        {
            CGRect padRect = CGRectZero; // CGRectMake(150,450,320,200);
            [documentInteractionController presentOpenInMenuFromRect:padRect inView:self.appDelegate.centerViewController.view animated:YES];
        }//[documentInteractionController present
    }
    
    
    
    }
    

}

- (void)documentInteractionController:(UIDocumentInteractionController *)controller didEndSendingToApplication:(NSString *)application
{
    
    [self selectordoneAction:nil];
}

-(void) documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)controller
{
      // [self selectordoneAction:nil];
}

- (IBAction)allPhotos:(UIButton*)sender {
    
    [self.allPhotoBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16.0f]];
    
    self.allPhotoBtn.titleLabel.textColor=self.customRedColor;
    self.playerImageView.image=self.playergrayImage;
    self.teamImageView.image=self.teamGrayImage;
    self.dateImageView.image=self.dateGrayImage;
    
    self.dateLbl.font=self.helveticaFont;
    self.teamlbl.font=self.helveticaFont;
    self.playerLbl.font=self.helveticaFont;
    
    self.dateLbl.textColor=[UIColor darkGrayColor];
    self.teamlbl.textColor=[UIColor darkGrayColor];
    self.playerLbl.textColor=[UIColor darkGrayColor];
    
    if (isPostPhotos) {

    self.AllPhotos=self.AllPhotosArr;
    

    self.AllPhotos=self.AllPhotosArr;
    NSMutableArray *s=[[NSMutableArray alloc] init];
    self.albumNameList=s;
    for (NSDictionary *photoDescription in self.AllPhotos) {
        NSString *image=  [photoDescription objectForKey:@"image"];
        
        if(![image isEqualToString:@""])
        {
            NSString *str=[[NSString alloc] initWithFormat:@"%@%@",POSTIMAGELINKTHUMB,image];
            [albumNameList addObject:str];
        }
        
    }

    [self.tableVw reloadData];
        
    }else{
        
        

        
        self.AllVideos=self.AllVideosArr;
        
        NSMutableArray *s=[[NSMutableArray alloc] init];
        self.videoNameList=s;
        
        self.allVideosLink=[[NSMutableArray alloc] init] ;
        for (NSDictionary *d in  self.AllVideos)
        {
            NSString *image=  [d objectForKey:@"video_thumb"];
            
            if(![image isEqualToString:@""])
            {
                NSString *str=[[NSString alloc] initWithFormat:@"%@%@",POSTVIDEOIMAGELINK,image];
                [self.videoNameList addObject:str];
            }
            NSString *videoLink=[[NSString alloc] initWithFormat:@"%@%@",VIDEOLINK,[d objectForKey:@"video"]];
            [self.allVideosLink addObject:videoLink];
        }
        
        [self.tableVw reloadData];

    }
}

- (IBAction)cancelShareAction:(id)sender {
    
    [self selectordoneAction:sender];
}

#pragma mark - FilterPostedImage && Videos
-(void)filterAllData{
    
    if (isPostPhotos) {
        
        if (self.isTeam) {
            
            if ([self.sportName isEqualToString:@"All Teams"]) {
                
                self.AllPhotos=self.AllPhotosArr;
                
                NSMutableArray *s=[[NSMutableArray alloc] init];
                self.albumNameList=s;
                for (NSDictionary *photoDescription in self.AllPhotos) {
                    NSString *image=  [photoDescription objectForKey:@"image"];
                    
                    if(![image isEqualToString:@""])
                    {
                        NSString *str=[[NSString alloc] initWithFormat:@"%@%@",POSTIMAGELINKTHUMB,image];
                        [albumNameList addObject:str];
                    }
                    
                }

                
            }else{
                
                NSPredicate *predicated=[NSPredicate predicateWithFormat:@"team_name==%@",self.sportName];
                NSLog(@"predicated %@",predicated);
                self.AllPhotos=[[self.AllPhotosArr filteredArrayUsingPredicate:predicated] mutableCopy];
                
                NSSortDescriptor *alphaSort = [NSSortDescriptor sortDescriptorWithKey:@"Name" ascending:YES];
                self.AllPhotos= [[ self.AllPhotos   sortedArrayUsingDescriptors:[NSArray arrayWithObject:alphaSort]] mutableCopy];
                
                NSMutableArray *s=[[NSMutableArray alloc] init];
                self.albumNameList=s;
                for (NSDictionary *photoDescription in self.AllPhotos) {
                    NSString *image=  [photoDescription objectForKey:@"image"];
                    
                    if(![image isEqualToString:@""])
                    {
                        NSString *str=[[NSString alloc] initWithFormat:@"%@%@",POSTIMAGELINKTHUMB,image];
                        [albumNameList addObject:str];
                    }
                    
                }

            }
                
            [self.tableVw reloadData];
            
            
        }else if (isName){
            
            
            if ([self.selectedUsername isEqualToString:@"All Player"]) {
                                
                self.AllPhotos=self.AllPhotosArr;
                NSMutableArray *s=[[NSMutableArray alloc] init];
                self.albumNameList=s;
                for (NSDictionary *photoDescription in self.AllPhotos) {
                    NSString *image=  [photoDescription objectForKey:@"image"];
                    
                    if(![image isEqualToString:@""])
                    {
                        NSString *str=[[NSString alloc] initWithFormat:@"%@%@",POSTIMAGELINKTHUMB,image];
                        [albumNameList addObject:str];
                    }
                    
                }

                
                
            }else{

            NSPredicate *predicated=[NSPredicate predicateWithFormat:@"Name==%@",self.selectedUsername];
            NSLog(@"predicated %@",predicated);
            self.AllPhotos=[[self.AllPhotosArr filteredArrayUsingPredicate:predicated] mutableCopy];
            
            NSSortDescriptor *alphaSort = [NSSortDescriptor sortDescriptorWithKey:@"Name" ascending:YES];
            self.AllPhotos= [[ self.AllPhotos   sortedArrayUsingDescriptors:[NSArray arrayWithObject:alphaSort]] mutableCopy];
            NSMutableArray *s=[[NSMutableArray alloc] init];
            self.albumNameList=s;
            for (NSDictionary *photoDescription in self.AllPhotos) {
                NSString *image=  [photoDescription objectForKey:@"image"];
                
                if(![image isEqualToString:@""])
                {
                    NSString *str=[[NSString alloc] initWithFormat:@"%@%@",POSTIMAGELINKTHUMB,image];
                    [albumNameList addObject:str];
                }
                
            }
            }

            [self.tableVw reloadData];
            
        }else if (isDate){
            
            @autoreleasepool {
                
            
            NSDate *fstDate=[self dateFromSD:self.selDate];
             NSDate *lstDate=[self dateFromSDLast:self.selDate];
            
            NSPredicate *predicated=[NSPredicate predicateWithFormat:@"adddate>=%@ AND adddate<=%@",fstDate,lstDate];
            NSLog(@"predicated %@",predicated);
           // self.AllPhotos=[[self.AllPhotosArr filteredArrayUsingPredicate:predicated] mutableCopy];
            
            NSSortDescriptor *alphaSort = nil;
                
            
            if(isAscendingDate)
                alphaSort=[NSSortDescriptor sortDescriptorWithKey:@"adddate" ascending:YES];
            else
                alphaSort=[NSSortDescriptor sortDescriptorWithKey:@"adddate" ascending:NO];
            
            self.AllPhotos= [[ self.AllPhotos   sortedArrayUsingDescriptors:[NSArray arrayWithObject:alphaSort]] mutableCopy];
            NSMutableArray *s=[[NSMutableArray alloc] init];
            self.albumNameList=s;
            for (NSDictionary *photoDescription in self.AllPhotos) {
                NSString *image=  [photoDescription objectForKey:@"image"];
                
                if(![image isEqualToString:@""])
                {
                    NSString *str=[[NSString alloc] initWithFormat:@"%@%@",POSTIMAGELINKTHUMB,image];
                    [albumNameList addObject:str];
                }
                
            }

            [self.tableVw reloadData];
            }
        }else{
//            NSPredicate *predicated=[NSPredicate predicateWithFormat:@"sports_name==%@",self.sportName];
//            NSLog(@"predicated %@",predicated);
//            self.AllPhotos=[self. self.AllPhotosArr filteredArrayUsingPredicate:predicated];
            
            NSSortDescriptor *alphaSort = [NSSortDescriptor sortDescriptorWithKey:@"Name" ascending:YES];
            self.AllPhotos= [[self.AllPhotosArr   sortedArrayUsingDescriptors:[NSArray arrayWithObject:alphaSort]] mutableCopy];
            NSMutableArray *s=[[NSMutableArray alloc] init];
            self.albumNameList=s;
            for (NSDictionary *photoDescription in self.AllPhotos) {
                NSString *image=  [photoDescription objectForKey:@"image"];
                
                if(![image isEqualToString:@""])
                {
                    NSString *str=[[NSString alloc] initWithFormat:@"%@%@",POSTIMAGELINKTHUMB,image];
                    [albumNameList addObject:str];
                }
                
            }
             [self setRightBarButtonItemText:@"Select"];
            isEditEnabled=NO;
            self.selectedImageDict=nil;
            self.selVideoPath=nil;
            self.printView.hidden=YES;
            self.shareView.hidden=YES;
            self.sharevwmain.hidden=YES;
            [self.tableVw reloadData];
            
            
        }

    }else{
        
        if (self.isTeam) {
            
            if ([self.sportName isEqualToString:@"All Teams"]) {
                
                self.AllVideos=self.AllVideosArr;
                
                NSMutableArray *s=[[NSMutableArray alloc] init];
                self.videoNameList=s;
                
                self.allVideosLink=[[NSMutableArray alloc] init] ;
                for (NSDictionary *d in  self.AllVideos)
                {
                    NSString *image=  [d objectForKey:@"video_thumb"];
                    
                    if(![image isEqualToString:@""])
                    {
                        NSString *str=[[NSString alloc] initWithFormat:@"%@%@",POSTVIDEOIMAGELINK,image];
                        [self.videoNameList addObject:str];
                    }
                    NSString *videoLink=[[NSString alloc] initWithFormat:@"%@%@",VIDEOLINK,[d objectForKey:@"video"]];
                    [self.allVideosLink addObject:videoLink];
                }

                
            }else{
            
            NSPredicate *predicated=[NSPredicate predicateWithFormat:@"team_name==%@",self.sportName];
            NSLog(@"predicated %@",predicated);
            self.AllVideos=[[self.AllVideosArr filteredArrayUsingPredicate:predicated] mutableCopy];
            
            NSSortDescriptor *alphaSort = [NSSortDescriptor sortDescriptorWithKey:@"Name" ascending:YES];
            self.AllVideos= [[ self.AllVideos   sortedArrayUsingDescriptors:[NSArray arrayWithObject:alphaSort]] mutableCopy];
            
            NSMutableArray *s=[[NSMutableArray alloc] init];
            self.videoNameList=s;
            
            self.allVideosLink=[[NSMutableArray alloc] init] ;
            for (NSDictionary *d in  self.AllVideos)
            {
                NSString *image=  [d objectForKey:@"video_thumb"];
                
                if(![image isEqualToString:@""])
                {
                    NSString *str=[[NSString alloc] initWithFormat:@"%@%@",POSTVIDEOIMAGELINK,image];
                    [self.videoNameList addObject:str];
                }
                NSString *videoLink=[[NSString alloc] initWithFormat:@"%@%@",VIDEOLINK,[d objectForKey:@"video"]];
                [self.allVideosLink addObject:videoLink];
            }
            }
            [self.tableVw reloadData];
            
            
        }else if (isName){
            
            
            if ([self.selectedUsername isEqualToString:@"All Player"]) {
                
                self.AllVideos=self.AllVideosArr;
                NSMutableArray *s=[[NSMutableArray alloc] init];
                self.videoNameList=s;
                
                self.allVideosLink=[[NSMutableArray alloc] init] ;
                for (NSDictionary *d in  self.AllVideos)
                {
                    NSString *image=  [d objectForKey:@"video_thumb"];
                    
                    if(![image isEqualToString:@""])
                    {
                        NSString *str=[[NSString alloc] initWithFormat:@"%@%@",POSTVIDEOIMAGELINK,image];
                        [self.videoNameList addObject:str];
                    }
                    NSString *videoLink=[[NSString alloc] initWithFormat:@"%@%@",VIDEOLINK,[d objectForKey:@"video"]];
                    [self.allVideosLink addObject:videoLink];
                }

                
            }else{
                
            NSPredicate *predicated=[NSPredicate predicateWithFormat:@"Name==%@",self.selectedUsername];
            NSLog(@"predicated %@",predicated);
            self.AllVideos=[[self.AllVideosArr filteredArrayUsingPredicate:predicated] mutableCopy];
            
            NSSortDescriptor *alphaSort = [NSSortDescriptor sortDescriptorWithKey:@"Name" ascending:YES];
            self.AllVideos= [[ self.AllVideos   sortedArrayUsingDescriptors:[NSArray arrayWithObject:alphaSort]] mutableCopy];
            NSMutableArray *s=[[NSMutableArray alloc] init];
            self.videoNameList=s;
            
            self.allVideosLink=[[NSMutableArray alloc] init] ;
            for (NSDictionary *d in  self.AllVideos)
            {
                NSString *image=  [d objectForKey:@"video_thumb"];
                
                if(![image isEqualToString:@""])
                {
                    NSString *str=[[NSString alloc] initWithFormat:@"%@%@",POSTVIDEOIMAGELINK,image];
                    [self.videoNameList addObject:str];
                }
                NSString *videoLink=[[NSString alloc] initWithFormat:@"%@%@",VIDEOLINK,[d objectForKey:@"video"]];
                [self.allVideosLink addObject:videoLink];
            }
            }
            [self.tableVw reloadData];
            
        }else if (isDate){
            @autoreleasepool {
                
            
            NSDate *fstDate=[self dateFromSD:self.selDate];
            NSDate *lstDate=[self dateFromSDLast:self.selDate];
            
            NSPredicate *predicated=[NSPredicate predicateWithFormat:@"adddate>=%@ AND adddate<=%@",fstDate,lstDate];
           
            NSLog(@"predicated %@",predicated);
            self.AllVideos=[[self.AllVideosArr filteredArrayUsingPredicate:predicated] mutableCopy];
            
             NSSortDescriptor *alphaSort = nil;
            if(isAscendingDate)
                alphaSort=[NSSortDescriptor sortDescriptorWithKey:@"adddate" ascending:YES];
            else
                alphaSort=[NSSortDescriptor sortDescriptorWithKey:@"adddate" ascending:NO];
            self.AllVideos= [[self.AllVideos   sortedArrayUsingDescriptors:[NSArray arrayWithObject:alphaSort]] mutableCopy];
            NSMutableArray *s=[[NSMutableArray alloc] init];
            self.videoNameList=s;
            
            self.allVideosLink=[[NSMutableArray alloc] init] ;
            for (NSDictionary *d in  self.AllVideos)
            {
                NSString *image=  [d objectForKey:@"video_thumb"];
                
                if(![image isEqualToString:@""])
                {
                    NSString *str=[[NSString alloc] initWithFormat:@"%@%@",POSTVIDEOIMAGELINK,image];
                    [self.videoNameList addObject:str];
                }
                NSString *videoLink=[[NSString alloc] initWithFormat:@"%@%@",VIDEOLINK,[d objectForKey:@"video"]];
                [self.allVideosLink addObject:videoLink];
            }

            [self.tableVw reloadData];
            }
        }else{
            //            NSPredicate *predicated=[NSPredicate predicateWithFormat:@"sports_name==%@",self.sportName];
            //            NSLog(@"predicated %@",predicated);
            //            self.AllPhotos=[self. self.AllPhotosArr filteredArrayUsingPredicate:predicated];
            
            NSSortDescriptor *alphaSort = [NSSortDescriptor sortDescriptorWithKey:@"Name" ascending:YES];
            self.AllVideos= [[ self.AllVideosArr   sortedArrayUsingDescriptors:[NSArray arrayWithObject:alphaSort]] mutableCopy];
            NSMutableArray *s=[[NSMutableArray alloc] init];
            self.videoNameList=s;

            self.allVideosLink=[[NSMutableArray alloc] init] ;
            for (NSDictionary *d in  self.AllVideos)
            {
                NSString *image=  [d objectForKey:@"video_thumb"];
                
                if(![image isEqualToString:@""])
                {
                    NSString *str=[[NSString alloc] initWithFormat:@"%@%@",POSTVIDEOIMAGELINK,image];
                    [self.videoNameList addObject:str];
                }
                NSString *videoLink=[[NSString alloc] initWithFormat:@"%@%@",VIDEOLINK,[d objectForKey:@"video"]];
                [self.allVideosLink addObject:videoLink];
            }

            [self.tableVw reloadData];
            
            
        }
         [self setRightBarButtonItemText:@"Select"];
        isEditEnabled=NO;
        self.selectedImageDict=nil;
        self.selVideoPath=nil;
        self.printView.hidden=YES;
        self.shareView.hidden=YES;
        self.sharevwmain.hidden=YES;
        
    }
    
    
    [self setNoDataView];
}



- (IBAction)doneWithPicker:(id)sender {
    
    self.pickerContainerView.hidden=YES;
    
    if (self.Selectedtag==101) {
        
        self.sportName=[self.TeamNameArr objectAtIndex:self.teamSelectEdRow];
        
        self.playerImageView.image=self.playergrayImage;
        self.teamImageView.image=self.teamRedImage;
        self.dateImageView.image=self.dateGrayImage;
        
        self.dateLbl.font=self.helveticaFont;
        self.teamlbl.font=self.helveticaFontForteBold;
        self.playerLbl.font=self.helveticaFont;
        
        self.dateLbl.textColor=[UIColor darkGrayColor];
        self.teamlbl.textColor=self.customRedColor;
        self.playerLbl.textColor=[UIColor darkGrayColor];
        
        [self.allPhotoBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
        self.allPhotoBtn.titleLabel.textColor=[UIColor darkGrayColor];

        
    }else{
        
        self.selectedUsername=[self.userName objectAtIndex:self.userSelectedRow];
        self.playerImageView.image=self.playerRedImage;
        self.teamImageView.image=self.teamGrayImage;
        self.dateImageView.image=self.dateGrayImage;
        
        self.dateLbl.font=self.helveticaFont;
        self.teamlbl.font=self.helveticaFont;
        self.playerLbl.font=self.helveticaFontForteBold;
        
        self.dateLbl.textColor=[UIColor darkGrayColor];
        self.teamlbl.textColor=[UIColor darkGrayColor];
        self.playerLbl.textColor=self.customRedColor;
        
        [self.allPhotoBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
        self.allPhotoBtn.titleLabel.textColor=[UIColor darkGrayColor];

 
    }
    [self filterAllData];

}

- (IBAction)cancelWithPicker:(id)sender {
    
    self.pickerContainerView.hidden=YES;

}
  
    
#pragma mark -PickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.Selectedtag==101) {
        self.teamSelectEdRow=row;
    }else{
        self.userSelectedRow=row;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
     if (self.Selectedtag==101) {
         return self.TeamNameArr.count;
     }else{
         return self.userName.count;
     }
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    
    if (!view){
        
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 3, 300, 24)];
        label.backgroundColor = [UIColor clearColor];
        [view addSubview:label];
        
//        UIImageView *flagView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 24, 24)];
//        flagView.contentMode = UIViewContentModeScaleToFill;
//        [view addSubview:flagView];
        
        
        
    }
      if (self.Selectedtag==101) {
          [(UILabel *)(view.subviews)[0] setText:[self.TeamNameArr objectAtIndex:row] ];
      }else{
          [(UILabel *)(view.subviews)[0] setText:[self.userName objectAtIndex:row] ];

      }
    // [(UIImageView *)(view.subviews)[1] setImage:[self.allTeamList objectAtIndex:row]];
    return view;
    
}


#pragma mark - DatePicker

-(void)showDatePicker:(id)sender{
    
    /*self.datePickerview.hidden=NO;
    [self.view bringSubviewToFront:self.datePickerview];*/
    [self donePicker:sender];
    
}
- (IBAction)pickercancel:(id)sender {
    
    self.datePickerview.hidden=YES;
}

- (IBAction)donePicker:(id)sender {
    self.datePickerview.hidden=YES;
    self.isName=NO;
    self.isTeam=NO;
    self.isDate=YES;
    self.teamNametxt.text=@"";
    self.nameTxt.text=@"";
    
    self.playerImageView.image=self.playergrayImage;
    self.teamImageView.image=self.teamGrayImage;
    self.dateImageView.image=self.dateRedImage;
    
    self.dateLbl.font=self.helveticaFontForteBold;
    self.teamlbl.font=self.helveticaFont;
    self.playerLbl.font=self.helveticaFont;
    
    self.dateLbl.textColor=self.customRedColor;
    self.teamlbl.textColor=[UIColor darkGrayColor];
    self.playerLbl.textColor=[UIColor darkGrayColor];
    
    [self.allPhotoBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    self.allPhotoBtn.titleLabel.textColor=[UIColor darkGrayColor];
    
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    
    self.selDate=[self.datePicker date];
    self.selectedDate=[dateformatter stringFromDate:[self.datePicker date]];
    self.dateTxt.text=self.selectedDate;
    [self filterAllData];
}

- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)selectordoneAction:(UIButton*)sender
{
    if (isPostPhotos){
        
        if ([self.rightBarButtonItem.title  isEqualToString:@"Select"]) {
            
            [self.selectBtn setTitle:@"Cancel" forState:UIControlStateNormal];
            isEditEnabled=YES;
            self.selectedImageDict=[[NSMutableDictionary alloc] init];
             self.selVideoPath=nil;
            self.printView.hidden=NO;
            //self.allPhotoBtn.hidden=YES;
            self.filterView.hidden=YES;
            
        }else{
            
             [self setRightBarButtonItemText:@"Select"];
            isEditEnabled=NO;
            self.selectedImageDict=nil;
            self.selVideoPath=nil;
            self.printView.hidden=YES;
            self.shareView.hidden=YES;
            self.sharevwmain.hidden=YES;
            self.allPhotoBtn.hidden=NO;
            self.filterView.hidden=NO;
            [self.tableVw reloadData];
            
        }

    }
}

- (IBAction)addAlbum:(id)sender {
   
}

- (IBAction)editAlbums:(id)sender {
  
}

#pragma mark - ViewPhotos && Videos

-(void)viewAllPhotos:(UIButton *)sender
{
    
    PhotoMainVCTableCell *photoCell=nil;
    
    if(appDelegate.isIos7)
     photoCell= (PhotoMainVCTableCell*)[[[[sender superview] superview] superview] superview];
    else
        photoCell= (PhotoMainVCTableCell*)[[[sender superview] superview] superview];
    
    
    
    NSIndexPath *selectedIndexPath=[self.tableVw indexPathForCell:photoCell];
  
    if(isEditEnabled)
    {
        if (sender.tag==0) {
            
            if ([photoCell.upvw1 isHidden]) {
                
                photoCell.upvw1.hidden=NO;
                [self.selectedImageDict setObject:@"1" forKey:[NSString stringWithFormat:@"%d",selectedIndexPath.row * 4 + sender.tag]];
                
            }else{
                photoCell.upvw1.hidden=YES;
                [self.selectedImageDict setObject:@"0" forKey:[NSString stringWithFormat:@"%d",selectedIndexPath.row * 4 + sender.tag]];
            }
            
        }else if (sender.tag==1){
            
            if ([photoCell.upvw2 isHidden]) {
                
                photoCell.upvw2.hidden=NO;
                [self.selectedImageDict setObject:@"1" forKey:[NSString stringWithFormat:@"%d",selectedIndexPath.row * 4 + sender.tag]];
                
            }else{
                photoCell.upvw2.hidden=YES;
                [self.selectedImageDict setObject:@"0" forKey:[NSString stringWithFormat:@"%d",selectedIndexPath.row * 4 + sender.tag]];
            }

            
        }else if (sender.tag==2){
            
            if ([photoCell.upvw3 isHidden]) {
                
                photoCell.upvw3.hidden=NO;
                [self.selectedImageDict setObject:@"1" forKey:[NSString stringWithFormat:@"%d",selectedIndexPath.row * 4 + sender.tag]];
                
            }else{
                photoCell.upvw3.hidden=YES;
                [self.selectedImageDict setObject:@"0" forKey:[NSString stringWithFormat:@"%d",selectedIndexPath.row * 4 + sender.tag]];
            }

            
        }else{
            
            if ([photoCell.upvw4 isHidden]) {
                
                photoCell.upvw4.hidden=NO;
                [self.selectedImageDict setObject:@"1" forKey:[NSString stringWithFormat:@"%d",selectedIndexPath.row * 4 + sender.tag]];
                
            }else{
                photoCell.upvw4.hidden=YES;
                [self.selectedImageDict setObject:@"0" forKey:[NSString stringWithFormat:@"%d",selectedIndexPath.row * 4 + sender.tag]];
            }

            
        }
        
    }
    else
    {
        
        PhotoDetailsVC *detail=[[PhotoDetailsVC alloc] initWithNibName:@"PhotoDetailsVC" bundle:nil];
        
        @autoreleasepool {
            
                     
            NSString *path1=[[self.albumNameList objectAtIndex:selectedIndexPath.row * 4 + sender.tag] lastPathComponent];
            
            
             
            
    
              NSString *path=[[[[self.albumNameList objectAtIndex:selectedIndexPath.row * 4 + sender.tag]  stringByDeletingLastPathComponent] stringByDeletingLastPathComponent]stringByAppendingFormat:@"/%@",path1];
            NSLog(@"Path=%@",path);
        
        detail.imageUrl=path;
        }
        [self.navigationController pushViewController:detail animated:YES];
    }
    
    
    
}



-(void)viewAllVideos:(UIButton *)sender
{
    
    PhotoMainVCTableCell *photoCell=nil;
    
    if(appDelegate.isIos7)
        photoCell= (PhotoMainVCTableCell*)[[[[sender superview] superview] superview] superview];
    else
        photoCell= (PhotoMainVCTableCell*)[[[sender superview] superview] superview];
    NSIndexPath *selectedIndexPath=[self.tableVw indexPathForCell:photoCell];
    
    if(isEditEnabled)
    {
        self.selVideoPath=nil;
        
    if (sender.tag==0)
    {
        
        if ([photoCell.upvw1 isHidden]) {
            
            photoCell.upvw1.hidden=NO;
            photoCell.upvw2.hidden=YES;
            photoCell.upvw3.hidden=YES;
            photoCell.upvw4.hidden=YES;
            
         self.selVideoPath=[self.allVideosLink objectAtIndex:(selectedIndexPath.row * 4 + sender.tag) ];
        }else{
            photoCell.upvw1.hidden=YES;
        }
    }
    else if (sender.tag==1)
    {
        if ([photoCell.upvw2 isHidden]) {
            
              self.selVideoPath=[self.allVideosLink objectAtIndex:(selectedIndexPath.row * 4 + sender.tag) ];
            
            photoCell.upvw2.hidden=NO;
            photoCell.upvw1.hidden=YES;
            photoCell.upvw3.hidden=YES;
            photoCell.upvw4.hidden=YES;
        }else{
            photoCell.upvw2.hidden=YES;
        }
    }
    else if (sender.tag==2)
    {
        if ([photoCell.upvw3 isHidden]) {
            
              self.selVideoPath=[self.allVideosLink objectAtIndex:(selectedIndexPath.row * 4 + sender.tag) ];
            
            photoCell.upvw3.hidden=NO;
            photoCell.upvw2.hidden=YES;
            photoCell.upvw1.hidden=YES;
            photoCell.upvw4.hidden=YES;
        }else{
            photoCell.upvw3.hidden=YES;
        }
    }
    else
    {
        if ([photoCell.upvw4 isHidden]) {
            
              self.selVideoPath=[self.allVideosLink objectAtIndex:(selectedIndexPath.row * 4 + sender.tag) ];
            
            photoCell.upvw4.hidden=NO;
            photoCell.upvw2.hidden=YES;
            photoCell.upvw3.hidden=YES;
            photoCell.upvw1.hidden=YES;
        }else{
            photoCell.upvw4.hidden=YES;
        }
    }
    }
   else
   {
    
//    if(isEditEnabled)
//    {
//        if (sender.tag==0) {
//            
//            if ([photoCell.upvw1 isHidden]) {
//                
//                photoCell.upvw1.hidden=NO;
//                [self.selectedImageDict setObject:@"1" forKey:[NSString stringWithFormat:@"%d",selectedIndexPath.row * 4 + sender.tag]];
//                
//            }else{
//                photoCell.upvw1.hidden=YES;
//                [self.selectedImageDict setObject:@"0" forKey:[NSString stringWithFormat:@"%d",selectedIndexPath.row * 4 + sender.tag]];
//            }
//            
//        }else if (sender.tag==1){
//            
//            if ([photoCell.upvw2 isHidden]) {
//                
//                photoCell.upvw2.hidden=NO;
//                [self.selectedImageDict setObject:@"1" forKey:[NSString stringWithFormat:@"%d",selectedIndexPath.row * 4 + sender.tag]];
//                
//            }else{
//                photoCell.upvw2.hidden=YES;
//                [self.selectedImageDict setObject:@"0" forKey:[NSString stringWithFormat:@"%d",selectedIndexPath.row * 4 + sender.tag]];
//            }
//            
//            
//        }else if (sender.tag==3){
//            
//            if ([photoCell.upvw3 isHidden]) {
//                
//                photoCell.upvw3.hidden=NO;
//                [self.selectedImageDict setObject:@"1" forKey:[NSString stringWithFormat:@"%d",selectedIndexPath.row * 4 + sender.tag]];
//                
//            }else{
//                photoCell.upvw3.hidden=YES;
//                [self.selectedImageDict setObject:@"0" forKey:[NSString stringWithFormat:@"%d",selectedIndexPath.row * 4 + sender.tag]];
//            }
//            
//            
//        }else{
//            
//            if ([photoCell.upvw4 isHidden]) {
//                
//                photoCell.upvw4.hidden=NO;
//                [self.selectedImageDict setObject:@"1" forKey:[NSString stringWithFormat:@"%d",selectedIndexPath.row * 4 + sender.tag]];
//                
//            }else{
//                photoCell.upvw4.hidden=YES;
//                [self.selectedImageDict setObject:@"0" forKey:[NSString stringWithFormat:@"%d",selectedIndexPath.row * 4 + sender.tag]];
//            }
//            
//        }
//        
//    }
//    else
//    {
        [self btnVideoClicked:[self.allVideosLink objectAtIndex:selectedIndexPath.row * 4 + sender.tag]];
   // }
    
    
   }
}


-(void)deleteAlbum:(UIButton *)sender
{
    
}

#pragma mark - TextFieldDelegate
#pragma mark - TextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    
    if (textField.tag==101) {
        
        self.pickerContainerView.hidden=NO;
        [self.view bringSubviewToFront:self.pickerContainerView];
        self.Selectedtag=101;
        self.isName=NO;
        self.isTeam=YES;
        self.isDate=NO;
        self.userSelectedRow=0;
        
//        self.playerImageView.image=self.playergrayImage;
//        self.teamImageView.image=self.teamRedImage;
//        self.dateImageView.image=self.dateGrayImage;
//        
//        self.dateLbl.font=self.helveticaFont;
//        self.teamlbl.font=self.helveticaFontForteBold;
//        self.playerLbl.font=self.helveticaFont;
//        
//        self.dateLbl.textColor=[UIColor darkGrayColor];
//        self.teamlbl.textColor=self.customRedColor;
//        self.playerLbl.textColor=[UIColor darkGrayColor];
//        
//        [self.allPhotoBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
//        self.allPhotoBtn.titleLabel.textColor=[UIColor darkGrayColor];

        [self.picker reloadAllComponents];
        
        
    }else if (textField.tag==103){
        
        self.pickerContainerView.hidden=NO;
        [self.view bringSubviewToFront:self.pickerContainerView];
        self.Selectedtag=103;
        self.isName=YES;
        self.isTeam=NO;
        self.isDate=NO;
        self.teamSelectEdRow=0;
        [self.picker reloadAllComponents];
        
//        self.playerImageView.image=self.playerRedImage;
//        self.teamImageView.image=self.teamGrayImage;
//        self.dateImageView.image=self.dateGrayImage;
//        
//        self.dateLbl.font=self.helveticaFont;
//        self.teamlbl.font=self.helveticaFont;
//        self.playerLbl.font=self.helveticaFontForteBold;
//        
//        self.dateLbl.textColor=[UIColor darkGrayColor];
//        self.teamlbl.textColor=[UIColor darkGrayColor];
//        self.playerLbl.textColor=self.customRedColor;
//
//        [self.allPhotoBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
//        self.allPhotoBtn.titleLabel.textColor=[UIColor darkGrayColor];

        
    }else{
        
        [self showDatePicker];
        
//        self.playerImageView.image=self.playergrayImage;
//        self.teamImageView.image=self.teamGrayImage;
//        self.dateImageView.image=self.dateRedImage;
//        
//        self.dateLbl.font=self.helveticaFontForteBold;
//        self.teamlbl.font=self.helveticaFont;
//        self.playerLbl.font=self.helveticaFont;
//        
//        self.dateLbl.textColor=self.customRedColor;
//        self.teamlbl.textColor=[UIColor darkGrayColor];
//        self.playerLbl.textColor=[UIColor darkGrayColor];
//        
//        [self.allPhotoBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
//        self.allPhotoBtn.titleLabel.textColor=[UIColor darkGrayColor];

    }
    
}

#pragma mark - TableViewDelegate && DataSourace

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isPostPhotos) {
        
         return ((int)(self.AllPhotos.count/4))+(self.AllPhotos.count%4?1:0);
        
    }else{
        
        return ((int)(self.AllVideos.count/4))+(self.AllVideos.count%4?1:0);

    }
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PhotoMainVCTableCell";
    
    PhotoMainVCTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = (PhotoMainVCTableCell *)[PhotoMainVCTableCell cellFromNibNamed:@"PhotoMainVCTableCell"];
        
      
        
    }
    if(self.isPostPhotos )
    {
        
        cell.playimage1.hidden=YES;
         cell.playimage2.hidden=YES;
         cell.playimage3.hidden=YES;
         cell.playimage4.hidden=YES;
    }
    else
    {
        cell.playimage1.hidden=NO;
        cell.playimage2.hidden=NO;
        cell.playimage3.hidden=NO;
        cell.playimage4.hidden=NO;
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}



- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Row=%i-Cell=%@",indexPath.row,cell);
    
    @autoreleasepool {
        
    
    
    PhotoMainVCTableCell *scell=(PhotoMainVCTableCell *)cell;
    
    scell.selectionStyle=UITableViewCellSelectionStyleNone;
        
     if (isPostPhotos) {    
        
    if(indexPath.row>=((int)(self.AllPhotos.count/4)))
    {
        if(self.AllPhotos.count%4==1)
        {
            scell.vw2.hidden=YES;
            scell.vw3.hidden=YES;
            scell.vw4.hidden=YES;
            
            [scell.btn1 addTarget:self action:@selector(viewAllPhotos:) forControlEvents:UIControlEventTouchUpInside];
          
            
           
            
              //[scell.btn1 setImageWithURL:[NSURL URLWithString:[self.albumNameList objectAtIndex:(indexPath.row*4) + scell.btn1.tag]] placeholderImage:self.noAlbumImage forState:UIControlStateNormal];
            
            
            [scell.imgFrm1 setImageWithURL:[NSURL URLWithString:[self.albumNameList objectAtIndex:(indexPath.row*4) + scell.btn1.tag]] placeholderImage:self.noAlbumImage ];
            
            
            if(isEditEnabled==YES)
            {
                
                if (!self.selectedImageDict) {
                    
                    if ([[self.selectedImageDict valueForKey:[NSString stringWithFormat:@"%d",indexPath.row * 4 + scell.btn1.tag]] integerValue]) {
                        
                        scell.upvw1.hidden=NO;
                    }else{
                        scell.upvw1.hidden=YES;
                        
                    }
                    
                }else{
                    
                    scell.upvw1.hidden=YES;
                    
                }
            }
            else
            {
                scell.upvw1.hidden=YES;
                
            }
            

        }
        else if(self.AllPhotos.count%4==2)
        {
            scell.vw3.hidden=YES;
            scell.vw4.hidden=YES;
            
            [scell.btn1 addTarget:self action:@selector(viewAllPhotos:) forControlEvents:UIControlEventTouchUpInside];
            [scell.btn2 addTarget:self action:@selector(viewAllPhotos:) forControlEvents:UIControlEventTouchUpInside];
            
                   
           
           // [scell.btn1 setImageWithURL:[NSURL URLWithString:[self.albumNameList objectAtIndex:(indexPath.row*4) + scell.btn1.tag]] placeholderImage:self.noAlbumImage forState:UIControlStateNormal];
             [scell.imgFrm1 setImageWithURL:[NSURL URLWithString:[self.albumNameList objectAtIndex:(indexPath.row*4) + scell.btn1.tag]] placeholderImage:self.noAlbumImage ];
            //[scell.btn2 setImageWithURL:[NSURL URLWithString:[self.albumNameList objectAtIndex:(indexPath.row*4) + scell.btn2.tag]] placeholderImage:self.noAlbumImage forState:UIControlStateNormal];
            [scell.imgFrm2 setImageWithURL:[NSURL URLWithString:[self.albumNameList objectAtIndex:(indexPath.row*4) + scell.btn2.tag]] placeholderImage:self.noAlbumImage ];
            
            
            if(isEditEnabled==YES)
            {
                
                if (!self.selectedImageDict) {
                    
                    if ([[self.selectedImageDict valueForKey:[NSString stringWithFormat:@"%d",indexPath.row * 4 + scell.btn1.tag]] integerValue]) {
                        
                        scell.upvw1.hidden=NO;
                    }else{
                        scell.upvw1.hidden=YES;
                        
                    }
                    
                    if ([[self.selectedImageDict valueForKey:[NSString stringWithFormat:@"%d",indexPath.row * 4 + scell.btn2.tag]] integerValue]) {
                        
                        scell.upvw2.hidden=NO;
                    }else{
                        scell.upvw2.hidden=YES;
                        
                    }

                    
                    
                }else{
                    
                    scell.upvw1.hidden=YES;
                    scell.upvw2.hidden=YES;
                    
                }
            }
            else
            {
                scell.upvw1.hidden=YES;
                scell.upvw2.hidden=YES;
            }
            

        }
        else if(self.AllPhotos.count%4==3)
        {
           
            scell.vw4.hidden=YES;
            
            [scell.btn1 addTarget:self action:@selector(viewAllPhotos:) forControlEvents:UIControlEventTouchUpInside];
            [scell.btn2 addTarget:self action:@selector(viewAllPhotos:) forControlEvents:UIControlEventTouchUpInside];
              [scell.btn3 addTarget:self action:@selector(viewAllPhotos:) forControlEvents:UIControlEventTouchUpInside];
            
        
            
            
             
             //[scell.btn1 setImageWithURL: [NSURL URLWithString:[self.albumNameList objectAtIndex:(indexPath.row*4) + scell.btn1.tag]] placeholderImage:self.noAlbumImage forState:UIControlStateNormal];
            [scell.imgFrm1 setImageWithURL: [NSURL URLWithString:[self.albumNameList objectAtIndex:(indexPath.row*4) + scell.btn1.tag]] placeholderImage:self.noAlbumImage ];
           //  [scell.btn2 setImageWithURL: [NSURL URLWithString:[self.albumNameList objectAtIndex:(indexPath.row*4) + scell.btn2.tag]] placeholderImage:self.noAlbumImage forState:UIControlStateNormal];
            [scell.imgFrm2 setImageWithURL: [NSURL URLWithString:[self.albumNameList objectAtIndex:(indexPath.row*4) + scell.btn2.tag]] placeholderImage:self.noAlbumImage ];
            [scell.imgFrm3 setImageWithURL: [NSURL URLWithString:[self.albumNameList objectAtIndex:(indexPath.row*4) + scell.btn3.tag]] placeholderImage:self.noAlbumImage ];
            
             //[scell.btn3 setImageWithURL: [NSURL URLWithString:[self.albumNameList objectAtIndex:(indexPath.row*4) + scell.btn3.tag]] placeholderImage:self.noAlbumImage forState:UIControlStateNormal];
            
            if(isEditEnabled==YES)
            {
                
                if (!self.selectedImageDict) {
                    
                    if ([[self.selectedImageDict valueForKey:[NSString stringWithFormat:@"%d",indexPath.row * 4 + scell.btn1.tag]] integerValue]) {
                        
                        scell.upvw1.hidden=NO;
                    }else{
                        scell.upvw1.hidden=YES;
                        
                    }
                    
                    if ([[self.selectedImageDict valueForKey:[NSString stringWithFormat:@"%d",indexPath.row * 4 + scell.btn2.tag]] integerValue]) {
                        
                        scell.upvw2.hidden=NO;
                    }else{
                        scell.upvw2.hidden=YES;
                        
                    }
                    if ([[self.selectedImageDict valueForKey:[NSString stringWithFormat:@"%d",indexPath.row * 4 + scell.btn3.tag]] integerValue]) {
                        
                        scell.upvw3.hidden=NO;
                    }else{
                        scell.upvw3.hidden=YES;
                        
                    }

                    
                    
                }else{
                    
                    scell.upvw1.hidden=YES;
                    scell.upvw2.hidden=YES;
                    scell.upvw3.hidden=YES;
                    
                }
            }
            else
            {
                scell.upvw1.hidden=YES;
                scell.upvw2.hidden=YES;
                scell.upvw3.hidden=YES;

            }

            }

    }
    else
    {
        [scell.btn1 addTarget:self action:@selector(viewAllPhotos:) forControlEvents:UIControlEventTouchUpInside];
        [scell.btn2 addTarget:self action:@selector(viewAllPhotos:) forControlEvents:UIControlEventTouchUpInside];
        [scell.btn3 addTarget:self action:@selector(viewAllPhotos:) forControlEvents:UIControlEventTouchUpInside];
            [scell.btn4 addTarget:self action:@selector(viewAllPhotos:) forControlEvents:UIControlEventTouchUpInside];
        
          
           
        //[scell.btn1 setImageWithURL: [NSURL URLWithString:[self.albumNameList objectAtIndex:(indexPath.row*4) + scell.btn1.tag]] placeholderImage:self.noAlbumImage forState:UIControlStateNormal];
        [scell.imgFrm1 setImageWithURL: [NSURL URLWithString:[self.albumNameList objectAtIndex:(indexPath.row*4) + scell.btn1.tag]] placeholderImage:self.noAlbumImage ];
        
        
        //[scell.btn2 setImageWithURL: [NSURL URLWithString:[self.albumNameList objectAtIndex:(indexPath.row*4) + scell.btn2.tag]] placeholderImage:self.noAlbumImage forState:UIControlStateNormal];
        [scell.imgFrm2 setImageWithURL: [NSURL URLWithString:[self.albumNameList objectAtIndex:(indexPath.row*4) + scell.btn2.tag]] placeholderImage:self.noAlbumImage ];
        
        
        //[scell.btn3 setImageWithURL: [NSURL URLWithString:[self.albumNameList objectAtIndex:(indexPath.row*4) + scell.btn3.tag]] placeholderImage:self.noAlbumImage forState:UIControlStateNormal];
        [scell.imgFrm3 setImageWithURL: [NSURL URLWithString:[self.albumNameList objectAtIndex:(indexPath.row*4) + scell.btn3.tag]] placeholderImage:self.noAlbumImage ];
        //[scell.btn4 setImageWithURL: [NSURL URLWithString:[self.albumNameList objectAtIndex:(indexPath.row*4) + scell.btn4.tag]] placeholderImage:self.noAlbumImage forState:UIControlStateNormal];
        [scell.imgFrm4 setImageWithURL: [NSURL URLWithString:[self.albumNameList objectAtIndex:(indexPath.row*4) + scell.btn4.tag]] placeholderImage:self.noAlbumImage ];
        
        if(isEditEnabled==YES)
        {
            
            if (!self.selectedImageDict) {
                
                if ([[self.selectedImageDict valueForKey:[NSString stringWithFormat:@"%d",indexPath.row * 4 + scell.btn1.tag]] integerValue]) {
                    
                    scell.upvw1.hidden=NO;
                }else{
                    scell.upvw1.hidden=YES;
                    
                }
                
                if ([[self.selectedImageDict valueForKey:[NSString stringWithFormat:@"%d",indexPath.row * 4 + scell.btn2.tag]] integerValue]) {
                    
                    scell.upvw2.hidden=NO;
                }else{
                    scell.upvw2.hidden=YES;
                    
                }
                if ([[self.selectedImageDict valueForKey:[NSString stringWithFormat:@"%d",indexPath.row * 4 + scell.btn3.tag]] integerValue]) {
                    
                    scell.upvw3.hidden=NO;
                }else{
                    scell.upvw3.hidden=YES;
                    
                }
                if ([[self.selectedImageDict valueForKey:[NSString stringWithFormat:@"%d",indexPath.row * 4 + scell.btn4.tag]] integerValue]) {
                    
                    scell.upvw4.hidden=NO;
                }else{
                    scell.upvw4.hidden=YES;
                    
                }

                
                
            }else{
                
                scell.upvw1.hidden=YES;
                scell.upvw2.hidden=YES;
                scell.upvw3.hidden=YES;
                scell.upvw4.hidden=YES;

                
            }
        }
        else
        {
            scell.upvw1.hidden=YES;
            scell.upvw2.hidden=YES;
            scell.upvw3.hidden=YES;
            scell.upvw4.hidden=YES;

        }

        
     }
     }else{
         if(indexPath.row>=((int)(self.AllVideos.count/4)))
         {
             if(self.AllVideos.count%4==1)
             {
                 scell.vw2.hidden=YES;
                 scell.vw3.hidden=YES;
                 scell.vw4.hidden=YES;
                 
                 [scell.btn1 addTarget:self action:@selector(viewAllVideos:) forControlEvents:UIControlEventTouchUpInside];
                 
               // [scell.btn1 setImageWithURL:[NSURL URLWithString:[self.videoNameList objectAtIndex:(indexPath.row*4) + scell.btn1.tag]] placeholderImage:self.noAlbumImage forState:UIControlStateNormal];
                  [scell.imgFrm1 setImageWithURL:[NSURL URLWithString:[self.videoNameList objectAtIndex:(indexPath.row*4) + scell.btn1.tag]] placeholderImage:self.noAlbumImage ];
                 
                 
                 if(isEditEnabled==YES)
                 {
                     
                     if (!self.selectedImageDict) {
                         
                         if ([[self.selectedImageDict valueForKey:[NSString stringWithFormat:@"%d",indexPath.row * 4 + scell.btn1.tag]] integerValue]) {
                             
                             scell.upvw1.hidden=NO;
                         }else{
                             scell.upvw1.hidden=YES;
                             
                         }
                         
                     }else{
                         
                         scell.upvw1.hidden=YES;
                         
                     }
                 }
                 else
                 {
                     scell.upvw1.hidden=YES;
                     
                 }
                 
                 
             }
             else if(self.AllVideos.count%4==2)
             {
                 scell.vw3.hidden=YES;
                 scell.vw4.hidden=YES;
                 
                 [scell.btn1 addTarget:self action:@selector(viewAllVideos:) forControlEvents:UIControlEventTouchUpInside];
                 [scell.btn2 addTarget:self action:@selector(viewAllVideos:) forControlEvents:UIControlEventTouchUpInside];
                 
                 
                 
                 //[scell.btn1 setImageWithURL:[NSURL URLWithString:[self.videoNameList objectAtIndex:(indexPath.row*4) + scell.btn1.tag]] placeholderImage:self.noAlbumImage forState:UIControlStateNormal];
                 [scell.imgFrm1 setImageWithURL:[NSURL URLWithString:[self.videoNameList objectAtIndex:(indexPath.row*4) + scell.btn1.tag]] placeholderImage:self.noAlbumImage ];
                 //[scell.btn2 setImageWithURL:[NSURL URLWithString:[self.videoNameList objectAtIndex:(indexPath.row*4) + scell.btn2.tag]] placeholderImage:self.noAlbumImage forState:UIControlStateNormal];
                 [scell.imgFrm2 setImageWithURL:[NSURL URLWithString:[self.videoNameList objectAtIndex:(indexPath.row*4) + scell.btn2.tag]] placeholderImage:self.noAlbumImage ];
                 
                 
                 if(isEditEnabled==YES)
                 {
                     
                     if (!self.selectedImageDict) {
                         
                         if ([[self.selectedImageDict valueForKey:[NSString stringWithFormat:@"%d",indexPath.row * 4 + scell.btn1.tag]] integerValue]) {
                             
                             scell.upvw1.hidden=NO;
                         }else{
                             scell.upvw1.hidden=YES;
                             
                         }
                         
                         if ([[self.selectedImageDict valueForKey:[NSString stringWithFormat:@"%d",indexPath.row * 4 + scell.btn2.tag]] integerValue]) {
                             
                             scell.upvw2.hidden=NO;
                         }else{
                             scell.upvw2.hidden=YES;
                             
                         }
                         
                         
                         
                     }else{
                         
                         scell.upvw1.hidden=YES;
                         scell.upvw2.hidden=YES;
                         
                     }
                 }
                 else
                 {
                     scell.upvw1.hidden=YES;
                     scell.upvw2.hidden=YES;
                 }
                 
                 
             }
             else if(self.AllVideos.count%4==3)
             {
                 
                 scell.vw4.hidden=YES;
                 
                 [scell.btn1 addTarget:self action:@selector(viewAllVideos:) forControlEvents:UIControlEventTouchUpInside];
                 [scell.btn2 addTarget:self action:@selector(viewAllVideos:) forControlEvents:UIControlEventTouchUpInside];
                 [scell.btn3 addTarget:self action:@selector(viewAllVideos:) forControlEvents:UIControlEventTouchUpInside];
                 
               // [scell.btn1 setImageWithURL: [NSURL URLWithString:[self.videoNameList objectAtIndex:(indexPath.row*4) + scell.btn1.tag]] placeholderImage:self.noAlbumImage forState:UIControlStateNormal];
                 [scell.imgFrm1 setImageWithURL: [NSURL URLWithString:[self.videoNameList objectAtIndex:(indexPath.row*4) + scell.btn1.tag]] placeholderImage:self.noAlbumImage ];
                // [scell.btn2 setImageWithURL: [NSURL URLWithString:[self.videoNameList objectAtIndex:(indexPath.row*4) + scell.btn2.tag]] placeholderImage:self.noAlbumImage forState:UIControlStateNormal];
                 [scell.imgFrm2 setImageWithURL: [NSURL URLWithString:[self.videoNameList objectAtIndex:(indexPath.row*4) + scell.btn2.tag]] placeholderImage:self.noAlbumImage ];
                 //[scell.btn3 setImageWithURL: [NSURL URLWithString:[self.videoNameList objectAtIndex:(indexPath.row*4) + scell.btn3.tag]] placeholderImage:self.noAlbumImage forState:UIControlStateNormal];
                 [scell.imgFrm3 setImageWithURL: [NSURL URLWithString:[self.videoNameList objectAtIndex:(indexPath.row*4) + scell.btn3.tag]] placeholderImage:self.noAlbumImage ];
                 
                 if(isEditEnabled==YES)
                 {
                     
                     if (!self.selectedImageDict) {
                         
                         if ([[self.selectedImageDict valueForKey:[NSString stringWithFormat:@"%d",indexPath.row * 4+ scell.btn1.tag]] integerValue]) {
                             
                             scell.upvw1.hidden=NO;
                         }else{
                             scell.upvw1.hidden=YES;
                             
                         }
                         
                         if ([[self.selectedImageDict valueForKey:[NSString stringWithFormat:@"%d",indexPath.row + scell.btn2.tag]] integerValue]) {
                             
                             scell.upvw2.hidden=NO;
                         }else{
                             scell.upvw2.hidden=YES;
                             
                         }
                         if ([[self.selectedImageDict valueForKey:[NSString stringWithFormat:@"%d",indexPath.row * 4+ scell.btn3.tag]] integerValue]) {
                             
                             scell.upvw3.hidden=NO;
                         }else{
                             scell.upvw3.hidden=YES;
                             
                         }
                         
                     }else{
                         
                         scell.upvw1.hidden=YES;
                         scell.upvw2.hidden=YES;
                         scell.upvw3.hidden=YES;
                         
                     }
                 }
                 else
                 {
                     scell.upvw1.hidden=YES;
                     scell.upvw2.hidden=YES;
                     scell.upvw3.hidden=YES;
                     
                 }
                 
             }
             
         }
         else
         {
             [scell.btn1 addTarget:self action:@selector(viewAllVideos:) forControlEvents:UIControlEventTouchUpInside];
             [scell.btn2 addTarget:self action:@selector(viewAllVideos:) forControlEvents:UIControlEventTouchUpInside];
             [scell.btn3 addTarget:self action:@selector(viewAllVideos:) forControlEvents:UIControlEventTouchUpInside];
             [scell.btn4 addTarget:self action:@selector(viewAllVideos:) forControlEvents:UIControlEventTouchUpInside];
             
             
             
             /*[scell.btn1 setImageWithURL: [NSURL URLWithString:[self.videoNameList objectAtIndex:(indexPath.row*4) + scell.btn1.tag]] placeholderImage:self.noAlbumImage forState:UIControlStateNormal];
             [scell.btn2 setImageWithURL: [NSURL URLWithString:[self.videoNameList objectAtIndex:(indexPath.row*4) + scell.btn2.tag]] placeholderImage:self.noAlbumImage forState:UIControlStateNormal];
             [scell.btn3 setImageWithURL: [NSURL URLWithString:[self.videoNameList objectAtIndex:(indexPath.row*4) + scell.btn3.tag]] placeholderImage:self.noAlbumImage forState:UIControlStateNormal];
             [scell.btn4 setImageWithURL: [NSURL URLWithString:[self.videoNameList objectAtIndex:(indexPath.row*4) + scell.btn4.tag]] placeholderImage:self.noAlbumImage forState:UIControlStateNormal];*/
             [scell.imgFrm1 setImageWithURL: [NSURL URLWithString:[self.videoNameList objectAtIndex:(indexPath.row*4) + scell.btn1.tag]] placeholderImage:self.noAlbumImage ];
             [scell.imgFrm2 setImageWithURL: [NSURL URLWithString:[self.videoNameList objectAtIndex:(indexPath.row*4) + scell.btn2.tag]] placeholderImage:self.noAlbumImage ];
             [scell.imgFrm3 setImageWithURL: [NSURL URLWithString:[self.videoNameList objectAtIndex:(indexPath.row*4) + scell.btn3.tag]] placeholderImage:self.noAlbumImage ];
             [scell.imgFrm4 setImageWithURL: [NSURL URLWithString:[self.videoNameList objectAtIndex:(indexPath.row*4) + scell.btn4.tag]] placeholderImage:self.noAlbumImage ];
             
             if(isEditEnabled==YES)
             {
                 
                 if (!self.selectedImageDict) {
                     
                     if ([[self.selectedImageDict valueForKey:[NSString stringWithFormat:@"%d",indexPath.row * 4+ scell.btn1.tag]] integerValue]) {
                         
                         scell.upvw1.hidden=NO;
                     }else{
                         scell.upvw1.hidden=YES;
                         
                     }
                     
                     if ([[self.selectedImageDict valueForKey:[NSString stringWithFormat:@"%d",indexPath.row * 4+ scell.btn2.tag]] integerValue]) {
                         
                         scell.upvw2.hidden=NO;
                     }else{
                         scell.upvw2.hidden=YES;
                         
                     }
                     if ([[self.selectedImageDict valueForKey:[NSString stringWithFormat:@"%d",indexPath.row * 4 + scell.btn3.tag]] integerValue]) {
                         
                         scell.upvw3.hidden=NO;
                     }else{
                         scell.upvw3.hidden=YES;
                         
                     }
                     if ([[self.selectedImageDict valueForKey:[NSString stringWithFormat:@"%d",indexPath.row * 4 + scell.btn4.tag]] integerValue]) {
                         
                         scell.upvw4.hidden=NO;
                     }else{
                         scell.upvw4.hidden=YES;
                         
                     }
                     
                     
                 }else{
                     
                     scell.upvw1.hidden=YES;
                     scell.upvw2.hidden=YES;
                     scell.upvw3.hidden=YES;
                     scell.upvw4.hidden=YES;
                     
                     
                 }
             }
             else
             {
                 scell.upvw1.hidden=YES;
                 scell.upvw2.hidden=YES;
                 scell.upvw3.hidden=YES;
                 scell.upvw4.hidden=YES;
                 
             }
             
             
         }

         
         
     }
        
        
   }
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isiPad) {
        return 130.0f;
    }
    return 76.0f;
}


- (IBAction)custompopupbTapped:(id)sender
{
    
    int filterNum=[sender tag];
    
    if(filterNum==0)
    {
        isAscendingDate=1;
        [self showDatePicker:sender];
        
    }
    else if(filterNum==1)
    {
        isAscendingDate=0;
        [self showDatePicker:sender];
        
    }
    else if(filterNum==2)
    {
        self.pickerContainerView.hidden=NO;
        [self.view bringSubviewToFront:self.pickerContainerView];
        self.Selectedtag=103;
        self.isName=YES;
        self.isTeam=NO;
        self.isDate=NO;
        self.teamSelectEdRow=0;
        [self.picker reloadAllComponents];
        
    }
    else if(filterNum==3)
    {
        self.pickerContainerView.hidden=NO;
        [self.view bringSubviewToFront:self.pickerContainerView];
        self.Selectedtag=101;
        self.isName=NO;
        self.isTeam=YES;
        self.isDate=NO;
        self.userSelectedRow=0;
        [self.picker reloadAllComponents];
        
    }
    else if(filterNum==4)
    {
        /*self.pickerContainerView.hidden=NO;
        [self.view bringSubviewToFront:self.pickerContainerView];
        self.Selectedtag=101;
        self.isName=NO;
        self.isTeam=YES;
        self.isDate=NO;
        self.userSelectedRow=0;
        [self.picker reloadAllComponents];*/
        
        self.isTeam=YES;
        self.sportName=@"All Teams";
        [self filterAllData];
        
    }
   
    
    
    [self hideCustomPopupTapped:nil];
}

- (IBAction)hideCustomPopupTapped:(id)sender
{
    
    self.custompopupbottomvw.hidden=YES;
    self.custompopuptopselectionvw.hidden=YES;
}

- (IBAction)popuptapped:(id)sender {
    self.popupalertvw.hidden=YES;
    self.popupalertvwback.hidden=YES;
    
}






//// facebook sdk change 8th july

/*
- (void)facebookLoginActionP
{
    
    
    if (![[FBSession activeSession] isOpen])
    {
        appDelegate.isFromAlbumForVideoPost=1;
        [appDelegate openSessionWithAllowLoginUI:YES];
    }
    else
    {
        [self sessionStateOpen:nil];
    }
    
    
    
    
    
    //
    
    //[FBRequest requestWithGraphPath:<#(NSString *)#> parameters:<#(NSDictionary *)#> HTTPMethod:<#(NSString *)#>];
}

-(void)sessionStateOpen:(id)notiobject
{
    
    
    if(!appDelegate.isFromAlbumForVideoPost)
    {
        return;
    }
    
    
    
    
    
    if ([[FBSession activeSession] isOpen])
    {
        
        [self performSelector:@selector(requestVideoPost) withObject:nil afterDelay:0.0];
    }
    
}

//// facebook sdk change 8th july

-(void)sessionStateOpenExtended:(id)notiobject
{
    if(!appDelegate.isFromAlbumForVideoPost)
    {
        return;
    }
    
    
    if ([[FBSession activeSession] isOpen])
    {
       
        [self performSelector:@selector(fetchingUserData) withObject:nil afterDelay:0.0];
    }
    
}


-(void)fetchingUserData
{
    appDelegate.isFromAlbumForVideoPost=0;
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
   dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        //Background Thread
        
       NSData *videoData =[NSData dataWithContentsOfURL:[NSURL URLWithString:self.selVideoPath]];
       
       
       dispatch_sync(dispatch_get_main_queue(), ^(void){
            //Run UI Updates
            NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           videoData,@"video.mp4",
                                           @"video/quicktime",@"contentType",
                                           @"",@"title",
                                           @"",@"description",
                                           nil];
            
            
            [FBRequestConnection startWithGraphPath:@"me/videos" parameters:params HTTPMethod:@"POST" completionHandler:^(FBRequestConnection *connection, id result, NSError *error)
             
             {
                 
                 [self hideHudView];
                 
                 self.selVideoPath=nil;
                 
                 [self showAlertViewCustom];
                 [self setRightBarButtonItemText:@"Select"];
                 isEditEnabled=NO;
                 self.selectedImageDict=nil;
                 
                 self.selVideoPath=nil;
                 self.printView.hidden=YES;
                 self.shareView.hidden=YES;
                 self.sharevwmain.hidden=YES;
                 [self.tableVw reloadData];
                 
             }];
            
            
        });
       
       videoData=nil;
       
    });
}

-(void)requestVideoPost
{
    NSArray* permissions = [[NSArray alloc] initWithObjects:
                            @"publish_stream",@"publish_actions", nil];
    
    [[FBSession activeSession] requestNewPublishPermissions:permissions defaultAudience:FBSessionDefaultAudienceEveryone completionHandler:^(FBSession *session, NSError *error) {
        
        
        
    }];
}
*/

@end
