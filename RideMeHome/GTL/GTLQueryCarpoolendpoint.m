/* This file was generated by the ServiceGenerator.
 * The ServiceGenerator is Copyright (c) 2014 Google Inc.
 */

//
//  GTLQueryCarpoolendpoint.m
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   carpoolendpoint/v1
// Description:
//   This is an API
// Classes:
//   GTLQueryCarpoolendpoint (6 custom class methods, 5 custom properties)

#import "GTLQueryCarpoolendpoint.h"

#import "GTLCarpoolendpointCarPool.h"
#import "GTLCarpoolendpointCarPoolCollection.h"
#import "GTLCarpoolendpointCollectionResponseCarPool.h"

@implementation GTLQueryCarpoolendpoint

@dynamic cursor, driverId, fields, identifier, limit;

+ (NSDictionary *)parameterNameMap {
  NSDictionary *map =
    [NSDictionary dictionaryWithObject:@"id"
                                forKey:@"identifier"];
  return map;
}

#pragma mark -
#pragma mark "carPoolEndpoint" methods
// These create a GTLQueryCarpoolendpoint object.

+ (id)queryForCarPoolEndpointGetCarPoolByAssociateIdWithDriverId:(NSString *)driverId {
  NSString *methodName = @"carpoolendpoint.carPoolEndpoint.getCarPoolByAssociateId";
  GTLQueryCarpoolendpoint *query = [self queryWithMethodName:methodName];
  query.driverId = driverId;
  query.expectedObjectClass = [GTLCarpoolendpointCarPoolCollection class];
  return query;
}

#pragma mark -
#pragma mark Service level methods
// These create a GTLQueryCarpoolendpoint object.

+ (id)queryForGetCarPoolWithIdentifier:(long long)identifier {
  NSString *methodName = @"carpoolendpoint.getCarPool";
  GTLQueryCarpoolendpoint *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  query.expectedObjectClass = [GTLCarpoolendpointCarPool class];
  return query;
}

+ (id)queryForInsertCarPoolWithObject:(GTLCarpoolendpointCarPool *)object {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"carpoolendpoint.insertCarPool";
  GTLQueryCarpoolendpoint *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.expectedObjectClass = [GTLCarpoolendpointCarPool class];
  return query;
}

+ (id)queryForListCarPool {
  NSString *methodName = @"carpoolendpoint.listCarPool";
  GTLQueryCarpoolendpoint *query = [self queryWithMethodName:methodName];
  query.expectedObjectClass = [GTLCarpoolendpointCollectionResponseCarPool class];
  return query;
}

+ (id)queryForRemoveCarPoolWithIdentifier:(long long)identifier {
  NSString *methodName = @"carpoolendpoint.removeCarPool";
  GTLQueryCarpoolendpoint *query = [self queryWithMethodName:methodName];
  query.identifier = identifier;
  return query;
}

+ (id)queryForUpdateCarPoolWithObject:(GTLCarpoolendpointCarPool *)object {
  if (object == nil) {
    GTL_DEBUG_ASSERT(object != nil, @"%@ got a nil object", NSStringFromSelector(_cmd));
    return nil;
  }
  NSString *methodName = @"carpoolendpoint.updateCarPool";
  GTLQueryCarpoolendpoint *query = [self queryWithMethodName:methodName];
  query.bodyObject = object;
  query.expectedObjectClass = [GTLCarpoolendpointCarPool class];
  return query;
}

@end
