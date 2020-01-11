/* Flutter package */
import 'dart:io';

import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/foundation.dart';
import 'package:wallet_apps/src/model/model_document.dart';
import 'package:wallet_apps/src/model/model_login.dart';
import 'package:wallet_apps/src/model/model_signup.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/qr_scan_pay_screen/scan_pay.dart';
import 'package:wallet_apps/src/screen/main_screen/forgot_password_screen/forgot_password.dart';
import 'package:wallet_apps/src/screen/home_screen/fill_documents_screen/add_success_screen/add_success.dart';
import 'package:wallet_apps/src/screen/home_screen/fill_documents_screen/fill_documents.dart';
import 'package:wallet_apps/src/screen/home_screen/add_user_info_screen/add_user_info.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/dashboard.dart';
import 'package:wallet_apps/src/screen/home_screen/fill_documents_screen/take_selfie_screen/take_selfie.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/profile_user.dart';
import 'package:wallet_apps/src/screen/home_screen/setting_screen/setting.dart';
import 'package:wallet_apps/src/screen/home_screen/transaction_history_screen/transaction_history_screen.dart';
import 'package:wallet_apps/src/screen/main_screen/login_screen/login_first_screen/login_first.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'package:wallet_apps/src/screen/main_screen/sign_up_screen/create_password_screen/create_password.dart';
import 'package:wallet_apps/src/screen/main_screen/sign_up_screen/signup_first_screen/signup_first.dart';
import 'package:wallet_apps/src/bloc/bloc_provider.dart';
import 'package:wallet_apps/src/screen/main_screen/sign_up_screen/sms_code_screen/sms_code.dart';
import 'package:wallet_apps/src/screen/main_screen/sign_up_screen/user_info_screen/user_info.dart';
import 'package:wallet_apps/src/screen/main_screen/welcome_to_zees_screen/welcome_to_zees.dart';

void main () {
  WidgetsFlutterBinding.ensureInitialized(); /* Avoid Error, " accessed before the binding was initialized " */
  // debugPaintSizeEnabled = true;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  FlutterError.onError = (FlutterErrorDetails details) { /* Catch Error During Callback */
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode)
      exit(1);
  };
  runApp(App());
}

class App extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App>{

  ModelSignUp _modelSignUp = ModelSignUp();

  @override
  Widget build(BuildContext context) {
    return ConnectivityAppWrapper(
      app: Provider(
        child: MaterialApp(
          initialRoute: '/',
          title: 'Zeetomic',
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              textTheme: TextTheme(body1: TextStyle(color: getHexaColor(appBarTextColor))),
              color: Colors.transparent,
              iconTheme: IconThemeData(color: getHexaColor(appBarTextColor))
            ),
            /* Color All Text */
            textTheme: TextTheme(body1: TextStyle(color: getHexaColor(textColor))),
            canvasColor: getHexaColor(color2),
            cardColor: getHexaColor(color1),
            bottomAppBarTheme: BottomAppBarTheme(color: getHexaColor(color1)),
            floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: getHexaColor(textColor)),
            fontFamily: "Avenir",
            scaffoldBackgroundColor: Colors.transparent
          ),
          routes: <String, WidgetBuilder>{
            /* Login Screen */
            '/': (context) => 
            // HomeWidget(),
            // UserInfo(_modelSignUp),
            // SignUpFirst(),
            // SmsCode(_modelSignUp),
            WelcomeToZee(),
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
            '/transaction_historyScreen': (context) => TransactionHistoryWidget(),
            /* Verify User Screen */
            '/add_profile_screen': (context) => AddUserInfo(),
            '/addDocumentScreen': (context) => AddDocuments(),
            '/signUpScreen': (context) => SignUpFirst(),
          },
        )
      ),
    );
  }
}