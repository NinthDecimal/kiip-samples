package me.kiip.kiipfragmentexample;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import me.kiip.sdk.Kiip;
import me.kiip.sdk.Poptart;

//This App is for those who are targeting devices before API 11 and using Fragment V4
public class MainActivity extends BaseFragmentActivity implements View.OnClickListener{

    EditText etMomentId;
    Button btSaveMoment;
    TextView tvKiipSDKVersion;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        etMomentId = findViewById(R.id.et_moment_id);
        btSaveMoment = findViewById(R.id.bt_save_moment);
        btSaveMoment.setOnClickListener(this);

        tvKiipSDKVersion = findViewById(R.id.tv_version);
        tvKiipSDKVersion.setText(Kiip.VERSION);
    }

    @Override
    public void onStartSession(KiipHelper helper, Poptart poptart, Exception exception) {
        //As far as you don't receive any errors here, you are fine.
        if (exception != null) {
            exception.getMessage();
        }
    }

    @Override
    public void onEndSession(KiipHelper helper, Exception exception) {
        //As far as you don't receive any errors here, you are fine.
        if (exception != null) {
            exception.getMessage();
        }
    }

    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.bt_save_moment:
                saveMomentCall();
                break;
            default:
                break;
        }
    }

    private void saveMomentCall() {
        String moment = etMomentId.getText().toString();
        if (moment.length() > 0) {
            Kiip.getInstance().saveMoment(moment, new Kiip.Callback() {
                @Override
                public void onFailed(Kiip kiip, Exception e) {
                    if (e != null) e.getMessage();
                }

                @Override
                public void onFinished(Kiip kiip, Poptart poptart) {
                    if (poptart != null) showPoptart(poptart);
                }
            });
        }
    }
}
