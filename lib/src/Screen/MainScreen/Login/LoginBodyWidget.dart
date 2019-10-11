import 'package:Wallet_Apps/src/Bloc/Bloc.dart';
import 'package:Wallet_Apps/src/Provider/Hexa_Color_Convert.dart';
import 'package:Wallet_Apps/src/Provider/Reuse_Widget.dart';
import 'package:flutter/material.dart';

/* body widget */
Widget bodyWidget(
  Bloc bloc, 
  BuildContext context, 
  TextEditingController controlEmails, TextEditingController controlPasswords,
  FocusNode firstNode, FocusNode secondNode,
  Function clearAllInput, Function disableLoginButton, Function validatorLogin
) {
  return Center(
    child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        margin: EdgeInsets.only(top: 100.0),
        child: Column(
          children: <Widget>[
            /* Title of Zeetomic */
            Container(
              margin: EdgeInsets.only(bottom: 80.0),
              child: Center(
                child: Text('Login to ZEETOMIC', 
                  style: TextStyle(
                    foreground: Paint()..shader = linearGradient,
                    fontSize: 30.0,
                  )
                ),
              ),
            ),
            /* Body login */
            Container(
              padding: EdgeInsets.only(top: 10.0),
              margin: EdgeInsets.only(left: 50.0, right: 50.0, bottom: 30.0),
              /* User Input Field */
              child: userLogin(bloc, context, controlEmails, controlPasswords, firstNode, secondNode, clearAllInput, disableLoginButton, validatorLogin),
            ),
            /* Button login */
            Container(
              margin: EdgeInsets.only(left: 50.0, right: 50.0, top: 10.0),
              child: loginButton(bloc, context, clearAllInput, disableLoginButton, validatorLogin),
            ),
            /* Forgot password button */
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(margin: EdgeInsets.only(right: 3.0), child: Text('Don\'t have an account?', style: TextStyle(color: Colors.white)),),
                  register(context),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              alignment: Alignment.center, 
              child: forgotPassword(context)
            ),
            /* Zeetomic Logo Bottomm side */
            Container(
              margin: EdgeInsets.only(top: 160.0),
              child: Center(
                child: Image.asset('assets/zeetomic-logo-footer.png', width: 150.0, height: 50.0,),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// /* Column of User Login */
Widget userLogin(Bloc bloc, BuildContext context, TextEditingController controlEmails, TextEditingController controlPasswords, FocusNode firstNode, FocusNode secondNode, Function clearAllInput, Function disableLoginButton, Function validatorLogin) {
  return Column(
    children: <Widget>[
      /* User Email input*/
      Container(
        margin: EdgeInsets.only(bottom: 25.0), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /* Email label */
            Container(margin: EdgeInsets.only(bottom: 5.0),child: labelUserInput('Email', whiteColor),),
            /* Email Input */
            emailField(bloc, controlEmails, firstNode, secondNode)
          ],
        )
      ),
      /* User Password input */
      Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /* Password Label and Forget password button */
            Container(margin: EdgeInsets.only(bottom: 5.0), child: labelUserInput('Password', whiteColor)),
            /* Password Input */
            passwordField(bloc, controlPasswords, firstNode, secondNode, clearAllInput, disableLoginButton, validatorLogin),
          ],
        )
      ),
    ],
  );
}

Widget emailField(Bloc bloc, TextEditingController controlPasswords, FocusNode firstNode, FocusNode secondNode) {
  return StreamBuilder(
    stream: bloc.emailObservable,
    builder: (context, snapshot) {
      return TextField(
        controller: controlPasswords,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
        textInputAction: TextInputAction.next,
        focusNode: firstNode,
        keyboardType: TextInputType.emailAddress,
        onChanged: (userInput) {
          bloc.addEmail(userInput);
        },
        decoration: InputDecoration(
          filled: true, fillColor: black38,
          hasFloatingPlaceholder: false,
          contentPadding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: margin10),
          errorText: snapshot.error,
          labelStyle: TextStyle(color: Colors.white),
          /* Border side */
          border: errorOutline(),
          focusedErrorBorder: errorOutline(),
          hintStyle: TextStyle(wordSpacing: 50.0),
          enabledBorder: outlineInput(Color(convertHexaColor(borderColor))),
          focusedBorder: outlineInput(Color(convertHexaColor(lightBlueSky))),
        ),
        onSubmitted: (value) {
          firstNode.unfocus();
          FocusScope.of(context).requestFocus(secondNode);
        },
      );
    },
  );
}

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
          contentPadding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: margin10),
          errorText: snapshot.error,
          // labelText: 'Password',
          labelStyle: TextStyle(color: Colors.white),
          /* Border side */
          border: errorOutline(),
          enabledBorder: outlineInput(Color(convertHexaColor(borderColor))),
          focusedBorder: outlineInput(Color(convertHexaColor(lightBlueSky))),
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
          color: Color(convertHexaColor(lightBlueSky)),
          disabledTextColor: Colors.black54, disabledColor: Colors.grey[700],
          focusColor: Color(convertHexaColor("#55D8EB")),
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
    child: Text('Sign up', style: TextStyle(color: Color(convertHexaColor(lightBlueSky)), fontWeight: FontWeight.bold)),
    onTap: () { Navigator.pushReplacementNamed(context, '/signUp');},
  );
}

/* Forgot Password Button */
Widget forgotPassword(BuildContext context) {
  return InkWell(
    child: Text('Forgot password?', style: TextStyle(color: Color(convertHexaColor(lightBlueSky)), fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
    onTap: () { Navigator.pushNamed(context, '/forgotPasswordScreen'); },
  );
}