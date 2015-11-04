//
//  PhotoFirstViewController.m
//  Wall
//
//  Created by Mindpace on 03/03/14.
//
//

#import "PhotoFirstViewController.h"
#import "AFHTTPClient.h"
#import "UIImageView+AFNetworking.h"
#import "PhotoMainVC.h"
#import "PhotoMainVC.h"
@interface PhotoFirstViewController ()

@end

@implementation PhotoFirstViewController

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
    
    self.topview.backgroundColor=appDelegate.barGrayColor;
    self.photoAlbumsImage.image=self.noAlbumImage;
    self.videoAlbumImage.image=self.noVideThumbImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - GetRequestDataFromServer


-(void)getUpdateData{
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
        
        NSString *str=[request responseString];
        
        NSLog(@"Data=%@",str);
        [self hideNativeHudView];
        
        
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
                    
                
                        self.AllPhotos=[aDict objectForKey:@"post_details"];
                        self.AllPhotosArr=self.AllPhotos;
                        NSLog(@"alll Post Photos %@",self.AllPhotos);
                        NSMutableArray *s=[[NSMutableArray alloc] init];
                        self.albumNameList=s;
                        
                        self.TeamNameArr=[[NSMutableArray alloc] init] ;
                        self.userName=[[NSMutableArray alloc] init] ;
                        
                        for (NSDictionary *d in  self.AllPhotos)
                        {
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
                        
                        [self.TeamNameArr addObject:@"All Teams"];
                        [self.userName addObject:@"All Player"];
                        [self.photoAlbumsImage setImageWithURL:[NSURL URLWithString:[self.albumNameList objectAtIndex:0]] placeholderImage:self.noAlbumImage];
                        
                }
                else
                {
                                       
                }
            }
        }
        
        
	}
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    [self hideNativeHudView];
	//[self showAlertMessage:CONNFAILMSG];ChAfter
	
}


- (void)requestFinishedVideo:(ASIHTTPRequest *)request
{
    @autoreleasepool {
        
        NSLog(@"Data Received in Connection Manager.... %@ ",[request responseString]);
        
        NSString *str=[request responseString];
        
        NSLog(@"Data=%@",str);
        [self hideNativeHudView];
        
        
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
                    
                    
                  
                        
                        self.AllVideos=[aDict objectForKey:@"post_details"];
                        self.AllVideosArr=self.AllVideos;
                        NSLog(@"all post Videos %@",self.AllVideos);
                        NSMutableArray *s=[[NSMutableArray alloc] init];
                        self.videoNameList=s;
                        
                        self.videoTeamNameArr=[[NSMutableArray alloc] init] ;
                        self.videoUserName=[[NSMutableArray alloc] init] ;
                        
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
                            
                            if (![self.videoUserName containsObject:[d valueForKey:@"Name"]]) {
                                [self.videoUserName addObject:[d valueForKey:@"Name"]];
                            }
                            if (![self.videoTeamNameArr containsObject:[d valueForKey:@"team_name"]]) {
                                [self.videoTeamNameArr addObject:[d valueForKey:@"team_name"]];
                            }
                            
                        }
                        
                        [self.videoTeamNameArr addObject:@"All Teams"];
                        [self.videoUserName addObject:@"All Player"];
                        
                        
                        [self.videoAlbumImage setImageWithURL:[NSURL URLWithString:[self.videoNameList objectAtIndex:0]] placeholderImage:self.noAlbumImage];
                    
                    
                }
                else
                {
                    
                }
            }
        }
        
        
	}
}


- (void)requestFailedVideo:(ASIHTTPRequest *)request
{
    [self hideNativeHudView];
	//[self showAlertMessage:CONNFAILMSG];ChAfter
	
}


- (IBAction)videoAlbum:(id)sender {
    PhotoMainVC *mainVc=[[PhotoMainVC alloc] initWithNibName:@"PhotoMainVC" bundle:nil];
    
    mainVc.isPostPhotos=NO;
    mainVc.AllVideos=self.AllVideos;
    mainVc.AllVideosArr=self.AllVideosArr;
    mainVc.userName=self.videoUserName;
    mainVc.TeamNameArr=self.videoTeamNameArr;
    mainVc.videoNameList=self.videoNameList;
    mainVc.allVideosLink=self.allVideosLink;
    
    [self.navigationController pushViewController:mainVc animated:YES];
 
    
}

- (IBAction)photoAlbum:(id)sender {
    
    PhotoMainVC *mainVc=[[PhotoMainVC alloc] initWithNibName:@"PhotoMainVC" bundle:nil];
    mainVc.isPostPhotos=YES;
    mainVc.AllPhotos=self.AllPhotos;
    mainVc.AllPhotosArr=self.AllPhotosArr;
    mainVc.userName=self.userName;
    mainVc.TeamNameArr=self.TeamNameArr;
    self.albumNameList=self.albumNameList;

    [self.navigationController pushViewController:mainVc animated:YES];
    
}
@end
