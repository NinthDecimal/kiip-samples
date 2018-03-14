package me.kiip.kiipfragmentexample;

import android.app.Application;

import java.util.LinkedList;

import me.kiip.sdk.Kiip;
import me.kiip.sdk.KiipFragmentCompat;
import me.kiip.sdk.Poptart;

/**
 * Created by desy on 3/13/18.
 */

public class KiipBaseApplication extends Application {
    private static final String APP_KEY = "YOUR APP KEY";
    private static final String APP_SECRET = "YOUR APP SECRET";

    @Override
    public void onCreate() {
        super.onCreate();

        // Set a global poptart queue to persist poptarts across Activities
        KiipFragmentCompat.setDefaultQueue(new LinkedList<Poptart>());

        Kiip.init(this, APP_KEY, APP_SECRET);
        //Uncommit this to test the AD
//        Kiip.getInstance().setTestMode(true);

    }
}
