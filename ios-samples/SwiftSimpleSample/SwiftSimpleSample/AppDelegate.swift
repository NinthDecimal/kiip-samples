/*
    Copyright (C) 2014 Kiip, Inc. All Rights Reserved.

    Abstract:
    
                The application-specific delegate class.
            
*/

@UIApplicationMain
class AppDelegate: NSObject, UIApplicationDelegate, KiipDelegate {
    // MARK: Properties

    var window: UIWindow?
    let KP_APP_KEY = "x"
    let KP_APP_SECRET = "x"

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary) -> Bool {
        // Override point for customization after application launch.

        var kiip: Kiip = Kiip(appKey:KP_APP_KEY, andSecret:KP_APP_SECRET);

        // Listen for Kiip events
        kiip.delegate = self;
        
        Kiip.setSharedInstance(kiip);

        return true;
    }

    func showError(error:NSError) {
        var alert = UIAlertView(title: "Error", message: error.localizedDescription,
                                delegate: nil, cancelButtonTitle: "OK")
        alert.show()
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
