//
//  MoreViewController.m
//  ios_facebook_state
//
//  Created by Stanley Ng on 6/13/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *navigationImageView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

@end

@implementation MoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"More";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // navigation bar
    [self.navigationController setNavigationBarHidden:YES];
    
    UIScrollView *scrollView;
    UIImageView *imageView;
    NSDictionary *viewsDictionary;
    
    // Create the scroll view and the image view.
    scrollView = [[UIScrollView alloc] init];
    imageView = [[UIImageView alloc] init];
    
    // Add an image to the image view.
    [imageView setImage:[UIImage imageNamed:@"view-more"]];
    
    [imageView insertSubview:self.logoutButton aboveSubview:imageView];
    
    
    // Add the image view to the scroll view.
    [scrollView addSubview:imageView];
    
    // Add the scroll view to our view
    //[self.view addSubview:scrollView];
    [self.containerView insertSubview:scrollView belowSubview:self.navigationImageView];

    // Set the translatesAutoresizingMaskIntoConstraints to NO so that the views autoresizing mask is not translated into auto layout constraints.
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Set the constraints for the scroll view and the image view.
    viewsDictionary = NSDictionaryOfVariableBindings(scrollView, imageView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|" options:0 metrics: 0 views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:0 metrics: 0 views:viewsDictionary]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageView]|" options:0 metrics: 0 views:viewsDictionary]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView]|" options:0 metrics: 0 views:viewsDictionary]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
