import 'package:wallet_apps/index.dart';

Widget smsCodeVerifyBody( /* Body widget */
  BuildContext context,
  ModelSignUp _modelSignup,
  Function onChanged,
  Function validatorLogin
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch, /* Stretch Is Fill Cross Axis */
    children: <Widget>[
      Container( /* Title of Zeetomic */
        child: Column(
          children: <Widget>[
            Container(
              child: textDisplay(
                "Sign up", 
                TextStyle(
                  color: getHexaColor("ffffff"),
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold
                )
              ),
            )
          ],
        ),
      ),
      Container( /* Body login */
        padding: EdgeInsets.only(top: 59.0),
        child: userLoginField( /* User Input Field */
          context,
          _modelSignup,
          onChanged,
          validatorLogin
        ),
      ),
      customFlatButton( /* Button login */
        context,
        "Sign Up", "smsCodeScreen", AppColors.greenColor,
        FontWeight.bold,
        size18,
        EdgeInsets.only(top: size10, bottom: 0),
        EdgeInsets.only(top: size15, bottom: size15),
        BoxShadow(
          color: Color.fromRGBO(0,0,0,0.54),
          blurRadius: 5.0
        ),
        validatorLogin
      ),
      Container( /* Resend Code Countdown */
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 30.0),
        child: Text("Resend Code in 59s", style: TextStyle(fontSize: 18.0),),
      ),
      Expanded(child: Container(),),
      toLogin(context),
    ],
  );
}

Widget userLoginField( /* Column of User Login */
  BuildContext context, 
  ModelSignUp _modelSignUp,
  Function onChanged, Function validatorLogin
  ) {
  return Column(
    children: <Widget>[
      Container( /* Email & Phone Number Input Field*/
        margin: EdgeInsets.only(bottom: 13.0), 
        child: inputField(
          context: context, 
          labelText: "Phone number", /* Label */
          prefixText: "${_modelSignUp.countryCode} ", /* Prefix */
          widgetName: "smsCodeScreen", /* Widget Name */
          textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
          inputType: TextInputType.phone,
          controller: _modelSignUp.controlPhoneNums,
          focusNode: _modelSignUp.nodePhoneNums, 
          validateField: instanceValidate.validatePhone, 
          onChanged: onChanged, 
          action: null
        )
      ),
      Container( /* Password input */
        margin: EdgeInsets.only(bottom: 25.0),
        child: inputField(
          context: context, 
          labelText: "Enter SMS code", 
          widgetName: "smsCodeScreen", 
          obcureText: true, 
          textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
          inputAction: TextInputAction.done,
          controller: _modelSignUp.controlSmsCode,
          focusNode: _modelSignUp.nodeSmsCode, 
          validateField: instanceValidate.validateSms, 
          onChanged: onChanged, 
          action: validatorLogin
        )
      ),
    ],
  );
}

// Widget emailField(Bloc bloc, TextEditingController controlPasswords, FocusNode firstNode, FocusNode secondNode) {
//   return StreamBuilder(
//     stream: bloc.emailObservable,
//     builder: (context, snapshot) {
//       return TextField(
//         controller: controlPasswords,
//         style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
//         textInputAction: TextInputAction.next,
//         focusNode: firstNode,
//         keyboardType: TextInputType.emailAddress,
//         onChanged: (userInput) {
//           bloc.addEmail(userInput);
//         },
//         decoration: InputDecoration(
//           filled: true, fillColor: black38,
//           hasFloatingPlaceholder: false,
//           contentPadding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: size10),
//           errorText: snapshot.error,
//           labelStyle: TextStyle(color: Colors.white),
//           /* Border side */
//           border: errorOutline(),
//           focusedErrorBorder: errorOutline(),
//           hintStyle: TextStyle(wordSpacing: 50.0),
//           enabledBorder: outlineInput(getHexaColor(borderColor)),
//           focusedBorder: outlineInput(getHexaColor(lightBlueSky)),
//         ),
//         onSubmitted: (value) {
//           firstNode.unfocus();
//           FocusScope.of(context).requestFocus(secondNode);
//         },
//       );
//     },
//   );
// }

Widget passwordField(Bloc bloc, TextEditingController controlPasswords, FocusNode firstNode, FocusNode secondNode, Function clearAllInput, Function disableLoginButton, Function validatorLogin) {
  return StreamBuilder(
    stream: bloc.passwordObservable,
    builder: (context, snapshot) {
      return TextField(
        controller: controlPasswords,
        style: TextStyle(color: Colors.white),
        focusNode: secondNode,
        obscureText: true,
        onChanged: (value) {
          bloc.addPassword(value);
        },
        decoration: InputDecoration(
          filled: true, fillColor: AppColors.black38,
          contentPadding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: size10),
          errorText: snapshot.error,
          // labelText: 'Password',
          labelStyle: TextStyle(color: Colors.white),
          /* Border side */
          border: errorOutline(),
          enabledBorder: outlineInput(getHexaColor(AppColors.borderColor)),
          focusedBorder: outlineInput(getHexaColor(AppColors.lightBlueSky)),
          focusedErrorBorder: errorOutline(),
        ),
        onSubmitted: (value) {
          try{
            bloc.submit.listen((submit){
              if (firstNode.hasFocus == false){
                if (submit == true && secondNode.hasFocus == false) {
                  validatorLogin(bloc, context, clearAllInput, disableLoginButton);
                }
              }
            });
          }catch(err){
          }
        },
      );
    },
  );
}

Widget loginButton(Bloc bloc, BuildContext context, Function clearAllInput, Function disableLoginButton, Function validatorLogin) {
  return StreamBuilder(
    stream: bloc.submit,
    builder: (context, snapshot) {
      /* Reset User Input And Button Login*/
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: FlatButton(
          color: getHexaColor(AppColors.lightBlueSky),
          disabledTextColor: Colors.black54, disabledColor: Colors.grey[700],
          focusColor: getHexaColor("#55D8EB"),
          padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
          textColor: Colors.black,
          child: Text(
            'LOGIN',
            style: TextStyle(fontSize: 17.0),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)),
          onPressed: 
          snapshot.data == null ? null : 
          () async {
            validatorLogin(bloc, context, clearAllInput, disableLoginButton);
          }
        ),
      );
    },
  );
}
