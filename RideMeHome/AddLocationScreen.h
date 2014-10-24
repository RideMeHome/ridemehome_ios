//
//  AddLocationScreen.h
//  RideMeHome
//
//  Created by ajith kumar on 8/16/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "geocoders.h"
#import "Utilities.h"
#import "GTLLocationendpoint.h"
#import "GTMHTTPFetcherLogging.h"

@interface AddLocationScreen : UIViewController<GMSMapViewDelegate>
{
    BOOL firstLocationUpdate_;
    GMSMarker *marker;
    UIBarButtonItem *addItem;
    CLLocationCoordinate2D _selectedPosition;
    NSDictionary *newDict;
    NSMutableDictionary *dict;
}
@property (strong, nonatomic) IBOutlet GMSMapView *gmapsView;
- (IBAction)searchClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *addressSearchField;
@property (strong, nonatomic) IBOutlet UITextField *locationLabel;

@end
