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

  SmsCodeModel _smsCodeM = SmsCodeModel();

  int time = 30;

  @override
  void initState() {
    _smsCodeM.node1.requestFocus();
    WidgetsBinding.instance.addObserver(this);
    Timer.periodic(Duration(milliseconds: 1000), runTimer);
    super.initState();
  }

  @override
  void dispose() {
    // _smsCodeM.nodeSmsCodeVerify.dispose();
    WidgetsBinding.instance.removeObserver(this);
    resetAllField();
    super.dispose();
  }
  
  void onChanged(String value) async {
    if (_smsCodeM.node1.hasFocus) {
      if (_smsCodeM.code.length > 0) _smsCodeM.code.removeAt(0);
      _smsCodeM.code.insert(0, value);
      // if (_smsCodeM.code.length == 0) 
      if(_smsCodeM.controller1.text != ""){
        FocusScope.of(context).requestFocus(_smsCodeM.node2);
      }
    }
    else if (_smsCodeM.node2.hasFocus) {
      
      if (_smsCodeM.code.length > 1) _smsCodeM.code.removeAt(1);
      _smsCodeM.code.insert(1, value);
      if (_smsCodeM.controller2.text != "") {
        FocusScope.of(context).requestFocus(_smsCodeM.node3);
      }
    }
    else if (_smsCodeM.node3.hasFocus) {
      if (_smsCodeM.code.length > 2) _smsCodeM.code.removeAt(2);
      _smsCodeM.code.insert(2, value);
      if(_smsCodeM.controller3.text != ""){
        FocusScope.of(context).requestFocus(_smsCodeM.node4);
      }
    }
    else if (_smsCodeM.node4.hasFocus) {
      if (_smsCodeM.code.length > 3) _smsCodeM.code.removeAt(3);
      _smsCodeM.code.insert(3, value);
      if(_smsCodeM.controller4.text != ""){
        FocusScope.of(context).requestFocus(_smsCodeM.node5);
      }
    }
    else if (_smsCodeM.node5.hasFocus) {
      if (_smsCodeM.code.length > 4) _smsCodeM.code.removeAt(4);
      _smsCodeM.code.insert(4, value);
      if (_smsCodeM.controller5.text != ""){
        FocusScope.of(context).requestFocus(_smsCodeM.node6);
      }
    }
    else if (_smsCodeM.node6.hasFocus) {
      if (_smsCodeM.code.length > 5) _smsCodeM.code.removeAt(5);
      _smsCodeM.code.insert(5, value);
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
        _smsCodeM.showResendBtn = true;
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
      _smsCodeM.showResendBtn = false;
      time = 30;
    });
  }

  void onSubmit(BuildContext context) async{  /* Validator User Login After Check Internet */
    if (_smsCodeM.enable) submitOtpCode();
  }

  // Time Out Handler Method
  void timeCounter(Timer timer) async {
    print(timer.tick);
    // Assign Timer Number Counter To myNumCount Variable
    AppServices.myNumCount = timer.tick;
    // Cancel Timer When Rest Api Successfully
    if (_backend.response != null) timer.cancel();
    // Display TimeOut With SnackBar When Over 10 Second
    if (AppServices.myNumCount == 10) {
      Navigator.pop(context);
      _smsCodeM.globalKey.currentState.showSnackBar(SnackBar(content: Text('Connection timed out'),));
    }
  }

  void submitOtpCode() async {

    // Processing Time Out Handler Method
    AppServices.timerOutHandler(_backend.response, timeCounter);

    // Display Loading
    dialogLoading(context);

    try{
      
      // Convert Code List To String
      for(int i = 0; i < _smsCodeM.code.length; i++){
        _smsCodeM.verifyCode += _smsCodeM.code[i];
      }

      // Request API
      await _postRequest.confirmAccount(widget.phoneNumber, _smsCodeM).then((value) async {
        if (AppServices.myNumCount < 10) { 
          _backend.response = value;
          if (_backend.response != null) {
            // Navigator.pop(context);
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

          }
        }
      });
    } on SocketException catch (e) {
      await dialog(context, Text("${e.message}", textAlign: TextAlign.center), "Message");
    } catch (e) {
      await dialog(context, Text("${e.message}", textAlign: TextAlign.center), "Message");
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
    _smsCodeM.controller1.text = "";
    _smsCodeM.controller2.text = "";
    _smsCodeM.controller3.text = "";
    _smsCodeM.controller4.text = "";
    _smsCodeM.controller5.text = "";
    _smsCodeM.controller6.text = "";
    _smsCodeM.code = [];
    _smsCodeM.verifyCode = "";
  }

  Widget build(BuildContext context){
    return Scaffold(
      key: _smsCodeM.globalKey,
      body: BodyScaffold(
        height: MediaQuery.of(context).size.height,
        child: SmsBody(
          time: time, 
          smsCodeModel: _smsCodeM,
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

