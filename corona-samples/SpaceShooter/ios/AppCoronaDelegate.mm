//
//  AppCoronaDelegate.mm
//  TemplateApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppCoronaDelegate.h"

#import "CoronaRuntime.h"
#import "CoronaLua.h"
//#import <KiipSDK/KiipSDK.h>

@implementation AppCoronaDelegate

- (void)willLoadMain:(id<CoronaRuntime>)runtime
{
//    Kiip *kiip = [[Kiip alloc] initWithAppKey:@"a22232a561a02fdf7684ef67a48aeeb5" andSecret:@"e320cb6c3b23b4d2eee7b6aa0954ef17"];
//    [Kiip setSharedInstance:kiip];
//    [Kiip sharedInstance].testMode = YES;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 4 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//        [[Kiip sharedInstance] saveMoment:@"test" withCompletionHandler:^(KPPoptart *poptart, NSError *error) {
//            if (error) {
//                NSLog(@"something's wrong");
//                // handle with an Alert dialog.
//            }
//            if (poptart) {
//                [poptart show];
//            }
//            if (!poptart) {
//                // handle logic when there is no reward to give.
//            }
//        }];
//    });
}

- (void)didLoadMain:(id<CoronaRuntime>)runtime
{
}

#pragma mark UIApplicationDelegate methods

// The following are stubs for common delegate methods. Uncomment and implement
// the ones you wish to be called. Or add additional delegate methods that
// you wish to be called.

/*
- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
*/

/*
- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}
*/

/*
- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}
*/

/*
- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}
*/

/*
- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
*/

@end
