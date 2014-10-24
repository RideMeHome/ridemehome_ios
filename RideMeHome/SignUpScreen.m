//
//  SignUpScreen.m
//  RideMeHome
//
//  Created by ajith kumar on 8/15/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import "SignUpScreen.h"

@interface SignUpScreen ()

@end

@implementation SignUpScreen

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
    
    UIBarButtonItem *joinItem = [[UIBarButtonItem alloc]  initWithTitle:@"next" style:UIBarButtonItemStyleDone target:self action:@selector(showMoreDetailsScreen:) ];
    [joinItem setTintColor:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f]];
    
    self.navigationItem.rightBarButtonItem = joinItem;
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}


-(void)showMoreDetailsScreen : (UIBarButtonItem *)sender
{
    self.userObj = [[userDataObj alloc] init];
    
    self.userObj.fullName = self.txt_fullName.text;
    
    self.userObj.mobileNum = self.txt_mobile.text;
    
    self.userObj.emailId = self.txt_emailId.text;
    
    self.userObj.password = self.txt_password.text;
    
    MoreDetailsScreen *moreDetails = [[MoreDetailsScreen alloc]  initWithNibName:@"MoreDetailsScreen" bundle:nil ];
    
    moreDetails.userObj = self.userObj;
    
    [self.navigationController pushViewController:moreDetails animated:YES];
}











- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
