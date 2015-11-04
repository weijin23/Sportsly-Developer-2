//
//  MapViewController.h
//  CityGuide
//
//  Created by Jeeban Krishna  Mondal on 28/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "GooglePolylineRequest.h"
#import <MapKit/MapKit.h>


@interface MapViewController : BaseVC <MKMapViewDelegate,GooglePolylineRequestDelegate>
{
    IBOutlet MKMapView *aMapView;
    NSString *selectRowIndex;
    NSDictionary *getGoogleAddress;
    CLLocationCoordinate2D getUserLocation;
    CLLocationCoordinate2D destinationLocation;
    NSString *travleMode;
    GooglePolylineRequest *gpl;
    UIActivityIndicatorView*	indicator;
	UIView* indicatorView;
    MKPolyline *routeLine;
   

}
@property (strong, nonatomic) IBOutlet UIButton *butnList;
@property(nonatomic,strong) NSMutableArray *tableArr;
@property(assign, nonatomic)  CLLocationCoordinate2D endRouteLocation;
@property (strong, nonatomic) NSString *selectedAddress;
@property (strong, nonatomic) NSString *selectedAddress1;
@property(nonatomic,strong)MKPolyline *routeLine;
@property (strong, nonatomic) IBOutlet UILabel *durationLbl;
@property (strong, nonatomic) IBOutlet UILabel *distanceLbl;
@property(nonatomic,strong)  GooglePolylineRequest *gpl;
@property(nonatomic,strong) NSString *travleMode;
@property(nonatomic,strong)NSString *selectRowIndex;
@property (strong, nonatomic) IBOutlet UISegmentedControl *travleModeSegmentController;
- (IBAction)travelModeSegmentAction:(id)sender;
- (CLLocationCoordinate2D)getDestinationLocation;
@property(nonatomic,strong) UIActivityIndicatorView*	indicator;
@property (strong, nonatomic) IBOutlet UIView *instrationView;
@property(nonatomic,strong) UIView* indicatorView;
- (IBAction)listOfPoint:(id)sender;
-(void)stopIndicator;
-(void)startIndicator;
@property (strong, nonatomic) IBOutlet UITableView *instructionTbl;
- (IBAction)bacbf:(id)sender;
@end
