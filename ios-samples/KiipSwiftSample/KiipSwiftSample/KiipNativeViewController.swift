//
//  KiipNativeViewController.swift
//  KiipSwiftSample
//
//  Created by encore on 30/11/18.
//  Copyright © 2018 Kiip. All rights reserved.
//

import UIKit
import KiipSDK

class KiipNativeViewController: UIViewController,KPPoptartDelegate,KPModalDelegate {
    var nativeRewardView: KPNativeRewardView?

    override func viewDidLoad() {
        super.viewDidLoad()

        nativeRewardView = KPNativeRewardView(cGpoint: CGPoint(x: 20, y: 80), setViewType: viewType.FLUID_RECTANGLE)
        nativeRewardView?.backgroundColor = UIColor.gray
        view.addSubview(nativeRewardView!)
        // Do any additional setup after loading the view.
    }

    @IBAction func actionNativeView(_ sender: Any) {
        
        let handler: ((KPPoptart?, Error?) -> Void)? = { poptart, error in
            if error != nil {
                let alertController = UIAlertController(title: "Title", message: error?.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertController, animated: true)
            }
            
            // Since we've implemented this block, Kiip will no longer show the poptart automatically
            poptart?.delegate = self
            
            if poptart?.modal != nil {
                poptart?.modal.delegate = self
            }
            poptart?.show(self.nativeRewardView)
        }
        Kiip.sharedInstance().saveMoment("d", withCompletionHandler: handler)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
