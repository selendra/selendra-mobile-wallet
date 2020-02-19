package com.example.wallet;

import android.os.Bundle;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

  private TextView tv;
  private ImageView iv;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
//    setContentView(R.layout.launch);
//    tv = (TextView) findViewById(R.id.tv);
//    iv = (ImageView) findViewById(R.id.iv);
//    Animation myanim = AnimationUtils.loadAnimation(this, R.anim.mytransition);
//    tv.startAnimation(myanim);
//    iv.startAnimation(myanim);
    GeneratedPluginRegistrant.registerWith(this);
  }
}