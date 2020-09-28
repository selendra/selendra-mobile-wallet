import 'package:wallet_apps/index.dart';

class AppRouting{

  static ModelSignUp _modelSignUp = ModelSignUp();

  static PackageInfo _packageInfo = PackageInfo();

  static Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{ /* Login Screen */
    '/': (context) => AddAsset(),
    //Menu({}, _packageInfo, (){}),
    /* Home Screen */
    '/dashboardScreen': (context) => Home(),
    // '/getWalletScreen': (context) => GetWalletWidget(),
    // '/settingScreen': (context) => SettingWidget(),
    /* Verify User Screen */
    '/add_profile_screen': (context) => AddUserInfo(),
    '/addDocumentScreen': (context) => AddDocuments(),
    '/signUpScreen': (context) => SignUp(),
    '/loginScreen': (context) => Login(),
    '/forgotPasswordScreen': (context) => ForgotPassword()
  };
}