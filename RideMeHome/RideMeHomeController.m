//
//  RideMeHomeController.m
//  RideMeHome
//
//  Created by ajith kumar on 8/15/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import "RideMeHomeController.h"

@interface RideMeHomeController ()

#define kMenuAnimationDuration 0.5

@end

@implementation RideMeHomeController

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
    
    if (![Utilities hasDataForKey:KEY_USERDATA]) {
        [self showSignUpScreen];
        //return;
    }
   
    [self buildLeftView];
    self.rideOptionTableView.delegate = self;
    self.rideOptionTableView.dataSource = self;
    
    
    optionData = @[@"find a car" , @"carpool" , @"add a Location" , @"my locations" , @"my pools" , @"my requests" , @"LogOut" ];
    [self.rideOptionTableView setBackgroundColor:[UIColor clearColor]];
    [self.rideOptionTableView reloadData];
    
}



-(void)buildLeftView
{
    self.leftView.frame = CGRectMake(-self.leftView.frame.size.width - 80, 60, self.leftView.frame.size.width, self.view.frame.size.height);
}







-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}

/*- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)] ;
    
        [headerView setBackgroundColor:[UIColor clearColor]];
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [optionData count];
}*/


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [optionData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier = @"identity";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier ];
        
    }
   // [cell setBackgroundColor:[UIColor colorWithRed:32.0f/255.0f green:32.0f/255.0f blue:32.0f/255.0f alpha:0.5f]];
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.textLabel.text = [optionData objectAtIndex:indexPath.row];
    cell.tag = indexPath.row + 1;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0];
    cell.textLabel.textColor = [UIColor whiteColor];
    UIView *v = [[UIView alloc] initWithFrame:cell.frame];
    [v setBackgroundColor:[UIColor clearColor]];
    cell.selectedBackgroundView = v;
    
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self showRespectiveScreens:indexPath.row];
}




-(void)showRespectiveScreens : (int)indx
{
    indx = indx + 1;
    switch (indx) {
            
        case 1:
            [self showFindCarScreen];
            break;
            
        case 2 :
            [self showCarPoolScreen];
            break;
            
        case 3:
            
            [self showAddLocationScreen];
            break;
            
        case 4:
            [self showAllSavedLocations];
            
            break;
            
        case 5:
            [self showMyRequestsScreen:1];
            break;
            
        case 6:
            [self showMyRequestsScreen:2];
            break;
            
        case 7:
            [self logout];
            break;
            
        default:
            break;
    }
}


-(void)showFindCarScreen
{
    findacarScreenViewController *findcar = [[findacarScreenViewController alloc] initWithNibName:@"findacarScreenViewController" bundle:nil];
    [self.navigationController pushViewController:findcar animated:YES];
    
}
-(void)showCarPoolScreen
{
    
    CarPoolViewController *carpool = [[CarPoolViewController alloc] initWithNibName:@"CarPoolViewController" bundle:nil];
    [self.navigationController pushViewController:carpool animated:YES];
    
}

-(void)showAllSavedLocations
{
    MyLocationScreenViewController *mylocn = [[MyLocationScreenViewController alloc] initWithNibName:@"MyLocationScreenViewController" bundle:nil];
    
    [self.navigationController pushViewController:mylocn animated:YES];
}

-(void)showAddLocationScreen
{
    AddLocationScreen *addscreen = [[AddLocationScreen alloc]initWithNibName:@"AddLocationScreen" bundle:nil];
    
    [self.navigationController pushViewController:addscreen animated:YES];
}

-(void)showMyRequestsScreen : (int)type
{
    MyRequestsScreen *req = [[MyRequestsScreen alloc] initWithNibName:@"MyRequestsScreen" bundle:nil andscreenType:type];
    [self.navigationController pushViewController:req animated:YES];
}

-(void)logout
{
    [self showLoginScreen];
    //[self.navigationController popViewControllerAnimated:YES];
}


-(void)showLoginScreen
{
    LoginViewController *loginScreen = [[LoginViewController alloc]  initWithNibName:@"LoginViewController" bundle:nil ];
    
    
    [self.navigationController pushViewController:loginScreen animated:YES];
    
}

-(void)showSignUpScreen
{
    SignUpViewController *signup = [[SignUpViewController alloc] initWithNibName:@"SignUpViewController" bundle:nil ];
    
    [self.navigationController pushViewController:signup animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openCloseDrawer:(id)sender {
    
    [self openCloseView];
}


-(void)openCloseView
{
    
    
    
    if([self.leftView isHidden])
    {
        /// open the drawer
        
        [self.leftView setHidden:NO];
        
        [self.view addSubview:self.leftView];
        
        [UIView animateWithDuration:kMenuAnimationDuration animations:^{
            
            self.leftView.frame = CGRectMake(0, 60, self.leftView.frame.size.width, self.leftView.frame.size.height);
            /*CGRect toggleFrame = self.leftDrawerButton.frame;
             toggleFrame.origin.x = self.SearchButton.frame.origin.x;
             self.DrawerToggleButton.frame = toggleFrame;
             self.SearchButton.hidden = YES;*/
            
            
            
            /*self.searchButton.hidden = YES;
             CGRect drawerRect = self.leftDrawerButton.frame;
             drawerRect.origin.x = self.searchButton.frame.origin.x;
             self.leftDrawerButton.frame = drawerRect;*/
            
            
            [UIView animateWithDuration:kMenuAnimationDuration animations:^{
                
                
            }completion:^(BOOL finished){
                
                
                
                
            }];
            
        }completion:^(BOOL finished){
            //self.mainMenuDisplay = YES;
            
            
            
        }];
    }
    else
    {
        /// close the drawer
        [UIView animateWithDuration:kMenuAnimationDuration animations:^{
            
            self.leftView.frame = CGRectMake(-self.leftView.frame.size.width - 80, 60, self.leftView.frame.size.width, self.view.frame.size.height);
            /* CGRect toggleFrame = self.DrawerToggleButton.frame;
             toggleFrame.origin.x = 10;
             self.DrawerToggleButton.frame = toggleFrame;*/
            
            /*CGRect drawerRect = self.leftDrawerButton.frame;
             drawerRect.origin.x = 10;
             self.leftDrawerButton.frame = drawerRect;*/
            
            
        }completion:^(BOOL finished){
            
            //self.mainMenuDisplay = NO;
            [self.leftView setHidden:YES];
            //self.searchButton.hidden = NO;
            
            // self.SearchButton.hidden = NO;
        }];
    }
    
}




@end
