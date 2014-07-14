package me.kiip.customsample;

import android.os.Bundle;
import android.view.View;
import android.view.animation.AlphaAnimation;
import android.view.animation.Animation;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.Spinner;
import me.kiip.basekiiputils.BaseFragmentActivity;
import me.kiip.basekiiputils.KiipHelper;
import me.kiip.sdk.Kiip;
import me.kiip.sdk.Notification;
import me.kiip.sdk.Poptart;

public class MainActivity extends BaseFragmentActivity {

    private static final int TYPE_DEFAULT = 0;
    private static final int TYPE_CUSTOM = 1;
    private static final int TYPE_INTEGRATED = 2;

    int mNotificationType = TYPE_DEFAULT;

    EditText mMomentId;
    BaseNotificationView mIntegratedNotification;
    Poptart mIntegratedPoptart;

    // Notification type dropdown listener
    AdapterView.OnItemSelectedListener mOnItemSelectedListener = new AdapterView.OnItemSelectedListener() {
        @Override
        public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
            mNotificationType = position;

            // Enable custom notification if the type is TYPE_CUSTOM.
            ((CustomApplication)getApplication()).setEnableCustomNotification(mNotificationType == TYPE_CUSTOM);
        }

        @Override
        public void onNothingSelected(AdapterView<?> parent) {
            // no-op
        }
    };

    View.OnClickListener mOnClickListener = new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            int id = v.getId();

            // Clicked "Save Moment"
            if (id == R.id.btn_moment) {
                String momentId = mMomentId.getText().toString();

                // Uses mDefaultCallback for TYPE_DEFAULT,
                // mIntegratedCallback for TYPE_INTEGRATED.
                Kiip.getInstance().saveMoment(momentId,
                        mNotificationType != TYPE_INTEGRATED
                            ? mDefaultCallback
                            : mIntegratedCallback);
            }

            // Clicked integrated notification
            else if (id == R.id.integrated_notification) {
                if (mIntegratedPoptart != null) {
                    // Show the saved poptart. We don't use KiipHelper because
                    // we don't need this to be managed by KiipHelper's queue.
                    mIntegratedPoptart.show(MainActivity.this);

                    // Dismiss the integrated notification
                    dismissIntegratedNotification();
                }
            }
        }
    };

    Kiip.Callback mDefaultCallback = new Kiip.Callback() {
        @Override
        public void onFailed(Kiip kiip, Exception e) {
            showError(e);
        }

        @Override
        public void onFinished(Kiip kiip, Poptart poptart) {
            showPoptart(poptart);
        }
    };

    Kiip.Callback mIntegratedCallback = new Kiip.Callback() {
        @Override
        public void onFailed(Kiip kiip, Exception e) {
            showError(e);
        }

        @Override
        public void onFinished(Kiip kiip, Poptart poptart) {
            if (poptart != null && mIntegratedPoptart == null) {
                // Show the integrated notification
                showIntegratedNotification(poptart);
            }
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // Find views
        mMomentId = (EditText)findViewById(R.id.moment_id);
        Spinner spinner = (Spinner)findViewById(R.id.notification_type);
        mIntegratedNotification = (BaseNotificationView)findViewById(R.id.integrated_notification);

        // Set up views
        ArrayAdapter<CharSequence> adapter = ArrayAdapter.createFromResource(this,
                R.array.types_array, android.R.layout.simple_spinner_item);
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spinner.setAdapter(adapter);
        spinner.setOnItemSelectedListener(mOnItemSelectedListener);

        findViewById(R.id.btn_moment).setOnClickListener(mOnClickListener);

        mIntegratedNotification.setVisibility(View.INVISIBLE);
        mIntegratedNotification.setOnClickListener(mOnClickListener);
    }

    /**
     * Shows the integrated notification in the layout.
     * @param poptart
     */
    private void showIntegratedNotification(Poptart poptart) {
        // Set integrated notification properties
        Notification notification = poptart.getNotification();
        mIntegratedNotification.setIcon(notification.getIcon());
        mIntegratedNotification.setTitle(notification.getTitle());
        mIntegratedNotification.setMessage(notification.getMessage());

        // Show
        AlphaAnimation anim = new AlphaAnimation(0.0f, 1.0f);
        anim.setDuration(300);
        mIntegratedNotification.startAnimation(anim);
        mIntegratedNotification.setVisibility(View.VISIBLE);

        // We want to go direct to fullscreen when the user clicks our integrated notification
        poptart.setNotification(null);

        // Save the poptart to show later
        mIntegratedPoptart = poptart;
    }

    /**
     * Dismisses the integrated notification in the layout.
     */
    private void dismissIntegratedNotification() {
        // Clear reference to saved poptart
        mIntegratedPoptart = null;

        //Dismiss
        AlphaAnimation anim = new AlphaAnimation(1.0f, 0.0f);
        anim.setDuration(300);
        anim.setAnimationListener(new Animation.AnimationListener() {
            @Override
            public void onAnimationStart(Animation animation) {
            }

            @Override
            public void onAnimationEnd(Animation animation) {
                mIntegratedNotification.setVisibility(View.INVISIBLE);
            }

            @Override
            public void onAnimationRepeat(Animation animation) {
            }
        });
        mIntegratedNotification.startAnimation(anim);
    }

    // Session Listeners

    @Override
    public void onStartSession(KiipHelper kiipHelper, Poptart poptart, Exception e) {
        if (poptart != null) {
            showPoptart(poptart);
        }
        if (e != null) {
            showError(e);
        }
    }

    @Override
    public void onEndSession(KiipHelper kiipHelper, Exception e) {
        // no-op
    }

    private void showError(Exception exception) {
        getKiipHelper().showAlert("Kiip Error", exception);
    }
}
