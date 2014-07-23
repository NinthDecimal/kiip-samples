/*
    Copyright (C) 2014 Kiip, Inc. All Rights Reserved.

    Abstract:

                The application-specific delegate class.

*/

@UIApplicationMain
class AppDelegate: NSObject, UIApplicationDelegate, KiipDelegate {
    // MARK: Properties

    var window: UIWindow?
    let KP_APP_KEY = "3b46e5f42299f1697193bb843ed8dbf4"
    let KP_APP_SECRET = "90c4f68ebb4817b3edf24799b04df22c"

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary) -> Bool {
        // Override point for customization after application launch.

        var kiip: Kiip = Kiip(appKey:KP_APP_KEY, andSecret:KP_APP_SECRET);

        // Listen for Kiip events
        kiip.delegate = self;

        Kiip.setSharedInstance(kiip);

        return true;
    }

    func showError(error:NSError) {
        var alert = UIAlertController(title:"Error", message:error.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.window?.rootViewController.presentViewController(alert, animated: true, completion: nil)
    }

    func kiip(kiip:Kiip, didStartSessionWithPoptart poptart:KPPoptart, error:NSError) {
        NSLog("kiip:didStartSessionWithPoptart:%@ error:%@", poptart, error);

        if nil != error {
            self.showError(error);
        }

        // Since we've implemented this delegate method, Kiip will no longer show the poptart automatically
        poptart.show();
    }

    func kiip(kiip:Kiip, didEndSessionWithError error:NSError) {
        NSLog("kiip:didEndSessionWithError:%@", error);

        if nil != error {
            self.showError(error);
        }
    }

    func kiip(kiip:Kiip, contentId:NSString, quantity:Int, transactionId:NSString, signature:NSString) {

        NSLog("kiip:didReceiveContent:%@ quantity:%d transactionId:%@ signature:%@", contentId, quantity, transactionId, signature);

        // Add quantity amount of content to player's profile
        // e.g +20 coins to user's wallet
        // http://docs.kiip.com/en/guide/android.html#getting_virtual_rewards
    }
}
