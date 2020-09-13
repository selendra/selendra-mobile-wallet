import 'package:wallet_apps/index.dart';

class SmsCodeVerify extends StatefulWidget{
  
  final String phoneNumber;
  final String password;
  final Map<String, dynamic> message;

  SmsCodeVerify(this.phoneNumber, this.password, this.message);

  @override
  State<StatefulWidget> createState() {
    return SmsCodeVerifyState();
  }
}

class SmsCodeVerifyState extends State<SmsCodeVerify> with WidgetsBindingObserver {

  PostRequest _postRequest = PostRequest();

  Backend _backend = Backend();

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

  void onSubmit(BuildContext context) async{  /* Validator User Login After Check Internet */
    if (_smsCodeModel.enable) submitOtpCode();
  }

  void submitOtpCode() async {
    // Display Loading
    dialogLoading(context);
    try{
      // Convert Code List To String
      for(int i = 0; i < _smsCodeModel.code.length; i++){
        _smsCodeModel.verifyCode += _smsCodeModel.code[i];
      }
      // Request API
      _backend.response = await _postRequest.confirmAccount(widget.phoneNumber, _smsCodeModel);
      // Covert Data From String to Object
      _backend.mapData = json.decode(_backend.response.body);
      if (_backend.response.statusCode == 200){
        // Set Timer
        setState(() {
          time = 0;
        });
        if(_backend.mapData.containsKey('error')){
          // Close Loading
          Navigator.pop(context);
          await dialog(context, Text("${_backend.mapData['error']['message']}", textAlign: TextAlign.center), Text("Message"));
        } else {
          // Fetch Pin From Data Storage
          await StorageServices.fetchData('pin').then((value) {
            // Post Request Wallet After Verify Phone Number
            if (value != null) requestWallet(value['pin']);
            // Go To User Information Screen
            else Navigator.pushReplacement(
              context, 
              MaterialPageRoute(builder: (context) => UserInfo("phone", widget.phoneNumber, widget.password))
            );
          });
        }
      }
      resetAllField();
    } catch (e){
    }
  }

  // Post Request Wallet
  Future<void> requestWallet(String _pin) async {
    _backend.response = await _postRequest.retreiveWallet(_pin);
    _backend.mapData = json.decode(_backend.response.body);
    _backend.mapData.addAll({
      "dialog_name": "confirmPin",
      "confirm_pin": _pin,
      "compare": true,
    });
    // Close Loading
    Navigator.pop(context);

    Navigator.pop(context, _backend.mapData);
  }

  void resetAllField(){
    _smsCodeModel.controller1.text = "";
    _smsCodeModel.controller2.text = "";
    _smsCodeModel.controller3.text = "";
    _smsCodeModel.controller4.text = "";
    _smsCodeModel.controller5.text = "";
    _smsCodeModel.controller6.text = "";
    _smsCodeModel.code = [];
    _smsCodeModel.verifyCode = "";
  }

  Widget build(BuildContext context){
    return Scaffold(
      body: BodyScaffold(
        child: SmsBody(
          time: time, 
          smsCodeModel: _smsCodeModel,
          message: widget.message, 
          onChanged: onChanged, 
          onSubmit: onSubmit, 
          runTimer: runTimer, 
          resetTimer: resetTimer
        )
      )
    );
  }
}

