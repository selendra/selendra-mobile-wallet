import 'package:Wallet_Apps/src/Provider/Reuse_Widget.dart';
import 'package:flutter/material.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'dart:ui';
import '../../Provider/Hexa_Color_Convert.dart';

class DefaultWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DefaultWidgetState();
  }
}

class DefaultWidgetState extends State<DefaultWidget> {
  // GoogleSignInAccount user_data;
  
  final String redirectUrl = "https://testnet.zeetomic.com";
  final String clientId = '81l6052tuwhceq';
  final String clientSecret = 'P8T0FNCQJfQ3ArLq';

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(convertHexaColor(backgroundColor)),
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 35.0,bottom: 35.0),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      login(context),
                      Container(margin: EdgeInsets.only(top: 10.0, bottom: 10.0),),
                      createNewAcc(context)
                    ],
                  ),
                ),
                // Container(margin: EdgeInsets.only(top: 100.0, bottom: 100.0),),

                // Container(margin: EdgeInsets.only(bottom: 10),),
                // linkedInButton(),
                // Container(margin: EdgeInsets.only(bottom: 5),),
                // googleButton(),
                // Container(margin: EdgeInsets.only(bottom: 50.0),),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Widget googleButton() {
  //   if (user_data == null) {
  //     return GoogleSignInButton(
  //       darkMode: true,
  //       onPressed: () {
  //         // googleSignUp();
  //       },
  //     );
  //   } else {
  //     return IconButton(
  //       icon: Icon(Icons.power_settings_new),
  //       iconSize: 28.0,
  //       onPressed: () {
  //         googleSignOut();
  //       },
  //     );
  //   }
  // }

  Widget linkedInButton() {
    return LinkedInButtonStandardWidget(
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => linkedInLogin(),
            // fullscreenDialog: true
          )
        );
      },
    );
  }

  Widget circularProgress() {
    return CircularProgressIndicator();
  }

  Widget login(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 70.0, right: 70.0),
      decoration: BoxDecoration(
        // boxShadow: [
        //   shadow()
        // ],
        borderRadius: BorderRadius.circular(35.0,),
        gradient: LinearGradient(
          colors: [
            Color(convertHexaColor('#cB356b')),
            Color(convertHexaColor('##bd3f32')),
          ]
        )
      ),
      // child: flatButton(LoginWidget(), 'Login', context)
    );
  }

  Widget createNewAcc(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 70.0, right: 70.0),
      decoration: BoxDecoration(
        // boxShadow: [
        //   shadow()
        // ],
        gradient: LinearGradient(
          colors: [
            Color(convertHexaColor('#384A65')),
            Color(convertHexaColor('#384A65'))
          ],
        ),
        border: Border.all(width: 2.0, color: Color(convertHexaColor('#82939B'))),
        borderRadius: BorderRadius.circular(35.0)
      ),
      child: Text('Hello world')
    );
  }
  
  Widget flatButton(dynamic pushClass, String text, BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.only(top: 22.0, bottom: 22.0),
      textColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
      child: Text(text, style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.w300,),),
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> pushClass));
      }
    );
  }

  // void googleSignUp() {
  //   _googleSignIn.signIn(); 
  //   _googleSignIn.onCurrentUserChanged.listen((account) {
  //     if ( account != null ) Navigator.push(context, MaterialPageRoute(builder: (context) => home_screen.fromGoogle(dataFromGG: account, google: _googleSignIn,)));
  //   });
  // }

  void googleSignOut() {
    // _googleSignIn.signOut();
    setState(() {});
  }

  Widget linkedInLogin() {
    return LinkedInUserWidget(
      onGetUserProfile: (LinkedInUserModel linkedInUser){
        // print(linkedInUser);
      },
      redirectUrl: redirectUrl,
      clientId: clientId,
      clientSecret: clientSecret,
    );
  }

}
