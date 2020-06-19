import 'package:wallet_apps/index.dart';

class WelcomeToZee extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return WelcomeToZeeState();
  }
  
}

class WelcomeToZeeState extends State<WelcomeToZee> {

  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  PackageInfo _packageInfo;
  FirebaseRemote _firebaseRemote;

  bool status; int currentVersion;
  var snackBar;

  @override
  void initState() {
    // platForm();
    AppServices.noInternetConnection(globalKey);
    newVersionNotifier();
    super.initState();
  }

  // void platForm() {
  //   if (Theme.of(context).platform == TargetPlatform.android) {
  //     // print("Hello android");
  //     // print(Theme.of(context).platform);
  //   }
  //   if (Theme.of(context).platform == TargetPlatform.iOS) {
  //     // print("Hello iOS");
  //     // print(Theme.of(context).platform);
  //   }
  // }

  void tokenExpireChecker(BuildContext context) async { /* Check For Previous Login */
    if (status != null){
      dialogLoading(context);
      Timer(Duration(seconds: 1), () async {
        Navigator.pop(context);
        if (status == false){
          await dialog(context, Text('Unauthorized. please login again', textAlign: TextAlign.center), null);
          AppServices.clearStorage();
        }
      });
    }
  }

  void newVersionNotifier() async {
    try {
      _firebaseRemote = FirebaseRemote(); /* Declare instance firebaseRemote */
      await _firebaseRemote.initRemoteConfig();
      _firebaseRemote.parseVersion = UtilsConvert.versionConverter(_firebaseRemote.latestVersion);
      _packageInfo = await PackageInfo.fromPlatform();
      currentVersion = UtilsConvert.versionConverter("${_packageInfo.version}+${_packageInfo.buildNumber}");
      await StorageServices.fetchData("user_token").then((value) { // Checking IsLogged Value
        if (value != null){
          setState(() {
            status = value['isLoggedIn'];
          });
        };
      });
      if (_firebaseRemote.parseVersion > currentVersion) {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              title: Center(
                child: textScale(
                  text: "App update required",
                  hexaColor: "#000000",
                  fontWeight: FontWeight.w600
                ),
              ),
              content: Text(
                "${_firebaseRemote.content}", 
                style: TextStyle(
                  fontSize: 14.0
                ),
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Later"),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                FlatButton(
                  child: Text("Update"),
                  onPressed: () {
                    _launchUrl(_firebaseRemote.iosAppId,_firebaseRemote.androidAppId);
                    Navigator.of(context).pop(true);
                  },
                )
              ],
            );
          }
        );
        tokenExpireChecker(context);
      } else
        tokenExpireChecker(context);
    } catch (e) {}
  }

  void _launchUrl(String _iosAppId, String _androidAppId) async {
    StoreRedirect.redirect(iOSAppId: _iosAppId, androidAppId: _androidAppId);
    // await launch(_url);
  }

  void navigatePage(BuildContext context) {/* Navigate Login Screen */
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginSecond()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      body: scaffoldBGDecoration(
        left: 40.0, 
        right: 40.0,
        bottom: 20.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    /* Zeetomic */
                    logoWelcomeScreen(AppConfig.logoName, 120.0, 120.0),
                    Container(
                      margin: EdgeInsets.only(top: 50.0),
                      child: textScale(
                        text: "Welcome",
                        fontSize: 30,
                        hexaColor: "#FFFFFF"
                      )
                    ),
                  ],
                ),
              ),
            ),
            customFlatButton(
              context,
              "Login",
              "welcomeZee",
              AppColors.greenColor,
              FontWeight.bold,
              size18,
              EdgeInsets.only(top: size10, bottom: size10),
              EdgeInsets.only(top: size15, bottom: size15),
              BoxShadow(
                color: Colors.black54.withOpacity(0.3),
                blurRadius: 10.0,
                spreadRadius: 2.0,
                offset: Offset(2.0, 5.0),
              ),
              navigatePage
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                textScale(
                  text: "Don't have account? ",
                  fontSize: 16,
                  hexaColor: "#FFFFFF",
                  fontWeight: FontWeight.w500
                ),
                textButton(
                  padding: EdgeInsets.only(left: 5, top: 10, bottom: 10),
                  context: context,
                  textColor: AppColors.greenColor,
                  text: "Sign up",
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/signUpScreen');
                  }
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
}
