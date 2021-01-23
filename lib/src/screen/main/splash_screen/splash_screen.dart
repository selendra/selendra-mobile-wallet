import 'package:polkawallet_sdk/storage/keyring.dart';
import 'package:polkawallet_sdk/storage/types/keyPairData.dart';
import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/components/route_animation.dart';

class MySplashScreen extends StatefulWidget {
  final Keyring keyring;
  MySplashScreen(this.keyring);

  static const route = '/';
  @override
  State<StatefulWidget> createState() {
    return MySplashScreenState();
  }
}

class MySplashScreenState extends State<MySplashScreen> {
  GetRequest _getRequest = GetRequest();

  Backend _backend = Backend();

  FlareControls _flareControls = FlareControls();

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  initState() {
    // checkBiometric();
    // checkExpiredToken();
    Future.delayed(Duration(seconds: 3), () async {
      getCurrentAccount().then((value) {
        print("Get acc $value");
        if (value.isEmpty) {
          Navigator.pushReplacement(
              context, RouteAnimation(enterPage: Welcome()));
        } else {
          Navigator.pushReplacementNamed(context, Home.route);
        }
      });
      //Navigator.pushReplacement(context, RouteAnimation(enterPage: Home()));
    });
    super.initState();
  }

  Future<List<KeyPairData>> getCurrentAccount() async {
    final List<KeyPairData> ls = widget.keyring.keyPairs;

    return ls;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void checkBiometric() async {
    // Connectivity _connectivity = new Connectivity();
    // _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
    //   if (result == ConnectivityResult.none) {
    //     AppServices.mySnackBar(_globalKey, AppText.contentConnection);
    //   }
    //   // else {
    //   //   globalKey.currentState.removeCurrentSnackBar();
    //   // }
    // });

    try {
      await StorageServices.fetchData('biometric').then((value) async {
        // value == null whenever User Not Yet Login Or User Logged Out
        await Future.delayed(Duration(seconds: 3), () async {
          if (value != null) {
            if (value['bio'] == true) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => FingerPrint()));
            }
          } else {
            // _backend.response = await _getRequest.checkExpiredToken();
            // navigator();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Welcome()),
                ModalRoute.withName('/'));
          }
        });
      });
    } on SocketException catch (e) {
      await dialog(context, Text("${e.message}", textAlign: TextAlign.center),
          "Message");
    } catch (e) {
      await dialog(context, Text("${e.message}", textAlign: TextAlign.center),
          "Message");
    }
  }

  // Check For Previous Login
  void checkExpiredToken() async {
    try {
      _backend.mapData = await StorageServices.fetchData("user_token");
    } catch (err) {}
  }

  // Time Out Handler Method
  void timeCounter(Timer timer) async {
    // Assign Timer Number Counter To myNumCount Variable
    AppServices.myNumCount = timer.tick;

    // Cancel Timer When Rest Api Successfully
    if (_backend.response != null) {
      timer.cancel();
    }

    // Display TimeOut With SnackBar When Over 10 Second
    if (AppServices.myNumCount == 10) {
      // Navigator.pop(context);
      await dialog(
          context,
          Text("Connection timeout", textAlign: TextAlign.center),
          Text("Mesage"));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SlideBuilder()));
    }
  }

  Future<void> navigator() async {
    // Processing Time Out Handler Method
    AppServices.timerOutHandler(_backend.response, timeCounter);

    await _getRequest.checkExpiredToken().then((value) async {
      // Execute Statement If Rest Api Under 10 Second
      if (AppServices.myNumCount < 10) {
        // Assign Promise Data To Vairable
        _backend.response = value;

        // Convert String To Object
        if (_backend.response != null) {
          _backend.mapData = json.decode(_backend.response.body);

          // Check Expired Token
          if (_backend.response.statusCode == 200) {
            await Future.delayed(Duration(seconds: 4), () {
              // Navigator.pushReplacement(
              //     context, MaterialPageRoute(builder: (context) => Home()));
            });
          }

          // Reset isLoggedIn True -> False Cause Token Expired
          else if (_backend.response.statusCode == 401) {
            await dialog(
                context,
                Text("${_backend.mapData['error']['message']}",
                    textAlign: TextAlign.center),
                Text("Message"));
            // Remove Key Token
            StorageServices.removeKey('user_token');
            // Navigate To Login
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Login()));
          }
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => SlideBuilder()));
        }
        // No Previous Login Or Token Expired
      } else {
        await dialog(
            context, Text("Something wrong with connection"), Text("Message"));

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SlideBuilder()));
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        key: _globalKey,
        backgroundColor: hexaCodeToColor(AppColors.bgdColor),
        body: Align(
            alignment: Alignment.center,
            child: Container(
                width: 200.0,
                height: 200.0,
                child: SvgPicture.asset('assets/sld_logo.svg')
                // CustomAnimation.flareAnimation(_flareControls, "assets/animation/splash_screen.flr", "splash_screen"),
                )));
  }
}
