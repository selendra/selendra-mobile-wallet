/* Forgot Password Button */
import 'package:wallet_apps/index.dart';

Widget forgotPass(BuildContext context, dynamic color, {double fontSize: 18.0, FontWeight fontWeight: FontWeight.w500}) {
  return InkWell(
    child: Padding(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: textDisplay(
        "Forgot Password?",
        TextStyle(
          color: getHexaColor(color),
          fontSize: fontSize,
          fontWeight: fontWeight
        )
      ),
    ),
    onTap: () { Navigator.pushNamed(context, '/forgotPasswordScreen'); },
  );
}