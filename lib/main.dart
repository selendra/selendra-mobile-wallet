/* Flutter package */
import 'dart:io';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:custom_splash/custom_splash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:wallet_apps/src/bloc/bloc_provider.dart';
import 'package:wallet_apps/src/model/model_dashboard.dart';
import 'package:wallet_apps/src/model/model_scan_invoice.dart';
import 'package:wallet_apps/src/model/model_signup.dart';
import 'package:wallet_apps/src/model/model_user_info.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/add_user_info_screen/add_user_info.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/dashboard.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/invoice_screen/invoice_summary_screen/invoice_summary.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/qr_scan_pay_screen/scan_pay.dart';
import 'package:wallet_apps/src/screen/home_screen/fill_documents_screen/fill_documents.dart';
import 'package:wallet_apps/src/screen/home_screen/setting_screen/setting.dart';
import 'package:wallet_apps/src/screen/home_screen/transaction_history_screen/transaction_history_screen.dart';
import 'package:wallet_apps/src/screen/main_screen/forgot_password_screen/forgot_password.dart';
import 'package:wallet_apps/src/screen/main_screen/sign_up_screen/signup_first_screen/signup_first.dart';
import 'package:wallet_apps/src/screen/main_screen/sign_up_screen/user_info_screen/user_info.dart';
import 'package:wallet_apps/src/screen/main_screen/welcome_to_zees_screen/welcome_to_zees.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); /* Avoid Error, " accessed before the binding was initialized " */
  // debugPaintSizeEnabled = true;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  FlutterError.onError = (FlutterErrorDetails details) {
    /* Catch Error During Callback */
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) exit(1);
  };
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  
  ModelScanInvoice _modelUserInfo = ModelScanInvoice();
  ModelDashboard _modelDashboard = ModelDashboard();

  Function duringSplash = () {
    print('Something background process');
    int a = 123 + 23;
    print(a);

    if (a > 100)
      return 1;
    else
      return 2;
  };

  // Map<int, Widget> op = {1: MyApp(), 2: MyApp()};

  @override
  Widget build(BuildContext context) {
    return ConnectivityAppWrapper(
      app: Provider(
        child: MaterialApp(
          initialRoute: '/',
          title: 'Zeetomic',
          theme: ThemeData(
            appBarTheme: AppBarTheme(
            textTheme: TextTheme(
              body1: TextStyle(color: getHexaColor(appBarTextColor))
            ),
            color: Colors.transparent,
            iconTheme: IconThemeData(color: getHexaColor(appBarTextColor))),
            /* Color All Text */
            textTheme: TextTheme(body1: TextStyle(color: getHexaColor(textColor))),
            canvasColor: getHexaColor(color2),
            cardColor: getHexaColor(color1),
            bottomAppBarTheme: BottomAppBarTheme(color: getHexaColor(color1)),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: getHexaColor(textColor)
            ),
            fontFamily: "Avenir",
            scaffoldBackgroundColor: Colors.transparent
          ),
          routes: <String, WidgetBuilder>{
            /* Login Screen */
            '/': (context) =>
            // InvoiceSummary(_modelUserInfo),
            // HomeWidget(),
            // UserInfo({"label": "fuckyou"}),
            // SignUpFirst(),
            // SmsCode(_modelSignUp),
            WelcomeToZee(),
            // SendPayment("hello", _modelDashboard),
            // add_profile_screenWidget(),
            // HistroyWidget(),
            // PhoneScreen(setMyState),
            // HomeWidget(),
            // ChangePIN(),
            // InvoiceSummary(),
            // InvoiceInfo("Hello"),
            // ProfileUserWidget(),
            '/forgotPasswordScreen': (context) => ForgotPassword(),
            /* Home Screen */
            '/dashboardScreen': (context) => Dashboard(),
            // '/getWalletScreen': (context) => GetWalletWidget(),
            '/settingScreen': (context) => SettingWidget(),
            /* Verify User Screen */
            '/add_profile_screen': (context) => AddUserInfo(),
            '/addDocumentScreen': (context) => AddDocuments(),
            '/signUpScreen': (context) => SignUpFirst(),
          }
        ),
      ),
    );
  }
}
