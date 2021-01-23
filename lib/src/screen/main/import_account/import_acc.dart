import 'package:polkawallet_sdk/polkawallet_sdk.dart';
import 'package:polkawallet_sdk/storage/keyring.dart';
import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/models/m_import_acc.dart';
import 'package:wallet_apps/src/screen/main/import_account/import_acc_body.dart';

class ImportAcc extends StatefulWidget {
  final WalletSDK sdk;
  final Keyring keyring;
  ImportAcc(this.sdk, this.keyring);
  static const route = '/import';

  @override
  State<StatefulWidget> createState() {
    return ImportAccState();
  }
}

class ImportAccState extends State<ImportAcc> {
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  ImportAccModel _importAccModel = ImportAccModel();

  PackageInfo _packageInfo;

  FirebaseRemote _firebaseRemote;

  bool status;
  int currentVersion;

  var snackBar;

  @override
  void initState() {
    newVersionNotifier(context);
    AppServices.noInternetConnection(globalKey);
    super.initState();
  }

  void tokenExpireChecker(BuildContext context) async {
    /* Check For Previous Login */
    if (status != null) {
      dialogLoading(context);
      await Future.delayed(Duration(seconds: 1), () async {
        Navigator.pop(context);
        if (status == false) {
          await dialog(
              context,
              Text('Unauthorized. please login again',
                  textAlign: TextAlign.center),
              null);
          AppServices.clearStorage();
        }
      });
    }
  }

  void newVersionNotifier(BuildContext context) async {
    try {
      // _firebaseRemote = FirebaseRemote(); /* Declare instance firebaseRemote */
      // await _firebaseRemote.initRemoteConfig();
      // _firebaseRemote.parseVersion = AppUtils.versionConverter(_firebaseRemote.latestVersion);
      // _packageInfo = await PackageInfo.fromPlatform();
      // currentVersion = AppUtils.versionConverter("${_packageInfo.version}+${_packageInfo.buildNumber}");
      // // await dialog(context, Text("${_packageInfo.version}+${_packageInfo.buildNumber}"), Text("Version"));
      // await StorageServices.fetchData("user_token").then((value) { // Checking IsLogged Value
      //   if (value != null){
      //     setState(() {
      //       status = value['isLoggedIn'];
      //     });
      //   }
      // });
      // if (_firebaseRemote.parseVersion > currentVersion) {
      //   await showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      //       return AlertDialog(
      //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      //         title: Center(
      //           child: textScale(
      //             text: "App update required",
      //             hexaColor: "#000000",
      //             fontWeight: FontWeight.w600
      //           ),
      //         ),
      //         content: Text(
      //           "${_firebaseRemote.content}",
      //           style: TextStyle(
      //             fontSize: 14.0
      //           ),
      //           textAlign: TextAlign.center,
      //         ),
      //         actions: <Widget>[
      //           FlatButton(
      //             child: Text("Later"),
      //             onPressed: () {
      //               Navigator.of(context).pop(false);
      //             },
      //           ),
      //           FlatButton(
      //             child: Text("Update"),
      //             onPressed: () {
      //               _launchUrl(_firebaseRemote.iosAppId,_firebaseRemote.androidAppId);
      //               Navigator.of(context).pop(true);
      //             },
      //           )
      //         ],
      //       );
      //     }
      //   );
      //   tokenExpireChecker(context);
      // } else {
      //   tokenExpireChecker(context);
      // }
    } catch (e) {}
  }

  void _launchUrl(String _iosAppId, String _androidAppId) async {
    StoreRedirect.redirect(iOSAppId: _iosAppId, androidAppId: _androidAppId);
  }

  void navigatePage(BuildContext context) {
    /* Navigate Login Screen */
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  String onChanged(String value) {}

  void onSubmit() {}

  Widget build(BuildContext context) {
    return Scaffold(
        key: globalKey,
        body: BodyScaffold(
          height: MediaQuery.of(context).size.height,
          child: ImportAccBody(
              importAccModel: _importAccModel,
              onChanged: onChanged,
              onSubmit: onSubmit),
        ) //welcomeBody(context, navigatePage),
        );
  }
}
