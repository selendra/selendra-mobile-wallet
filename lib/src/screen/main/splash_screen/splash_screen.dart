import 'package:wallet_apps/index.dart';

class MySplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MySplashScreenState();
  }
}

class MySplashScreenState extends State<MySplashScreen>{

  int status; dynamic nextScreen;

  @override
  initState(){
    nextScreen = WelcomeToZee();
    tokenExpireChecker();
    super.initState();
  }

  void tokenExpireChecker() async { /* Check For Previous Login */
    try {
      await StorageServices.fetchData("user_token").then((value) async {
        if (value != null) {
          status = await checkExpiredToken();
          if (status == 200) { /* Check Expired Token */
            setState(() { // Reset Default Next Screen Variable
              nextScreen = Dashboard();
            });
          } else if (status == 401) { // Reset isLoggedIn True -> False Cause Token Expired
            Map<String, dynamic> data = value; 
            data.update("isLoggedIn", (value) => false);
            StorageServices.setData(data, "user_token"); // Override Key And Value User Token
          }
        }
      });
    } catch (err) {}
  }

  Widget build(BuildContext context) {
    return SplashScreen(
      loaderColor: getHexaColor(AppColors.lightBlueSky),
      seconds: 3,
      image: Image.asset(AppConfig.splashLogo, color: Colors.white),
      photoSize: 80.0,
      navigateAfterSeconds: nextScreen,
      backgroundColor: getHexaColor(AppColors.color1),
      loadingText: Text(AppConfig.bottomText),
    );
  }
}