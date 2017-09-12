package me.kiip.dev.nativead;

import android.app.Activity;
import android.app.Fragment;
import android.content.Context;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.InputMethodManager;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Locale;

import me.kiip.sdk.KiipRewardAdapter;

/**
 * Created by suman on 10/26/16.
 */

public class NativeListViewFragment extends Fragment {

    private KiipRewardAdapter mKiipRewardAdapter;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        super.onCreateView(inflater, container, savedInstanceState);

        final View view = inflater.inflate(R.layout.native_list_view_fragment, container, false);

        final ListView listView = (ListView) view.findViewById(R.id.listView);
        final Button saveMomentBtn = (Button) view.findViewById(R.id.btn_save_moment);
        final EditText textMomentId = (EditText) view.findViewById(R.id.text_moment_id);

        final ArrayAdapter<String> listAdapter = new ArrayAdapter<String>(getActivity(), android.R.layout.simple_list_item_1);
        Locale[] locales = Locale.getAvailableLocales();
        ArrayList<String> countries = new ArrayList<String>();
        for (Locale locale : locales) {
            String country = locale.getDisplayCountry();
            if (country.trim().length()>0 && !countries.contains(country)) {
                countries.add(country);
            }
        }
        Collections.sort(countries);
        for (String country : countries) {
            listAdapter.add(country);
        }



        mKiipRewardAdapter = new KiipRewardAdapter(getActivity(), listAdapter, 2);
        saveMomentBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                hideKeyboard(getActivity());
                mKiipRewardAdapter.saveMoment(textMomentId.getText().toString(), new KiipRewardAdapter.NativeCallback() {
                    @Override
                    public void onFailed(Exception e) {
                        Log.e("KIIPSDK", e.toString());
                    }

                    @Override
                    public void onSuccess(boolean b) {
                        if (b) {
                            mKiipRewardAdapter.showReward();
                        }
                    }
                });
                Toast.makeText(getActivity(), "Save Moment", Toast.LENGTH_SHORT).show();
            }
        });

        listView.setAdapter(mKiipRewardAdapter);

        return view;
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
    }

    public static void hideKeyboard(Activity activity)
    {
        try {
            InputMethodManager inputManager = (InputMethodManager) activity.getSystemService(Context.INPUT_METHOD_SERVICE);
            inputManager.hideSoftInputFromWindow(activity.getCurrentFocus().getWindowToken(), InputMethodManager.HIDE_NOT_ALWAYS);
        } catch (Exception e) {
            Log.e("KeyBoardUtil", e.toString(), e);
        }
    }
}
