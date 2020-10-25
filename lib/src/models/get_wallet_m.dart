import 'package:wallet_apps/index.dart';

class GetWalletModel {

  TextEditingController pinController = TextEditingController();

  FocusNode pinNode = FocusNode();
  
  bool disableButton;

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