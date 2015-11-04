//
//  DataModel.m
//  CalApp
//
//  Created by Satish Kumar on 18/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "HomeVCTableData.h"
#import "DataModel.h"
#import "AppDelegate.h"

#import "ASIHTTPRequest.h"
#import "ConnectionManager.h"



//#import "Request.h"
#import "ASINetworkQueue.h"


@implementation DataModel
@synthesize appDelegate,requestSent,dicForPh,strMainDataS,cManager,arrForLs,pcount,arrForLoadGCS,arrForLoadGPL;

-(id)init{
	if((self = [super init])){
		self.appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
       
        self.requestSent = [NSMutableSet set];
    }
	
	return self;
}

-(BOOL)sendRequestFor:(NSMutableArray*)aRequestPages from:(id)aSource 
{
    if ([requestSent containsObject:aRequestPages])
    {
        return NO;
    }
    
    ConnectionManager* aConn = [[ConnectionManager alloc] init];
        self.cManager=aConn;
	aConn.requestId = aRequestPages;
	aConn.requester = aSource;
    aConn.handler = self;
	[aConn callWebServiceMethod:aRequestPages ofType:NO requestSource:aSource andHandler:self];
	
    [requestSent addObject:aRequestPages];
    NSLog(@"%@ %@",@"Request sent",aRequestPages);
    
	return YES;
}
///////////For Single Request
-(BOOL)sendSingleRequestFor:(NSString *)aRequestPage from:(id)aSource parameter:(NSDictionary*)dic
{
    if ([requestSent containsObject:aRequestPage])
    {
        return NO;
    }
    
    ConnectionManager* aConn = [[ConnectionManager alloc] init];
    self.cManager=aConn;
	aConn.requestSingleId = aRequestPage;
	aConn.requester = aSource;
    aConn.handler = self;
	[aConn callWebServiceMethodSingle:aRequestPage ofType:NO requestSource:aSource andHandler:self parameter:dic];
	
    [requestSent addObject:aRequestPage];
    NSLog(@"%@ %@",@"Request sent",aRequestPage);
    
	return YES;
}
////////////////
//-(BOOL)sendRequestFor:(NSString*)reqId from:(id)aSource{
//    NSString* rName = reqId;//[NSString stringWithFormat:@"%d",reqId];
//    if ([requestSent containsObject:rName]) {
//        return NO;
//    }
//	Request* aRequest = [[Request alloc] init];
//	aRequest.service = nil;
//	aRequest.requestId = rName;
//    [requestSent addObject:rName];
//    [aRequest sendRequest:reqId fromSource:aSource andHandler:self];
//	return YES;
//}
-(void)notifyRequestFinished:(id) aManager
{
     appDelegate.arrItems=nil;
    
    ConnectionManager* m = (ConnectionManager*) aManager;

    NSMutableArray* reqId = m.requestId;
     NSMutableDictionary* responses = m.webServiceResponse;
  
  //  ASIHTTPRequest* aRequest = m.aRequest;
    if ([responses.allKeys count]>0)
    {
       // NSString* d = [aRequest responseString];
        
        
        /*if ([reqId isEqualToString:EVENTLIST])
        {
            [self loadEventData:d];
        }
        else if ([reqId isEqualToString:TAXILIST])
        {
            [self loadTaxiData:d];
        }
        else if ([reqId isEqualToString:NEARME])
        {
            [self loadNearMeData:d];
        }
        else if ([reqId isEqualToString:MYACCOUNT])
        {
            [self loadMyAccountData:d];
        }*/
        /*else*/
        if ( [reqId count]==3)
        {
          
           // [self loadAndReqForPhData:responses];
            [self loadFourSquareDataUpdate:responses :nil];
          
        }
       /* else if ([reqId isEqualToString:FS_TAXI] )
        {
              self.arrForLs=[NSMutableArray array];
             [self loadAndReqForPhData:[aRequest responseString]];
            [self loadAndReqForGoogleLocalST];
          
        }*/
    }
    else
    {
       // [appDelegate showNetworkError:CONNFAILMSG];ChAfter
    }
    
    [requestSent removeObject:reqId];
    
   /* if ([reqId count]==3)
    {
        
    }
    else
    {
    if ([aManager requester])
    {
        ConnectionManager* aR = (ConnectionManager*)aManager;
        [aR.requester notifyRequesterWithData:m.requestId];
    }
    }
    
    [aManager autorelease];*/
}
////////For Single




-(void)notifyRequestFinishedSingle:(id) aManager
{
    appDelegate.arrItems=nil;
    
    
    ConnectionManager* m = (ConnectionManager*) aManager;
    self.cManager=m;
    NSString* reqId = m.requestSingleId;
    
    NSString* d =nil;
    NSError *e=nil;
    
    if([reqId isEqualToString:FINDPLAYGROUND])
    {
    ASIFormDataRequest* aRequest = m.aRequest;//Ch
          d = [aRequest responseString];
        
        e=[aRequest error];
    }
    else
    {
    AFHTTPRequestOperation* aRequest = m.aRequestOperation;
          d = [aRequest responseString];
        
        e=[aRequest error];
    }
    
    if (e == nil)
    {
       
        /*Change  if ([reqId isEqualToString:FS_PORTFOLIO])
        {
          
            [self loadPortFolioData:d];
        }
        else if ([reqId isEqualToString:GETSUBAGENTTYPES])
        {
            
            
            [self loadGETAgentData:d];
           
        }
        else*/
            
        if ([reqId isEqualToString:SIGNUP])
        {
           
            
            if ([cManager requester])
            {
                ConnectionManager* aR = (ConnectionManager*)cManager;
                [aR.requester notifyRequesterWithData:d:aR];
            }
            
        }
        else if ([reqId isEqualToString:VERIFY])
        {
            
            
            if ([cManager requester])
            {
                ConnectionManager* aR = (ConnectionManager*)cManager;
                [aR.requester notifyRequesterWithData:d:aR];
            }
            
        }
        else if ([reqId isEqualToString:LOGIN])
        {
            
            
            if ([cManager requester])
            {
                ConnectionManager* aR = (ConnectionManager*)cManager;
                [aR.requester notifyRequesterWithData:d:aR];
            }
            
        }
         else if ([reqId isEqualToString:LOGOUT])
        {
            
            
            if ([cManager requester])
            {
                ConnectionManager* aR = (ConnectionManager*)cManager;
                  [aR.requester notifyRequesterWithData:d:aR];
              
            }
            
        }
       else if ([reqId isEqualToString:ADDEVENT])
        {
            
            
            if ([cManager requester])
            {
                ConnectionManager* aR = (ConnectionManager*)cManager;
                [aR.requester notifyRequesterWithData:d:aR];
               
            }
            
        }
       else if ([reqId isEqualToString:EDITEVENT])
        {
            
            
            if ([cManager requester])
            {
                ConnectionManager* aR = (ConnectionManager*)cManager;
                [aR.requester notifyRequesterWithData:d:aR];
                
            }
            
        }
       else if ([reqId isEqualToString:COMMENTPOST])
       {
           
           
           if ([cManager requester])
           {
               ConnectionManager* aR = (ConnectionManager*)cManager;
               [aR.requester notifyRequesterWithData:d:aR];
               
           }
           
       }
       else if ([reqId isEqualToString:FINDPLAYGROUND])
       {
           
           NSMutableDictionary* responses = m.webServiceResponse;
           if(responses.allKeys.count>0)
           [self loadFourSquareDataUpdateSingle:responses ];
           
           
           if ([cManager requester])
           {
               ConnectionManager* aR = (ConnectionManager*)cManager;
               [aR.requester notifyRequesterWithData:d:aR];
               
           }
           
       }
          else if ([reqId isEqualToString:TEAM_LISTING])
        {
            
            
            if ([cManager requester])
            {
                ConnectionManager* aR = (ConnectionManager*)cManager;
                [aR.requester notifyRequesterWithData:d:nil];
                
            }
            
        }
          else if ([reqId isEqualToString:UPDATEPOST])
          {
              
              
              if ([cManager requester])
              {
                  ConnectionManager* aR = (ConnectionManager*)cManager;
                  [aR.requester notifyRequesterWithData:d:aR];
                  
              }
              
          }
          else if ([reqId isEqualToString:ADD_TEAM])
          {
              
              
              if ([cManager requester])
              {
                  ConnectionManager* aR = (ConnectionManager*)cManager;
                  [aR.requester notifyRequesterWithData:d:nil];
                  
              }
              
          }
          else if ([reqId isEqualToString:EDIT_TEAM])
          {
              
              
              if ([cManager requester])
              {
                  ConnectionManager* aR = (ConnectionManager*)cManager;
                  [aR.requester notifyRequesterWithData:d:nil];
                  
              }
              
          }
          else if ([reqId isEqualToString:ADD_PLAYER])
          {
              
              
              if ([cManager requester])
              {
                  ConnectionManager* aR = (ConnectionManager*)cManager;
                  [aR.requester notifyRequesterWithData:d:nil];
                  
              }
              
          }
          else if ([reqId isEqualToString:EDIT_PLAYER])
          {
              
              
              if ([cManager requester])
              {
                  ConnectionManager* aR = (ConnectionManager*)cManager;
                  [aR.requester notifyRequesterWithData:d:nil];
                  
              }
              
          }
          else if ([reqId isEqualToString:DELELTE_PLAYER])
          {
              
              
              if ([cManager requester])
              {
                  ConnectionManager* aR = (ConnectionManager*)cManager;
                  [aR.requester notifyRequesterWithData:d:nil];
                  
              }
              
          }
          else if ([reqId isEqualToString:DELETE_TEAM])
          {
              
              
              if ([cManager requester])
              {
                  ConnectionManager* aR = (ConnectionManager*)cManager;
                  [aR.requester notifyRequesterWithData:d:nil];
                  
              }
              
          }
          else if ([reqId isEqualToString:POST])
          {
              
              
              if ([cManager requester])
              {
                  ConnectionManager* aR = (ConnectionManager*)cManager;
                  [aR.requester notifyRequesterWithData:d:aR];
                  
              }
              
          }
          else if ([reqId isEqualToString:PROFILEEDIT])
          {
              
              
              if ([cManager requester])
              {
                  ConnectionManager* aR = (ConnectionManager*)cManager;
                  [aR.requester notifyRequesterWithData:d:nil];
                  
              }
              
          }
          else if ([reqId isEqualToString:EVENTDETAILS])
          {
              
              
              if ([cManager requester])
              {
                  ConnectionManager* aR = (ConnectionManager*)cManager;
                  [aR.requester notifyRequesterWithData:d:aR];
                  
              }
              
          }
          else if ([reqId isEqualToString:DELETEEVENT])
          {
              
              
              if ([cManager requester])
              {
                  ConnectionManager* aR = (ConnectionManager*)cManager;
                  [aR.requester notifyRequesterWithData:d:aR];
                  
              }
              
          }
          else if ([reqId isEqualToString:VIEWEVENTSTATUS])
          {
              
              
              if ([cManager requester])
              {
                  ConnectionManager* aR = (ConnectionManager*)cManager;
                  [aR.requester notifyRequesterWithData:d:aR];
                  
              }
              
          }
          else if ([reqId isEqualToString:SENDADDEVENTPUSH])
          {
              
              
              if ([cManager requester])
              {
                  ConnectionManager* aR = (ConnectionManager*)cManager;
                  [aR.requester notifyRequesterWithData:d:aR];
                  
              }
              
          }
          else if ([reqId isEqualToString:INVITEPLAYERS])
          {
              
              
              if ([cManager requester])
              {
                  ConnectionManager* aR = (ConnectionManager*)cManager;
                  [aR.requester notifyRequesterWithData:d:aR];
                  
              }
              
          }
          else if ([reqId isEqualToString:INVITEFRIENDS])
          {
              
              
              if ([cManager requester])
              {
                  ConnectionManager* aR = (ConnectionManager*)cManager;
                  [aR.requester notifyRequesterWithData:d:aR];
                  
              }
              
          }
          else if ([reqId isEqualToString:INVITEFRIENDSSTATUS])
          {
              
              
              if ([cManager requester])
              {
                  ConnectionManager* aR = (ConnectionManager*)cManager;
                  [aR.requester notifyRequesterWithData:d:aR];
                  
              }
              
          }
          else if ([reqId isEqualToString:TEAMINVITESTATUS])
          {
              
              
              if ([cManager requester])
              {
                  
                  [self loadFourSquareDataTeamPostDetails:d];
                  
                  
                  
                  
                  
                  ConnectionManager* aR = (ConnectionManager*)cManager;
                  [aR.requester notifyRequesterWithData:d:aR];
                  
              }
              
          }
          else if ([reqId isEqualToString:EVENTINVITESTATUS])
          {
              
              
              if ([cManager requester])
              {
                  
                 // [self loadFourSquareDataTeamPostDetails:d];
                  
                  
                  
                  
                  
                  ConnectionManager* aR = (ConnectionManager*)cManager;
                  [aR.requester notifyRequesterWithData:d:aR];
                  
              }
              
          }
          else if ([reqId isEqualToString:FORGOTPASSWORD])
          {
              
              
              if ([cManager requester])
              {
                  
                  // [self loadFourSquareDataTeamPostDetails:d];
                  
                  
                  
                  
                  
                  ConnectionManager* aR = (ConnectionManager*)cManager;
                  [aR.requester notifyRequesterWithData:d:aR];
                  
              }
              
          }

        /*Changeelse if ([reqId isEqualToString:GETCUSTOMERDETAILS])
        {
          */  
            
            /*if ([cManager requester])
            {
                ConnectionManager* aR = (ConnectionManager*)cManager;
                [aR.requester notifyRequesterWithData:d:aR.requestSingleId];
                
            }*/
            /*Change   [self loadGetCustomerData:d];
            
        }*/
        /*
          else if ([reqId isEqualToString:NEARME]) {
            [self loadNearMeData:d];
        }else if ([reqId isEqualToString:MYACCOUNT]) {
            [self loadMyAccountData:d];
        }else if ( [reqId isEqualToString:FS_BARS] || [reqId isEqualToString:FS_RESTURANTS] || [reqId isEqualToString:FS_PUBS]) {
            //  [self loadFourSquareData:[aRequest responseString]];//Replaced
            [self loadAndReqForPhData:[aRequest responseString]];
            
        }
        else if ([reqId isEqualToString:FS_TAXI] )
        {
            self.arrForLs=[NSMutableArray array];
            [self loadAndReqForPhData:[aRequest responseString]];
            [self loadAndReqForGoogleLocalST];
            
        }*/
    }
    else
    {
       
        
        if ([cManager requester])
        {
            ConnectionManager* aR = (ConnectionManager*)cManager;
            [aR.requester notifyRequesterWithData:aR:nil];
        }
         [appDelegate showNetworkError:[e localizedDescription]];
    }
    
    [requestSent removeObject:reqId];
    
   /* if ([reqId isEqualToString:FS_TAXI] || [reqId isEqualToString:FS_BARS] || [reqId isEqualToString:FS_RESTURANTS] || [reqId isEqualToString:FS_PUBS])
    {
        
    }
    else
    {
        if ([aManager requester]) {
            ConnectionManager* aR = (ConnectionManager*)aManager;
            [aR.requester notifyRequesterWithData:m.requestId];
        }
    }
    
    [aManager autorelease];*/
}




-(void)loadFourSquareDataTeamPostDetails:(NSString*)responses
{

///////Added by Debattam
/*self.dataArray=[[NSMutableArray alloc] init];
[dataArray release];*/
    
  
    
    NSString *str=responses;
    
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
                
                
                aDict=[aDict objectForKey:@"response"];
                 aDict=[aDict objectForKey:@"team_details"];
               NSArray   *array=[aDict objectForKey:@"post_details"];
                
                NSMutableArray *marrat=[[NSMutableArray alloc] init];
                appDelegate.arrItems=marrat;
                
                
                
                
                for(NSDictionary *diction in array)
                {
                    HomeVCTableData *dvca=[[HomeVCTableData alloc] init];
                    ImageInfo *imauser=nil;
                    ImageInfo *imaposted=nil;
                    ImageInfo *imapostedsecondary=nil;
                    NSString *likecountstr=nil;
                    NSString *commentcountstr=nil;
                    NSString *comnt=nil;
                    
                    BOOL existuserima=0;
                    BOOL existpostedima=0;
                    BOOL existpostedimasecondary=0;
                  
                    
                    
                    if(![[diction objectForKey:@"ProfileImage"] isEqualToString:@""])
                    {
                        imauser= [[ImageInfo alloc] initWithSourceURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGELINKTHUMB,[diction objectForKey:@"ProfileImage"]]]];
                        existuserima=1;
                    }
                    dvca.imageWidth=0.0;
                    dvca.imageHeight=0.0;
                    if(![[diction objectForKey:@"image"] isEqualToString:@""])
                    {
                        imaposted= [[ImageInfo alloc] initWithSourceURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",POSTIMAGELINK,[diction objectForKey:@"image"]]]];
                        existpostedima=1;
                        
                     
                       /* if([[diction objectForKey:@"image_width"] isMemberOfClass:[NSDecimalNumber class]])
                        {*/
                            dvca.imageWidth=[[diction objectForKey:@"image_width"] floatValue] ;
                            dvca.imageHeight=[[diction objectForKey:@"image_height"] floatValue] ;
                        /*}
                        else  if([[diction objectForKey:@"image_width"] isMemberOfClass:[NSString class]])
                        {
                            if(![[diction objectForKey:@"image_width"] isEqualToString:@""])
                            {
                                dvca.imageWidth=[[diction objectForKey:@"image_width"] floatValue] ;
                                dvca.imageHeight=[[diction objectForKey:@"image_height"] floatValue] ;
                            }
                            
                        }*/

                    }
                    else  if(![[diction objectForKey:@"video_thumb"] isEqualToString:@""])
                    {
                        imaposted=[[ImageInfo alloc] initWithSourceURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",POSTVIDEOIMAGELINK,[diction objectForKey:@"video_thumb"]]]];
                        existpostedima=1;
                        
                        
                        /*if([[diction objectForKey:@"video_thumb_width"] isMemberOfClass:[NSDecimalNumber class]])
                        {*/
                            dvca.imageWidth=[[diction objectForKey:@"video_thumb_width"] floatValue] ;
                            dvca.imageHeight=[[diction objectForKey:@"video_thumb_height"] floatValue] ;
                        /*}
                        else  if([[diction objectForKey:@"video_thumb_width"] isMemberOfClass:[NSString class]])
                        {
                            if(![[diction objectForKey:@"video_thumb_width"] isEqualToString:@""])
                            {
                                dvca.imageWidth=[[diction objectForKey:@"video_thumb_width"] floatValue] ;
                                dvca.imageHeight=[[diction objectForKey:@"video_thumb_height"] floatValue] ;
                            }
                            
                        }*/

                    }
                    
                        //imapostedsecondary= [[ImageInfo alloc] initWithSourceURL:[NSURL URLWithString:@""]];
                        existpostedimasecondary=0;
                        
                        
                        comnt=[diction objectForKey:@"comment_text"];
                      
                        commentcountstr=[NSString stringWithFormat:@"%@",[diction objectForKey:@"number_of_comment"]];//ch
                    
                    NSString *s=[[NSString alloc] initWithFormat:@"%@",[diction objectForKey:@"number_of_likes"] ];
                    likecountstr=s;
                    
                    if([[diction objectForKey:@"Islike"] isEqualToString:@"Y"])
                        dvca.isLike=1;
                    else
                        dvca.isLike=0;
                    dvca.post_id=[diction objectForKey:@"post_id"];
                    dvca.number_of_likes=[likecountstr intValue];
                    NSMutableArray *marray=[[diction objectForKey:@"comment_user_details"] mutableCopy];
                    dvca.commentdetailsarr=marray;
                    
                    dvca.number_of_comment=dvca.commentdetailsarr.count;
                    dvca.adddate=[diction objectForKey:@"adddate"];
                    
                    /*marray=[[diction objectForKey:@"like_user_details"] mutableCopy];
                    dvca.likedetailsarr=marray;
                    [marray release];*/
                    
                                        dvca.secondaryImageInfo=imapostedsecondary;
                    dvca.postedImageInfo=imaposted;
                    dvca.userImageInfo=imauser;
                    dvca.likecountlab=likecountstr;
                    dvca.commentstr= comnt;
                    dvca.commentcountlab=commentcountstr;
                    dvca.isExistUserImageInfo=existuserima;
                    dvca.isExistPostedImageInfo=existpostedima;
                    dvca.isExistSecondaryImageInfo=existpostedimasecondary;
                    [appDelegate.arrItems addObject:dvca];
                }
                
                
                
            }
        }
    }
    
    

}




-(void)loadFourSquareDataUpdateSingle:(NSMutableDictionary*)responses
{
    

    
     NSMutableArray* arrData = [NSMutableArray array];
    
     for (int j=0; j<[[responses allKeys] count]; j++)
     
     
     {
     NSString *response1=[responses objectForKey:[[responses allKeys] objectAtIndex:j]];
     
     NSLog(@"Response1Key=%@",response1);
     
     
     NSMutableArray *arr=[NSMutableArray arrayWithObjects:response1, nil];
     
    
     [arr addObjectsFromArray:cManager.nextpagescommon];
     
     NSLog(@"DataList=%@",arr);
     
   
     
     
     for (NSString *response in arr)
     {
     
     
     
     if (response)
     {
         SBJsonParser *parser=[[SBJsonParser alloc] init];
         
         id res = [parser objectWithString:response];
     if ([res isKindOfClass:[NSDictionary class]])
     {
     NSDictionary* aDict = (NSDictionary*) res;
     
     //  aDict = [aDict objectForKey:@"response"];
     
     if(![[aDict objectForKey:@"status"] isEqualToString:@"OK"])
     {
     //  return;
     }
     else
     {
     NSArray* ar = [aDict objectForKey:@"results"];
     
     NSLog(@"CountAr=%i",[ar count]);
     
     
     
     for (id a in ar)
     {
     aDict = (NSDictionary*)a;
     
     NSString* anId = [aDict objectForKey:@"id"];
     if (anId)
     {
      NSString *data= [self checkNull:[aDict objectForKey:@"name"]];
     
    
     
   
     
     
     
     
     
     
     [arrData addObject:data];
     
     
     }
     }
     }
     }
     }
     }
     
     }
     
    
    /*  if([[cManager requestId] isEqualToString:FS_TAXI])
     {
     self.arrForLoadGPL=arrData;
     }
     else
     {*/
    appDelegate.arrItems = arrData;
     
     /*if ([cManager requester])
     {
     ConnectionManager* aR = (ConnectionManager*)cManager;
     [aR.requester notifyRequesterWithData:cManager.requestId:nil];
     }*/
    /* }*/
    
}




-(void)loadPortFolioData:(NSString *)response
{
    /*Change NSMutableArray* arrData = [NSMutableArray array];
    
    NSLog(@"Load Port Folio Data Response=%@",response);
    
    
    
   
    if (response)
    {
        id res = [response JSONValue];
        if ([res isKindOfClass:[NSDictionary class]])
        {
            NSDictionary* aDict = (NSDictionary*) res;
            aDict=[aDict objectForKey:@"responseData"];
     
     
            if(![[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
            {
     
            }
            else
            {
                NSDictionary* ar1 = [aDict objectForKey:@"response"];
     
                NSArray *ar=[ar1 objectForKey:@"property_details"];
     
               for(id a in ar)
               {
                   NSDictionary *dic=(NSDictionary*)a;
     
                   PSData *data=[[PSData alloc] init];
     
                   data.Id=[self checkNull:[dic objectForKey:@"id"] ];
                   data.contact_id=[self checkNull:[dic objectForKey:@"contact_id"] ];;
     
                   data.ownership_status=[self checkNull:[dic objectForKey:@"ownership_status"] ];;
                   data.building_type=[self checkNull:[dic objectForKey:@"building_type"] ];;
                   data.property_type=[self checkNull:[dic objectForKey:@"property_type"] ];;
                   data.ownership=[self checkNull:[dic objectForKey:@"ownership"] ];;
                   data.location=[self checkNull:[dic objectForKey:@"location"] ];;
                   data.is_primary_address=[self checkNull:[dic objectForKey:@"is_primary_address"] ];;
                   data.address1=[self checkNull:[dic objectForKey:@"address1"] ];;
                   data.address2=[self checkNull:[dic objectForKey:@"address2"] ];;
                   data.city=[self checkNull:[dic objectForKey:@"city"] ];;
                   data.state=[self checkNull:[dic objectForKey:@"state"] ];;
                   data. zip=[self checkNull:[dic objectForKey:@"zip"] ];;
                   data.country=[self checkNull:[dic objectForKey:@"country"] ];;
                   data. purchase_dt=[self checkNull:[dic objectForKey:@"purchase_dt"] ];;
                   data.purchase_price=[self checkNull:[dic objectForKey:@"purchase_price"] ];;
                   
                   data. move_in_dt=[self checkNull:[dic objectForKey:@"move_in_dt"] ];;
                   data.property_taxes=[self checkNull:[dic objectForKey:@"property_taxes"] ];;
                   
                   data. mortgage_amt=[self checkNull:[dic objectForKey:@"mortgage_amt"] ];;
                   
                   
                   data. mortgage_term=[self checkNull:[dic objectForKey:@"mortgage_term"] ];;
                   data. mortgage_rate=[self checkNull:[dic objectForKey:@"mortgage_rate"] ];;
                   data. mortgage_exp_dt=[self checkNull:[dic objectForKey:@"mortgage_exp_dt"] ];;
                   
                   data. sale_dt=[self checkNull:[dic objectForKey:@"sale_dt"] ];;
                   data. sale_price=[self checkNull:[dic objectForKey:@"sale_price"] ];;
                   data. beadrooms=[self checkNull:[dic objectForKey:@"beadrooms"] ];;
                   data. bathrooms=[self checkNull:[dic objectForKey:@"bathrooms"] ];;
                   data. size_in_sqft=[self checkNull:[dic objectForKey:@"size_in_sqft"] ];;
                   
                   data. lot_size=[self checkNull:[dic objectForKey:@"lot_size"] ];;
                   
                   
                   data. storeys=[self checkNull:[dic objectForKey:@"storeys"] ];;
                   data. property_desc=[self checkNull:[dic objectForKey:@"property_desc"] ];;
                   
                   data. is_available=[self checkNull:[dic objectForKey:@"is_available"] ];;
                   
                   data. alarm=[self checkNull:[dic objectForKey:@"alarm"] ];;
                   data. balcony=[self checkNull:[dic objectForKey:@"balcony"] ];;
                   data. cable_satellite_tv=[self checkNull:[dic objectForKey:@"cable_satellite_tv"] ];;
                   data. carpeted_floors=[self checkNull:[dic objectForKey:@"carpeted_floors"] ];;
                   
                   data. deck=[self checkNull:[dic objectForKey:@"deck"] ];
                   data. dinning_room=[self checkNull:[dic objectForKey:@"dinning_room"] ];;
                   data. dishwasher=[self checkNull:[dic objectForKey:@"dishwasher"] ];;
                   data. doorman=[self checkNull:[dic objectForKey:@"doorman"] ];;
                   data. elevator=[self checkNull:[dic objectForKey:@"elevator"] ];;
                   data. firepalce=[self checkNull:[dic objectForKey:@"firepalce"] ];;
                   data. fitness_center=[self checkNull:[dic objectForKey:@"fitness_center"] ];;
                   data. furnished=[self checkNull:[dic objectForKey:@"furnished"] ];;
                   data. garbage_disposal=[self checkNull:[dic objectForKey:@"garbage_disposal"] ];;
                   data. garden_patio=[self checkNull:[dic objectForKey:@"garden_patio"] ];;
                   data. green_building=[self checkNull:[dic objectForKey:@"green_building"] ];;
                   data. hardwood_floors=[self checkNull:[dic objectForKey:@"hardwood_floors"] ];;
                   data. parking_type=[self checkNull:[dic objectForKey:@"parking_type"] ];;
                   data. allow_partnership=[self checkNull:[dic objectForKey:@"allow_partnership"] ];
                   data. registered_dt=[self checkNull:[dic objectForKey:@"registered_dt"] ];
                   
                    NSArray *imgarray=[dic objectForKey:@"property_images"];
                   
                   if([imgarray count]>0)
                   {
                       NSDictionary *aDic=nil;
                       
                       if([[imgarray objectAtIndex:0] isKindOfClass:[NSDictionary class]])
                      aDic=[imgarray objectAtIndex:0];
                       
                       if(aDic)
                       {
                           ImageInfo *im=[[ImageInfo alloc] initWithSourceURL:[NSURL URLWithString:[aDic objectForKey:@"image_url"]]];
                           
                      data. imageInfo=im;
                           [im release];
                       }
                   }
                   else
                   {
                        data. imageInfo=nil; 
                   }
                   
                   data. imageInfos=nil;
                   data. imageInfoslink=nil;
                   
                   
                   
                   
                   
                   [arrData addObject:data];
                   [data release];
                   
               }
                
            }
        }
    }
    
    
    appDelegate.arrItems = arrData;
    
    if ([cManager requester])
    {
        ConnectionManager* aR = (ConnectionManager*)cManager;
        [aR.requester notifyRequesterWithData:cManager.requestSingleId:nil];
    }*/
}


-(void)loadGetCustomerData:(NSString *)response
{
    NSMutableArray* arrData = [NSMutableArray array];
    
    NSLog(@"Load Port CustomerData Response=%@",response);
    
    
    
    
    if (response)
    {
        SBJsonParser *parser=[[SBJsonParser alloc] init];
        
        id res = [parser objectWithString:response];
        if ([res isKindOfClass:[NSDictionary class]])
        {
            NSDictionary* aDict = (NSDictionary*) res;
            aDict=[aDict objectForKey:@"responseData"];
            
            
            if(![[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
            {
                
            }
            else
            {
                NSDictionary* ar1 = [aDict objectForKey:@"response"];
                
                NSArray *ar=[ar1 objectForKey:@"contact_details"];
                
                for(id a in ar)
                {
                    NSDictionary *dic=(NSDictionary*)a;
                    [arrData addObject:dic];
                  
                    
                }
                
            }
        }
    }
    
    
    appDelegate.arrItems = arrData;
    
    if ([cManager requester])
    {
        ConnectionManager* aR = (ConnectionManager*)cManager;
        [aR.requester notifyRequesterWithData:cManager.requestSingleId:nil];
    }
}



-(void)loadGETAgentData:(NSString *)response
{
    NSMutableArray* arrData = [NSMutableArray array];
    
    if (response)
    {
        SBJsonParser *parser=[[SBJsonParser alloc] init];
        
        id res = [parser objectWithString:response];
        if ([res isKindOfClass:[NSDictionary class]])
        {
            NSDictionary* aDict = (NSDictionary*) res;
            aDict=[aDict objectForKey:@"responseData"];
            
            
            if(![[NSString stringWithFormat:@"%@", [aDict objectForKey:@"status"]] isEqualToString:@"1"])
            {
                
            }
            else
            {
                NSDictionary* ar1 = [aDict objectForKey:@"response"];
                
                NSArray *ar=[ar1 objectForKey:@"ower_agents"];
                
                
                for (id a in ar)
                {
                    aDict = (NSDictionary*)a;
                    
                    [arrData addObject:a];
                    
                }
            }
        }
    }
    
    
    appDelegate.arrItems = arrData;
    
    if ([cManager requester])
    {
        ConnectionManager* aR = (ConnectionManager*)cManager;
        [aR.requester notifyRequesterWithData:cManager.requestSingleId:nil];
    }

}



////////

//-(void)notifyRequestFinished:(id) sender{
//	NSAutoreleasePool* aPool = [[NSAutoreleasePool alloc] init];
//	
//	ConnectionManager* aRequest = (ConnectionManager*) sender;
//    NSString* reqId = aRequest.requestId;
//	if([aRequest.webServiceResponse isKindOfClass:[NSError class]]) {
//        NSError* e = (NSError*)aRequest.webServiceResponse;
//        [aRequest.requester showAlertMessage:[e localizedDescription]];
//        aRequest.requester = nil;
//        
//	}else {
//		NSString* d = [aRequest webServiceResponse];
//        if ([reqId isEqualToString:EVENTLIST]) {
//            [self loadEventData:d];
//        }else if ([reqId isEqualToString:TAXILIST]) {
//            [self loadTaxiData:d];
//        }else if ([reqId isEqualToString:NEARME]) {
//            [self loadNearMeData:d];
//        }else if ([reqId isEqualToString:MYACCOUNT]) {
//            [self loadMyAccountData:d];
//        }else if ([reqId isEqualToString:FS_TAXI] || [reqId isEqualToString:FS_BARS] || [reqId isEqualToString:FS_RESTURANTS] || [reqId isEqualToString:FS_PUBS]) {
//            [self loadFourSquareData:[aRequest webServiceResponse]];
//        }
//	}
//    
//	[requestSent removeObject:[NSString stringWithFormat:@"%d",aRequest.requestId]];
//    [aRequest autorelease];
//    [aPool release];
//    
//}


-(NSNumber*)numberFromString:(NSString*) aVal{
	return [NSNumber numberWithInt:[aVal intValue]];
}


 /*Change-(NSManagedObject*)objectOfType:(NSString*) aType forKey:(NSString*) aKey andValue:(NSString*) anId newFlag:(BOOL) canCreate{
    id anObj = nil;
	//NSLog(@"XXXX%@",aType);
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
	
    [request setEntity:[NSEntityDescription entityForName:aType inManagedObjectContext:self.managedObjectContext]];
    [request setPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@==%@",aKey,anId]]];
	NSArray* ar = [managedObjectContext executeFetchRequest:request error:nil];
	if (ar) {
		int count = [ar count];
		if (count == 1) {
			anObj=  [ar objectAtIndex:0];
		}
	}
	
	if (anObj == nil && canCreate) {
		anObj = [NSEntityDescription insertNewObjectForEntityForName:aType inManagedObjectContext:self.managedObjectContext];
	}
	[request release];	
	
    return anObj;
	
}

-(NSManagedObject*)objectOfType:(NSString*) aType forKey:(NSString*) aKey andValue:(NSString*) anId withCondition:(NSString*) aCond newFlag:(BOOL) canCreate{
    id anObj = nil;
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:aType inManagedObjectContext:self.managedObjectContext]];
    [request setPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"(%@ == %@ AND %@)",aKey,anId,aCond]]];// AND %@aCond
	NSArray* ar = [managedObjectContext executeFetchRequest:request error:nil];
	if (ar) {
		int count = [ar count];
		//NSLog(@"Obj of type : %@  : count : %d ",aType,count);
		if (count == 1) {
			anObj=  [ar objectAtIndex:0];
		}
	}
	
	if (anObj == nil && canCreate) {
		anObj = [NSEntityDescription insertNewObjectForEntityForName:aType inManagedObjectContext:self.managedObjectContext];
	}
	[request release];	
	//NSLog(@"%@",[anObj description]);
    return anObj;
	
}*/

-(NSString*)conditionForVersion:(NSString*) vid{
    return [NSString stringWithFormat:@"(vid == %@)",vid];
}
                                                                                                                                  
-(void)loadFourSquareData:(NSString*)response{
    /*Change NSMutableArray* arrData = [NSMutableArray array];
    if (response) {
        id res = [response JSONValue];
        if ([res isKindOfClass:[NSDictionary class]]) {
            NSDictionary* aDict = (NSDictionary*) res;
            
            aDict = [aDict objectForKey:@"response"];
            
            NSArray* ar = [aDict objectForKey:@"venues"];
            for (id a in ar) {
                aDict = (NSDictionary*)a;
                //NSLog(@"%@",[a allKeys]);
                NSString* anId = [aDict objectForKey:@"id"];
                if (anId) {
                    NSDictionary* tDict = nil;
                    FSData* data = [[FSData alloc] init];
                    data.itemId = anId;
                    data.name=[self checkNull:[aDict objectForKey:@"name"]];
                    tDict = [aDict objectForKey:@"contact"];
                    data.phone = [self checkNull:[tDict objectForKey:@"phone"]];
                    //data.phone = [tDict objectForKey:@"phone"];
                    data.formattedPhone = [self checkNull:[tDict objectForKey:@"formattedPhone"]];
                    tDict = [aDict objectForKey:@"location"];
                    data.address = [self checkNull:[tDict objectForKey:@"address"]];
                    //data.address = [tDict objectForKey:@"address"];
                    data.lat = [tDict objectForKey:@"lat"];
                    data.lng = [tDict objectForKey:@"lng"];
                    data.postalCode = [self checkNull:[tDict objectForKey:@"postalCode"]];
                    data.city = [self checkNull:[tDict objectForKey:@"city"]];
                    //data.city = [tDict objectForKey:@"city"];
                    data.state = [self checkNull:[tDict objectForKey:@"state"]];
                    //data.state = [tDict objectForKey:@"state"];
                    //data.country = [tDict objectForKey:@"country"];
                    data.country = [self checkNull:[tDict objectForKey:@"country"]];
                    [arrData addObject:data];
                    [data release];
                }
            }
        }
    }
    appDelegate.arrItems = arrData;
    
    
    if ([cManager requester]) {
        ConnectionManager* aR = (ConnectionManager*)cManager;
        [aR.requester notifyRequesterWithData:cManager.requestId:nil];
    }*/
}

//////////////////////////////////////////For Google local Search

-(void)loadAndReqForGoogleLocalST
{
 
  
  
     /*Change
    
    
    
    
    
ASIHTTPRequest *aRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://ajax.googleapis.com/ajax/services/search/local?v=1.0&q=taxi&sll=%f,%f&sspn=0.125,0.125&rsz=8&start=0&key=%@",appDelegate.locationLat,appDelegate.locationLong,GOOGLEPLACESAPIKEY]]];
    
    NSLog(@"Request Sent For First Google Local Search....%@",[NSString stringWithFormat:@"http://ajax.googleapis.com/ajax/services/search/local?v=1.0&q=taxi&sll=%f,%f&sspn=0.125,0.125&rsz=8&start=0",appDelegate.locationLat,appDelegate.locationLong]);

    
[aRequest setShouldContinueWhenAppEntersBackground:YES];
[aRequest setDelegate:self];
  [aRequest setUsername:@""];
[aRequest setValidatesSecureCertificate:NO];
[ASIHTTPRequest setShouldThrottleBandwidthForWWAN:YES];
[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [aRequest setDidFinishSelector:@selector(reqFinish:)];
    [aRequest setDidFailSelector:@selector(reqFail:)];
    
[aRequest startAsynchronous];
*/

}



- (void)reqFinish:(ASIHTTPRequest *)request{
	NSLog(@"Data Received in Connection Manager.... %@ ",[request responseString]);
  
    NSString *str=[self stringByStrippingHTML:[request responseString]];
    
    
    [arrForLs addObject:[self loadAndReqForPhDataLsParseArray:str]];
    
   
    
    [self loadAndReqForGoogleLocalSearchTaxi:str];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
}

- (void)reqFail:(ASIHTTPRequest *)request{
    
	NSLog(@"Error receiving data : %@ ",[request.error description]);
    //[dicForPh setObject:@"" forKey:[request.userInfo objectForKey:[[[request userInfo] allKeys] objectAtIndex:0]]];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}




-(void)loadAndReqForGoogleLocalSearchTaxi:(NSString*)response
{

   
     /*Change
    
    ASINetworkQueue* aQueue =nil;
    
  
    if (response) {
        id res = [response JSONValue];
        if ([res isKindOfClass:[NSDictionary class]]) {
            NSDictionary* aDict = (NSDictionary*) res;
            
           
            
            
            
            
            if(![(NSDecimalNumber *)[aDict objectForKey:@"responseStatus"] isEqualToNumber:[NSNumber numberWithInt:200]])
            {
                return;
            }
           NSDictionary* resdata = [aDict objectForKey:@"responseData"];
            
            NSDictionary *cursor=[resdata objectForKey:@"cursor" ];
            
            NSArray *pages=[cursor objectForKey:@"pages"];
            
            self.pcount=[pages count];
            
            aQueue = [ASINetworkQueue queue];
            [aQueue setDelegate:self];
            [aQueue setShouldCancelAllRequestsOnFailure:NO];
            [aQueue setMaxConcurrentOperationCount:[pages count]-1];
            [aQueue setQueueDidFinishSelector:@selector(lsQueueFinished:)];
            
         
            
            for (int i=8;i<=([pages count]-1)*8;i+=8)
            {
                             
                   
                   ASIHTTPRequest  *aRequest=  [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://ajax.googleapis.com/ajax/services/search/local?v=1.0&q=taxi&sll=%f,%f&sspn=0.125,0.125&rsz=8&start=%i&key=%@",appDelegate.locationLat,appDelegate.locationLong,i,GOOGLEPLACESAPIKEY]]];
                
                 NSLog(@"Request Sent For Subsequent Google Local Search.... %@ ",[NSString stringWithFormat:@"http://ajax.googleapis.com/ajax/services/search/local?v=1.0&q=taxi&sll=%f,%f&sspn=0.125,0.125&rsz=8&start=%i",appDelegate.locationLat,appDelegate.locationLong,i]);
                
             
                    
                    
                    [aRequest setShouldContinueWhenAppEntersBackground:YES];
                    [aRequest setDelegate:self];
                
                [aRequest setDidFinishSelector:@selector(reqlsFinish:)];
                [aRequest setDidFailSelector:@selector(reqlsFail:)];
                 
                    
                    NSMutableDictionary *mtd=[[NSMutableDictionary alloc] init];
                    [mtd setObject:[NSNumber numberWithInt:i] forKey:@"Start_Name"];
                  
                    [aRequest setUserInfo:mtd];
                    [mtd release];
                    [aRequest setValidatesSecureCertificate:NO];
                    [ASIHTTPRequest setShouldThrottleBandwidthForWWAN:YES];
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
                    
                    
                    [aQueue addOperation:aRequest];
                    
                
            }
            
            
            
        }
    }
    
    
    
    [aQueue go];
    
    */
}



- (void)reqlsFinish:(ASIHTTPRequest *)request{
	NSLog(@"Data Received in Connection Manager.... %@ ",[request responseString]);
    
    
    
    
    // [dicForPh setObject:[self parsePhData:[request responseString]] forKey:[request.userInfo objectForKey:[[[request userInfo] allKeys] objectAtIndex:0]]];
    
    [arrForLs addObject:[self loadAndReqForPhDataLsParseArray:[self  stringByStrippingHTML:[request responseString]]]];
    
 
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
}

- (void)reqlsFail:(ASIHTTPRequest *)request{
    
	NSLog(@"Error receiving data : %@ ",[request.error description]);
    
     [arrForLs addObject:@""];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}








-(void)lsQueueFinished:(id) queue
{
	
    
    [self loadLSDataUpdate:arrForLs];
     
}



-(id)loadAndReqForPhDataLsParseArray:(NSString*)response
{
    NSArray *resultss=nil;
    if (response) {
        SBJsonParser *parser=[[SBJsonParser alloc] init];
        
        id res = [parser objectWithString:response];
        if ([res isKindOfClass:[NSDictionary class]]) {
            NSDictionary* aDict = (NSDictionary*) res;
            
            
            
            
            
            
            if(![(NSDecimalNumber *)[aDict objectForKey:@"responseStatus"] isEqualToNumber:[NSNumber numberWithInt:200]]
               )
            {
                return @"";
            }
            NSDictionary* resdata = [aDict objectForKey:@"responseData"];
            
         
         resultss=[resdata objectForKey:@"results"];
            
        }
    }
    return resultss;
}




-(void)loadLSDataUpdate:(NSMutableArray *)phArr
{
     /*Change
    NSMutableArray *marray=nil; 
    
    if([phArr count]>0)
   marray=[[phArr objectAtIndex:0] mutableCopy];
    
    for(int i=1;i<=pcount-1;i++)
    {
       if(([phArr count]-1)>=i)
        [marray addObjectsFromArray:[phArr objectAtIndex:i]];
    }
       
    NSMutableArray* arrData = [NSMutableArray array];
   
            NSDictionary* aDict = nil;
    NSArray *phnumbers=nil;;
       NSMutableString *addstr=nil;
               NSDictionary* tDict = nil;
            for (id a in marray) {
                
                
                if([a isKindOfClass:[NSDictionary class]])
                {
                aDict = (NSDictionary*)a;
              
               
               
             
                    FSData* data = [[FSData alloc] init];
                    data.itemId = @"";
                    data.name=[self stringByStrippingHTML:[self checkNull:[aDict objectForKey:@"title"]]];
                    
                    
                
               
                phnumbers=[aDict objectForKey:@"phoneNumbers"];
                
                if([phnumbers count]>0)
                     tDict = [phnumbers objectAtIndex:0];
                
                    data.phone = [self checkNull:[tDict objectForKey:@"number"]];
                  
                    
                    
                    
                    data.formattedPhone = [self checkNull:[tDict objectForKey:@"number"]];
                
                phnumbers=[aDict objectForKey:@"addressLines"];
                
                   if([phnumbers count]>0)
                addstr= [[self checkNull:[phnumbers objectAtIndex:0]] mutableCopy];
                
              //  [addstr appendString:[NSString stringWithFormat:@" %@",[self checkNull:[phnumbers objectAtIndex:1]]]];
                
                             
                data.address = addstr;
                    
                [addstr release];
                
                    data.lat = [self checkNull:[aDict objectForKey:@"lat"]];
                    data.lng = [self checkNull:[aDict objectForKey:@"lng"]];
                    data.postalCode = [self checkNull:[aDict objectForKey:@"postalCode"]];
                    data.city = [self checkNull:[aDict objectForKey:@"city"]];
                    //data.city = [tDict objectForKey:@"city"];
                    data.state = [self checkNull:[aDict objectForKey:@"region"]];
                    //data.state = [tDict objectForKey:@"state"];
                    //data.country = [tDict objectForKey:@"country"];
                    data.country = [self checkNull:[aDict objectForKey:@"country"]];
                    [arrData addObject:data];
                    [data release];
                    
          
                
                
            }
        
    }
    [marray release];
    
    self.arrForLoadGCS=arrData;*/
    
   /* appDelegate.arrItems = arrData;
    
    if ([cManager requester]) {
        ConnectionManager* aR = (ConnectionManager*)cManager;
        [aR.requester notifyRequesterWithData:cManager.requestId];
    }*/
     /*Change
    [self compareAndLoad];*/
    
}





-(void) compareAndLoad
{
   // self.arrForLoadGCS=[NSArray array];
    
    if([self.arrForLoadGCS count] >[self.arrForLoadGPL count])
    {
    appDelegate.arrItems = [self.arrForLoadGCS mutableCopy];
    
    }
    else
    {
        appDelegate.arrItems =[self.arrForLoadGPL mutableCopy];
    }
    
    if ([cManager requester]) {
        ConnectionManager* aR = (ConnectionManager*)cManager;
        [aR.requester notifyRequesterWithData:cManager.requestId:nil];
    }


}
//////////////////////////////////////////Finish Google Local Search

-(NSString *) stringByStrippingHTML:(NSString *)str {
    NSRange r;
    NSString *s = str;
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    
    while ((r = [s rangeOfString:@"amp;" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    
    while ((r = [s rangeOfString:@"#39;" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    
    return s; 
}
/////////////////////////////////////////////////////////////////////////////////////////////////
-(void)loadAndReqForPhData:(NSMutableDictionary*)responses
{
     /*Change
    self.strMainDataS=responses;
    int noofreq=0;
    ASINetworkQueue* aQueue =nil;
    aQueue = [ASINetworkQueue queue];
    [aQueue setDelegate:self];
    [aQueue setShouldCancelAllRequestsOnFailure:NO];
  //  [aQueue setMaxConcurrentOperationCount:[ar count]];
    [aQueue setQueueDidFinishSelector:@selector(phQueueFinished:)];
  //  NSMutableArray* arrData = [NSMutableArray array];
    for (int j=0; j<[[responses allKeys] count]; j++)
        
     
    {
        NSString *response=[responses objectForKey:[[responses allKeys] objectAtIndex:j]];
        
        
        if(response)
        {
        id res = [response JSONValue];
        if ([res isKindOfClass:[NSDictionary class]])
        {
            NSDictionary* aDict = (NSDictionary*) res;
            
            //  aDict = [aDict objectForKey:@"response"];
            
           
            
            
            if(![[aDict objectForKey:@"status"] isEqualToString:@"OK"])
            {
                return;
            }
             NSArray* ar = [aDict objectForKey:@"results"];
            
            NSLog(@"Results=%i",[ar count]);
            NSLog(@"Response=%@",[[responses allKeys] objectAtIndex:j]);
            
            NSMutableDictionary *mt=[[NSMutableDictionary alloc] init];
            self.dicForPh=mt;
            [mt release];
            
            for (id a in ar) {
                aDict = (NSDictionary*)a;
                //NSLog(@"%@",[a allKeys]);
                NSString *anId = [aDict objectForKey:@"id"];
             
                
                if (anId)
                {
                    noofreq++;
                  NSString *referenceId=  [self checkNull:[aDict objectForKey:@"reference"]];
                     NSString *anName=  [self checkNull:[aDict objectForKey:@"name"]];
                    NSString *srs=[ NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?reference=%@&sensor=true&key=%@",referenceId,GOOGLEPLACESAPIKEY];
                        ASIHTTPRequest  *aRequest=  [ASIHTTPRequest requestWithURL:[NSURL URLWithString:srs]];
                
                    
                    [aRequest setShouldContinueWhenAppEntersBackground:YES];
                    [aRequest setDelegate:self];
                    
                    NSLog(@"Reference ID %@",referenceId);
                      NSLog(@"Title %@",anName);
                     NSLog(@"Request String---- %@",srs);
                    
                    NSMutableDictionary *mtd=[[NSMutableDictionary alloc] init];
                    [mtd setObject:anName forKey:@"Place_Name"];
                //    [aRequest setUsername:anName];
                    [aRequest setUserInfo:mtd];
                    [mtd release];
                    [aRequest setValidatesSecureCertificate:NO];
                    [ASIHTTPRequest setShouldThrottleBandwidthForWWAN:YES];
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
                    
                 
                    [aQueue addOperation:aRequest];
                    
                }
            }


    
        }
    }
    
    }
    
    
    NSLog(@"No Of request=%i",noofreq);
    
   [aQueue setMaxConcurrentOperationCount:noofreq];
        [aQueue go];
    */

}

-(void)phQueueFinished:(id) queue
{
	
	/*ASINetworkQueue* aQueue = [ASINetworkQueue queue];
	[aQueue setDelegate:self];
	[aQueue setShouldCancelAllRequestsOnFailure:NO];
	[aQueue setMaxConcurrentOperationCount:1];
	[aQueue setQueueDidFinishSelector:@selector(commonqueueFinished:)];
    [self.appDelegate notifyDataLoaded];*/
    
    
    [self loadFourSquareDataUpdate:strMainDataS :dicForPh];
    
}


- (void)requestFinished:(ASIHTTPRequest *)request
{
	NSLog(@"Data Received in Connection Manager.... %@ ",[request responseString]);
    NSLog(@"PhName-%@------Ob-%@",[request.userInfo objectForKey:[[[request userInfo] allKeys] objectAtIndex:0]],[self parsePhData:[request responseString]]);
    
    
    
    [dicForPh setObject:[self parsePhData:[request responseString]] forKey:[request.userInfo objectForKey:[[[request userInfo] allKeys] objectAtIndex:0]]];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
 
	NSLog(@"Error receiving data : %@ ",[request.error description]);
	 [dicForPh setObject:@"" forKey:[request.userInfo objectForKey:[[[request userInfo] allKeys] objectAtIndex:0]]];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


-(NSString *)parsePhData:(NSString*)response
{
    NSString *strph=nil;
    if (response) {
        SBJsonParser *parser=[[SBJsonParser alloc] init];
        
        id res = [parser objectWithString:response];
        if ([res isKindOfClass:[NSDictionary class]]) {
            NSDictionary* aDict = (NSDictionary*) res;
            
            //  aDict = [aDict objectForKey:@"response"];
            if(![[aDict objectForKey:@"status"] isEqualToString:@"OK"])
            {
                return @"";
            }
            NSDictionary* ar =(NSDictionary*)[aDict objectForKey:@"result"];
          //  for (id a in ar) {
            //    aDict = (NSDictionary*)a;
              
            
            
                NSString* anId = [ar objectForKey:@"id"];
                if (anId)
                {
                  
                 strph=  [self checkNull:[ar objectForKey:@"international_phone_number"]];
                   // NSLog(@"PhNameParsePh====%@",strph);
                }
           // }
        }
    }
    return strph;
}
//////////////////////////////
/*-(void)loadFourSquareDataUpdate:(NSMutableDictionary*)responses:(NSMutableDictionary *)phArr
{
    
    NSLog(@"phArr----%@",phArr);
    
    NSMutableArray* arrData = [NSMutableArray array];
    
    for (int j=0; j<[[responses allKeys] count]; j++)
        
        
    {
        NSString *response=[responses objectForKey:[[responses allKeys] objectAtIndex:j]];
    
    
    
    
    
    if (response)
    {
        id res = [response JSONValue];
        if ([res isKindOfClass:[NSDictionary class]]) {
            NSDictionary* aDict = (NSDictionary*) res;
            
            //  aDict = [aDict objectForKey:@"response"];
            
            if(![[aDict objectForKey:@"status"] isEqualToString:@"OK"])
            {
                return;
            }
            NSArray* ar = [aDict objectForKey:@"results"];
            for (id a in ar) {
                aDict = (NSDictionary*)a;
                //NSLog(@"%@",[a allKeys]);
                NSString* anId = [aDict objectForKey:@"id"];
                if (anId)
                {
                    NSDictionary* tDict = nil;
                    FSData* data = [[FSData alloc] init];
                    data.itemId = anId;
                    data.name=[self checkNull:[aDict objectForKey:@"name"]];
                    
                    NSArray *types=[aDict objectForKey:@"types"];
                    
                    for(int k=0;k<[types count];k++)
                    {
                        
                        NSLog(@"%@",[types objectAtIndex:k]);
                        
                        
                        if([[types objectAtIndex:k] isEqualToString:GP_CHURCH])
                        {
                            data.type= [self checkNull:[types objectAtIndex:k]];
                            break;
                        }
                       else if([[types objectAtIndex:k] isEqualToString:GP_RESTURANTS])
                        {
                            data.type= [self checkNull:[types objectAtIndex:k]];
                            break;
                        }
                       else if([[types objectAtIndex:k] isEqualToString:GP_SCHOOL])
                        {
                            data.type= [self checkNull:[types objectAtIndex:k]];
                            break;
                        }
                    }
                    
                    
                    
                    
                    
                    tDict = [aDict objectForKey:@"contact"];
                    
                   // data.phone = [self checkNull:[tDict objectForKey:@"phone"]];
                    data.phone = [self checkNull:[phArr objectForKey:data.name]];
                    NSLog(@"PhNameUpdate-%@====Name-----%@",data.phone,data.name);
                    
                    
                    
                    data.formattedPhone = [self checkNull:[tDict objectForKey:@"formattedPhone"]];
                    tDict = [aDict objectForKey:@"geometry"];
                    tDict=[tDict objectForKey:@"location"];
                    data.address = [self checkNull:[aDict objectForKey:@"vicinity"]];
                    
                    //data.address = [tDict objectForKey:@"address"];
                    data.lat = [tDict objectForKey:@"lat"];
                    data.lng = [tDict objectForKey:@"lng"];
                    data.postalCode = [self checkNull:[tDict objectForKey:@"postalCode"]];
                    data.city = [self checkNull:[tDict objectForKey:@"city"]];
                    //data.city = [tDict objectForKey:@"city"];
                    data.state = [self checkNull:[tDict objectForKey:@"state"]];
                    //data.state = [tDict objectForKey:@"state"];
                    //data.country = [tDict objectForKey:@"country"];
                    data.country = [self checkNull:[tDict objectForKey:@"country"]];
                    [arrData addObject:data];
                    [data release];
                    
                }
            }
        }
    }
    
        
    }
    
    
 
    appDelegate.arrItems = arrData;
    
    if ([cManager requester])
    {
        ConnectionManager* aR = (ConnectionManager*)cManager;
        [aR.requester notifyRequesterWithData:cManager.requestId];
    }
  
}*/
/////////////////////////
-(void)loadFourSquareDataUpdate:(NSMutableDictionary*)responses :(NSMutableDictionary *)phArr
{
    
    /*Change
    
    NSMutableArray* arrData = [NSMutableArray array];
    
    for (int j=0; j<[[responses allKeys] count]; j++)
        
        
    {
        NSString *response1=[responses objectForKey:[[responses allKeys] objectAtIndex:j]];
        
         NSLog(@"Response1Key=%@",response1);
        
        
        NSMutableArray *arr=[NSMutableArray arrayWithObjects:response1, nil];
        
        if([[[responses allKeys] objectAtIndex:j] isEqualToString:FS_RESTURANTS])
        {
            [arr addObjectsFromArray:cManager.nextpagesrestaurent];
            
             NSLog(@"Restaurent=%@",cManager.nextpagesrestaurent);
            
        }
        else if([[[responses allKeys] objectAtIndex:j] isEqualToString:FS_CHURCH])
        {
             [arr addObjectsFromArray:cManager.nextpageschurch];
            
             NSLog(@"Church=%@",cManager.nextpageschurch);
        }
        else if([[[responses allKeys] objectAtIndex:j] isEqualToString:FS_SCHOOL])
        {
             [arr addObjectsFromArray:cManager.nextpagesschool];
            
             NSLog(@"School=%@",cManager.nextpagesschool);
        }
        
        
         for (NSString *response in arr)
         {
             
         
        
        if (response)
        {
            id res = [response JSONValue];
            if ([res isKindOfClass:[NSDictionary class]])
            {
                NSDictionary* aDict = (NSDictionary*) res;
                
                //  aDict = [aDict objectForKey:@"response"];
                
                if(![[aDict objectForKey:@"status"] isEqualToString:@"OK"])
                {
                  //  return;
                }
                else
                {
                NSArray* ar = [aDict objectForKey:@"results"];
                
                NSLog(@"CountAr=%i",[ar count]);
                
                
                
                for (id a in ar) {
                    aDict = (NSDictionary*)a;
                    //NSLog(@"%@",[a allKeys]);
                    NSString* anId = [aDict objectForKey:@"id"];
                    if (anId)
                    {
                        NSDictionary* tDict = nil;
                        FSData* data = [[FSData alloc] init];
                        data.itemId = anId;
                        data.name=[self checkNull:[aDict objectForKey:@"name"]];
                        
                        ImageInfo *imageinfo=[[ImageInfo alloc] initWithSourceURL:[NSURL URLWithString:[self checkNull:[aDict objectForKey:@"icon"]]]];
                        data.imageInfo=imageinfo;
                        [imageinfo release];
                        
                        NSArray *types=[aDict objectForKey:@"types"];
                        
                        for(int k=0;k<[types count];k++)
                        {
                            
                            NSLog(@"%@",[types objectAtIndex:k]);
                            
                            
                            if([[types objectAtIndex:k] isEqualToString:GP_CHURCH])
                            {
                                data.type= [self checkNull:[types objectAtIndex:k]];
                                break;
                            }
                            else if([[types objectAtIndex:k] isEqualToString:GP_RESTURANTS])
                            {
                                data.type= [self checkNull:[types objectAtIndex:k]];
                                break;
                            }
                            else if([[types objectAtIndex:k] isEqualToString:GP_SCHOOL])
                            {
                                data.type= [self checkNull:[types objectAtIndex:k]];
                                break;
                            }
                        }
                        
                        
                        
                        
                        
                        tDict = [aDict objectForKey:@"contact"];
                        
                        NSString *referenceId=  [self checkNull:[aDict objectForKey:@"reference"]];
                      
                        NSString *srs=[ NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?reference=%@&sensor=true&key=%@",referenceId,GOOGLEPLACESAPIKEY];
                     //   data.phone = [self checkNull:[phArr objectForKey:data.name]];
                      
                          data.phone = srs;
                        
                        
                        data.formattedPhone = [self checkNull:[tDict objectForKey:@"formattedPhone"]];
                        tDict = [aDict objectForKey:@"geometry"];
                        tDict=[tDict objectForKey:@"location"];
                        data.address = [self checkNull:[aDict objectForKey:@"vicinity"]];
                        
                        //data.address = [tDict objectForKey:@"address"];
                        data.lat = [tDict objectForKey:@"lat"];
                        data.lng = [tDict objectForKey:@"lng"];
                        data.postalCode = [self checkNull:[tDict objectForKey:@"postalCode"]];
                        data.city = [self checkNull:[tDict objectForKey:@"city"]];
                        //data.city = [tDict objectForKey:@"city"];
                        data.state = [self checkNull:[tDict objectForKey:@"state"]];
                        //data.state = [tDict objectForKey:@"state"];
                        //data.country = [tDict objectForKey:@"country"];
                        data.country = [self checkNull:[tDict objectForKey:@"country"]];
                        [arrData addObject:data];
                        [data release];
                        
                    }
                }
            }
            }
        }
         }
        
    }
    */
    
    /*  if([[cManager requestId] isEqualToString:FS_TAXI])
     {
     self.arrForLoadGPL=arrData;
     }
     else
     {*/
   /*Change  appDelegate.arrItems = arrData;
    
    if ([cManager requester])
    {
        ConnectionManager* aR = (ConnectionManager*)cManager;
        [aR.requester notifyRequesterWithData:cManager.requestId:nil];
    }*/
    /* }*/
    
}




/////////////////////////////////////////////////////////////////////////////////////////////////
//-(void)loadFourSquareData:(NSString*)response{
//    NSMutableArray* arrData = [NSMutableArray array];
//    if (response) {
//        id res = [response JSONValue];
//        if ([res isKindOfClass:[NSDictionary class]]) {
//            NSDictionary* aDict = (NSDictionary*) res;
//            
//          //  aDict = [aDict objectForKey:@"response"];
//            
//            NSArray* ar = [aDict objectForKey:@"results"];
//            for (id a in ar) {
//                aDict = (NSDictionary*)a;
//                //NSLog(@"%@",[a allKeys]);
//                NSString* anId = [aDict objectForKey:@"id"];
//                if (anId)
//                {
//                    NSDictionary* tDict = nil;
//                    FSData* data = [[FSData alloc] init];
//                    data.itemId = anId;
//                    data.name=[self checkNull:[aDict objectForKey:@"name"]];
//                    
//                    
//                    tDict = [aDict objectForKey:@"contact"];
//                    data.phone = [self checkNull:[tDict objectForKey:@"phone"]];
//                    //data.phone = [tDict objectForKey:@"phone"];
//                    data.formattedPhone = [self checkNull:[tDict objectForKey:@"formattedPhone"]];
//                    tDict = [aDict objectForKey:@"geometry"];
//                    tDict=[tDict objectForKey:@"location"];
//                    data.address = [self checkNull:[aDict objectForKey:@"vicinity"]];
//                    
//                    //data.address = [tDict objectForKey:@"address"];
//                    data.lat = [tDict objectForKey:@"lat"];
//                    data.lng = [tDict objectForKey:@"lng"];
//                    data.postalCode = [self checkNull:[tDict objectForKey:@"postalCode"]];
//                    data.city = [self checkNull:[tDict objectForKey:@"city"]];
//                    //data.city = [tDict objectForKey:@"city"];
//                    data.state = [self checkNull:[tDict objectForKey:@"state"]];
//                    //data.state = [tDict objectForKey:@"state"];
//                    //data.country = [tDict objectForKey:@"country"];
//                    data.country = [self checkNull:[tDict objectForKey:@"country"]];
//                    [arrData addObject:data];
//                    [data release];
//                    
//                }
//            }
//        }
//    }
//    appDelegate.arrItems = arrData;
//}




-(NSString*)checkNull:(id) obj
{
    if (obj == nil || obj == [NSNull null])
    {
        return @"";
    }
    
    return obj;
}
    
    
    
    
/*-(void)loadEventData:(NSString*)data{
    if (data) {
		//TBXML * tbxml = [[TBXML tbxmlWithXMLData:data] retain];
        TBXML * tbxml = [[TBXML tbxmlWithXMLString:data] retain];
		TBXMLElement * rootXMLElement = tbxml.rootXMLElement;
		TBXMLElement *resultNodes = nil;
		
		resultNodes = [TBXML childElementNamed:@"result" parentElement:rootXMLElement];
		
		if (resultNodes){
			do {
				NSString* val = @"";
                NSString* nid = nil;
                NSString* vid = nil;
                EventItem* anEvent = nil;
                TBXMLElement* anItem = [TBXML childElementNamed:@"nid" parentElement:resultNodes];
                if (anItem) {
                    val = [TBXML textForElement:anItem];
                    val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    if (val && val.length > 0) {
                        nid = val;
                        
                        anItem = [TBXML childElementNamed:@"vid" parentElement:resultNodes];
                        
                        if (anItem) {
                            val = [TBXML textForElement:anItem];
                            val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                             if (val && val.length > 0) {
                                 vid = val;
                             }
                        }
                        
                    }
                    
                }
                
                if (nid && vid) {
                    anEvent = (EventItem*)[self objectOfType:@"EventItem" forKey:@"nid" andValue:nid withCondition:[self conditionForVersion:vid] newFlag:YES];
                    anEvent.nid = [self numberFromString:nid];
                    anEvent.vid = [self numberFromString:vid];
                }else{
                    anEvent = nil;
                }
                
                if (anEvent) {
                    anItem = [TBXML childElementNamed:@"title" parentElement:resultNodes]; 
                    if (anItem) {
                        val = [TBXML textForElement:anItem];
                        val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        [anEvent setTitle:val];
                    }  
                    
                    
                    anItem = [TBXML childElementNamed:@"from_date" parentElement:resultNodes]; 
                    if (anItem) {
                        val = [TBXML textForElement:anItem];
                        val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        [anEvent setFromDate:val];
                        NSDate* d = [appDelegate.dateFormat dateFromString:val];
                        [anEvent setEventStartDate:d];
                    }
                    
                    anItem = [TBXML childElementNamed:@"to_date" parentElement:resultNodes]; 
                    if (anItem) {
                        val = [TBXML textForElement:anItem];
                        val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        [anEvent setToDate:val];
                        NSDate* d = [appDelegate.dateFormat dateFromString:val];
                        [anEvent setEventEndDate:d];
                    }
                    
                    anItem = [TBXML childElementNamed:@"start_time" parentElement:resultNodes]; 
                    if (anItem) {
                        val = [TBXML textForElement:anItem];
                        val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        [anEvent setStartTime:val];
                    }
                    
                    anItem = [TBXML childElementNamed:@"end_time" parentElement:resultNodes]; 
                    if (anItem) {
                        val = [TBXML textForElement:anItem];
                        val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        [anEvent setEndTime:val];
                    }
                    
                    anItem = [TBXML childElementNamed:@"latitude" parentElement:resultNodes]; 
                    if (anItem) {
                        val = [TBXML textForElement:anItem];
                        val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        [anEvent setLatitude:val];
                    }
                    
                    anItem = [TBXML childElementNamed:@"longitude" parentElement:resultNodes]; 
                    if (anItem) {
                        val = [TBXML textForElement:anItem];
                        val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        [anEvent setLongitude:val];
                    }
                    
                    anItem = [TBXML childElementNamed:@"location" parentElement:resultNodes]; 
                    if (anItem) {
                        val = [TBXML textForElement:anItem];
                        val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        [anEvent setLocation:val];
                    }
                    
                    
                    anItem = [TBXML childElementNamed:@"available_tickets" parentElement:resultNodes]; 
                    if (anItem) {
                        val = [TBXML textForElement:anItem];
                        val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        [anEvent setAvailableTickets:val];
                    }
                    
                    anItem = [TBXML childElementNamed:@"image" parentElement:resultNodes]; 
                    if (anItem) {
                        val = [TBXML textForElement:anItem];
                        val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        [anEvent setImageUrl:val];
                    }
                    
                    anItem = [TBXML childElementNamed:@"description" parentElement:resultNodes]; 
                    if (anItem) {
                        val = [TBXML textForElement:anItem];
                        //val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        [anEvent setDetails:[self formattedHtmlString:val]];
                    }
                    
                    anItem = [TBXML childElementNamed:@"price" parentElement:resultNodes]; 
                    if (anItem) {
                        val = [TBXML textForElement:anItem];
                        val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        [anEvent setAmountPaid:val];
                    }
                    
                }
                
                
                
            }while ((resultNodes = resultNodes->nextSibling));
		}
		[tbxml release];
        
        
	}
    
    [self.managedObjectContext save:nil];
}
*/

/*-(void)loadMyAccountData:(NSString*)data{
    if (data) {
		TBXML * tbxml = [[TBXML tbxmlWithXMLString:data] retain];
		TBXMLElement * rootXMLElement = tbxml.rootXMLElement;
		TBXMLElement *resultNodes = nil;
		
		resultNodes = [TBXML childElementNamed:@"events" parentElement:rootXMLElement];
		
		if (resultNodes){
			do {
				NSString* val = @"";
                NSString* nid = nil;
                NSString* vid = nil;
                EventItem* anEvent = nil;
                TBXMLElement* anItem = [TBXML childElementNamed:@"nid" parentElement:resultNodes];
                if (anItem) {
                    val = [TBXML textForElement:anItem];
                    val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    if (val && val.length > 0) {
                        nid = val;
                        
                        anItem = [TBXML childElementNamed:@"vid" parentElement:resultNodes];
                        
                        if (anItem) {
                            val = [TBXML textForElement:anItem];
                            val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                            if (val && val.length > 0) {
                                vid = val;
                            }
                        }
                        
                    }
                    
                }
                
                if (nid && vid) {
                    anEvent = (EventItem*)[self objectOfType:@"EventItem" forKey:@"nid" andValue:nid withCondition:[self conditionForVersion:vid] newFlag:NO];
                }else{
                    anEvent = nil;
                }
                
                if (anEvent) {
                    anItem = [TBXML childElementNamed:@"ticket_no" parentElement:resultNodes]; 
                    if (anItem) {
                        val = [TBXML textForElement:anItem];
                        val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        [anEvent setTicketCount:val];
                    }
                    
                    anItem = [TBXML childElementNamed:@"total_price" parentElement:resultNodes]; 
                    if (anItem) {
                        val = [TBXML textForElement:anItem];
                        val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        [anEvent setAmountPaid:val];
                    }
                    
                }
                
                
                
            }while ((resultNodes = resultNodes->nextSibling));
		}
		[tbxml release];
        
        
	}
    
    [self.managedObjectContext save:nil];
}
*/

/*-(void) loadTaxiData:(NSString*)data{
    if (data) {
		TBXML * tbxml = [[TBXML tbxmlWithXMLString:data] retain];
		TBXMLElement * rootXMLElement = tbxml.rootXMLElement;
		TBXMLElement *resultNodes = nil;
		
		resultNodes = [TBXML childElementNamed:@"result" parentElement:rootXMLElement];
		
		if (resultNodes){
			do {
				NSString* val = @"";
                NSString* nid = nil;
                NSString* vid = nil;
                TaxiItem* anEvent = nil;
                TBXMLElement* anItem = [TBXML childElementNamed:@"nid" parentElement:resultNodes];
                if (anItem) {
                    val = [TBXML textForElement:anItem];
                    val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    if (val && val.length > 0) {
                        nid = val;
                        
                        anItem = [TBXML childElementNamed:@"vid" parentElement:resultNodes];
                        
                        if (anItem) {
                            val = [TBXML textForElement:anItem];
                            val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                            if (val && val.length > 0) {
                                vid = val;
                            }
                        }
                        
                    }
                    
                }
                
                if (nid && vid) {
                    anEvent = (TaxiItem*)[self objectOfType:@"TaxiItem" forKey:@"nid" andValue:nid withCondition:[self conditionForVersion:vid] newFlag:YES];
                    anEvent.nid = [self numberFromString:nid];
                    anEvent.vid = [self numberFromString:vid];
                }else{
                    anEvent = nil;
                }
                
                if (anEvent) {
                    anItem = [TBXML childElementNamed:@"title" parentElement:resultNodes]; 
                    if (anItem) {
                        val = [TBXML textForElement:anItem];
                        val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        [anEvent setTitle:val];
                    }  
                    
                    
                    anItem = [TBXML childElementNamed:@"address1" parentElement:resultNodes]; 
                    if (anItem) {
                        val = [TBXML textForElement:anItem];
                        val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        [anEvent setAddress1:val];
                    }
                    
                    anItem = [TBXML childElementNamed:@"address2" parentElement:resultNodes]; 
                    if (anItem) {
                        val = [TBXML textForElement:anItem];
                        val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        [anEvent setAddress2:val];
                    }
                    
                    anItem = [TBXML childElementNamed:@"address3" parentElement:resultNodes]; 
                    if (anItem) {
                        val = [TBXML textForElement:anItem];
                        val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        [anEvent setAddress3:val];
                    }
                    
                    anItem = [TBXML childElementNamed:@"phone" parentElement:resultNodes]; 
                    if (anItem) {
                        val = [TBXML textForElement:anItem];
                        val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        [anEvent setPhone:val];
                    }
                    
                    anItem = [TBXML childElementNamed:@"description" parentElement:resultNodes]; 
                    if (anItem) {
                        val = [TBXML textForElement:anItem];
                        val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        [anEvent setDetails:[self formattedHtmlString:val]];
                    }
                    
                }
              
            }while ((resultNodes = resultNodes->nextSibling));
		}
		[tbxml release];
        
        
	}
    
    [self.managedObjectContext save:nil];
}
 
 */
    
    /*
-(void) loadNearMeData:(NSString*)data{
    if (data) {
        NSMutableArray* ar = [NSMutableArray array];
        //[ar addObject:@"All"];
		TBXML * tbxml = [[TBXML tbxmlWithXMLString:data] retain];
		TBXMLElement * rootXMLElement = tbxml.rootXMLElement;
		TBXMLElement *resultNodes = nil;
		
		resultNodes = [TBXML childElementNamed:@"result" parentElement:rootXMLElement];
		
		if (resultNodes){
			do {
				NSString* val = @"";
                NSString* nid = nil;
                NSString* vid = nil;
                NearMe* anEvent = nil;
                TBXMLElement* anItem = [TBXML childElementNamed:@"nid" parentElement:resultNodes];
                if (anItem) {
                    val = [TBXML textForElement:anItem];
                    val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    if (val && val.length > 0) {
                        nid = val;
                        
                        anItem = [TBXML childElementNamed:@"vid" parentElement:resultNodes];
                        
                        if (anItem) {
                            val = [TBXML textForElement:anItem];
                            val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                            if (val && val.length > 0) {
                                vid = val;
                            }
                        }
                        
                    }
                    
                }
                
                if (nid && vid) {
                    anEvent = (NearMe*)[self objectOfType:@"NearMe" forKey:@"nid" andValue:nid withCondition:[self conditionForVersion:vid] newFlag:YES];
                    anEvent.nid = [self numberFromString:nid];
                    anEvent.vid = [self numberFromString:vid];
                }else{
                    anEvent = nil;
                }
                
                if (anEvent) {
                    anItem = [TBXML childElementNamed:@"title" parentElement:resultNodes]; 
                    if (anItem) {
                        val = [TBXML textForElement:anItem];
                        val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        [anEvent setTitle:val];
                    }  
                    
                    
                    anItem = [TBXML childElementNamed:@"category" parentElement:resultNodes]; 
                    if (anItem) {
                        val = [TBXML textForElement:anItem];
                        val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        [anEvent setCategory:val];
                        if (![ar containsObject:val]) {
                            [ar addObject:val];
                        }
                    }
                    
                    anItem = [TBXML childElementNamed:@"address" parentElement:resultNodes]; 
                    if (anItem) {
                        val = [TBXML textForElement:anItem];
                        val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        [anEvent setAddress:val];
                    }
                    
                    anItem = [TBXML childElementNamed:@"phone" parentElement:resultNodes]; 
                    if (anItem) {
                        val = [TBXML textForElement:anItem];
                        val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        [anEvent setPhone:val];
                    }
                    
                    anItem = [TBXML childElementNamed:@"description" parentElement:resultNodes]; 
                    if (anItem) {
                        val = [TBXML textForElement:anItem];
                        val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        [anEvent setDetails:[self formattedHtmlString:val]];
                    }
                    
                    
                     anItem = [TBXML childElementNamed:@"GeoLocation" parentElement:resultNodes]; 
                     if (anItem) {
                     NSMutableString* lInfo = [NSMutableString string];
                         TBXMLElement* cItem = [TBXML childElementNamed:@"location" parentElement:anItem];
                     do{
                     
                     
                         if (cItem) {
                             val = [TBXML textForElement:cItem];
                             val = [val stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                     
                             if(val.length > 0){
                                 [lInfo appendString:[NSString stringWithFormat:@"%@|",val]];
                             }
                         } 
                     }while ((cItem = cItem -> nextSibling));                        
                        NSLog(@"Location : %@",lInfo);
                        [anEvent setGeoLocations:lInfo];
                     }
                    
                    appDelegate.arrCategory =  [NSArray arrayWithArray:ar];
                
                }
              
            }while ((resultNodes = resultNodes->nextSibling));
		}
		[tbxml release];
        
        
	}
    
    
    [self.managedObjectContext save:nil];
}
*/
    
    
-(NSString*)formattedHtmlString:(NSString*)aHtml
    {
	
	aHtml = [NSString stringWithFormat:@"<html> \n"
             "<head> \n"
             "<style type=\"text/css\"> \n"
             "body {font-family: \"%@\"; font-size: %@; color: %@;}\n"
             "</style> \n"
             "</head> \n"
             "<body>%@</body> \n"
             "</html>", @"helvetica", @"15",@"#989898", aHtml];
	return aHtml;
}
    
@end
