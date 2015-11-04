//
//  MapViewVC.m
//  FoodTruckTracker
//
//  Created by Piyali on 28/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "MapViewVC.h"

@implementation MapViewVC
@synthesize dotcom;

@synthesize mapview;
@synthesize backb,loccordinate,geocoder;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  //  self.view.backgroundColor=appDelegate.backgroundPinkColor;
    self.topview.backgroundColor=appDelegate.barGrayColor;
 
    [self geocodeAddress];
    
}

-(void)showMap
{
    
    MKCoordinateSpan span;
    span.latitudeDelta=.002;
    span.longitudeDelta=.002;
    MKCoordinateRegion region;
    region.center=loccordinate;
    region.span=span;
    mapview.region=region;
    
    annotation = [[MyAnnotation alloc] initWithCoordinate:loccordinate
                                                    title:@"The Event is here" subtitle:self.selectedAddress/*[NSString
                                                                                    stringWithFormat:@"Lat: %f & Lng: %f",loccordinate.latitude,loccordinate.longitude]*/];
    
    [mapview addAnnotation:annotation];
}

- (void)geocodeAddress
{
    CLGeocoder *geocoder1=[[CLGeocoder alloc] init];
    self.geocoder = geocoder1;
    [geocoder geocodeAddressString:self.selectedAddress completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if([placemarks count])
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             CLLocation *location = placemark.location;
             CLLocationCoordinate2D coordinate = location.coordinate;
           
             self.loccordinate=coordinate;
           
             [self showMap];
            
         }
         else
         {
             NSLog(@"error");
            
             NSString *message=CONNFAILMSG;
             [self showHudAlert:message];
             [self performSelector:@selector(hideHudViewHere) withObject:nil afterDelay:2.0];
         }
     }];
    
}



-(void)hideHudViewHere
{
    [self hideHudView];
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (MKAnnotationView *)mapView:(MKMapView *)aMapView viewForAnnotation:(id)ann 
{
    NSString *identifier = @"myPin";
    MKPinAnnotationView *pin = (MKPinAnnotationView *)
    [aMapView dequeueReusableAnnotationViewWithIdentifier:identifier]; 
    if (pin == nil) 
    {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:ann reuseIdentifier:identifier];
    } 
    else
    {
        pin.annotation = ann;
    }
             
               //---display a disclosure button on the right---
               /*UIButton *myDetailButton =
               [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
               myDetailButton.frame = CGRectMake(0, 0, 23, 23); myDetailButton.contentVerticalAlignment =
               UIControlContentVerticalAlignmentCenter; myDetailButton.contentHorizontalAlignment =
               UIControlContentHorizontalAlignmentCenter;
               [myDetailButton addTarget:self action:@selector(checkButtonTapped:)
                        forControlEvents:UIControlEventTouchUpInside];
               pin.rightCalloutAccessoryView = myDetailButton; pin.enabled = YES;*/
               pin.animatesDrop=TRUE;
             //  pin.canShowCallout=YES;
               return pin;

}

- (void)viewDidUnload
{
    [self setDotcom:nil];
   
    [self setMapview:nil];
    [self setBackb:nil];
   
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)bacbf:(id)sender
{
    int tag=[sender tag];
    
    if(tag==1)
    [self.navigationController popViewControllerAnimated:YES];
   
}





@end
