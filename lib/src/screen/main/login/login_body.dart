import 'package:wallet_apps/index.dart';

class LoginBody extends StatelessWidget{

  final List<MyInputField> listInput;
  final ModelLogin modelLogin;
  final Function validateInput;
  final Function validatePassword;
  final Function onChanged;
  final Function tabBarSelectChanged;
  final Function showPassword;
  final Function submitLogin;

  LoginBody({
    this.listInput,
    this.modelLogin,
    this.validateInput,
    this.validatePassword,
    this.onChanged,
    this.tabBarSelectChanged,
    this.showPassword,
    this.submitLogin,

  });
  
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        logoSize(AppConfig.logoName, 70.0, 47.62),
        Container(
          margin: EdgeInsets.only(top: 20.0),
          child: textDisplay(
            "Login",
            TextStyle(
              color: getHexaColor("#FFFFFF"),
              fontSize: 30.0,
              fontWeight: FontWeight.w400
            )
          ),
        ),
        Container( /* User Log In Choice */
          padding: EdgeInsets.only(top: 20.0),
          margin: EdgeInsets.only(bottom: 5),
          child: TabBar(
            unselectedLabelColor: Colors.grey.withOpacity(0.5),
            indicatorColor: getHexaColor(AppColors.blueColor),
            labelColor: getHexaColor(AppColors.blueColor),
            // labelStyle: TextStyle(fontSize: 30.0),
            tabs: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                width: double.infinity,
                child: Icon(LineAwesomeIcons.phone, size: 23.0,),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                alignment: Alignment.center,
                child: Icon(LineAwesomeIcons.envelope, size: 23.0),
              )
            ],
            onTap: tabBarSelectChanged,
          ),
        ),

        /* Email & Phone Number Input Field*/
        SizedBox(
          height: 230.0,
          child: Form(
            key: modelLogin.formState,
            child: TabBarView(
              children: [
                listInput[0],
                listInput[1]
              ],
            )
          ),
        ),
        // Container(
        //   margin: EdgeInsets.only(bottom: 13.0),
        //   child: 
        // ),

        CustomFlatButton(
          textButton: "Login",
          widgetName: "loginSecondScreen",
          buttonColor: AppColors.blueColor,
          fontWeight: FontWeight.bold,
          fontSize: size18,
          edgeMargin: EdgeInsets.only(bottom: 15),
          edgePadding: EdgeInsets.only(top: size15, bottom: size15),
          boxShadow: BoxShadow(
            color: Colors.black54.withOpacity(modelLogin.enable == false ? 0 : 0.3),
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 5.0),
          ),
          action: modelLogin.enable == false ? null : submitLogin
        )

      ],
    );
  }
}

// Widget userLoginForm({
//   String label,
//   String prefixText,
//   ModelLogin modelLogin,
//   TextInputType inputType = TextInputType.phone,
//   List<TextInputFormatter> textInputFormatter,
//   Function validateInput,
//   Function validatePassword,
//   Function onChanged,
//   Function showPassword,
//   Function submtiLogin
// }){
//   return Column(
//     children: <Widget>[
//       /* Email & Phone Number Input Field*/
//       Container(
//         margin: EdgeInsets.only(bottom: 13.0),
//         child: inputField(
//           context: context,
//           labelText: label,
//           prefixText: prefixText,
//           widgetName: "loginSecondScreen",
//           textInputFormatter: textInputFormatter,
//           // modelLogin.label == "email"
//           //   ?  /* If Label Equal Email Just Control Length Input Format */
//           //   : , /* Else Add Condition 0-9 Only */
//           inputType: inputType,
//           controller: modelLogin.label == "email"
//               ? modelLogin.controlEmails
//               : modelLogin.controlPhoneNums,
//           focusNode: modelLogin.label == "email"
//               ? modelLogin.nodeEmails
//               : modelLogin.nodePhoneNums,
//           validateField: validateInput,
//           onChanged: onChanged,
//           action: submtiLogin
//         )
//       ),
//       Container(
//         /* Password Input Field */
//         margin: EdgeInsets.only(bottom: 25.0),
//         child: inputField(
//           context: context,
//           labelText: "Password",
//           widgetName: "loginSecondScreen",
//           obcureText: modelLogin.securePassword,
//           textInputFormatter: [
//             LengthLimitingTextInputFormatter(TextField.noMaxLength)
//           ],
//           inputAction: TextInputAction.done,
//           controller: modelLogin.controlPasswords,
//           focusNode: modelLogin.nodePasswords,
//           validateField: validatePassword,
//           icon: IconButton(
//             icon: Icon(modelLogin.securePassword == true ? Icons.visibility_off : Icons.visibility, color: Colors.white),
//             onPressed: () {
//               if (modelLogin.securePassword == false) showPassword(true);
//               else showPassword(false);
//             },
//           ),
//           onChanged: onChanged,
//           action: submtiLogin
//         ),
//       ),
//     ],
//   );
// }

