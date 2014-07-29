//
//  AppDelegate.swift
//  CustomSwiftSample
//
//  Created by Sahil Verma on 7/23/14.
//  Copyright (c) 2014 kiip. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, KiipDelegate {
                            
    var window: UIWindow?
    
    let KP_APP_KEY : String = "3b46e5f42299f1697193bb843ed8dbf4"
    let KP_APP_SECRET : String = "90c4f68ebb4817b3edf24799b04df22c"
    
    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
        // Override point for customization after application launch.
        
        /* Kiip init code */
        var kiip: Kiip = Kiip(appKey: KP_APP_KEY, andSecret:KP_APP_SECRET)
        kiip.delegate = self
        /* Kiip init code */

        /* Optional KPCustomNotificationView, commented out because we have a scroll picker.
         * otherwise, you would keep this line.
         */
        // kiip.notificationView = KPCustomNotificationView()

        Kiip.setSharedInstance(kiip)
        return true
    }

    func applicationWillResignActive(application: UIApplication!) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication!) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication!) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication!) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication!) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    //MARK: - Toggle defuault vs custom notification
    func toggleCustomNotification(enabled: Bool) {
        if enabled {
            Kiip.sharedInstance().notificationView = KPCustomNotificationView()
        }
        else {
            Kiip.sharedInstance().notificationView = nil;
        }
    }
}