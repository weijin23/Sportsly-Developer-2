//
//  CommentVCTableData.h
//  Wall
//
//  Created by Sukhamoy Hazra on 13/09/13.
//
//
#import "ImageInfo.h"
#import <Foundation/Foundation.h>

@interface CommentVCTableData : NSObject
{
    
}

@property(nonatomic,strong) ImageInfo *userImageInfo;
@property(nonatomic,assign) BOOL isExistUserImageInfo;

@property(nonatomic,strong) NSString *userName;
@property(nonatomic,strong) NSString *commentstr;
@property(nonatomic,strong) NSString *reducedCommentstr;

@property(nonatomic,strong) NSString *postdatestr;
@property(nonatomic,strong) NSDate *postDate;
@property(nonatomic,strong) NSDate *postTime;

@property(nonatomic,assign) BOOL isExpand;


@property(nonatomic,assign) BOOL isCoach;
@property(nonatomic,assign) BOOL isPlayer;
@property(nonatomic,assign) BOOL isPrimary;
@property(nonatomic,strong) NSString* playerNameTeam;
@property(nonatomic,strong) NSString* playerIdTeam;
@property(nonatomic,strong) NSString* primaryUserName;
@property(nonatomic,strong) NSString* primaryRelation;
@end
