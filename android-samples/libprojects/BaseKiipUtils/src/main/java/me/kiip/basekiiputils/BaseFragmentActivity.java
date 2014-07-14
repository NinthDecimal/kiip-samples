package me.kiip.basekiiputils;

import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import me.kiip.sdk.Poptart;

public abstract class BaseFragmentActivity extends FragmentActivity implements KiipHelper.Listener {

    private KiipHelper mKiipHelper;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        mKiipHelper = new KiipHelper(this, this);
        mKiipHelper.onCreate(this);
    }

    @Override
    protected void onStart() {
        super.onStart();
        mKiipHelper.onStart(this);
    }

    @Override
    protected void onStop() {
        super.onStop();
        mKiipHelper.onStop(this);
    }

    public KiipHelper getKiipHelper() {
        return mKiipHelper;
    }

    public void showPoptart(Poptart poptart) {
        mKiipHelper.getKiipFragment().showPoptart(poptart);
    }
}
