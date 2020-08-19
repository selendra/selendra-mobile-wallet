import 'package:wallet_apps/index.dart';

void main() async {

  // Avoid Error, " accessed before the binding was initialized "
  WidgetsFlutterBinding.ensureInitialized(); 

  // Enable Debug Paint
  // debugPaintSizeEnabled = true; 

  // Keep Screen Portrait
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); 

  // Catch Error During Callback
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) exit(1);
  };

  runApp(
    App()
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
        title: 'SELENDRA',
        theme: AppStyle.myTheme(),
        routes: AppRouting.routes
      )
    );
  }
}
