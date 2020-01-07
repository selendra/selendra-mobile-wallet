import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:wallet_apps/src/model/model_login.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:flutter/material.dart';
import 'package:wallet_apps/src/screen/main_screen/main_reuse_widget.dart';

/* body widget */
Widget loginSdcondBodyWidget(
  BuildContext context,
  ModelLogin _modelLogin,
  Function onChanged,
  Function checkInputAndValidate
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch, /* Stretch is fill cros axis */
    children: <Widget>[
      Container( /* Title of Zeetomic */
        child: Column(
          children: <Widget>[
            Container(
              child: textDisplay(
                "Login", 
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
        margin: EdgeInsets.only(top: 59.0),
        child: userLogin( /* User Input Field */
          context,
          _modelLogin,
          onChanged,
          checkInputAndValidate
        ),
      ),
      customFlatButton( /* Button login */
        _modelLogin.bloc,
        context,
        "Login", "loginSecondScreen", blueColor,
        FontWeight.bold,
        size18,
        EdgeInsets.only(top: size10, bottom: 0),
        EdgeInsets.only(top: size15, bottom: size15),
        BoxShadow(
          color: Color.fromRGBO(0,0,0,0.54),
          blurRadius: 5.0
        ),
        checkInputAndValidate
      ),
      Container(
        margin: EdgeInsets.only(top: 30.0),
        alignment: Alignment.center, 
        child: forgotPassword(context)
      ),
      Expanded(flex: 2, child: Container()),
      noAccountWidget(context, getHexaColor(blueColor)) /* Bottom Align Sign Up */ 
    ],
  );
}

Widget userLogin( /* Column of User Login */
  BuildContext context, 
  ModelLogin _modelLogin,
  Function onChanged, Function checkInputAndValidate
  ) {
  return Column(
    children: <Widget>[
      Container( /* Email & Phone Number Input Field*/
        margin: EdgeInsets.only(bottom: 13.0), 
        child: inputField(
          _modelLogin.bloc, 
          context, 
          _modelLogin.controlEmails.text != "" ? "Email" : "Phone number", 
          _modelLogin.controlEmails.text != "" ? null : _modelLogin.countryCode, 
          "loginSecondScreen", 
          false, 
          _modelLogin.controlEmails.text != "" ? TextInputType.text : TextInputType.phone,
          TextInputAction.next,
          _modelLogin.controlEmails.text != "" ? _modelLogin.controlEmails : _modelLogin.controlPhoneNums,
          _modelLogin.controlEmails.text != "" ? _modelLogin.nodeEmails : _modelLogin.nodePhoneNums, 
          onChanged, 
          null
        )
      ),
      Container( /* Password Input Field */
        margin: EdgeInsets.only(bottom: 25.0),
        child: inputField(
          _modelLogin.bloc,
          context, 
          "Password", null, "loginSecondScreen", 
          true, 
          TextInputType.text, TextInputAction.done,
          _modelLogin.controlPasswords,
          _modelLogin.nodePasswords, 
          onChanged, 
          checkInputAndValidate
        ),
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: <Widget>[
            
            /* Password Label and Forget password button */
            // Container(margin: EdgeInsets.only(bottom: 5.0), child: labelUserInput('Password', whiteColorHexa)),
            /* Password Input */
            // passwordField(bloc, controlPasswords, firstNode, secondNode, clearAllInput, disableLoginButton, checkInputAndValidate),
        //   ],
        // )
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

Widget passwordField(Bloc bloc, TextEditingController controlPasswords, FocusNode firstNode, FocusNode secondNode, Function clearAllInput, Function disableLoginButton, Function checkInputAndValidate) {
  return StreamBuilder(
    stream: bloc.passwordObservable,
    builder: (context, snapshot) {
      // print(secondNode.hasFocus);
      return TextField(
        controller: controlPasswords,
        style: TextStyle(color: Colors.white),
        focusNode: secondNode,
        obscureText: true,
        onChanged: (value) {
          bloc.addPassword(value);
        },
        decoration: InputDecoration(
          filled: true, fillColor: black38,
          contentPadding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: size10),
          errorText: snapshot.error,
          // labelText: 'Password',
          labelStyle: TextStyle(color: Colors.white),
          /* Border side */
          border: errorOutline(),
          enabledBorder: outlineInput(getHexaColor(borderColor)),
          focusedBorder: outlineInput(getHexaColor(lightBlueSky)),
          focusedErrorBorder: errorOutline(),
        ),
        onSubmitted: (value) {
          try{
            bloc.submit.listen((submit){
              if (firstNode.hasFocus == false){
                if (submit == true && secondNode.hasFocus == false) {
                  checkInputAndValidate(bloc, context, clearAllInput, disableLoginButton);
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

Widget loginButton(Bloc bloc, BuildContext context, Function clearAllInput, Function disableLoginButton, Function checkInputAndValidate) {
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
          color: getHexaColor(lightBlueSky),
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
            checkInputAndValidate(bloc, context, clearAllInput, disableLoginButton);
          }
        ),
      );
    },
  );
}

/* To Register */
Widget register(BuildContext context) {
  return InkWell(
    child: Text('Sign up', style: TextStyle(color: getHexaColor(lightBlueSky), fontWeight: FontWeight.bold)),
    onTap: () { Navigator.pushReplacementNamed(context, '/signUp');},
  );
}

/* Forgot Password Button */
Widget forgotPassword(BuildContext context) {
  return InkWell(
    child: textDisplay(
      "Forgot Password",
      TextStyle(
        color: getHexaColor("#FFFFFF"),
        fontSize: 18.0,
      )
    ),
    onTap: () { Navigator.pushNamed(context, '/forgotPasswordScreen'); },
  );
}