/* Flutter package */
import 'dart:io';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
// import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:wallet_apps/src/bloc/bloc_provider.dart';
import 'package:wallet_apps/src/routes/routing.dart';
import 'package:wallet_apps/theme/style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); /* Avoid Error, " accessed before the binding was initialized " */

  // debugPaintSizeEnabled = true; // Enable Debug Paint
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); // Keep Screen Portrait
  FlutterError.onError = (FlutterErrorDetails details) {
    /* Catch Error During Callback */
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) exit(1);
  };
  runApp(App()
  // DevicePreview(
  //   enabled: false,
  //   builder: (context) => App(),
  // )
  );
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        initialRoute: '/',
        title: 'ZEETOMIC',
        theme: AppStyle.myTheme(),
        routes: AppRouting.route
      )
    );
  }
}
