import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:wallet_apps/src/model/model_login.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:flutter/material.dart';
import 'package:wallet_apps/src/screen/main_screen/main_reuse_widget.dart';

Widget signUpFirstBodyWidget(
  BuildContext context,
  ModelLogin _modelSignUp,
  Function popScreen, Function submitValidator, Function navigatePage, Function onChanged
) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.stretch, /* Stretch is fill cros axis */
    children: <Widget>[
      Column( /* Title of Zeetomic */
        children: <Widget>[
          zeeLogo(45.03, 47.62),
          Container(
            margin: EdgeInsets.only(top: 38.96),
            child: textDisplay(
              "Sign Up", 
              TextStyle(
                color: getHexaColor("#FFFFFF"),
                fontSize: 30.0,
                fontWeight: FontWeight.bold
              )
            ),
          )
        ],
      ),
      Container( /* Body Sign Up */
        padding: EdgeInsets.only(top: 59.0),
        child: Column( /* User Input Field */
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 13.0), 
              child: inputField(
                _modelSignUp.bloc,
                context,
                "Phone number", _modelSignUp.countryCode, "PhoneScreen",
                false, 
                TextInputType.phone, _modelSignUp.controlPhoneNumbers,
                _modelSignUp.firstNode,
                onChanged,
                navigatePage
              )
            )
          ],
        ),
      ),
      blueButton( /* Button Request Code */
        _modelSignUp.bloc,
        context,
        "Request Code", "phoneNumber", greenColor,
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
      toLogin(context)
    ],
  );
  // Center(
  //   child: SingleChildScrollView(
  //     physics: BouncingScrollPhysics(),
  //     child: Container(
  //       margin: EdgeInsets.only(top: 100.0),
  //       child: Column(
  //         children: <Widget>[
  //           /* Title of Zeetomic */
  //           Container(
  //             margin: EdgeInsets.only(bottom: 80.0),
  //             child: Center(
  //               child: Text('Sign Up to ZEETOMIC', 
  //                 style: TextStyle(
  //                   foreground: Paint()..shader = linearGradient,
  //                   fontSize: 30.0,
  //                 )
  //               ),
  //             ),
  //           ),
  //           /* User Input Field Login */
  //           Container(
  //             padding: EdgeInsets.only(top: 10.0),
  //             margin: EdgeInsets.only(left: 50.0, right: 50.0, bottom: 30.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: <Widget>[
  //                 userEmail(emailEditor, emailNode, bloc),
  //                 /* Email Field */
  //                 userPassword(passwordEditor, passwordNode, bloc),
  //               ],
  //             )
  //           ),
  //           /* Button login */
  //           Container(
  //             margin: EdgeInsets.only(left: 50.0, right: 50.0,top: 10.0),
  //             child: signUpButton(bloc, submitValidator),
  //           ),
  //           /* To Login */
  //           Container(
  //             margin: EdgeInsets.only(top: 20.0),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: <Widget>[
  //                 Container(margin: EdgeInsets.only(right: 3.0), child: Text('Already have an account?', style: TextStyle(color: Colors.white)),),
  //                 toLogin(context),
  //               ],
  //             ),
  //           ),
  //           /* Zeetomic Logo Bottomm side */
  //           Container(
  //             margin: EdgeInsets.only(top: 160.0),
  //             child: Center(
  //               child: Image.asset('assets/zeetomic-logo-footer.png', width: 150.0, height: 50.0,),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   ),
  // );
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
                Container(margin: EdgeInsets.only(bottom: 5.0),child: labelUserInput('EMAIL ADDRESS', whiteColorHexa),),
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
                Container(margin: EdgeInsets.only(bottom: 5.0),child: labelUserInput('PASSWORD', whiteColorHexa),),
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
          color: getHexaColor(lightBlueSky),
          disabledTextColor: Colors.black54,
          disabledColor: Colors.grey[700],
          focusColor: getHexaColor("#55D8EB"),
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
