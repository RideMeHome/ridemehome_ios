//
//  SignUpScreen.h
//  RideMeHome
//
//  Created by ajith kumar on 8/15/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreDetailsScreen.h"
#import "userDataObj.h"

@interface SignUpScreen : UIViewController
{
    NSArray *textfields;
    NSArray *iconHolder;
}

@property (strong, nonatomic) IBOutlet UITextField *txt_fullName;

@property (strong, nonatomic) IBOutlet UITextField *txt_mobile;

@property (strong, nonatomic) IBOutlet UITextField *txt_emailId;

@property (strong, nonatomic) IBOutlet UITextField *txt_password;

@property (strong , nonatomic) userDataObj *userObj;


@end
