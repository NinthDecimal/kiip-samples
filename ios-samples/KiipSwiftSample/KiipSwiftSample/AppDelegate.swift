//
//  AppDelegate.swift
//  KiipSwiftSample
//
//  Created by Daniel on 4/23/18.
//  Copyright © 2018 Kiip, Inc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, KiipDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Initialize Kiip
        Kiip.initWithAppKey(KP_APP_KEY, andSecret: KP_APP_SECRET);
        //comment the test if you are done 
        Kiip.sharedInstance().testMode = true;
        Kiip.sharedInstance().delegate = self;
        
        return true
    }

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

    //MARK:-- KiipDelegates --
    
    private func kiip(kiip:Kiip, didStartSessionWithPoptart poptart:KPPoptart, error:NSError) {
        print("kiip:didStartSessionWithPoptart: \(error.localizedDescription)")
    }
    
    private func kiip(kiip:Kiip, didEndSessionWithError error:NSError) {
        print("kiip:didStartSessionWithPoptart: \(error.localizedDescription)")
    }
    
    func kiip(kiip:Kiip, contentId:NSString, quantity:Int, transactionId:NSString, signature:NSString) {
        print("kiip:didReceiveContent:\(contentId) quantity:\(quantity) transactionId:\(transactionId) signature:\(signature)");
        // Add quantity amount of content to player's profile
        // e.g +20 coins to user's wallet
        // http://docs.kiip.com/en/guide/android.html#getting_virtual_rewards
    }
}

