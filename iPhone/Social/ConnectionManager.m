//
//  ConnectionManager.m
//  EventManager
//
//  Created by Satish Kumar on 3/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//


#import "ConnectionManager.h"
#import "AppDelegate.h"
#import "ASIHTTPRequest.h"
//#import "AFHTTPRequestOperation.h"
#define	DISPATCH_QUEUE_PRIORITY_DEFAULT  0
@implementation ConnectionManager

@synthesize	requester,handler,aRequest;
@synthesize requestId;
@synthesize isSynchronous,webServiceResponse,nextpageschurch,nextpagesrestaurent,nextpagesschool,requestSingleId ,subrequestqueue,nextpagetokenblankcounter,checkqueuefinished,aMyRequest1,aMyRequest2,aMyRequest3,storeCreatedUser;


-(id)init
{
	if ((self = [super init]))
    {
		appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        webServiceResponse=[[NSMutableDictionary alloc] init];
        
        storeCreatedUser=[[NSMutableArray alloc] init];
	}
	return self;
}

/////////////////////For Single Request
/*
-(BOOL)callWebServiceMethodSingle:(NSString*) reqId ofType:(BOOL) isSync requestSource:(id<ConnectionProtocol>) reqSource andHandler:(id<ResponseHandler>) resHandler parameter:(NSDictionary*)dic
{
    appDelegate.arrItems=nil;
	self.requester = reqSource;
	self.handler = resHandler;
	self.requestSingleId = reqId;
	isSynchronous = isSync;
    BOOL isSent = NO;
    NSString* str = [self urlStringSingleRequest];
    
    if (str)
    {
        NSLog(@"Requested: %@",str);
        NSURL* url = [NSURL URLWithString:str];
 
        ASIFormDataRequest *aRequest1=[[ASIFormDataRequest alloc] initWithURL:url];
        self.aRequest = aRequest1;
        [self.storeCreatedUser addObject:self.aRequest];
        [aRequest setShouldContinueWhenAppEntersBackground:YES];
       
        [aRequest setDelegate:self];
        [aRequest setUsername:requestSingleId];
        [aRequest setValidatesSecureCertificate:NO];
        [ASIFormDataRequest setShouldThrottleBandwidthForWWAN:YES];

        
        
        
        
        if([[dic allKeys] count]>0)
        {
            [aRequest setRequestMethod:@"POST"];
            for(int i=0;i<[[dic allKeys] count];i++)
            {
                NSLog(@"RequestParam=%@",[[dic allKeys] objectAtIndex:i]);
                
                if([[dic objectForKey:[[dic allKeys] objectAtIndex:i]] isKindOfClass:[NSData class]])
                {
                    [aRequest setPostFormat:ASIMultipartFormDataPostFormat];
                    [aRequest addRequestHeader:@"Content-Type" value:@"multipart/form-data"];
                   
                   [aRequest addData:[dic objectForKey:[[dic allKeys] objectAtIndex:i]] withFileName:@"user.jpg" andContentType:@"image/jpeg" forKey:[[dic allKeys] objectAtIndex:i]];
                }
                else
                {
                     NSLog(@"RequestParam=%@ and Key=%@",[dic objectForKey:[[dic allKeys] objectAtIndex:i]],[[dic allKeys] objectAtIndex:i]);
                     [aRequest addPostValue:[dic objectForKey:[[dic allKeys] objectAtIndex:i]] forKey:[[dic allKeys] objectAtIndex:i]];
                    
                    
                   
                }
                
                
              
                
                
                
               
            }
        
        
        }
        
        
        [aRequest setDidFinishSelector:@selector(requestSingleFinished:)];
          [aRequest setDidFailSelector:@selector(requestSingleFailed:)];
       
        [aRequest startAsynchronous];
        isSent = YES;
        
        
    }
    
    
	return isSent;
}
*/
-(BOOL)callWebServiceMethodSingle:(NSString*) reqId ofType:(BOOL) isSync requestSource:(id<ConnectionProtocol>) reqSource andHandler:(id<ResponseHandler>) resHandler parameter:(NSDictionary*)dic
{
    appDelegate.arrItems=nil;
	self.requester = reqSource;
	self.handler = resHandler;
	self.requestSingleId = reqId;
	isSynchronous = isSync;
    BOOL isSent = NO;
    NSString* str = [self urlStringSingleRequest];
    
    if (str)
    {
        NSLog(@"Requested: %@",str);
        NSURL* url = [NSURL URLWithString:str];
        
        
        
        
        if([reqId isEqualToString:FINDPLAYGROUND])
        {
        
        
        //////////////////////////////////////////
        
        
        
        
        
        ASIFormDataRequest *aRequest1=[[ASIFormDataRequest alloc] initWithURL:url];
        self.aRequest = aRequest1;
        [self.storeCreatedUser addObject:self.aRequest];
        [aRequest setShouldContinueWhenAppEntersBackground:YES];
        
        [aRequest setDelegate:self];
        [aRequest setUsername:requestSingleId];
        [aRequest setValidatesSecureCertificate:NO];
        [ASIFormDataRequest setShouldThrottleBandwidthForWWAN:YES];
        
        
        
        
        
        if([[dic allKeys] count]>0)
        {
            [aRequest setRequestMethod:@"POST"];
            for(int i=0;i<[[dic allKeys] count];i++)
            {
                NSLog(@"RequestParam=%@",[[dic allKeys] objectAtIndex:i]);
                
                if([[dic objectForKey:[[dic allKeys] objectAtIndex:i]] isKindOfClass:[NSData class]])
                {
                    [aRequest setPostFormat:ASIMultipartFormDataPostFormat];
                    [aRequest addRequestHeader:@"Content-Type" value:@"multipart/form-data"];
                    
                    [aRequest addData:[dic objectForKey:[[dic allKeys] objectAtIndex:i]] withFileName:@"user.jpg" andContentType:@"image/jpeg" forKey:[[dic allKeys] objectAtIndex:i]];
                }
                else
                {
                    NSLog(@"RequestParam=%@ and Key=%@",[dic objectForKey:[[dic allKeys] objectAtIndex:i]],[[dic allKeys] objectAtIndex:i]);
                    [aRequest addPostValue:[dic objectForKey:[[dic allKeys] objectAtIndex:i]] forKey:[[dic allKeys] objectAtIndex:i]];
                    
                    
                    
                }
                
                
                
                
                
                
                
            }
            
            
        }
        
        
        [aRequest setDidFinishSelector:@selector(requestSingleFinished:)];
        [aRequest setDidFailSelector:@selector(requestSingleFailed:)];
        
        [aRequest startAsynchronous];
        
        
        
    }
    
      //////////////////////////////////////
        else
        {
        AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL: url]; // replace BASEURL
        client.parameterEncoding = AFJSONParameterEncoding;
        
        self.aRequestClient=client;
        
        NSMutableURLRequest *request = [client multipartFormRequestWithMethod:@"POST" path:@"" parameters:nil constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
            
            
            
            if([[dic allKeys] count]>0)
            {
                
                
                for(int i=0;i<[[dic allKeys] count];i++)
                {
                    NSLog(@"RequestParam=%@",[[dic allKeys] objectAtIndex:i]);
                    
                   if([[dic objectForKey:[[dic allKeys] objectAtIndex:i]] isKindOfClass:[NSData class]])
                    {
                        
                        [formData appendPartWithFileData:[dic objectForKey:[[dic allKeys] objectAtIndex:i]] name:[[dic allKeys] objectAtIndex:i] fileName:@"user.jpg" mimeType:@"image/*"];
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
         self.aRequestOperation=operation;
        
        [client enqueueHTTPRequestOperation:operation];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             
             
             NSLog(@"Data Received in Connection Manager.... %@ ",[operation responseString]);
             //  self.webServiceResponse = [request responseString];
             
             if([self.requestSingleId isEqualToString:FINDPLAYGROUND])
             {
                 self.nextpagescommon=[NSMutableArray array];
                 [self.webServiceResponse setObject:[operation responseString] forKey:FINDPLAYGROUND];
                 
                 [self createSubRequestSingle:[operation responseString]];
                 
             }
             else
             {
                 [handler  notifyRequestFinishedSingle:self];
             }

             
             
             
             
             
         }
         
         
         
         
         
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
          
             NSLog(@"Error receiving data : %@ ",[operation.error description]);
             [handler notifyRequestFinishedSingle:self];
             
         }];
        
        
        
        
        
        [operation start];

    }
    
        
        isSent = YES;
        
        
    }
    
    
	return isSent;
}


-(NSString*)urlStringSingleRequest
{
   // NSString* s = nil;
    
    if ([requestSingleId isEqualToString:LOGIN])
    {
        return LINKFORLOGIN;
    }
    else if ([requestSingleId isEqualToString:SIGNUP])
    {
        return LINKFORREGISTER;
    }
    else if ([requestSingleId isEqualToString:VERIFY])
    {
        return LINKFORVERIFY;
    }
    else if ([requestSingleId isEqualToString:FEEDBACK])
    {
        return FEEDBACKLINK;
    }
    else if ([requestSingleId isEqualToString:INVITEMAIL])
    {
        return INVITEMAILLINK;
    }

    else if ([requestSingleId isEqualToString:LOGOUT])
    {
        return LOGOUTLINK;
    }
    else if ([requestSingleId isEqualToString:ADDEVENT])
    {
        return ADDEVENTLINK;
    }
   else if ([requestSingleId isEqualToString:EDITEVENT])
    {
    return EDITEVENTLINK;
    }
      else if ([requestSingleId isEqualToString:TEAM_LISTING])
    {
        //return TEAM_LISTING_LINK;
        return  TEAMROSTERLINK;
    }
      else if ([requestSingleId isEqualToString:ADD_TEAM])
      {
          return ADD_TEAM_LINK;
      }
      else if ([requestSingleId isEqualToString:EDIT_TEAM])
      {
          return EDIT_TEAM_LINK;
      }
      else if ([requestSingleId isEqualToString:ADD_PLAYER])
      {
          return ADD_PLAYER_LINK;
      }
      else if ([requestSingleId isEqualToString:EDIT_PLAYER])
      {
          return EDIT_PLAYER_LINK;
      }
      else if ([requestSingleId isEqualToString:DELELTE_PLAYER])
      {
          return DELETE_PLAYER_LINK;
      }
      else if ([requestSingleId isEqualToString:DELETE_TEAM])
      {
          return DELETE_TEAM_LINK;
      }
      else if ([requestSingleId isEqualToString:POST])
      {
          return POSTLINK;
      }
      else if ([requestSingleId isEqualToString:PROFILEEDIT])
      {
          return PROFILEEDITLINK;
      }
      else if ([requestSingleId isEqualToString:EVENTDETAILS])
      {
          return EVENTDETAILSLINK;
      }
      else if ([requestSingleId isEqualToString:DELETEEVENT])
      {
          return DELETEEVENTLINK;
      }
      else if ([requestSingleId isEqualToString:INVITEPLAYERS])
      {
          return INVITEPLAYERSLINK;
      }
      else if ([requestSingleId isEqualToString:TEAMINVITESTATUS])
      {
          return TEAMINVITESTATUSLINK;
      }
      else if ([requestSingleId isEqualToString:EVENTINVITESTATUS])
      {
          return EVENTINVITESTATUSLINK;
      }
      else if ([requestSingleId isEqualToString:FORGOTPASSWORD])
      {
          return FORGOTPASSWORDLINK;
      }
      else if ([requestSingleId isEqualToString:UPDATEPOST])
      {
          return UPDATEPOSTLINK;
      }
      else if ([requestSingleId isEqualToString:COMMENTPOST])
      {
          return COMMENTPOSTLINK;
      }
      else if ([requestSingleId isEqualToString:INVITEFRIENDS])
      {
          return INVITEFRIENDSLINK;
      }
      else if ([requestSingleId isEqualToString:INVITEFRIENDSSTATUS])
      {
          return INVITEFRIENDSSTATUSLINK;
      }
      else if ([requestSingleId isEqualToString:VIEWEVENTSTATUS])
      {
          return VIEWEVENTSTATUSLINK;
      }
      else if ([requestSingleId isEqualToString:SENDADDEVENTPUSH])
      {
          return SENDADDEVENTPUSHLINK;
      }
    else if ([requestSingleId isEqualToString:FINDPLAYGROUND])
    {
        
        NSString *str=[[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%@&types=%@&sensor=true&key=%@", appDelegate.locationLatPlayground, appDelegate.locationLongPlayground, [NSString stringWithFormat:@"%i", 3000], [NSString stringWithFormat:@"%@|%@", WALL_PARK,WALL_STADIUM ], GOOGLEPLACESAPIKEY] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        
        
        return str;
        
      //  https://maps.googleapis.com/maps/api/place/search/json?location=22.572646,88.363894&radius=10000&types=park&sensor=true&key=AIzaSyBskHuWp00YPJiE5I_7hOC-iAeBbnfuIw4
    }
    /*Changeelse if ([requestSingleId isEqualToString:GETPROPERTYFIELDPOPULATION])
    {
        return @"http://www.getmymobileapps.com/app_realestate/scripts/ws/get_property_form_details.json";
    }
    else if ([requestSingleId isEqualToString:ADDPROPERTIES])
    {
        return @"http://www.getmymobileapps.com/app_realestate/scripts/ws/post_property_details.json";
    }
    else if ([requestSingleId isEqualToString:GETCUSTOMERDETAILS])
    {
        return @"http://www.getmymobileapps.com/app_realestate/scripts/ws/get_contact_details.json";
    }
    */
    
    
    
    //
    /*
    
    else if ([requestId isEqualToString:MYACCOUNT])
    {
        NSDictionary *facebookUserInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"kSHKFacebookUserInfo"];
        NSString* fbUserId = [facebookUserInfo objectForKey:@"id"];//@"1124089523";//
        if (fbUserId)
        {
            return [NSString stringWithFormat:@"%@%@", MYACCOUNT_PAGE,fbUserId];
        }
    }
    else if ([requestId isEqualToString:FS_BARS])
    {
        // return  [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_secret=DOKP3Y003XDT30W5ZSD1BLI0XH24Q4SKJ2FQLQMOEFI02CTX&client_id=EHTAUJZD5A0CGMQBUDWNDNVROTOBA4XHUME2PMCAYMKPEMQH&ll=%f,%f&v=20120507&categoryId=4bf58dd8d48988d116941735&intent=checkin",appDelegate.locationLat,appDelegate.locationLong];
        //   NSLog(@"Bars-%@",[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%@&types=%@&sensor=true&key=%@", appDelegate.locationLat, appDelegate.locationLong, [NSString stringWithFormat:@"%i", 10000], GP_BARS, GOOGLEPLACESAPIKEY]);
        return [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%@&types=%@&sensor=true&key=%@", appDelegate.locationLat, appDelegate.locationLong, [NSString stringWithFormat:@"%i", 10000], GP_BARS, GOOGLEPLACESAPIKEY];
        
        
    }
    else if ([requestId isEqualToString:FS_PUBS])
    {
        // return  [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_secret=DOKP3Y003XDT30W5ZSD1BLI0XH24Q4SKJ2FQLQMOEFI02CTX&client_id=EHTAUJZD5A0CGMQBUDWNDNVROTOBA4XHUME2PMCAYMKPEMQH&ll=%f,%f&v=20120507&categoryId=4bf58dd8d48988d11b941735&intent=checkin",appDelegate.locationLat,appDelegate.locationLong];
        return [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%@&types=%@&sensor=true&key=%@", appDelegate.locationLat, appDelegate.locationLong, [NSString stringWithFormat:@"%i", 10000], GP_RESTURANTS, GOOGLEPLACESAPIKEY];
    }
    else if ([requestId isEqualToString:FS_RESTURANTS])
    {
        //  return  [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_secret=DOKP3Y003XDT30W5ZSD1BLI0XH24Q4SKJ2FQLQMOEFI02CTX&client_id=EHTAUJZD5A0CGMQBUDWNDNVROTOBA4XHUME2PMCAYMKPEMQH&ll=%f,%f&v=20120507&categoryId=4bf58dd8d48988d1c4941735&intent=checkin",appDelegate.locationLat,appDelegate.locationLong];
        return [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%@&types=%@&sensor=true&key=%@", appDelegate.locationLat, appDelegate.locationLong, [NSString stringWithFormat:@"%i", 10000], GP_NIGHTCLUB, GOOGLEPLACESAPIKEY];
    }
    else if ([requestId isEqualToString:FS_TAXI])
    {
        //   return  [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%@&types=%@&sensor=true&key=%@", appDelegate.locationLat, appDelegate.locationLong, [NSString stringWithFormat:@"%i", 10000], GP_TAXI, GOOGLEPLACESAPIKEY];        //51.641571,-0.4922268
        return [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%@&types=%@&sensor=true&key=%@", appDelegate.locationLat,appDelegate.locationLong, [NSString stringWithFormat:@"%i", 10000], GP_TAXI, GOOGLEPLACESAPIKEY];
        
        
        
        // return [NSString stringWithFormat:@"http://ajax.googleapis.com/ajax/services/search/local?v=1.0&q=taxi&sll=%f,%f&sspn=0.125,0.125&rsz=8&start=0&key=%@",appDelegate.locationLat,appDelegate.locationLong,GOOGLEPLACESAPIKEY];
    }*/
    
   /* if (s)
    {
        return [NSString stringWithFormat:@"%@%@",BASEURL,s];
    }*/
    return nil;
}







//52.467518,-1.779166
- (void)requestSingleFinished:(ASIHTTPRequest *)request
{
	NSLog(@"Data Received in Connection Manager.... %@ ",[request responseString]);
  //  self.webServiceResponse = [request responseString];
    
    if([self.requestSingleId isEqualToString:FINDPLAYGROUND])
    {
        self.nextpagescommon=[NSMutableArray array];
        [self.webServiceResponse setObject:[request responseString] forKey:FINDPLAYGROUND];
        
        [self createSubRequestSingle:[request responseString]];
	
	}
    else
    {
        [handler  notifyRequestFinishedSingle:self];
    }
	
}

- (void)requestSingleFailed:(ASIHTTPRequest *)request
{
    //self.webServiceResponse = request.error;
	NSLog(@"Error receiving data : %@ ",[request.error description]);
	[handler notifyRequestFinishedSingle:self];
	
}



/////////////////////







-(BOOL)callWebServiceMethod:(NSMutableArray*) reqId ofType:(BOOL) isSync requestSource:(id<ConnectionProtocol>) reqSource andHandler:(id<ResponseHandler>) resHandler
{
    ASINetworkQueue* aQueue1 =nil;
    aQueue1 = [ASINetworkQueue queue];
    [aQueue1 setDelegate:self];
    [aQueue1 setShouldCancelAllRequestsOnFailure:NO];
 
    [aQueue1 setQueueDidFinishSelector:@selector(queueSubFinished:)];
     // [aQueue1 setQueueDidFailSelector:@selector(queueSubFailed:)];
    self.subrequestqueue=aQueue1;
    self.nextpagetokenblankcounter=0;
    self.checkqueuefinished=0;
    
    
    self.nextpageschurch=[NSMutableArray array];
    self.nextpagesrestaurent=[NSMutableArray array];
    self.nextpagesschool=[NSMutableArray array];
	self.requester = reqSource;
	self.handler = resHandler;
	self.requestId = reqId;
	isSynchronous = isSync;
    BOOL isSent = NO;
  //  NSString* str = [self urlString:[self.requestId objectAtIndex:0]];
     ASINetworkQueue* aQueue =nil;
    
    
   
      
        aQueue = [ASINetworkQueue queue];
        [aQueue setDelegate:self];
        [aQueue setShouldCancelAllRequestsOnFailure:NO];
        [aQueue setMaxConcurrentOperationCount:[reqId count]];
        [aQueue setQueueDidFinishSelector:@selector(queueFinished:)];
        
        
        /*NSMutableDictionary *mt=[[NSMutableDictionary alloc] init];
        self.dicForPh=mt;
        [mt release];*/
        
        
        for (int i=0;i<[requestId count];i++)
        {
            NSString *a=[self urlString:[requestId objectAtIndex:i]];
            
            
            if (a)
            {
                
                
               
                ASIHTTPRequest  *aRequest1=  [[ASIHTTPRequest alloc ] initWithURL:[NSURL URLWithString:a]];
                self.aMyRequest1=aRequest1;
                [self.storeCreatedUser addObject:self.aMyRequest1];
                [aRequest1 setShouldContinueWhenAppEntersBackground:YES];
                [aRequest1 setValidatesSecureCertificate:NO];
                [ASIHTTPRequest setShouldThrottleBandwidthForWWAN:YES];
                
              
                [aRequest1 setDelegate:self];
                
             
                
                 NSMutableDictionary *mtd=[[NSMutableDictionary alloc] init];
                [mtd setObject:[requestId objectAtIndex:i] forKey:@"Req_Name"];
             
                [aRequest1 setUserInfo:mtd];
              
                [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
                
                
                [aQueue addOperation:aRequest1];
            }
        }
        
        
        
    




[aQueue go];




        isSent = YES;
    
   
    
	return isSent;
}





//52.467518,-1.779166
- (void)requestFinished:(ASIHTTPRequest *)request
{
	NSLog(@"Data Received in Connection Manager.... %@ ",[request responseString]);
    
    NSLog(@"Key=%@",[[[request userInfo] allKeys] objectAtIndex:0]);
    
   
     [self.webServiceResponse setObject:[request responseString] forKey:[request.userInfo objectForKey:[[[request userInfo] allKeys] objectAtIndex:0]]];
    
    
    
    
    
    [self createSubRequest:[request.userInfo objectForKey:[[[request userInfo] allKeys] objectAtIndex:0]] :[request responseString]];
	
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
   // [self.webServiceResponse addObject:[request error]];
	NSLog(@"Error receiving data : %@ ",[request.error description]);
     self.nextpagetokenblankcounter++;
}




-(void)createSubRequestSingle :(NSString*)response
{
    NSString* pagetoken=nil;
    if(response)
    {
        SBJsonParser *parser=[[SBJsonParser alloc] init];
        
        id res = [parser objectWithString:response];
        if ([res isKindOfClass:[NSDictionary class]])
        {
            NSDictionary* aDict = (NSDictionary*) res;
            
            //  aDict = [aDict objectForKey:@"response"];
            
            
            
            
            if(![[aDict objectForKey:@"status"] isEqualToString:@"OK"])
            {
                self.nextpagetokenblankcounter++;
                
               /* if(self.checkqueuefinished)
                {
                    //self.checkqueuefinished=1;
                    NSLog(@"From pagetoken");
                    NSLog(@"NextPAGECOUNTERBLANK=%i",self.nextpagetokenblankcounter);
                    if(self.nextpagetokenblankcounter==3)
                        [handler notifyRequestFinished:self];
                }*/
                  [handler notifyRequestFinishedSingle:self];
                return;
            }
            pagetoken = [aDict objectForKey:@"next_page_token"];
            
            if(!pagetoken)
            {
                self.nextpagetokenblankcounter++;
                
                
                /*if(self.checkqueuefinished)
                {
                    //self.checkqueuefinished=1;
                    NSLog(@"From pagetoken");
                    NSLog(@"NextPAGECOUNTERBLANK=%i",self.nextpagetokenblankcounter);
                    if(self.nextpagetokenblankcounter==3)
                        [handler notifyRequestFinished:self];
                }*/
                  [handler notifyRequestFinishedSingle:self];
                return;
                
            }
            /* else
             {
             self.subrequestqueuecounter++;
             }*/
            
        }
        
    }
    
    ASIHTTPRequest *aRequest1= [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&pagetoken=%@",[self urlStringSingleRequest],pagetoken]]];
    self.aMyRequest2=aRequest1;
       [self.storeCreatedUser addObject:self.aMyRequest2];
   /* NSMutableDictionary *mtd=[[NSMutableDictionary alloc] init];
    [mtd setObject:key forKey:@"Req_Name"];
    
    [aRequest1 setUserInfo:mtd];
    [mtd release];*/
    
    [aRequest1 setShouldContinueWhenAppEntersBackground:YES];
    [aRequest1 setDelegate:self];
    [aRequest1 setUsername:requestSingleId];
    [aRequest1 setValidatesSecureCertificate:NO];
    [ASIHTTPRequest setShouldThrottleBandwidthForWWAN:YES];
    [aRequest1 setDidFinishSelector:@selector(requestSubFinished:)];
    [aRequest1 setDidFailSelector:@selector(requestSubFailed:)];
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [aRequest1 startAsynchronous];
    /*  [self.subrequestqueue addOperation:aRequest1];
     
     
     if(self.nextpagetokenblankcounter==3)
     {
     [self.subrequestqueue setMaxConcurrentOperationCount:self.subrequestqueuecounter];
     [self.subrequestqueue go];
     }*/
}







-(void)createSubRequest:(NSString *)key :(NSString*)response
{
    NSString* pagetoken=nil;
    if(response)
    {
        SBJsonParser *parser=[[SBJsonParser alloc] init];
        
        id res = [parser objectWithString:response];
        if ([res isKindOfClass:[NSDictionary class]])
        {
            NSDictionary* aDict = (NSDictionary*) res;
            
            //  aDict = [aDict objectForKey:@"response"];
            
            
            
            
            if(![[aDict objectForKey:@"status"] isEqualToString:@"OK"])
            {
                 self.nextpagetokenblankcounter++;
                
                if(self.checkqueuefinished)
                {
                    //self.checkqueuefinished=1;
                    NSLog(@"From pagetoken");
                    NSLog(@"NextPAGECOUNTERBLANK=%i",self.nextpagetokenblankcounter);
                    if(self.nextpagetokenblankcounter==3)
                        [handler notifyRequestFinished:self];
                }
                
                return;
            }
          pagetoken = [aDict objectForKey:@"next_page_token"];
            
            if(!pagetoken)
            {
                 self.nextpagetokenblankcounter++;
                
                
                if(self.checkqueuefinished)
                {
                    //self.checkqueuefinished=1;
                     NSLog(@"From pagetoken");
                     NSLog(@"NextPAGECOUNTERBLANK=%i",self.nextpagetokenblankcounter);
                    if(self.nextpagetokenblankcounter==3)
                        [handler notifyRequestFinished:self];
                }
                
                return;
               
            }
           /* else
            {
                self.subrequestqueuecounter++;
            }*/
            
        }
        
    }
    
    ASIHTTPRequest *aRequest1=[ [ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&pagetoken=%@",[self urlString:key],pagetoken]]];
    self.aMyRequest3=aRequest1;
       [self.storeCreatedUser addObject:self.aMyRequest3];
    
    NSMutableDictionary *mtd=[[NSMutableDictionary alloc] init];
    [mtd setObject:key forKey:@"Req_Name"];
    
    [aRequest1 setUserInfo:mtd];
    
    [aRequest1 setShouldContinueWhenAppEntersBackground:YES];
    [aRequest1 setDelegate:self];
    [aRequest1 setUsername:requestSingleId];
    [aRequest1 setValidatesSecureCertificate:NO];
    [ASIHTTPRequest setShouldThrottleBandwidthForWWAN:YES];
    [aRequest1 setDidFinishSelector:@selector(requestSubFinished:)];
    [aRequest1 setDidFailSelector:@selector(requestSubFailed:)];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [aRequest1 startAsynchronous];
  /*  [self.subrequestqueue addOperation:aRequest1];
    
    
    if(self.nextpagetokenblankcounter==3)
    {
        [self.subrequestqueue setMaxConcurrentOperationCount:self.subrequestqueuecounter];
        [self.subrequestqueue go];
    }*/
}

- (void)requestSubFinished:(ASIHTTPRequest *)request
{
	NSLog(@"Data Received in Connection Manager.... %@ ",[request responseString]);
    
     /*ChangeNSString *key=[request.userInfo objectForKey:[[[request userInfo] allKeys] objectAtIndex:0]];
    
   
    
    
    if([key isEqualToString:FS_CHURCH])
    {
       [ self.nextpageschurch addObject:[request responseString]];
    }
    else if([key isEqualToString:FS_SCHOOL])
    {
         [ self.nextpagesschool addObject:[request responseString]];
    }
    else if([key isEqualToString:FS_RESTURANTS])
    {
         [ self.nextpagesrestaurent addObject:[request responseString]];
    }
    
    [self createSubRequest:key :[request responseString]];
    
       
    	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    */
      [ self.nextpagescommon addObject:[request responseString]];
    [self createSubRequestSingle:[request responseString]];
}

- (void)requestSubFailed:(ASIHTTPRequest *)request
{
    // [self.webServiceResponse addObject:[request error]];
	NSLog(@"Error receiving data : %@ ",[request.error description]);
    //	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        self.nextpagetokenblankcounter++;
    
    /*if(self.checkqueuefinished)
    {
        //self.checkqueuefinished=1;
         NSLog(@"From Request Subfailed");
         NSLog(@"NextPAGECOUNTERBLANK=%i",self.nextpagetokenblankcounter);
        
        if(self.nextpagetokenblankcounter==3)
            [handler notifyRequestFinished:self];
    }*/
      [handler notifyRequestFinishedSingle:self];
}










-(void)queueFinished:(id) queue
{
	
	/*ASINetworkQueue* aQueue = [ASINetworkQueue queue];
     [aQueue setDelegate:self];
     [aQueue setShouldCancelAllRequestsOnFailure:NO];
     [aQueue setMaxConcurrentOperationCount:1];
     [aQueue setQueueDidFinishSelector:@selector(commonqueueFinished:)];
     [self.appDelegate notifyDataLoaded];*/
    
    
  //  [self loadFourSquareDataUpdate:strMainDataS :dicForPh];
 
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    
    if(!self.checkqueuefinished)
    {
        self.checkqueuefinished=1;
        
        NSLog(@"From Queue Finished");
        NSLog(@"NextPAGECOUNTERBLANK=%i",self.nextpagetokenblankcounter);
        
        if(self.nextpagetokenblankcounter==3)
           [handler notifyRequestFinished:self];
    }
}


//-(NSString*)urlString{
//    NSString* s = nil;
//    
//    if ([requestId isEqualToString:EVENTLIST]) {
//        s = EVENTLIST;
//    }else if ([requestId isEqualToString:TAXILIST]) {
//        s = TAXILIST;
//    }else if ([requestId isEqualToString:NEARME]) {
//        s = NEARME;
//    }else if ([requestId isEqualToString:MYACCOUNT]){
//        NSDictionary *facebookUserInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"kSHKFacebookUserInfo"];
//        NSString* fbUserId = [facebookUserInfo objectForKey:@"id"];//@"1124089523";//
//        if (fbUserId) {
//            return [NSString stringWithFormat:@"%@%@", MYACCOUNT_PAGE,fbUserId];
//        }
//    }else if ([requestId isEqualToString:FS_BARS]) {
//        return  [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_secret=DOKP3Y003XDT30W5ZSD1BLI0XH24Q4SKJ2FQLQMOEFI02CTX&client_id=EHTAUJZD5A0CGMQBUDWNDNVROTOBA4XHUME2PMCAYMKPEMQH&ll=%f,%f&v=20120507&categoryId=4bf58dd8d48988d116941735&intent=checkin",appDelegate.locationLat,appDelegate.locationLong];
//    }else if ([requestId isEqualToString:FS_PUBS]) {
//        return  [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_secret=DOKP3Y003XDT30W5ZSD1BLI0XH24Q4SKJ2FQLQMOEFI02CTX&client_id=EHTAUJZD5A0CGMQBUDWNDNVROTOBA4XHUME2PMCAYMKPEMQH&ll=%f,%f&v=20120507&categoryId=4bf58dd8d48988d11b941735&intent=checkin",appDelegate.locationLat,appDelegate.locationLong];
//    }else if ([requestId isEqualToString:FS_RESTURANTS]) {
//        return  [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_secret=DOKP3Y003XDT30W5ZSD1BLI0XH24Q4SKJ2FQLQMOEFI02CTX&client_id=EHTAUJZD5A0CGMQBUDWNDNVROTOBA4XHUME2PMCAYMKPEMQH&ll=%f,%f&v=20120507&categoryId=4bf58dd8d48988d1c4941735&intent=checkin",appDelegate.locationLat,appDelegate.locationLong];
//    }else if ([requestId isEqualToString:FS_TAXI]) {
//        return  [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_secret=DOKP3Y003XDT30W5ZSD1BLI0XH24Q4SKJ2FQLQMOEFI02CTX&client_id=EHTAUJZD5A0CGMQBUDWNDNVROTOBA4XHUME2PMCAYMKPEMQH&ll=%f,%f&v=20120507&categoryId=4bf58dd8d48988d130951735&intent=checkin",appDelegate.locationLat,appDelegate.locationLong];
//    }
//    
//    if (s) {
//        return [NSString stringWithFormat:@"%@%@",BASEURL,s];
//    }
//    return nil;
//}




-(NSString*)urlString:(NSString*)comparestr
{
     NSString* s = nil;
     /*Change Below All Comment*/
//    NSString* s = nil;
//    
//    /*if ([requestId isEqualToString:EVENTLIST]) {
//        s = EVENTLIST;
//    }else if ([requestId isEqualToString:TAXILIST]) {
//        s = TAXILIST;
//    }else if ([requestId isEqualToString:NEARME]) {
//        s = NEARME;
//    }else if ([requestId isEqualToString:MYACCOUNT]){
//        NSDictionary *facebookUserInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"kSHKFacebookUserInfo"];
//        NSString* fbUserId = [facebookUserInfo objectForKey:@"id"];//@"1124089523";//
//        if (fbUserId) {
//            return [NSString stringWithFormat:@"%@%@", MYACCOUNT_PAGE,fbUserId];
//        }
//    }*/
//    
//    
//    
//    
//    
///* els*/ if ([comparestr isEqualToString:FS_SCHOOL])
//        {
//       // return  [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_secret=DOKP3Y003XDT30W5ZSD1BLI0XH24Q4SKJ2FQLQMOEFI02CTX&client_id=EHTAUJZD5A0CGMQBUDWNDNVROTOBA4XHUME2PMCAYMKPEMQH&ll=%f,%f&v=20120507&categoryId=4bf58dd8d48988d116941735&intent=checkin",appDelegate.locationLat,appDelegate.locationLong];
//     //   NSLog(@"Bars-%@",[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%@&types=%@&sensor=true&key=%@", appDelegate.locationLat, appDelegate.locationLong, [NSString stringWithFormat:@"%i", 10000], GP_BARS, GOOGLEPLACESAPIKEY]);
//        return [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%@&types=%@&sensor=true&key=%@", appDelegate.locationLat, appDelegate.locationLong, [NSString stringWithFormat:@"%i", 10000], GP_SCHOOL, GOOGLEPLACESAPIKEY];
//        
//        
//        }
//    else if ([comparestr isEqualToString:FS_CHURCH])
//    {
//       // return  [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_secret=DOKP3Y003XDT30W5ZSD1BLI0XH24Q4SKJ2FQLQMOEFI02CTX&client_id=EHTAUJZD5A0CGMQBUDWNDNVROTOBA4XHUME2PMCAYMKPEMQH&ll=%f,%f&v=20120507&categoryId=4bf58dd8d48988d11b941735&intent=checkin",appDelegate.locationLat,appDelegate.locationLong];
//         return [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%@&types=%@&sensor=true&key=%@", appDelegate.locationLat, appDelegate.locationLong, [NSString stringWithFormat:@"%i", 10000], GP_CHURCH, GOOGLEPLACESAPIKEY];
//    }
//    else if ([comparestr isEqualToString:FS_RESTURANTS])
//    {
//      //  return  [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_secret=DOKP3Y003XDT30W5ZSD1BLI0XH24Q4SKJ2FQLQMOEFI02CTX&client_id=EHTAUJZD5A0CGMQBUDWNDNVROTOBA4XHUME2PMCAYMKPEMQH&ll=%f,%f&v=20120507&categoryId=4bf58dd8d48988d1c4941735&intent=checkin",appDelegate.locationLat,appDelegate.locationLong];
//         return [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%@&types=%@&sensor=true&key=%@", appDelegate.locationLat, appDelegate.locationLong, [NSString stringWithFormat:@"%i", 10000], GP_RESTURANTS, GOOGLEPLACESAPIKEY];
//    }
//    /*else if ([requestId isEqualToString:FS_TAXI])
//    {
//     //   return  [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%@&types=%@&sensor=true&key=%@", appDelegate.locationLat, appDelegate.locationLong, [NSString stringWithFormat:@"%i", 10000], GP_TAXI, GOOGLEPLACESAPIKEY];        //51.641571,-0.4922268
//         return [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%@&types=%@&sensor=true&key=%@", appDelegate.locationLat,appDelegate.locationLong, [NSString stringWithFormat:@"%i", 10000], GP_TAXI, GOOGLEPLACESAPIKEY];
//        
//        
//        
//      // return [NSString stringWithFormat:@"http://ajax.googleapis.com/ajax/services/search/local?v=1.0&q=taxi&sll=%f,%f&sspn=0.125,0.125&rsz=8&start=0&key=%@",appDelegate.locationLat,appDelegate.locationLong,GOOGLEPLACESAPIKEY];
//    }*/
//    
//    /*if (s) {
//        return [NSString stringWithFormat:@"%@%@",BASEURL,s];
//    }*/
//    
//    return s;
    
    return s;
   
}












@end
