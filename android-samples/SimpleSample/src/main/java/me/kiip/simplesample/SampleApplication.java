package me.kiip.simplesample;

import android.app.Application;
import android.util.Log;

import java.util.LinkedList;

import me.kiip.sdk.Kiip;
import me.kiip.sdk.Kiip.OnContentListener;
import me.kiip.sdk.KiipFragmentCompat;
import me.kiip.sdk.Poptart;

/**
 * User: Grantland Chew <grantlandchew@gmail.com>
 * Date: 7/9/13
 * Time: 4:36 PM
 */
public class SampleApplication extends Application implements OnContentListener {

    public static final String TAG = "kiip";
//    private static final String APP_KEY = "my_app_key";
    private static final String APP_KEY = "a74e0f59ac62b69290c26fc5dc9381de";
//    private static final String APP_SECRET = "my_app_secret";
    private static final String APP_SECRET = "0495aa4d5330e7e101de6c3a2e93b395";

    @Override
    public void onCreate() {
        super.onCreate();

        // Set a global poptart queue to persist poptarts across Activities
        KiipFragmentCompat.setDefaultQueue(new LinkedList<Poptart>());

        // Instantiate and set the shared Kiip instance
        Kiip.init(this, APP_KEY, APP_SECRET);

        // Listen for Kiip events
        Kiip.getInstance().setOnContentListener(this);

        // To test Kiip advertisement banner (WARNING: THIS IS ONLY FOR THE DEVELOPMENT PURPOSE)
        // COMMENT THIS OUT IN PRODUCTION
        Kiip.getInstance().setTestMode(true);
    }

    @Override
    public void onContent(Kiip kiip, String s, int i, String s1, String s2) {
        Log.d(TAG, "onContent content=" + s + " quantity=" + i + " transactionId=" + s1 + " signature=" + s2);
        // Add quantity amount of content to player's profile
        // e.g +20 coins to user's wallet
        // http://docs.kiip.com/en/guide/android.html#getting_virtual_rewards
    }
    //region Content listener

    //endregion
}
