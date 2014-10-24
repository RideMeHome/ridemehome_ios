//
//  LoginViewController.m
//  DevconApp14
//
//  Created by ajith kumar on 7/30/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeScreenViewController.h"



@interface LoginViewController ()


@end



@implementation LoginViewController
@synthesize uNameField,passwdField;

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginClicked:(id)sender {
    
    
    
    
    
    NSMutableDictionary *dictObj = [[NSMutableDictionary alloc] init ];
    [dictObj setObject:uNameField.text forKey:@"username" ];
    [dictObj setObject:passwdField.text forKey:@"password" ];
    
    
    
    [self sendLoginRequest:dictObj];
    
}

-(void)sendLoginRequest : (NSMutableDictionary *)dict
{
    Request *req = [[Request alloc] init];
    
    req.cmdType = COMMAND_LOGIN;
    
    req.url = [NSString stringWithFormat:@"%@%@" , BASE_URL , LOGIN_URL];
    
    req.reqObj = dict;
    
    req.delegate = self;
    
    req.requestType = POST_REQUEST;
    
    NetworkController *networks = [NetworkController getInstance];
    
    [networks startRequest:req];
    
    [Utilities showActivityIndicator:self.view];

}

- (IBAction)cancelClicked:(id)sender {
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LOGIN_CANCEL_TITLE message:LOGIN_CANCEL_MESSAGE delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil ];
    [alert show];
   // [self.navigationController popViewControllerAnimated:YES];
}


#pragma networkingdelegates

-(void)downloadCompleted : (Response *)resp
{
    [Utilities stopActivityIndicator];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_LOGIN object:self userInfo:(NSDictionary *)resp.respData ];
     [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)downloadFailed : (Response *)resp
{
    [Utilities stopActivityIndicator];
}

@end
