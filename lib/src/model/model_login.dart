import 'package:flutter/material.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';

class ModelLogin {
  final String directory = "userID";

  bool isProgress = false, isLogedin = false, isBoth = false;

  String token; String phoneNumber = "", countryCode = "+855", label;

  var colorSubmitted = Colors.transparent;

  /* User login Property*/
  final FocusNode nodeEmails = FocusNode();
  final FocusNode nodePhoneNums = FocusNode();
  final FocusNode nodePasswords = FocusNode();
  TextEditingController controlEmails = TextEditingController();
  TextEditingController controlPasswords = TextEditingController();
  TextEditingController controlPhoneNums = TextEditingController();

  // QueryResult queryResult = QueryResult();

  Bloc bloc = Bloc();
}

// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'dart:async';
// import 'package:graphql_flutter/graphql_flutter.dart';

// import 'package:wallet_apps/src/provider/reuse_widget.dart';
// import 'package:wallet_apps/src/store_small_data/data_store.dart';
// import '../../../bloc/bloc.dart';
// import '../../../provider/internet_connection.dart';
// import './login_body.dart';


// class LoginWidget extends StatefulWidget {
//   final Function setMyState;
//   @override
//   LoginWidget(this.setMyState);
//   State<StatefulWidget> createState() {
//     return LoginState();
//   }
// }

// class LoginState extends State<LoginWidget> {
  
//   final String directory = "userID";

//   bool isProgress = false, isLogedin = false, isBoth = false;

//   String token; String phoneNumber = "+855 ";

//   var colorSubmitted = Colors.transparent;

//   /* User login Property*/
//   final FocusNode firstNode = FocusNode();
//   final FocusNode secondNode = FocusNode();
//   TextEditingController controlEmails = TextEditingController();
//   TextEditingController controlPasswords = TextEditingController();
//   TextEditingController controlPhoneNumbers = TextEditingController();

//   QueryResult queryResult = QueryResult();

//   Bloc bloc = Bloc();

//   @override
//   initState() {
//     /* Clear All Input Field */
//     clearAllInput();
//     /* Check For Previous Login */
//     checkLoginBefore();
//     /* Init State */
//     super.initState();
//   }

//   /* Check For Previous Login */
//   void checkLoginBefore() async {
//     var response = await fetchData('userToken');
//     if (response != null){
//       /* Loading */
//       dialogLoading(context);
//       /* Pop Loading */
//       await Future.delayed(Duration(milliseconds: 800), () {
//         Navigator.pop(context);
//       });
//       widget.setMyState();
//       Navigator.pushReplacementNamed(context, '/homeScreen');
//     }
//   }

//   /* Disable Login Button When Wrong Password And Error Something */
//   void disableLoginButton(Bloc bloc) {
//     bloc.addEmail(null); bloc.addPassword(null);
//   }

//   /* Clear Text In Field */
//   void clearAllInput() async {
//     controlEmails.clear(); controlPasswords.clear();
//   }

//   /* Check Internet Before Validate And Finish Validate*/
//   void checkInputAndValidate() async {
//     setState(() {isProgress = true;});  
//     await Future.delayed(Duration(milliseconds: 100), (){
//       checkConnection(context).then((isConnect) {
//         if ( isConnect == true ) {
//           validatorLogin(bloc, context, clearAllInput, disableLoginButton);
//         } else {
//           setState(() {
//             isProgress = false;
//             noInternet(context);
//           });
//         }
//       }); 
//     });
//   }

//   /* Validator User Login After Check Internet */
//   void validatorLogin(Bloc bloc, BuildContext context, Function clearAllInput, Function disableLoginButton) async{
//     /* Show Loading */
//     dialogLoading(context);
//     /* Response Result */
//     final submitResponse = await bloc.submitMethod(context).then((data) async {
//       if (data == true) {
//         Navigator.pop(context);
//         /* ReSet Bearer Token In Main Widget */
//         widget.setMyState();
//         /* Wait And Push Replace To HomePage */
//         await Future.delayed(Duration(milliseconds: 300), () async {
//           Navigator.pushReplacementNamed(context, '/homeScreen');
//         });
//       }
//       return data;
//     }).catchError((onError){
//       Navigator.pop(context);
//       setState(() => isProgress = false );
//       return false;
//     });
//     if (submitResponse == false) {
//       Navigator.pop(context);
//       clearAllInput(); 
//       disableLoginButton(bloc);
//     }
//   }

//   void resetScreen(BuildContext context) {
//     setState(() {
//       isBoth = true;
//     });
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: scaffoldBackColor(),
//         child: Stack(
//           children: <Widget>[
//             /* Body Widget */
//             loginBodyWidget(
//               isBoth,
//               phoneNumber,
//               bloc,
//               context,
//               controlEmails, controlPasswords,
//               firstNode, secondNode,
//               clearAllInput,
//               disableLoginButton,
//               validatorLogin,
//               resetScreen,
//               colorSubmitted,
//             ),
//           ],
//         ),
//       )
//     );
//   }

// }
