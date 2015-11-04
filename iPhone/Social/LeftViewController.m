  //
//  LeftViewController.m
//  Social
//
//  Created by Mindpace on 12/08/13.
//
//
#import "LoginPageViewController.h"
#import "UIImage+FixRotation.h"
#import "HFImageEditorViewController.h"
#import "TeamEventsVC.h"
#import "FeedBackViewController.h"
#import "ToDoByEventsVC.h"
#import "EventCalendarViewController.h"
#import "CalendarViewController.h"
#import "RightViewController.h"
#import "TeamMaintenanceVC.h"
#import "AddAFriend.h"
#import "SettingsViewController.h"
#import "HomeVC.h"
#import "LeftVCTableCell.h"
#import "LeftViewController.h"
#import "CenterViewController.h"
#import "ClubLeagueViewController.h"
#import "ShowVideoViewController.h"
#import "TeamPlayerViewController.h"
#import "PhotoMainVC.h"
#import "FirstLoginViewController.h"

@interface LeftViewController ()

@end

@implementation LeftViewController


@synthesize dataArray,orgImage,isConnectionProgressing/*,userImainfo*/,isSelectedImage,profpicloadingimainfo;

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
    
    self.view.backgroundColor=appDelegate.leftPanelGrayColor;
    
      self.userNameLbl.text=@"";
    
     // Do any additional setup after loading the view from its nib.
    
    @autoreleasepool {
        self.noImage=[UIImage imageNamed:@"leftpanelavatar.png"];
    }
    
    
    self.donebt.hidden=YES;
    self.crossbt.hidden=YES;
   
    storeCreatedRequests=[[NSMutableArray alloc] init];
    
      isConnectionProgressing=0;
     [self.avatarimavw cleanPhotoFrame ];
    self.avatarimavw.image=self.noImage;
     self.leftvctappiclab.hidden=NO;
       self.isSelectedImage=0;
    self.view.backgroundColor=self.darkGrayColor;
   // self.view.layer.cornerRadius=0.0;
    
  //  [self setCalibriFont:self.searchtf withSize:14.0  ];
    
    NSMutableArray *marr=[[NSMutableArray alloc] initWithObjects:/*@"WALL",@"TEAM ROSTER",@"MY CALENDAR",*//*@"LEAGUE/CLUB",*//*@"TEAM EVENTS",@"TEAM ADMIN",*//*@"BUY/SELL",*//*@"TRAINING VIDEOS"*/@"Albums",@"Settings", @"Help",@"FAQ",@"Tutorial",@"Logout",nil];
    self.dataArray=marr;
    
    
    self.userNameLbl.text=[NSString stringWithFormat:@"%@ %@",[appDelegate.aDef objectForKey:FIRSTNAME],[appDelegate.aDef objectForKey:LASTNAME]];
    
    
    [self.tableView reloadData];
}

-(void)loadVC
{
    self.userNameLbl.text=[NSString stringWithFormat:@"%@ %@",[appDelegate.aDef objectForKey:FIRSTNAME],[appDelegate.aDef objectForKey:LASTNAME]];
    
    if(appDelegate.faceBookImageData)
    {
        [self sendImageChangeNewForFaceBook];
    }
    
    
}
-(void)resetVC
{
     [self.avatarimavw cleanPhotoFrame ];
    self.avatarimavw.image=self.noImage;
     self.leftvctappiclab.hidden=NO;
    self.userNameLbl.text=@"";
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageUpdated:) name:LEFTCONTROLLERIMAGELOADED object:nil];
    
  
    
    
    
    [self loadImage];
    
}


-(void)loadImage
{
    if((![self.appDelegate.aDef objectForKey:ISFETCHUSERPROFILEURL]) || [self.avatarimavw.image isEqual:self.noImage])
    {
        if([self.appDelegate.aDef objectForKey:USERPROFILEURL])
        {
            /*if([self.avatarimavw.image isEqual:self.noImage])
             {*/
            NSLog(@"IMAGELINKPROFILE=%@",[ NSString stringWithFormat:@"%@%@", IMAGELINK,[appDelegate.aDef objectForKey:USERPROFILEURL ] ]);
            
            
            
            ImageInfo *userImainfo=  [[ImageInfo alloc] initWithSourceURL:[NSURL URLWithString:[ NSString stringWithFormat:@"%@%@", IMAGELINK,[appDelegate.aDef objectForKey:USERPROFILEURL ] ]]] ;
            
            self.profpicloadingimainfo=userImainfo;
            [self.storeCreatedRequests addObject:userImainfo];
            userImainfo.notificationName=LEFTCONTROLLERIMAGELOADED;
            userImainfo.notifiedObject=self;
            
                   if(!userImainfo.isProcessing)
            [userImainfo getImage];
            
            /*  [cell1.userima setImage:info.image   ];
             */
            //}
        }
        
    }
}

- (void)imageUpdated:(NSNotification *)notif
{
      [appDelegate setUserDefaultValue:@"1" ForKey:ISFETCHUSERPROFILEURL];
     [self.avatarimavw applyPhotoFrame ];
    self.avatarimavw.image=self.orgImage;
     self.leftvctappiclab.hidden=YES;
    appDelegate.userOwnImage=self.orgImage;
    
    self.isSelectedImage=1;
   /* if(image1)
    {
        self.avatarimavw.image=image1;
        
        
        if(self.editbtn.hidden==YES)
        {
            self.isSelectedImage=1;
            
            self.crossbT.hidden=NO;
        }
        else
        {
            self.isSelectedImage=0;
            
            self.crossbT.hidden=YES;
        }
        
        
    }
    else
    {
        self.avatarimavw.image=self.noImage;
        
        self.isSelectedImage=0;
        
        self.crossbT.hidden=YES;
    }*/
    
    
    
    
    
    
    
    
    
    [appDelegate.centerVC setPostAvatarsImage:self.orgImage :nil];
    
 
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)  picker
{
    
    [super imagePickerControllerDidCancel:picker];
    
    self.camActionSheet=nil;
    //[appDelegate setHomeView];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
  
    
   
    UIImage *originalImage = nil, *editedImage = nil, *imageToSave = nil;
    
    editedImage = (UIImage *) [info objectForKey:
                               UIImagePickerControllerEditedImage];
    originalImage = (UIImage *) [info objectForKey:
                                 UIImagePickerControllerOriginalImage];
    
    if (editedImage) {
        imageToSave = [editedImage imageWithFixedRotation];
    } else {
        imageToSave = [originalImage imageWithFixedRotation];
    }
    ///////////////////////////Image Cropping
    HFImageEditorViewController *imageEditor=nil;
    
    if(appDelegate.isIphone5)
    {
    imageEditor = [[HFImageEditorViewController alloc] initWithNibName:@"HFImageEditorViewController_568" bundle:nil] ;
    }
    else
    {
        imageEditor = [[HFImageEditorViewController alloc] initWithNibName:@"HFImageEditorViewController" bundle:nil] ; 
    }
    imageEditor.cropSize = CGSizeMake(200, 200);
    imageEditor.sourceImage = imageToSave;
    imageEditor.previewImage = imageToSave;
    [imageEditor reset:NO];
    
    imageEditor.doneCallback = ^(UIImage *newImage, BOOL canceled){
        
        [UIApplication sharedApplication].statusBarHidden=NO;

        if(!canceled) {
            
            isSelectedImage=1;
            
            @autoreleasepool
                {
                
                UIImage *ima1=nil;
                ima1=newImage;
                    
                     [self.avatarimavw applyPhotoFrame ];
                self.avatarimavw.image=[self getImage:ima1 isWidth:0 length:60  ] ;
                self.leftvctappiclab.hidden=YES;
                ima1=nil;
                }
            
            [self sendImageChangeNew];
        }
                   
        [self dismissModal];
        self.camActionSheet=nil;
        
    };
    
    [picker pushViewController:imageEditor animated:YES];
    [picker setNavigationBarHidden:NO];
    
    
    
    
    
    
    
    ////////////////////////////
    
   info=nil;
   /* self.camActionSheet=nil;*///Ch
    
    
    
    
    
  //  [self dismissModal];//Ch
    
    
 
    
    
  
    
    
    ///////
    
    
     // [self sendImageChangeNew];//Ch
    /////
 
    
}



-(void)sendImageChangeNewForFaceBook
{
    BOOL fl=0;
    
    if(appDelegate.faceBookImageData)
    {
        UIImage *ima=[[UIImage alloc] initWithData:appDelegate.faceBookImageData];
        
        
        
        if(ima)
        {
            isSelectedImage=1;
            
            @autoreleasepool
            {
                
                UIImage *ima1=nil;
                ima1=ima;
                
                 [self.avatarimavw applyPhotoFrame ];
                self.avatarimavw.image=[self getImage:ima1 isWidth:0 length:60  ] ;
                self.leftvctappiclab.hidden=YES;
                ima1=nil;
                
                fl=1;
            }
        }
        
        
        
        ima=nil;
    }
    
   
    appDelegate.faceBookImageData=nil;
    
    if(fl)
    {
        
        if(self.hudFlag1)
        {
            return;
        }
        
   /* NSMutableDictionary *command = [NSMutableDictionary dictionary];
    [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
    if(isSelectedImage==0 && (!appDelegate.userOwnImage ))
        [command setObject:@"Y" forKey:@"delete_image"];
    else
        [command setObject:@"N" forKey:@"delete_image"];*/
        
        NSMutableDictionary *command = [NSMutableDictionary dictionary];
        command = [[self configureReqParamDict] mutableCopy];
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    //[self showHudView:@"Connecting..."];
    [self showNativeHudView];
        self.hudFlag1=1;
    self.requestDic=command;
    
    
    if(isSelectedImage==1)
        [self sendRequestForImageChange:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam",UIImageJPEGRepresentation(self.avatarimavw.image,0.5),@"ProfileImage", nil]];
    else
        [self sendRequestForImageChange:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
        
    }
    
    
}


///////Test
-(void)sendRequestForImageChangeWithAFNetWorking:(NSDictionary*)dic
{
   //http://www.sportsly.co/wscontroller/EditProfile
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL: [NSURL URLWithString:@"http://www.sportsly.co"]]; // replace BASEURL
    client.parameterEncoding = AFJSONParameterEncoding;
    
    NSMutableURLRequest *request = [client multipartFormRequestWithMethod:@"POST" path:@"/wscontroller/EditProfile" parameters:nil constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
   
        
        
        if([[dic allKeys] count]>0)
        {
            
            
            for(int i=0;i<[[dic allKeys] count];i++)
            {
                NSLog(@"RequestParam=%@",[[dic allKeys] objectAtIndex:i]);
                
                if([[[dic allKeys] objectAtIndex:i] isEqualToString:@"ProfileImage" ])
                {
                    if([[[dic allKeys] objectAtIndex:i] isEqualToString:@"video"])
                    {
                        
                          [formData appendPartWithFileData:[dic objectForKey:[[dic allKeys] objectAtIndex:i]] name:[[dic allKeys] objectAtIndex:i] fileName:@"user" mimeType:@"video/*"];
                    }
                    else
                    {
                        
                         [formData appendPartWithFileData:[dic objectForKey:[[dic allKeys] objectAtIndex:i]] name:[[dic allKeys] objectAtIndex:i] fileName:@"user.jpg" mimeType:@"image/*"];
                        
                    }

        
                }
                else
                {
                    [formData appendPartWithFormData:[[dic objectForKey:[[dic allKeys] objectAtIndex:i]] dataUsingEncoding:NSUTF8StringEncoding] name:[[dic allKeys] objectAtIndex:i]];
                   
                }
                
                
                
                
                
                
            }
        }
        
        
        
    }];
 

AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];

   [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        /*float uploadPercentge = (float)totalBytesWritten / (float)totalBytesExpectedToWrite;
        float uploadActualPercentage = uploadPercentge * 100;
        NSLog(@"Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite);
        NSLog(@"Multipartdata upload in progress: %@",[NSString stringWithFormat:@"%.2f %%",uploadActualPercentage]);
        if (uploadActualPercentage >= 100) {
            NSLog(@"Waitting for response ...");
        }
        progressBar.progress = uploadPercentge; //  progressBar is UIProgressView to show upload progress
         
         */
    }];
    
    
    [client enqueueHTTPRequestOperation:operation];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        [self hideHudView];
        [self hideNativeHudView];
        NSString *str=operation.responseString;
        
        NSLog(@"Data=%@",str);
        
        
        if(str)
        {
            SBJsonParser *parser=[[SBJsonParser alloc] init];
            
            id res = [parser objectWithString:str];
            if ([res isKindOfClass:[NSDictionary class]])
            {
                NSDictionary* aDict = (NSDictionary*) res;
                // aDict=[aDict objectForKey:@"responseData"];
                
                
                if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
                {
                    // [appDelegate saveAllUserDataFirstName:[self.requestDic objectForKey:FIRSTNAME] LastName:[self.requestDic objectForKey:LASTNAME] Address:[self.requestDic objectForKey:ADDRESS] Email:[self.requestDic objectForKey:EMAIL] Password:[self.requestDic objectForKey:PASSWORD] ContactNo:[self.requestDic objectForKey:CONTACTNO] PrimaryEmail1:[self.requestDic objectForKey:PRIMARYEMAIL1] PrimaryEmail2:[self.requestDic objectForKey:PRIMARYEMAIL2] SecondaryEmail1:[self.requestDic objectForKey:SECONDARYEMAIL1] SecondaryEmail2:[self.requestDic objectForKey:SECONDARYEMAIL2] SecondaryEmail3:[self.requestDic objectForKey:SECONDARYEMAIL3] SecondaryEmail4:[self.requestDic objectForKey:SECONDARYEMAIL4] SecondaryEmail5:[self.requestDic objectForKey:SECONDARYEMAIL5] SecondaryEmail6:[self.requestDic objectForKey:SECONDARYEMAIL6] ProfileImage:nil];
                    
                    
                    /////////Set Profile Image
                    appDelegate.centerVC.myavatar.image=appDelegate.centerVC.noImage;
                    //  appDelegate.leftVC.avatarimavw.image=appDelegate.leftVC.noImage;
                    appDelegate.userOwnImage=nil;
                    
                    self.leftvctappiclab.hidden=NO;
                    [appDelegate removeUserDefaultValueForKey:ISFETCHUSERPROFILEURL];
                    if(![[aDict objectForKey:@"ProfileImage"] isEqualToString:@""])
                    {
                        NSLog(@"UpdatedProfileImage=%@",[aDict objectForKey:@"ProfileImage"]);
                        
                        [appDelegate setUserDefaultValue:[aDict objectForKey:@"ProfileImage"] ForKey:USERPROFILEURL];
                        [appDelegate.leftVC loadImage];
                    }
                    else
                    {
                        [appDelegate removeUserDefaultValueForKey:USERPROFILEURL];
                        isSelectedImage=0;
                    }
                    
                    self.crossbt.hidden=YES;
                    self.donebt.hidden=YES;
                    /////////
                    
                    
                    
                    
                    //                [self showHudAlert:[aDict objectForKey:@"message"]];
                    //                [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
                    self.requestDic=nil;
                }
                else
                {
                    [self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
                }
            }
        }
        

    }
     
     
     
     
     
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
                                         NSLog(@"PostMultImagesWithTextAPI API failed with error: %@", operation.responseString);
        
        [self hideHudView];
        [self hideNativeHudView];
        NSLog(@"Error receiving dataImage : %@ ",[operation.error description]);
        //[self showAlertMessage:CONNFAILMSG];ChAfter
        
        if(self.orgImage)
        {
            [self.avatarimavw applyPhotoFrame ];
            self.avatarimavw.image=self.orgImage;
            self.leftvctappiclab.hidden=YES;
            isSelectedImage=1;
        }
        else
        {
            [self.avatarimavw cleanPhotoFrame];
            self.avatarimavw.image=self.noImage;
            self.leftvctappiclab.hidden=NO;
            isSelectedImage=0;
        }
        
        
        self.crossbt.hidden=YES;
        self.donebt.hidden=YES;

        
        
    }];
    
    
    
    
    
    [operation start];
    ///////////////////////////////////////////////////////////////////////////////////////////////
    
}

///////Test Finish
-(void)sendRequestForImageChange:(NSDictionary*)dic
{
    // NSString *str=POST;
    
    NSURL* url = [NSURL URLWithString:PROFILEEDITLINK];
    ASIFormDataRequest *aRequest=  [[ASIFormDataRequest alloc ] initWithURL:url];
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
            NSLog(@"RequestParam=%@",[[dic allKeys] objectAtIndex:i]);
            
            if([[[dic allKeys] objectAtIndex:i] isEqualToString:@"ProfileImage" ])
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
    
    self.hudFlag1=0;
    
    [self hideHudView];
    [self hideNativeHudView];
NSString *str=[request responseString];

NSLog(@"Data=%@",str);

    
    if(str)
    {
        SBJsonParser *parser=[[SBJsonParser alloc] init];
        
        id res = [parser objectWithString:str];
        if ([res isKindOfClass:[NSDictionary class]])
        {
            NSDictionary* aDict = (NSDictionary*) res;
            // aDict=[aDict objectForKey:@"responseData"];
            
            
            if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
            {
                // [appDelegate saveAllUserDataFirstName:[self.requestDic objectForKey:FIRSTNAME] LastName:[self.requestDic objectForKey:LASTNAME] Address:[self.requestDic objectForKey:ADDRESS] Email:[self.requestDic objectForKey:EMAIL] Password:[self.requestDic objectForKey:PASSWORD] ContactNo:[self.requestDic objectForKey:CONTACTNO] PrimaryEmail1:[self.requestDic objectForKey:PRIMARYEMAIL1] PrimaryEmail2:[self.requestDic objectForKey:PRIMARYEMAIL2] SecondaryEmail1:[self.requestDic objectForKey:SECONDARYEMAIL1] SecondaryEmail2:[self.requestDic objectForKey:SECONDARYEMAIL2] SecondaryEmail3:[self.requestDic objectForKey:SECONDARYEMAIL3] SecondaryEmail4:[self.requestDic objectForKey:SECONDARYEMAIL4] SecondaryEmail5:[self.requestDic objectForKey:SECONDARYEMAIL5] SecondaryEmail6:[self.requestDic objectForKey:SECONDARYEMAIL6] ProfileImage:nil];
                
                
                /////////Set Profile Image
                appDelegate.centerVC.myavatar.image=appDelegate.centerVC.noImage;
                //  appDelegate.leftVC.avatarimavw.image=appDelegate.leftVC.noImage;
                appDelegate.userOwnImage=nil;
               
                 self.leftvctappiclab.hidden=NO;
                [appDelegate removeUserDefaultValueForKey:ISFETCHUSERPROFILEURL];
                if(![[aDict objectForKey:@"ProfileImage"] isEqualToString:@""])
                {
                    NSLog(@"UpdatedProfileImage=%@",[aDict objectForKey:@"ProfileImage"]);
                    
                    [appDelegate setUserDefaultValue:[aDict objectForKey:@"ProfileImage"] ForKey:USERPROFILEURL];
                    [appDelegate.leftVC loadImage];
                }
                else
                {
                    [appDelegate removeUserDefaultValueForKey:USERPROFILEURL];
                    isSelectedImage=0;
                }
                
                self.crossbt.hidden=YES;
                  self.donebt.hidden=YES;
                /////////
                
                
                
                
                //                [self showHudAlert:[aDict objectForKey:@"message"]];
                //                [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
                self.requestDic=nil;
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
    self.hudFlag1=0;
    [self hideHudView];
    [self hideNativeHudView];
	NSLog(@"Error receiving dataImage : %@ ",[request.error description]);
	//[self showAlertMessage:CONNFAILMSG];ChAfter
    
    if(self.orgImage)
    {
        [self.avatarimavw applyPhotoFrame ];
        self.avatarimavw.image=self.orgImage;
         self.leftvctappiclab.hidden=YES;
        isSelectedImage=1;
    }
    else
    {
         [self.avatarimavw cleanPhotoFrame];
        self.avatarimavw.image=self.noImage;
        self.leftvctappiclab.hidden=NO;
        isSelectedImage=0;
    }
	
    
    self.crossbt.hidden=YES;
    self.donebt.hidden=YES;
}

- (IBAction)photoActionTapped:(id)sender
{
    int tag=[sender tag];
    
    if(tag==0)
    {
    if(self.orgImage)
    {
         [self.avatarimavw applyPhotoFrame ];
        self.avatarimavw.image=self.orgImage;
         self.leftvctappiclab.hidden=YES;
        isSelectedImage=1;
    }
    else
    {
         [self.avatarimavw cleanPhotoFrame ];
        self.avatarimavw.image=self.noImage;
         self.leftvctappiclab.hidden=NO;
            isSelectedImage=0;
    }
        
        self.crossbt.hidden=YES;
        self.donebt.hidden=YES;
    }
    else
    {
        /*NSMutableDictionary *command = [NSMutableDictionary dictionary];
        [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
        if(isSelectedImage==0 && (!appDelegate.userOwnImage ))
            [command setObject:@"Y" forKey:@"delete_image"];
        else
            [command setObject:@"N" forKey:@"delete_image"];*/
        
        NSMutableDictionary *command = [NSMutableDictionary dictionary];
        command = [[self configureReqParamDict] mutableCopy];
        SBJsonWriter *writer = [[SBJsonWriter alloc] init];
        
        
        NSString *jsonCommand = [writer stringWithObject:command];
        
        
        [self showHudView:@"Connecting..."];
        [self showNativeHudView];
        
        self.requestDic=command;
        
        
        if(isSelectedImage==1)
            [self sendRequestForImageChange:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam",UIImageJPEGRepresentation(self.avatarimavw.image,0.5),@"ProfileImage", nil]];
        else
            [self sendRequestForImageChange:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
    }
}




-(void)sendImageChangeNew
{
   /* NSMutableDictionary *command = [NSMutableDictionary dictionary];
    [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
    if(isSelectedImage==0 && (!appDelegate.userOwnImage ))
        [command setObject:@"Y" forKey:@"delete_image"];
    else
        [command setObject:@"N" forKey:@"delete_image"];*/
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    command = [[self configureReqParamDict] mutableCopy];
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    
    self.requestDic=command;
    
    
    if(isSelectedImage==1)
        [self sendRequestForImageChangeWithAFNetWorking:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam",UIImageJPEGRepresentation(self.avatarimavw.image,0.5),@"ProfileImage", nil]];
    else
        [self sendRequestForImageChangeWithAFNetWorking:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
}




-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    ///////Added by Debattam
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LEFTCONTROLLERIMAGELOADED object:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return [dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    /* if(indexPath.row==0)
     {
     return 174.0;
     }
     else if(indexPath.row==25)
     {
     return 140.0;
     }
     else
     {*/
    
    
    return 44;
    //}
    
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LeftVCTableCell";
    // static NSString *CellIdentifier1 = @"TableHeader";
    // static NSString *CellIdentifier2 = @"TableFooter";
    //   UIColor *clcolor= [UIColor clearColor];
    /* if(indexPath.row==0)
     {
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
     if (cell == nil) {
     cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] autorelease];
     cell.selectionStyle=UITableViewCellSelectionStyleNone;
     cell.backgroundColor=clcolor;
     [cell.contentView addSubview:tabheaderview];
     }
     
     
     return cell;
     }*/
    /*else if(indexPath.row==25)
     {
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
     if (cell == nil) {
     cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2] autorelease];
     cell.selectionStyle=UITableViewCellSelectionStyleNone;
     cell.backgroundColor=clcolor;
     [cell.contentView addSubview:tabfooterview];
     }
     
     return cell;
     }
     else
     {*/
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier]; ;
    
    
    
    if (cell == nil)
    {
        
        
        cell =[LeftVCTableCell cellFromNibNamed:@"LeftVCTableCell"];
        
    }
    
    
    
    [self configureCell:cell atIndexPath:indexPath];
    
    
    
    return cell;
    /* }*/
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    
    /*if(indexPath.row==0)
    {
           [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationController];
    }
      else if(indexPath.row==3)
   {
       TeamEventsVC *teVC= (TeamEventsVC*)[appDelegate.navigationControllerTeamEvents.viewControllers objectAtIndex:0];
       
       [teVC createEvent];
        [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerTeamEvents];
       
       
      
   }
      else if(indexPath.row==4)
      {
          [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerTeamMaintenance];
          
          if([[appDelegate.navigationControllerTeamMaintenance.viewControllers lastObject] isMemberOfClass:[TeamMaintenanceVC class]])
              [(TeamMaintenanceVC*)[appDelegate.navigationControllerTeamMaintenance.viewControllers lastObject] loadTeamData];
          
          
      }
    else if(indexPath.row==1)
      {
          
          [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerTeamRoster];
          
          if([[appDelegate.navigationControllerTeamRoster.viewControllers lastObject] isMemberOfClass:[TeamPlayerViewController class]])
              
              [(TeamPlayerViewController*)[appDelegate.navigationControllerTeamRoster.viewControllers lastObject] getAllTemaDetailsFoeUser];
      }*/

    /*else if(indexPath.row==2)
      {
          EventCalendarViewController *eVC=(EventCalendarViewController*) [appDelegate.navigationControllerCalendar.viewControllers objectAtIndex:0];
          [appDelegate.navigationControllerCalendar popToRootViewControllerAnimated:NO];
          
          
          self.appDelegate.centerViewController.isShowMainCalendarFirstScreeen=0;
          eVC.eventheaderlab.text=UPCOMINGTEAMEVENTS;
          eVC.isMonth=1;
          eVC.topSegCntrl.selectedSegmentIndex=eVC.isMonth;
          eVC.calvc.view.hidden=NO;
          eVC.callistvc.view.hidden=YES;
          eVC.downarrowfilterimavw.hidden=YES;
          eVC.downarrowfilterbt.hidden=YES;
          
          
          [eVC.calvc.monthView reloadData];
          [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerCalendar];
          
      }*/

   

   if(indexPath.row==0 )
   {
       
   
       [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerMyPhoto];
       [(PhotoMainVC*)[self.appDelegate.navigationControllerMyPhoto.viewControllers objectAtIndex:0] getUpdateData];

        
       
   }
  /* else if(indexPath.row==5)
   {
       
       [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerBuySell];
       
   }*/
  /* else if(indexPath.row==6 )
   {
      
       self.appDelegate.trainningVideoVC.isFromHomeVC=0;
       [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerTrainingVideo];
       [(ShowVideoViewController*)[self.appDelegate.navigationControllerTrainingVideo.viewControllers objectAtIndex:0] getAllTrainingVideos];

      
       
   }*/

    
    else if(indexPath.row==2)
   {
       
       FeedBackViewController *fVC=(FeedBackViewController*)[appDelegate.navigationControllerFeedBack.viewControllers objectAtIndex:0];
       
       [fVC disableSlidingAndHideTopBar];
       
       [fVC firstTime];
       
       
       [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerFeedBack];
       
   }
   else if(indexPath.row==3)
   {
       
       [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerFaq];
       
   }
    
   else if( indexPath.row==1)
   {
       [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerSettings];
       
       
   }
   else if(indexPath.row==4)
   {
       
       [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerTutorial];
       
   }
  
    else if(indexPath.row==(self.dataArray.count-1))
    {
        if(isConnectionProgressing)
            return;
        
        
        self.logoutActionSheet=[[UIActionSheet alloc] initWithTitle:@"Are you sure you want to log out?" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"Log Out" otherButtonTitles:@"Cancel", nil];
        
        [self.logoutActionSheet showInView:self.view];
     
    }
}



-(void)selectTableViewIndex:(int)row :(BOOL)isSel
{
  //  [self view];
    @autoreleasepool {
        NSLog(@"%i---%i",row,isSel);
    
   /* NSIndexPath *iPath=[NSIndexPath indexPathForRow:row inSection:0];
    LeftVCTableCell **/UIView *ltvCell=[self.leftviewsarrat objectAtIndex:row];//(LeftVCTableCell*)[self.tableView cellForRowAtIndexPath:iPath];
    
    if(isSel)
    {
    //ltvCell.selectionStyle=UITableViewCellSelectionStyleGray;
        ltvCell.backgroundColor=appDelegate.themeCyanColor;
    }
    else
    {
    //ltvCell.selectionStyle=UITableViewCellSelectionStyleNone;
          ltvCell.backgroundColor=self.clearcolor;
        //self.clearcolor;
    }
        
           NSLog(@"%@---%@",ltvCell,self.tableView);
    }
}



-(void)resetTableViewIndex
{
    //  [self view];
    @autoreleasepool {
        
        
        
       // for(NSIndexPath *iPath in self.tableView.indexPathsForVisibleRows)
        for (UIView *vw in self.leftviewsarrat)
        {
       
      //  LeftVCTableCell *ltvCell=(LeftVCTableCell*)[self.tableView cellForRowAtIndexPath:iPath];
        
       
            //ltvCell.selectionStyle=UITableViewCellSelectionStyleNone;
          //  ltvCell.backGroundvw.backgroundColor=self.clearcolor;
            //
            vw.backgroundColor=self.clearcolor;
        }
        
      
    }
}

- (IBAction)leftBtapped:(id)sender
{
    
    int tag=[sender tag];
    
    
    if(tag==0 )
    {
        
        
        [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerMyPhoto];
        [(PhotoMainVC*)[self.appDelegate.navigationControllerMyPhoto.viewControllers objectAtIndex:0] getUpdateData];
        
        
        
    }
    /* else if(indexPath.row==5)
     {
     
     [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerBuySell];
     
     }*/
    /* else if(indexPath.row==6 )
     {
     
     self.appDelegate.trainningVideoVC.isFromHomeVC=0;
     [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerTrainingVideo];
     [(ShowVideoViewController*)[self.appDelegate.navigationControllerTrainingVideo.viewControllers objectAtIndex:0] getAllTrainingVideos];
     
     
     
     }*/
    
    
    else if(tag==2)
    {
        
        FeedBackViewController *fVC=(FeedBackViewController*)[appDelegate.navigationControllerFeedBack.viewControllers objectAtIndex:0];
        
        [fVC disableSlidingAndHideTopBar];
        
        [fVC firstTime];
        
        
        [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerFeedBack];
        
    }
    else if(tag==3)
    {
        
        [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerFaq];
        
    }
    
    else if( tag==1)
    {
        [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerSettings];
        
        
    }
    else if(tag==4)
    {
        
        [self.appDelegate.centerViewController showNavController:self.appDelegate.navigationControllerTutorial];
        
    }
    
    else if(tag==(self.dataArray.count-1))
    {
        if(isConnectionProgressing)
            return;
        
        
        self.logoutActionSheet=[[UIActionSheet alloc] initWithTitle:@"Are you sure you want to log out?" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"Log Out" otherButtonTitles:@"Cancel", nil];
        
        [self.logoutActionSheet showInView:self.view];
        
    }

}


-(void)reqlogout
{
    if ([FBSDKAccessToken currentAccessToken])
    {
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logOut];
    }

    
    NSMutableDictionary *command=[NSMutableDictionary dictionary];
    
    [command setObject:[appDelegate.aDef objectForKey:UDID] forKey:@"IMEI"];
    [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
    
    
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    isConnectionProgressing=1;
    [appDelegate sendRequestFor:LOGOUT from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    
    
    return YES;
}






- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
   LeftVCTableCell *cell1=(LeftVCTableCell*)cell;
    
    
    NSLog(@"%@",[dataArray objectAtIndex:indexPath.row]);
    
 
    
    /*if([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"TEAM ADMIN"])
    {
       CGRect r =  cell1.leftimav.frame;
        r.origin.x+=2;
        r.origin.y-=2;
        cell1.leftimav.frame=r;
    }
    else*/ if([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"Albums"])
    {
         CGRect r=  cell1.leftimav.frame;
       // r.origin.x+=1;
        r.origin.y+=2;
      //  r.size.width-=2;
        r.size.height-=4;
        cell1.leftimav.frame=r;
    }
    
     [self setDiavloFont:cell1.detailslab1 withSize:14.0  ];
        cell1.detailslab1.text=[dataArray objectAtIndex:indexPath.row];
    
    
    
    /*if([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"BUY/SELL"])
     cell1.leftimav.image=[UIImage imageNamed:@"BUY:SELL" ];
   else if([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"LEAGUE/CLUB"])
    cell1.leftimav.image=[UIImage imageNamed:@"LEAGUE:CLUB" ];
       else*/
    cell1.leftimav.image=[UIImage imageNamed:[dataArray objectAtIndex:indexPath.row] ];
    
 //   cell1.leftimav.backgroundColor=lightbluecolor;
    /*  if(indexPath.row%2)
     cell1.frntvw.backgroundColor=graycolor;
     else
     cell1.frntvw.backgroundColor=lightgraycolor;*/
    
    cell1.selectionStyle=UITableViewCellSelectionStyleNone;
    /* cell1.leftimav.layer.borderColor=[whitecolor CGColor];
     cell1.leftimav.layer.borderWidth=2.0;*/
    
    /* FSData *data=[self.partDataArray objectAtIndex:indexPath.row];
     
     cell1.detailslab1.text=data.name;
     cell1.detailslab2.text=data.address;
     ImageInfo * info = data.imageInfo;
     
     if(info.image)
     {
     cell1.leftimav.image = info.image;
     cell1.leftimav.hidden=NO;
     cell1.acindview.hidden=YES;
     [cell1.acindview stopAnimating];
     
     }
     else
     {
     cell1.acindview.hidden=NO;
     cell1.leftimav.hidden=YES;
     [cell1.acindview startAnimating];
     info.notifiedObject=data;
     [info getImage];
     }*/
    
    
}

-(void)notifyRequesterWithData:(id) aData :(id)aData1
{
    isConnectionProgressing=0;
    [self hideHudView];
    [self hideNativeHudView];
    
    if([aData isKindOfClass:[ConnectionManager class]])
    {
        ConnectionManager *aR=(ConnectionManager*)aData;
       
         if([aR.requestSingleId isEqualToString:PROFILEEDIT])
          {
              if(self.orgImage)
              {
                   [self.avatarimavw applyPhotoFrame ];
                   self.leftvctappiclab.hidden=YES;
               self.avatarimavw.image=self.orgImage;
              }
              else
              {
                   [self.avatarimavw cleanPhotoFrame ];
                   self.leftvctappiclab.hidden=NO;
                  self.avatarimavw.image=self.noImage;
              }
          }
          else//For Logout
          {
              
          }
        return;
    }
    
    
    NSString *str=(NSString*)aData;
     ConnectionManager *aR=(ConnectionManager*)aData1;
    NSLog(@"Data=%@",str);
    
    
    
    //if([aR.requestSingleId isEqualToString:LOGOUT])
    
   if([aR.requestSingleId isEqualToString:PROFILEEDIT])
    {
        
        
        
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
                   // [appDelegate saveAllUserDataFirstName:[self.requestDic objectForKey:FIRSTNAME] LastName:[self.requestDic objectForKey:LASTNAME] Address:[self.requestDic objectForKey:ADDRESS] Email:[self.requestDic objectForKey:EMAIL] Password:[self.requestDic objectForKey:PASSWORD] ContactNo:[self.requestDic objectForKey:CONTACTNO] PrimaryEmail1:[self.requestDic objectForKey:PRIMARYEMAIL1] PrimaryEmail2:[self.requestDic objectForKey:PRIMARYEMAIL2] SecondaryEmail1:[self.requestDic objectForKey:SECONDARYEMAIL1] SecondaryEmail2:[self.requestDic objectForKey:SECONDARYEMAIL2] SecondaryEmail3:[self.requestDic objectForKey:SECONDARYEMAIL3] SecondaryEmail4:[self.requestDic objectForKey:SECONDARYEMAIL4] SecondaryEmail5:[self.requestDic objectForKey:SECONDARYEMAIL5] SecondaryEmail6:[self.requestDic objectForKey:SECONDARYEMAIL6] ProfileImage:nil];
                    
                    
                    /////////Set Profile Image
                    appDelegate.centerVC.myavatar.image=appDelegate.centerVC.noImage;
                  //  appDelegate.leftVC.avatarimavw.image=appDelegate.leftVC.noImage;
                    appDelegate.userOwnImage=nil;
                
                     self.leftvctappiclab.hidden=NO;
                    [appDelegate removeUserDefaultValueForKey:ISFETCHUSERPROFILEURL];
                    if(![[aDict objectForKey:@"ProfileImage"] isEqualToString:@""])
                    {
                        [appDelegate setUserDefaultValue:[aDict objectForKey:@"ProfileImage"] ForKey:USERPROFILEURL];
                        [appDelegate.leftVC loadImage];
                    }
                    else
                    {
                        [appDelegate removeUserDefaultValueForKey:USERPROFILEURL];
                    }
                    /////////
                    
                    
                    
                    
                    //                [self showHudAlert:[aDict objectForKey:@"message"]];
                    //                [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
                    self.requestDic=nil;
                }
                else
                {
                    [self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
                }
            }
        }
        
        
        
        
        
        

        
        
        
    }
    else//For Logout
    {
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
                    
                    @try {
                        
                    [appDelegate.JSONDATAarr removeAllObjects];
                    appDelegate.myFriendList=nil;
                    appDelegate.messageUserList=nil;
                    [appDelegate removeUserDefaultValueForKey:ARRAYNAMES];
                    [appDelegate removeUserDefaultValueForKey:ARRAYIDS];
                    [appDelegate removeUserDefaultValueForKey:ARRAYSTATUS];
                    [appDelegate removeUserDefaultValueForKey:ARRAYTEAMSPORTS];
                    [appDelegate removeUserDefaultValueForKey:ARRAYISCREATES];
                    [appDelegate removeUserDefaultValueForKey:ARRAYIMAGES];
                    [appDelegate removeUserDefaultValueForKey:ARRAYTEXTS];
                    [self.appDelegate removeUserDefaultValueForKey:ISLOGIN];
                        
                        if([appDelegate.aDef objectForKey:ISLOGINWITHFACEBOOK])
                        {
                        [self.appDelegate removeUserDefaultValueForKey:ISLOGINWITHFACEBOOK];
                        [appDelegate closeSession];
                        }
                        
                        appDelegate.faceBookImageData=nil;
                    [self.appDelegate removeUserDefaultValueForKey:NEWLOGIN];
                    [self.appDelegate removeUserDefaultValueForKey:LoggedUserDeviceTokenStatus];
                    [appDelegate removeUserDefaultValueForKey:ISFETCHUSERPROFILEURL];
                    [appDelegate removeUserDefaultValueForKey:USERPROFILEURL];
                     [appDelegate removeUserDefaultValueForKey:ISLIKECOMMENTALREADYLOADED];
                    [appDelegate removeUserDefaultValueForKey:ALLHISTORYLIKECOUNTS];
                         [appDelegate removeUserDefaultValueForKey:FIRSTTIMEPOSTDICTIONARY];
                        [appDelegate removeUserDefaultValueForKey:ISFIRSTTIMESHOWPLUSINADDFRIEND];
                         [appDelegate removeUserDefaultValueForKey:ISFIRSTTIMEENTERADDFRIEND];
                     [appDelegate removeUserDefaultValueForKey:ISEXISTOWNTEAM];
                    appDelegate.allHistoryLikesComments=nil;
                    appDelegate.allHistoryLikesCounts=0;
                    appDelegate.userOwnImage=nil;
                    [appDelegate removeAllUserData];
                    
                    [self deleteAllInvites ];
                        [self deleteAllEvents:nil];
                 
                    //   [self.appDelegate.centerVC resetVC];
                    
                    
                    // [self showHudAlert:[aDict objectForKey:@"message"]];
                        
                    [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:0.0];
                    
                    }
                    @catch (NSException *exception) {
                        
                        NSLog(@"Exception is=%@",exception);
                        
                    }
                   
                }
                else
                {
                    [self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
                    [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:1.0];
                }
            }
            
            else{
                [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:0.0];
            }
        }
        
        
        
        
        
        
        
        
        
        
        
        
    }
}


-(void)hideHudViewHere
{
     // [self.appDelegate removeUserDefaultValueForKey:LoggedUserID];
    [self hideHudView];
    
    [self setStatusBarStyleOwnApp:0];
     [self.appDelegate addRootVC:self.appDelegate.navigationControllerfirst ];
    [self.appDelegate.leftVC resetVC];
    [self.appDelegate.rightVC resetVC];
    
    int flag=0;
    
    for (UIViewController *vc in self.appDelegate.navigationControllerfirst.viewControllers) {
        
        if ([vc isKindOfClass:[FirstLoginViewController class]]) {
            
            [self.appDelegate.navigationControllerfirst popToViewController:vc animated:YES];
            flag=1;
            break;
        }
    }
    
    self.appDelegate.slidePanelController.centerPanel =nil;
    self.appDelegate.navigationController=nil;              /// 18/7/2014
    self.appDelegate.navigationControllerCenter=nil;
    self.appDelegate.navigationControllerCalendar=nil;
    self.appDelegate.navigationControllerAddAFriend=nil;
    self.appDelegate.navigationControllerTeamInvites=nil;
    self.appDelegate.navigationControllerTeamMaintenance=nil;
    self.appDelegate.navigationControllerMyTeams=nil;  ////AD july For Myteam
    self.appDelegate.navigationControllerChatMessage=nil;
    
    
    
    if (flag==0) {
         FirstLoginViewController *loginViewController=[[FirstLoginViewController alloc] initWithNibName:@"FirstLoginViewController" bundle:nil];
        [self.appDelegate.navigationControllerfirst pushViewController:loginViewController animated:NO];
    }
    
 
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidUnload
{
    [self setTableView:nil];
    [self setAvatarimavw:nil];
    [self setCrossbt:nil];
    [self setDonebt:nil];
   
    [self setUserNameLbl:nil];
    [self setLeftvctappiclab:nil];
    [super viewDidUnload];
}


- (IBAction)changeImageAction:(id)sender
{
    self.isShowActionSheetFromSelf=1;
      [self takeImage];
}

- (NSMutableDictionary *) configureReqParamDict {
    
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    
    [paramDict setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"UserID"];
    [paramDict setObject:[appDelegate.aDef objectForKey:FIRSTNAME] forKey:@"FirstName"];
    [paramDict setObject:[appDelegate.aDef objectForKey:LASTNAME] forKey:@"LastName"];
    
    [paramDict setObject:[appDelegate.aDef objectForKey:PASSWORD] forKey:@"Password"];
    [paramDict setObject:[appDelegate.aDef objectForKey:CONTACTNO] forKey:@"ContactNo"];
    
    [paramDict setObject:[appDelegate.aDef objectForKey:EMAIL] forKey:@"Email"];
    [paramDict setObject:[appDelegate.aDef objectForKey:PRIMARYEMAIL1] forKey:@"PrimaryEmail1"];
    [paramDict setObject:[appDelegate.aDef objectForKey:PRIMARYEMAIL2] forKey:@"PrimaryEmail2"];
    [paramDict setObject:[appDelegate.aDef objectForKey:SECONDARYEMAIL1] forKey:@"SecondaryEmail1"];
    [paramDict setObject:[appDelegate.aDef objectForKey:SECONDARYEMAIL2] forKey:@"SecondaryEmail2"];
    [paramDict setObject:[appDelegate.aDef objectForKey:SECONDARYEMAIL3] forKey:@"SecondaryEmail3"];
    [paramDict setObject:[appDelegate.aDef objectForKey:SECONDARYEMAIL4] forKey:@"SecondaryEmail4"];
    [paramDict setObject:[appDelegate.aDef objectForKey:SECONDARYEMAIL5] forKey:@"SecondaryEmail5"];
    [paramDict setObject:[appDelegate.aDef objectForKey:SECONDARYEMAIL6] forKey:@"SecondaryEmail6"];
    
    [paramDict setObject:[appDelegate.aDef objectForKey:EVENTNOTIFICATIONEMAIL] forKey:@"EventInv_mail"];
    [paramDict setObject:[appDelegate.aDef objectForKey:EVENTNOTIFICATION] forKey:@"EventInv_push"];
    [paramDict setObject:[appDelegate.aDef objectForKey:TEAMNOTIFICATIONEMAIL] forKey:@"TeamInv_mail"];
    [paramDict setObject:[appDelegate.aDef objectForKey:TEAMNTIFICATION] forKey:@"TeamInv_push"];
    [paramDict setObject:[appDelegate.aDef objectForKey:FRIENDNOTIFICATIONEMAIL] forKey:@"FrndInv_mail"];
    [paramDict setObject:[appDelegate.aDef objectForKey:FRIENDNOTIFICATION] forKey:@"FrndInv_push"];
    [paramDict setObject:[appDelegate.aDef objectForKey:MESSAGENOTIFICATIONEMAIL] forKey:@"Message_mail"];
    [paramDict setObject:[appDelegate.aDef objectForKey:MESSAGENOTIFICATION] forKey:@"Message_push"];
    
    if(isSelectedImage && (!appDelegate.userOwnImage ))
        [paramDict setObject:@"Y" forKey:@"delete_image"];
    else
        [paramDict setObject:@"N" forKey:@"delete_image"];
    
    return paramDict;
}

@end
