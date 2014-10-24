//
//  CarPoolViewController.h
//  RideMeHome
//
//  Created by ajith kumar on 8/16/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utilities.h"
#import "GTLServiceCarpoolendpoint.h"
#import "GTMHTTPFetcherLogging.h"
#import "GTLCarpoolendpoint.h"

@interface CarPoolViewController : UIViewController<UIActionSheetDelegate>
{
    NSArray *locationlbls;
    UIDatePicker *datePicker;
    NSDateFormatter *dateFormatter;
    
    UIActionSheet *actionsheet1;
    UIActionSheet *actionsheet0;
    
    double lat,lon;
}
@property (strong, nonatomic) IBOutlet UITextField *txt_noseats;

@property (strong, nonatomic) IBOutlet UITextField *txt_carmodel;
@property (strong, nonatomic) IBOutlet UILabel *lbl_locnSelected;
@property (strong, nonatomic) IBOutlet UILabel *lbl_locationreached;

@property (strong, nonatomic) IBOutlet UIView *datePickerHolder;

@property (strong, nonatomic) IBOutlet UIButton *btn_dateselected;


- (IBAction)addLocnBtn:(id)sender;

- (IBAction)showDatePicker:(id)sender;
- (IBAction)addDestLocn:(id)sender;

@end
