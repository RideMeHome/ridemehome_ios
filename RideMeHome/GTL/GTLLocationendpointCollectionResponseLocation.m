/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2014 Google Inc.
 */

//
//  GTLLocationendpointCollectionResponseLocation.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   locationendpoint/v1
// Description:
//   This is an API
// Classes:
//   GTLLocationendpointCollectionResponseLocation (0 custom class methods, 2 custom properties)

#import "GTLLocationendpointCollectionResponseLocation.h"

#import "GTLLocationendpointLocation.h"

// ----------------------------------------------------------------------------
//
//   GTLLocationendpointCollectionResponseLocation
//

@implementation GTLLocationendpointCollectionResponseLocation
@dynamic items, nextPageToken;

+ (NSDictionary *)arrayPropertyToClassMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObject:[GTLLocationendpointLocation class]
                                forKey:@"items"];
  return map;
}

@end