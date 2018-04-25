//
//  NativeView.swift
//  KiipSwiftSample
//
//  Created by Daniel on 4/25/18.
//  Copyright © 2018 Kiip, Inc. All rights reserved.
//

import Foundation


class KiipNativeView: UIViewController {
    
    //native view placeholder
    //it's recommended that you setup the reward as native (not default)
    //please check your Kiip app dashboard moments.

    var nativeView: KPNativeRewardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //check the KPNativeRewardView init
        nativeView = KPNativeRewardView.init(cGpoint: CGPoint(x: 30, y: 200));
        //indicate where the ad will show by coloring background (not necessary to do this)
        nativeView.backgroundColor = UIColor.darkGray
        self.view.addSubview(nativeView)
    }
    

    @IBAction func showNativeView(_ sender: UIButton) {
        Kiip.sharedInstance().saveMoment("<Your Moment ID>") { (poptart, error) -> Void in
            if (poptart != nil) {
                //instead of just show(), we wil pass the KPNativeRewardView
                poptart?.show(self.nativeView)
            }
        }
    }
}
