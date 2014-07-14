//
//  ViewController.m
//  SimpleSample
//
//  Created by Ash Bhat on 7/9/13.
//  Copyright (c) 2013 Ash Bhat. All rights reserved.
//

#import <KiipSDK/KiipSDK.h>

#import "ViewController.h"
#import "AppDelegate.h"

#define KEYBOARD_HEIGHT_PORTRAIT 216
#define KEYBOARD_HEIGHT_LANDSCAPE 162
#define ANIMATION_DURATION 0.3 // 300 ms

// Types of notifications 
NSString *const kNotificationDefault = @"Default Notification";
NSString *const kNotificationCustom = @"Custom Notification";
NSString *const kNotificationIntegrated = @"Integrated Notification";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.momentField setDelegate:self];

    //setting the default notification type (what appears when the app is first opened up)
    self.notifType = kNotificationDefault;
    self.dataArray = @[
                  kNotificationDefault,
                  kNotificationCustom,
                  kNotificationIntegrated
                  ];
    
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    
    self.redeemButton.alpha = 0.0f;
    self.redeemButton.hidden = YES;
    [self registerForKeyboardNotifications];
}

// Resize the UIPickerView for portrait/landscape
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    CGRect frame = self.pickerView.frame;
    float screenHeight;
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        screenHeight = self.view.frame.size.height;
        frame.size.height = KEYBOARD_HEIGHT_PORTRAIT;
        frame.origin.y = screenHeight - KEYBOARD_HEIGHT_PORTRAIT;
    } else if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)){
        screenHeight = self.view.frame.size.height;
        frame.size.height = KEYBOARD_HEIGHT_LANDSCAPE;
        frame.origin.y = screenHeight - KEYBOARD_HEIGHT_LANDSCAPE;
    }
    self.pickerView.frame = frame;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // Hides keyboard when user touches anywhere outside the keyboard
    [self.view endEditing:YES];
}

- (void)showIntegratedNotification:(KPPoptart *)poptart {
    // Sending poptart data to KPCusomButton
    [self.redeemButton setPoptart:poptart];
    
    // Show integrated notification
    self.redeemButton.hidden = NO;
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        self.redeemButton.alpha = 1.0;
    }];
    
    // We want to go direct to fullscreen when the integrated notification is interacted with
    [poptart setNotification:nil];
    
    // Save the poptart to show later
    self.savedPoptart = poptart;
}

- (void)dismissIntegratedNotification {
    // Clear the reference to the saved poptart
    self.savedPoptart = nil;
    
    // Dismiss
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        self.redeemButton.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.redeemButton.hidden = YES;
    }];
}

- (void)showError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark IBAction
////////////////////////////////////////////////////////////////////////////////////////////////////

- (IBAction)callMoment:(id)sender {
    void (^handler)(KPPoptart *, NSError *);
    
    if (![self.notifType isEqualToString:kNotificationIntegrated]) {
        // Default handler
        handler = ^(KPPoptart *poptart, NSError *error) {
            if (error) {
                [self showError:error];
            }
            else{
                [poptart show];
            }
        };
    } else {
        // Integrated handler
        handler = ^(KPPoptart *poptart, NSError *error) {
            if (error) {
                [self showError:error];
            }
            if (poptart) {
                // Show the integrated notification
                [self showIntegratedNotification:poptart];
            }
        };
    }
    
    [[Kiip sharedInstance] saveMoment:@"boop" withCompletionHandler:handler];
}

- (IBAction)integratedTouchUpInside:(id)sender {
    // Show the saved poptart
    [self.savedPoptart show];
    // Dismiss the integrated notification
    [self dismissIntegratedNotification];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIPickerViewDataSource
////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.dataArray count];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIPickerViewDelegate
////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.dataArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if([self.dataArray objectAtIndex: row]!=nil) {
        self.notifType = [self.dataArray objectAtIndex:row];
    }
    // Enable custom notifications if the type is kNotifcationCustom
    [((AppDelegate *)[UIApplication sharedApplication].delegate) toggleCustomNotification:[self.notifType isEqualToString:kNotificationCustom]];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UITextFieldDelegate
////////////////////////////////////////////////////////////////////////////////////////////////////

// Hides keyboard when user hits "return"
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    /*[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];*/
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(keyboardWillShow:)
                                            name:UIKeyboardWillShowNotification object:nil];
    
}

- (void) keyboardWillShow:(NSNotification *) aNotification{
    
    NSDictionary* info = [aNotification userInfo];
    NSLog(@"%@", info);
}
@end

