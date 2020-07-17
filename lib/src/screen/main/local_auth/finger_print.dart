import 'package:local_auth/local_auth.dart';
import 'package:wallet_apps/index.dart';

class FingerPrint extends StatefulWidget {
  @override
  _FingerPrintState createState() => _FingerPrintState();
}

class _FingerPrintState extends State<FingerPrint> {

  Widget screen = Login(); int status = 0;

  GetRequest _getRequest = GetRequest();

  final localAuth = LocalAuthentication();
  bool _hasFingerPrint = false;
  String authorNot = 'Not Authenticate';
  List<BiometricType> _availableBio = List<BiometricType>();

  Future<void> checkBioSupport() async {
    bool hasFingerPrint = false;
    try{
      hasFingerPrint = await localAuth.canCheckBiometrics;
      print(hasFingerPrint);
    } on  PlatformException catch (e){
      print (e);
    }
    if (!mounted) return;
    setState(() {
      _hasFingerPrint = hasFingerPrint;
    });
  }

  Future<void> getBioList() async {
    List<BiometricType> availableBio = List<BiometricType>();
    try{
      availableBio = await localAuth.getAvailableBiometrics();
    } on  PlatformException catch (e){
      print (e);
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
        localizedReason: '',
        useErrorDialogs: true,
        stickyAuth: true
      );
    } on PlatformException catch (e){
      print(e);
    }

    if (authenticate) {
      // StorageServices.setData(authenticate, "bio_auth");
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => screen)
      );
    }

  }

  void tokenExpireChecker() async { /* Check For Previous Login */
    try {
      await StorageServices.fetchData("user_token").then((value) async {
        if (value != null) {
          status = await _getRequest.checkExpiredToken();
          if (status == 200) { /* Check Expired Token */
            screen = Dashboard();
          } else if (status == 401) { // Reset isLoggedIn True -> False Cause Token Expired
            Map<String, dynamic> data = value; 
            data.update("isLoggedIn", (value) => false);
            StorageServices.setData(data, "user_token"); // Override Key And Value User Token
          }
        }
      });
    } catch (err) {}
  }

  @override
  void initState() {
    tokenExpireChecker();
    authenticate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: scaffoldBGDecoration(
        top: 0.0, left: 0.0, right: 0.0, bottom: 0.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.lock, color: Colors.white),
            Text("Authentication Required")
          ],
        )
      )
    );
  }
}
