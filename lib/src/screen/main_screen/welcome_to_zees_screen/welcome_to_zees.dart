import 'package:flutter/material.dart';
import 'package:wallet_apps/src/bloc/bloc_provider.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/login_screen/login_first_screen/login_first.dart';
import 'package:wallet_apps/src/screen/main_screen/main_reuse_widget.dart';
import 'package:wallet_apps/src/store_small_data/data_store.dart';

class WelcomeToZee extends StatefulWidget{

  final setMyState;

  WelcomeToZee(this.setMyState);

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

  /* Check For Previous Login */
  void checkLoginBefore(BuildContext context) async {
    var response = await fetchData('userToken');
    if (response != null){
      widget.setMyState();
      /* Loading */
      dialogLoading(context);
      /* Pop Loading */
      await Future.delayed(Duration(seconds: 2), () {
        Navigator.pop(context);
      });
      Navigator.pushReplacementNamed(context, '/dashboardScreen');
    }
  }

  navigatePage(BuildContext context) {
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(builder: (context) => LoginFirstScreen(widget.setMyState))
    );
  }

  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    /* Check For Previous Login */
    return Scaffold(
      body: scaffoldBGDecoration(
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
                    zeeLogo(91.14, 96.38),
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
              child: blueButton(
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
            noAccountWidget(context)
          ],
        )
      ),
    );
  }
}