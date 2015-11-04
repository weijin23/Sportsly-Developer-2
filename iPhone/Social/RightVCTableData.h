//
//  DetailViewCommentData.h
//  SkinaGram
//
//  Created by Mindpace on 19/07/13.
//
//
#import "ImageInfo.h"
#import <Foundation/Foundation.h>

@interface RightVCTableData : NSObject
{
 ImageInfo *userImageInfo;

    NSString* username;
     NSString* commentstr;
     int imastatus_first;
     int imastatus_second;
   BOOL isExistUserImageInfo;
}
@property(nonatomic,strong) ImageInfo *userImageInfo;
@property(nonatomic,assign)  int imastatus_first;
@property(nonatomic,assign) BOOL isExistUserImageInfo;
@property(nonatomic,assign)  int imastatus_second;
@property(nonatomic,strong) NSString* username;
@property(nonatomic,strong) NSString* commentstr;


@end
