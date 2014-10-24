//
//  PassengerRideRequestScreenViewController.h
//  RideMeHome
//
//  Created by ajith kumar on 8/19/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTMHTTPFetcherLogging.h"
#import "GTLPassengerendpoint.h"
#import "Utilities.h"
#import "Request.h"
#import "NetworkController.h"
#import "passengerCell.h"

@interface PassengerRideRequestScreenViewController : UIViewController<UITableViewDataSource,UITableViewDelegate , NetworkingDelegate ,UIAlertViewDelegate>
{
    NSNumber *poolId;
    NSArray *passItems;
}

@property (strong, nonatomic) IBOutlet UITableView *tbl_passengerslist;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andcarpoolId : (NSNumber *)carpoolid;
@end
