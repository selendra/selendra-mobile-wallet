import 'package:Wallet_Apps/src/Bloc/Bloc.dart';
import 'package:Wallet_Apps/src/Provider/Hexa_Color_Convert.dart';
import 'package:Wallet_Apps/src/Provider/Reuse_Widget.dart';
import 'package:flutter/material.dart';

Widget bodyWidget(
  BuildContext context, 
  Bloc bloc,
  Function popScreen,
  Function submitValidator,
  FocusNode emailNode,
  FocusNode passwordNode,
  TextEditingController emailEditor,
  TextEditingController passwordEditor
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
                child: Text('Sign Up to ZEETOMIC', 
                  style: TextStyle(
                    foreground: Paint()..shader = linearGradient,
                    fontSize: 30.0,
                  )
                ),
              ),
            ),
            /* User Input Field Login */
            Container(
              padding: EdgeInsets.only(top: 10.0),
              margin: EdgeInsets.only(left: 50.0, right: 50.0, bottom: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  userEmail(emailEditor, emailNode, bloc),
                  /* Email Field */
                  userPassword(passwordEditor, passwordNode, bloc),
                ],
              )
            ),
            /* Button login */
            Container(
              margin: EdgeInsets.only(left: 50.0, right: 50.0,top: 10.0),
              child: signUpButton(bloc, submitValidator),
            ),
            /* To Login */
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(margin: EdgeInsets.only(right: 3.0), child: Text('Already have an account?', style: TextStyle(color: Colors.white)),),
                  toLogin(context),
                ],
              ),
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

/* User Email */
Widget userEmail(TextEditingController emailEditor, FocusNode emailNode, Bloc bloc) {
  return StreamBuilder(
    stream: bloc.emailObservable,
    builder: (context, snapshot){
      return Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 25.0), 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /* Email label */
                Container(margin: EdgeInsets.only(bottom: 5.0),child: labelUserInput('EMAIL ADDRESS', whiteColor),),
                /* Email Input */
                userTextField(emailEditor, emailNode, bloc.addEmail, snapshot, false, TextInputType.emailAddress, TextInputAction.next),
              ],
            )
          ),
        ],
      );
    },
  );
}
/* User Password */
Widget userPassword(TextEditingController passwordEditor, FocusNode passwordNode, Bloc bloc) {
  return StreamBuilder(
    stream: bloc.passwordObservable,
    builder: (context, snapshot){
      return Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /* Email label */
                Container(margin: EdgeInsets.only(bottom: 5.0),child: labelUserInput('PASSWORD', whiteColor),),
                /* Email Input */
                userTextField(passwordEditor, passwordNode, bloc.addPassword, snapshot, true, TextInputType.text, TextInputAction.done)
              ],
            )
          ),
        ],
      );
    },
  );
}

/* Sign Up Button */
Widget signUpButton(Bloc bloc, Function submitValidator) {
  return StreamBuilder(
    stream: bloc.submit,
    builder: (context, snapshot) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: FlatButton(
          color: Color(convertHexaColor(lightBlueSky)),
          disabledTextColor: Colors.black54,
          disabledColor: Colors.grey[700],
          focusColor: Color(convertHexaColor("#55D8EB")),
          padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
          textColor: Colors.black,
          child: Text(
            'Sign Up',
            style: TextStyle(fontSize: 17.0),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)),
          onPressed: 
          snapshot.data == null ? null : 
          () {
            submitValidator(bloc);
          }
        ),
      );
    },
  );
}

/* To Login */
Widget toLogin(BuildContext context) {
  return Align(
    alignment: Alignment.centerRight,
    child: InkWell(
      child: Text('Login', style: TextStyle(color: Color(convertHexaColor(lightBlueSky)), fontWeight: FontWeight.bold),),
      onTap: () { Navigator.pushReplacementNamed(context, '/');},
    ),
  );
}