//
//  MapViewVC.h
//  FoodTruckTracker
//
//  Created by Piyali on 28/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"


@interface MapViewVC : BaseVC<MKMapViewDelegate>
{
    MyAnnotation *annotation;
}
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (strong, nonatomic) IBOutlet UILabel *dotcom;
@property (strong, nonatomic) NSString *selectedAddress;


@property (strong, nonatomic) IBOutlet MKMapView *mapview;
@property (strong, nonatomic) IBOutlet UIButton *backb;
- (IBAction)bacbf:(id)sender;
@property(nonatomic,assign) CLLocationCoordinate2D loccordinate;


- (void)geocodeAddress;
-(void)showMap;


@end
