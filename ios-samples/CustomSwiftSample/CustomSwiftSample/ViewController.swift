//
//  ViewController.swift
//  CustomSwiftSample
//
//  Created by Sahil Verma on 7/23/14.
//  Copyright (c) 2014 kiip. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate,
                      KPNotificationDelegate, KPModalDelegate, KPPoptartDelegate {

    let kRewardDefault = "Default Reward Experience"
    let kNotificationCustom = "Custom Notification"
    let kNotificationIntegrated = "Integrated Notifcation"
    let kPickerViewComponents = 1

    var rewardFlowType : String!
    var pickerDataSource : Array<String>!

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var scrollPicker: UIPickerView!
    @IBOutlet weak var saveMmtButton : UIButton!

    /* Kiip Callback */
    var kpHandler : ((KPPoptart!, NSError!) -> Void)!
    /* Kiip Callback w/ integrated notification */
    var kpHandlerIntegrated : ((KPPoptart!, NSError!) -> Void)!

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

        // Set button target
        saveMmtButton.addTarget(self, action: "saveMmtPressed:", forControlEvents: UIControlEvents.TouchUpInside)

        // Create handler for Kiip save Moment callback
        kpHandler = { (poptart:KPPoptart!, error:NSError!) -> Void in
            if error {
                // no op
            }
            if poptart {

                // Set listeners on poptart
                if (poptart.notification) {
                    poptart.notification.delegate = self
                }
                if (poptart.modal) {
                    poptart.modal.delegate = self
                }
                poptart.delegate = self
                poptart.show()
            }
        }

        // Handler for integrated notification //
        kpHandlerIntegrated = { (poptart:KPPoptart!, error:NSError!) -> Void in
            if error {
                // no op
            }
            if poptart {
                // helper method to show Integrated Notification inside your UI.
                self.showIntegratedNotification(poptart)
            }
        }
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

    //MARK: - TouchUpInside
    func saveMmtPressed(sender: UIButton!) {

        if (rewardFlowType == kRewardDefault) {
            // -- Kiip -- //
            Kiip.sharedInstance().saveMoment("test", kpHandler)
        }

        if (rewardFlowType == kNotificationCustom) {

        }

        if (rewardFlowType == kNotificationIntegrated) {

        }
    }

    //MARK: integrated notification
    func showIntegratedNotification(poptart : KPPoptart!) {

    }

    //MARK: - KPNotificationDelegate
    func willShowNotification(notification: KPNotification!) {
        // will show notification
    }

    func didDismissNotification(notification: KPNotification!) {
        // notification dismissed
    }

    func didDismissNotificationWithClick(notification: KPNotification!) {
        // Notification clicked!
    }

    //MARK: - KPModalDelegate
    func willPresentModal(modal: KPModal!) {
        // will Present Modal
    }

    func didDismissModal(modal: KPModal!) {
        // modal Dismisssed
    }

}