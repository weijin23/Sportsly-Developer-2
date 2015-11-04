//
//  CreatePostViewController.m
//  Wall
//
//  Created by Mindpace on 18/11/13.
//
//
#import "UIButton+AFNetworking.h"
#import "HomeVC.h"
#import "CreatePostViewController.h"
#import "CenterViewController.h"
@interface CreatePostViewController ()

@end

@implementation CreatePostViewController
@synthesize homeVC,dataVideo,isSelectedImage,isSelectedVideo,teamId,teamName,actionSheetChoicePost,isCompleteCoachPost,isCompleteWallPost,isCompleteFinishCoachPost,isCompleteFinishWallPost,isSelectedVideoFromURL,videoURLStr,tickimage,nontickimage,isSelectedCoachUpdate,checkbtlabel,isFirstTimeEnter,isTakeImageFromWall,isVideoSelected;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self disableSlidingAndHideTopBar];
    
  
    [self.navigationController setNavigationBarHidden:YES];
    
      [self setStatusBarStyleOwnApp:0];
    
     [self.commentTextVw becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self enableSlidingAndShowTopBar];
    
     [self.navigationController setNavigationBarHidden:NO];
    
      [self setStatusBarStyleOwnApp:1];
    
    
    [self.commentTextVw resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    isCompleteWallPost=0;
    isCompleteCoachPost=0;
    // Do any additional setup after loading the view from its nib.
    self.mylab1.text=self.teamName;
    self.previewimavw.image=nil;
    isSelectedVideo=0;
    self.isSelectedVideoFromURL=0;
    isSelectedImage=0;
  
    self.commentTextVw.text=@"";
    self.dataVideo=nil;
    [self showPostView:1];
   // self.topbarvw.backgroundColor=appDelegate.barGrayColor;
   // self.keyboardtopVw.backgroundColor=appDelegate.backgroundPinkColor;
    
   
    
    
    
    
    @autoreleasepool
    {
        if (self.isiPad) {
            self.tickimage=[UIImage imageNamed:@"graytick_ipad.png"];
            self.nontickimage=[UIImage imageNamed:@"graynontick_ipad.png"];
        }
        self.tickimage=[UIImage imageNamed:@"graytick.png"];
        self.nontickimage=[UIImage imageNamed:@"graynontick.png"];
    }
    
    isSelectedCoachUpdate=0;
    
    [self reloadButton];
    
    
    
    
    
    
    
    
    NSMutableDictionary *mtdic=nil;
    
   if( ![appDelegate.aDef objectForKey:FIRSTTIMEPOSTDICTIONARY])
   {
       mtdic=[[NSMutableDictionary alloc] init];
   }
   else
   {
       mtdic=[[appDelegate.aDef objectForKey:FIRSTTIMEPOSTDICTIONARY] mutableCopy];
   }
    
    
    if(![mtdic objectForKey:self.teamId])
    {
    [mtdic setObject:@"1" forKey:self.teamId];
        
        [appDelegate setUserDefaultValue:mtdic ForKey:FIRSTTIMEPOSTDICTIONARY];
        
        
        
        
        
        if([[appDelegate.centerVC.dataArrayUpIsCreated objectAtIndex:appDelegate.centerVC.lastSelectedTeam] integerValue])
        {
            
            //self.commentTextVw.text=@"Add your text here.\nYou can select the \"Coach Update\" button to post the message in Coach Update.";
            
            self.commentTextVw.text=@"Add your text here.";   ///// 16/01/15
            self.imageViewCoachUpdate.hidden=NO;
        }
        else
        {
            self.commentTextVw.text=@"Add your text here.";
        }
        self.commentTextVw.textColor=self.lightgraycolor;
    }
    
    
    
    
    
    if(isTakeImageFromWall)
        [self postbTapped:self.cambt];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if(!isFirstTimeEnter)
    {
        textView.text=@"";
        textView.textColor=self.blackcolor;
        self.imageViewCoachUpdate.hidden=YES;
        
        isFirstTimeEnter=1;
    }
    return YES;
    
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if(!isFirstTimeEnter)
    {
        textView.selectedRange = NSMakeRange(0, 0);
    }
}

-(IBAction)postbTapped:(id)sender
{
    
    
    int tag=[sender tag];
    
    
    if(tag==0)
    {
        if(!isFirstTimeEnter)
        {
            self.commentTextVw.text=@"";
            self.commentTextVw.textColor=self.blackcolor;
            self.imageViewCoachUpdate.hidden=YES;
            
            isFirstTimeEnter=1;
        }
        
        
       //chch   self.isModallyPresentFromCenterVC=1;
       // [self takeImage];
       
            // do something else
        /*isVideoSelected=0;
            [self useCameraRoll:nil];*/
        
        
        UIActionSheet *acsh=  [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Choose From Photo Library",@"Choose From Video Library",nil];
        self.camActionSheet=acsh;
        self.camActionSheet.delegate=self;
       
            [self.camActionSheet showInView:self.view];
        
       
        
            
        
    }
    /*else if(tag==1)
    {
        if(!isFirstTimeEnter)
        {
            self.commentTextVw.text=@"";
            self.commentTextVw.textColor=self.blackcolor;
            
            
            isFirstTimeEnter=1;
        }
         self.isShowTrainningVideoOption=0;
        
     //chch   self.isModallyPresentFromCenterVC=1;
        //[self takeVideo];
       
            // do something else
        isVideoSelected=1;
            [self useCameraRollVideo:nil];
            NSLog(@"Video Library will open");
            
        
    }*/
    else if (tag==5)
    {
      
      //chch  self.isModallyPresentFromCenterVC=1;
            // do something else
       /* isVideoSelected=0;
            [self getCameraPicture:@"Take Photo"];
            NSLog(@"Camera will open");*/
            
        
        UIActionSheet *acsh=  [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Take Video",nil];
        self.camActionSheet=acsh;
        self.camActionSheet.delegate=self;
        
        [self.camActionSheet showInView:self.view];

      
       
    }
    else if(tag==2)
    {
        if(self.isSelectedImage)
           self.isSelectedImage=0;
        
        if(self.isSelectedVideo)
        {
            self.isSelectedVideo=0;
            self.isSelectedVideoFromURL=0;
        }
        self.previewimavw.image=nil;
       self.dataVideo=nil;
        [self showPostView:1];
    }
    else if(tag==3)
    {
        [self resetPostView];
    }
    else if(tag==4)
    {
        
        
        
         if([[appDelegate.centerVC.dataArrayUpIsCreated objectAtIndex:appDelegate.centerVC.lastSelectedTeam] integerValue])
         /*{
             [self showPostActionSheet];
         }*/
         {
             if(self.commentTextVw.text.length>250)
             {
                 [self showAlertMessage:@"The text for coach update must be maximum 250 characters long." title:@""];
             
                 return;
             }
             
             
             
             isCompleteFinishCoachPost=0;
             isCompleteFinishWallPost=0;
             
             if(isSelectedCoachUpdate)
             {
                 
                 isCompleteCoachPost=1;
                 isCompleteWallPost=1;
                 
                 [self postOnWall];
                 [self postCoachUpdate];
                 
                 
                 
                 
                 
                 
                 
                 
             }
             else 
             {
                 isCompleteCoachPost=0;
                 isCompleteWallPost=1;
                 
                 [self postOnWall];
             }
             
         }
         else
         {
             isCompleteFinishCoachPost=0;
             isCompleteFinishWallPost=0;
             isCompleteCoachPost=0;
             isCompleteWallPost=1;
             [self postOnWall];
         }
        
        
        
        
        
       [self performSelector:@selector(showacInd) withObject:nil afterDelay:1.5];  //19th................june
        
        
      
    }
    
    

    
    
    
    
}

-(void)showacInd                                  //19th................june
{
    if(self.isSelectedVideo==1)
    {
        
        HomeVC *hvc=[[HomeVC alloc]init];
        
        [hvc fireBackgroundExecuting];
        
        isbgExec=YES;
    }
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
     NSString *choice = [self.camActionSheet buttonTitleAtIndex:buttonIndex];
    
        if ([choice isEqualToString:@"Take Photo"])
        {
             [self.commentTextVw resignFirstResponder];
            
            isVideoSelected=0;
            // do something else
            [self getCameraPicture:choice];
            NSLog(@"Camera will open");
            
        }
        else if ([choice isEqualToString:@"Choose From Photo Library"])
        {
             [self.commentTextVw resignFirstResponder];
            
            isVideoSelected=0;
            // do something else
            [self useCameraRoll:actionSheet];
            NSLog(@"Library will open");
            
        }
        else if ([choice isEqualToString:@"Take Video"])
        {
             [self.commentTextVw resignFirstResponder];
            
            isVideoSelected=1;
            // do something else
            [self getCameraPictureVideo:choice];
            NSLog(@"Video will open");
            
        }
        else if ([choice isEqualToString:@"Choose From Video Library"])
        {
             [self.commentTextVw resignFirstResponder];
            
            isVideoSelected=1;
            // do something else
            [self useCameraRollVideo:actionSheet];
            NSLog(@"Video Library will open");
            
        }

}


-(void)showPostActionSheet
{
    self.actionSheetChoicePost=[[UIActionSheet alloc] initWithTitle:@"Coach update?" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Yes",@"No", nil];
    
    [self.actionSheetChoicePost showInView:self.appDelegate.centerViewController.view];
}





-(void)postOnWall
{
    
      
    if((![self.commentTextVw.text isEqualToString:@""]) || self.previewimavw.hidden==NO)
    {
        NSMutableDictionary *command = [NSMutableDictionary dictionary];
        
        
        if([[appDelegate.centerVC.dataArrayUpIsCreated objectAtIndex:appDelegate.centerVC.lastSelectedTeam] integerValue])
        {
        
            if(isSelectedCoachUpdate)
            {
                
                NSDictionary *cdic= [appDelegate.centerVC.dataArrayUpCoachDetails objectAtIndex:appDelegate.centerVC.lastSelectedTeam];
                if([cdic objectForKey:@"creator_id"])
                    [command setObject:[cdic objectForKey:@"creator_id"] forKey:@"user_id"];
                else
                    [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"user_id"];
            }
            else
            {
                   [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"user_id"];
            }
        
        }
        else
        {
              [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"user_id"];
        }
        
        NSString *postText= self.commentTextVw.text;
        
        @autoreleasepool {
            postText=[postText stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n "]];
        }
        
        [command setObject:postText forKey:@"comment_text"];
        [command setObject:self.teamId forKey:@"team_id"];
         [command setObject:@"" forKey:@"video_link"];
        if(self.isSelectedVideo==1)
        {
            if(isSelectedVideoFromURL)
        [command setObject:self.videoURLStr forKey:@"video_link"];
        
        }
       
        SBJsonWriter *writer = [[SBJsonWriter alloc] init];
        
        
        NSString *jsonCommand = [writer stringWithObject:command];
        
        
        [self showHudView:@"Connecting..."];
        //  [self showActiveIndicatorOwnPost];
        [self showNativeHudView];
        NSLog(@"RequestParamJSON=%@",jsonCommand);
        
        
        
        
        
         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,2), ^{                  //19th......... june
        
        if(self.isSelectedVideo==1)
        {
            if(isSelectedVideoFromURL)
            [self sendRequestForPost:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam",UIImageJPEGRepresentation(self.previewimavw.image,1.0),@"video_thumb", nil]];
                else
            [self sendRequestForPost:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam",UIImageJPEGRepresentation(self.previewimavw.image,1.0),@"video_thumb",self.dataVideo,@"video", nil]];
        }
        else if(self.isSelectedImage==1)
        {
            [self sendRequestForPost:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam",UIImageJPEGRepresentation(self.previewimavw.image,1.0),@"image", nil]];
        }
        /*else if(isSelectedVideo==1)
         [appDelegate sendRequestFor:POST from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam",self.dataVideo,@"video", nil]];*/
        else
        {
            [self sendRequestForPost:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
        }
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 
                 NSLog(@"called");
                 
                 [self resetPostView];                                         //19th......june
                 
                 
                 //              if(isbgExec==YES)
                 //              {
                 //                  HomeVC *hc=[[HomeVC alloc]init];
                 //
                 //                  [hc finishBackgroundExecuting];
                 //
                 //                  isbgExec=NO;
                 //
                 //              }
                 
                 
                 
                 
                 
                 
             });
             
         });
    }
    else
    {
        [self showAlertMessage:@"Text can't be left blank."];
    }
}



/*-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if([actionSheet isEqual:self.actionSheetChoicePost])
    {
        
        isCompleteFinishCoachPost=0;
        isCompleteFinishWallPost=0;
        
       if(buttonIndex==0)
        {
            
            isCompleteCoachPost=1;
            isCompleteWallPost=1;
            
              [self postOnWall];
            [self postCoachUpdate];
            
            
            
            
            
            
            
            
        }
        else if(buttonIndex==1)
        {
            isCompleteCoachPost=0;
            isCompleteWallPost=1;
            
              [self postOnWall];
        }
        
    }
    else
    {
        [super actionSheet:actionSheet clickedButtonAtIndex:buttonIndex];
    }
}
*/

/////////////////////////////////////////////////////////////////////

-(void)postCoachUpdate
{
    NSString *postText=self.commentTextVw.text;
    
    
  
    
    
    
    @autoreleasepool {
        postText=[postText stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n "]];
    }
    
    if((![postText isEqualToString:@""]))
    {
          [self postUpdate:postText];
        
    }
    else
    {
       // [self showAlertMessage:@"Text can't be left blank."];
          [self postUpdate:@""];
    }
  
}



-(void)postUpdate:(NSString*)text
{
    
    
    NSMutableDictionary *command = [NSMutableDictionary dictionary];
    [command setObject:text forKey:@"status_update"];
    
    [command setObject:[appDelegate.centerVC.dataArrayUpButtonsIds objectAtIndex:appDelegate.centerVC. lastSelectedTeam] forKey:@"team_id"];
    
    
    
    NSDictionary *cdic= [appDelegate.centerVC.dataArrayUpCoachDetails objectAtIndex:appDelegate.centerVC.lastSelectedTeam];
    
    if([cdic objectForKey:@"creator_id"])
      [command setObject:[cdic objectForKey:@"creator_id"] forKey:@"user_id"];
        else
        [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"user_id"];
    
    
    
    
    
    
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
   /* [self showHudView:@"Connecting..."];
    [self showNativeHudView];*///Add Latest Ch
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    
    
    [appDelegate sendRequestFor:UPDATEPOST from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];
    
}




-(void)notifyRequesterWithData:(id) aData :(id)aData1
{
    
      isCompleteFinishCoachPost=1;
    if(isCompleteFinishWallPost)
    {
    [self hideHudView];
    [self hideNativeHudView];
    }
  
    
    if([aData isKindOfClass:[ConnectionManager class]])
    {
        ConnectionManager *aR=(ConnectionManager*)aData;
        if([aR.requestSingleId isEqualToString:UPDATEPOST])
        {
            //            self.updatetextvw.text=[self textForUpdateField:[appDelegate.centerVC.dataArrayUpTexts objectAtIndex:lastSelectedTeam]];
            //
            //            self.updatetextvw.enabled=NO;
            //            self.smsnumbertextl.hidden=YES;
            
        }
        
        
        return;
    }
    ConnectionManager *aR=(ConnectionManager*)aData1;
    NSString *str=(NSString*)aData;
    @autoreleasepool {
        if([aR.requestSingleId isEqualToString:UPDATEPOST ])
        {
            
            
            
            NSLog(@"Data=%@",str);
            
            
            
            if (str)
            {
                SBJsonParser *parser=[[SBJsonParser alloc] init];
                
                id res = [parser objectWithString:str];
                if ([res isKindOfClass:[NSDictionary class]])
                {
                    NSDictionary* aDict = (NSDictionary*) res;
                    
                    
                    
                    if([[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
                    {
                        appDelegate.centerVC.updatetextvw.text=self.commentTextVw.text;
                        
                        //[appDelegate.centerVC.dataArrayUpTexts replaceObjectAtIndex:appDelegate.centerVC. lastSelectedTeam withObject:appDelegate.centerVC.updatetextvw.text];  //on 03/12/14
                        
                        [appDelegate.centerVC.dataArrayUpTexts replaceObjectAtIndex:appDelegate.centerVC. lastSelectedTeam withObject:self.commentTextVw.text];
                        [appDelegate setUserDefaultValue:self.appDelegate.centerVC.dataArrayUpTexts ForKey:ARRAYTEXTS];
                       
                        appDelegate.centerVC.updatetextvw.editable=NO;
         /////////////////////////////////////////////////////////////////////////////
                        
                        Invite *invite=(Invite*)  [self objectOfTypeInvite:INVITE forTeam:[NSString stringWithFormat:@"%@", [aDict objectForKey:@"team_id"] ] forUpdate:3 forUpdateId:[aDict objectForKey:@"update_id"] andManObjCon:self.managedObjectContext];
                        if(!invite)
                        {
                            invite=[NSEntityDescription insertNewObjectForEntityForName:INVITE inManagedObjectContext:self.managedObjectContext];
                            
                            
                            
                            invite.teamName=[aDict objectForKey:@"team_name"];
                            invite.teamId=[NSString stringWithFormat:@"%@", [aDict objectForKey:@"team_id"] ];
                            invite.message=[aDict objectForKey:@"team_update"];//[NSString stringWithFormat:@"New status update for %@ team",invite.teamName];
                            invite.type=[NSNumber numberWithInt:3];
                            
                            invite.postId=[[NSString alloc] initWithFormat:@"%@", [aDict objectForKey:@"update_id"] ];
                            invite.inviteStatus=[[NSNumber alloc] initWithInt:1];
                            
                            
                            int difftime= [[NSTimeZone systemTimeZone] secondsFromGMT];
                            
                            NSDate *datetime=   [[appDelegate.dateFormatFullOriginalComment dateFromString:[aDict objectForKey:@"update_adddate"]] dateByAddingTimeInterval:difftime]  ;
                            invite.datetime=datetime;
                            invite.senderProfileImage=[ [NSString alloc] initWithFormat:@"%@%@", TEAM_LOGO_URL,[aDict objectForKey:@"team_logo"] ];
                            
                        }
                        [appDelegate saveContext];
                        
       //////////////////////////////////////////////////////////////////////////////
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        if(isCompleteFinishWallPost)
                        {
                           
                            [self takeActionAfterCompleted];
                        }
                       
                    }
                    else
                    {
                        [self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
                        //                        self.updatetextvw.text=[self textForUpdateField:[self.dataArrayUpTexts objectAtIndex:lastSelectedTeam]];
                        //                        self.updatetextvw.enabled=NO;
                        //                        self.smsnumbertextl.hidden=YES;
                        
                    }
                }
            }
            
        }
        
    }
    
    
    
    
    
}





-(void)takeActionAfterCompleted
{
    int index=homeVC.lastSelectedTeam;//[[[self.myFormRequest1 userInfo] objectForKey:@"Index"] integerValue];
    
    [homeVC requestFirst:index];
    [self resetPostView];
}


-(void)takeActionAfterCompleted2
{
    int index=homeVC.lastSelectedTeam;//[[[self.myFormRequest1 userInfo] objectForKey:@"Index"] integerValue];
    
    [homeVC requestFirst:index];
}



////////////////////////////////////////////////////////////////////

/*-(void)sendRequestForPost:(NSDictionary*)dic
{
    // NSString *str=POST;
    
    NSURL* url = [NSURL URLWithString:POSTLINK];
    ASIFormDataRequest *aRequest=  [[ASIFormDataRequest alloc] initWithURL:url] ;
    self.myFormRequest1=aRequest;
    [self.storeCreatedRequests addObject:self.myFormRequest1];
    
    
    [aRequest setShouldContinueWhenAppEntersBackground:YES];
    
    [aRequest setDelegate:self];
    [aRequest setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:homeVC. lastSelectedTeam ],@"Index", nil]];
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
                    [aRequest addData:[dic objectForKey:[[dic allKeys] objectAtIndex:i]] withFileName:@"socialvideo.mp4" andContentType:@"multipart/form-data" forKey:[[dic allKeys] objectAtIndex:i]];
                    
                   
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
    
}*/



-(void)sendRequestForPost:(NSDictionary*)dic
{
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL: [NSURL URLWithString:POSTLINK]]; // replace BASEURL
    client.parameterEncoding = AFJSONParameterEncoding;
    
    NSMutableURLRequest *request = [client multipartFormRequestWithMethod:@"POST" path:@"" parameters:nil constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
        
        
        if([[dic allKeys] count]>0)
        {
            
            
            for(int i=0;i<[[dic allKeys] count];i++)
            {
                NSLog(@"RequestParam=%@",[[dic allKeys] objectAtIndex:i]);
                
                if([[dic objectForKey:[[dic allKeys] objectAtIndex:i]] isKindOfClass:[NSData class]])
                {
                    if([[[dic allKeys] objectAtIndex:i] isEqualToString:@"video"])
                    {
                        
                        [formData appendPartWithFileData:[dic objectForKey:[[dic allKeys] objectAtIndex:i]] name:[[dic allKeys] objectAtIndex:i] fileName:@"user.mp4" mimeType:@"video/*"];
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
    
    
    [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:homeVC. lastSelectedTeam ],@"Index", nil];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         
         isCompleteFinishWallPost=1;
         
         if(isCompleteCoachPost)
         {
             if(isCompleteFinishCoachPost)
             {
                 [self hideHudView];
                 [self hideNativeHudView];
             }
         }
         else
         {
             [self hideNativeHudView];
             [self hideHudView];
         }
         
         
         
         NSString *str=[operation responseString];
         
         NSLog(@"Data=%@",str);
         
         
         //19th.............june
         if(isbgExec==YES)
         {
             HomeVC *hc=[[HomeVC alloc]init];
             
             [hc finishBackgroundExecuting];
             
             isbgExec=NO;
             
         }
         

         
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
                     
                     
                     /*int tag=lastSelectedTeam;
                      for(id v in self.menuupscrollview.subviews)
                      {
                      if([v isMemberOfClass:[UIButton class]])
                      {
                      UIButton *bt=(UIButton*)v;
                      if(tag==[v tag])
                      {
                      [bt setTitleColor:self.redcolor forState:UIControlStateNormal];
                      
                      }
                      else
                      {
                      [bt setTitleColor:self.darkgraycolor forState:UIControlStateNormal];
                      }
                      }
                      }
                      
                      if(lastSelectedTeam==0)
                      [self upBtapped:appDelegate.centerVC.buttonfirstinscroll];
                      else
                      [self upBtapped:[self.menuupscrollview viewWithTag:lastSelectedTeam]];*/
                     
                     
                     //    [self showHudAlert:[aDict objectForKey:@"message"]];
                     //  [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
                     
                     
                     
                     
                     
                     if(isCompleteCoachPost)
                     {
                         if(isCompleteFinishCoachPost)
                         {
                            // [self takeActionAfterCompleted];
                             
                             [self takeActionAfterCompleted2];              // 19th.....june
                             
                         }
                     }
                     else
                     {
                         [self takeActionAfterCompleted];
                     }
                     
                 }
                 else
                 {
                    // [self showAlertMessage:[aDict objectForKey:@"message"] title:@""];
                      [self takeActionAfterCompleted2];                   // 19.....june
                 }
             }
         }
         

     }
     
     
     
     
     
      failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
         isCompleteFinishWallPost=1;
         if(isCompleteCoachPost)
         {
             if(isCompleteFinishCoachPost)
             {
                 [self hideHudView];
                 [self hideNativeHudView];
             }
         }
         else
         {
             [self hideNativeHudView];
             [self hideHudView];
         }

         
     }];
    
    
    
    
    
    [operation start];


}


/*- (void)requestFinished:(ASIHTTPRequest *)request
{
	NSLog(@"Data Received in Connection Manager.... %@ ",[request responseString]);
        isCompleteFinishWallPost=1;
    
    if(isCompleteCoachPost)
    {
        if(isCompleteFinishCoachPost)
        {
        [self hideHudView];
        [self hideNativeHudView];
        }
    }
    else
    {
        [self hideNativeHudView];
        [self hideHudView];
    }
  
   
  
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
            
                
                
                
                
                if(isCompleteCoachPost)
                {
                    if(isCompleteFinishCoachPost)
                    {
                        [self takeActionAfterCompleted];
                        
                        
                        
                    }
                }
                else
                {
                    [self takeActionAfterCompleted];
                }
                
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
 
       isCompleteFinishWallPost=1;
    if(isCompleteCoachPost)
    {
        if(isCompleteFinishCoachPost)
        {
            [self hideHudView];
            [self hideNativeHudView];
        }
    }
    else
    {
        [self hideNativeHudView];
        [self hideHudView];
    }
 
	//[self showAlertMessage:CONNFAILMSG];ChAfter
	
}
*/

-(void)resetPostView
{
    self.previewimavw.image=nil;
   
    isSelectedVideo=0;
    self.isSelectedVideoFromURL=0;
    self.videoURLStr=nil;
    isSelectedImage=0;
  
    self.commentTextVw.text=@"";
    self.dataVideo=nil;
    
      [self showPostView:0];
}

-(void)showPostView:(int)mode
{
    if(mode==0)
    {
        /*[UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.75];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.navigationController.view cache:YES];
        [self.navigationController popViewControllerAnimated:NO];
        [UIView commitAnimations];*/
        [self dismissModal];
      
       
    }
    else if(mode==1)
    {
        self.previewimavw.hidden=YES;
        self.crosspreviewbt.hidden=YES;
        self.keyboardtopVw.hidden=NO;
    }
    else if(mode==2)
    {
        self.previewimavw.hidden=NO;
        self.crosspreviewbt.hidden=NO;
        self.keyboardtopVw.hidden=YES;
    }
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)  picker
{
    
    [super imagePickerControllerDidCancel:picker];
    
    
    self.camActionSheet=nil;
    
    //[appDelegate setHomeView];
}



-(void)loadVideoURL :(NSString*)videourlstr :(NSString*)thumburlstr :(ImageInfo*)thumbInfo
{
        [self.commentTextVw becomeFirstResponder];
    if(thumbInfo.image)
    self.previewimavw.image=thumbInfo.image;
    else
    {
        if(thumburlstr && (![thumburlstr isEqualToString:@""]))
        {
            [self.previewimavw setImageWithURL:[[NSURL alloc] initWithString:thumburlstr] placeholderImage:self.noVideThumbImage];
        }
        else
        self.previewimavw.image=self.noVideThumbImage;
    }
    
    isSelectedVideo=1;
    isSelectedVideoFromURL=1;
    self.videoURLStr=videourlstr;
    [self showPostView:2];
    self.camActionSheet=nil;
    
    
    
}

-(void)openTrainningVideos
{
    [super openTrainningVideos];
    
    [self.commentTextVw resignFirstResponder];
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissModal];
    
    
    if(!isFirstTimeEnter)
    {
        self.commentTextVw.text=@"";
        self.commentTextVw.textColor=self.blackcolor;
        self.imageViewCoachUpdate.hidden=YES;
        
        isFirstTimeEnter=1;
    }
   // [appDelegate setHomeView];
   // NSString *choice = [self.camActionSheet buttonTitleAtIndex:0];
   // if ([choice isEqualToString:@"Take Video"] || [choice isEqualToString:@"Choose From Library "])
    if(isVideoSelected)
    {
        @autoreleasepool {
            
            
            [self showHudView:@"Converting..."];   // 19th.....june
            
            self.previewimavw.image=[self getThumnailForVideo:[info objectForKey:UIImagePickerControllerMediaURL]];
            // 19th.....june
            
            [self showPostView:2];    //19th...june
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,2), ^{
            
            NSURL *outputurl=nil;
            
            NSURL *videoURL=[info objectForKey:UIImagePickerControllerMediaURL];
            outputurl=videoURL;
            self.dataVideo=[NSData dataWithContentsOfURL:outputurl];
                
            //self.previewimavw.image=[self getThumnailForVideo:[info objectForKey:UIImagePickerControllerMediaURL]];
            // 19th.....june
            
            isSelectedVideo=1;
            //[self showPostView:2];  // 19th.....june
            
            
            
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
            //[self showHudView:@"Converting..."];
                
                
                
                
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
                            
                          //  [self finishedVideoConvert];  // 19th.....june
                            
                            
                            
                            break;
                            
                            
                        default:
                            NSLog(@"Export Default");
                           // [self finishedVideoConvert];  // 19th.....june
                            break;
                            
                    }
                    
                    
                }];
                
            }
            else
            {
                
                
               // [self finishedVideoConvert];  // 19th.....june
                
                
                
            }
            
            
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    NSLog(@"called2");
                    
                    [self finishedVideoConvert];              //19th......june
                    
                    
                });
                
                
            });
            
            
            
            
            
            
            
            
            
            
            ///////////////
        }
        info=nil;
        self.camActionSheet=nil;
    }
    else
    {
        isSelectedImage=1;
        
        @autoreleasepool {
            
            
            UIImage *ima1=nil;
            
            
            if([info objectForKey:UIImagePickerControllerEditedImage])
                ima1=[[UIImage alloc] initWithData:UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerEditedImage], 0.1)];
            else
                ima1=[[UIImage alloc] initWithData:UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], 0.1)];
            
            /* if([info objectForKey:UIImagePickerControllerEditedImage])
             self.previewimavw.image=[self getImage:[info objectForKey:UIImagePickerControllerEditedImage] isWidth:1 length:296   ];
             else
             self.previewimavw.image=[self getImage:[info objectForKey:UIImagePickerControllerOriginalImage] isWidth:1 length:296   ];*/
            UIImage *ima2=[self getImage:ima1 isWidth:1 length:296  ];
            
            
            
            
            
            self.previewimavw.image=ima2;
            
            ima1=nil;
            ima2=nil;
        }
       // [self dismissModal];
     //   [appDelegate setHomeView];
        [self showPostView:2];
        
        
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





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setPreviewimavw:nil];
    [self setCommentTextVw:nil];
    [self setKeyboardtopVw:nil];
    [self setTopbarvw:nil];
    [self setCheckbt:nil];
    [self setCheckbtlabel:nil];
    [super viewDidUnload];
}
- (IBAction)alsoCoachUpdateAction:(id)sender
{
    
    isSelectedCoachUpdate=!isSelectedCoachUpdate;
    [self reloadButton];
    
    
    
}

-(void)reloadButton
{
    if([[appDelegate.centerVC.dataArrayUpIsCreated objectAtIndex:appDelegate.centerVC.lastSelectedTeam] integerValue])
    {
        self.checkbt.hidden=NO;
         self.checkbtlabel.hidden=NO;
    }
    else
    {
      self.checkbt.hidden=YES;
           self.checkbtlabel.hidden=YES;
        
        
     
        
        
     CGRect r /*= self.camsecbt.frame;
        
         r.origin.x=278;
        self.camsecbt.frame=r*/;
        
      r = self.videobt.frame;
        r.origin.x=155;
        self.videobt.frame=r;
    }
    
    
    if(isSelectedCoachUpdate==0)
        [self.checkbt setBackgroundImage:self.nontickimage forState:UIControlStateNormal];
    else
        [self.checkbt setBackgroundImage:self.tickimage forState:UIControlStateNormal];
}

@end
