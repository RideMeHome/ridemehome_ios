//
//  NetworkController.h
//  DevconApp14
//
//  Created by ajith kumar on 8/5/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "NetworkingDelegate.h"
#import "appConstants.h"
#import "Request.h"
#import "Response.h"
#import "Utilities.h"

@interface NetworkController : NSObject
{
    
}


+(instancetype)getInstance;

-(void)startRequest : (Request *)req;
-(void)downloadImageForUrl : (NSString *)urlStr forobj : (id<NetworkingDelegate>)del contex:(void*)inContext;

@end
