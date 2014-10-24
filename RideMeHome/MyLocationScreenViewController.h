//
//  MyLocationScreenViewController.h
//  RideMeHome
//
//  Created by ajith kumar on 8/16/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utilities.h"
#import "GTLLocationendpoint.h"
#import "GTMHTTPFetcherLogging.h"

@interface MyLocationScreenViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSDictionary *savedLocn;
    NSArray *keysValue;
}
@property (strong, nonatomic) IBOutlet UITableView *savedlocnTableView;

@end
