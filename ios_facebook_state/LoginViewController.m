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

@property (weak, nonatomic) IBOutlet UIView *loadingPanelView;
@property (weak, nonatomic) IBOutlet UIView *verifyPanelView;
@property (weak, nonatomic) IBOutlet UIView *loginPanelView;
@property (weak, nonatomic) IBOutlet UIView *helpView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingActivityIndicatorView;

- (IBAction)onTap:(id)sender;
- (IBAction)onNotMeButton:(id)sender;
- (IBAction)onContinueButton:(id)sender;
- (IBAction)onLoginButton:(id)sender;

- (UIView *)getPaddingView;
- (void)willShowKeyboard:(NSNotification *)notification;
- (void)willHideKeyboard:(NSNotification *)notification;
- (void)textFieldDidChange:(UITextField *)theTextField;
- (void)callbackLoadingPanelView;
- (void)callbackLoginButton;
- (void)launchLoadingViewController;
- (void)launchFeedViewController;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        // view: background color
        self.view.backgroundColor = [AVHexColor colorWithHexString: @"#3B5998"];
    
        // keyboard
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];

        // view: loading panel
        [self launchLoadingViewController];
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
    self.loginTextField.delegate = self;
    [self.loginTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    // textfield: password
    self.passwordTextField.leftView = [self getPaddingView];
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTextField.placeholder = @"Password";
    self.passwordTextField.secureTextEntry = YES;
    [self.passwordTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self.passwordTextField setFont:[UIFont systemFontOfSize:14]];
    self.passwordTextField.delegate = self;
    [self.passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    // button: login
    [self.loginButton setEnabled:NO];
}

- (IBAction)onTap:(id)sender {
    NSLog(@"onTap");
    [self.view endEditing:YES];
}

- (IBAction)onNotMeButton:(id)sender {
    NSLog(@"onNotMeButton");

    // view: verify panel
    [self.verifyPanelView setHidden:YES];
    
    // view: login panel
    [self.loginPanelView setHidden:NO];
}

- (IBAction)onLoginButton:(id)sender {
    NSLog(@"onLoginButton");
    
    // keyboard
    [self.view endEditing:YES];
    
    // button: login
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"Logging In"];
    [title addAttribute:NSForegroundColorAttributeName
                  value:[AVHexColor colorWithHexa:@"#FFFFFF"]
                  range:NSMakeRange(0, 10)];
    [title addAttribute:NSFontAttributeName
                  value:[UIFont fontWithName:@"HelveticaNeue" size:16.0]
                  range:NSMakeRange(0, 10)];
    [self.loginButton setAttributedTitle:title forState:UIControlStateNormal];
    
    // activity indicator view: loading
    [self.loadingActivityIndicatorView startAnimating];
    
    // action
    [self performSelector:@selector(callbackLoginButton) withObject:nil afterDelay:2];
}

- (IBAction)onContinueButton:(id)sender {
    NSLog(@"onContinueButton");
    [self launchFeedViewController];
}

- (UIView *)getPaddingView {
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 45)];
}

- (void) willShowKeyboard: (NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         // image view: logo
                         {
                             CGRect frame = self.logoImageView.frame;
                             frame.origin.y = frame.origin.y - 80;
                             self.logoImageView.frame = frame;
                         }
                         
                         // view: login panel
                         {
                             CGRect frame = self.loginPanelView.frame;
                             frame.origin.y = frame.origin.y - 80;
                             self.loginPanelView.frame = frame;
                         }
                         
                         // view: help
                         {
                             CGRect frame = self.helpView.frame;
                             frame.origin.y = frame.origin.y - 170;
                             self.helpView.frame = frame;
                         }
                     }
                     completion:nil];
}

- (void) willHideKeyboard: (NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         // image view: logo
                         {
                             CGRect frame = self.logoImageView.frame;
                             frame.origin.y = frame.origin.y + 80;
                             self.logoImageView.frame = frame;
                         }
                         
                         // view: panel
                         {
                             CGRect frame = self.loginPanelView.frame;
                             frame.origin.y = frame.origin.y + 80;
                             self.loginPanelView.frame = frame;
                         }
                         
                         // view: help
                         {
                             CGRect frame = self.helpView.frame;
                             frame.origin.y = frame.origin.y + 170;
                             self.helpView.frame = frame;
                         }
                     }
                     completion:nil];
}

- (void)textFieldDidChange:(UITextField *)theTextField {
    NSLog(@"text changed: %@", theTextField.text);
    
    if (self.loginTextField.text.length == 0 || self.passwordTextField.text.length == 0) {
        [self.loginButton setEnabled:NO];
    }
    else {
        [self.loginButton setEnabled:YES];
    }
}

- (void)callbackLoadingPanelView {
    NSLog(@"callbackLoadingPanelView");
    
    // view: loading panel
    [self.loadingPanelView setHidden:YES];
    
    // view: verify panel
    [self.verifyPanelView setHidden:NO];
}

- (void)callbackLoginButton {
    NSLog(@"callbackLoginButton");
    
    // button: login
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"Log In"];
    [title addAttribute:NSForegroundColorAttributeName
                  value:[AVHexColor colorWithHexa:@"#FFFFFF"]
                  range:NSMakeRange(0, 6)];
    [title addAttribute:NSFontAttributeName
                  value:[UIFont fontWithName:@"HelveticaNeue" size:16.0]
                  range:NSMakeRange(0, 6)];
    [self.loginButton setAttributedTitle:title forState:UIControlStateNormal];
    
    // activity indicator view: loading
    [self.loadingActivityIndicatorView stopAnimating];
    
    // validate the password
    if ([self.passwordTextField.text isEqualToString:@"password"]) {

        // launch feed view controller
        [self launchFeedViewController];

    }
    else {
    
        // launch alert
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Incorrect Password" message:@"The password you entered is incorrect.  Please try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        
        // textfield: password
        [self.passwordTextField setText:@""];
        
        // button: login
        [self.loginButton setEnabled:NO];
    }
}

-(void)launchLoadingViewController {
    NSLog(@"launchLoadingViewController");
    [self performSelector:@selector(callbackLoadingPanelView) withObject:nil afterDelay:2];
}

-(void)launchFeedViewController {
    NSLog(@"launchFeedViewController");
}

# pragma textFieldDelegrate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSLog(@"textFieldShouldBeginEditing");
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"textFieldDidBeginEditing");
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    NSLog(@"textFieldShouldEndEditing");
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"textFieldDidEndEditing");
}

@end
