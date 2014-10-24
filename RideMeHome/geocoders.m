//
//  geocoders.m
//  RideMeHome
//
//  Created by ajith kumar on 8/16/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import "geocoders.h"
#import <GoogleMaps/GoogleMaps.h>

static geocoders *_instance;
@implementation geocoders
{
    
}




+(geocoders *)getInstance
{
    
    static dispatch_once_t ones;
    dispatch_once(&ones, ^{
    
        _instance = [[geocoders alloc] init];
    
    });
    
    return _instance;
}


- (CLLocationCoordinate2D) geoCodeUsingAddress:(NSString *)address
{
    double latitude = 0, longitude = 0;
    NSString *esc_addr =  [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude = latitude;
    center.longitude = longitude;
    return center;
}

/*
-(NSString *)getAdrressFromLatLong : (CGFloat)lat lon:(CGFloat)lon{
    
     NSString *address = nil;
    
    NSString *urlString = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&amp;sensor=false",lat,lon];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    NSURLResponse *response = nil;
    NSError *requestError = nil;
    
    NSData *respData = [NSURLConnection sendAsynchronousRequest:request queue:<#(NSOperationQueue *)#> completionHandler:<#^(NSURLResponse *response, NSData *data, NSError *connectionError)handler#>];
    
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request
                                                             error:&requestError];
    NSString *responseString = [[NSString alloc] initWithData: responseData encoding:NSUTF8StringEncoding];
    
                            NSError *error = [[NSError alloc]init];
                            id jsonObject = [NSJSONSerialization
                                             JSONObjectWithData:responseData
                                             options:NSJSONReadingAllowFragments
                                             error:&error];
                            
    //NSLog(@"responseString %@ ",[[responseString JSONValue] valueForKey:@"results"]);
    
    if ([responseString length] > 0) {
        
        if ([[jsonObject valueForKey:@"status"] isEqualToString:@"OK"] ) {
            NSLog(@"responseString %@  %@",[[jsonObject valueForKey:@"results"] objectAtIndex:0]);
            NSArray *resultsArray = [jsonObject valueForKey:@"results"];
           
            
            if ([resultsArray count] > 0) {
                address = [[resultsArray objectAtIndex:0] valueForKey:@"formatted_address"];
            }
            
            // use the address variable to access the ADDRESS :)
        } else {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle: @"error"
                                                               message: @"Location Unknown."
                                                              delegate:nil
                                                     cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
            [alertView show];
        }
    }
                            return address;
}*/

-(NSString *)getAddressfromlat : (double)lat andlong :(double)lon 
{
    
    __block NSString *locn = @"";
    [[GMSGeocoder geocoder] reverseGeocodeCoordinate:CLLocationCoordinate2DMake(lat, lon) completionHandler:^(GMSReverseGeocodeResponse* response, NSError* error) {
        NSLog(@"reverse geocoding results:");
        for(GMSAddress* addressObj in [response results])
        {
//            NSLog(@"coordinate.latitude=%f", addressObj.coordinate.latitude);
//            NSLog(@"coordinate.longitude=%f", addressObj.coordinate.longitude);
//            NSLog(@"thoroughfare=%@", addressObj.thoroughfare);
//            NSLog(@"locality=%@", addressObj.locality);
//            NSLog(@"subLocality=%@", addressObj.subLocality);
//            NSLog(@"administrativeArea=%@", addressObj.administrativeArea);
//            NSLog(@"postalCode=%@", addressObj.postalCode);
//            NSLog(@"country=%@", addressObj.country);
//            NSLog(@"lines=%@", addressObj.lines);
            
            locn = addressObj.locality;
        }
    }];
    
    return locn;
}

@end
