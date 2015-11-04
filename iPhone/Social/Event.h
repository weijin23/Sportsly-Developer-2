//
//  Event.h
//  Wall
//
//  Created by Mindpace on 01/11/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Event : NSManagedObject

@property (nonatomic, strong) NSDate * alertDate;
@property (nonatomic, strong) NSString * alertString;
@property (nonatomic, strong) NSDate * arrivalTime;
@property (nonatomic, strong) NSDate * endTime;
@property (nonatomic, strong) NSDate * eventDate;
@property (nonatomic, strong) NSString * eventDateString;
@property (nonatomic, strong) NSString * eventId;
@property (nonatomic, strong) NSString * eventIdentifier;
@property (nonatomic, strong) NSString * eventName;
@property (nonatomic, strong) NSString * eventType;
@property (nonatomic, strong) NSString * fieldName;
@property (nonatomic, strong) NSNumber * isCreated;
@property (nonatomic, strong) NSNumber * isPublic;
@property (nonatomic, strong) NSNumber * isPublicAccept;
@property (nonatomic, strong) NSNumber * isPublicAccept1;
@property (nonatomic, strong) NSString * location;
@property (nonatomic, strong) NSString * opponentTeam;
@property (nonatomic, strong) NSString * opponentTeamId;
@property (nonatomic, strong) NSString * repeat;
@property (nonatomic, strong) NSDate * startTime;
@property (nonatomic, strong) NSString * teamId;
@property (nonatomic, strong) NSString * teamName;
@property (nonatomic, strong) NSString * thingsToBring;
@property (nonatomic, strong) NSString * uniformColor;
@property (nonatomic, strong) NSString * userId;
@property (nonatomic, strong) NSString * notes;
@property (nonatomic, strong) NSNumber * isHomeGame;
@property (nonatomic, strong) NSString * playerName;
@property (nonatomic, strong) NSString * playerId;
@property (nonatomic, strong) NSString * playerUserId;
@property (nonatomic, strong) NSString * playerName1;
@property (nonatomic, strong) NSString * playerId1;
@property (nonatomic, strong) NSString * playerUserId1;
@property (nonatomic, strong) NSNumber * inviteStatus;
@property (nonatomic, strong) NSDate * datetime;
@property (nonatomic, strong) NSNumber * isTeamMayBe;
@property (nonatomic, strong) NSString * creatorUserId;
@end
