//
//  Utilities.h
//  DevconApp14
//
//  Created by ajith kumar on 8/5/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "appConstants.h"

@interface Utilities : NSObject
{
    
}



+(UIButton *)setRoundedView:(UIButton *)roundedView toDiameter:(float)newSize;

+ (UIImage *)roundedImageWithImage:(UIImage *)image;

+(NSString *)convertDictToJsonString : (NSDictionary *)dict;

+(void)showActivityIndicator : (UIView *)view;

+(void)stopActivityIndicator;

+(void)setDataToCache : (id)object forkey : (NSString *)key;

+(id)getDataFromCache : (NSString *)key;

+(void)removeCachedData : (NSString *)key;

+(BOOL)hasDataForKey : (NSString *)key;

+(NSString *)getAccessToken;

+(CGRect)getScreenFrame;

+(BOOL)isBigScreen;

+(NSString *)timeFromDate:(NSDate*)inDate andEndDate : (NSDate *)endDate;

@end
