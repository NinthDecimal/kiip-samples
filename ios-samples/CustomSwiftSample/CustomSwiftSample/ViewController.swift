//
//  ViewController.swift
//  CustomSwiftSample
//
//  Created by Sahil Verma on 7/23/14.
//  Copyright (c) 2014 kiip. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    let kRewardDefault = "Default Reward Experience"
    let kNotificationCustom = "Custom Notification"
    let kNotificationIntegrated = "Integrated Notifcation"
    let kPickerViewComponents = 1

    var rewardFlowType : String!
    var pickerDataSource : Array<String>!

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var scrollPicker: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navBar.topItem.title = "Kiip SDK \(KPVersion)"

        // Set picker view & default reward type
        pickerDataSource = [kRewardDefault,
                            kNotificationCustom,
                            kNotificationIntegrated]
        rewardFlowType = kRewardDefault
        scrollPicker.dataSource = self
        scrollPicker.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - UIPickerViewDataSource
    func numberOfComponentsInPickerView(pV:UIPickerView!) -> Int {
        return kPickerViewComponents
    }

    func pickerView( pV:UIPickerView!,
        numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }

    //MARK: - UIPickerViewDelegate
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerDataSource[row]
    }

    func pickerView(pickerView:UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        rewardFlowType = pickerDataSource[row]
    }

}