import 'package:polkawallet_sdk/api/types/balanceData.dart';
import 'package:polkawallet_sdk/api/types/networkParams.dart';
import 'package:polkawallet_sdk/polkawallet_sdk.dart';
import 'package:polkawallet_sdk/storage/keyring.dart';
import 'package:polkawallet_sdk/storage/types/keyPairData.dart';
import 'package:wallet_apps/index.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:wallet_apps/src/screen/home/menu/account.dart';
import 'package:wallet_apps/src/screen/main/import_account/import_acc.dart';

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

  runApp(App()
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
  final Keyring keyring = Keyring();
  final WalletSDK sdk = WalletSDK();
  BalanceData _balance;
  bool _sdkReady = false;
  bool _apiConnected = false;
  String mBalance = '0';
  String _msgChannel;

  @override
  void initState() {
    _initApi();
    super.initState();
  }

  Future<void> _initApi() async {
    await keyring.init();

    await sdk.init(keyring);
    setState(() {
      _sdkReady = true;
    });
    if (_sdkReady) {
      connectNode();
    }
  }

  Future<void> connectNode() async {
    final node = NetworkParams();

    node.name = 'Indranet hosted By Selendra';
    node.endpoint = 'wss://rpc-testnet.selendra.org';
    node.ss58 = 0;
    final res = await sdk.api.connectNode(keyring, [node]);

    print('res $res');
    if (res != null) {
      setState(() {
        _apiConnected = true;

        _subscribeBalance();
      });
      // _importFromMnemonic();

    }
  }

  Future<void> _subscribeBalance() async {
    print('subscribe');
    final channel =
        await sdk.api.account.subscribeBalance(keyring.current.address, (res) {
      setState(() {
        _balance = res;
        mBalance = int.parse(_balance.freeBalance).toString();
        print(mBalance);
      });
    });

    setState(() {
      _msgChannel = channel;
      print('$channel');
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (builder, constraints) {
      return OrientationBuilder(
        builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);
          return Provider(
              child: MaterialApp(
            initialRoute: '/',
            title: 'Kaabop',
            theme: AppStyle.myTheme(),
            routes: {
              MySplashScreen.route: (_) => MySplashScreen(keyring),
              Home.route: (_) =>
                  Home(sdk, keyring, _apiConnected, mBalance, _msgChannel),
              ImportAcc.route: (_) => ImportAcc(sdk, keyring),
              Account.route: (_) => Account(sdk, keyring),
            },
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
                ]),
          ));
        },
      );
    });
  }
}
