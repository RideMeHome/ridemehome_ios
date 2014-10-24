//
//  NetworkingDelegate.h
//  DevconApp14
//
//  Created by ajith kumar on 8/5/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Response;

@protocol NetworkingDelegate <NSObject>

-(void)downloadCompleted : (Response *)resp;

-(void)downloadFailed : (Response *)resp;

@optional

-(void)didDownloadImage : (UIImage *)img contex:(void*)inContext;

@end
