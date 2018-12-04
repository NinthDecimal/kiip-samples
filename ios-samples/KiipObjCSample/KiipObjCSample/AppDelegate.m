//
//  AppDelegate.m
//  KiipObjCSample
//
//  Copyright © 2018 Kiip. All rights reserved.
//

#import "AppDelegate.h"

#define KP_APP_KEY    @"Your App Key"  // Interstitial Rewards or Notification Reward
#define KP_APP_SECRET @"Your App Secret"  // Interstitial Rewards or Notification Reward


@interface AppDelegate () 

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [Kiip initWithAppKey:KP_APP_KEY andSecret:KP_APP_SECRET];

    [[Kiip sharedInstance] setDelegate:self];
    [[Kiip sharedInstance] setTestMode:YES];
    [[Kiip sharedInstance] setDebugMode:YES];  //comment this if you wnat to test in production

    return YES;
}


////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark KiipDelegate
////////////////////////////////////////////////////////////////////////////////////////////////////

- (void) kiip:(Kiip *)kiip didStartSessionWithPoptart:(KPPoptart *)poptart error:(NSError *)error {
    NSLog(@"kiip:didStartSessionWithPoptart:%@ error:%@", poptart, error);
    
    if (error) {
        NSLog(@"%@",[error localizedDescription]);
    }

    // Since we've implemented this delegate method, Kiip will no longer show the poptart automatically
    [poptart show];
}

- (void) kiip:(Kiip *)kiip didEndSessionWithError:(NSError *)error {
    NSLog(@"kiip:didEndSessionWithError:%@", error);
    
    if (error) {
        NSLog(@"%@",[error localizedDescription]);
    }
}

// In order for you to know whether a user got a virtual currency or not, you need this callback to listen for his/her result.
- (void) kiip:(Kiip *)kiip didReceiveContent:(NSString *)contentId quantity:(int)quantity transactionId:(NSString *)transactionId signature:(NSString *)signature {
    NSLog(@"kiip:didReceiveContent:%@ quantity:%d transactionId:%@ signature:%@", contentId, quantity, transactionId, signature);
}


// Video playback listener is here
- (void) kiipVideoPlaybackDidBegin:(Kiip *)kiip {
    NSLog(@"kiip:kiipVideoPlaybackDidBegin:");
}

- (void) kiipVideoPlaybackDidEnd:(Kiip *)kiip {
    NSLog(@"kiip:kiipVideoPlaybackDidEnd:");
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
