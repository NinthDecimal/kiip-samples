package me.kiip.simplesample;

import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.EditText;
import android.widget.Toast;
import me.kiip.basekiiputils.BaseFragmentActivity;
import me.kiip.basekiiputils.KiipHelper;
import me.kiip.sdk.*;

public class MainActivity extends BaseFragmentActivity implements DialogInterface.OnShowListener, DialogInterface.OnDismissListener,
        Notification.OnShowListener, Notification.OnClickListener, Notification.OnDismissListener,
        Modal.OnShowListener, Modal.OnDismissListener {

    private static final String TAG = "MainActivity";

    EditText mMomentId;
    EditText mMomentValue;

    OnClickListener mOnClickListener = new OnClickListener() {
        @Override
        public void onClick(View v) {
            int id = v.getId();

            // Save moment
            // http://docs.kiip.com/en/guide/android.html#getting_rewards
            if (id == R.id.btn_moment) {
                try {
                    final String momentId = mMomentId.getText().toString();
                    Double momentValue = mMomentValue.getText().length() > 0 ? Double.valueOf(mMomentValue.getText().toString()) : null;

                    // Delegate to be called after Kiip#saveMoment is complete
                    Kiip.Callback cb = new Kiip.Callback() {
                        @Override
                        public void onFailed(Kiip kiip, Exception exception) {
                            Log.e(TAG, "Failed to save moment " + momentId, exception);

                            showError(exception);
                        }

                        @Override
                        public void onFinished(Kiip kiip, Poptart poptart) {
                            Log.d(TAG, "Moment saved poptart=" + poptart);
                            // WARNING: poptart may be null if no reward was given, but
                            // KiipHelper#showPoptart checks for this
                            showPoptart(poptart);
                        }
                    };

                    if (momentValue == null) {
                        Kiip.getInstance().saveMoment(momentId, cb);
                    } else {
                        Kiip.getInstance().saveMoment(momentId, momentValue.doubleValue(), cb);
                    }
                } catch (NumberFormatException e) {
                    Toast.makeText(MainActivity.this, "Invalid moment_value", Toast.LENGTH_LONG).show();
                }
            }

            // Show promo
            else if (id == R.id.btn_promo) {
                Kiip.getInstance().getPromo(MainActivity.this, new Kiip.OnPromoListener() {
                    @Override
                    public void onPromo(Kiip kiip, Promo promo) {
                        Log.d(TAG, "onPromo " + promo);
                        if (promo != null) {
                            promo.show();
                        }
                    }
                });
            }

            // Start new activity
            // KiipHelper helps persist Kiip views across Activity switching
            else if (id == R.id.btn_start) {
                startActivity(new Intent(MainActivity.this, SecondaryActivity.class));
            }
        }
    };

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main_activity);

        mMomentId = (EditText) findViewById(R.id.moment_id);
        mMomentValue = (EditText)findViewById(R.id.moment_value);

        final int[] clickables = {
                R.id.btn_moment,
                R.id.btn_promo,
                R.id.btn_start
        };
        for (int id : clickables) {
            findViewById(id).setOnClickListener(mOnClickListener);
        }

        // Listen for poptart events
        getKiipHelper().getKiipFragment().setOnShowListener(this);
        getKiipHelper().getKiipFragment().setOnDismissListener(this);
    }

    // Session Listeners from extending BaseFragmentActivity

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

    // Poptart listeners from implements

    @Override
    public void onShow(DialogInterface dialog) {
        Log.d(TAG, "Poptart#onShow");

        final Poptart poptart = (Poptart)dialog;
        final Notification notification = poptart.getNotification();
        final Modal modal = poptart.getModal();

        // Listen for notification events
        if (notification != null) {
            notification.setOnShowListener(this);
            notification.setOnClickListener(this);
            notification.setOnDismissListener(this);
        }

        // Listen for modal events
        if (modal != null) {
            modal.setOnShowListener(this);
            modal.setOnDismissListener(this);
        }
    }


    @Override
    public void onDismiss(DialogInterface dialog) {
        Log.d(TAG, "Poptart#onDismiss");
    }

    @Override
    public void onShow(Notification notification) {
        Log.d(TAG, "Notification#onShow");
    }

    @Override
    public void onClick(Notification notification) {
        Log.d(TAG, "Notification#onClick");
    }

    @Override
    public void onDismiss(Notification notification) {
        Log.d(TAG, "Notification#onDismiss");
    }

    @Override
    public void onShow(Modal modal) {
        Log.d(TAG, "Modal#onShow");
    }

    @Override
    public void onDismiss(Modal modal) {
        Log.d(TAG, "Modal#onDismiss");
    }

    private void showError(Exception exception) {
        getKiipHelper().showAlert("Kiip Error", exception);
    }
}
