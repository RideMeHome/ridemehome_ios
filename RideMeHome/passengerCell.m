//
//  passengerCell.m
//  RideMeHome
//
//  Created by ajith kumar on 8/19/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import "passengerCell.h"

@implementation passengerCell

@synthesize lbl_passengerinfo;

- (void)awakeFromNib
{
    // Initialization code
    
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)acceptClicked:(id)sender {
    
    
}

- (IBAction)rejectClicked:(id)sender {
}
@end
