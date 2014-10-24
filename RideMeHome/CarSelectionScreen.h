//
//  CarSelectionScreen.h
//  RideMeHome
//
//  Created by ajith kumar on 8/18/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utilities.h"
#import "appConstants.h"
#import "geocoders.h"
#import "GTMHTTPFetcherLogging.h"
#import "GTLCarpoolendpoint.h"
#import "GTLPassengerendpoint.h"

@interface CarSelectionScreen : UIViewController
{
    GTLCarpoolendpointCarPool *myObj;
}
@property (strong, nonatomic) IBOutlet UILabel *lbl_drivername;
@property (strong, nonatomic) IBOutlet UILabel *lbl_drivermobile;
@property (strong, nonatomic) IBOutlet UILabel *lbl_driveremail;
@property (strong, nonatomic) IBOutlet UILabel *lbl_drivertraveldetails;


-(void)refreshUserData : (GTLCarpoolendpointCarPool *)userObj;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andUserData : (GTLCarpoolendpointCarPool *)userObj;

@end
