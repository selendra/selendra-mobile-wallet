import 'package:wallet_apps/index.dart';

Widget welcomeBody(
  BuildContext context,
  Function navigatePage
){
  return scaffoldBGDecoration(
    left: 40.0, 
    right: 40.0,
    bottom: 20.0,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                /* Zeetomic */
                logoWelcomeScreen(AppConfig.logoName, 120.0, 120.0),
                Container(
                  margin: EdgeInsets.only(top: 50.0),
                  child: textScale(
                    text: "Welcome",
                    fontSize: 30,
                    hexaColor: "#FFFFFF"
                  )
                ),
              ],
            ),
          ),
        ),
        customFlatButton(
          context,
          "Login",
          "welcomeZee",
          AppColors.greenColor,
          FontWeight.bold,
          size18,
          EdgeInsets.only(top: size10, bottom: size10),
          EdgeInsets.only(top: size15, bottom: size15),
          BoxShadow(
            color: Colors.black54.withOpacity(0.3),
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 5.0),
          ),
          navigatePage
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            textScale(
              text: "Don't have account? ",
              fontSize: 16,
              hexaColor: "#FFFFFF",
              fontWeight: FontWeight.w500
            ),
            textButton(
              padding: EdgeInsets.only(left: 5, top: 10, bottom: 10),
              context: context,
              textColor: AppColors.greenColor,
              text: "Sign up",
              fontWeight: FontWeight.w600,
              fontSize: 18,
              onTap: () {
                Navigator.pushReplacementNamed(context, '/signUpScreen');
              }
            ),
          ],
        ),
      ],
    )
  );
}