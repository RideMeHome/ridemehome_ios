/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2014 Google Inc.
 */

//
//  GTLLocationendpointLocation.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   locationendpoint/v1
// Description:
//   This is an API
// Classes:
//   GTLLocationendpointLocation (0 custom class methods, 6 custom properties)

#import "GTLLocationendpointLocation.h"

// ----------------------------------------------------------------------------
//
//   GTLLocationendpointLocation
//

@implementation GTLLocationendpointLocation
@dynamic associateId, descriptionProperty, identifier, latitude, longitude,
         title;

+ (NSDictionary *)propertyToJSONKeyMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObjectsAndKeys:
      @"description", @"descriptionProperty",
      @"id", @"identifier",
      nil];
  return map;
}

@end