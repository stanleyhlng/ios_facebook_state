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

@property (weak, nonatomic) IBOutlet UIView *panelView;
@property (weak, nonatomic) IBOutlet UIView *helpView;
@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)onTap:(id)sender;
- (IBAction)onLoginButton:(id)sender;

- (UIView *)getPaddingView;
- (void)willShowKeyboard:(NSNotification *)notification;
- (void)willHideKeyboard:(NSNotification *)notification;
- (void)textFieldDidChange:(UITextField *)theTextField;
- (void)callbackLoginButton;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        // view: background color
        self.view.backgroundColor = [AVHexColor colorWithHexString: @"#3b5998"];
    
        // keyboard
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
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

- (IBAction)onLoginButton:(id)sender {
    NSLog(@"onLoginButton");
    
    // button: login
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"Logging In"];
    [self.loginButton setAttributedTitle:title forState:UIControlStateNormal];
    
    [self performSelector:@selector(callbackLoginButton) withObject:nil afterDelay:2];
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
                         // view: panel
                         {
                             CGRect frame = self.panelView.frame;
                             frame.origin.y = frame.origin.y - 80;
                             self.panelView.frame = frame;
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
                         // view: panel
                         {
                             CGRect frame = self.panelView.frame;
                             frame.origin.y = frame.origin.y + 80;
                             self.panelView.frame = frame;
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

- (void)callbackLoginButton {
    NSLog(@"callbackLoginButton");
    
    // button: login
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"Log In"];
    [self.loginButton setAttributedTitle:title forState:UIControlStateNormal];
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
