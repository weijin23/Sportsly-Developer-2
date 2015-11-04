//
//  ConnectionManager.h
//  EventManager
//
//  Created by Satish Kumar on 3/19/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASINetworkQueue.h"
#import "ASIFormDataRequest.h"
@protocol ConnectionProtocol <NSObject>
@optional
-(id)postData;
-(void)notifyRequesterWithData:(id) aData :(id)aData1;
-(void)showAlertMessage:(NSString*)msg;
@end

@protocol ResponseHandler <NSObject>
-(void)notifyRequestFinished:(id) aManager;
-(void)notifyRequestFinishedSingle:(id) aManager;
@end

@class AppDelegate,ASIHTTPRequest,AFHTTPClient ;
@interface ConnectionManager : NSObject
{
	                      AppDelegate* appDelegate ;
	                      id<ConnectionProtocol> requester; 
	                      id<ResponseHandler> __weak handler;
				          NSMutableArray* requestId;
                          NSString* requestSingleId;
	                      BOOL isSynchronous;
	ASIFormDataRequest* aRequest;
    NSMutableDictionary *webServiceResponse ;
    
}
@property(nonatomic,assign) BOOL nextpagetokenblankcounter;
@property(nonatomic,assign) BOOL checkqueuefinished;
@property(nonatomic,strong) ASINetworkQueue *subrequestqueue;
@property(nonatomic,strong) NSMutableArray* nextpagesschool;
@property(nonatomic,strong) NSMutableArray* nextpageschurch;
@property(nonatomic,strong) NSMutableArray* nextpagescommon;
@property(nonatomic,strong) NSMutableArray* nextpagesrestaurent;
@property(nonatomic,strong) NSMutableArray* storeCreatedUser;
@property(nonatomic,strong) NSMutableDictionary *webServiceResponse ;
@property(nonatomic,strong) ASIFormDataRequest* aRequest;
@property(nonatomic,strong) AFHTTPRequestOperation* aRequestOperation;
@property(nonatomic,strong) AFHTTPClient* aRequestClient;
@property(nonatomic,strong) ASIHTTPRequest* aMyRequest1;
@property(nonatomic,strong) ASIHTTPRequest* aMyRequest2;
@property(nonatomic,strong) ASIHTTPRequest* aMyRequest3;

@property(nonatomic,strong)  NSMutableArray* requestId;
@property(nonatomic,strong) NSString* requestSingleId;
@property(nonatomic,assign)  BOOL isSynchronous;
@property(nonatomic,strong)  id<ConnectionProtocol> requester;
@property(nonatomic,weak)  id<ResponseHandler> handler;
-(BOOL)callWebServiceMethod:(NSMutableArray*) reqId ofType:(BOOL) isSync requestSource:(id<ConnectionProtocol>) reqSource andHandler:(id<ResponseHandler>) resHandler ;
-(NSString*)urlString:(NSString*)comparestr;
-(BOOL)callWebServiceMethodSingle:(NSString*) reqId ofType:(BOOL) isSync requestSource:(id<ConnectionProtocol>) reqSource andHandler:(id<ResponseHandler>)resHandler parameter:(NSDictionary*)dic;
-(NSString*)urlStringSingleRequest; 
-(void)createSubRequest:(NSString *)key :(NSString*)response;
-(void)createSubRequestSingle:(NSString*)response;
@end
