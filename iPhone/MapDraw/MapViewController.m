//
//  MapViewController.m
//  CityGuide
//
//  Created by Jeeban Krishna  Mondal on 28/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.

// @"http://maps.google.com/maps?output=dragdir&saddr=%@&daddr=%@&sensor=false&mode=driving"


#import "MapViewController.h"
#import "GoogleRoute.h"
#import "RouteAnnotation.h"
#import <QuartzCore/QuartzCore.h>
@interface MapViewController()


@end

@implementation MapViewController
@synthesize selectRowIndex;
@synthesize travleMode;
@synthesize gpl;
@synthesize indicator;
@synthesize indicatorView;
@synthesize routeLine,selectedAddress;
@synthesize tableArr;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.topview.backgroundColor=appDelegate.barGrayColor;
    //self.view.backgroundColor=appDelegate.backgroundPinkColor;
    
    
    
 
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero] ;
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:15.0];
	label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
	label.textAlignment = NSTextAlignmentCenter;
	label.textColor = [UIColor whiteColor];
	self.navigationItem.titleView = label;
	label.text = NSLocalizedString(@"Merchant Direction",@"");
	[label sizeToFit];
    
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setFrame:CGRectMake(0, 0, 59, 30)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton] ;
    
    UIButton *homeButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [homeButton setImage:[UIImage imageNamed:@"nav_home.png"] forState:UIControlStateNormal];
    [homeButton addTarget:self action:@selector(homeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [homeButton setFrame:CGRectMake(0, 0, 38, 32)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:homeButton] ;
    
    destinationLocation=  [self getDestinationLocation:self.selectedAddress];
    
    if (destinationLocation.latitude && destinationLocation.longitude) {
         destinationLocation=  [self getDestinationLocation:self.selectedAddress1];
    }

    
    self.travleModeSegmentController.selectedSegmentIndex=0;
    travleMode=@"driving";
    aMapView.showsUserLocation = YES;
    aMapView.delegate=self;
    
    
    self.indicator =[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] ;
    self.indicator.frame = CGRectMake(30, 30, 40, 40);
    self.indicator.hidesWhenStopped = YES;
    
    self.indicatorView=[[UIView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width -100)/2, (self.view.bounds.size.height - 100)/2, 100, 100)] ;
    
    self.indicatorView.backgroundColor=[UIColor blackColor];
    self.indicatorView.alpha=0.8;
    CALayer *l = [self.indicatorView layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:10.0];
    [self.view addSubview:self.indicatorView];
    [self.indicatorView addSubview: self.indicator];
    self.indicatorView.hidden=YES;
    [self startIndicator];
    
    [self performSelector:@selector(getUserCurrentLocation) withObject:nil afterDelay:2.0];
    
    self.tableArr=[[NSMutableArray alloc] init];
    self.instrationView.hidden=YES;
    
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setStatusBarStyleOwnApp:0];
}
//
- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [self setStatusBarStyleOwnApp:1];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
#pragma mark - AfterDelayGetUserCurrentLocation

-(void)getUserCurrentLocation{
    
    NSLog(@"current location %f %f",getUserLocation.latitude,getUserLocation.longitude);
    NSLog(@"destination location %f %f",destinationLocation.latitude,destinationLocation.longitude);
    
    
    if (destinationLocation.latitude && destinationLocation.longitude) {
        
        CLLocation *from = [[CLLocation alloc] initWithLatitude:getUserLocation.latitude  longitude:getUserLocation.longitude];
        CLLocation *to = [[CLLocation alloc] initWithLatitude:destinationLocation.latitude longitude:destinationLocation.longitude];
        if (!gpl) {
            gpl = [[GooglePolylineRequest alloc] init];
        }
        gpl.delegate = self;
        [gpl requestPolylineFromPoint:from toPoint:to andMode:travleMode];
        
    }else{
        
        [self stopIndicator];
        [[[UIAlertView alloc] initWithTitle:@""
                                    message:@"No Route Found"
                                   delegate:nil
                          cancelButtonTitle:@"Okay"
                          otherButtonTitles:nil] show];

    }
   
}

#pragma mark -

- (void)viewDidUnload
{
    self.routeLine=nil;
    self.durationLbl=nil;
    self.distanceLbl=nil;
    self.travleModeSegmentController=nil;
    self.indicator=nil;
    self.indicatorView=nil;
    [super viewDidUnload];
}

/*- (void)dealloc
{
    [aMapView release];
    [_travleModeSegmentController release];
    [_distanceLbl release];
    [_durationLbl release];
    [super dealloc];
}*/

#pragma mark - Class Method
#pragma mark - BackButtonAction
-(void)backButtonAction:(id)sender{
    
    
    
}
#pragma mark - HomeButtonAction
/*- (void)homeButtonAction:(id)sender {
    MainMenuViewController *mainMenu=[[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:nil];
    mainMenu.isMyProfile=YES;
    [[self.tabBarController.viewControllers objectAtIndex:0]  pushViewController:mainMenu animated:NO];
    [self.tabBarController.tabBar setNeedsDisplay];
    [self.tabBarController setSelectedIndex:0];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary: [[UITabBarItem appearanceWhenContainedIn:[UITabBar class], nil] titleTextAttributesForState:UIControlStateNormal]];
    [attributes setValue:[UIFont fontWithName:@"Avenir" size:10] forKey:UITextAttributeFont];
    [attributes setValue:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    [[UITabBarItem appearanceWhenContainedIn:[UITabBar class], nil] setTitleTextAttributes:attributes forState:UIControlStateDisabled];
    [mainMenu release];
}*/

#pragma mark  - SegmentController Action
- (IBAction)travelModeSegmentAction:(id)sender {
        [self startIndicator];
        if ( self.travleModeSegmentController.selectedSegmentIndex==0) {
            self.travleMode=@"driving";
        }else{
            self.travleMode=@"walking";
        }
  //22.750000 88.250000
   // -34.925686 138.603389
    CLLocation *from = [[CLLocation alloc] initWithLatitude:getUserLocation.latitude longitude:getUserLocation.longitude];
    CLLocation *to = [[CLLocation alloc] initWithLatitude:destinationLocation.latitude longitude:destinationLocation.longitude];
    
    if (gpl) {
        gpl=nil;
         gpl = [[GooglePolylineRequest alloc] init] ;
         gpl.delegate = self;
    }else{
         gpl = [[GooglePolylineRequest alloc] init] ;
         gpl.delegate = self;
    }
    
    [gpl requestPolylineFromPoint:from toPoint:to andMode:travleMode];
  
   
}

#pragma mark - DestinationLatitudeAndLongitude
- (CLLocationCoordinate2D)getDestinationLocation:(NSString*)address
{
    NSLog(@"get add ress %@",self.selectedAddress);
    CLLocationCoordinate2D myLocation;
    NSString *combineAddress=address;
      
    combineAddress = [combineAddress stringByReplacingOccurrencesOfString:@" " withString:@"+" options:NSRegularExpressionSearch range:NSMakeRange(0, combineAddress.length)];
    
    combineAddress = [combineAddress stringByReplacingOccurrencesOfString:@"-" withString:@"+" options:NSRegularExpressionSearch range:NSMakeRange(0, combineAddress.length)];
    combineAddress = [combineAddress stringByReplacingOccurrencesOfString:@"," withString:@"+" options:NSRegularExpressionSearch range:NSMakeRange(0, combineAddress.length)];


    combineAddress = [combineAddress stringByReplacingOccurrencesOfString:@"/" withString:@"+" options:NSRegularExpressionSearch range:NSMakeRange(0, combineAddress.length)];
    combineAddress = [combineAddress stringByReplacingOccurrencesOfString:@"&" withString:@"+" options:NSRegularExpressionSearch range:NSMakeRange(0, combineAddress.length)];
    
    NSLog(@"combine address %@",combineAddress);
    
    NSString *unescaped=[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=true",combineAddress];
    NSURL* apiUrl = [NSURL URLWithString:unescaped];
    NSString *aResponse = [NSString stringWithContentsOfURL:apiUrl encoding:NSUTF8StringEncoding error:NULL];
    NSLog(@"respone %@",aResponse);
    NSError *error;
    if (aResponse) {
    NSMutableDictionary *jsonResponeDict= [NSJSONSerialization JSONObjectWithData: [aResponse dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    
        for (int i=0; i<[[jsonResponeDict valueForKey:@"results"] count]; i++) {
            
            if ([[jsonResponeDict valueForKey:@"results"] objectAtIndex:i]){
                myLocation.latitude=[[[[[[jsonResponeDict valueForKey:@"results"] objectAtIndex:i] valueForKey:@"geometry"] valueForKey:@"location"] valueForKey:@"lat"] doubleValue];
                myLocation.longitude=[[[[[[jsonResponeDict valueForKey:@"results"]  objectAtIndex:i]valueForKey:@"geometry"] valueForKey:@"location"] valueForKey:@"lng"] doubleValue];
                
            }

    }
         return myLocation;
            
    }else{
         return myLocation;
    }
   
}

#pragma mark -
#pragma mark Indicator


-(void)stopIndicator{
    [self.view setUserInteractionEnabled:YES];
    self.navigationController.navigationBar.userInteractionEnabled=YES;
    self.tabBarController.tabBar.userInteractionEnabled=YES;
    self.indicatorView.hidden=YES;
    [self performSelectorOnMainThread:@selector(busyToggle:) withObject:@"NO" waitUntilDone:NO];
}

-(void)startIndicator{
    [self.view setUserInteractionEnabled:NO];
    self.navigationController.navigationBar.userInteractionEnabled=NO;
    self.tabBarController.tabBar.userInteractionEnabled=NO;
    self.indicatorView.hidden=NO;
    [self performSelectorOnMainThread:@selector(busyToggle:) withObject:@"YES" waitUntilDone:NO];
}

-(void)busyToggle:(NSString*) str{
    BOOL isBusy = [str boolValue];
    if (isBusy) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if(![self.indicator isAnimating]){
            [self.indicator startAnimating];
            [self.view bringSubviewToFront:indicatorView];
        }
    }else {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if([self.indicator isAnimating]){
            [self.indicator stopAnimating];
        }
    }
    
}



#pragma mark - Device Orientation
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return  UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
}

-(BOOL)shouldAutorotate
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return self.interfaceOrientation;
}


#pragma mark  - GooglePolylineRequestDelegate
- (void)googlePolylineRequest:(GooglePolylineRequest*)request didFailWithError:(NSError*)error
{
    [self stopIndicator];
    [[[UIAlertView alloc] initWithTitle:@""
                                message:@"No Route Found"
                               delegate:nil
                      cancelButtonTitle:@"Okay"
                      otherButtonTitles:nil] show];
}

- (void)googlePolylineRequest:(GooglePolylineRequest*)request didFindRoutes:(NSArray*)routes
{
    [self stopIndicator];
    id userLocation = [aMapView userLocation];
    NSMutableArray *pins = [[NSMutableArray alloc] initWithArray:[aMapView annotations]];
    if ( userLocation != nil ) {
       [pins removeObject:userLocation]; 
   }
    [aMapView removeAnnotations:pins];
   
    pins = nil;
    [aMapView removeOverlays:aMapView.overlays];
    
    GoogleRoute *route = [routes lastObject];
    
    [aMapView setRegion:[route region] animated:YES];
    
    NSMutableArray *polylines = [[NSMutableArray alloc] init];
    
    Leg *leg = [route.legs lastObject];
    
    for (Step *step in [leg steps])
    {
        RouteAnnotation *ann = [[RouteAnnotation alloc] initWithCoordinate:step.startLocation.coordinate andTitle:@" " andSubTitle:step.htmlInstructions];
        [aMapView addAnnotation:ann];
        [polylines addObjectsFromArray:step.polyline];
        [self.tableArr addObject:step.htmlInstructions];
    }
    
    
    NSArray *points = polylines;
    int pointsCount = [polylines count];
    
    CLLocationCoordinate2D *coords = malloc(sizeof(CLLocationCoordinate2D) * pointsCount);
    
    for (int i=0; i< pointsCount; ++i)
    {
        CLLocation *loc = [points objectAtIndex:i];
        coords[i] = loc.coordinate;
    }
   
    self.routeLine = [MKPolyline polylineWithCoordinates:coords count:pointsCount];
    
    free(coords);
    
    [aMapView addOverlay:self.routeLine];
  
    
    Step *step = [[leg steps] lastObject];
    RouteAnnotation *ann1 = [[RouteAnnotation alloc] initWithCoordinate:step.endLocation.coordinate andTitle:step.lastAddressString andSubTitle:self.selectedAddress];
    [self.tableArr addObject:self.selectedAddress];

    self.endRouteLocation=step.endLocation.coordinate;
    
    [aMapView addAnnotation:ann1];
    
    
}

#pragma mark - MKMapViewDelegate
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userCurrentLocation
{
    getUserLocation=userCurrentLocation.coordinate;
    
    //NSLog(@"location %f %f",getUserLocation.coordinate.latitude,getUserLocation.coordinate.longitude);
    //    RouteAnnotation *ann = [[RouteAnnotation alloc] initWithCoordinate:getUserLocation andTitle:@" " andSubTitle:@"Current Location"];
    //    [aMapView addAnnotation:ann];
   
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{	
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Opps" message:NSLocalizedString(@"LOCATION_FAILED_KEY", @"") delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alertView show];
   
    
    
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]])
    {
        MKPolylineView *view = [[MKPolylineView alloc] initWithPolyline:self.routeLine];
        if ([travleMode isEqualToString:@"driving"]) {
            view.fillColor = [UIColor blueColor];
            view.strokeColor = [UIColor blueColor];
            view.lineWidth = 4.0f;

        }else{
            view.fillColor = [UIColor purpleColor];
            view.strokeColor = [UIColor purpleColor];
            view.lineWidth = 4.0f;
        }
        return view;
    }
    
    return nil;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	
    if ([annotation isEqual:[aMapView userLocation]])
        
        return nil;
    
    else{
        
	static NSString *annotationIdentifier = @"aPin";
    static NSString *annotationIdentifier1 = @"aPin1";
       
        if ([[annotation title] isEqualToString:@"End of route"]) {
            
            MKPinAnnotationView *aAnnotation = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier1];
            
            aAnnotation = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier1] ;
            //aAnnotation.image=[UIImage imageNamed:@""];
            aAnnotation.canShowCallout = YES;
            aAnnotation.animatesDrop = NO;
            aAnnotation.pinColor = MKPinAnnotationColorRed;
            //          if ([travleMode isEqualToString:@"driving"]) {
            //              aAnnotation.pinColor = MKPinAnnotationColorPurple;
            //          }else{
            //              aAnnotation.pinColor = MKPinAnnotationColorGreen;
            //          }
            
            [aAnnotation setAnnotation:annotation];
            return aAnnotation;

        }else{
       
       
            MKPinAnnotationView *aAnnotation = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
            
            aAnnotation = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier] ;
            aAnnotation.image=[UIImage imageNamed:@""];
            aAnnotation.canShowCallout = YES;
            aAnnotation.animatesDrop = NO;
            aAnnotation.pinColor = MKPinAnnotationColorPurple;
            //          if ([travleMode isEqualToString:@"driving"]) {
            //              aAnnotation.pinColor = MKPinAnnotationColorPurple;
            //          }else{
            //              aAnnotation.pinColor = MKPinAnnotationColorGreen;
            //          }
            
            [aAnnotation setAnnotation:annotation];
            return aAnnotation;
        }
                
              
    }
    //return nil;
}

- (IBAction)bacbf:(id)sender
{
    
    if ([self.instrationView isHidden]) {
        [self dismissModal];
    }else{
        self.instrationView.hidden=YES;
        self.butnList.hidden=NO;
    }
}

#pragma ListPoint

- (IBAction)listOfPoint:(id)sender {
    
    self.instrationView.hidden=NO;
    [self.instructionTbl reloadData];
    self.butnList.hidden=YES;
}

#pragma mark - TableViewDataSorace

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableArr count] ;//+ 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EventPlayerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    
    if (cell == nil)
    {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
       
    }
    
    cell.textLabel.font=[UIFont systemFontOfSize:12.0f];
    cell.textLabel.text=[self.tableArr objectAtIndex:indexPath.row];
    
    return cell;
    
}



@end
