//
//  Response.h
//  DevconApp14
//
//  Created by ajith kumar on 8/5/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkingDelegate.h"

@interface Response : NSObject

@property (nonatomic , strong) id respData;
@property int cmdType;
@property int statusCode;
@property NSString *rawResp;
@property (nonatomic , strong) NSString *errorMsg;
@property (nonatomic , unsafe_unretained) id<NetworkingDelegate> delegate;

@end
