/*
    Copyright (C) 2014 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    
                A view controller that demonstrates how to use UITextField.
            
*/

class SampleViewController: UIViewController, UITextFieldDelegate {
    // MARK: Properties

    @IBOutlet var momentIdField: UITextField
    @IBOutlet var momentValueField: UITextField
    @IBOutlet var saveMoment: UIButton
    @IBOutlet var deviceLabel: UILabel

    // Mark: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // You can add your Device ID to your Developer Console to receive test rewards
        // http://app.kiip.me
        var deviceIdentifier:String = Kiip.sharedInstance().deviceIdentifier
        println("deviceIdentifier = \(deviceIdentifier)")
        self.deviceLabel.text = "Device ID: \(deviceIdentifier)"

        self.momentIdField.delegate = self
        self.momentValueField.delegate = self
        self.saveMoment.addTarget(self, action:Selector("onClick"), forControlEvents:UIControlEvents.TouchUpInside)

        
        var tapGesture = UITapGestureRecognizer(target: self, action: Selector("dismissKeyboard"))
        self.view.addGestureRecognizer(tapGesture)
    }

    // MARK: UITextFieldDelegate
    
    func onClick(sender:AnyObject) {
        // Save moment
        // http://docs.kiip.com/en/guide/android.html#getting_rewards
        if sender.isEqual(self.saveMoment) {
            self.dismissKeyboard()
    
            var momentId:String = self.momentIdField.text
            var momentValue:NSString = self.momentValueField.text

            Kiip.sharedInstance().saveMoment(momentId, value:momentValue.doubleValue, withCompletionHandler:{(poptart:KPPoptart!, error:NSError!) -> Void in
                    if error {
                        self.showError(error)
                    }

                    // Since we've implemented this block, Kiip will no longer show the poptart automatically
                    // WARNING: poptart may be nil if no reward was given
                    poptart.show()
                })
        }
    }
    
    func showError(error:NSError) {
        var alert = UIAlertController(title:"Error", message:error.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(textField:UITextField) -> Bool  {
        if self.momentIdField == textField {
            self.momentValueField.becomeFirstResponder()
        }
        else if self.momentValueField == textField {
            textField.resignFirstResponder()
        }
    
        return false
    }
    
    func dismissKeyboard() {
        self.momentIdField.resignFirstResponder()
        self.momentValueField.resignFirstResponder()
    }

    // MARK: Actions
}
