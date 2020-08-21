import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/screen/main/sign_up/sms_code/sms_code_verify.dart';
import 'package:http/http.dart' as http;

class CreatePassword extends StatefulWidget {

  final ModelSignUp _modelSignUp;

  CreatePassword(this._modelSignUp);

  @override
  State<StatefulWidget> createState() {
    return CreatePasswordState();
  }
}

class CreatePasswordState extends State<CreatePassword> {

  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  PostRequest _postRequest = PostRequest();

  Backend _backend = Backend();
  
  @override
  void initState() {

    // Initalize Number Counter
    AppServices.myNumCount = 0;

    AppServices.noInternetConnection(globalKey);
    super.initState();
  }
  
  @override
  void dispose() {
    widget._modelSignUp.controlPassword.clear();
    widget._modelSignUp.controlConfirmPassword.clear();
    widget._modelSignUp.isMatch = true;
    widget._modelSignUp.enable2 = false;
    widget._modelSignUp.responsePass1 = null;
    widget._modelSignUp.responsePass2 = null;
    super.dispose();
  }

  /* Close Current Screen */
  void popScreen() { 
    Navigator.pop(context);
  }

  void onChanged(String changed) {
    widget._modelSignUp.formStatePassword.currentState.validate();
  }

  /* Validate Field */

  String validatePass1(String value){ /* Validate User Input And Enable Or Disable Button */
    if (widget._modelSignUp.nodePassword.hasFocus){
      widget._modelSignUp.responsePass1 = instanceValidate.validatePassword(value);
      validateAllField();
    }
    return widget._modelSignUp.responsePass1;
  }

  String validatePass2(String value) {
    if (widget._modelSignUp.nodeConfirmPassword.hasFocus){
      widget._modelSignUp.responsePass2 = instanceValidate.validatePassword(value);
      validateAllField();
    }
    return widget._modelSignUp.responsePass2;
  }

  void validateAllField(){

    if ( widget._modelSignUp.responsePass1 == null && widget._modelSignUp.responsePass2 == null ) {

      if (widget._modelSignUp.controlConfirmPassword.text == widget._modelSignUp.controlPassword.text) { 
        // Disable Not Match Text
        if (widget._modelSignUp.isMatch == false) widget._modelSignUp.isMatch = true;
        // If Not Match
        if (widget._modelSignUp.enable2 == false) widget._modelSignUp.enable2 = true;
      } 
      else {
        if (widget._modelSignUp.controlConfirmPassword.text != '' && widget._modelSignUp.controlPassword.text != ''){
          // Disable Button
          if (widget._modelSignUp.enable2) widget._modelSignUp.enable2 = false;
          // Enable Not Match Text
          if (widget._modelSignUp.isMatch) widget._modelSignUp.isMatch = false;
        }
      }
    } else {
      // Disable Button
      if (widget._modelSignUp.enable2) widget._modelSignUp.enable2 = false;
      // Enable Not Match Text
      if (widget._modelSignUp.isMatch == false) widget._modelSignUp.isMatch = true;
    }
    setState(() {});
  }

  // Validate Button
  void enableButton() {
    if (widget._modelSignUp.controlPassword.text != '' && widget._modelSignUp.controlConfirmPassword.text != '') setState(() => widget._modelSignUp.enable2 = true);
  }

  // Send Message After Register
  Future<http.Response> resendOtpCode() async {
    return await _postRequest.resendCode(widget._modelSignUp.controlPhoneNums.text);
  }

  // Show And Hide Passwords
  void showPassword(bool showPassword){
    if (widget._modelSignUp.nodePassword.hasFocus) {
      setState(() {
        widget._modelSignUp.showPassword1 = showPassword;
      });
    } else if (widget._modelSignUp.nodeConfirmPassword.hasFocus){
      setState(() {
        widget._modelSignUp.showPassword2 = showPassword;
      });
    } 
  }

  // Submit From Keyboard
  void onSubmit(BuildContext context) {
    if (widget._modelSignUp.nodePassword.hasFocus) {
      FocusScope.of(context).requestFocus(widget._modelSignUp.nodeConfirmPassword);
    } else { /* Prevent Submit On Smart Keyboard */ 
      if (widget._modelSignUp.enable2 == true) submitSignUp(context);
    }
  }

  void timeCounter(Timer timer) async {
    // Assign Timer Number Counter To myNumCount Variable
    AppServices.myNumCount = timer.tick;
    // Cancel Timer When Rest Api Successfully
    if (_backend.response != null) timer.cancel();
    // Display TimeOut With SnackBar When Over 10 Second
    if (AppServices.myNumCount == 10) {
      Navigator.pop(context);
      globalKey.currentState.showSnackBar(SnackBar(content: Text('Connection timed out'),));
    }
    setState((){});
  }
  /* -------------- Submit --------------- */

  // Navigate To Fill User Info
  void submitSignUp(BuildContext context) async { 

    // Display Dialog Loading
    dialogLoading(context);

    // Connection timed out
    AppServices.timerOutHandler(_backend.response, timeCounter);

    await Future.delayed(Duration(seconds: 11), (){});

    try{
      // Post Register By Email
      if (widget._modelSignUp.label == "email") { 
        await registerByEmail();
      }
      // Post Register By Phone Number
      else { 
        await registerByPhoneNumber();
      }
      
    } catch (e){
      await dialog(context, textAlignCenter(text: 'Something goes wrong !'), warningTitleDialog());
    }
  }

  // Register By Email
  Future<void> registerByEmail() async {

    await _postRequest.registerByEmail(widget._modelSignUp.controlEmails.text,  widget._modelSignUp.controlConfirmPassword.text).then((value) async {
      if (AppServices.myNumCount < 10) {
        _backend.response = value;
        if (_backend.response != null) {
          // Navigator.pop(context);
          _backend.mapData = json.decode(_backend.response.body);
        }
        // Navigator Route
        await navigator();
      }
    });
  }

  // Register By Phone Number
  Future<void> registerByPhoneNumber() async {

    await _postRequest.registerByPhone(widget._modelSignUp.controlPhoneNums.text, widget._modelSignUp.controlConfirmPassword.text).then((value) async {
      if (AppServices.myNumCount < 10) {
        _backend.response = value;
        if (_backend.response != null) {
          // Navigator.pop(context);
          _backend.mapData = json.decode(_backend.response.body);
        }
        // Navigator Route
        await navigator();
      }
    });
  }

  // Navigator Route
  Future<void> navigator() async {

    // Close Loading
    Navigator.pop(context);

    if (_backend.response.statusCode == 200){
      if (_backend.mapData['message'] == "Successfully registered!"){
        await dialog(
          context,
          textAlignCenter(text: "${_backend.mapData['message']}"),
          Icon(
            Icons.done_outline,
            color: getHexaColor(AppColors.greenColor),
          ) 
        );

        await resendOtpCode().then((value) {
          _backend.mapData = json.decode(value.body);
          if(value.statusCode == 200){
            // Close Loading
            Navigator.pop(context); 
            Future.delayed(Duration(milliseconds: 100), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SmsCodeVerify(widget._modelSignUp.controlPhoneNums.text, widget._modelSignUp.controlConfirmPassword.text, _backend.mapData)
                )
              );
            });
          }
        });
      } else {
        await dialog(
          context,
          textAlignCenter(text: _backend.mapData['message']),
          Text("Message") 
        );
      }
    }

    // Remove All Focus Field After Click Button
    clearFocusInput();
  }

  Future<void> clearFocusInput() async {
    await Future.delayed(Duration(milliseconds: 100), (){
      FocusScope.of(context).unfocus();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      body: scaffoldBGDecoration(
        child: createPasswordBody(
          context, 
          widget._modelSignUp, 
          validatePass1, validatePass2, onChanged,popScreen, showPassword,
          onSubmit, submitSignUp
        )
      )
    );
  }
}
