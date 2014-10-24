//
//  SignUpViewController.m
//  RideMeHome
//
//  Created by ajith kumar on 8/15/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

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
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showSignUp:(id)sender {
    
    [self.navigationController.navigationBar setHidden:NO];
    SignUpScreen *signup = [[SignUpScreen alloc] initWithNibName:@"SignUpScreen" bundle:nil];
    [self.navigationController pushViewController:signup animated:YES];
}

- (IBAction)showLogin:(id)sender {
    
    
    LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:login animated:YES];
}
@end
