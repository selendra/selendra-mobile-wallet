package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import de.mintware.barcode_scan.BarcodeScanPlugin;
import io.flutter.plugins.connectivity.ConnectivityPlugin;
import io.flutter.plugins.firebase.core.FlutterFirebaseCorePlugin;
import io.flutter.plugins.firebase.firebaseremoteconfig.FirebaseRemoteConfigPlugin;
import com.example.flutterimagecompress.FlutterImageCompressPlugin;
import io.flutter.plugins.flutter_plugin_android_lifecycle.FlutterAndroidLifecyclePlugin;
import me.schlaubi.fluttercontactpicker.FlutterContactPickerPlugin;
import vn.hunghd.flutter.plugins.imagecropper.ImageCropperPlugin;
import io.flutter.plugins.imagepicker.ImagePickerPlugin;
import io.flutter.plugins.localauth.LocalAuthPlugin;
import io.flutter.plugins.packageinfo.PackageInfoPlugin;
import io.flutter.plugins.pathprovider.PathProviderPlugin;
import net.touchcapture.qr.flutterqr.FlutterQrPlugin;
import io.flutter.plugins.share.SharePlugin;
import com.zt.shareextend.ShareExtendPlugin;
import io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin;
import com.jaumard.smsautofill.SmsAutoFillPlugin;
import com.danieldallos.storeredirect.StoreRedirectPlugin;
import io.flutter.plugins.urllauncher.UrlLauncherPlugin;
import com.benjaminabel.vibration.VibrationPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    BarcodeScanPlugin.registerWith(registry.registrarFor("de.mintware.barcode_scan.BarcodeScanPlugin"));
    ConnectivityPlugin.registerWith(registry.registrarFor("io.flutter.plugins.connectivity.ConnectivityPlugin"));
    FlutterFirebaseCorePlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebase.core.FlutterFirebaseCorePlugin"));
    FirebaseRemoteConfigPlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebase.firebaseremoteconfig.FirebaseRemoteConfigPlugin"));
    FlutterImageCompressPlugin.registerWith(registry.registrarFor("com.example.flutterimagecompress.FlutterImageCompressPlugin"));
    FlutterAndroidLifecyclePlugin.registerWith(registry.registrarFor("io.flutter.plugins.flutter_plugin_android_lifecycle.FlutterAndroidLifecyclePlugin"));
    FlutterContactPickerPlugin.registerWith(registry.registrarFor("me.schlaubi.fluttercontactpicker.FlutterContactPickerPlugin"));
    ImageCropperPlugin.registerWith(registry.registrarFor("vn.hunghd.flutter.plugins.imagecropper.ImageCropperPlugin"));
    ImagePickerPlugin.registerWith(registry.registrarFor("io.flutter.plugins.imagepicker.ImagePickerPlugin"));
    LocalAuthPlugin.registerWith(registry.registrarFor("io.flutter.plugins.localauth.LocalAuthPlugin"));
    PackageInfoPlugin.registerWith(registry.registrarFor("io.flutter.plugins.packageinfo.PackageInfoPlugin"));
    PathProviderPlugin.registerWith(registry.registrarFor("io.flutter.plugins.pathprovider.PathProviderPlugin"));
    FlutterQrPlugin.registerWith(registry.registrarFor("net.touchcapture.qr.flutterqr.FlutterQrPlugin"));
    SharePlugin.registerWith(registry.registrarFor("io.flutter.plugins.share.SharePlugin"));
    ShareExtendPlugin.registerWith(registry.registrarFor("com.zt.shareextend.ShareExtendPlugin"));
    SharedPreferencesPlugin.registerWith(registry.registrarFor("io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin"));
    SmsAutoFillPlugin.registerWith(registry.registrarFor("com.jaumard.smsautofill.SmsAutoFillPlugin"));
    StoreRedirectPlugin.registerWith(registry.registrarFor("com.danieldallos.storeredirect.StoreRedirectPlugin"));
    UrlLauncherPlugin.registerWith(registry.registrarFor("io.flutter.plugins.urllauncher.UrlLauncherPlugin"));
    VibrationPlugin.registerWith(registry.registrarFor("com.benjaminabel.vibration.VibrationPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
