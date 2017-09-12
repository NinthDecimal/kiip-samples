package me.kiip.dev.nativead;

import android.app.Application;

import me.kiip.sdk.Kiip;

/**
 * Created by suman on 10/26/16.
 */

public class NativeAdApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        // Initialization logic goes here!
        Kiip.init(this,"<APP_KEY>", "<APP_SECRET>");
        // To test Kiip advertisement banner (WARNING: THIS IS ONLY FOR THE DEVELOPMENT PURPOSE)
        // COMMENT THIS OUT IN PRODUCTION
        //Kiip.getInstance().setTestMode(true);
    }
}