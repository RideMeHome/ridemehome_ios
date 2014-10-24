//
//  MyRequestsScreen.m
//  RideMeHome
//
//  Created by ajith kumar on 8/18/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import "MyRequestsScreen.h"

@interface MyRequestsScreen ()

@end

@implementation MyRequestsScreen


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andscreenType : (int)sctype
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        type = sctype;
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
    
    // requestsDict = [Utilities getDataFromCache:KEY_CARPOOLSTATUS];
    // allDrivers = [requestsDict allKeys];
    
    //[self refreshMyRequests];
    
    self.tbl_myRequests.delegate = self;
    self.tbl_myRequests.dataSource = self;
    
    
    if (type == 2 ) {
        [self sendHttpRequestforPassenger];
    }
    else{
        [self sendHttpRequestforDriver];
    }
    
    
}


-(void)sendHttpRequestforDriver
{
    
    GTLServiceCarpoolendpoint *service = [self locationService];
    NSString *assoId = [[[Utilities getDataFromCache:KEY_USERDATA] objectForKey:@"username"] uppercaseString];
    
    GTLQueryCarpoolendpoint *query = [GTLQueryCarpoolendpoint queryForCarPoolEndpointGetCarPoolByAssociateIdWithDriverId:assoId];
    
    [service executeQuery:query completionHandler:^(GTLServiceTicket *ticket, GTLCarpoolendpointCarPoolCollection *object, NSError *error) {
        NSArray *items = [object items];
        
        // NSArray *myArr = (NSArray *)object;
        
        
        allDrivers = items;
        [self.tbl_myRequests reloadData];
        
    }];
    
}



- (GTLServiceCarpoolendpoint *) locationService {
    static GTLServiceCarpoolendpoint *service = nil;
    if (!service) {
        service = [[GTLServiceCarpoolendpoint alloc] init];
        
        // Have the service object set tickets to retry temporary error conditions
        // automatically
        service.retryEnabled = YES;
        
        [GTMHTTPFetcher setLoggingEnabled:YES];
    }
    return service;
}

-(void)sendHttpRequestforPassenger
{
    
    NSString *assoId = [[[Utilities getDataFromCache:KEY_USERDATA] objectForKey:@"username"] uppercaseString];
    
    
    
    Request *req = [[Request alloc] init];
    
    req.cmdType = COMMAND_MYREQUESTS;
    
    req.url = [NSString stringWithFormat:@"https://ride-me-home-cern.appspot.com/_ah/api/passengerendpoint/v1/Passenger/passengerId/%@" , assoId];
    
    req.reqObj = nil;
    
    req.delegate = self;
    
    req.requestType = GET_REQUEST;
    
    NetworkController *networks = [NetworkController getInstance];
    
    [networks startRequest:req];
    
    [Utilities showActivityIndicator:self.view];
    
    
}

-(void)refreshMyRequests
{
    
    
    if (type == 2) {
        
        
        GTLServicePassengerendpoint *service = [self passengerRequestService];
        
        NSString *assoId = [[[Utilities getDataFromCache:KEY_USERDATA] objectForKey:@"username"] uppercaseString];
        
        GTLQueryPassengerendpoint *query = [GTLQueryPassengerendpoint queryForPassengerEndpointGetPassengerByPassengerIdWithPassengerId:assoId];
        
        [service executeQuery:query completionHandler:^(GTLServiceTicket *ticket, GTLPassengerendpointPassengerCollection *object, NSError *error) {
            // NSArray *items = [object items];
            
            allDrivers = (NSArray *)object;
            /*NSMutableDictionary *dict = [[Utilities getDataFromCache:KEY_LOCATIONDATA] mutableCopy];
             if (dict == nil) {
             dict = [[NSMutableDictionary alloc] init];
             }*/
            
            [self.tbl_myRequests reloadData];
            
            
            
            
        }];
        
        
        
        
    }else
    {
        
        
        
        GTLServicePassengerendpoint *service = [self passengerRequestService];
        
        NSString *assoId = [[[Utilities getDataFromCache:KEY_USERDATA] objectForKey:@"username"] uppercaseString];
        
        // GTLQueryPassengerendpoint *query = [GTLQueryPassengerendpoint queryForPassengerEndpointGetPassengerByDriverIdWithDriverId:assoId];
        
        GTLQueryPassengerendpoint *query = [GTLQueryPassengerendpoint queryForPassengerEndpointGetPassengerByCarPoolIdWithCarPoolId:5700305828184064];
        
        [service executeQuery:query completionHandler:^(GTLServiceTicket *ticket, GTLPassengerendpointPassengerCollection *object, NSError *error) {
            // NSArray *items = [object items];
            
            allDrivers = (NSArray *)object;
            /*NSMutableDictionary *dict = [[Utilities getDataFromCache:KEY_LOCATIONDATA] mutableCopy];
             if (dict == nil) {
             dict = [[NSMutableDictionary alloc] init];
             }*/
            
            for (GTLPassengerendpointPassenger *end in allDrivers) {
                
            }
            
            [self.tbl_myRequests reloadData];
            
            
            
            
        }];
        
        
        
        
    }
}





- (GTLServicePassengerendpoint *) passengerRequestService {
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [allDrivers count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    
    UITableViewCell *reqCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (reqCell == nil) {
        
        reqCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    
    if (type == 2) {
        NSDictionary *passenger = [allDrivers objectAtIndex:indexPath.row];
        reqCell.textLabel.text = [NSString stringWithFormat:@"%@    status :REQUESTED" , [passenger objectForKey:@"driverId"]];//[requestsDict objectForKey:[allDrivers objectAtIndex:indexPath.row]];
        [reqCell setBackgroundColor:[UIColor clearColor]];
        [reqCell.textLabel setTextColor:[UIColor whiteColor]];
        
        
        
    } else
    {
        GTLCarpoolendpointCarPool *drivedata = [allDrivers objectAtIndex:indexPath.row];
        reqCell.textLabel.text = [self getMyRideString:drivedata];//drivedata.destinationLocation;
        reqCell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
        reqCell.textLabel.numberOfLines = 2;
        [reqCell.textLabel setTextColor:[UIColor whiteColor]];
        [reqCell.textLabel setBackgroundColor:[UIColor clearColor]];
        [reqCell setBackgroundColor:[UIColor clearColor]];
        
        /*UIView *v = [[UIView alloc] initWithFrame:CGRectMake(reqCell.frame.origin.x  , reqCell.frame.origin.y + 1, reqCell.frame.size.width, reqCell.frame.size.height - 2)];
        [v setBackgroundColor:[UIColor clearColor]];
        UIView *topSelectedBackgroundSeparator = [[UIView alloc] initWithFrame:CGRectMake(tableView.separatorInset.left, 0, reqCell.frame.size.width - tableView.separatorInset.left, 1)];
        UIView *selectedBackgroundSeparator = [[UIView alloc] initWithFrame:CGRectOffset(topSelectedBackgroundSeparator.frame, 0, reqCell.frame.size.height)];
        
        topSelectedBackgroundSeparator.backgroundColor = selectedBackgroundSeparator.backgroundColor = tableView.separatorColor;
        
        [v addSubview:selectedBackgroundSeparator];
        [v addSubview:topSelectedBackgroundSeparator];

        reqCell.selectedBackgroundView = v;*/
        
        
    }
    
    
    //reqCell.lbl_status.text = [passenger objectForKey:@"id"];
    
    return reqCell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (type == 2) {
        
    }else
    {
        GTLCarpoolendpointCarPool *drivedata = [allDrivers objectAtIndex:indexPath.row];
        [self showPassengerList:drivedata];
        
    }
}

-(void)showPassengerList : (GTLCarpoolendpointCarPool *)data
{
    PassengerRideRequestScreenViewController *passenger = [[PassengerRideRequestScreenViewController alloc] initWithNibName:@"PassengerRideRequestScreenViewController" bundle:nil andcarpoolId:data.identifier];
    
    [self.navigationController pushViewController:passenger animated:YES];
}

-(NSString *)getMyRideString : (GTLCarpoolendpointCarPool *)drivData
{
    
    NSString *str = [NSString stringWithFormat:@"i have registered for a drive from %@ to %@",drivData.originLocation , drivData.destinationLocation];
    
    return str;
}


#pragma networkingdelegates

-(void)downloadCompleted : (Response *)resp
{
    NSDictionary *dict = (NSDictionary *)resp.respData;
    
    if ([dict objectForKey:@"items"] != nil ) {
        NSArray *values = [dict objectForKey:@"items"] ;
        allDrivers = values;
        [self.tbl_myRequests reloadData];
    }
    
}
-(void)downloadFailed : (Response *)resp
{
    [Utilities stopActivityIndicator];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
