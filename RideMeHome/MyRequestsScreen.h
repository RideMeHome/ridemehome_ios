//
//  MyRequestsScreen.h
//  RideMeHome
//
//  Created by ajith kumar on 8/18/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utilities.h"
#import "RequestCell.h"
#import "GTMHTTPFetcherLogging.h"
#import "GTLPassengerendpoint.h"
#import "NetworkController.h"
#import "GTLServiceCarpoolendpoint.h"
#import "GTMHTTPFetcherLogging.h"
#import "GTLCarpoolendpoint.h"
#import "PassengerRideRequestScreenViewController.h"

@interface MyRequestsScreen : UIViewController<UITableViewDataSource,UITableViewDelegate,NetworkingDelegate>
{
    NSMutableDictionary *requestsDict;
    NSArray *allDrivers;
    int type;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andscreenType : (int)sctype;
@property (strong, nonatomic) IBOutlet UITableView *tbl_myRequests;


@end
