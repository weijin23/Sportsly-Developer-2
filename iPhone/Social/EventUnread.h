//
//  EventUnread.h
//  Wall
//
//  Created by Mindpace on 18/01/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface EventUnread : NSManagedObject

@property (nonatomic, strong) NSString * eventName;
@property (nonatomic, strong) NSString * playerName;
@property (nonatomic, strong) NSString * eventId;
@property (nonatomic, strong) NSDate * datetime;
@property (nonatomic, strong) NSString * teamLogo;
@property (nonatomic, strong) NSString * teamName;
@property (nonatomic, strong) NSString * playerUserId;
@property (nonatomic, strong) NSString * playerId;
@property (nonatomic, strong) NSNumber * inviteStatus;
@property (nonatomic, strong) NSNumber * isPublic;
@property (nonatomic, strong) NSString * userId;


@end
