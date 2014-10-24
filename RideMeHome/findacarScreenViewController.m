//
//  findacarScreenViewController.m
//  RideMeHome
//
//  Created by ajith kumar on 8/17/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import "findacarScreenViewController.h"

@interface findacarScreenViewController ()

@end

@implementation findacarScreenViewController

static CGFloat randf() {
    return (((float)arc4random()/0x100000000)*1.0f);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20.0f/255.0f green:20.0f/255.0f blue:20.0f/255.0f alpha:.5f]];
    
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    
    self.title =  @"find a ride";
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.mapView.delegate = self;

    //[self loadMarkersOnMap];
    [self showMyLocation];
    [self getAllCarPoolers];
    
}

-(void)showMyLocation
{
    
    /*GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.868
                                                            longitude:151.2086
                                                                 zoom:12];*/
    
   // self.mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    self.mapView.settings.compassButton = YES;
    self.mapView.settings.myLocationButton = YES;
    
    // Listen to the myLocation property of GMSMapView.
    [self.mapView addObserver:self
               forKeyPath:@"myLocation"
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
    
    //self.view = self.mapView;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.mapView.myLocationEnabled = YES;
    });

    
    
}


-(void)getAllCarPoolers
{
    
    
    
    GTLServiceCarpoolendpoint *service = [self carPoolService];
    
    GTLQueryCarpoolendpoint *query = [GTLQueryCarpoolendpoint queryForListCarPool];
    
    [service executeQuery:query completionHandler:^(GTLServiceTicket *ticket, GTLCarpoolendpointCarPoolCollection *object, NSError *error) {
        // NSArray *items = [object items];
        
        NSArray *values = (NSArray *)object;
        
        for (GTLCarpoolendpointCarPool *carpoolObj in values) {
            [self loadMarkersOnMap:carpoolObj];
        }
    }];

    
    
    
    
}


#pragma mark - KVO updates

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (!firstLocationUpdate_) {
        // If the first location update has not yet been recieved, then jump to that
        // location.
        firstLocationUpdate_ = YES;
        CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
        self.mapView.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                         zoom:10];
        //[self loadMarkersOnMap];
    }
}

-(void)loadMarkersOnMap : (GTLCarpoolendpointCarPool *)obj
{
       static int i = 0;
    
    //for (NSString *key in allKeys) {
        
       // NSDictionary *pdict = [locnHolder objectForKey:key];
        CLLocationCoordinate2D pos = CLLocationCoordinate2DMake([obj.destinationLatitude doubleValue], [obj.destinationLongitude doubleValue]);
        
        
        
        
        
        double delayInSeconds = (i * 0.5);
        dispatch_time_t popTime =
        dispatch_time(DISPATCH_TIME_NOW,
                      (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            GMSVisibleRegion region = [self.mapView.projection visibleRegion];
            GMSCoordinateBounds *bounds =
            [[GMSCoordinateBounds alloc] initWithRegion:region];
            [self addMarkerInBounds:bounds andposition:pos witTitle:obj.destinationLocation anduserdata:obj];
        });

        i++;
       /* GMSMarker *marker = [GMSMarker markerWithPosition:pos];
        marker.title = [NSString stringWithFormat:@"Marker"];
        marker.draggable = YES;
        //marker.tappable = YES;
        
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.icon = [GMSMarker markerImageWithColor:color];
        
        marker.rotation = (randf()-0.5f)*20;  // rotate between -20 and +20 degrees
        
        
        marker.map = self.mapView;*/
        
        
  //  }
    
    
}




- (void)addMarkerInBounds:(GMSCoordinateBounds *)bounds andposition : (CLLocationCoordinate2D)pos
                witTitle : (NSString *)title anduserdata : (GTLCarpoolendpointCarPool *)obj
{
    CLLocationDegrees latitude = bounds.southWest.latitude +
    randf() * (bounds.northEast.latitude - bounds.southWest.latitude);
    
    // If the visible region crosses the antimeridian (the right-most point is
    // "smaller" than the left-most point), adjust the longitude accordingly.
    BOOL offset = (bounds.northEast.longitude < bounds.southWest.longitude);
    CLLocationDegrees longitude = bounds.southWest.longitude + randf() *
    (bounds.northEast.longitude - bounds.southWest.longitude + (offset ?
                                                                360 : 0));
    if (longitude > 180.f) {
        longitude -= 360.f;
    }
    
    UIColor *color =
    [UIColor colorWithHue:randf() saturation:1.f brightness:1.f alpha:1.0f];
    
//    CLLocationCoordinate2D position =
//    CLLocationCoordinate2DMake(latitude, longitude);
    GMSMarker *marker = [GMSMarker markerWithPosition:pos];
    marker.title = [NSString stringWithFormat:@"Marker"];
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.icon = [GMSMarker markerImageWithColor:color];
    marker.userData = obj;
    marker.rotation = (randf()-0.5f)*20;  // rotate between -20 and +20 degrees
    
    marker.map = self.mapView;
}



- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker
{
    [self showUserScreen:(GTLCarpoolendpointCarPool *)marker.userData ];
    return YES;
}



- (GTLServiceCarpoolendpoint *) carPoolService {
    static GTLServiceCarpoolendpoint *service = nil;
    if (!service) {
        service = [[GTLServiceCarpoolendpoint alloc] init];
        
        // Have the service object set tickets to retry temporary error conditions
        // automatically
        service.retryEnabled = YES;
        
        [GTMHTTPFetcher setLoggingEnabled:YES];
    }
    return service;
}






-(void)showUserScreen : (GTLCarpoolendpointCarPool *)userObj
{
    CarSelectionScreen *carSelectn  = [[CarSelectionScreen alloc] initWithNibName:@"CarSelectionScreen" bundle:nil andUserData:userObj];
    
   // [self.navigationController presentViewController:carSelectn animated:YES completion:^{}];
    [self.navigationController pushViewController:carSelectn animated:YES];
    
    
   // [carSelectn refreshUserData:userObj];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn_Search:(id)sender {
    
    
    [self.txt_search resignFirstResponder];
    
    NSString *address = [NSString stringWithFormat:@"%@+%@+%@" , self.txt_search.text , @"Bangalore" , @"Karnataka"];
    
    geocoders *_coder = [geocoders getInstance];
    CLLocationCoordinate2D position = [_coder geoCodeUsingAddress:address];
    [self.mapView becomeFirstResponder];
    self.mapView.camera = [GMSCameraPosition cameraWithTarget:position
                                                           zoom:10];
    
}
@end
