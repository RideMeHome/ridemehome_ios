//
//  findacarScreenViewController.h
//  RideMeHome
//
//  Created by ajith kumar on 8/17/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "Utilities.h"
#import "geocoders.h"
#import "CarSelectionScreen.h"
#import "GTLServiceCarpoolendpoint.h"
#import "GTMHTTPFetcherLogging.h"
#import "GTLCarpoolendpoint.h"


@interface findacarScreenViewController : UIViewController<GMSMapViewDelegate>
{
    BOOL firstLocationUpdate_;
    NSArray *markersArray;
    UIBarButtonItem *addItem;
    CLLocationCoordinate2D _selectedPosition;
    
    NSMutableDictionary *dict;
}

@property (strong, nonatomic) IBOutlet GMSMapView *mapView;


@property (strong, nonatomic) IBOutlet UITextField *txt_search;


- (IBAction)btn_Search:(id)sender;


@end
