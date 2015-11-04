//
//  Contacts.h
//  Wall
//
//  Created by Mindpace on 25/09/13.
//
//

#import <Foundation/Foundation.h>
#import "ImageInfo.h"


@interface ContactsUser : NSObject

@property (nonatomic, strong) NSString *cFirstChar;
@property (nonatomic, strong) NSString *contactName;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *profileImage;
@property (nonatomic, strong) ImageInfo *profileImageInfo;
@end
