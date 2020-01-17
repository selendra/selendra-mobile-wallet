import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:wallet_apps/src/bloc/bloc_provider.dart';
import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/login_screen/login_first_screen/login_first.dart';
import 'package:wallet_apps/src/screen/main_screen/main_reuse_widget.dart';
import 'package:wallet_apps/src/service/services.dart';

class WelcomeToZee extends StatefulWidget{

  WelcomeToZee();

  @override
  State<StatefulWidget> createState() {
    return WelcomeToZeeState();
  }

}

class WelcomeToZeeState extends State<WelcomeToZee> {
  
  @override
  void initState() {
    checkLoginBefore(context);
    super.initState();
  }

  void checkLoginBefore(BuildContext context) async { /* Check For Previous Login */
    try{
      int status = await checkExpiredToken();
      if (status != 401 && status != null) { /* Check Expired Token */
        dialogLoading(context); /* Loading */
        await Future.delayed(Duration(milliseconds: 500), () { /* Pop Loading */
          Navigator.pop(context);
        });
        Navigator.pushReplacementNamed(context, '/dashboardScreen');
      } else {
        clearStorage();
      }
    } catch (err) {
    }
  }

  void navigatePage(BuildContext context) { /* Navigate Login Screen */
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(builder: (context) => LoginFirstScreen())
    );
  }

  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    /* Check For Previous Login */
    return Scaffold(
      body: ConnectivityWidgetWrapper(
        message: "Something wrong with internet connection !",
        child: scaffoldBGDecoration(
          leftRight40, leftRight40, 0, 67,
          color1, color2,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      /* Zeetomic */ 
                      // 91.14, 96.38 zeelogo
                      /* CBM */
                      // CBM-V1.png
                      logoWelcomeScreen("CBM-V1.png", 120.0, 120.0),
                      Container(
                        margin: EdgeInsets.only(top: 50.0),
                        child: textDisplay(
                          "Welcome",
                          TextStyle(
                            color: getHexaColor("#ffffff"),
                            fontSize: 34.0,
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30.0),
                child: customFlatButton(
                  bloc,
                  context,
                  "Login", "welcomeZee", greenColor,
                  FontWeight.bold,
                  size18,
                  EdgeInsets.only(top: size10, bottom: size10),
                  EdgeInsets.only(top: size15, bottom: size15),
                  BoxShadow(
                    color: Color.fromRGBO(0,0,0,0.54),
                    blurRadius: 5.0
                  ),
                  navigatePage
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  textDisplay(
                    "Don't have account? ", 
                    TextStyle(
                      color: getHexaColor("#ffffff"),
                      fontSize: 18,
                    )
                  ),
                  noAccountWidget(context, Colors.white, "Sign Up")
                ],
              )
            ],
          )
        ),
      ),
    );
  }
}