
import 'package:local_auth/local_auth.dart';
import 'package:wallet_apps/index.dart';

class FingerPrint extends StatefulWidget {
  
  FingerPrint();
  @override
  _FingerPrintState createState() => _FingerPrintState();
}

class _FingerPrintState extends State<FingerPrint> {

  Widget screen = Welcome();

  GetRequest _getRequest = GetRequest();

  Backend _backend = Backend();

  final localAuth = LocalAuthentication();

  bool _hasFingerPrint = false; bool enableText = false;

  String authorNot = 'Not Authenticate';

  List<BiometricType> _availableBio = List<BiometricType>();

  @override
  void initState() {
    authenticate();
    super.initState();
  }

  Future<void> checkBioSupport() async {
    bool hasFingerPrint = false;
    try{
      hasFingerPrint = await localAuth.canCheckBiometrics;
    } on  PlatformException catch (e){
      print(e);
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
        localizedReason: '',
        useErrorDialogs: true,
        stickyAuth: true
      );
      
      // Open Loading
      dialogLoading(context);
      if (authenticate){
        await checkExpiredToken();
      } else {
        // Close Loading
        Navigator.pop(context);
        setState(() {
          enableText = true;
        });
      }
    } on PlatformException catch (e){ }

    if (authenticate) {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => screen)
      );
    }

  }

  Future<void> checkExpiredToken() async { /* Check For Previous Login */
    try {
      _backend.response = await _getRequest.checkExpiredToken();
      // Close Loading
      Navigator.pop(context);
      // Convert String To Object
      _backend.mapData = json.decode(_backend.response.body);
      // Check Expired Token
      if (_backend.response.statusCode == 200) {
        screen = Home();
      } 
      // Reset isLoggedIn True -> False Cause Token Expired
      else if (_backend.response.statusCode== 401) {
        await dialog(context, Text('${_backend.mapData['error']['message']}', textAlign: TextAlign.center), Text("Message"));
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => Login())
        );
      }
    } catch (err) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          setState(() {
            enableText = false;
          });
          authenticate();
        },
        child: scaffoldBGDecoration(
          top: 0.0, left: 0.0, right: 0.0, bottom: 0.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Padding(
              //   padding: EdgeInsets.only(left: 50, right: 50),
              //   child: Image.asset('assets/images/illustrator/finger_print.pfing')
              // ),
              MyCircularImage(
                imagePath: "assets/finger_print.svg",
              ),
              
              MyText(
                top: 50.0,
                text: 'Authentication Required'
              ),
              if (enableText) MyText(
                top: 19.0,
                text: 'Touch screen to trigger finger print'
              )
            ],
          )
        ),
      )
    );
  }
}
