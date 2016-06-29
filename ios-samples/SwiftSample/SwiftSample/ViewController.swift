//
//  ViewController.swift
//  SwiftSample
//
//  Created by Suman Raj Venkatesan on 11/19/15.
//  Copyright © 2015 Kiip Inc.,. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnSaveMoment: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initButton()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initButton() {
        btnSaveMoment.backgroundColor = UIColor.yellowColor()
        btnSaveMoment.layer.cornerRadius = 5
        btnSaveMoment.layer.borderWidth = 1
        btnSaveMoment.layer.borderColor = self.view.tintColor.CGColor
        btnSaveMoment.titleEdgeInsets = UIEdgeInsets.init(top: 2, left: 2, bottom: 2, right: 2)
    }
    
    @IBAction func tapSaveMoment(sender: AnyObject) {
        Kiip.sharedInstance().saveMoment("test") { (poptart:KPPoptart!, error:NSError!) -> Void in
            if ((poptart) != nil) {
                poptart.show();
            }
        }
    }

}

