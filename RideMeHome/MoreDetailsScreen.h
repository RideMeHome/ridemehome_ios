//
//  MoreDetailsScreen.h
//  RideMeHome
//
//  Created by ajith kumar on 8/17/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userDataObj.h"
#import "Utilities.h"
#import "GTLAssociateendpoint.h"
#import "GTMHTTPFetcherLogging.h"
#import "GTLQueryAssociateendpoint.h"
#import "GTLAssociateendpointAssociate.h"

@interface MoreDetailsScreen : UIViewController<UIActionSheetDelegate>
{
   

}

@property (strong, nonatomic) IBOutlet UITextField *txt_carmodel;

@property (strong, nonatomic) IBOutlet UITextField *txt_cernTeam;

@property (strong, nonatomic) IBOutlet UITextField *txt_assoId;

@property (strong, nonatomic) IBOutlet UILabel *lbl_genre;

@property (strong , nonatomic) userDataObj *userObj;

- (IBAction)addButtonClicked:(id)sender;

 - (GTLServiceAssociateendpoint *)associateservice;

@end
