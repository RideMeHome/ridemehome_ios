/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2014 Google Inc.
 */

//
//  GTLCarpoolendpointCarPool.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   carpoolendpoint/v1
// Description:
//   This is an API
// Classes:
//   GTLCarpoolendpointCarPool (0 custom class methods, 13 custom properties)

#import "GTLCarpoolendpointCarPool.h"

// ----------------------------------------------------------------------------
//
//   GTLCarpoolendpointCarPool
//

@implementation GTLCarpoolendpointCarPool
@dynamic capcaity, descriptionProperty, destinationLatitude,
         destinationLocation, destinationLongitude, driverId, driverName,
         identifier, originLatitude, originLocation, originLongitude,
         startDateTime, status;

+ (NSDictionary *)propertyToJSONKeyMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObjectsAndKeys:
      @"description", @"descriptionProperty",
      @"id", @"identifier",
      nil];
  return map;
}

@end
