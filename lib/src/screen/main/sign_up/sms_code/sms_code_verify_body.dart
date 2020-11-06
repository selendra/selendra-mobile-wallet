import 'package:wallet_apps/index.dart';

class SmsBody extends StatelessWidget{

  final int time;
  final SmsCodeModel smsCodeModel;
  final Map<String, dynamic> message;
  final Function onChanged;
  final Function onSubmit;
  final Function runTimer;
  final Function resetInput; 
  final Function resetTimer;

  SmsBody({
    @required this.time,
    @required this.smsCodeModel,
    @required this.message,
    @required this.onChanged,
    @required this.onSubmit,
    @required this.runTimer, 
    this.resetInput,
    @required this.resetTimer
  });

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        MyAppBar(
          title: "Verify sms",
          margin: EdgeInsets.only(bottom: 16.0),
          onPressed: (){
            Navigator.pop(context);
          }
        ),

        Container(
          margin: EdgeInsets.only(bottom: 30.0),
          child: SvgPicture.asset('assets/sms.svg', width: 300, height: 250)
        ),

        MyText(
          bottom: 60.0,
          width: 300.0,
          text: "We send you a verify code with your phone number +85515894139"
        ),

        Container(
          margin: EdgeInsets.only(bottom: 60),
          child: Form(
            key: smsCodeModel.formKey,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SmsBox(onChanged: onChanged, focusNode: smsCodeModel.node1, controller: smsCodeModel.controller1),
                SmsBox(onChanged: onChanged, focusNode: smsCodeModel.node2, controller: smsCodeModel.controller2),
                SmsBox(onChanged: onChanged, focusNode: smsCodeModel.node3, controller: smsCodeModel.controller3),
                SmsBox(onChanged: onChanged, focusNode: smsCodeModel.node4, controller: smsCodeModel.controller4),
                SmsBox(onChanged: onChanged, focusNode: smsCodeModel.node5, controller: smsCodeModel.controller5),
                SmsBox(right: 16.0, onChanged: onChanged, focusNode: smsCodeModel.node6, controller: smsCodeModel.controller6),
              ],
            )
          )
        ),

        MyFlatButton(
          width: 150,
          height: 58,
          edgeMargin: EdgeInsets.only(bottom: 26),
          textButton: "Clear",
          buttonColor: AppColors.secondary,
          fontWeight: FontWeight.bold,
          fontSize: size18,
          hasShadow: true,
          action: resetInput
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            MyText(
              text: !smsCodeModel.showResendBtn 
              ? "Resend Code in $time s" 
              : "Didn't receive code?",
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
