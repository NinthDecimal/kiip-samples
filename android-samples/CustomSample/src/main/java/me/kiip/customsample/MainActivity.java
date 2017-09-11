package me.kiip.customsample;

import android.os.Bundle;
import android.view.View;
import android.view.animation.AlphaAnimation;
import android.view.animation.Animation;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import me.kiip.basekiiputils.BaseFragmentActivity;
import me.kiip.basekiiputils.KiipHelper;
import me.kiip.sdk.Kiip;
import me.kiip.sdk.KiipNativeRewardView;
import me.kiip.sdk.Notification;
import me.kiip.sdk.Poptart;

public class MainActivity extends BaseFragmentActivity {

    private static final int TYPE_DEFAULT = 0;
    private static final int TYPE_CUSTOM = 1;
    private static final int TYPE_INTEGRATED = 2;
    private static final int TYPE_NATIVE_REWARD = 3;

    int mNotificationType = TYPE_DEFAULT;

    EditText mMomentId;
    TextView tvVersion;
    BaseNotificationView mIntegratedNotification;
    Poptart mIntegratedPoptart;
    KiipNativeRewardView mRewardView;

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

    // Clicked "Save Moment"
    View.OnClickListener mOnClickListener = new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            int id = v.getId();

            // Uses mDefaultCallback for TYPE_DEFAULT,
            // mIntegratedCallback for TYPE_INTEGRATED,
            // mNativeRewardCallback for TYPE_NATIVE_REWARD.
            if (id == R.id.btn_moment) {
                String momentId = mMomentId.getText().toString();

                switch (mNotificationType) {
                    case TYPE_DEFAULT:
                        Kiip.getInstance().saveMoment(momentId, mDefaultCallback);
                        break;

                    case TYPE_INTEGRATED:
                        Kiip.getInstance().saveMoment(momentId, mIntegratedCallback);
                        break;

                    case TYPE_NATIVE_REWARD:
                        Kiip.getInstance().saveMoment(momentId, mNativeRewardCallback);
                        break;

                    default:
                        break;
                }

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


    /*
    Different Callbacks
     */

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

    Kiip.Callback mNativeRewardCallback = new Kiip.Callback() {
        @Override
        public void onFailed(Kiip kiip, Exception e) {
            Toast.makeText(MainActivity.this, "Native fixed view saveMoment failed.", Toast.LENGTH_SHORT).show();
        }

        @Override
        public void onFinished(Kiip kiip, Poptart poptart) {
            if (poptart != null) {
                poptart.showNativeReward(mRewardView);
            }
        }
    };

    // -----------------------------------------------------------------------------------

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // Find views
        mMomentId = (EditText)findViewById(R.id.moment_id);
        Spinner spinner = (Spinner)findViewById(R.id.notification_type);
        mIntegratedNotification = (BaseNotificationView)findViewById(R.id.integrated_notification);
        mRewardView = (KiipNativeRewardView) findViewById(R.id.kiip_native_reward_view);
        tvVersion = (TextView) findViewById(R.id.tvVersion);

        // Set up views
        ArrayAdapter<CharSequence> adapter = ArrayAdapter.createFromResource(this,
                R.array.types_array, android.R.layout.simple_spinner_item);
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spinner.setAdapter(adapter);
        spinner.setOnItemSelectedListener(mOnItemSelectedListener);

        findViewById(R.id.btn_moment).setOnClickListener(mOnClickListener);

        mIntegratedNotification.setVisibility(View.INVISIBLE);
        mIntegratedNotification.setOnClickListener(mOnClickListener);

        tvVersion.setText(Kiip.VERSION);
    }

    /**
     * Shows the integrated notification in the layout.
     * @param poptart
     */
    private void showIntegratedNotification(Poptart poptart) {
        // Set integrated notification properties
        Notification notification = poptart.getNotification();
        if (notification != null) {
            mIntegratedNotification.setIcon(notification.getIcon());
            mIntegratedNotification.setTitle(notification.getTitle());
            mIntegratedNotification.setMessage(notification.getMessage());
        }

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
