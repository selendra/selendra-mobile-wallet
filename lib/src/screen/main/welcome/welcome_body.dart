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
          child: SlideBuilder()
        ),
        customFlatButton(
          context,
          "Get start",
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
      ],
    )
  );
}