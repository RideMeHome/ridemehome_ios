//
//  CarSelectionScreen.m
//  RideMeHome
//
//  Created by ajith kumar on 8/18/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import "CarSelectionScreen.h"

@interface CarSelectionScreen ()

@end

@implementation CarSelectionScreen



-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andUserData : (GTLCarpoolendpointCarPool *)userObj
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        myObj = userObj;
    }
    return self;
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20.0f/255.0f green:20.0f/255.0f blue:20.0f/255.0f alpha:1.0f]];
    
    
    UIBarButtonItem  *addItem = [[UIBarButtonItem alloc]  initWithTitle:@"Confirm" style:UIBarButtonItemStyleDone target:self action:@selector(sendConfirmRequest:) ];
    //[joinItem setTintColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f]];
    
    self.navigationItem.rightBarButtonItem = addItem;
    
    
    self.lbl_drivername.text = myObj.driverId;
    // self.lbl_drivermobile.text = userObj.driverId;
    
    
    self.lbl_drivertraveldetails.text = [self createDriverDetailString:myObj];


}


-(void)refreshUserData : (GTLCarpoolendpointCarPool *)userObj
{
    
    
    self.lbl_drivername.text = userObj.driverId;
   // self.lbl_drivermobile.text = userObj.driverId;
    
    
    self.lbl_drivertraveldetails.text = [self createDriverDetailString:userObj];
    
    
    
}

-(void)sendConfirmRequest : (UIBarButtonItem *)item
{
    
    NSMutableDictionary *dict = [Utilities getDataFromCache:KEY_CARPOOLSTATUS];
    if (dict != nil) {
        dict = [[NSMutableDictionary alloc] init];
    }
    
    [dict setObject:[self createString] forKey:self.lbl_drivername.text ];
    [Utilities removeCachedData:KEY_CARPOOLSTATUS];
    [Utilities setDataToCache:dict forkey:KEY_CARPOOLSTATUS];
    
     NSDictionary *userData = [Utilities getDataFromCache:KEY_USERDATA];
    GTLPassengerendpointPassenger *obj = [[GTLPassengerendpointPassenger alloc] init];
    obj.carPoolId = myObj.identifier;
    obj.capacity = [NSNumber numberWithInt:1];;
    obj.driverId =  myObj.driverId;//[[userData objectForKey:@"username"] uppercaseString];
    
    obj.pickupTime =  myObj.startDateTime;
    
    obj.status = @"REQUESTED";
    
    obj.passengerId = [[userData objectForKey:@"username"] uppercaseString];;
    obj.pickupLatitude = myObj.originLatitude;
    obj.pickupLongitude = myObj.originLongitude;
    obj.pickupLocation = myObj.originLocation;
    
    GTLServicePassengerendpoint *service = [self locationService];
    
    GTLQueryPassengerendpoint *query = [GTLQueryPassengerendpoint queryForInsertPassengerWithObject:obj];
    
    [service executeQuery:query completionHandler:^(GTLServiceTicket *ticket, GTLPassengerendpointPassengerCollection *object, NSError *error) {
        // NSArray *items = [object items];
                UIAlertView *locnAlert = [[UIAlertView alloc] initWithTitle:@"Request sent" message:@"your request has been sent successfully , the associate will get back to you. " delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:@"ok", nil];
        
        [locnAlert show];
        
        
    }];
    

    
    
    
}





- (GTLServicePassengerendpoint *) locationService {
    static GTLServicePassengerendpoint *service = nil;
    if (!service) {
        service = [[GTLServicePassengerendpoint alloc] init];
        
        // Have the service object set tickets to retry temporary error conditions
        // automatically
        service.retryEnabled = YES;
        
        [GTMHTTPFetcher setLoggingEnabled:YES];
    }
    return service;
}


-(NSString *)createDriverDetailString : (GTLCarpoolendpointCarPool *)driObj
{
    
  ///  NSString *adr1 = [[geocoders getInstance] getAddressfromlat:[driObj.originLatitude doubleValue] andlong:[driObj.originLocation doubleValue]];
    
  ///  NSString *adr2 = [[geocoders getInstance] getAddressfromlat:[driObj.destinationLatitude doubleValue] andlong:[driObj.destinationLongitude doubleValue]];
    NSString *str = [NSString stringWithFormat:@"%@ travelling from %@ to %@ at 5:30 PM with 3 seats left>" , driObj.driverId , driObj.originLocation , driObj.destinationLocation  ];
    
    return str;
}

-(NSString *)createString
{
    NSString *str = [NSString stringWithFormat:@"sent request to join %@ for a ride to %@" ,self.lbl_drivername.text , self.lbl_drivertraveldetails.text ];
    
    return str;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
