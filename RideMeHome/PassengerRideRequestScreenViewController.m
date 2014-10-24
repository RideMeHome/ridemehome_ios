//
//  PassengerRideRequestScreenViewController.m
//  RideMeHome
//
//  Created by ajith kumar on 8/19/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import "PassengerRideRequestScreenViewController.h"

@interface PassengerRideRequestScreenViewController ()

@end

@implementation PassengerRideRequestScreenViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andcarpoolId : (NSNumber *)carpoolid
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        poolId = carpoolid;
        
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
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20.0f/255.0f green:20.0f/255.0f blue:20.0f/255.0f alpha:.5f]];
    
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    
    self.title =  @"Passengers";
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    self.tbl_passengerslist.delegate = self;
    self.tbl_passengerslist.dataSource = self;
   // [self getListOfPassengers];
    
    [self sendHttpReqToGetPassList];
    
    
}


-(void)getListOfPassengers
{
    
    GTLServicePassengerendpoint *service = [self locationService];
    //NSString *assoId = [[[Utilities getDataFromCache:KEY_USERDATA] objectForKey:@"username"] uppercaseString];
    
    GTLQueryPassengerendpoint *query = [GTLQueryPassengerendpoint queryForPassengerEndpointGetPassengerByCarPoolIdWithCarPoolId:[poolId longLongValue]];
    
    [service executeQuery:query completionHandler:^(GTLServiceTicket *ticket, GTLPassengerendpointPassengerCollection *object, NSError *error) {
        NSArray *items = [object items];
        
        // NSArray *myArr = (NSArray *)object;
        
        
        
    }];

    
    
}

-(void)sendHttpReqToGetPassList
{
    
    Request *req = [[Request alloc] init];
    
    req.cmdType = COMMAND_PASSENGERLIST;
    
    req.url = [NSString stringWithFormat:@"https://ride-me-home-cern.appspot.com/_ah/api/passengerendpoint/v1/Passenger/carPoolId/%@" , poolId];
    
    req.reqObj = nil;
    
    req.delegate = self;
    
    req.requestType = GET_REQUEST;
    
    NetworkController *networks = [NetworkController getInstance];
    
    [networks startRequest:req];
    
    [Utilities showActivityIndicator:self.view];
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

-(void)showMessage
{
    [self.tbl_passengerslist setHidden:YES];
    
    UILabel *msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 120)];
    msgLabel.center = self.view.center;
    
    [msgLabel setTextColor:[UIColor whiteColor]];
    msgLabel.numberOfLines = 2;
    
    [msgLabel setText:@"No passengers have sent request"];
    [self.view addSubview:msgLabel];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [passItems count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identity";
    
    passengerCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier ];
    
    if (cell == nil) {
        
        //cell = [[passengerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"passengerCell" owner:self options:nil];
        cell = (passengerCell *)[nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        [cell setBackgroundColor:[UIColor clearColor]];
    }
    NSDictionary *dict = [passItems objectAtIndex:indexPath.row];
    cell.lbl_passengerinfo.text = [self getStringForPassenger:dict];
    
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Request" message:@"Do you approve the request" delegate:self cancelButtonTitle:@"Deny" otherButtonTitles:@"Accept", nil];
    
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
    }else
    {
        
    }
}

-(NSString *)getStringForPassenger : (NSDictionary *)obj
{
    NSString *str = [NSString stringWithFormat:@"%@ has requested for a pickup from  %@" , [obj objectForKey:@"passengerId"] , [obj objectForKey:@"pickupLocation"]];
    
    return str;
    
}



#pragma networkingdelegates

-(void)downloadCompleted : (Response *)resp
{
     [Utilities stopActivityIndicator];
    NSDictionary *dict = (NSDictionary *)resp.respData;
    
    if ([dict objectForKey:@"items"] != nil ) {
        passItems = [dict objectForKey:@"items"] ;
        
        [self.tbl_passengerslist reloadData];
        
    } else
    {
        [self showMessage];
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
