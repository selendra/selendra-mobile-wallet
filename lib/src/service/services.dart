import 'package:wallet_apps/index.dart';
import 'package:http/http.dart' as http;

class AppServices {

  static int myNumCount = 0;

  static Future noInternetConnection(GlobalKey<ScaffoldState> globalKey) async {
    try {
      Connectivity _connectivity = new Connectivity();

      final myResult = await _connectivity.checkConnectivity();
      
      _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
        print(result);
        if (result == ConnectivityResult.none) {
          mySnackBar(globalKey, AppText.contentConnection);
        } else {
          globalKey.currentState.removeCurrentSnackBar();
        }
      });

      if (myResult == ConnectivityResult.none) {
        mySnackBar(globalKey, AppText.contentConnection);
      }
    } catch (e) {}
  }

  static void mySnackBar(GlobalKey<ScaffoldState> globalKey, String content) {
    globalKey.currentState.showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: Duration(days: 365),
      backgroundColor: Colors.red,
      content: Text(content,
        style: TextStyle(
          color: Colors.white,
        )
      ),
      action: SnackBarAction(
        label: "Close",
        textColor: Colors.white,
        onPressed: () {
          globalKey.currentState.removeCurrentSnackBar();
        },
      ),
    ));
  }

  static void clearStorage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

  // Remove Zero At The Position Of Phone Number
  static String removeZero(String number){
    return number.replaceFirst("0", "", 0);
  }

  static double getRadienFromDegree(double degree){
    double unitRadien = 57.295779513;
    return degree / unitRadien;
  }

  static Timer appLifeCycle(Timer timer){
    return timer;
  }

  static Map<String, dynamic> emptyMapData(){
    return Map<String, dynamic>.unmodifiable({});
  }
  
  static void timerOutHandler(http.Response res, Function counter) async {
    Timer.periodic(Duration(seconds: 1), (Timer timer){
      if (timer.tick <= 10) counter(timer);
      else if (timer.tick > 10) timer.cancel();
    });
  }
  
}

