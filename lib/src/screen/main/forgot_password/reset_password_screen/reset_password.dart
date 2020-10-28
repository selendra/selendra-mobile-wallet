import 'package:wallet_apps/index.dart';

class ResetPassword extends StatefulWidget{

  final ForgetModel _modelForgotPassword;

  ResetPassword(this._modelForgotPassword);

  @override
  State<StatefulWidget> createState() {
    return ResetPasswordState();
  }
}

class ResetPasswordState extends State<ResetPassword> {

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  PostRequest _postRequest = PostRequest();

  Backend _backend = Backend();

  @override
  void initState() {
    widget._modelForgotPassword.responseEmail = null;
    widget._modelForgotPassword.responsePhoneNumber = null;
    super.initState();
  }

  void popScreen() {
    Navigator.pop(context);
  }

  void initRequestFocuse() async {
    await Future.delayed(Duration(milliseconds: 300),(){
      FocusScope.of(context).requestFocus(widget._modelForgotPassword.nodePasswords);
    });
  }

  String validateEmail(String value){
    if (widget._modelForgotPassword.nodeEmail.hasFocus){
      widget._modelForgotPassword.responseEmail = instanceValidate.validateEmails(value);
      validateAllFieldNotEmpty();
    }
    return widget._modelForgotPassword.responseEmail;
  }
  String validatePhoneNumber(String value){
    if (widget._modelForgotPassword.nodePhoneNums.hasFocus){
      widget._modelForgotPassword.responsePhoneNumber = instanceValidate.validatePhone(value);
      validateAllFieldNotEmpty();
    }
    return widget._modelForgotPassword.responsePhoneNumber;
  }

  String validateNewPassword(String value){
    if (widget._modelForgotPassword.nodePasswords.hasFocus){
      widget._modelForgotPassword.responseNewPassword = instanceValidate.validatePassword(value);
      if ( widget._modelForgotPassword.responseNewPassword == null ) {
        if (widget._modelForgotPassword.controlConfirmPasswords.text.length >= 5){ // If Confirm Complete Fill 
          widget._modelForgotPassword.responseConfirmPassword = isMatchNewAndConfirm();
        }
      } else if (widget._modelForgotPassword.responseConfirmPassword == "Confirm password does not match"){
        widget._modelForgotPassword.responseConfirmPassword = null;
      }
      validateAllFieldNotEmpty();
    }
    return widget._modelForgotPassword.responseNewPassword;
  }

  String validateConfirmPassword(String value){
    if (widget._modelForgotPassword.nodeConfirmPasswords.hasFocus){
      widget._modelForgotPassword.responseConfirmPassword = instanceValidate.validatePassword(value);
      if ( widget._modelForgotPassword.responseConfirmPassword == null
        ) {
        if (widget._modelForgotPassword.controlNewPasswords.text.length >= 5){ // If New Complete Fill
          isMatchNewAndConfirm();
        }
      }
      validateAllFieldNotEmpty();
    }
    return widget._modelForgotPassword.responseConfirmPassword;
  }

  String isMatchNewAndConfirm(){
    if (widget._modelForgotPassword.controlNewPasswords.text == widget._modelForgotPassword.controlConfirmPasswords.text){
      enableButton(true);
      widget._modelForgotPassword.responseConfirmPassword = null;
    }
    else {
      enableButton(false);
      widget._modelForgotPassword.responseConfirmPassword = "Confirm password does not match";
    }
    return widget._modelForgotPassword.responseConfirmPassword;
  }

  String validateResetCode(String value){
    if (widget._modelForgotPassword.nodeResetCode.hasFocus){
      widget._modelForgotPassword.responseResetCode = instanceValidate.validateResetCode(value);
      validateAllFieldNotEmpty();
    }
    return widget._modelForgotPassword.responseResetCode;
  }

  void validateAllFieldNotEmpty(){
    if ( // Check User Request By Phone Number
      widget._modelForgotPassword.key == "phone"
    ) {
      if (
        widget._modelForgotPassword.controlPhoneNums.text.length >= 8 &&
        widget._modelForgotPassword.controlNewPasswords.text.length >= 5 &&
        widget._modelForgotPassword.controlConfirmPasswords.text.length >= 5 &&
        widget._modelForgotPassword.controlResetCode.text.length == 6
      ) validateAllFieldNoError();
      else if (widget._modelForgotPassword.enable2 == true) enableButton(false);

    } else if ( widget._modelForgotPassword.key == "email" ) { // Check User Request By Email
      if (
        widget._modelForgotPassword.controllerEmail.text != "" &&
        widget._modelForgotPassword.controlNewPasswords.text.length >= 5 &&
        widget._modelForgotPassword.controlConfirmPasswords.text.length >= 5 &&
        widget._modelForgotPassword.controlResetCode.text.length == 6
      ) { 
        validateAllFieldNoError();
      } else if (widget._modelForgotPassword.enable2 == true) enableButton(false);
    }
  }

  void validateAllFieldNoError(){
    if ( // Check User Request By Phone Number
      widget._modelForgotPassword.key == "phone"
    ) {
      if (
        widget._modelForgotPassword.responsePhoneNumber == null &&
        widget._modelForgotPassword.responseNewPassword == null &&
        widget._modelForgotPassword.responseConfirmPassword == null &&
        widget._modelForgotPassword.responseResetCode == null
      ) enableButton(true);
      else if (widget._modelForgotPassword.enable2 == true) enableButton(false);

    } 
    else if ( widget._modelForgotPassword.key == "email" ) { // Check User Request By Email
      if (
        widget._modelForgotPassword.responseEmail == null &&
        widget._modelForgotPassword.responseNewPassword == null &&
        widget._modelForgotPassword.responseConfirmPassword == null &&
        widget._modelForgotPassword.responseResetCode == null
      ) enableButton(true);
      else if (widget._modelForgotPassword.enable2 == true) enableButton(false);
    }
  }

  void onChanged(String changed){
    widget._modelForgotPassword.formStateResetPass.currentState.validate();
  }

  void onSubmit(BuildContext context) { // User Keyboard To Go To The Next Field
    if ( // Check User Request By Phone Number
      widget._modelForgotPassword.key == "phone"
    ) {
      if (widget._modelForgotPassword.nodePhoneNums.hasFocus) FocusScope.of(context).requestFocus(widget._modelForgotPassword.nodePasswords);
      else if (widget._modelForgotPassword.nodePasswords.hasFocus) FocusScope.of(context).requestFocus(widget._modelForgotPassword.nodeConfirmPasswords);
      else if (widget._modelForgotPassword.nodeConfirmPasswords.hasFocus) FocusScope.of(context).requestFocus(widget._modelForgotPassword.nodeResetCode);
      else {
        if (widget._modelForgotPassword.enable2) { // If Button Enable To Request
          submit();
        }
      }
    } else if ( widget._modelForgotPassword.key == "email" ) { // Check User Request By Email
      if (widget._modelForgotPassword.nodeEmail.hasFocus) FocusScope.of(context).requestFocus(widget._modelForgotPassword.nodePasswords);
      else if (widget._modelForgotPassword.nodePasswords.hasFocus) FocusScope.of(context).requestFocus(widget._modelForgotPassword.nodeConfirmPasswords);
      else if (widget._modelForgotPassword.nodeConfirmPasswords.hasFocus) FocusScope.of(context).requestFocus(widget._modelForgotPassword.nodeResetCode);
      else {
        if (widget._modelForgotPassword.enable2) { // If Button Enable To Request
          submit();
        }
      }
    }
  }

  void enableButton(bool enable){
    setState(() {
      widget._modelForgotPassword.enable2 = enable;
    });
  }

  void timeCounter(Timer timer) async {
    // Assign Timer Number Counter To myNumCount Variable
    AppServices.myNumCount = timer.tick;
    // Cancel Timer When Rest Api Successfully
    if (_backend.response != null) timer.cancel();
    // Display TimeOut With SnackBar When Over 10 Second
    if (AppServices.myNumCount == 10) {
      Navigator.pop(context);
      _globalKey.currentState.showSnackBar(SnackBar(content: Text('Connection timed out'),));
    }
  }

  void submit() async {

    // Display Dialog Loading
    dialogLoading(context);

    // Rest Api
    try{
      await _postRequest.resetPass(
        widget._modelForgotPassword, 
        widget._modelForgotPassword.key == "phone" 
        ? "+855${widget._modelForgotPassword.controlPhoneNums.text}"
        : widget._modelForgotPassword.controllerEmail.text,
        widget._modelForgotPassword.key == "phone" ? "reset-password" : "reset-password-by-email"
        ).then((value) async {
        // Close Dialog
        Navigator.pop(context);

        // Condition True When Successfully 
        if (AppServices.myNumCount < 10) {
          // Assign Promise Data To Response Variable
          _backend.response = value;
          if (_backend.response != null) {
            // Navigator.pop(context);
            _backend.mapData = json.decode(_backend.response.body);
            // Condition And Navigator
            if (!_backend.mapData.containsKey('error')) {
              await dialog(context, Text(_backend.mapData['message']), Icon(Icons.done_outline, color: hexaCodeToColor(AppColors.greenColor)));
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login()), ModalRoute.withName('/'));
            } else {
              await dialog(context, Text(_backend.mapData['error']['message']), textMessage());
            }
          }
        }
      });
    } on SocketException catch (e) {
      await dialog(context, Text("${e.message}"), Text("Message"));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: BodyScaffold(
        height: MediaQuery.of(context).size.height,
        child: ResetPasswordBody(
          forgetM: widget._modelForgotPassword, 
          validatePhoneNumber: validatePhoneNumber, 
          validateEmail: validateEmail, 
          validateNewPassword: validateNewPassword, 
          validateConfirmPassword: validateConfirmPassword, 
          validateResetCode: validateResetCode,
          onChanged: onChanged, 
          onSubmit: onSubmit,
          submitResetPassword: submit, 
          popScreen: popScreen
        )
      ),
    );
  }
}