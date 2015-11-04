//
//  MyAnnotation.m
//  FoodTruckTracker
//
//  Created by Piyali on 29/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation

@synthesize coordinate,title,subtitle;

-(NSString *)subtitle 
{ 
    return subtitle;
}

-(NSString *)title 
{ 
    return title;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c title:(NSString *) t
               subtitle:(NSString *) st
{ 
    coordinate = c;
    self.title = t;
    self.subtitle = st; 
    return self;
}


@end
