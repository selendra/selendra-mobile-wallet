import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet_apps/src/model/model_signup.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/forgot_password_screen/forgot_password_body.dart';
import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:wallet_apps/src/screen/main_screen/forgot_password_screen/reset_password_screen/reset_password.dart';

class ForgotPassword extends StatefulWidget{
  State<StatefulWidget> createState() {
    return ForgotPasswordState();
  }
}

class ForgotPasswordState extends State<ForgotPassword> {

  ModelSignUp _modelSignUp = ModelSignUp();

  void onChanged(String label, String changed){

  }

  void requestCode(BuildContext context) async {
    dialogLoading(context);
    await forgetPassword(_modelSignUp).then((_response) async {
      Navigator.pop(context);
      await dialog(context, Text(_response['message']), Icon(Icons.done));
      Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassword(_modelSignUp)));
    });
  }

  void popScreen() {
    Navigator.pop(context);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: scaffoldBGDecoration(
        16.0, 16.0, 16.0, 0,
        color1, color2,
        forgotPasswordBodyWidget(context, _modelSignUp, onChanged, popScreen, requestCode)
      ),
    );
  }
}

// Widget body(BuildContext context) {

//   return Scaffold(
//     backgroundColor: getHexaColor(backgroundColor),
//     body: Stack(
//       children: <Widget>[
//         AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0.0,
//           iconTheme: IconThemeData(color: Colors.white70),
//         ),
//         Center(child: Text('Under construction !', style: TextStyle(fontSize: 20.0, foreground: Paint()..shader = linearGradient),),)
//         // SingleChildScrollView(
//         //   child: Container(
//         //     child: Column(
//         //       mainAxisAlignment: MainAxisAlignment.center,
//         //       children: <Widget>[
                
//         //         // Container(
//         //         //   margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0), 
//         //         //   child: inputField(context),
//         //         // )
//         //       ],
//         //     ),
//         //   ),
//         // )
//       ],
//     ),
//   );
// }

// Widget inputField(BuildContext context) {
//   return Column(
//     children: <Widget>[
//       TextField(
//         textInputAction: TextInputAction.done,
//         keyboardType: TextInputType.emailAddress,
//         // focusNode: emailNode,
//         // onChanged: (term) {
//         //   emailNode.unfocus();
//         //   FocusScope.of(context).requestFocus(passwordNode);
//         // },
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.only(top: 23.0, bottom: 23.0, left: 20.0),
//           labelStyle: TextStyle(color: Colors.white30),
//           labelText: 'Email',
//           enabledBorder: outlineInput(Colors.white30)
//         ),
//       ),
//       //Button
//       Container(
//         margin: EdgeInsets.all(25.0),
//         child: sendButton(context),
//       )
//     ],
//   );
// }

// Widget sendButton(BuildContext context) {
//   return Container(
//     margin: EdgeInsets.only(left: 35.0, right: 35.0),
//     width: double.infinity,
//     child: FlatButton(
//       padding: EdgeInsets.only(left: 60.0, right: 60.0, top: 20.0, bottom: 20.0),
//       textColor: Colors.white,
//       child: Text('Send', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18.0)),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
//       onPressed: () {
        
//       },
//     ),
//   );
// }