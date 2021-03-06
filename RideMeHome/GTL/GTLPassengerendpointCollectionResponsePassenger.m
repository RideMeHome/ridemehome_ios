/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2014 Google Inc.
 */

//
//  GTLPassengerendpointCollectionResponsePassenger.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   passengerendpoint/v1
// Description:
//   This is an API
// Classes:
//   GTLPassengerendpointCollectionResponsePassenger (0 custom class methods, 2 custom properties)

#import "GTLPassengerendpointCollectionResponsePassenger.h"

#import "GTLPassengerendpointPassenger.h"

// ----------------------------------------------------------------------------
//
//   GTLPassengerendpointCollectionResponsePassenger
//

@implementation GTLPassengerendpointCollectionResponsePassenger
@dynamic items, nextPageToken;

+ (NSDictionary *)arrayPropertyToClassMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObject:[GTLPassengerendpointPassenger class]
                                forKey:@"items"];
  return map;
}

@end
