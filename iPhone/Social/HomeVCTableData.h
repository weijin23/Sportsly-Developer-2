//
//  DetailViewCommentData.h
//  SkinaGram
//
//  Created by Mindpace on 19/07/13.
//
//
#import "ImageInfo.h"
#import <Foundation/Foundation.h>

@interface HomeVCTableData : NSObject
{
 
}
@property(nonatomic,strong) ImageInfo *userImageInfo;
@property(nonatomic,strong) ImageInfo *postedImageInfo;
@property(nonatomic,strong) ImageInfo *secondaryImageInfo;

@property(nonatomic,assign) BOOL isShowDelete;

@property(nonatomic,assign) float imageWidth;
@property(nonatomic,assign) float imageHeight;
@property(nonatomic,assign) BOOL isExistUserImageInfo;
@property(nonatomic,assign) BOOL isExistPostedImageInfo;
@property(nonatomic,assign) BOOL isExistSecondaryImageInfo;
@property(nonatomic,assign) long long int number_of_likes;
@property(nonatomic,assign) long long int number_of_comment;
@property(nonatomic,strong) NSMutableArray *commentdetailsarr;
@property(nonatomic,strong) NSMutableArray *likedetailsarr;
@property(nonatomic,strong) NSString* adddate;
@property(nonatomic,assign) BOOL isLike;
@property(nonatomic,strong) NSString *post_id;
@property(nonatomic,strong) NSString *videoUrlStr;
@property(nonatomic,strong) NSString* likecountlab;
@property(nonatomic,strong) NSString* commentcountlab;
@property(nonatomic,strong) NSString* commentstr;
@property(nonatomic,strong) NSString* playerfname;
@property(nonatomic,strong) NSString* playerlname;
@property(nonatomic,strong) NSString* userId;


@property(nonatomic,assign) BOOL isCoach;
@property(nonatomic,assign) BOOL isPlayer;
@property(nonatomic,assign) BOOL isPrimary;
@property(nonatomic,strong) NSString* playerNameTeam;
@property(nonatomic,strong) NSString* playerIdTeam;
@property(nonatomic,strong) NSString* primaryUserName;
@property(nonatomic,strong) NSString* primaryRelation;


@end
