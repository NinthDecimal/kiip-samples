package me.kiip.dev.kiipsimpledemo;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

import me.kiip.sdk.Kiip;
import me.kiip.sdk.Poptart;

public class KiipDemoActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_kiip_demo);

        Button saveMomentBtn = (Button)findViewById(R.id.save_moment_btn);
        saveMomentBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Kiip.getInstance().saveMoment("test", new Kiip.Callback() {
                    @Override
                    public void onFailed(Kiip kiip, Exception e) {
                        Toast.makeText(getApplicationContext(), "Save Moment Failed", Toast.LENGTH_SHORT).show();
                    }

                    @Override
                    public void onFinished(Kiip kiip, Poptart poptart) {
                        if (poptart != null) {
                            poptart.show(KiipDemoActivity.this);
                        }
                    }
                });
            }
        });
    }
}
