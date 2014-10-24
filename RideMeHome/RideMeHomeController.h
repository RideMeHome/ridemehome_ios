//
//  RideMeHomeController.h
//  RideMeHome
//
//  Created by ajith kumar on 8/15/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignUpViewController.h"
#import "AddLocationScreen.h"
#import "MyLocationScreenViewController.h"
#import "CarPoolViewController.h"
#import "findacarScreenViewController.h"
#import "MyRequestsScreen.h"

@interface RideMeHomeController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *optionData;
}


- (IBAction)openCloseDrawer:(id)sender;





@property (strong, nonatomic) IBOutlet UIView *leftView;

@property (strong, nonatomic) IBOutlet UIImageView *profileImgView;

@property (strong, nonatomic) IBOutlet UIButton *loginClicked;

@property (strong, nonatomic) IBOutlet UITableView *rideOptionTableView;



@end
