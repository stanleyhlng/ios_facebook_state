//
//  StatusViewController.m
//  ios_facebook_state
//
//  Created by Stanley Ng on 6/14/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

#import "StatusViewController.h"
#import "AVHexColor.h"
#import "Users.h"

@interface StatusViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) Users *users;

- (void)onCancelButton:(id)sender;
- (void)onPostButton:(id)sender;

@end

@implementation StatusViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Update Status";

        // Define Users object
        self.users = [Users instance];
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
 
    // Configure navigation bar
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{
       NSForegroundColorAttributeName:[UIColor blackColor],
       }];

    // Configure post button
    UIBarButtonItem *postButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Post"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(onPostButton:)];
    [postButton setTintColor: [AVHexColor colorWithHexString:@"#BAbEC4"]];
    self.navigationItem.rightBarButtonItem = postButton;

    // Configure cancel button
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Cancel"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(onCancelButton:)];
    [cancelButton setTintColor: nil];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    // Configure profile image
    [self.profileImageView setImage:[UIImage imageNamed:[self.users getCurrentProfileImage]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onCancelButton:(id)sender
{
    NSLog(@"onCancelButton");

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onPostButton:(id)sender
{
    NSLog(@"onPostButton");
}

@end
