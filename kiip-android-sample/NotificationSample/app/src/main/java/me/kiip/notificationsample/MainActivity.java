package me.kiip.notificationsample;

import android.content.Context;
import android.content.DialogInterface;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;

import me.kiip.sdk.Kiip;
import me.kiip.sdk.Notification;
import me.kiip.sdk.Poptart;

public class MainActivity extends AppCompatActivity implements View.OnClickListener{
    Button default_notification;
    Button custom_notification;
    Kiip.KiipAdapter mKiipAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        default_notification = findViewById(R.id.default_notification);
        default_notification.setOnClickListener(this);
        custom_notification = findViewById(R.id.custom_notification);
        custom_notification.setOnClickListener(this);

        //Set up your custom notification
        mKiipAdapter = new Kiip.KiipAdapter() {
            @Override
            public View getNotificationView(Context context, ViewGroup parent, Poptart poptart) {
                // Note: make sure you pass in parent and attachedToRoot=false so that the view's
                // width and height are correctly inflated.
                BaseNotificationView mIntegratedNotification = (BaseNotificationView) LayoutInflater.from(context).inflate(R.layout.notification_custom, parent, false);

                // Set custom notification properties.
                Notification notification = poptart.getNotification();
                if (notification != null) {
                    mIntegratedNotification.setIcon(notification.getIcon());
                    mIntegratedNotification.setTitle(notification.getTitle());
                    mIntegratedNotification.setMessage(notification.getMessage());
                }

                return mIntegratedNotification;
            }
        };

    }

    @Override
    public void onClick(View view) {
        switch (view.getId()) {

            /**
             * If you are using the default notification, you can ignore the Kiip.getInstance().setAdapter
             */
            case R.id.default_notification:
                Kiip.getInstance().saveMoment("Your moment ID", new Kiip.Callback() {
                @Override
                public void onFailed(Kiip kiip, Exception e) {

                }

                @Override
                public void onFinished(Kiip kiip, Poptart poptart) {
                    if (poptart!=null) {

                        poptart.setOnShowListener(new DialogInterface.OnShowListener() {
                            @Override
                            public void onShow(DialogInterface dialogInterface) {

                            }
                        });
                        //don't need to use Kiip.getInstance().setAdapter(null)
                        //if you haven't implemented the custom notification
                        Kiip.getInstance().setAdapter(null);
                        poptart.show(MainActivity.this);

                        poptart.setOnDismissListener(new DialogInterface.OnDismissListener() {
                            @Override
                            public void onDismiss(DialogInterface dialogInterface) {

                            }
                        });
                    }
                }
            });
                break;

            /**
             * Inorder to use the custom notification, you need set the Kiip.getInstance().setAdapter()
             */
            case R.id.custom_notification:
                Kiip.getInstance().saveMoment("Your moment ID", new Kiip.Callback() {
                    @Override
                    public void onFailed(Kiip kiip, Exception e) {

                    }

                    @Override
                    public void onFinished(Kiip kiip, Poptart poptart) {
                        Kiip.getInstance().setAdapter(mKiipAdapter);
                        poptart.show(MainActivity.this);
                    }
                });
                break;
            default:
                break;
        }
    }


    @Override
    protected void onStart() {
        super.onStart();
        Kiip.getInstance().startSession(new Kiip.Callback() {
            @Override
            public void onFailed(Kiip kiip, Exception e) {
            }

            @Override
            public void onFinished(Kiip kiip, Poptart poptart) {
                if (poptart != null) poptart.show(MainActivity.this);
            }
        });
    }

    @Override
    protected void onStop() {
        super.onStop();
        Kiip.getInstance().endSession(new Kiip.Callback() {
            @Override
            public void onFailed(Kiip kiip, Exception e) {

            }

            @Override
            public void onFinished(Kiip kiip, Poptart poptart) {

            }
        });
    }
}
