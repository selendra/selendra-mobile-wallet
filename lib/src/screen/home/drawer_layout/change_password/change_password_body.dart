import 'package:wallet_apps/index.dart';

Widget changePasswordBody(
  BuildContext _context, ModelChangePassword _model,
  Function validateOldPass, Function validateNewPass, Function validateConfirmPass,
  Function onSubmitted, Function onChanged, 
  Function submitPassword, Function popScreen
) {
  return Column(
    children: <Widget>[
      containerAppBar( /* AppBar */
        _context,
        Row(
          children: <Widget>[
            iconAppBar( /* Arrow Back Button */
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
        )
      ),
      Form( /* Body Change Password */
        key: _model.formStateChangePassword,
        child: Expanded( 
          child: Container(
            margin: EdgeInsets.only(left: 27.0, right: 27.0, top: 27.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    /* Old Password */
                    margin: EdgeInsets.only(bottom: 12.0, top: 10.0),
                    child: inputField(
                      context: _context,
                      labelText: "Old Password",
                      prefixText: "",
                      widgetName: "changePasswordScreen",
                      obcureText: true,
                      textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                      inputAction: TextInputAction.next,
                      controller: _model.controlOldPassword,
                      focusNode: _model.nodeOldPassword,
                      validateField: validateOldPass, 
                      onChanged: onChanged, 
                      action: onSubmitted
                    ),
                  ),
                  Container( /* New Password */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: inputField(
                      context: _context,
                      labelText: "New Password",
                      prefixText: "",
                      widgetName: "changePasswordScreen",
                      obcureText: true,
                      textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                      inputAction: TextInputAction.next,
                      controller: _model.controlNewPassword,
                      focusNode: _model.nodeNewPassword,
                      validateField: validateNewPass, 
                      onChanged: onChanged, 
                      action: onSubmitted
                    ),
                  ),
                  Container( /* Old Password */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: inputField(
                      context: _context,
                      labelText: "Confirm Password",
                      prefixText: "",
                      widgetName: "changePasswordScreen",
                      obcureText: true,
                      textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                      inputAction: TextInputAction.done,
                      controller: _model.controlConfirmPassword,
                      focusNode: _model.nodeConfirmPassword,
                      validateField: validateConfirmPass, 
                      onChanged: onChanged, 
                      action: onSubmitted
                    ),
                  ),
                  customFlatButton(
                    _context,
                    "Change Now",
                    "changePasswordScreen",
                    AppColors.blueColor,
                    FontWeight.normal,
                    size18,
                    EdgeInsets.only(top: 15.0),
                    EdgeInsets.only(top: size15, bottom: size15),
                    BoxShadow(
                      color: Color.fromRGBO(
                        0, 0, 0, _model.enable == false ? 0 : 0.54
                      ), 
                      blurRadius: 5.0
                    ),
                    _model.enable == false ? null : submitPassword
                  )
                ],
              ),
            )
          )
        ),
      )
    ],
  );
}
