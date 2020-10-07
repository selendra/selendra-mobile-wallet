import 'package:wallet_apps/index.dart';

class AppStyle {
  static ThemeData myTheme(){
    return ThemeData(
      appBarTheme: AppBarTheme(
        textTheme: TextTheme(bodyText2: TextStyle(color: hexaCodeToColor(AppColors.appBarTextColor))),
        color: Colors.transparent,
        iconTheme: IconThemeData(color: hexaCodeToColor(AppColors.appBarTextColor))
      ),
      /* Color All Text */
      textTheme: TextTheme(bodyText2: TextStyle(color: hexaCodeToColor(AppColors.textColor))),
      canvasColor: hexaCodeToColor("#FFFFFF"),
      cardColor: hexaCodeToColor(AppConfig.darkBlue50),
      bottomAppBarTheme: BottomAppBarTheme(color: hexaCodeToColor(AppColors.cardColor)),
      // floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: hexaCodeToColor(AppColors.textColor)),
      fontFamily: "Avenir",
      scaffoldBackgroundColor: Color(AppUtils.convertHexaColor(AppColors.bgdColor)),
    );
  }
}