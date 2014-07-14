package me.kiip.simplesample;

import android.app.Application;
import android.util.Log;
import me.kiip.sdk.Kiip;
import me.kiip.sdk.Kiip.OnContentListener;
import me.kiip.sdk.Kiip.OnSwarmListener;
import me.kiip.sdk.KiipFragmentCompat;
import me.kiip.sdk.Poptart;

import java.util.LinkedList;

/**
 * User: Grantland Chew <grantlandchew@gmail.com>
 * Date: 7/9/13
 * Time: 4:36 PM
 */
public class SampleApplication extends Application implements OnSwarmListener, OnContentListener {

    public static final String TAG = "kiip";
    private static final String APP_KEY = "my_app_key";
    private static final String APP_SECRET = "my_app_secret";

    @Override
    public void onCreate() {
        super.onCreate();

        // Set a global poptart queue to persist poptarts across Activities
        KiipFragmentCompat.setDefaultQueue(new LinkedList<Poptart>());

        // Instantiate and set the shared Kiip instance
        Kiip kiip = Kiip.init(this, APP_KEY, APP_SECRET);

        // Listen for Kiip events
        kiip.setOnSwarmListener(this);
        kiip.setOnContentListener(this);

        Kiip.setInstance(kiip);
    }

    // Swarm listener

    @Override
    public void onSwarm(Kiip kiip, String id) {
        Log.d(TAG, "onSwarm id=" + id);

        // Enter "swarm" mode
        // http://docs.kiip.com/en/guide/swarm.html
    }

    // Content listener

    @Override
    public void onContent(Kiip kiip, String content, int quantity, String transactionId, String signature) {
        Log.d(TAG, "onContent content=" + content + " quantity=" + quantity + " transactionId=" + transactionId + " signature=" + signature);

        // Add quantity amount of content to player's profile
        // e.g +20 coins to user's wallet
        // http://docs.kiip.com/en/guide/android.html#getting_virtual_rewards
    }
}
