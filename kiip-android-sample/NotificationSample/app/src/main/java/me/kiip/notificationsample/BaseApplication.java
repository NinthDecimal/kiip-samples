package me.kiip.notificationsample;

import android.app.Application;
import android.util.Log;

import me.kiip.sdk.Kiip;


public class BaseApplication extends Application implements Kiip.OnContentListener{
    public static final String TAG = "kiip";
    private final static String app_key = "Your App Key";
    private final static String app_secret = "Your App Secret";

    @Override
    public void onCreate() {
        super.onCreate();
        Kiip.init(this, app_key, app_secret);
        Kiip.getInstance().setOnContentListener(this);
        Kiip.getInstance().setTestMode(true);
    }

    @Override
    public void onContent(Kiip kiip, String contentId, int quantity, String transactionId, String signature) {
        Log.d(TAG, "onContent received= " + quantity );
    }
}
