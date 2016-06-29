//
//  AppDelegate.swift
//  SwiftSample
//
//  Created by Suman Raj Venkatesan on 11/19/15.
//  Copyright © 2015 Kiip Inc.,. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, KiipDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let kiip: Kiip = Kiip(appKey:KP_APP_KEY, andSecret:KP_APP_SECRET);
        kiip.testMode = true;
        kiip.delegate = self;
        Kiip.setSharedInstance(kiip);
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

//MARK:-- KiipDelegates --
    
    func kiip(kiip:Kiip, didStartSessionWithPoptart poptart:KPPoptart, error:NSError) {
        print("kiip:didStartSessionWithPoptart: \(error.localizedDescription)")
    }
    
    func kiip(kiip:Kiip, didEndSessionWithError error:NSError) {
        print("kiip:didStartSessionWithPoptart: \(error.localizedDescription)")
    }

    func kiip(kiip:Kiip, contentId:NSString, quantity:Int, transactionId:NSString, signature:NSString) {
        print("kiip:didReceiveContent:\(contentId) quantity:\(quantity) transactionId:\(transactionId) signature:\(signature)");
        // Add quantity amount of content to player's profile
        // e.g +20 coins to user's wallet
        // http://docs.kiip.com/en/guide/android.html#getting_virtual_rewards
    }
}

