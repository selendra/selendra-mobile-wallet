import 'package:wallet_apps/index.dart';

class AppRouting{
  static Map<String, WidgetBuilder> route = <String, WidgetBuilder>{ /* Login Screen */
    '/': (context) => MySplashScreen(),
    '/forgotPasswordScreen': (context) => ForgotPassword(),
    /* Home Screen */
    '/dashboardScreen': (context) => Dashboard(),
    // '/getWalletScreen': (context) => GetWalletWidget(),
    // '/settingScreen': (context) => SettingWidget(),
    /* Verify User Screen */
    '/add_profile_screen': (context) => AddUserInfo(),
    '/addDocumentScreen': (context) => AddDocuments(),
    '/signUpScreen': (context) => SignUpFirst(),
    '/loginScreen': (context) => Login(),
  };
}