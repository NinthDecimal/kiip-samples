//
//  KPViewController.m
//  Sample
//
//  Created by Grantland Chew on 9/19/12.
//  Copyright (c) 2012 Kiip, Inc. All rights reserved.
//

#import <KiipSDK/KiipSDK.h>

#import "SampleViewController.h"

@interface SampleViewController () <UITextFieldDelegate>

@end

@implementation SampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // You can add your Device ID to your Developer Console to receive test rewards
    // http://app.kiip.me
    NSString *deviceIdentifier = [[Kiip sharedInstance] deviceIdentifier];
    NSLog(@"Device ID: %@", deviceIdentifier);
    [self.deviceLabel setText:[NSString stringWithFormat:@"Device ID: %@", deviceIdentifier]];
    
    self.momentIdField.delegate = self;
    self.momentValueField.delegate = self;
    [self.saveMoment addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)onClick:(id)sender {
    // Save moment
    // http://docs.kiip.com/en/guide/android.html#getting_rewards
    if ([sender isEqual:self.saveMoment]) {
        [self dismissKeyboard];
        
        NSString *momentId = self.momentIdField.text;
        NSString *momentValue = self.momentValueField.text;
        [[Kiip sharedInstance] saveMoment:momentId value:[momentValue doubleValue] withCompletionHandler: nil];
        
         /*^(KPPoptart *poptart, NSError *error) {
            if (error) {
                [self showError:error];
            }

            // Since we've implemented this block, Kiip will no longer show the poptart automatically
            // WARNING: poptart may be nil if no reward was given
            [poptart show];
        }]*/
    }
}

- (void)showError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.momentIdField == textField) {
        [self.momentValueField becomeFirstResponder];
    }
    else if (self.momentValueField == textField) {
        [textField resignFirstResponder];
    }

    return NO;
}

- (void)dismissKeyboard {
    [self.momentIdField resignFirstResponder];
    [self.momentValueField resignFirstResponder];
}

@end
