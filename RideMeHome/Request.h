//
//  Request.h
//  DevconApp14
//
//  Created by ajith kumar on 8/5/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkingDelegate.h"

@interface Request : NSObject


@property NSDictionary *reqObj;
@property NSString *url;
@property int cmdType;
@property int requestType;
@property NSString *accessToken;
@property (nonatomic,unsafe_unretained) id<NetworkingDelegate> delegate;

@end
