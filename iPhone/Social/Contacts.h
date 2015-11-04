//
//  Contacts.h
//  Wall
//
//  Created by Mindpace on 25/09/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Contacts : NSManagedObject

@property (nonatomic, strong) NSString * cFirstChar;
@property (nonatomic, strong) NSString * contactName;
@property (nonatomic, strong) NSString * email;
@property (nonatomic, strong) NSString * userId;

@end
