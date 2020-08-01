import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/components/sms_component.dart';
import 'package:wallet_apps/src/model/sms_code_model.dart';

SmsComponent smsComponent = SmsComponent();

Widget smsCodeVerifyBody( /* Body widget */
  BuildContext context,
  int time,
  SmsCodeModel _smsCodeModel,
  Map<String, dynamic> message,
  Function onChanged,
  Function onSubmit,
  Function runTimer, Function resetTimer,
) {
  return SafeArea(
    child: SingleChildScrollView(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center, /* Stretch Is Fill Cross Axis */
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white,),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ),

          FittedBox(
            fit: BoxFit.contain,
            child: Image.asset('assets/images/message.png', width: 200.0, height: 200.0, color: getHexaColor(AppColors.lightBlueSky)),
          ),

          Container(
            padding: EdgeInsets.only(bottom: 15.0),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text("Verification Code", style: TextStyle(fontSize: 18))
            ),
          ),

          Container(
            padding: EdgeInsets.only(bottom: 15.0),
            child: Text("${message['message']}", textAlign: TextAlign.center),
          ),

          Form(
            key: _smsCodeModel.formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SmsComponent.boxCode(right: 5.0, onChanged: onChanged, focusNode: _smsCodeModel.node1, controller: _smsCodeModel.controller1),
                SmsComponent.boxCode(right: 5.0, onChanged: onChanged, focusNode: _smsCodeModel.node2, controller: _smsCodeModel.controller2),
                SmsComponent.boxCode(right: 5.0, onChanged: onChanged, focusNode: _smsCodeModel.node3, controller: _smsCodeModel.controller3),
                SmsComponent.boxCode(right: 5.0, onChanged: onChanged, focusNode: _smsCodeModel.node4, controller: _smsCodeModel.controller4),
                SmsComponent.boxCode(right: 5.0, onChanged: onChanged, focusNode: _smsCodeModel.node5, controller: _smsCodeModel.controller5),
                SmsComponent.boxCode(onChanged: onChanged, focusNode: _smsCodeModel.node6, controller: _smsCodeModel.controller6),
              ],
            )
          ),

          // customFlatButton( /* Button login */
          //   context,
          //   "Sign Up", "smsCodeScreen", AppColors.greenColor,
          //   FontWeight.bold,
          //   size18,
          //   EdgeInsets.only(top: size10, bottom: 0),
          //   EdgeInsets.only(top: size15, bottom: size15),
          //   BoxShadow(
          //     color: Color.fromRGBO(0,0,0,0.54),
          //     blurRadius: 5.0
          //   ),
          //   onSubmit
          // ),
          resendBtn(time: time, smsCodeModel: _smsCodeModel, resetTimer: resetTimer, runTimer: runTimer),
        ],
      ),
    ),
  );
}

Widget resendBtn({int time, SmsCodeModel smsCodeModel, Function resetTimer, Function runTimer}){
  return FittedBox(
    fit: BoxFit.contain,
    child: Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            !smsCodeModel.showResendBtn ? "Resend Code in $time\s" 
            : "Didn't receive a code?",
            style: TextStyle(fontSize: 18.0),
          ),
          !smsCodeModel.showResendBtn ? Container() 
          : Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: InkWell(
              onTap: (){
                resetTimer();
                Timer.periodic(Duration(milliseconds: 1000), runTimer);
              },
              child: Text("Resend Code", textAlign: TextAlign.start, style: TextStyle(fontSize: 18.0, color: getHexaColor(AppColors.lightBlueSky),)),
            )
          )
        ],
      )
    ),
  );
}

// Widget userLoginField( /* Column of User Login */
//   BuildContext context, 
//   ModelSignUp _modelSignUp,
//   Function onChanged, Function onSubmit
//   ) {
//   return Column(
//     children: <Widget>[
//       Container( /* Password input */
//         margin: EdgeInsets.only(bottom: 25.0),
//         child: inputField(
//           context: context, 
//           labelText: "Enter SMS code", 
//           widgetName: "smsCodeScreen", 
//           obcureText: true, 
//           textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
//           inputAction: TextInputAction.done,
//           controller: _modelSignUp.controlSmsCode,
//           focusNode: _modelSignUp.nodeSmsCode, 
//           validateField: instanceValidate.validateSms, 
//           onChanged: onChanged, 
//           action: onSubmit
//         )
//       ),
//     ],
//   );
// }

Widget passwordField(Bloc bloc, TextEditingController controlPasswords, FocusNode firstNode, FocusNode secondNode, Function clearAllInput, Function disableLoginButton, Function onSubmit) {
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
          filled: true, fillColor: AppColors.black38,
          contentPadding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: size10),
          errorText: snapshot.error,
          // labelText: 'Password',
          labelStyle: TextStyle(color: Colors.white),
          /* Border side */
          border: errorOutline(),
          enabledBorder: outlineInput(getHexaColor(AppColors.borderColor)),
          focusedBorder: outlineInput(getHexaColor(AppColors.lightBlueSky)),
          focusedErrorBorder: errorOutline(),
        ),
        onSubmitted: (value) {
          try{
            bloc.submit.listen((onSubmit){
              if (firstNode.hasFocus == false){
                if (onSubmit == true && secondNode.hasFocus == false) {
                  onSubmit(bloc, context, clearAllInput, disableLoginButton);
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
