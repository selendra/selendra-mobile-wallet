import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/components/sms_component.dart';
import 'package:wallet_apps/src/model/sms_code_model.dart';

class SmsBody extends StatelessWidget{

  final int time;
  final SmsCodeModel smsCodeModel;
  final Map<String, dynamic> message;
  final Function onChanged;
  final Function onSubmit;
  final Function runTimer; 
  final Function resetTimer;

  SmsBody({
    @required this.time,
    @required this.smsCodeModel,
    @required this.message,
    @required this.onChanged,
    @required this.onSubmit,
    @required this.runTimer, 
    @required this.resetTimer
  });

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        MyAppBar(
          title: "Verification",
          action: (){
            Navigator.pop(context);
          }
        ),
        

        FittedBox(
          fit: BoxFit.contain,
          child: Image.asset('assets/images/sms.png', width: 293, height: 216),
        ),

        MyText(
          text: "Verification Code"
        ), 
        // Container(
        //   padding: EdgeInsets.only(bottom: 15.0),
        //   child: FittedBox(
        //     fit: BoxFit.contain,
        //     child: Text("", style: TextStyle(fontSize: 18))
        //   ),
        // ),

        Container(
          padding: EdgeInsets.only(bottom: 15.0),
          child: Text("${message['message']}", textAlign: TextAlign.center),
        ),

        Form(
          key: smsCodeModel.formKey,
          child: Row(
            children: <Widget>[
              SmsBox(right: 5.0, onChanged: onChanged, focusNode: smsCodeModel.node1, controller: smsCodeModel.controller1),
              SmsBox(right: 5.0, onChanged: onChanged, focusNode: smsCodeModel.node2, controller: smsCodeModel.controller2),
              SmsBox(right: 5.0, onChanged: onChanged, focusNode: smsCodeModel.node3, controller: smsCodeModel.controller3),
              SmsBox(right: 5.0, onChanged: onChanged, focusNode: smsCodeModel.node4, controller: smsCodeModel.controller4),
              SmsBox(right: 5.0, onChanged: onChanged, focusNode: smsCodeModel.node5, controller: smsCodeModel.controller5),
              SmsBox(onChanged: onChanged, focusNode: smsCodeModel.node6, controller: smsCodeModel.controller6),
            ],
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            MyText(
              text: !smsCodeModel.showResendBtn 
              ? "Resend Code in $time s" 
              : "Didn't receive a code?",
            ),
            !smsCodeModel.showResendBtn ? Container() 
            : Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: InkWell(
                onTap: (){
                  resetTimer();
                  Timer.periodic(Duration(milliseconds: 1000), runTimer);
                },
                child: MyText(
                  text: "Resend Code",
                  color: AppColors.secondary_text,
                ),
              )
            )
          ],
        )
        // resendBtn(time: time, smsCodeModel: smsCodeModel, resetTimer: resetTimer, runTimer: runTimer),
      ],
    );
  }
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
              child: Text("Resend Code", textAlign: TextAlign.start, style: TextStyle(fontSize: 18.0, color: hexaCodeToColor(AppColors.lightBlueSky),)),
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
          enabledBorder: myOutlineInput(hexaCodeToColor(AppColors.borderColor)),
          focusedBorder: myOutlineInput(hexaCodeToColor(AppColors.lightBlueSky)),
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
