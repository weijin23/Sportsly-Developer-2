//
//  Invite.h
//  Wall
//
//  Created by Mindpace on 25/11/13.
//
//

#import <Foundation/Foundation.h>


@interface LikeCommentData : NSObject

@property (nonatomic, strong) NSString * last_id;
@property (nonatomic, assign) BOOL isComment;
@property (nonatomic, strong) NSString * data2;
@property (nonatomic, strong) NSString * data1;
@property (nonatomic, strong) NSString * message;
@property (nonatomic, strong) NSDate *datetime;
@property (nonatomic, assign) BOOL inviteStatus;
@property (nonatomic, strong) NSString * profImg;
@end
