import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/screen/main/confirm_mnemonic.dart';
import 'package:wallet_apps/src/screen/main/contents_backup.dart';
import 'package:wallet_apps/src/screen/main/create_mnemoic.dart';
import 'package:wallet_apps/src/screen/main/import_account/import_acc.dart';
import 'package:wallet_apps/src/screen/main/create_user_info/user_infor.dart';

class AppRouting {
  static Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    /* Login Screen */
    '/': (context) => Welcome(),
    //Menu({}, _packageInfo, (){}),
    /* Home Screen */
    // '/dashboardScreen': (context) => Home(),
    // '/getWalletScreen': (context) => GetWalletWidget(),
    // '/settingScreen': (context) => SettingWidget(),
    /* Verify User Screen */
    '/add_profile_screen': (context) => AddUserInfo(),
    '/addDocumentScreen': (context) => AddDocuments(),
    '/signUpScreen': (context) => SignUp(),
    '/loginScreen': (context) => Login(),
    '/forgotPasswordScreen': (context) => ForgetPassword()
  };
}
