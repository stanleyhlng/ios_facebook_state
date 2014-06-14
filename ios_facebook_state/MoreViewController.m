//
//  MoreViewController.m
//  ios_facebook_state
//
//  Created by Stanley Ng on 6/13/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

#import "MoreViewController.h"
#import "AVHexColor.h"
#import "User.h"

@interface MoreViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *navigationImageView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) UIButton *logoutButton;

- (void)onSearchButton:(id)sender;
- (void)onContactButton:(id)sender;
- (void)onLogoutButton:(id)sender;

@end

@implementation MoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"More";
        
        // object
        User *user = [User sharedInstance];
        NSLog(@"user object:%@", user.nameDict[@"stanley"]);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.

    // Define negative spacer
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -5;
    
    // Configure the left button
    UIImage *searchButtonImage = [[UIImage imageNamed:@"button-search"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithImage:searchButtonImage
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(onSearchButton:)];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, searchButton, nil];
    
    // Configure the right button
    UIImage *contactButtonImage = [[UIImage imageNamed:@"button-contact"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIBarButtonItem *contactButton = [[UIBarButtonItem alloc] initWithImage:contactButtonImage
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(onContactButton:)];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, contactButton, nil];
    
    // Configure navigation bar
    self.navigationController.navigationBar.translucent = NO;
    //[self.navigationController setNavigationBarHidden:YES];

    // Configure scroll view
    UIScrollView *scrollView;
    UIImageView *imageView;
  
    // Create the scroll view and the image view.
    scrollView = [[UIScrollView alloc] init];
    imageView = [[UIImageView alloc] init];
    
    // Add an image to the image view.
    [imageView setImage:[UIImage imageNamed:@"view-more"]];

    //[imageView insertSubview:self.logoutButton aboveSubview:imageView];
    
    // Add the image view to the scroll view.
    [scrollView addSubview:imageView];
    
    self.logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.logoutButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.logoutButton addTarget:self action:@selector(onLogoutButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.logoutButton setImage:[UIImage imageNamed:@"button-logout"] forState:UIControlStateNormal];
    
    [scrollView addSubview:self.logoutButton];
    
    // Add the scroll view to our view
    [self.containerView addSubview:scrollView];
    //[self.containerView insertSubview:scrollView belowSubview:self.navigationImageView];

    // Set the translatesAutoresizingMaskIntoConstraints to NO so that the views autoresizing mask is not translated into auto layout constraints.
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Set the constraints for the scroll view and the image view.
    NSDictionary *viewsDictionary = @{
                                      @"scrollView":scrollView,
                                      @"imageView":imageView,
                                      @"logoutButton":self.logoutButton
                                      };
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|" options:0 metrics: 0 views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]-65.0-|" options:0 metrics: 0 views:viewsDictionary]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageView]|" options:0 metrics: 0 views:viewsDictionary]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView]|" options:0 metrics: 0 views:viewsDictionary]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[logoutButton]|" options:0 metrics: 0 views:viewsDictionary]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[logoutButton]|" options:0 metrics: 0 views:viewsDictionary]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onSearchButton:(id)sender
{
    NSLog(@"onSearchButton");
}

- (void)onContactButton:(id)sender
{
    NSLog(@"onContactButton");
}

- (void)onLogoutButton:(id)sender
{
    NSLog(@"onLogoutButton");
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Are you sure you want to log out?"
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:@"Log Out"
                                                    otherButtonTitles:@"Cancel", nil];
    [actionSheet showInView:self.view];
}

#pragma UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    NSLog(@"clickedButtonAtIndex %d %@", buttonIndex, buttonTitle);
    
    if ([buttonTitle isEqualToString:@"Log Out"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
