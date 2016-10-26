package me.kiip.dev.nativead;

import android.app.FragmentTransaction;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;

public class NativeMainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        if (savedInstanceState == null) {
            final NativeListViewFragment listViewFragment = new NativeListViewFragment();
            listViewFragment.setArguments(getIntent().getExtras());
            FragmentTransaction ft = getFragmentManager().beginTransaction();
            ft.add(R.id.fragment_container, listViewFragment).commit();
            Log.d("KIIP", "here");
        }
    }
}
