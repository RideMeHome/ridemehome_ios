//
//  MoreDetailsScreen.m
//  RideMeHome
//
//  Created by ajith kumar on 8/17/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import "MoreDetailsScreen.h"

@interface MoreDetailsScreen ()
{
    NSArray *musicGenre;
    UIActionSheet *myactionsheet;
}

@end

@implementation MoreDetailsScreen

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
    
    UIBarButtonItem *joinItem = [[UIBarButtonItem alloc]  initWithTitle:@"join" style:UIBarButtonItemStyleDone target:self action:@selector(registerUser:) ];
    [joinItem setTintColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f]];
    
    self.navigationItem.rightBarButtonItem = joinItem;
    
    musicGenre = @[@"no music selected",@"Indian Classical" , @"Hindi" , @"Kannada",@"Rock" , @"Blues" , @"Metal" , @"Hip-Hop" , @"Rap" , @"Jazz"];
    
    
    
}


-(void)registerUser : (UIBarButtonItem *)item
{
    
    self.userObj.carmodel = self.txt_carmodel.text;
    
    self.userObj.cernerteam = self.txt_cernTeam.text;
    
    self.userObj.cernerassoId = self.txt_assoId.text;
    
    self.userObj.musicGenre = self.lbl_genre.text;
    
    
    
    NSMutableDictionary *userDict = [[NSMutableDictionary alloc] init];
    
    [userDict setObject:self.userObj.fullName forKey:@"fullname"];
    
    [userDict setObject:self.userObj.mobileNum forKey:@"mobile"];
    
    [userDict setObject:self.userObj.emailId forKey:@"email"];
    
    [userDict setObject:self.userObj.password forKey:@"password"];
    
    [userDict setObject:self.userObj.carmodel forKey:@"carmodel"];
    
    [userDict setObject:self.userObj.cernerteam forKey:@"cernteam"];
    
    [userDict setObject:self.userObj.cernerassoId forKey:@"username"];
    
    [userDict setObject:self.userObj.musicGenre forKey:@"genre"];
    
    
    
    
    
    GTLAssociateendpointAssociate *obj = [[GTLAssociateendpointAssociate alloc] init];
    obj.name = self.userObj.fullName;
    obj.mobile = self.userObj.mobileNum;
    obj.cernerId = self.userObj.cernerassoId;
    obj.email = self.userObj.emailId;
    obj.cernerTeam = self.userObj.cernerteam;
    obj.vehicleModel = self.userObj.carmodel;
    GTLServiceAssociateendpoint *service = [self associateservice];
    
    GTLQueryAssociateendpoint *query = [GTLQueryAssociateendpoint queryForInsertAssociateWithObject:obj];
    
    [service executeQuery:query completionHandler:^(GTLServiceTicket *ticket, GTLAssociateendpointCollectionResponseAssociate *object, NSError *error) {
       // NSArray *items = [object items];
        
        [Utilities setDataToCache:userDict forkey:KEY_USERDATA];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }];
    
    
    //NSArray *controllers = [self.navigationController viewControllers];
    
    
    
   // [];
    
    
}


- (GTLServiceAssociateendpoint *) associateservice {
    static GTLServiceAssociateendpoint *service = nil;
    if (!service) {
        service = [[GTLServiceAssociateendpoint alloc] init];
        
        // Have the service object set tickets to retry temporary error conditions
        // automatically
        service.retryEnabled = YES;
        
        [GTMHTTPFetcher setLoggingEnabled:YES];
    }
    return service;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.lbl_genre.text = [musicGenre objectAtIndex:buttonIndex ];
    [myactionsheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
    
}
- (IBAction)addButtonClicked:(id)sender {
    
    
    
    
    myactionsheet = [[UIActionSheet alloc]  initWithTitle:@"select a music genre" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:nil, nil ];
    
    for (NSString *value in musicGenre) {
        [myactionsheet addButtonWithTitle:value];
    }
    
    
    [myactionsheet showInView:[UIApplication sharedApplication].keyWindow];
    
}
@end
