//
//  DataModel.h
//  CalApp
//
//  Created by Satish Kumar on 18/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ConnectionManager.h"

@class AppDelegate;


@interface DataModel : NSObject <ResponseHandler>{
	AppDelegate* __weak appDelegate;
	
	
    NSMutableSet* requestSent;
    ////added
    NSMutableDictionary *dicForPh;
     NSMutableDictionary *strMainDataS;
    ConnectionManager *cManager;
}
/////added
@property(nonatomic,strong) NSArray *arrForLoadGCS;
@property(nonatomic,strong) NSArray *arrForLoadGPL;

@property(nonatomic,strong) NSMutableArray *arrForLs;

@property(nonatomic,strong) NSMutableDictionary *dicForPh;
@property(nonatomic,strong) NSMutableDictionary *strMainDataS;
@property(nonatomic,strong) ConnectionManager *cManager;

@property(nonatomic,strong) NSMutableSet* requestSent;

@property(weak) AppDelegate* appDelegate;
@property(assign) int pcount;


-(NSNumber*)numberFromString:(NSString*) aVal;
-(BOOL)sendRequestFor:(NSMutableArray*)aRequestPages from:(id)aSource;
//-(void)loadEventData:(NSString*)d;
//-(void) loadTaxiData:(NSString*)d;
//-(void) loadNearMeData:(NSString*)d;
-(void)loadFourSquareData:(NSString*)response;
//-(void)loadMyAccountData:(NSString*)data;
-(NSString*)conditionForVersion:(NSString*) vid;
-(NSString*)formattedHtmlString:(NSString*)aHtml;
-(NSString*)checkNull:(id) obj;
//added
-(void)loadAndReqForPhData:(NSMutableDictionary*)responses;
-(NSString *)parsePhData:(NSString*)response;
-(void)loadFourSquareDataUpdate:(NSMutableDictionary*)responses :(NSMutableDictionary *)phArr;

-(void)loadAndReqForGoogleLocalST;
-(void)loadAndReqForGoogleLocalSearchTaxi:(NSString*)response;
-(id)loadAndReqForPhDataLsParseArray:(NSString*)response;
-(void)loadLSDataUpdate:(NSMutableArray *)phArr;
-(NSString *) stringByStrippingHTML:(NSString *)str;
-(void) compareAndLoad;
-(BOOL)sendSingleRequestFor:(NSString *)aRequestPage from:(id)aSource parameter:(NSDictionary*)dic;
-(void)loadPortFolioData:(NSString *)response;
-(void)loadGETAgentData:(NSString *)response;
-(void)loadGetCustomerData:(NSString *)response;
-(void)loadFourSquareDataUpdateSingle:(NSMutableDictionary*)responses ;
-(void)loadFourSquareDataTeamPostDetails:(NSString*)responses;
@end
