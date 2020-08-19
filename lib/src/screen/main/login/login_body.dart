import 'package:wallet_apps/index.dart';

Widget loginBody(
  BuildContext context,
  ModelLogin modelLogin,
  Function validateInput,
  Function validatePassword,
  Function onChanged,
  Function tabBarSelectChanged,
  Function showPassword,
  Function submtiLogin,
) {
  return Column(
    children: <Widget>[
      logoSize(AppConfig.logoName, 70.0, 47.62),
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
                FontAwesomeIcons.phone,
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
                child: userLoginForm( /* User Input Field */
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
                  submtiLogin: submtiLogin
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10.0),
                child: userLoginForm( /* User Input Field */
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
                  submtiLogin: submtiLogin
                ),
              )
            ],
          )
        )
      ),

      RaisedButton(
        onPressed: (){
          print("Hello world");
        },
      ),
      // Button login
      CustomFlatButton(
        textButton: "Login",
        widgetName: "loginSecondScreen",
        buttonColor: AppColors.blueColor,
        fontWeight: FontWeight.bold,
        fontSize: size18,
        edgeMargin: EdgeInsets.only(bottom: 15),
        edgePadding: EdgeInsets.only(top: size15, bottom: size15),
        boxShadow: BoxShadow(
          color: Colors.black54.withOpacity(modelLogin.enable == false ? 0 : 0.3),
          blurRadius: 10.0,
          spreadRadius: 2.0,
          offset: Offset(2.0, 5.0),
        ),
        // modelLogin.enable == false ? null : 
        action: submtiLogin
      ),
      // RaisedButton(
      //   child: Text("Hello"),
      //   onPressed: (){
      //     submtiLogin(context);
      //   },
      // ),
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
      forgotPass(
        context,
        AppColors.blueColor, 
        fontSize: 16.0, 
        fontWeight: FontWeight.w600,
      ),
    ],
  );
}

Widget userLoginForm({
  BuildContext context,
  String label,
  String prefixText,
  ModelLogin modelLogin,
  TextInputType inputType = TextInputType.phone,
  List<TextInputFormatter> textInputFormatter,
  Function validateInput,
  Function validatePassword,
  Function onChanged,
  Function showPassword,
  Function submtiLogin
}){
  return Column(
    children: <Widget>[
      /* Email & Phone Number Input Field*/
      Container(
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
          action: submtiLogin
        )
      ),
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
          action: submtiLogin
        ),
      ),
    ],
  );
}


class CustomFlatButton extends StatelessWidget{
  final String textButton;
  final String widgetName;
  final String buttonColor;
  final FontWeight fontWeight;
  final double fontSize;
  final EdgeInsetsGeometry edgeMargin;
  final EdgeInsetsGeometry edgePadding;
  final BoxShadow boxShadow;
  final Function action;

  CustomFlatButton({this.textButton, this.widgetName, this.buttonColor, this.fontWeight, this.fontSize, this.edgeMargin, this.edgePadding, this.boxShadow, this.action});

  Widget build(BuildContext context) {
    return  Container(
      margin: edgeMargin,
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(size5), boxShadow: [boxShadow]),
      child: FlatButton(
        color: getHexaColor(buttonColor),
        disabledTextColor: Colors.black54,
        disabledColor: Colors.grey[700],
        focusColor: getHexaColor("#83B6BD"),
        textColor: Colors.white,
        child: Text(
          textButton,
          style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(size5)),
        onPressed: (){
          action(context);
        }
        // action == null ? null : 
        // (){
        //   ();
        // }
      ),
    );
  }
}
