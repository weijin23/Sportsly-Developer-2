//
//  Invite.h
//  Wall
//
//  Created by Mindpace on 25/11/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Invite : NSManagedObject

@property (nonatomic, strong) NSString * contentMessage;
@property (nonatomic, strong) NSString * creatorEmail;
@property (nonatomic, strong) NSString * creatorName;
@property (nonatomic, strong) NSString * creatorPhno;
@property (nonatomic, strong) NSString * message;
@property (nonatomic, strong) NSString * teamId;
@property (nonatomic, strong) NSString * teamName;
@property (nonatomic, strong) NSNumber * type;
@property (nonatomic, strong) NSString * postId;
@property (nonatomic, strong) NSString * userId;
@property (nonatomic, strong) NSString *senderName;
@property (nonatomic, strong) NSString *senderProfileImage;
@property (nonatomic, strong) NSNumber * inviteStatus;
@property (nonatomic, strong) NSDate *datetime;
@property (nonatomic, strong) NSDate *eventDate;
@property (nonatomic, strong) NSString *teamSport;



@property (nonatomic, strong) NSString * eventName;
@property (nonatomic, strong) NSString * playerName;
@property (nonatomic, strong) NSString * eventId;
//@property (nonatomic, strong) NSDate * datetime;
@property (nonatomic, strong) NSString * teamLogo;
//@property (nonatomic, strong) NSString * teamName;
@property (nonatomic, strong) NSString * playerUserId;
@property (nonatomic, strong) NSString * playerId;
//@property (nonatomic, strong) NSNumber * inviteStatus;
@property (nonatomic, strong) NSNumber * isPublic;
//@property (nonatomic, strong) NSString * userId;

@property (nonatomic, strong) NSNumber * viewStatus;

@property (nonatomic, strong) NSString * last_id;
@property (nonatomic, strong) NSNumber * isComment;
//@property (nonatomic, strong) NSString * data2;
@property (nonatomic, strong) NSString * data1;
//@property (nonatomic, strong) NSString * message;
//@property (nonatomic, strong) NSDate *datetime;
//@property (nonatomic, assign) BOOL inviteStatus;
@property (nonatomic, strong) NSString * profImg;





@end
