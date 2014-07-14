package me.kiip.customsample;

import android.app.Application;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import me.kiip.sdk.Kiip;
import me.kiip.sdk.KiipFragmentCompat;
import me.kiip.sdk.Notification;
import me.kiip.sdk.Poptart;

import java.util.LinkedList;

/**
 * User: Grantland Chew <grantlandchew@gmail.com>
 * Date: 7/9/13
 * Time: 4:36 PM
 */
public class CustomApplication extends Application {

    private static final String APP_KEY = "my_app_key";
    private static final String APP_SECRET = "my_app_secret";

    Kiip.KiipAdapter mAdapter = new Kiip.KiipAdapter() {
        @Override
        public View getNotificationView(Context context, ViewGroup parent, Poptart poptart) {
            // Note: make sure you pass in parent and attachedToRoot=false so that the view's
            // width and height are correctly inflated.
            BaseNotificationView view = (BaseNotificationView)LayoutInflater.from(context).inflate(R.layout.notification_custom, parent, false);

            // Set custom notification properties.
            Notification notification = poptart.getNotification();
            view.setIcon(notification.getIcon());
            view.setTitle(notification.getTitle());
            view.setMessage(notification.getMessage());

            return view;
        }
    };

    @Override
    public void onCreate() {
        super.onCreate();

        // Set a global poptart queue to persist poptarts across Activities.
        KiipFragmentCompat.setDefaultQueue(new LinkedList<Poptart>());

        // Instantiate and set the shared Kiip instance.
        Kiip kiip = Kiip.init(this, APP_KEY, APP_SECRET);
        // Usually the KiipAdapter is set here, but for the sake of this sample it is called in
        // setEnableCustomNotification.
        // kiip.setAdapter(mAdapter);
        Kiip.setInstance(kiip);
    }

    public void setEnableCustomNotification(boolean enabled) {
        // Usually this would be set right after Kiip.init, but since this
        // sample allows enabling/disabling, we have it here.
        Kiip.getInstance().setAdapter(enabled ? mAdapter : null);
    }
}
