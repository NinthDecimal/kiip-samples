//
//  ViewController.m
//  KiipObjCSample
//
//  Created by encore on 28/11/18.
//  Copyright © 2018 Kiip. All rights reserved.
//

#import "ViewController.h"
#import <KiipSDK/KiipSDK.h>
#import "KPCustomNotificationView.h"

@interface ViewController () <KPPoptartDelegate,KPModalDelegate>

@property (strong, nonatomic) KPCustomNotificationView *customNotificationView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"KiipObjC";
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)actionInterstitial:(id)sender {
    
    void (^handler)(KPPoptart *, NSError *) = ^(KPPoptart *poptart, NSError *error) {
        if (error) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Title" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        // Since we've implemented this block, Kiip will no longer show the poptart automatically
        poptart.delegate = self;
        if (poptart.modal) {
            poptart.modal.delegate = self;
        }
        [poptart show];
    };
    [[Kiip sharedInstance] saveMoment:@"t" withCompletionHandler:handler];
    
    // [[Kiip sharedInstance] saveMoment:@"t" withAssetId:nil withCompletionHandler:nil];
}

- (IBAction)actionNotification:(id)sender {
    [[Kiip sharedInstance] setNotificationView:nil];
    [[Kiip sharedInstance] saveMoment:@"test" withCompletionHandler:nil];
}

- (IBAction)actionCustomNotification:(id)sender {
    self.customNotificationView = [[KPCustomNotificationView alloc] initWithFrame:CGRectZero];
    [[Kiip sharedInstance] setNotificationView:self.customNotificationView];
    [[Kiip sharedInstance] saveMoment:@"test" withCompletionHandler:nil];
}


- (IBAction)actionSwitchTestMode:(id)sender {
    [[Kiip sharedInstance] setTestMode:[sender isOn]];
}

- (IBAction)actionClearSession:(id)sender {
   // [[Kiip sharedInstance] clearSession];
}

- (IBAction)actionStartSession:(id)sender {
   // [[Kiip sharedInstance] startSession];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark KPPoptartDelegate
////////////////////////////////////////////////////////////////////////////////////////////////////

//Tells the delegate a Poptart will be presented.

- (void) willPresentPoptart:(KPPoptart *)poptart {
    
}

// Tells the delegate a Poptart was dismissed.

- (void) didDismissPoptart:(KPPoptart *)poptart {
    
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark KPModalDelegate
////////////////////////////////////////////////////////////////////////////////////////////////////

- (void) willPresentModal:(KPModal *)modal {
    
}

- (void) didDismissModal:(KPModal *)modal {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
