package me.kiip.customsample;

import android.app.Application;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import java.util.LinkedList;

import me.kiip.sdk.Kiip;
import me.kiip.sdk.KiipFragmentCompat;
import me.kiip.sdk.Notification;
import me.kiip.sdk.Poptart;

/**
 * User: Grantland Chew <grantlandchew@gmail.com>
 * Date: 7/9/13
 * Time: 4:36 PM
 */
public class CustomApplication extends Application  {
    //    private static final String APP_KEY = "my_app_key";
    private static final String APP_KEY = "a74e0f59ac62b69290c26fc5dc9381de";
    //    private static final String APP_SECRET = "my_app_secret";
    private static final String APP_SECRET = "0495aa4d5330e7e101de6c3a2e93b395";

    Kiip.KiipAdapter mAdapter = new Kiip.KiipAdapter() {
        @Override
        public View getNotificationView(Context context, ViewGroup parent, Poptart poptart) {
            // Note: make sure you pass in parent and attachedToRoot=false so that the view's
            // width and height are correctly inflated.
            BaseNotificationView view = (BaseNotificationView)LayoutInflater.from(context).inflate(R.layout.notification_custom, parent, false);

            // Set custom notification properties.
            Notification notification = poptart.getNotification();
            if (notification != null) {
                view.setIcon(notification.getIcon());
                view.setTitle(notification.getTitle());
                view.setMessage(notification.getMessage());
            }

            return view;
        }
    };

    @Override
    public void onCreate() {
        super.onCreate();

        // Set a global poptart queue to persist poptarts across Activities.
        KiipFragmentCompat.setDefaultQueue(new LinkedList<Poptart>());

        // Instantiate and set the shared Kiip instance.
        Kiip.init(this, APP_KEY, APP_SECRET);
        // Usually the KiipAdapter is set here, but for the sake of this sample it is called in
        // setEnableCustomNotification.
        // kiip.setAdapter(mAdapter);

        // To test Kiip advertisement banner (WARNING: THIS IS ONLY FOR THE DEVELOPMENT PURPOSE)
        // COMMENT THIS OUT IN PRODUCTION
        //Kiip.getInstance().setTestMode(true);
    }

    public void setEnableCustomNotification(boolean enabled) {
        // Usually this would be set right after Kiip.init, but since this
        // sample allows enabling/disabling, we have it here.
        Kiip.getInstance().setAdapter(enabled ? mAdapter : null);
    }

}
