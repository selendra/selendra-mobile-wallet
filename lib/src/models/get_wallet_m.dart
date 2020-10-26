import 'package:wallet_apps/index.dart';

class GetWalletModel {

  TextEditingController pinController = TextEditingController();
  TextEditingController confirmPinController = TextEditingController();

  FocusNode pinNode = FocusNode();
  FocusNode confirmPinNode = FocusNode();
  
  bool disableButton1 = true;
  bool disableButton2 = true;
  bool error = false;
  bool copy = false;

  BoxDecoration get pinPutDecoration {
    return BoxDecoration(
      // border: Border.all(color: Colors.deepPurpleAccent),
      borderRadius: BorderRadius.circular(10.0),
      color: hexaCodeToColor(AppColors.cardColor)
    );
  }

  BoxConstraints get boxConstraint {
    return  BoxConstraints(minWidth: 60, minHeight: 80);
  }
}