//
//  geocoders.h
//  RideMeHome
//
//  Created by ajith kumar on 8/16/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>


@interface geocoders : NSObject
{
    GMSGeocoder *geo;
}

+(geocoders *)getInstance;
- (CLLocationCoordinate2D) geoCodeUsingAddress:(NSString *)address;
-(NSString *)getAddressfromlat : (double)lat andlong :(double)lon;




@end
