import 'package:wallet_apps/index.dart';

Widget createPasswordBodyWidget(
  BuildContext _context,
  ModelSignUp _modelSignUp,
  Function validatePass1, Function validatePass2,
  Function onChanged, Function popScreen, Function showPassword,
  Function onSubmit, Function navigatePage
){
  return Column(
    children: <Widget>[
      containerAppBar( /* AppBar */
        _context,
        Row(
          children: <Widget>[
            iconAppBar( /* Arrow Back Button */
              Icon(Icons.arrow_back, color: Colors.white),
              Alignment.centerLeft,
              EdgeInsets.all(0),
              popScreen,
            ),
            containerTitle("Create Password", double.infinity, Colors.white, FontWeight.normal)
          ],
        )
      ),
      Expanded( /* Body */
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 27.0, right: 27.0, top: 27.0),
            child: Form(
              key: _modelSignUp.formStatePassword,
              child: Column(
                children: <Widget>[
                  Container( /* Password Field */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: inputField(
                      context: _context,
                      labelText: "Password",
                      widgetName: "createPasswordScreen",
                      obcureText: !_modelSignUp.showPassword1,
                      textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                      inputAction: TextInputAction.next,
                      controller: _modelSignUp.controlPassword,
                      focusNode: _modelSignUp.nodePassword,
                      validateField: validatePass1, 
                      onChanged: onChanged, 
                      icon: IconButton(
                        icon: Icon(_modelSignUp.showPassword1 == true ? Icons.visibility : Icons.visibility_off, color: Colors.white),
                        onPressed: () {
                          if (_modelSignUp.showPassword1 == false) showPassword(true);
                          else showPassword(false);
                        },
                      ),
                      action: onSubmit
                    ),
                  ),
                  Container( /* Confirm Password Field */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: inputField(
                      context: _context,
                      labelText: "Confirm Password",
                      widgetName: "createPasswordScreen",
                      obcureText: !_modelSignUp.showPassword2,
                      textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                      inputAction: TextInputAction.done,
                      controller: _modelSignUp.controlConfirmPassword,
                      focusNode: _modelSignUp.nodeConfirmPassword,
                      validateField: validatePass2, 
                      onChanged: onChanged, 
                      icon: IconButton(
                        icon: Icon(_modelSignUp.showPassword2 == true ? Icons.visibility : Icons.visibility_off, color: Colors.white),
                        onPressed: () {
                          if (_modelSignUp.showPassword2 == false) showPassword(true);
                          else showPassword(false);
                        },
                      ),
                      action: onSubmit
                    ),
                  ),
                  _modelSignUp.isNotMatch == false
                  ? Container()
                  : FittedBox(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Password and confirm password does not match",
                      style: TextStyle(fontSize: 18.0, color: Colors.red),
                    ),
                  ),
                  customFlatButton( /* Button Request Code */
                    _context,
                    "Sign Up Now",
                    "signUpFirstScreen",
                    AppColors.greenColor,
                    FontWeight.normal,
                    size18,
                    EdgeInsets.only(top: size10, bottom: size10),
                    EdgeInsets.only(top: size15, bottom: size15),
                    BoxShadow(
                      color: Colors.black54.withOpacity(_modelSignUp.enable2 == false ? 0 : 0.3), 
                      blurRadius: 10.0, 
                      spreadRadius: 2.0, 
                      offset: Offset(2.0, 5.0),
                    ),
                    _modelSignUp.enable2 == true ? navigatePage : null
                  )
                ],
              ),
            ),
          ),
        ),
      )
    ],
  );
}
