import 'package:wallet_apps/index.dart';

Widget loginSecondBodyWidget(
  BuildContext context,
  ModelLogin modelLogin,
  Function validateInput,
  Function validatePassword,
  Function onChanged,
  Function tabBarSelectChanged,
  Function showPassword,
  Function validateAndSubmit
) {
  return Column(
    children: <Widget>[
      logoWelcomeScreen(AppConfig.logoName, 70.0, 47.62),
      Container(
        margin: EdgeInsets.only(top: 20.0),
        child: textDisplay(
          "Login",
          TextStyle(
            color: getHexaColor("#FFFFFF"),
            fontSize: 30.0,
            fontWeight: FontWeight.w400
          )
        ),
      ),
      Container( /* User Log In Choice */
        padding: EdgeInsets.only(top: 20.0),
        margin: EdgeInsets.only(bottom: 5),
        child: TabBar(
          unselectedLabelColor: Colors.grey.withOpacity(0.5),
          indicatorColor: getHexaColor(AppColors.blueColor),
          labelColor: getHexaColor(AppColors.blueColor),
          // labelStyle: TextStyle(fontSize: 30.0),
          tabs: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
              width: double.infinity,
              child: Icon(
                OMIcons.phone,
                size: 23.0,
              ),
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
      SizedBox( /* Body login */
        height: 230.0,
        child: Form(
            key: modelLogin.formState2,
            child: TabBarView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10),
                  margin: EdgeInsets.only(bottom: 10),
                  child: userLogin( /* User Input Field */
                    context: context,
                    label: "Phone number",
                    prefixText: "${modelLogin.countryCode} ",
                    modelLogin: modelLogin,
                    validateInput: validateInput,
                    validatePassword: validatePassword,
                    textInputFormatter: [
                      LengthLimitingTextInputFormatter(9),
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    onChanged: onChanged,
                    showPassword: showPassword,
                    validateAndSubmit: validateAndSubmit
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10.0),
                  child: userLogin( /* User Input Field */
                    context: context,
                    label: "Email",
                    inputType: TextInputType.emailAddress,
                    modelLogin: modelLogin,
                    validateInput: validateInput,
                    validatePassword: validatePassword,
                    textInputFormatter: [
                      LengthLimitingTextInputFormatter(TextField.noMaxLength)
                    ],
                    onChanged: onChanged,
                    showPassword: showPassword,
                    validateAndSubmit: validateAndSubmit
                  ),
              )
            ],
          )
        )
      ),
      customFlatButton(/* Button login */
        context,
        "Login",
        "loginSecondScreen",
        AppColors.blueColor,
        FontWeight.bold,
        size18,
        EdgeInsets.only(bottom: 15),
        EdgeInsets.only(top: size15, bottom: size15),
        BoxShadow(
          color: Colors.black54.withOpacity(modelLogin.enable2 == false ? 0 : 0.3),
          blurRadius: 10.0,
          spreadRadius: 2.0,
          offset: Offset(2.0, 5.0),
        ),
        modelLogin.enable2 == false ? null : validateAndSubmit
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          textScale(
            text: "Don't have account? ",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            hexaColor: "#FFFFFF"
          ),
          textButton(
            padding: EdgeInsets.only(left: 5, top: 10, bottom: 10),
            context: context,
            textColor: AppColors.blueColor,
            text: "Sign up",
            fontWeight: FontWeight.w600,
            fontSize: 18,
            onTap: () {
              Navigator.pushReplacementNamed(context, '/signUpScreen');
            }
          )
        ],
      ),
      Container(
        child: forgotPass(context, AppColors.blueColor, fontSize: 16.0, fontWeight: FontWeight.w600),
      ),
    ],
  );
}

Widget userLogin(
  {BuildContext context,
  String label,
  String prefixText,
  ModelLogin modelLogin,
  TextInputType inputType = TextInputType.phone,
  List<TextInputFormatter> textInputFormatter,
  Function validateInput,
  Function validatePassword,
  Function onChanged,
  Function showPassword,
  Function validateAndSubmit}
) {
  return Column(
    children: <Widget>[
      Container(
          /* Email & Phone Number Input Field*/
          margin: EdgeInsets.only(bottom: 13.0),
          child: inputField(
              context: context,
              labelText: label,
              prefixText: prefixText,
              widgetName: "loginSecondScreen",
              textInputFormatter: textInputFormatter,
              // modelLogin.label == "email"
              //   ?  /* If Label Equal Email Just Control Length Input Format */
              //   : , /* Else Add Condition 0-9 Only */
              inputType: inputType,
              controller: modelLogin.label == "email"
                  ? modelLogin.controlEmails
                  : modelLogin.controlPhoneNums,
              focusNode: modelLogin.label == "email"
                  ? modelLogin.nodeEmails
                  : modelLogin.nodePhoneNums,
              validateField: validateInput,
              onChanged: onChanged,
              action: validateAndSubmit)),
      Container(
        /* Password Input Field */
        margin: EdgeInsets.only(bottom: 25.0),
        child: inputField(
          context: context,
          labelText: "Password",
          widgetName: "loginSecondScreen",
          obcureText: modelLogin.securePassword,
          textInputFormatter: [
            LengthLimitingTextInputFormatter(TextField.noMaxLength)
          ],
          inputAction: TextInputAction.done,
          controller: modelLogin.controlPasswords,
          focusNode: modelLogin.nodePasswords,
          validateField: validatePassword,
          icon: IconButton(
            icon: Icon(modelLogin.securePassword == true ? Icons.visibility_off : Icons.visibility, color: Colors.white),
            onPressed: () {
              if (modelLogin.securePassword == false) showPassword(true);
              else showPassword(false);
            },
          ),
          onChanged: onChanged,
          action: validateAndSubmit
        ),
      ),
    ],
  );
}
