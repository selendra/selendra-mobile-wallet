import 'package:wallet_apps/index.dart';

Widget paddingScreenWidget(BuildContext context, Widget child) {
  return Container( /* Create Whole Screen Background Color */
    color: hexaCodeToColor(AppColors.bgdColor),
    // scaffoldBGColor("#344051", "#222834"),
    constraints: BoxConstraints( /* Make Height And Widget To Fit Screen */
      maxHeight: MediaQuery.of(context).size.height,
      maxWidth: MediaQuery.of(context).size.width
    ),
    child: Center(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.only(top: 10, left: 40.0, right: 40, bottom: 10),
          child: child,
        )
      ),
    ),
  );
}

Widget toLogin(BuildContext context) { /* Back To Login Screen*/
  return Align(
    alignment: Alignment.center,
    child: InkWell(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Text('Back to login', style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w400))
      ),
      onTap: () { 
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
      },
    ),
  );
}

Widget forgotPass(BuildContext context, dynamic color, {double fontSize: 18.0, FontWeight fontWeight: FontWeight.w500, Function method}) {
  return InkWell(
    child: Padding(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: textDisplay(
        "Forgot Password?",
        TextStyle(
          color: hexaCodeToColor(color),
          fontSize: fontSize,
          fontWeight: fontWeight
        )
      ),
    ),
    onTap: (){
      Navigator.pushNamed(context, '/forgotPasswordScreen');
    }
  );
}