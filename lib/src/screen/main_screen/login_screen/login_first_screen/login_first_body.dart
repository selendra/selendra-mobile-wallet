import 'package:wallet_apps/index.dart';

Widget loginFirstBodyWidget( /* body widget */
  BuildContext context,
  ModelLogin _modelLogin,
  Function validateInput, Function onChanged, Function tabBarSelectChanged, Function navigatePage
) {
  return Column(
    children: <Widget>[
      logoWelcomeScreen(AppConfig.logoName, 70.0, 47.62),
      Container(
        margin: EdgeInsets.only(top: 60.0),
        child: textDisplay(
          "Login",
          TextStyle(
            color: getHexaColor("#FFFFFF"),
            fontSize: 30.0,
            fontWeight: FontWeight.w400
          )
        ),
      ),
      Container( /* User Choice Log in */
        margin: EdgeInsets.only(top: 30.0, bottom: 59.0),
        child: TabBar(
          unselectedLabelColor: getHexaColor("#FFFFFF"),
          indicatorColor: getHexaColor(AppColors.blueColor),
          labelColor: getHexaColor(AppColors.blueColor),
          // labelStyle: TextStyle(fontSize: 30.0),
          tabs: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              width: double.infinity,
              child: Icon(OMIcons.phone, size: 23.0,),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              alignment: Alignment.center,
              child: Icon(OMIcons.email, size: 23.0),
            )
          ],
          onTap: tabBarSelectChanged,
        ),
      ),
      Form(
        key: _modelLogin.formState1,
        child: Container(
          height: 100.0,
          child: TabBarView( /* Body Sign Up */
            children: <Widget>[
              Container( /* Sign By Phone Number Field */
                padding: EdgeInsets.only(top: 9.0),
                child: inputField(
                  context: context,
                  labelText: "Phone number",
                  prefixText: "${_modelLogin.countryCode} ",
                  widgetName: "loginFirstScreen",
                  textInputFormatter: [LengthLimitingTextInputFormatter(9), WhitelistingTextInputFormatter.digitsOnly],
                  inputType: TextInputType.phone,
                  inputAction: TextInputAction.done,
                  controller: _modelLogin.controlPhoneNums,
                  focusNode: _modelLogin.nodePhoneNums,
                  validateField: validateInput, 
                  onChanged: onChanged, 
                  action: navigatePage
                )
              ),
              Container( /* Login By Email Field */
                padding: EdgeInsets.only(top: 9.0),
                child: inputField(
                  context: context,
                  labelText: "Email",
                  prefixText: null,
                  widgetName: "loginFirstScreen",
                  textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                  inputType: TextInputType.emailAddress,
                  inputAction: TextInputAction.done,
                  controller: _modelLogin.controlEmails,
                  focusNode: _modelLogin.nodeEmails,
                  validateField: validateInput, 
                  onChanged: onChanged, 
                  action: navigatePage
                )
              ),
            ],
          ),
        ),
      ),
      Container(
        child: customFlatButton( /* Button login */
          context,
          "Login",
          "loginFirstScreen",
          AppColors.blueColor,
          FontWeight.bold,
          size18,
          EdgeInsets.only(top: size10, bottom: size10),
          EdgeInsets.only(top: size15, bottom: size15),
          BoxShadow(
            color: Colors.black54.withOpacity(_modelLogin.enable1 == false ? 0 : 0.3), 
            blurRadius: 10.0, 
            spreadRadius: 2.0, 
            offset: Offset(2.0, 5.0)
          ), 
          // .fromRGBO(0, 0, 0, 0.54)
          _modelLogin.enable1 == false ? null : navigatePage
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          textScale(
            text: "Don't have account? ", 
            fontSize: 18,
            hexaColor: "#FFFFFF"
          ),
          textButton(
            padding: EdgeInsets.only(left: 5, top: 10, bottom: 10),
            context: context, 
            textColor: "#FFFFFF",
            text: "Sign up",
            fontWeight: FontWeight.bold,
            fontSize: 18,
            onTap: (){
              Navigator.pushReplacementNamed(context, '/signUpScreen');
            }
          ),
        ],
      ),
      forgotPass(context, AppColors.blueColor),
    ],
  );
}

/* To Register */
Widget register(BuildContext context) {
  return InkWell(
    child: Text('Sign up',
      style: TextStyle(
      color: getHexaColor(AppColors.lightBlueSky), fontWeight: FontWeight.bold)
    ),
    onTap: () {
      Navigator.pushReplacementNamed(context, '/signUp');
    },
  );
}

/* Forgot Password Button */
Widget forgotPasswordBody(BuildContext context) {
  return InkWell(
    child: Text('Forgot password?',
      style: TextStyle(
        color: getHexaColor(AppColors.lightBlueSky),
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline
      )
    ),
    onTap: () {
      Navigator.pushNamed(context, '/forgotPasswordScreen');
    },
  );
}
