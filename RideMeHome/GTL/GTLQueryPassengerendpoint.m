/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2014 Google Inc.
 */

//
//  GTLQueryPassengerendpoint.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   passengerendpoint/v1
// Description:
//   This is an API
// Classes:
//   GTLQueryPassengerendpoint (8 custom class methods, 7 custom properties)

#import "GTLQueryPassengerendpoint.h"

#import "GTLPassengerendpointCollectionResponsePassenger.h"
#import "GTLPassengerendpointPassenger.h"
#import "GTLPassengerendpointPassengerCollection.h"

@implementation GTLQueryPassengerendpoint

@dynamic carPoolId, cursor, driverId, fields, identifier, limit, passengerId;

+ (NSDictionary *)parameterNameMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObject:@"id"
                                forKey:@"identifier"];
  return map;
}

#pragma mark -
#pragma mark Service level methods
// These create a GTLQueryPassengerendpoint object.

+ (id)queryForGetPassengerWithIdentifier:(long long)identifier {
  NSString *methodName = @"passengerendpoint.getPassenger";
  GTLQueryPassengerendpoint *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  query.expectedObjectClass = [GTLPassengerendpointPassenger class];
  return query;
}

+ (id)queryForInsertPassengerWithObject:(GTLPassengerendpointPassenger *)object {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"passengerendpoint.insertPassenger";
  GTLQueryPassengerendpoint *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.expectedObjectClass = [GTLPassengerendpointPassenger class];
  return query;
}

+ (id)queryForListPassenger {
  NSString *methodName = @"passengerendpoint.listPassenger";
  GTLQueryPassengerendpoint *query = [self queryWithMethodName:methodName];
  query.expectedObjectClass = [GTLPassengerendpointCollectionResponsePassenger class];
  return query;
}

#pragma mark -
#pragma mark "passengerEndpoint" methods
// These create a GTLQueryPassengerendpoint object.

+ (id)queryForPassengerEndpointGetPassengerByCarPoolIdWithCarPoolId:(long long)carPoolId {
  NSString *methodName = @"passengerendpoint.passengerEndpoint.getPassengerByCarPoolId";
  GTLQueryPassengerendpoint *query = [self queryWithMethodName:methodName];
  query.carPoolId = carPoolId;
  query.expectedObjectClass = [GTLPassengerendpointPassengerCollection class];
  return query;
}

+ (id)queryForPassengerEndpointGetPassengerByDriverIdWithDriverId:(NSString *)driverId {
  NSString *methodName = @"passengerendpoint.passengerEndpoint.getPassengerByDriverId";
  GTLQueryPassengerendpoint *query = [self queryWithMethodName:methodName];
  query.driverId = driverId;
  query.expectedObjectClass = [GTLPassengerendpointPassengerCollection class];
  return query;
}

+ (id)queryForPassengerEndpointGetPassengerByPassengerIdWithPassengerId:(NSString *)passengerId {
  NSString *methodName = @"passengerendpoint.passengerEndpoint.getPassengerByPassengerId";
  GTLQueryPassengerendpoint *query = [self queryWithMethodName:methodName];
  query.passengerId = passengerId;
  query.expectedObjectClass = [GTLPassengerendpointPassengerCollection class];
  return query;
}

#pragma mark -
#pragma mark Service level methods
// These create a GTLQueryPassengerendpoint object.

+ (id)queryForRemovePassengerWithIdentifier:(long long)identifier {
  NSString *methodName = @"passengerendpoint.removePassenger";
  GTLQueryPassengerendpoint *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  return query;
}

+ (id)queryForUpdatePassengerWithObject:(GTLPassengerendpointPassenger *)object {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"passengerendpoint.updatePassenger";
  GTLQueryPassengerendpoint *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.expectedObjectClass = [GTLPassengerendpointPassenger class];
  return query;
}

@end