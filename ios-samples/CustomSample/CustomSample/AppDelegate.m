//
//  AppDelegate.m
//  SimpleSample
//
//  Created by Ash Bhat on 7/9/13.
//  Copyright (c) 2013 Ash Bhat. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "KPCustomNotificationView.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIViewController *viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    viewController.title = [NSString stringWithFormat:@"Kiip v%@", KPVersion];
    self.viewController = navigationController;
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    // Create the custom notification view
    self.customNotificationView = [[KPCustomNotificationView alloc] initWithFrame:CGRectZero];
    
    // Instantiate and set the shared Kiip instance.
    Kiip *kiip = [[Kiip alloc] initWithAppKey:KP_APP_KEY andSecret:KP_APP_SECRET];
    kiip.delegate = self;
    // Usually the notificationView is set here, but for the sake of this sample it is called in
    // toggleCustomNotification.
    // kiip.notificationView = self.customNotificationView;
    [Kiip setSharedInstance:kiip];
    
    return YES;
}

- (void)toggleCustomNotification:(BOOL)enabled {
    // Usually this would be set right after Kiip.init, but since this
    // sample allows enabling/disabling, we have it here.
    [[Kiip sharedInstance] setNotificationView:enabled ? self.customNotificationView : nil];
}

- (void)showError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark KiipDelegate
////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)kiip:(Kiip *)kiip didStartSessionWithPoptart:(KPPoptart *)poptart error:(NSError *)error {
    if (error) {
        [self showError:error];
    }
    if (poptart) {
        [poptart show];
    }
}

@end
