/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2014 Google Inc.
 */

//
//  GTLQueryCarpoolendpoint.h
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   carpoolendpoint/v1
// Description:
//   This is an API
// Classes:
//   GTLQueryCarpoolendpoint (6 custom class methods, 5 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLQuery.h"
#else
  #import "GTLQuery.h"
#endif

@class GTLCarpoolendpointCarPool;

@interface GTLQueryCarpoolendpoint : GTLQuery

//
// Parameters valid on all methods.
//

// Selector specifying which fields to include in a partial response.
@property (copy) NSString *fields;

//
// Method-specific parameters; see the comments below for more information.
//
@property (copy) NSString *cursor;
@property (copy) NSString *driverId;
// identifier property maps to 'id' in JSON (to avoid Objective C's 'id').
@property (assign) long long identifier;
@property (assign) NSInteger limit;

#pragma mark -
#pragma mark "carPoolEndpoint" methods
// These create a GTLQueryCarpoolendpoint object.

// Method: carpoolendpoint.carPoolEndpoint.getCarPoolByAssociateId
//  Authorization scope(s):
//   kGTLAuthScopeCarpoolendpointUserinfoEmail
// Fetches a GTLCarpoolendpointCarPoolCollection.
+ (id)queryForCarPoolEndpointGetCarPoolByAssociateIdWithDriverId:(NSString *)driverId;

#pragma mark -
#pragma mark Service level methods
// These create a GTLQueryCarpoolendpoint object.

// Method: carpoolendpoint.getCarPool
//  Authorization scope(s):
//   kGTLAuthScopeCarpoolendpointUserinfoEmail
// Fetches a GTLCarpoolendpointCarPool.
+ (id)queryForGetCarPoolWithIdentifier:(long long)identifier;

// Method: carpoolendpoint.insertCarPool
//  Authorization scope(s):
//   kGTLAuthScopeCarpoolendpointUserinfoEmail
// Fetches a GTLCarpoolendpointCarPool.
+ (id)queryForInsertCarPoolWithObject:(GTLCarpoolendpointCarPool *)object;

// Method: carpoolendpoint.listCarPool
//  Optional:
//   cursor: NSString
//   limit: NSInteger
//  Authorization scope(s):
//   kGTLAuthScopeCarpoolendpointUserinfoEmail
// Fetches a GTLCarpoolendpointCollectionResponseCarPool.
+ (id)queryForListCarPool;

// Method: carpoolendpoint.removeCarPool
//  Authorization scope(s):
//   kGTLAuthScopeCarpoolendpointUserinfoEmail
+ (id)queryForRemoveCarPoolWithIdentifier:(long long)identifier;

// Method: carpoolendpoint.updateCarPool
//  Authorization scope(s):
//   kGTLAuthScopeCarpoolendpointUserinfoEmail
// Fetches a GTLCarpoolendpointCarPool.
+ (id)queryForUpdateCarPoolWithObject:(GTLCarpoolendpointCarPool *)object;

@end