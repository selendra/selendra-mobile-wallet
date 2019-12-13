/* Flutter package */
import 'package:wallet_apps/src/model/model_document.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/forgot_password_screen/forgot_password.dart';
import 'package:wallet_apps/src/screen/home_screen/fill_documents_screen/add_success_screen/add_success.dart';
import 'package:wallet_apps/src/screen/home_screen/fill_documents_screen/fill_documents.dart';
import 'package:wallet_apps/src/screen/home_screen/add_user_info_screen/add_user_info.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/dashboard.dart';
import 'package:wallet_apps/src/screen/home_screen/fill_documents_screen/take_selfie_screen/take_selfie.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/profile_user.dart';
import 'package:wallet_apps/src/screen/home_screen/setting_screen/setting.dart';
import 'package:wallet_apps/src/screen/home_screen/transaction_history_screen/transaction_history_screen.dart';
import 'package:wallet_apps/src/screen/main_screen/login_screen/phone_field_screen/phone_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:wallet_apps/src/screen/main_screen/sign_up_screen/sign_up.dart';
import 'package:wallet_apps/src/bloc/bloc_provider.dart';
import 'package:wallet_apps/src/screen/main_screen/welcome_to_zees_screen/welcome_to_zees.dart';

void main () {
  debugPaintSizeEnabled = true;
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

  ModelDocument _modelDocument;

  @override
  void initState() {
    super.initState();
  }

  firstTreeState() async { /* Reset Bearer Token In Main Widget */
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
              bottomAppBarTheme: BottomAppBarTheme(color: getHexaColor(color1)),
              floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: getHexaColor(textColor)),
              fontFamily: "Avenir",
              scaffoldBackgroundColor: Colors.transparent
            ),
            routes: <String, WidgetBuilder>{
              /* Login Screen */
              '/': (context) =>  AddSuccess(),
              // WelcomeToZee(firstTreeState),
              // add_profile_screenWidget(),
              // HistroyWidget(),
              // PhoneScreen(setMyState),
              // HomeWidget(),
              // ChangePIN(),
              // InvoiceSummary(),
              // InvoiceInfo("Hello"),
              // ProfileUserWidget(),
              '/forgotPasswordScreen': (context) => ForgotPasswordWidget(),
              /* Home Screen */
              '/dashboardScreen': (context) => HomeWidget(),
              // '/getWalletScreen': (context) => GetWalletWidget(),
              '/profileScreen': (context) => ProfileUserWidget(),
              '/settingScreen': (context) => SettingWidget(),
              '/transaction_historyScreen': (context) => TransactionHistoryWidget(),
              /* Verify User Screen */
              '/add_profile_screen': (context) => AddUserInfo(),
              '/addDocumentScreen': (context) => AddDocuments(),
              '/signUpScreen': (context) => SignUpWidget(),
            },
          )
        ),
      ),
    );
  }
}