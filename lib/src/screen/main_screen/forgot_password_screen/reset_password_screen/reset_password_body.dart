import 'package:wallet_apps/index.dart';

Widget resetPasswordBody(
  BuildContext _context,
  ModelForgotPassword _modelForgetPassword,
  Function validatePhoneNumber, Function validateEmail, Function validateNewPassword, 
  Function validateConfirmPassword, Function validateResetCode,
  Function onChanged, Function onSubmit,
  Function submitResetPassword, Function popScreen,
) {
  return Container(
    child: Column(
      children: <Widget>[
        containerAppBar(
            /* AppBar */
            _context,
            Row(
              children: <Widget>[
                iconAppBar(
                  /* Arrow Back Button */
                  Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  Alignment.centerLeft,
                  EdgeInsets.all(0),
                  popScreen,
                ),
                containerTitle(
                  "Change Password", 
                  double.infinity, 
                  Colors.white,
                  FontWeight.normal
                )
              ],
            )),
        Expanded(/* Body */
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: _modelForgetPassword.formStateResetPass,
              child: Container(
                padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 59.0),
                child: Column(
                  children: <Widget>[
                    _modelForgetPassword.key == "phone" 
                    ? Container( /* Phone number field */
                      margin: EdgeInsets.only(bottom: 12.0),
                      child: inputField(
                        enableInput: false,
                        context: _context,
                        labelText: "Phone number",
                        prefixText: "${_modelForgetPassword.countryCode} ",
                        widgetName: "resetPasswordScreen",
                        textInputFormatter: [
                          LengthLimitingTextInputFormatter(9),
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        inputType: TextInputType.number,
                        inputAction: TextInputAction.next,
                        controller: _modelForgetPassword.controlPhoneNums,
                        focusNode: _modelForgetPassword.nodePhoneNums,
                        validateField: validatePhoneNumber, 
                        onChanged: onChanged, 
                        action: onSubmit
                      ),
                    )
                    : Container( /* Email field */
                      margin: EdgeInsets.only(bottom: 12.0),
                      child: inputField(
                        enableInput: false,
                        context: _context,
                        labelText: "Email",
                        prefixText: "",
                        widgetName: "resetPasswordScreen",
                        textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                        inputType: TextInputType.emailAddress,
                        inputAction: TextInputAction.next,
                        controller: _modelForgetPassword.controllerEmail,
                        focusNode: _modelForgetPassword.nodePhoneNums,
                        validateField: validateEmail, 
                        onChanged: onChanged, 
                        action: onSubmit
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 12.0),
                      child: inputField(
                      context: _context,
                      labelText: "New Password",
                      widgetName: "resetPasswordScreen",
                      obcureText: true,
                      textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                      inputAction: TextInputAction.next,
                      controller: _modelForgetPassword.controlNewPasswords,
                      focusNode: _modelForgetPassword.nodePasswords,
                      validateField: validateNewPassword, 
                      onChanged: onChanged, 
                      action: onSubmit
                      ),
                    ),
                    Container( /* SMS code field */
                      margin: EdgeInsets.only(bottom: 12.0),
                      child: inputField(
                        context: _context,
                        labelText: "Confirm New Password",
                        widgetName: "resetPasswordScreen",
                        obcureText: true,
                        textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                        inputAction: TextInputAction.next,
                        controller: _modelForgetPassword.controlConfirmPasswords,
                        focusNode: _modelForgetPassword.nodeConfirmPasswords,
                        validateField: validateConfirmPassword, 
                        onChanged: onChanged, 
                        action: onSubmit
                      ),
                    ),
                    Container( /* Verify Code field */
                      margin: EdgeInsets.only(bottom: 12.0),
                      child: inputField(
                        context: _context,
                        labelText: "Reset code",
                        widgetName: "resetPasswordScreen",
                        textInputFormatter: [
                          LengthLimitingTextInputFormatter(6),
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        inputAction: TextInputAction.next,
                        inputType: TextInputType.number,
                        controller: _modelForgetPassword.controlResetCode,
                        focusNode: _modelForgetPassword.nodeResetCode,
                        validateField: validateResetCode, 
                        onChanged: onChanged, 
                        action: onSubmit
                      ),
                    ),
                    customFlatButton(/* Request Button */
                      _context,
                      "Request Code",
                      "resetPasswordScreen",
                      AppColors.greenColor,
                      FontWeight.normal,
                      size18,
                      EdgeInsets.only(top: 15.0),
                      EdgeInsets.only(top: size15, bottom: size15),
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.54),
                        blurRadius: 5.0
                      ),
                      _modelForgetPassword.enable2 == false ? null : submitResetPassword
                    )
                  ],
                )
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
