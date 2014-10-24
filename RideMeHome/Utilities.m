//
//  Utilities.m
//  DevconApp14
//
//  Created by ajith kumar on 8/5/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities
{
    
}
static UIActivityIndicatorView *indicator;

+(UIButton *)setRoundedView:(UIButton *)roundedView toDiameter:(float)newSize;
{
    CGPoint saveCenter = roundedView.center;
    CGRect newFrame = CGRectMake(roundedView.frame.origin.x, roundedView.frame.origin.y, newSize, newSize);
    roundedView.frame = newFrame;
    roundedView.layer.cornerRadius = newSize / 2.0;
    roundedView.center = saveCenter;
    
    return roundedView;
}


+ (UIImage *)roundedImageWithImage:(UIImage *)image {
    if (image) {
        CGContextRef cx = CGBitmapContextCreate(NULL, image.size.width, image.size.height, CGImageGetBitsPerComponent(image.CGImage), 0, CGImageGetColorSpace(image.CGImage), CGImageGetBitmapInfo(image.CGImage));
        
        CGContextBeginPath(cx);
        CGRect pathRect = CGRectMake(0, 0, image.size.width, image.size.height);
        CGContextAddEllipseInRect(cx, pathRect);
        CGContextClosePath(cx);
        CGContextClip(cx);
        
        CGContextDrawImage(cx, CGRectMake(0, 0, image.size.width, image.size.height), image.CGImage);
        
        CGImageRef clippedImage = CGBitmapContextCreateImage(cx);
        CGContextRelease(cx);
        
        UIImage *roundedImage = [UIImage imageWithCGImage:clippedImage];
        CGImageRelease(clippedImage);
        
        return roundedImage;
    }
    
    return nil;
}


+(NSString *)convertDictToJsonString : (NSDictionary *)dict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString* aStr = @"";
    aStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return aStr;
}


+(void)setDataToCache : (id)object forkey : (NSString *)key
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];  //load NSUserDefaults
   
    [prefs setObject:object forKey:key];
    
    [prefs synchronize];
    
}

+(id)getDataFromCache : (NSString *)key
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ([prefs objectForKey:key] != nil) {
        return [prefs objectForKey:key];
    }
    return nil;
}

+(BOOL)hasDataForKey : (NSString *)key 
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ([prefs objectForKey:key] != nil) {
        return YES;
    }
    return NO;
}

+(void)removeCachedData : (NSString *)key
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ([prefs objectForKey:key] != nil) {
        [prefs removeObjectForKey:key];
        [prefs synchronize];
    }

}





+(NSString *)timeFromDate:(NSDate*)inDate andEndDate : (NSDate *)endDate
{
	static NSDateFormatter *dateFormatter = nil;
	if (!dateFormatter) {
		dateFormatter = [[NSDateFormatter alloc] init];
	}
	/*[dateFormatter setLocale:[NSLocale currentLocale]];
	[dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setTimeStyle:NSDateFormatterFullStyle];*/
    //[dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setLocale:[NSLocale currentLocale]];
	[dateFormatter setDateFormat:@"hh:mm a"];
    
    
    
	NSString *dateString = [NSString stringWithFormat:@"%@ - %@" ,[dateFormatter stringFromDate:inDate] , [dateFormatter stringFromDate:endDate] ];
    //	DebugLog(@"dateString =%@",dateString);
    
	return dateString;
}

+(void)showActivityIndicator : (UIView *)view
{
    if (indicator == nil) {
        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    
    indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    indicator.center = view.center;
    [view addSubview:indicator];
    [indicator bringSubviewToFront:view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    
    [indicator startAnimating];
}

+(NSString *)getAccessToken
{
   NSDictionary *dict = [Utilities getDataFromCache:KEY_USERDATA];
    if (dict!= nil) {
        return [dict objectForKey:@"accessToken"];
    }
    return nil;//@"wNZASHEvUGUctFARGPaggoiVlqlSLFlfNrGOvUATdeCvWCiFVb";
}

+(CGRect)getScreenFrame
{
    return [[UIScreen mainScreen] bounds];
}

+(BOOL)isBigScreen
{
    if([UIScreen mainScreen].bounds.size.height == 568){
        // iPhone retina-4 inch
        
        return YES;
        
    } else{
        // iPhone retina-3.5 inch
        return NO;
    }
}

+(void)stopActivityIndicator
{
    [indicator stopAnimating];
    
}


@end
