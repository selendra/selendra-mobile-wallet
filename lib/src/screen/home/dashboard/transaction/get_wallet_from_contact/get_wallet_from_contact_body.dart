import 'package:wallet_apps/index.dart';

Widget getWalletFromContactBody({
  BuildContext context,
  ModelGetWalletFromContact modelGetWalletFromContact,
  Function validatePhoneNumber, Function onChanged, 
  Function onSubmit, Function submitToContact,
}){
  return Column(
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(top: 20.0),
        child: Form(
          key: modelGetWalletFromContact.formState,
          child: inputField(
            context: context, 
            labelText: "Phone number", 
            widgetName: 'sendTokenScreen',
            textInputFormatter: [
              LengthLimitingTextInputFormatter(9),
              WhitelistingTextInputFormatter.digitsOnly
            ], 
            prefixText: "+855 ",
            inputType: TextInputType.number, 
            controller: modelGetWalletFromContact.controllerToContact, 
            focusNode: modelGetWalletFromContact.nodeToContact, 
            validateField: validatePhoneNumber, 
            onChanged: onChanged, 
            enableInput: true,
            action: onSubmit
          ),
        )
      ),
      Container(
        margin: EdgeInsets.only(top: 20.0),
        child: customFlatButton(
          context, 
          "Submit", "walletFromContactScreen", AppColors.blueColor, 
          FontWeight.bold,
          size18,
          EdgeInsets.only(top: size10, bottom: size10),
          EdgeInsets.only(top: size15, bottom: size15),
          BoxShadow(
            color: Color.fromRGBO(0,0,0,0.0),
            blurRadius: 0.0
          ), 
          modelGetWalletFromContact.enable == false ? null : submitToContact
        ),
      )
    ],
  );
}