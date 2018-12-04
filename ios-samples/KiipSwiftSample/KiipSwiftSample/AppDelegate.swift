//
//  AppDelegate.swift
//  KiipSwiftSample
//
//  Copyright © 2018 Kiip. All rights reserved.
//

import UIKit
import KiipSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,KiipDelegate {

    var window: UIWindow?
    
    let KP_APP_KEY = "Your App Key"          // Interstitial Rewards or Notification Reward
    let KP_APP_SECRET = "Your App Secret"    // Interstitial Rewards or Notification Reward


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Kiip.initWithAppKey(KP_APP_KEY, andSecret: KP_APP_SECRET)
        Kiip.sharedInstance().delegate = self
        Kiip.sharedInstance().debugMode = true
        Kiip.sharedInstance().testMode = true     //comment this if you wnat to test in production

        return true
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    
    // MARK: -
    // MARK: KiipDelegate
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func kiip(_ kiip: Kiip?, didStartSessionWith poptart: KPPoptart?, error:Error?)  {
        
        if error != nil {
            print("\(error?.localizedDescription  ?? "SessionError")")
        }
        // Since we've implemented this delegate method, Kiip will no longer show the poptart automatically
        poptart?.show()
    }
    
    func kiip(_ kiip: Kiip!, didEndSessionWithError error: Error!) {
        
    }
    
    // In order for you to know whether a user got a virtual currency or not, you need this callback to listen for his/her result.
    func kiip(_ kiip: Kiip!, didReceiveContent content: String!, quantity: Int32, transactionId: String!, signature: String!) {
        print("kiip:didReceiveContent:\(content) quantity:\(quantity) transactionId:\(transactionId) signature:\(signature)")

    }
    
    // Video playback listener is here
    func kiipVideoPlaybackDidBegin(_ kiip: Kiip!) {
        print("kiip:kiipVideoPlaybackDidBegin:")
    }
    
    func kiipVideoPlaybackDidEnd(_ kiip: Kiip!) {
        print("kiip:kiipVideoPlaybackDidEnd:")
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////////

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

