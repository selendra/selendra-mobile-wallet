import 'package:wallet_apps/index.dart';
import 'package:responsive_framework/responsive_framework.dart';

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
    //   enabled: true,
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
    return LayoutBuilder(
      builder: (builder, constraints) {
        return OrientationBuilder(
          builder: (context, orientation){
            SizeConfig().init(constraints, orientation);
            return Provider(
              child: MaterialApp(
                initialRoute: '/',
                title: 'SELENDRA',
                theme: AppStyle.myTheme(),
                routes: AppRouting.routes,
                builder: (context, widget) => ResponsiveWrapper.builder(
                  BouncingScrollWrapper.builder(context, widget),
                  maxWidth: 1200,
                  minWidth: 450,
                  defaultScale: true,
                  breakpoints: [
                    ResponsiveBreakpoint.autoScale(480, name: MOBILE),
                    ResponsiveBreakpoint.autoScale(800, name: TABLET),
                    ResponsiveBreakpoint.resize(1000, name: DESKTOP),
                    ResponsiveBreakpoint.autoScale(2460, name: '4K'),
                  ]
                ),
              )
            );
          },
        );
      }
    );
  }
}
