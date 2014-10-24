//
//  LoginViewController.h
//  DevconApp14
//
//  Created by ajith kumar on 7/30/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Request.h"
#import "Utilities.h"
#import "appConstants.h"
#import "NetworkController.h"


@interface LoginViewController : UIViewController<NetworkingDelegate>
- (IBAction)loginClicked:(id)sender;
- (IBAction)cancelClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *uNameField;
@property (strong, nonatomic) IBOutlet UITextField *passwdField;

@end
