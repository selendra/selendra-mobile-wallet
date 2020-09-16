import 'package:wallet_apps/index.dart';

class MySplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MySplashScreenState();
  }
}

class MySplashScreenState extends State<MySplashScreen>{

  GetRequest _getRequest = GetRequest();

  Backend _backend = Backend();

  FlareControls _flareControls = FlareControls();

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  initState(){
    checkBiometric();
    checkExpiredToken();
    super.initState();
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
    
    try{
      await StorageServices.fetchData('biometric').then((value) async {
        // value == null whenever User Not Yet Login Or User Logged Out
        await Future.delayed(Duration(seconds: 3), () async {
          if (value != null){
            if (value['bio'] == true){
              print(value);
              Navigator.pushReplacement(
                context, 
                MaterialPageRoute(builder: (context) => FingerPrint())
              );
            }
          } else {
      // _backend.response = await _getRequest.checkExpiredToken();
            navigator();
          }
        });
        
      });
    } catch (e) {
      await dialog(context, Text("$e", textAlign: TextAlign.center), "Message");
    }
  }

  // Check For Previous Login
  void checkExpiredToken() async { 
    try {
      _backend.mapData = await StorageServices.fetchData("user_token");
    } catch (err) {}
  }

  void timeCounter(Timer timer) async {
    // Assign Timer Number Counter To myNumCount Variable
    AppServices.myNumCount = timer.tick;
    // Cancel Timer When Rest Api Successfully
    if (_backend.response != null) timer.cancel();
    // Display TimeOut With SnackBar When Over 10 Second
    if (AppServices.myNumCount == 10) {
      await dialog(context, Text("Connection timed out", textAlign: TextAlign.center), Text("Message"));

      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => Login())
      );
    }
  }

  Future<void> navigator() async {
    if (_backend.mapData != null) {

      AppServices.timerOutHandler(_backend.response, timeCounter);    
      // Get Request To Check Expired Token
      await _getRequest.checkExpiredToken().then((value) async {
        // Execute Statement If Rest Api Under 10 Second
        if (AppServices.myNumCount < 10){
          // Assign Promise Data To Vairable
          _backend.response = value;
          // Convert String To Object
          _backend.mapData = json.decode(_backend.response.body);
          // Check Expired Token
          if (_backend.response.statusCode == 200) { 
            await Future.delayed(Duration(seconds: 4), (){
              Navigator.pushReplacement(
                context, 
                MaterialPageRoute(builder: (context) => Home())
              );
            });
          }
          // Reset isLoggedIn True -> False Cause Token Expired 
          else if (_backend.response.statusCode == 401) {
            await dialog(context, Text("${_backend.mapData['error']['message']}", textAlign: TextAlign.center), Text("Message"));
            // Remove Key Token
            StorageServices.removeKey('user_token');
            // Navigate To Login
            Navigator.pushReplacement(
              context, 
              MaterialPageRoute(builder: (context) => Login())
            );
          }
        }
      });
      
    } else {
      // No Previous Login Or Token Expired
      await Future.delayed(Duration(seconds: 4), (){
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => Welcome())
        );
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexaCodeToColor(AppColors.bgdColor),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          width: 200.0,
          height: 200.0,
          child: Image.asset('assets/images/sld_logo.png', color: Colors.white,)
          // CustomAnimation.flareAnimation(_flareControls, "assets/animation/splash_screen.flr", "splash_screen"),
        )
      )
    );
  }
}
