//
//  NetworkController.m
//  DevconApp14
//
//  Created by ajith kumar on 8/5/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import "NetworkController.h"



@implementation NetworkController
{
    
    
}



+(instancetype)getInstance
{
    static dispatch_once_t ones;
    
    static id instance;
    
    dispatch_once(&ones, ^{
    
        instance = [self new];
        
    });
    
    return instance;
}



-(void)startRequest : (Request *)req
{
    
    if (req.requestType == GET_REQUEST) {
        [self sendGetRequest:req];
    }else
    {
        [self sendPostRequest:req];
    }
    
}


-(void)sendPostRequest : (Request *)req
{
    NSString *string = req.url;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"]; [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    
    
    [manager POST:string parameters:req.reqObj success:^(AFHTTPRequestOperation *task, id responseObject) {
        
        
        
        Response *resp = [[Response alloc] init];
        resp.cmdType = req.cmdType;
       
        resp.respData = responseObject;
        resp.rawResp = responseObject;
        resp.delegate = req.delegate;
        [self dataRetrieved:resp];
        
        
        
        
    } failure:^(AFHTTPRequestOperation *task, NSError *error) {
        
        
        Response *resp = [[Response alloc] init];
        resp.cmdType = req.cmdType;
        resp.errorMsg = error.description;
        [self requestFailed:resp];
        
        
    }];

}

-(void)sendGetRequest : (Request *)req
{
    
    NSString *string = req.url;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    //[manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [manager.requestSerializer setValue:req.accessToken forHTTPHeaderField:@"accessToken"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:string parameters:req.reqObj success: ^(AFHTTPRequestOperation *task, id responseObject) {
        
        
        
        Response *resp = [[Response alloc] init];
        resp.cmdType = req.cmdType;
        
        resp.respData = responseObject;
        resp.rawResp = responseObject;
        resp.delegate = req.delegate;
        [self dataRetrieved:resp];
        
        
        
        
    } failure:^(AFHTTPRequestOperation *task, NSError *error) {
        
        
        
        Response *resp = [[Response alloc] init];
        resp.cmdType = req.cmdType;
        resp.errorMsg = error.description;
        [self requestFailed:resp];
        
        
    }];

    
}
-(void)downloadImageForUrl : (NSString *)urlStr forobj : (id<NetworkingDelegate>)del contex:(void*)inContext
{
    //urlStr = @"http://www.raywenderlich.com/wp-content/uploads/2014/01/sunny-background.png";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperationManager *operation = [AFHTTPRequestOperationManager manager];//[[AFHTTPRequestOperation alloc] initWithRequest:request];
     [operation.requestSerializer setValue:[Utilities getAccessToken] forHTTPHeaderField:@"accessToken"];
    operation.responseSerializer = [AFImageResponseSerializer serializer];
    
    /*[operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //self.backgroundImageView.image = responseObject;
        //[self saveImage:responseObject withFilename:@"background.png"];
        [self imageDownloaded:(UIImage *)responseObject fordelegate:del contex:inContext];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
    }];
    
    [operation start];*/
    
    [operation GET:urlStr parameters:nil success: ^(AFHTTPRequestOperation *task, id responseObject) {
        
        
        
       [self imageDownloaded:(UIImage *)responseObject fordelegate:del contex:inContext];
        
        
        
    } failure:^(AFHTTPRequestOperation *task, NSError *error) {
        
        
        NSLog(@"Error: %@", error);
        
        
    }];
}


-(void)imageDownloaded : (UIImage *)img fordelegate : (id)del contex:(void*)inContext
{
 
    id<NetworkingDelegate> netdel = (id<NetworkingDelegate>)del;
    if ([netdel respondsToSelector:@selector(didDownloadImage:contex:)]) {
        
        [netdel didDownloadImage:img contex:inContext];
    }
    
}

-(void)dataRetrieved : (Response *)resp
{
    id<NetworkingDelegate> netdel = resp.delegate;
    if ([netdel respondsToSelector:@selector(downloadCompleted:)]) {
        
        [netdel downloadCompleted:resp];
    }
    [netdel downloadCompleted:resp];
}
-(void)requestFailed : (Response *)resp
{
    
}


@end
