//
//  ViewController.swift
//  KiipSwiftSample
//
//  Created by encore on 30/11/18.
//  Copyright © 2018 Kiip. All rights reserved.
//

import UIKit
import KiipSDK

class ViewController: UIViewController,KPPoptartDelegate,KPModalDelegate {
    var customNotificationView: KPCustomNotificationView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "KiipSwiftSample"
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func actionInterstitial(_ sender: Any) {
        
        let handler: ((KPPoptart?, Error?) -> Void)? = { poptart, error in
            if error != nil {
                let alertController = UIAlertController(title: "Title", message: error?.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertController, animated: true)
            }
            poptart?.delegate = self
            if poptart?.modal != nil {
                poptart?.modal.delegate = self
            }
            poptart?.show()
        }
        
        Kiip.sharedInstance().saveMoment("t", withCompletionHandler: handler)
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    
    //Tells the delegate a Poptart will be presented.
    
    func willPresent(_ poptart: KPPoptart!) {
        
    }
    
    // Tells the delegate a Poptart was dismissed.

    func didDismiss(_ poptart: KPPoptart!) {
        
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func willPresent(_ modal: KPModal!) {
    
    }
    
    func didDismiss(_ modal: KPModal!) {
        
    }
    
    @IBAction func actionNotification(_ sender: Any) {
        Kiip.sharedInstance().notificationView = nil
        Kiip.sharedInstance().saveMoment("test", withCompletionHandler: nil)
    }
    
    
    @IBAction func actionCustomNotification(_ sender: Any) {
        
        customNotificationView = KPCustomNotificationView(frame: CGRect.zero)
        Kiip.sharedInstance().notificationView = customNotificationView
        Kiip.sharedInstance().saveMoment("test", withCompletionHandler: nil)
        
    }
    
    @IBAction func actionSwitchTestMode(_ sender: Any) {
        Kiip.sharedInstance().testMode = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

