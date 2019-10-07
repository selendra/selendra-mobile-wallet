import 'package:Wallet_Apps/src/Provider/Hexa_Color_Convert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Provider/Reuse_Widget.dart';

class ForgotPasswordWidget extends StatefulWidget{
  State<StatefulWidget> createState() {
    return ForgotPasswordState();
  }
}

class ForgotPasswordState extends State<ForgotPasswordWidget> {
  Widget build(BuildContext context) {
    // Bloc bloc 
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: Container(
        child: body(context),
      ),
    );
  }
}

Widget body(BuildContext context) {
  return Scaffold(
    backgroundColor: Color(convertHexaColor(backgroundColor)),
    body: Stack(
      children: <Widget>[
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.white70),
        ),
        Center(child: Text('Under construction !', style: TextStyle(fontSize: 20.0, foreground: Paint()..shader = linearGradient),),)
        // SingleChildScrollView(
        //   child: Container(
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: <Widget>[
                
        //         // Container(
        //         //   margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0), 
        //         //   child: inputField(context),
        //         // )
        //       ],
        //     ),
        //   ),
        // )
      ],
    ),
  );
}

Widget inputField(BuildContext context) {
  return Column(
    children: <Widget>[
      TextField(
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.emailAddress,
        // focusNode: emailNode,
        // onChanged: (term) {
        //   emailNode.unfocus();
        //   FocusScope.of(context).requestFocus(passwordNode);
        // },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 23.0, bottom: 23.0, left: 20.0),
          labelStyle: TextStyle(color: Colors.white30),
          labelText: 'Email',
          enabledBorder: outlineInput(Colors.white30)
        ),
      ),
      //Button
      Container(
        margin: EdgeInsets.all(25.0),
        child: sendButton(context),
      )
    ],
  );
}

Widget sendButton(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(left: 35.0, right: 35.0),
    width: double.infinity,
    child: FlatButton(
      padding: EdgeInsets.only(left: 60.0, right: 60.0, top: 20.0, bottom: 20.0),
      textColor: Colors.white,
      child: Text('Send', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18.0)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {
        
      },
    ),
  );
}