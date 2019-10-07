/* Flutter package */
import 'package:Wallet_Apps/src/Provider/Hexa_Color_Convert.dart';
import 'package:Wallet_Apps/src/Provider/Reuse_Widget.dart';
import 'package:Wallet_Apps/src/Screen/ForgotPasswordScreen/ForgotPassword.dart';
import 'package:Wallet_Apps/src/Screen/HomeScreen/AddDocument/AddDocumentWidget.dart';
import 'package:Wallet_Apps/src/Screen/HomeScreen/AddProfile/AddProfileWidget.dart';
import 'package:Wallet_Apps/src/Screen/HomeScreen/History/HistoryWidget.dart';
import 'package:Wallet_Apps/src/Screen/HomeScreen/Home/GetWallet/GetWalletWidget.dart';
import 'package:Wallet_Apps/src/Screen/HomeScreen/Home/HomeWidget.dart';
import 'package:Wallet_Apps/src/Screen/HomeScreen/Profile/ProfileUserWidget.dart';
import 'package:Wallet_Apps/src/Screen/HomeScreen/Setting/SettingWidget.dart';
import 'package:Wallet_Apps/src/Screen/MainScreen/Login/LoginWidget.dart';
import 'package:Wallet_Apps/src/Screen/MainScreen/SignUp/SignUpWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/rendering.dart';
/* Directory of file */
import 'package:Wallet_Apps/src/Store_Small_Data/Data_Storage.dart';
import './src/Provider/Provider_General.dart';

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
  void setMyState() async {
    token = await fetchData('userToken');
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
              scaffoldBackgroundColor: Color(convertHexaColor(backgroundColor)),
              cardColor: Color(convertHexaColor(highThenBackgroundColor)),
              // ("#302f34")),
              fontFamily: "Montserrat"
              // is not restarted.
              // primarySwatch: Colors.red
            ),
            routes: {
              /* Login Screen */
              '/': (context) =>
              // AddProfileWidget(),
              // HistroyWidget(),
              LoginWidget(setMyState),
              // HomeWidget(),
              // ProfileUserWidget(),
              '/forgotPasswordScreen': (context) => ForgotPasswordWidget(),
              /* Home Screen */
              '/homeScreen': (context) => HomeWidget(),
              '/getWalletScreen': (context) => GetWalletWidget(),
              '/profileScreen': (context) => ProfileUserWidget(),
              '/settingScreen': (context) => SettingWidget(),
              '/historyScreen': (context) => HistroyWidget(),
              /* Verify User Screen */
              '/addProfile': (context) => AddProfileWidget(),
              '/addDocument': (context) => AddDocumentWidget(),
              '/signUp': (context) => SignUpWidget(),
            },
          )
        ),
      ),
    );
  }
}