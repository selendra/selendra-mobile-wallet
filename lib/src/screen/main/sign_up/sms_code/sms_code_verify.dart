import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/model/sms_code_model.dart';
import 'package:http/http.dart' as http;

class SmsCodeVerify extends StatefulWidget{

  final ModelSignUp _modelSignUp; final Map<String, dynamic> message;

  SmsCodeVerify(this._modelSignUp, this.message);

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
    Timer.periodic(Duration(milliseconds: 1000), runTimer);
    super.initState();
    focusOnPassword();
  }

  @override
  void dispose() {
    // widget._modelSignUp.nodeSmsCodeVerify.dispose();
    WidgetsBinding.instance.removeObserver(this);
    resetAllField();
    super.dispose();
  }
  
  void onChanged(String value) async {
    widget._modelSignUp.code += value;
    if (_smsCodeModel.node1.hasFocus && _smsCodeModel.controller1.text != "") FocusScope.of(context).requestFocus(_smsCodeModel.node2);
    else if (_smsCodeModel.node2.hasFocus && _smsCodeModel.controller2.text != "") FocusScope.of(context).requestFocus(_smsCodeModel.node3);
    else if (_smsCodeModel.node3.hasFocus && _smsCodeModel.controller3.text != "") FocusScope.of(context).requestFocus(_smsCodeModel.node4);
    else if (_smsCodeModel.node4.hasFocus && _smsCodeModel.controller4.text != "") FocusScope.of(context).requestFocus(_smsCodeModel.node5);
    else if (_smsCodeModel.node5.hasFocus && _smsCodeModel.controller5.text != "") FocusScope.of(context).requestFocus(_smsCodeModel.node6);
    else if (_smsCodeModel.node6.hasFocus) {
      await Future.delayed(Duration(milliseconds: 100), (){
        FocusScope.of(context).unfocus();
      });

      sumbitOtpCode();
    }
  }

  /* Decrease Time */
  void runTimer(Timer timer){
    if (mounted){
      if(time == 0) {
        timer.cancel();
        setState(() {
          print("Reset");
        _smsCodeModel.showResendBtn = true;
        });
      }
      else {
        setState(() {
          time -= 1;
        });
      }
    } else if (!mounted){
      timer.cancel();
    }
  }

  void resetTimer() async {
    await _postRequest.resendCode(widget._modelSignUp.controlPhoneNums.text);
    setState(() {
      _smsCodeModel.showResendBtn = false;
      time = 30;
    });
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
    // Map<String, dynamic> response = await _postRequest.resendCode();
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

  void sumbitOtpCode() async {   
    dialogLoading(context);
    http.Response message = await _postRequest.confirmAccount(widget._modelSignUp);
    // Decode Data From String to Object
    Map<String, dynamic> decode = json.decode(message.body);
    if (message.statusCode == 200){
      Navigator.pop(context);
      // Set Timer
      setState(() {
        time = 0;
      });
      if(decode.containsKey('error')){
        await dialog(context, Text("${decode['error']['message']}", textAlign: TextAlign.center), Text("Message"));
      } else {
        await dialog(context, Text("${decode['message']}", textAlign: TextAlign.center), Text("Message"));
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => UserInfo(widget._modelSignUp))
        );
      }
      resetAllField();
    }
  }

  void resetAllField(){
    setState((){
      _smsCodeModel.controller1.text = "";
      _smsCodeModel.controller2.text = "";
      _smsCodeModel.controller3.text = "";
      _smsCodeModel.controller4.text = "";
      _smsCodeModel.controller5.text = "";
      _smsCodeModel.controller6.text = "";
    });
  }

  Widget build(BuildContext context){
    return Scaffold(
      body: scaffoldBGDecoration(
        child: smsCodeVerifyBody(
          context, 
          time, _smsCodeModel,
          widget._modelSignUp, 
          widget.message, 
          onChanged, onSubmit, 
          runTimer, resetTimer
        )
      )
    );
  }
}

