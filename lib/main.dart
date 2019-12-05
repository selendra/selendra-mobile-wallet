/* Flutter package */
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/forgot_password_screen/forgot_password.dart';
import 'package:wallet_apps/src/screen/home_screen/add_document_screen/add_document.dart';
import 'package:wallet_apps/src/screen/home_screen/add_profile_screen/add_profile.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/dashboard.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/get_wallet_screen/get_wallet.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/invoice_screen/invoice_info_screen/invoice_info.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/profile_user.dart';
import 'package:wallet_apps/src/screen/home_screen/setting_screen/setting.dart';
import 'package:wallet_apps/src/screen/home_screen/transaction_history_screen/transaction_history_screen.dart';
import 'package:wallet_apps/src/screen/main_screen/login_screen/phone_field_screen/phone_field.dart';
import 'package:wallet_apps/src/screen/main_screen/welcome_to_zees_screen/welcome_to_zees.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:wallet_apps/src/screen/main_screen/sign_up_screen/sign_up.dart';
import 'package:wallet_apps/src/store_small_data/data_store.dart';
import 'package:wallet_apps/src/bloc/bloc_provider.dart';

void main () {
  // debugPaintSizeEnabled = true;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(App());
}

class App extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App>{
  Map<String, dynamic> token;

  @override
  void initState() {
    super.initState();
  }

  _firstTreeState() async { /* ReSet Bearer Token In Main Widget */
    token = await Provider.fetchToken();
    setState(() {}); 
  }

  @override
  Widget build(BuildContext context) {
    final HttpLink _httpLink = HttpLink(uri: 'https://api.zeetomic.com/gql');
    final AuthLink authLink = AuthLink(getToken: () async => "Bearer ${token != null ? token['TOKEN'] : ''}");
    final Link link = authLink.concat(_httpLink);
    final ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: link,
        cache: InMemoryCache()
      )
    );
    return GraphQLProvider(
      client: client,
      child: CacheProvider(
        child: Provider(
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
              // ("#4B535F"),
              bottomAppBarTheme: BottomAppBarTheme(color: getHexaColor(color1)),
              floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: getHexaColor(textColor)),
              fontFamily: "Avenir",
              // is not restarted.
            ),
            routes: <String, WidgetBuilder>{
              /* Login Screen */
              '/': (context) => 
              // WelcomeToZee(_firstTreeState),
              // add_profile_screenWidget(),
              // HistroyWidget(),
              // PhoneScreen(setMyState),
              // HomeWidget(),
              ReceiptVerify("HEllo"),
              // GetWalletWidget(),
              // ProfileUserWidget(),
              '/phoneScreen': (context) => PhoneScreen(),
              '/forgotPasswordScreen': (context) => ForgotPasswordWidget(),
              /* Home Screen */
              '/dashboardScreen': (context) => HomeWidget(),
              // '/getWalletScreen': (context) => GetWalletWidget(),
              '/profileScreen': (context) => ProfileUserWidget(),
              '/settingScreen': (context) => SettingWidget(),
              '/transaction_historyScreen': (context) => HistroyWidget(),
              /* Verify User Screen */
              '/add_profile_screen': (context) => AddProfileWidget(),
              '/addDocumentScreen': (context) => AddDocumentWidget(),
              '/signUpScreen': (context) => SignUpWidget(),
            },
          )
        ),
      ),
    );
  }
}