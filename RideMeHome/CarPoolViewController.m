//
//  CarPoolViewController.m
//  RideMeHome
//
//  Created by ajith kumar on 8/16/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import "CarPoolViewController.h"

@interface CarPoolViewController ()

@end

@implementation CarPoolViewController

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
    
    self.title =  @"Register for the pool";
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"hh:mm a"];
    //[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc]  initWithTitle:@"Register" style:UIBarButtonItemStyleDone target:self action:@selector(registerIntoPool:) ];
    //[joinItem setTintColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f]];
    
    self.navigationItem.rightBarButtonItem = addItem;
    
    
    
}

-(void)registerIntoPool : (UIBarButtonItem *)item
{
    NSString *key = self.lbl_locnSelected.text;
    NSDictionary *userData = [Utilities getDataFromCache:KEY_USERDATA];
    NSDictionary *locnInfo =  [(NSMutableDictionary *) [Utilities getDataFromCache:KEY_LOCATIONDATA]objectForKey:key];
    
    lat = [[locnInfo objectForKey:@"lat"] doubleValue];
    lon = [[locnInfo objectForKey:@"lon"] doubleValue];
    
    
    GTLCarpoolendpointCarPool *obj = [[GTLCarpoolendpointCarPool alloc] init];
    obj.driverId = [[userData objectForKey:@"username"] uppercaseString];
    obj.originLatitude = [NSNumber numberWithDouble:lat];
    obj.originLongitude = [NSNumber numberWithDouble:lon];
    obj.originLocation = key;
    
    key = self.lbl_locationreached.text;
    locnInfo =  [(NSMutableDictionary *) [Utilities getDataFromCache:KEY_LOCATIONDATA]objectForKey:key];
    lat = [[locnInfo objectForKey:@"lat"] doubleValue];
    lon = [[locnInfo objectForKey:@"lon"] doubleValue];
    obj.destinationLatitude = [NSNumber numberWithDouble:lat];
    obj.destinationLongitude = [NSNumber numberWithDouble:lon];
    obj.destinationLocation = key;
    
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    obj.capcaity = [f numberFromString:self.txt_noseats.text];
    
    obj.startDateTime = [GTLDateTime dateTimeWithDate:datePicker.date timeZone:NSTimeZoneNameStyleStandard];
    
    GTLServiceCarpoolendpoint *service = [self locationService];
    
    GTLQueryCarpoolendpoint *query = [GTLQueryCarpoolendpoint queryForInsertCarPoolWithObject:obj];
    
    [service executeQuery:query completionHandler:^(GTLServiceTicket *ticket, GTLCarpoolendpointCarPoolCollection *object, NSError *error) {
        // NSArray *items = [object items];
        
        UIAlertView *locnAlert = [[UIAlertView alloc] initWithTitle:@"carpool added" message:@"successfully added your drive to the pool" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:@"ok", nil];
        
        [locnAlert show];
    }];

    
    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addLocnBtn:(id)sender {
    
    
    if (actionsheet0 == nil) {
        
    
    actionsheet0 = [[UIActionSheet alloc]  initWithTitle:@"select a location" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:nil, nil ];
    
    NSMutableDictionary *locations = [Utilities getDataFromCache:KEY_LOCATIONDATA];
    
    locationlbls = [locations allKeys];
    
    for (NSString *value in locationlbls) {
        [actionsheet0 addButtonWithTitle:value];
    }
    
    }
    
    [actionsheet0 showInView:[UIApplication sharedApplication].keyWindow];
    
}

- (IBAction)showDatePicker:(id)sender {
    
    [self.txt_carmodel resignFirstResponder];
    [self.txt_noseats resignFirstResponder];
    if(datePicker == nil){
        datePicker = [[UIDatePicker alloc] init];
        //set the action method that will listen for changes to picker value
        [datePicker addTarget:self
                              action:@selector(dateSelected:)
                    forControlEvents:UIControlEventValueChanged];
        
        datePicker.datePickerMode = UIDatePickerModeTime;
        [self.datePickerHolder setHidden:NO];
        
        [self.datePickerHolder addSubview:datePicker];
    }
    
    
    
    
}

- (IBAction)addDestLocn:(id)sender {
    
    
    if (actionsheet1 == nil) {
        
   
    actionsheet1 = [[UIActionSheet alloc]  initWithTitle:@"select a location" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:nil, nil ];
    
    NSMutableDictionary *locations = [Utilities getDataFromCache:KEY_LOCATIONDATA];
    
    locationlbls = [locations allKeys];
    
    for (NSString *value in locationlbls) {
        [actionsheet1 addButtonWithTitle:value];
    }
    
    }
    
    [actionsheet1 showInView:[UIApplication sharedApplication].keyWindow];
}

- (void) dateSelected:(id)sender
{
    NSDate *_date = datePicker.date;
    self.btn_dateselected.titleLabel.text = [dateFormatter stringFromDate:_date];
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


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0) {
        
        if (actionSheet == actionsheet0) {
            self.lbl_locnSelected.text = [locationlbls objectAtIndex:buttonIndex -1 ];
        }else
            self.lbl_locationreached.text = [locationlbls objectAtIndex:buttonIndex -1 ];
        
    }
   
    [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
}


@end
