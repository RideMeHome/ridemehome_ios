//
//  passengerCell.h
//  RideMeHome
//
//  Created by ajith kumar on 8/19/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface passengerCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lbl_passengerinfo;
- (IBAction)acceptClicked:(id)sender;
- (IBAction)rejectClicked:(id)sender;

@end
