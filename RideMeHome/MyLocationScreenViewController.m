//
//  MyLocationScreenViewController.m
//  RideMeHome
//
//  Created by ajith kumar on 8/16/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import "MyLocationScreenViewController.h"

@interface MyLocationScreenViewController ()

@end

@implementation MyLocationScreenViewController

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
    
    self.savedlocnTableView.delegate = self;
    self.savedlocnTableView.dataSource = self;
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20.0f/255.0f green:20.0f/255.0f blue:20.0f/255.0f alpha:.5f]];
    
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    
    self.title =  @"My Locations";
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    /*if ([Utilities getDataFromCache:KEY_LOCATIONDATA] == nil) {
        [self getLocationData];
    }else
    [self readData];*/
    
    [self getLocationData];
    
}

-(void)getLocationData
{
    
    GTLServiceLocationendpoint *service = [self locationService];
    
    NSString *assoId = [[[Utilities getDataFromCache:KEY_USERDATA] objectForKey:@"username"] uppercaseString];
    
    GTLQueryLocationendpoint *query = [GTLQueryLocationendpoint queryForLocationEndpointGetLocationByAssoicateIdWithAssociateId:assoId];
    
    [service executeQuery:query completionHandler:^(GTLServiceTicket *ticket, GTLLocationendpointLocationCollection *object, NSError *error) {
        // NSArray *items = [object items];
        
        NSArray *values = (NSArray *)object;
        NSMutableDictionary *dict = [[Utilities getDataFromCache:KEY_LOCATIONDATA] mutableCopy];
        if (dict == nil) {
            dict = [[NSMutableDictionary alloc] init];
        }

        
        for (GTLLocationendpointLocation *data in values) {
            
        
       // GTLLocationendpointLocation *data = (GTLLocationendpointLocation *)object;
        
        
            
        NSDictionary *mydict = @{@"lat":data.latitude , @"lon" : data.longitude};
        [dict setObject:mydict forKey:data.title];
            
        }
        
        [Utilities setDataToCache:dict forkey:KEY_LOCATIONDATA];
        
        [self readData];
        
    }];

    
}

- (GTLServiceLocationendpoint *) locationService {
    static GTLServiceLocationendpoint *service = nil;
    if (!service) {
        service = [[GTLServiceLocationendpoint alloc] init];
        
        // Have the service object set tickets to retry temporary error conditions
        // automatically
        service.retryEnabled = YES;
        
        [GTMHTTPFetcher setLoggingEnabled:YES];
    }
    return service;
}


-(void)readData
{
    savedLocn = [Utilities getDataFromCache:KEY_LOCATIONDATA];
    keysValue = [savedLocn allKeys];
    [self.savedlocnTableView reloadData];
}

-(void)deleteData : (NSString *)key
{
    NSMutableDictionary *locndict = [Utilities getDataFromCache:KEY_LOCATIONDATA];
    [locndict removeObjectForKey:key];
    [Utilities setDataToCache:locndict forkey:KEY_LOCATIONDATA];
   // [Utilities removeCachedData:key];
    [self readData];
    [self.savedlocnTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [savedLocn count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    cell.textLabel.text = [keysValue objectAtIndex:indexPath.row];
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        
        [self deleteData:[keysValue objectAtIndex:indexPath.row]];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
