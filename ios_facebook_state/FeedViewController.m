//
//  FeedViewController.m
//  ios_facebook_state
//
//  Created by Stanley Ng on 6/13/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

#import "FeedViewController.h"
#import "StatusViewController.h"
#import "AVHexColor.h"
#import "Users.h"

@interface FeedViewController ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicatorView;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (strong, nonatomic) Users *users;

- (IBAction)onStatusButton:(id)sender;
- (void)onSearchButton:(id)sender;
- (void)onContactButton:(id)sender;
- (void)callbackLoad:(id)sender;
- (void)refresh:(id)sender;

@end

@implementation FeedViewController

UIRefreshControl *refreshControl;
UIScrollView *scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Define Users object
        self.users = [Users instance];
        
        // Custom initialization
        self.title = @"News Feed";
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

    // indicator view: loading
    [self.loadingIndicatorView startAnimating];
    
    // Configure scroll view
    UIImageView *imageView;
    NSDictionary *viewsDictionary;
    
    scrollView = [[UIScrollView alloc] init];
    imageView = [[UIImageView alloc] init];

    [scrollView setHidden:YES];
    //[imageView setImage:[UIImage imageNamed:@"view-feed"]];
    [imageView setImage:[UIImage imageNamed: [self.users getCurrentFeedView]]];

    //[self.view addSubview: scrollView];
    [self.view insertSubview:scrollView belowSubview:self.errorLabel];
    
    [scrollView addSubview: imageView];

    scrollView.translatesAutoresizingMaskIntoConstraints  = NO;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    viewsDictionary = NSDictionaryOfVariableBindings(scrollView, imageView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|" options:0 metrics: 0 views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-45.0-[scrollView]-50.0-|" options:0 metrics: 0 views:viewsDictionary]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageView]|" options:0 metrics: 0 views:viewsDictionary]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView]|" options:0 metrics: 0 views:viewsDictionary]];
    
    // Load feed
    [self performSelector:@selector(callbackLoad:) withObject:nil afterDelay:2];

    // Initialize Refresh Control
    refreshControl = [[UIRefreshControl alloc] init];
    
    // Configure Refresh Control
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    
    // Configure View Controller
    [scrollView addSubview:refreshControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onStatusButton:(id)sender
{
    NSLog(@"onStatusButton");
    
    UIViewController *vc = [[StatusViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    nvc.modalTransitionStyle = UIModalTransitionStyleCoverVertical; // Rises from below
    
    [self presentViewController:nvc animated:YES completion:nil];
}

- (void)onSearchButton:(id)sender
{
    NSLog(@"onSearchButton");
}

- (void)onContactButton:(id)sender
{
    NSLog(@"onContactButton");
}

- (void)callbackLoad:(id)sender
{
    NSLog(@"callbackLoad");

    if (refreshControl.refreshing) {
        self.errorLabel.hidden = !self.errorLabel.hidden;
    }
    
    // indicator view: loading
    [self.loadingIndicatorView stopAnimating];
    
    [refreshControl endRefreshing];
    
    [scrollView setHidden:NO];
}

- (void)refresh:(id)sender
{
    NSLog(@"Refreshing");
    
    [self performSelector:@selector(callbackLoad:) withObject:nil afterDelay:2];
}

@end
