import 'package:wallet_apps/index.dart';

class MySplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MySplashScreenState();
  }
}

class MySplashScreenState extends State<MySplashScreen>{

  GetRequest _getRequest = GetRequest();

  int status;

  FlareControls _flareControls = FlareControls();

  @override
  initState(){
    tokenExpireChecker();
    super.initState();
  }

  void tokenExpireChecker() async { /* Check For Previous Login */
    try {
      await StorageServices.fetchData("user_token").then((value) async {
        print(value);
        if (value != null) {
          status = await _getRequest.checkExpiredToken();
          if (status == 200) { /* Check Expired Token */
            await Future.delayed(Duration(seconds: 4), (){
              Navigator.pushReplacement(
                context, 
                MaterialPageRoute(builder: (context) => Dashboard())
              );
            });
          } else if (status == 401) { // Reset isLoggedIn True -> False Cause Token Expired
            Map<String, dynamic> data = value; 
            data.update("isLoggedIn", (value) => false);
            StorageServices.setData(data, "user_token"); // Override Key And Value User Token
            
            await Future.delayed(Duration(seconds: 4), (){
              Navigator.pushReplacement(
                context, 
                MaterialPageRoute(builder: (context) => Welcome())
              );
            });
          }
        } 
         {
          await Future.delayed(Duration(seconds: 4), (){
            Navigator.pushReplacement(
              context, 
              MaterialPageRoute(builder: (context) => Welcome())
            );
          });
        }
      });
    } catch (err) {}
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getHexaColor(AppConfig.darkBlue75),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          width: 200.0,
          height: 200.0,
          child: CustomAnimation.flareAnimation(_flareControls, "assets/animation/splash_screen.flr", "splash_screen"),
        )
      )
    );
  }
}