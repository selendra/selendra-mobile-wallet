import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:wallet_apps/src/model/model_login.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/login_screen/login_reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/main_reuse_widget.dart';

Widget loginFirstBodyWidget(
  /* body widget */
  BuildContext context,
  ModelLogin _modelLogin,
  Function onChanged, Function tabBarSelectChanged, Function enableButton, Function navigatePage
) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    /* Stretch is fill cros axis */
    children: <Widget>[
      Column(
        /* Title of Zeetomic */
        children: <Widget>[
          // zeelogo
          logoWelcomeScreen("CBM_V1.png", 70.0, 47.62),
          Container(
            margin: EdgeInsets.only(top: 60.0),
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
      Container( /* User Choice Log in */
        margin: EdgeInsets.only(top: 30.0, bottom: 59.0),
        child: TabBar(
          unselectedLabelColor: getHexaColor("#FFFFFF"),
          indicatorColor: getHexaColor(blueColor),
          labelColor: getHexaColor(blueColor),
          labelStyle: TextStyle(fontSize: 18.0),
          tabs: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              width: double.infinity,
              child: Text("Email"),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              alignment: Alignment.center,
              child: Text("Phone number"),
            )
          ],
          onTap: tabBarSelectChanged,
        ),
      ),
      Container( /* User Login Choice Body */
        height: 75.0,
        margin: EdgeInsets.only(bottom: 13.0),
        child: TabBarView( /* Body Sign Up */
          children: <Widget>[
            Container( /* Login By Email Field */
            padding: EdgeInsets.only(top: 9.0),
            child: inputFieldLogin(
              _modelLogin.bloc,
              _modelLogin.bloc.emailObservable,
              _modelLogin.bloc.addEmail,
              context,
              "Email",
              null,
              "loginFirstScreen",
              _modelLogin,
              false,
              TextField.noMaxLength,
              TextInputType.text,
              TextInputAction.done,
              _modelLogin.controlEmails,
              _modelLogin.nodeEmails,
              onChanged, enableButton, navigatePage
              )
            ),
            Container( /* Sign By Phone Number Field */
              padding: EdgeInsets.only(top: 9.0),
              child: inputFieldLogin(
                _modelLogin.bloc, 
                _modelLogin.bloc.phoneNumsObservable, 
                _modelLogin.bloc.addPhoneNums,
                context,
                "Phone number",
                "${_modelLogin.countryCode} ",
                "loginFirstScreen",
                _modelLogin,
                false,
                TextField.noMaxLength,
                TextInputType.phone,
                TextInputAction.done,
                _modelLogin.controlPhoneNums,
                _modelLogin.nodePhoneNums,
                onChanged, enableButton, navigatePage
              )
            )
          ],
        ),
      ),
      customFlatButton( /* Button login */
        _modelLogin.bloc,
        context,
        "Login",
        "loginFirstScreen",
        blueColor,
        FontWeight.bold,
        size18,
        EdgeInsets.only(top: size10, bottom: size10),
        EdgeInsets.only(top: size15, bottom: size15),
        BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.54), blurRadius: 5.0),
        _modelLogin.enable == false ? null : navigatePage
      ),
      Expanded(flex: 2, child: Container()),
      Row(
        /* Bottom Navigator */
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          noAccountWidget(context, Colors.white, "Create Account"),
          Text(
            "  |  ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          forgotPass(context, Colors.white),
        ],
      ),
    ],
  );
}

Widget inputFieldLogin( /* User Input Field */
  Bloc bloc,
  Stream _streamObservable, Function _addStream,
  BuildContext context,
  String labelText, String prefixText, String widgetName,
  ModelLogin _modelLogin,
  bool obcureText,
  int textInputLength,
  TextInputType inputType, TextInputAction inputAction, TextEditingController controller,
  FocusNode _focusNode,
  Function onChanged, Function enableButton, Function action
) {
  return StreamBuilder(
    stream: _streamObservable,
    builder: (context, AsyncSnapshot _snapshot){
      if (_snapshot.hasData) { /* If Snapshot Has Data */
        enableButton(true); /* Enable Button */ 
        _addStream(null); /* Make Null Value To Email Stream */ 
      }
      return TextFormField(
        focusNode: _focusNode, 
        keyboardType: inputType,
        obscureText: obcureText,
        controller: controller,
        textInputAction: inputAction,
        style: TextStyle(color: getHexaColor("#ffffff"), fontSize: 18.0),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: controller.text != "" ? getHexaColor("#FFFFFF").withOpacity(0.3) : Colors.transparent, 
              width: 1.0
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: getHexaColor("#FFFFFF").withOpacity(0.3), width: 1.0),
          ),
          prefixText: prefixText, prefixStyle: TextStyle(color: Colors.white, fontSize: 18.0),
          filled: true, fillColor: getHexaColor("#FFFFFF").withOpacity(0.1),
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 18.0,
            color: _focusNode.hasFocus || controller.text != "" ? getHexaColor("#FFFFF").withOpacity(0.3) : getHexaColor("#ffffff")
          ),
          focusColor: getHexaColor("#ffffff"),
          //errorText: _snapshot.hasError ? _snapshot.error : "",
          contentPadding: EdgeInsets.only(top: 23.0, bottom: 23.0, left: 26.0), // No Content Padding = -10.0 px
        ),
        inputFormatters: [LengthLimitingTextInputFormatter(textInputLength)],
        onChanged: (valueChange) {
          if (valueChange == "" || _snapshot.hasError) enableButton(false); /* Disable Login Button When Have Error And Empty */
          if (
            widgetName == "invoiceInfoScreen" || 
            widgetName == "addAssetScreen" || 
            widgetName == "loginFirstScreen" ||
            widgetName == "loginSecondScreen" ||
            widgetName == "signUpFirstScreen" 
          ) onChanged(labelText, valueChange);
          else onChanged(valueChange);
        },
        onFieldSubmitted: (value) {
          if (widgetName == "BothScreen" || widgetName == "invoiceInfoScreen") action(bloc, context);
          else action(context, value);
        },
        // onFieldSubmitted: (value) {
        //       firstNode.unfocus();
        //       FocusScope.of(context).requestFocus(secondNode);
        // }
      );
    },
  );
}

/* Column of User Login */
Widget userLogin(
  BuildContext context, ModelLogin _modelLogin,
  Function onChanged, Function navigatePage
){
  return Column(
    children: <Widget>[
      /* Phone number input*/
      // Container(
      //   margin: EdgeInsets.only(bottom: 13.0),
      //   child: inputField(
      //     _modelLogin.bloc,
      //     context,
      //     "Phone number", "${_modelLogin.countryCode} ", "loginFirstScreen",
      //     false,
      //     TextField.noMaxLength,
      //     TextInputType.phone, TextInputAction.next, _modelLogin.controlPhoneNums,
      //     _modelLogin.nodePhoneNums,
      //     onChanged,
      //     navigatePage
      //   )
      // ),
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
//     _streamObservable: bloc.emailObservable,
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

Widget passwordField(
    Bloc bloc,
    TextEditingController controlPasswords,
    FocusNode firstNode,
    FocusNode secondNode,
    Function clearAllInput,
    Function disableLoginButton,
    Function validatorLogin) {
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
          filled: true, fillColor: black38,
          contentPadding:
              EdgeInsets.only(top: 15.0, bottom: 15.0, left: size10),
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
          try {
            bloc.submit.listen((submit) {
              if (firstNode.hasFocus == false) {
                if (submit == true && secondNode.hasFocus == false) {
                  validatorLogin(bloc, context, clearAllInput, disableLoginButton);
                }
              }
            });
          } catch (err) {}
        },
      );
    },
  );
}

Widget loginButton(
  Bloc bloc, BuildContext context, Function clearAllInput,
  Function disableLoginButton, Function validatorLogin) {
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
            disabledTextColor: Colors.black54,
            disabledColor: Colors.grey[700],
            focusColor: getHexaColor("#55D8EB"),
            padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
            textColor: Colors.black,
            child: Text(
              'LOGIN',
              style: TextStyle(fontSize: 17.0),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            onPressed: snapshot.data == null
                ? null
                : () async {
                    validatorLogin(
                        bloc, context, clearAllInput, disableLoginButton);
                  }),
      );
    },
  );
}

/* To Register */
Widget register(BuildContext context) {
  return InkWell(
    child: Text('Sign up',
        style: TextStyle(
            color: getHexaColor(lightBlueSky), fontWeight: FontWeight.bold)),
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
            color: getHexaColor(lightBlueSky),
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline)),
    onTap: () {
      Navigator.pushNamed(context, '/forgotPasswordScreen');
    },
  );
}
