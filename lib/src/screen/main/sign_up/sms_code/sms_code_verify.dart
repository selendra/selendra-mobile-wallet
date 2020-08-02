import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/model/sms_code_model.dart';
import 'package:http/http.dart' as http;

class SmsCodeVerify extends StatefulWidget{

  final String password; final Map<String, dynamic> message;
  final String phoneNumber;

  SmsCodeVerify(this.phoneNumber, this.password, this.message);

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
  }

  @override
  void dispose() {
    // _smsCodeModel.nodeSmsCodeVerify.dispose();
    WidgetsBinding.instance.removeObserver(this);
    resetAllField();
    super.dispose();
  }
  
  void onChanged(String value) async {
    if (_smsCodeModel.node1.hasFocus) {
      if (_smsCodeModel.code.length > 0) _smsCodeModel.code.removeAt(0);
      _smsCodeModel.code.insert(0, value);
      // if (_smsCodeModel.code.length == 0) 
      if(_smsCodeModel.controller1.text != ""){
        FocusScope.of(context).requestFocus(_smsCodeModel.node2);
      }
    }
    else if (_smsCodeModel.node2.hasFocus) {
      
      if (_smsCodeModel.code.length > 1) _smsCodeModel.code.removeAt(1);
      _smsCodeModel.code.insert(1, value);
      if (_smsCodeModel.controller2.text != "") {
        FocusScope.of(context).requestFocus(_smsCodeModel.node3);
      }
    }
    else if (_smsCodeModel.node3.hasFocus) {
      if (_smsCodeModel.code.length > 2) _smsCodeModel.code.removeAt(2);
      _smsCodeModel.code.insert(2, value);
      if(_smsCodeModel.controller3.text != ""){
        FocusScope.of(context).requestFocus(_smsCodeModel.node4);
      }
    }
    else if (_smsCodeModel.node4.hasFocus) {
      if (_smsCodeModel.code.length > 3) _smsCodeModel.code.removeAt(3);
      _smsCodeModel.code.insert(3, value);
      if(_smsCodeModel.controller4.text != ""){
        FocusScope.of(context).requestFocus(_smsCodeModel.node5);
      }
    }
    else if (_smsCodeModel.node5.hasFocus) {
      if (_smsCodeModel.code.length > 4) _smsCodeModel.code.removeAt(4);
      _smsCodeModel.code.insert(4, value);
      if (_smsCodeModel.controller5.text != ""){
        FocusScope.of(context).requestFocus(_smsCodeModel.node6);
      }
    }
    else if (_smsCodeModel.node6.hasFocus) {
      if (_smsCodeModel.code.length > 5) _smsCodeModel.code.removeAt(5);
      _smsCodeModel.code.insert(5, value);
      await Future.delayed(Duration(milliseconds: 100), (){
        FocusScope.of(context).unfocus();
      });

      submitOtpCode();
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
    await _postRequest.resendCode(widget.phoneNumber);
    setState(() {
      _smsCodeModel.showResendBtn = false;
      time = 30;
    });
  }

  // void checkInputAndValidate() async { /* Check Internet Before Validate And Finish Validate*/
  //   setState(() {_smsCodeModel.isProgress = true;});  
  //   await Future.delayed(Duration(milliseconds: 100), (){
  //     // checkConnection(context).then((isConnect) {
  //     //   if ( isConnect == true ) {
  //     //     onSubmit(context);
  //     //   } else {
  //     //     setState(() {
  //     //       _smsCodeModel.isProgress = false;
  //     //       noInternet(context);
  //     //     });
  //     //   }
  //     // }); 
  //   });
  // }

  void onSubmit(BuildContext context) async{  /* Validator User Login After Check Internet */
    if (_smsCodeModel.enable) submitOtpCode();
  }

  void submitOtpCode() async {  
    // Navigator.pushReplacement(
    //   context, 
    //   MaterialPageRoute(builder: (context) => UserInfo("phone", widget.phoneNumber, widget.password))
    // );
    try{
      dialogLoading(context);
      print(widget.phoneNumber);
      for (int i = 0; i < _smsCodeModel.code.length; i++){
        print("Index $i ${_smsCodeModel.code[i]}");
      }
      http.Response message = await _postRequest.confirmAccount(widget.phoneNumber, _smsCodeModel);
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
            MaterialPageRoute(builder: (context) => UserInfo("phone", widget.phoneNumber, widget.password))
          );
        }
        resetAllField();
      }
      _smsCodeModel.code = [];
    } catch (e){

    }
  }

  void resetAllField(){
    _smsCodeModel.controller1.text = "";
    _smsCodeModel.controller2.text = "";
    _smsCodeModel.controller3.text = "";
    _smsCodeModel.controller4.text = "";
    _smsCodeModel.controller5.text = "";
    _smsCodeModel.controller6.text = "";
  }

  Widget build(BuildContext context){
    return Scaffold(
      body: scaffoldBGDecoration(
        child: smsCodeVerifyBody(
          context, 
          time, 
          _smsCodeModel,
          widget.message, 
          onChanged, onSubmit, 
          runTimer, resetTimer
        )
      )
    );
  }
}

