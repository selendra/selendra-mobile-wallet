import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:wallet_apps/src/model/model_login.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:flutter/material.dart';
import 'package:wallet_apps/src/screen/main_screen/login_screen/login_reuse_widget.dart';

/* body widget */
Widget phoneFieldBodyWidget(BuildContext context, ModelLogin modelLogin, Function onChanged, Function navigatePage) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch is fill cros axis
    children: <Widget>[
      /* Title of Zeetomic */
      Column(
        children: <Widget>[
          zeeLogo(45.03, 47.62),
          Container(
            margin: EdgeInsets.only(top: 38.96),
            child: textDisplay(
              "Login", 
              TextStyle(
                color: getHexaColor("#FFFFFF"),
                fontSize: 30.0,
                fontWeight: FontWeight.bold
              )
            ),
          )
        ],
      ),
      /* Body login */
      Container(
        padding: EdgeInsets.only(top: 59.0),
        /* User Input Field */
        child: userLogin(context, modelLogin, onChanged, navigatePage),
      ),
      /* Button login */
      blueButton(
        modelLogin.bloc,
        context,
        "Login", "phoneNumber",
        FontWeight.bold,
        size18,
        EdgeInsets.only(top: size10, bottom: size10),
        EdgeInsets.only(top: size15, bottom: size15),
        BoxShadow(
          color: Color.fromRGBO(0,0,0,0.54),
          blurRadius: 5.0
        ),
        navigatePage
      ),
      Expanded(child: Container()),
      noAccountWidget(context)
    ],
  );
}

/* Column of User Login */
Widget userLogin(BuildContext context, ModelLogin modelLogin, Function onChanged, Function navigatePage) {
  return Column(
    children: <Widget>[
      /* Phone number input*/
      Container(
        margin: EdgeInsets.only(bottom: 13.0), 
        child: inputField(
          modelLogin.bloc,
          context,
          "Phone number", modelLogin.countryCode, "PhoneScreen",
          false, 
          TextInputType.phone, modelLogin.controlPhoneNumbers,
          modelLogin.firstNode,
          onChanged,
          navigatePage
        )
      ),
      /* Password input */
      // Container(
      //   margin: EdgeInsets.only(bottom: 25.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: <Widget>[
      //       inputField("Password", null, colorSubmitted, true, TextInputType.text, secondNode)
      //       /* Password Label and Forget password button */,
      //       // Container(margin: EdgeInsets.only(bottom: 5.0), child: labelUserInput('Password', whiteColorHexa)),
      //       /* Password Input */
      //       // passwordField(bloc, controlPasswords, firstNode, secondNode, clearAllInput, disableLoginButton, validatorLogin),
      //     ],
      //   )
      // ),
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
            validatorLogin(bloc, context, clearAllInput, disableLoginButton);
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
    child: Text('Forgot password?', style: TextStyle(color: getHexaColor(lightBlueSky), fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
    onTap: () { Navigator.pushNamed(context, '/forgotPasswordScreen'); },
  );
}