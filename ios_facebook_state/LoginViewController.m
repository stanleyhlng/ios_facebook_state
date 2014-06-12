//
//  LoginViewController.m
//  ios_facebook_state
//
//  Created by Stanley Ng on 6/10/14.
//  Copyright (c) 2014 Stanley Ng. All rights reserved.
//

#import "LoginViewController.h"
#import "AVHexColor.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)onTap:(id)sender;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        // view: background color
        self.view.backgroundColor = [AVHexColor colorWithHexString: @"#3b5998"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // textfield: login
    self.loginTextField.leftView = [self getPaddingView];
    self.loginTextField.leftViewMode = UITextFieldViewModeAlways;
    self.loginTextField.placeholder = @"Email or phone number";
    [self.loginTextField setFont:[UIFont systemFontOfSize:14]];

    // textfield: password
    self.passwordTextField.leftView = [self getPaddingView];
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTextField.placeholder = @"Password";
    self.passwordTextField.secureTextEntry = YES;
    [self.passwordTextField setFont:[UIFont systemFontOfSize:14]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    NSLog(@"onTap");
    [self.view endEditing:YES];
}

# pragma textfield

- (UIView *)getPaddingView {
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 45)];
}


@end
