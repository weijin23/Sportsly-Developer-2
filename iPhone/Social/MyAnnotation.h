//
//  MyAnnotation.h
//  FoodTruckTracker
//
//  Created by Piyali on 29/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface MyAnnotation : NSObject<MKAnnotation>
{
    CLLocationCoordinate2D coordinate;
    NSString *title;
  NSString *subtitle;
}
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

-(NSString *)subtitle ;
-(NSString *)title ;
-(id)initWithCoordinate:(CLLocationCoordinate2D) c title:(NSString *) t
               subtitle:(NSString *) st;

@end
