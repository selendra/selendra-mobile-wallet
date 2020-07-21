import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/model/sms_code_model.dart';

class SmsCodeVerify extends StatefulWidget{

  final ModelSignUp _modelSignUp;

  SmsCodeVerify(this._modelSignUp);
  @override
  State<StatefulWidget> createState() {
    return SmsCodeVerifyState();
  }
}

class SmsCodeVerifyState extends State<SmsCodeVerify> with WidgetsBindingObserver {

  PostRequest _postRequest = PostRequest();

  SmsCodeModel _smsCodeModel = SmsCodeModel();

  int time = 30;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    Timer.periodic(Duration(milliseconds: 1000), resendTimer);
    super.initState();
    focusOnPassword();
  }

  @override
  void dispose() {
    // widget._modelSignUp.nodeSmsCodeVerify.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  
  void onChanged(String value){
    print(value);
    if (_smsCodeModel.node1.hasFocus && _smsCodeModel.controller1.text != "") FocusScope.of(context).requestFocus(_smsCodeModel.node2);
    else if (_smsCodeModel.node2.hasFocus && _smsCodeModel.controller2.text != "") FocusScope.of(context).requestFocus(_smsCodeModel.node3);
    else if (_smsCodeModel.node3.hasFocus && _smsCodeModel.controller3.text != "") FocusScope.of(context).requestFocus(_smsCodeModel.node4);
    else if (_smsCodeModel.node4.hasFocus && _smsCodeModel.controller4.text != "") FocusScope.of(context).requestFocus(_smsCodeModel.node5);
    else if (_smsCodeModel.node5.hasFocus && _smsCodeModel.controller5.text != "") FocusScope.of(context).requestFocus(_smsCodeModel.node6);
    else if (_smsCodeModel.node6.hasFocus && _smsCodeModel.controller6.text != "") {
      print("Submitted");
      Timer(Duration(milliseconds: 100), (){
        FocusScope.of(context).unfocus();
      });
    }
  }

  /* Decrease Time */
  void resendTimer(Timer timer){
    if( time == 0) timer.cancel();
    else {
      setState(() {
        time -= 1;
      });
    }
  }

  void focusOnPassword() async {
    await Future.delayed(Duration(milliseconds: 100), (){
      FocusScope.of(context).requestFocus(widget._modelSignUp.nodeSmsCode);
    });
  }

  void checkInputAndValidate() async { /* Check Internet Before Validate And Finish Validate*/
    setState(() {widget._modelSignUp.isProgress = true;});  
    await Future.delayed(Duration(milliseconds: 100), (){
      // checkConnection(context).then((isConnect) {
      //   if ( isConnect == true ) {
      //     onSubmit(context);
      //   } else {
      //     setState(() {
      //       widget._modelSignUp.isProgress = false;
      //       noInternet(context);
      //     });
      //   }
      // }); 
    });
  }

  void onSubmit(BuildContext context) async{  /* Validator User Login After Check Internet */
    // final result = await _postRequest.resendCode(AppServices.removeZero("011725228"));
    // dialogLoading(context); /* Show Loading Process */
    // await confirmAccount(widget._modelSignUp).then((_response) async { /* Response Result */
    //   Navigator.pop(context); /* Close Loading Process */
    //   if (!_response.containsKey("error")) { /* Successfully Confirm Account */ 
    //     await dialog(context, Text("${_response['message']}"), Icon(Icons.done_outline, color: getHexaColor(blueColor),)); /* Pop Successfully To Dialog */
    //     Navigator.push(context, MaterialPageRoute(builder: (context) => UserInfo())); /* Navigate To User Information */ 
    //   } else { /* Not Successfully Or Already Confirm Account */
    //     await dialog(context, Text("${_response['error']['message']}"), Icon(Icons.warning, color: Colors.yellow)); /* Pop Error To Dialog */
    //   }
    // }).catchError((onError){
    // });
  }

  Widget build(BuildContext context){
    return Scaffold(
      body: scaffoldBGDecoration(
        child: smsCodeVerifyBody(context, time, _smsCodeModel, widget._modelSignUp, onChanged, onSubmit)
      )
    );
  }
}

