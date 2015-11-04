//
//  AddVideoViewController.m
//  Wall
//
//  Created by Sukhamoy on 10/12/13.
//
//

#import "AddVideoViewController.h"
#import "SportViewController.h"
@interface AddVideoViewController ()

@end

@implementation AddVideoViewController
@synthesize isCreated;
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
    self.view.backgroundColor=appDelegate.backgroundPinkColor;
    self.topview.backgroundColor=appDelegate.barGrayColor;
    
    
    self.sportNameArr=[NSMutableArray arrayWithObjects:@"Baseball",@"Basketball",@"Cricket",@"Football",@"Hockey",@"Lacrosse",@"Soccer",@"Volleyball", nil];
    self.firstView.layer.cornerRadius=3.0f;
    [self.firstView.layer setMasksToBounds:YES];
    
    self.uploadVideoView.layer.cornerRadius=3.0f;
    [self.uploadVideoView.layer setMasksToBounds:YES];
    
    self.videoLink.layer.cornerRadius=3.0f;
    [self.videoLink.layer setMasksToBounds:YES];
    self.segment.selectedSegmentIndex=1;

    if (isCreated) {
        
        self.uploadVideoView.hidden=YES;
        self.videoLink.hidden=YES;
        self.isLink=0;

    }else{
        
        self.firstView.hidden=YES;
        
        NSArray *arr=[[self.editVideoDict valueForKey:@"video_link"] componentsSeparatedByString:@"."];
        
        if (arr.count>1){
            
            if ([[arr objectAtIndex:1] isEqualToString:@"mp4"]){
                
                self.uploadVideoView.hidden=NO;
                self.videoLink.hidden=YES;
                self.videoTeamName.text=[self.editVideoDict valueForKey:@"tag_name"];
                self.videoSportName.text=[self.editVideoDict valueForKey:@"sports_name"];
                NSString *imgUrl=  [NSString stringWithFormat:@"%@%@",TRAININGVIDEOTHUMB,[self.editVideoDict valueForKey:@"video_thumb"]];
                self.thumpImageView.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]]];
                NSString *outputurl= [NSString stringWithFormat:@"%@%@",TRANINGVEDIOLINK,[self.editVideoDict valueForKey:@"video_link"]];
                self.dataVideo=[NSData dataWithContentsOfURL:[NSURL URLWithString:outputurl]];
                self.isLink=1;

                
            }else{
                
                self.isLink=2;
                self.uploadVideoView.hidden=YES;
                self.videoLink.hidden=NO;
                self.linkTeamName.text=[self.editVideoDict valueForKey:@"tag_name"];
                self.linkSportName.text=[self.editVideoDict valueForKey:@"sports_name"];
                self.urlTxt.text=[self.editVideoDict valueForKey:@"video_link"];

            }
            
        }else{
            self.isLink=2;
            self.uploadVideoView.hidden=YES;
            self.videoLink.hidden=NO;
            self.linkTeamName.text=[self.editVideoDict valueForKey:@"tag_name"];
            self.linkSportName.text=[self.editVideoDict valueForKey:@"sports_name"];
            self.urlTxt.text=[self.editVideoDict valueForKey:@"video_link"];

        }

    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UploadVideo To Server

- (IBAction)done:(id)sender {
    
  
    
    
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    
    if (isCreated) {
        
        [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
 
    }else{
       
        [command setObject:[self.editVideoDict valueForKey:@"training_id"] forKey:@"training_id"];

    }
    
    
    
    if (!self.firstView.isHidden) {
        
        [command setObject:self.sportTxt.text forKey:@"sports_name"];
        [command setObject:self.nameTxt.text forKey:@"tag_name"];
        
        NSString *tmp=[[self.nameTxt text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        
        if ([tmp  isEqualToString:@""] )
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Please Enter Video Name" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
            [alert show];
            return;
        }
        
        NSString *tmp1=[[self.sportTxt text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        
        if ([tmp1  isEqualToString:@""] )
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Please Select Sport Name" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
            [alert show];
            return;
        }



        
    }else if(!self.uploadVideoView.hidden){
        
        [command setObject:self.videoTeamName.text forKey:@"tag_name"];
        [command setObject:self.videoSportName.text forKey:@"sports_name"];
        
        NSString *tmp=[[self.videoTeamName text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        
        if ([tmp  isEqualToString:@""] )
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Please Enter Video Name" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
            [alert show];
            return;
        }
        
        NSString *tmp1=[[self.videoSportName text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        
        if ([tmp1  isEqualToString:@""] )
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Please Select Sport Name" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
            [alert show];
            return;
        }

        
    }else if (!self.videoLink.hidden){
        
        [command setObject:self.linkTeamName.text forKey:@"tag_name"];
        [command setObject:self.linkSportName.text forKey:@"sports_name"];
        
        NSString *tmp=[[self.linkTeamName text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        
        if ([tmp  isEqualToString:@""] )
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Please Enter Video Name" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
            [alert show];
            return;
        }
        
        NSString *tmp1=[[self.linkSportName text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        
        if ([tmp1  isEqualToString:@""] )
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Please Select Sport Name" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Okay", nil];
            [alert show];
            return;
        }

    }

        
    if (self.segment.selectedSegmentIndex==1) {
        [command setObject:@"Public" forKey:@"privacy"];
    }else{
        [command setObject:@"Private" forKey:@"privacy"];
    }
    
    if (self.isLink) {
        
         [command setObject:self.urlTxt.text forKey:@"video_link"];
        
    }else{
        
         [command setObject:@"" forKey:@"video_link"];
    }
       
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    
    if (self.isLink) {
         [self sendRequestForPost:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
        
    }else{
         [self sendRequestForPost:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam",UIImageJPEGRepresentation(self.thumpImageView.image,1.0),@"video_thumb",self.dataVideo,@"training_video", nil]];
    }
    
    
}


-(void)sendRequestForPost:(NSDictionary*)dic
{
    
    NSLog(@"dictiony %@",[dic allKeys]);
    NSURL* url=nil;
     if (isCreated) {
         
        url = [NSURL URLWithString:ADDTRAININGVIDEO];
         
     }else{
         
         url = [NSURL URLWithString:TRAININGVIDEOEDIT];
         
     }
    
    ASIFormDataRequest *aRequest=  [[ASIFormDataRequest alloc] initWithURL:url] ;
    self.myFormRequest1=aRequest;
    [self.storeCreatedRequests addObject:self.myFormRequest1];
    
    
    [aRequest setShouldContinueWhenAppEntersBackground:YES];
    
    [aRequest setDelegate:self];
  
    [aRequest setValidatesSecureCertificate:NO];
    [ASIFormDataRequest setShouldThrottleBandwidthForWWAN:YES];
    
       
    
    if([[dic allKeys] count]>1)
    {
        
        [aRequest addPostValue:[dic objectForKey:[[dic allKeys] objectAtIndex:1]] forKey:[[dic allKeys] objectAtIndex:1]];
        
        [aRequest setPostFormat:ASIMultipartFormDataPostFormat];
        [aRequest addRequestHeader:@"Content-Type" value:@"multipart/form-data"];
        
        [aRequest addData:[dic objectForKey:[[dic allKeys] objectAtIndex:2]] withFileName:@"user.jpg" andContentType:@"image/*" forKey:[[dic allKeys] objectAtIndex:2]];
        
        [aRequest addData:[dic objectForKey:[[dic allKeys] objectAtIndex:0]] withFileName:@"socialTrainingVideo.mp4" andContentType:@"multipart/form-data" forKey:[[dic allKeys] objectAtIndex:0]];
      

                    
    }
    else
    {
             
        [aRequest addPostValue:[dic objectForKey:[[dic allKeys] objectAtIndex:0]] forKey:[[dic allKeys] objectAtIndex:0]];
                
    }
            
            
        
    [aRequest setDidFinishSelector:@selector(requestFinished:)];
    [aRequest setDidFailSelector:@selector(requestFailed:)];
    
    [aRequest startAsynchronous];
    
}


- (void)requestFinished:(ASIHTTPRequest *)request
{
	NSLog(@"Data Received in Connection Manager.... %@ ",[request responseString]);
    // [self hideActiveIndicatorOwnPost];
    [self hideNativeHudView];
    [self hideHudView];
    
    NSString *str=[request responseString];
    
    NSLog(@"Data=%@",str);
    
    
    
    if (str)
    {
        SBJsonParser *parser=[[SBJsonParser alloc] init];
        
        id res = [parser objectWithString:str];
        if ([res isKindOfClass:[NSDictionary class]])
        {
            NSDictionary* aDict = (NSDictionary*) res;
            // aDict=[aDict objectForKey:@"responseData"];
            
            
            if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                [self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
            }
        }
    }
    
    
	
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
   
    [self hideNativeHudView];
    [self hideHudView];
	[self showAlertMessage:CONNFAILMSG];
	
}


- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)enterVideoLink:(id)sender {
    
    if (self.isLink==0 || self.isLink==1) {
        
        self.urlTxt.placeholder=@"URL";
        if (!self.firstView.isHidden) {
            
            self.linkTeamName.text=self.nameTxt.text;
            self.linkSportName.text=self.sportTxt.text;
            
        }else{
            self.linkTeamName.text=self.videoTeamName.text;
            self.linkSportName.text=self.videoSportName.text;
        }
        
        [self.urlTxt becomeFirstResponder];
        self.isLink=2;
        self.videoLink.hidden=NO;
        self.firstView.hidden=YES;
        self.uploadVideoView.hidden=YES;
        
        
    }
 
}

- (IBAction)uploadVideo:(id)sender {
    
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Upload Video",@"Enter Link",nil];
//    actionSheet.tag=[sender tag];
//    [actionSheet  showInView:self.view];
    [self.urlTxt resignFirstResponder];
    
    if (self.isLink==0 || self.isLink==2) {
        
        if (!self.firstView.isHidden) {
            
            self.videoTeamName.text=self.nameTxt.text;
            self.videoSportName.text=self.sportTxt.text;
            
        }else{
            self.videoTeamName.text=self.linkTeamName.text;
            self.videoSportName.text=self.linkSportName.text;
        }
        
        self.isShowTrainningVideoOption=0;
        [self takeVideo];
        self.isLink=1;
        self.thumpImageView.image=self.noVideThumbImage;
        self.uploadVideoView.hidden=NO;
        self.firstView.hidden=YES;
        self.videoLink.hidden=YES;
        self.urlTxt.text=@"";
    }

  
    
}

- (IBAction)segmentValueChange:(id)sender {
    
    
}

- (IBAction)selectedSport:(id)sender {
    
    
    SportViewController *sport=[[SportViewController alloc] initWithNibName:@"SportViewController" bundle:nil];
    [sport setSportBlock:^(NSString *sportName){
        
        if (!self.firstView.isHidden) {
            
            self.sportTxt.text=sportName;
            
        }else if(!self.uploadVideoView.hidden){
            
            self.videoSportName.text=sportName;
            
        }else if (!self.videoLink.hidden){
            
            self.linkSportName.text=sportName;

        }
        
    }];
    sport.sportArr=self.sportNameArr;
    [self presentViewController:sport animated:YES completion:nil];

}
#pragma mark - ActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (actionSheet==self.camActionSheet) {
        
        [super actionSheet:actionSheet clickedButtonAtIndex:buttonIndex];
        return;
    }
    NSString *choice = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if ([choice isEqualToString:@"Upload Video"]) {
        
        if (!self.firstView.isHidden) {
            
            self.videoTeamName.text=self.nameTxt.text;
            self.videoSportName.text=self.sportTxt.text;
            
        }else{
            self.videoTeamName.text=self.linkTeamName.text;
            self.videoSportName.text=self.linkSportName.text;
        }
      
          self.isShowTrainningVideoOption=0;
        [self takeVideo];
        self.isLink=NO;
        self.thumpImageView.image=self.noVideThumbImage;
        self.uploadVideoView.hidden=NO;
        self.firstView.hidden=YES;
        self.videoLink.hidden=YES;
        
        
    }else if([choice isEqualToString:@"Enter Link"]){
        
        self.urlTxt.placeholder=@"URL";
        if (!self.firstView.isHidden) {
            
            self.linkTeamName.text=self.nameTxt.text;
            self.linkSportName.text=self.sportTxt.text;
            
        }else{
            self.linkTeamName.text=self.videoTeamName.text;
            self.linkSportName.text=self.videoSportName.text;
        }

        [self.urlTxt becomeFirstResponder];
        self.isLink=YES;
        self.videoLink.hidden=NO;
        self.firstView.hidden=YES;
        self.uploadVideoView.hidden=YES;

    }
}

#pragma mark - TakeVideo
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)  picker
{
    [super imagePickerControllerDidCancel:picker];
    self.camActionSheet=nil;
    [appDelegate setHomeView];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissModal];
    [appDelegate setHomeView];
    NSString *choice = [self.camActionSheet buttonTitleAtIndex:0];
    if ([choice isEqualToString:@"Take Video"] || [choice isEqualToString:@"Choose From Library "])
    {
        @autoreleasepool {
            
            
            NSURL *outputurl=nil;
            
            NSURL *videoURL=[info objectForKey:UIImagePickerControllerMediaURL];
            outputurl=videoURL;
            self.dataVideo=[NSData dataWithContentsOfURL:outputurl];
            self.thumpImageView.image=[self getThumnailForVideo:[info objectForKey:UIImagePickerControllerMediaURL]];
        
            /*NSURL *aUrl=  [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"]];
             NSLog(@"VideoPath=%@",aUrl);
             self.dataVideo=[NSData dataWithContentsOfURL:aUrl];*/
            
            ///////////////
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:@"socialvideo.mp4"];
            [[NSFileManager defaultManager] removeItemAtPath:savedImagePath error:nil];
            
            // __block NSData *videoData=nil;
            
            
            AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:videoURL options:nil];
            
            NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
            [self showHudView:@"Converting..."];
            if ([compatiblePresets containsObject:AVAssetExportPresetMediumQuality])
                
            {
                
                AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
                
                outputurl=[NSURL fileURLWithPath:savedImagePath];
                
                exportSession.outputURL = outputurl;
                
                exportSession.outputFileType = AVFileTypeMPEG4;
                
                /* CMTime start = CMTimeMakeWithSeconds(1.0, 600);
                 
                 CMTime duration = CMTimeMakeWithSeconds(3.0, 600);
                 
                 CMTimeRange range = CMTimeRangeMake(start, duration);
                 
                 exportSession.timeRange = range;*/
                
                
                
                [exportSession exportAsynchronouslyWithCompletionHandler:^{
                    
                    
                    switch ([exportSession status]) {
                            
                            
                            
                            
                            /*case AVAssetExportSessionStatusFailed:
                             NSLog(@"Export failed: %@", [[exportSession error] localizedDescription]);
                             
                             break;
                             
                             case AVAssetExportSessionStatusCancelled:
                             
                             NSLog(@"Export canceled");
                             
                             break;
                             case AVAssetExportSessionStatusExporting:
                             
                             NSLog(@"Export exporting");
                             
                             break;*/
                        case AVAssetExportSessionStatusCompleted:
                            
                            NSLog(@"Export completed");
                            /* videoData=[NSData dataWithContentsOfURL:outputurl];
                             self.dataVideo=videoData;*/
                            
                            [self loadVideoAfterConvert:outputurl];
                            
                            [self finishedVideoConvert];
                            
                            
                            
                            break;
                            
                            
                        default:
                            NSLog(@"Export Default");
                            [self finishedVideoConvert];
                            break;
                            
                    }
                    
                    
                }];
                
            }
            else
            {
                [self finishedVideoConvert];
                
                
                
                
                
            }
            
                    
            ///////////////
        }
        info=nil;
        self.camActionSheet=nil;
    }
   }



-(void)finishedVideoConvert
{
    
    [self hideHudView];
}


-(void)loadVideoAfterConvert:(NSURL*)outputurl
{
    
    @autoreleasepool {
        
        
        
        
        NSData *videoData= [NSData dataWithContentsOfURL:outputurl];
        self.dataVideo=videoData;
    }
}

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

#pragma mark - TextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
   
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


@end
