//
//  AddLocationScreen.m
//  RideMeHome
//
//  Created by ajith kumar on 8/16/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import "AddLocationScreen.h"

@interface AddLocationScreen ()

@end

@implementation AddLocationScreen

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
    
    self.title =  @"Add a location";
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    self.gmapsView.delegate = self;
    self.locationLabel.hidden = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchClicked:(id)sender {
    
    
    
    
    NSString *address = [NSString stringWithFormat:@"%@+%@+%@" , self.addressSearchField.text , @"Bangalore" , @"Karnataka"];
    
    UIColor *color =
    [UIColor colorWithHue:randf() saturation:1.f brightness:1.f alpha:1.0f];
    
    
    geocoders *_coder = [geocoders getInstance];
    CLLocationCoordinate2D position = [_coder geoCodeUsingAddress:address];
    if (marker!= nil) {
        marker = nil;
    }
    _selectedPosition = position;
    marker = [GMSMarker markerWithPosition:position];
    marker.title = [NSString stringWithFormat:@"Marker"];
    marker.draggable = YES;
    //marker.tappable = YES;
    
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.icon = [GMSMarker markerImageWithColor:color];
    
    marker.rotation = (randf()-0.5f)*20;  // rotate between -20 and +20 degrees
    
    
    [self.gmapsView clear];
    marker.map = self.gmapsView;
    [self showCoordiantesOnMap:position];
    
}





-(void)showCoordiantesOnMap : (CLLocationCoordinate2D)coordinate
{
    self.gmapsView.hidden = NO;
    [self.addressSearchField resignFirstResponder];
    [self.gmapsView becomeFirstResponder];
    self.gmapsView.camera = [GMSCameraPosition cameraWithTarget:coordinate
                                                           zoom:14];
    
    self.locationLabel.hidden = NO;
    
    if (addItem == nil) {
        
        addItem = [[UIBarButtonItem alloc]  initWithTitle:@"Add" style:UIBarButtonItemStyleDone target:self action:@selector(registerLocation:) ];
        //[joinItem setTintColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f]];
        
        self.navigationItem.rightBarButtonItem = addItem;
    }
}





-(void)registerLocation : (UIBarButtonItem *)item
{
    
    
    dict = [[Utilities getDataFromCache:KEY_LOCATIONDATA]mutableCopy];
    
    NSNumber *lat = [NSNumber numberWithDouble:_selectedPosition.latitude];
    NSNumber *lon = [NSNumber numberWithDouble:_selectedPosition.longitude];
   // NSDictionary *userLocation=@{@"lat":lat,@"long":lon};
    
    if (newDict!=nil) {
        newDict = nil;
    }
    newDict  = @{@"lat":lat,@"lon":lon};
    if (dict == nil) {
        dict = [[NSMutableDictionary alloc] initWithDictionary:newDict];
        
    }else
    [dict setValue: newDict forKey:self.locationLabel.text];
    
    [Utilities removeCachedData:KEY_LOCATIONDATA];
    [Utilities setDataToCache:dict forkey:KEY_LOCATIONDATA];
    
    
    NSDictionary *userData = [Utilities getDataFromCache:KEY_USERDATA];
    
    GTLLocationendpointLocation *obj = [[GTLLocationendpointLocation alloc] init];
    obj.associateId = [[userData objectForKey:@"username"] uppercaseString];
    obj.latitude = lat;
    obj.longitude = lon;
    obj.title = self.locationLabel.text;
    
    GTLServiceLocationendpoint *service = [self locationService];
    
    GTLQueryLocationendpoint *query = [GTLQueryLocationendpoint queryForInsertLocationWithObject:obj];
    
    [service executeQuery:query completionHandler:^(GTLServiceTicket *ticket, GTLLocationendpointLocationCollection *object, NSError *error) {
        // NSArray *items = [object items];
        self.addressSearchField.text = @"";
        self.locationLabel.hidden = YES;
        [self.locationLabel resignFirstResponder];
        UIAlertView *locnAlert = [[UIAlertView alloc] initWithTitle:@"location added" message:@"the selected location has been added successfully" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:@"ok", nil];
        
        [locnAlert show];
        
        
    }];
    
    
    
    
    
    
   // [self.navigationController popViewControllerAnimated:YES];
    
}

- (GTLServiceLocationendpoint *) locationService {
    static GTLServiceLocationendpoint *service = nil;
    if (!service) {
        service = [[GTLServiceLocationendpoint alloc] init];
        
        // Have the service object set tickets to retry temporary error conditions
        // automatically
        service.retryEnabled = YES;
        
        [GTMHTTPFetcher setLoggingEnabled:YES];
    }
    return service;
}



#pragma mark-
#pragma mapviewdelegate

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker1
{
    /*marker.title = [NSString stringWithFormat:@"%f%f" , marker.position.latitude ,  marker.position.longitude];
    
    marker.snippet = @"it works";*/
    
   
    
    
    return YES;
}


- (void)mapView:(GMSMapView *)mapView didDragMarker:(GMSMarker *)mark
{
    
}

- (void)mapView:(GMSMapView *)mapView didEndDraggingMarker:(GMSMarker *)mark
{
    _selectedPosition =  mark.position;
}



-(void)allocMap
{
    self.gmapsView.settings.compassButton = YES;
    self.gmapsView.settings.myLocationButton = YES;
    firstLocationUpdate_ = NO;
    
    // Listen to the myLocation property of GMSMapView.
    [self.gmapsView addObserver:self
                     forKeyPath:@"myLocation"
                        options:NSKeyValueObservingOptionNew
                        context:NULL];
}

-(void)bringmaptoframe
{
    
    
    //self.view = self.gmapsView;
    
    // Ask for My Location data after the map has already been added to the UI.
    dispatch_async(dispatch_get_main_queue(), ^{
        self.gmapsView.myLocationEnabled = YES;
    });

}





- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (!firstLocationUpdate_) {
        // If the first location update has not yet been recieved, then jump to that
        // location.
        firstLocationUpdate_ = YES;
        CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
        self.gmapsView.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                         zoom:14];
    }

}




@end
