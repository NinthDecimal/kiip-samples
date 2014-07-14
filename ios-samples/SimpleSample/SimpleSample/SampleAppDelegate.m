//
//  KPAppDelegate.m
//  Sample
//
//  Created by Grantland Chew on 9/19/12.
//  Copyright (c) 2012 Kiip, Inc. All rights reserved.
//

#import "SampleAppDelegate.h"

#import "SampleViewController.h"

@implementation SampleAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    Kiip *kiip = [[Kiip alloc] initWithAppKey:KP_APP_KEY andSecret:KP_APP_SECRET];
    
    // Listen for Kiip events
    kiip.delegate = self;
    kiip.gender = @"Male";
    [Kiip setSharedInstance:kiip];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    UIViewController *viewController = [[SampleViewController alloc] initWithNibName:@"SampleViewController" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    viewController.title = [NSString stringWithFormat:@"Kiip v%@", KPVersion];
    self.viewController = navigationController;
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)showError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark KiipDelegate
////////////////////////////////////////////////////////////////////////////////////////////////////

- (void) kiip:(Kiip *)kiip didStartSessionWithPoptart:(KPPoptart *)poptart error:(NSError *)error {
    NSLog(@"kiip:didStartSessionWithPoptart:%@ error:%@", poptart, error);

    if (error) {
        [self showError:error];
    }

    // Since we've implemented this delegate method, Kiip will no longer show the poptart automatically
    [poptart show];
}

- (void) kiip:(Kiip *)kiip didEndSessionWithError:(NSError *)error {
    NSLog(@"kiip:didEndSessionWithError:%@", error);
    
    if (error) {
        [self showError:error];
    }
}

- (void) kiip:(Kiip *)kiip didStartSwarm:(NSString *)leaderboardId {
    NSLog(@"kiip:didStartSwarm:%@", leaderboardId);
    
    // Enter "swarm" mode
    // http://docs.kiip.com/en/guide/swarm.html
}

- (void) kiip:(Kiip *)kiip didReceiveContent:(NSString *)contentId quantity:(int)quantity transactionId:(NSString *)transactionId signature:(NSString *)signature {
    NSLog(@"kiip:didReceiveContent:%@ quantity:%d transactionId:%@ signature:%@", contentId, quantity, transactionId, signature);
    
    // Add quantity amount of content to player's profile
    // e.g +20 coins to user's wallet
    // http://docs.kiip.com/en/guide/android.html#getting_virtual_rewards
}

@end
