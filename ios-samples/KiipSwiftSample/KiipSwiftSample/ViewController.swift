//
//  ViewController.swift
//  KiipSwiftSample
//
//  Created by Daniel on 4/23/18.
//  Copyright © 2018 Kiip, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnSaveMoment: UIButton!
    @IBOutlet weak var showNativeView: UIButton!
    @IBOutlet weak var showTableView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func tapSaveMoment(_ sender: UIButton) {
        if (sender == btnSaveMoment) {
            Kiip.sharedInstance().saveMoment("<Your Moment ID>") { (poptart, error) -> Void in
                //check if there is a reward
                if (error != nil) {
                    NSLog("test", "failed")
                }
                if (poptart != nil) {
                    poptart?.show()
                }
            }
        }
    }

    
    func initButton() {
        btnSaveMoment.backgroundColor = UIColor.yellow;
        btnSaveMoment.layer.cornerRadius = 5
        btnSaveMoment.layer.borderWidth = 1
        btnSaveMoment.layer.borderColor = self.view.tintColor.cgColor
        btnSaveMoment.titleEdgeInsets = UIEdgeInsets.init(top: 2, left: 2, bottom: 2, right: 2)
        
        showNativeView.backgroundColor = UIColor.cyan;
        showNativeView.layer.cornerRadius = 5
        showNativeView.layer.borderWidth = 1
        showNativeView.layer.borderColor = self.view.tintColor.cgColor
        showNativeView.titleEdgeInsets = UIEdgeInsets.init(top: 2, left: 2, bottom: 2, right: 2)
        
        
        showTableView.backgroundColor = UIColor.green;
        showTableView.layer.cornerRadius = 5
        showTableView.layer.borderWidth = 1
        showTableView.layer.borderColor = self.view.tintColor.cgColor
        showTableView.titleEdgeInsets = UIEdgeInsets.init(top: 2, left: 2, bottom: 2, right: 2)
    }
    

}

