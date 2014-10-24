/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2014 Google Inc.
 */

//
//  GTLLocationendpointCollectionResponseLocation.h
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   locationendpoint/v1
// Description:
//   This is an API
// Classes:
//   GTLLocationendpointCollectionResponseLocation (0 custom class methods, 2 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLLocationendpointLocation;

// ----------------------------------------------------------------------------
//
//   GTLLocationendpointCollectionResponseLocation
//

// This class supports NSFastEnumeration over its "items" property. It also
// supports -itemAtIndex: to retrieve individual objects from "items".

@interface GTLLocationendpointCollectionResponseLocation : GTLCollectionObject
@property (retain) NSArray *items;  // of GTLLocationendpointLocation
@property (copy) NSString *nextPageToken;
@end