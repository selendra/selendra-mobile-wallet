import 'package:local_auth/local_auth.dart';
import 'package:wallet_apps/index.dart';

class FingerPrint extends StatefulWidget {
  FingerPrint();
  @override
  _FingerPrintState createState() => _FingerPrintState();
}

class _FingerPrintState extends State<FingerPrint> {
  Widget screen = SlideBuilder();

  GetRequest _getRequest = GetRequest();

  Backend _backend = Backend();

  final localAuth = LocalAuthentication();

  bool _hasFingerPrint = false;
  bool enableText = false;

  String authorNot = 'Not Authenticate';

  List<BiometricType> _availableBio = List<BiometricType>();

  GlobalKey<ScaffoldState> globalkey;

  @override
  void initState() {
    globalkey = GlobalKey<ScaffoldState>();
    authenticate();
    super.initState();
  }

  Future<void> checkBioSupport() async {
    bool hasFingerPrint = false;
    try {
      hasFingerPrint = await localAuth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _hasFingerPrint = hasFingerPrint;
    });
  }

  Future<void> getBioList() async {
    List<BiometricType> availableBio = List<BiometricType>();
    try {
      availableBio = await localAuth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _availableBio = availableBio;
    });
  }

  Future<void> authenticate() async {
    bool authenticate = false;

    try {
      authenticate = await localAuth.authenticateWithBiometrics(
          localizedReason: '', useErrorDialogs: true, stickyAuth: true);

      // Open Loading
      dialogLoading(context);
      if (authenticate) {
        await tokenChecker();
      } else {
        // Close Loading
        Navigator.pop(context);
        setState(() {
          enableText = true;
        });
      }
    } on SocketException catch (e) {
      await Future.delayed(Duration(milliseconds: 300), () {});
      AppServices.openSnackBar(globalkey, e.message);
    } catch (e) {
      await dialog(context, Text("${e.message}", textAlign: TextAlign.center),
          "Message");
    }

    // if (authenticate) {
    //   print("Hello navigation");
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => screen)
    //   );
    // }
  }

  // Time Out Handler Method
  void timeCounter(Timer timer) async {
    // Assign Timer Number Counter To myNumCount Variable
    AppServices.myNumCount = timer.tick;

    // Cancel Timer When Rest Api Successfully
    if (_backend.response != null) timer.cancel();

    // Display TimeOut With SnackBar When Over 10 Second
    if (AppServices.myNumCount == 10) {
      Navigator.pop(context);
      await dialog(
          context,
          Text("Connection timeout", textAlign: TextAlign.center),
          Text("Mesage"));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SlideBuilder()));
    }
  }

  Future<void> tokenChecker() async {
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
              Navigator.pushNamed(context, Home.route);
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => Home())
              // );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: globalkey,
        body: GestureDetector(
          onTap: () {
            setState(() {
              enableText = false;
            });
            authenticate();
          },
          child: BodyScaffold(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset("assets/finger_print.svg",
                    width: 300, height: 300),
                MyText(top: 50.0, text: 'Authentication Required'),
                MyText(top: 19.0, text: 'Touch screen to trigger finger print')
              ],
            ),
          ),
        ));
  }
}
