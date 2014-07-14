package me.kiip.basekiiputils;

import android.app.AlertDialog;
import android.content.Context;
import android.support.v4.app.FragmentActivity;
import android.util.Log;
import me.kiip.sdk.Kiip;
import me.kiip.sdk.KiipFragmentCompat;
import me.kiip.sdk.Poptart;

/**
 * User: Grantland Chew <grantlandchew@gmail.com>
 * Date: 7/10/13
 * Time: 5:14 PM
 */
public class KiipHelper {

    private static final String KIIP_FRAGMENT_TAG = "kiip_fragment_tag";

    private boolean mDebugLog = false;
    private String mDebugTag = "KiipHelper";

    private KiipFragmentCompat mKiipFragment;
    private Listener mListener;

    public KiipHelper(Context context, Listener listener) {
        mListener = listener;
    }

    public void onCreate(Context context) {
        if (!(context instanceof FragmentActivity)) {
            throw new RuntimeException("KiipHelper#onCreate requires FragmentActivity");
        }
        FragmentActivity activity = (FragmentActivity)context;

        // Create or re-use KiipFragment.
        mKiipFragment = (KiipFragmentCompat) activity.getSupportFragmentManager().findFragmentByTag(KIIP_FRAGMENT_TAG);
        if (mKiipFragment == null) {
            mKiipFragment = new KiipFragmentCompat();
            activity.getSupportFragmentManager().beginTransaction().add(mKiipFragment, KIIP_FRAGMENT_TAG).commit();
        }
    }

    public void onStart(Context context) {
        // Must call startSession in every Activity#onStart.
        debugLog("onStart.");
        Kiip.getInstance().startSession(new Kiip.Callback() {
            @Override
            public void onFailed(Kiip kiip, Exception exception) {
                debugLog("onStart: Failed to start session: " + exception + ".");
                if (mListener != null) {
                    mListener.onStartSession(KiipHelper.this, null, exception);
                }
            }

            @Override
            public void onFinished(Kiip kiip, Poptart poptart) {
                debugLog("onStart: Started session.");
                if (kiip != null && mListener != null) {
                    mListener.onStartSession(KiipHelper.this, poptart, null);
                }
                getKiipFragment().showPoptart(poptart);
            }
        });
    }

    public void onStop(Context context) {
        // Must call endSession in every Activity#onStop.
        debugLog("onStop.");
        Kiip.getInstance().endSession(new Kiip.Callback() {
            @Override
            public void onFailed(Kiip kiip, Exception exception) {
                debugLog("onStop: Failed to end session: " + exception + ".");
                if (mListener != null) {
                    mListener.onEndSession(KiipHelper.this, exception);
                }
            }

            @Override
            public void onFinished(Kiip kiip, Poptart poptart) {
                debugLog("onStop: Ended session.");
                if (kiip != null && mListener != null) {
                    mListener.onEndSession(KiipHelper.this, null);
                }
            }
        });
    }

    private Context getContext() {
        return mKiipFragment.getActivity();
    }

    public KiipFragmentCompat getKiipFragment() {
        return mKiipFragment;
    }

    public void showAlert(String title, String message) {
        new AlertDialog.Builder(getContext())
                .setTitle(title)
                .setMessage(message)
                .setNeutralButton(android.R.string.ok, null)
                .create()
                .show();
    }

    public void showAlert(String title, Exception exception) {
        String message = exception.getMessage();
        if (message == null) {
            message = exception.getClass().getSimpleName();
        }
        showAlert(title, message);
    }

    public void showAlert(String message) {
        showAlert(null, message);
    }

    public void enableDebugLogging(boolean enabled, String tag) {
        mDebugLog = enabled;
        mDebugTag = tag;
    }

    private void debugLog(String message) {
        if (mDebugLog) {
            Log.d(mDebugTag, message);
        }
    }

    public static interface Listener {
        void onStartSession(KiipHelper helper, Poptart poptart, Exception exception);
        void onEndSession(KiipHelper helper, Exception exception);
    }
}
