package me.kiip.dev.kiipsimpledemo;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.os.Bundle;

import me.kiip.sdk.Kiip;

public class KiipDemoApplication extends Application {

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
        Kiip.init(this, "3b46e5f42299f1697193bb843ed8dbf4", "90c4f68ebb4817b3edf24799b04df22c");
        Kiip.getInstance().setTestMode(true);
    }
}
