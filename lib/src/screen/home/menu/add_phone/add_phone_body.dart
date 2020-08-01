import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/model/add_phone_number.dart';

Widget addPhoneBody(
  BuildContext context,
  AddPhoneModel phoneModel,
  Function validatePhone,
  Function onChanged,
  Function onSubmit,
  Function submitAddPhone,
  Function popScreen,
){
  return Column(
    children: <Widget>[
      containerAppBar( /* AppBar */
        context, 
        Row(
          children: <Widget>[
            iconAppBar( /* Arrow Back Button */
              Icon(Icons.arrow_back, color: Colors.white,),
              Alignment.centerLeft,
              EdgeInsets.all(0),
              popScreen,
            ),
            containerTitle("Add Phone Number", double.infinity, Colors.white, FontWeight.normal)
          ],
        ),
      ),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 12.0),
              child: Form(
                key: phoneModel.formKey,
                child: inputField( /* Asset Code Field */
                  context: context, 
                  labelText: "Add Phone", 
                  widgetName: "addPhoneScreen",
                  prefixText: "${phoneModel.countryCode} ",
                  textInputFormatter: [
                    LengthLimitingTextInputFormatter(9),
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  inputType: TextInputType.phone,
                  inputAction: TextInputAction.next, 
                  controller: phoneModel.phone, 
                  focusNode: phoneModel.phoneNode, 
                  validateField: validatePhone, 
                  onChanged: onChanged, 
                  action: onSubmit
                ),
              )
            ),
            customFlatButton( /* Add Asset Button */
              context, 
              "Add Phone", "addPhoneScreen", AppColors.blueColor,
              FontWeight.normal, 
              size18,
              EdgeInsets.only(top: 15.0),
              EdgeInsets.only(top: size15, bottom: size15),
              BoxShadow(
                color: Color.fromRGBO(0,0,0,0.54),
                blurRadius: 5.0
              ),
              phoneModel.enable ? submitAddPhone : null 
            )
          ],
        )
      )
    ],
  );
}