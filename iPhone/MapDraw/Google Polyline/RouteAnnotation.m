//
//  RouteAnnotation.m
//  GoogleRoute
//
//  Created by Vitaly Evtushenko on 17.02.12.
//  Copyright (c) 2012 AshberrySoft LLC. All rights reserved.
//

#import "RouteAnnotation.h"

@implementation RouteAnnotation

@synthesize coordinate = _coordinate;
@synthesize title = _title;
@synthesize subtitle = _subtitle;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate andTitle:(NSString*)title andSubTitle:(NSString*)subTitle
{
    self = [super init];
    if (self)
    {
        _coordinate = coordinate;
        _title = title;
        _subtitle = subTitle;
    }
    return self;
}

@end
