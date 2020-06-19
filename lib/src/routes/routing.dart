import 'package:flutter/material.dart';
import 'package:wallet_apps/src/screen/home/add_user_info/add_user_info.dart';
import 'package:wallet_apps/src/screen/home/dashboard/dashboard.dart';
import 'package:wallet_apps/src/screen/home/fill_documents_screen/fill_documents.dart';
import 'package:wallet_apps/src/screen/home/setting_screen/setting.dart';
import 'package:wallet_apps/src/screen/main_screen/forgot_password_screen/forgot_password.dart';
import 'package:wallet_apps/src/screen/main_screen/login_screen/login_second_screen/login_second.dart';
import 'package:wallet_apps/src/screen/main_screen/sign_up_screen/signup_first_screen/signup_first.dart';
import 'package:wallet_apps/src/screen/main_screen/splash_screen/splash_screen.dart';

class AppRouting{
  static Map<String, WidgetBuilder> route = <String, WidgetBuilder>{ /* Login Screen */
    '/': (context) => MySplashScreen(),
    '/forgotPasswordScreen': (context) => ForgotPassword(),
    /* Home Screen */
    '/dashboardScreen': (context) => Dashboard(),
    // '/getWalletScreen': (context) => GetWalletWidget(),
    '/settingScreen': (context) => SettingWidget(),
    /* Verify User Screen */
    '/add_profile_screen': (context) => AddUserInfo(),
    '/addDocumentScreen': (context) => AddDocuments(),
    '/signUpScreen': (context) => SignUpFirst(),
    '/loginScreen': (context) => LoginSecond(),
  };
}