import 'package:wallet_apps/index.dart';

class ChangePin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChangePinState();
  }
}

class ChangePinState extends State<ChangePin> {
  
  ModelChangePin _changePinM = ModelChangePin();

  PostRequest _postRequest = PostRequest();

  @override
  initState(){
    AppServices.noInternetConnection(_changePinM.globalKey);
    super.initState();
  }

  @override
  void dispose() {
    removeAllFocus();
    _changePinM.controllerOldPin.clear();
    _changePinM.controllerNewPin.clear();
    _changePinM.controllerConfirmPin.clear();
    super.dispose();
  }

  // Validator Field

  String validateOldPin(String value) {
    if (_changePinM.nodeOldPin.hasFocus) {
      _changePinM.responseOldPin = instanceValidate.validateChangePin(value);
      if (_changePinM.controllerOldPin.text.isEmpty) _changePinM.responseOldPin += "old pin";
      validateAllFieldNotEmpty(); /* Check All Field To Enable Button */
    }
    return _changePinM.responseOldPin;
  }

  String validateNewPin(String value) {
    if (_changePinM.nodeNewPin.hasFocus) {
      _changePinM.responseNewPin = instanceValidate.validateChangePin(value);
      if (_changePinM.controllerNewPin.text.isEmpty) _changePinM.responseNewPin += "new pin"; 
      else if ( _changePinM.responseNewPin == null ) { // check New And Confirm PIN Match Or Not
        _changePinM.responseConfirmPin = newPinIsMatch();
      }
      else if (_changePinM.responseConfirmPin == "Confirm PIN does not match"){
        _changePinM.responseConfirmPin = null;
      }
      validateAllFieldNotEmpty(); /* Check All Field To Enable Button */
    }
    return _changePinM.responseNewPin;
  }

  String validateConfirmPin(String value) {
    if (_changePinM.nodeConfirmPin.hasFocus) {
      _changePinM.responseConfirmPin = instanceValidate.validateChangePin(value);
      if (_changePinM.controllerConfirmPin.text.isEmpty) _changePinM.responseConfirmPin += "confirm pin";
      else if ( _changePinM.responseConfirmPin == null ) { // Check New And Confirm PIN Match Or Not
        _changePinM.responseConfirmPin = confirmPinIsMatch();
      }
      validateAllFieldNotEmpty(); /* Check All Field To Enable Button */
    }
    return _changePinM.responseConfirmPin;
  }

  void validateAllFieldNotEmpty() { /* Validate To Enable Button */
    if (
      _changePinM.controllerOldPin.text.length == 4 &&
      _changePinM.controllerNewPin.text.length == 4 &&
      _changePinM.controllerConfirmPin.text.length == 4
    ) validateAllFieldNoError();
    else if (_changePinM.enable == true) enableButton(false);
  }

  void validateAllFieldNoError(){
    if (
      _changePinM.responseOldPin == null &&
      _changePinM.responseNewPin == null &&
      _changePinM.responseConfirmPin == null
    ) enableButton(true);
    else if (_changePinM.enable == true) enableButton(false);
  }

  String newPinIsMatch(){ // Execute When Confirm New Pin Field Not Empty And No Error
    if (
      _changePinM.controllerConfirmPin.text.length == 4
    ){
      if (_changePinM.controllerNewPin.text == _changePinM.controllerConfirmPin.text){
        enableButton(true);
        _changePinM.responseConfirmPin = null;
      } else {
        if (_changePinM.enable) enableButton(false); // Once Disable When Button Enable
        _changePinM.responseConfirmPin = "Confirm PIN does not match";
      } 
    }
    return _changePinM.responseConfirmPin;
  }

  String confirmPinIsMatch(){ // Execute When New Pin Field Not Empty And No Error
    if ( _changePinM.controllerNewPin.text.length == 4) {
      if (_changePinM.controllerNewPin.text == _changePinM.controllerConfirmPin.text){
        enableButton(true);
        _changePinM.responseConfirmPin = null;
      } else {
        if (_changePinM.enable) enableButton(false); // Once Disable When Button Enable
        _changePinM.responseConfirmPin = "Confirm PIN does not match";
      }
    }
    return _changePinM.responseConfirmPin;
  }

  void enableButton(bool enable){
    setState(() => _changePinM.enable = enable);
  }

  // On Action

  void onSubmit(BuildContext context) async {
    if (_changePinM.nodeOldPin.hasFocus){
      _changePinM.nodeOldPin.unfocus();
      FocusScope.of(context).requestFocus(_changePinM.nodeNewPin);
    } else if (_changePinM.nodeNewPin.hasFocus){
      _changePinM.nodeNewPin.unfocus();
      FocusScope.of(context).requestFocus(_changePinM.nodeConfirmPin);
    } else if (_changePinM.enable == true) submitPIN();
  }

  void onChanged(String changed) {
    _changePinM.formStateChangePin.currentState.validate();
  }

  void submitPIN() async { /* Submit Pin */
    removeAllFocus();
    dialogLoading(context); /* Show Loading Process */
    try {
      await _postRequest.changePIN(_changePinM).then((_response) async {
        Navigator.pop(context); /* Close Loading Process */
        if (!_response.containsKey("error")) { /* Check Response Not Error */
          await dialog(
            context, 
            Text("${_response['message']}"), 
            Icon(Icons.done_outline, color: hexaCodeToColor(AppColors.greenColor),)
          );
          Navigator.pop(context);
        } else {
          await dialog(
            context, 
            Text("${_response['error']['message']}"),
            warningTitleDialog()
          );
        }
      });
    } on SocketException catch (e) {
      await dialog(context, Text("${e.message}"), Text("Message")); 
      snackBar(_changePinM.globalKey, e.message.toString());
    } catch (e) {
      await dialog(context, Text(e.message.toString()), Text("Message")); 
    }
  }

  void removeAllFocus(){
    _changePinM.nodeOldPin.unfocus();
    _changePinM.nodeNewPin.unfocus();
    _changePinM.nodeConfirmPin.unfocus();
  }

  void popScreen() { /* Close Screen */
    Navigator.pop(context);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _changePinM.globalKey,
      body: BodyScaffold(
        height: MediaQuery.of(context).size.height,
        child: ChangePinBody(
          modelChangePin: _changePinM,
          validateOldPin: validateOldPin, 
          validateNewPin: validateNewPin, 
          validateConfirmPin: validateConfirmPin,
          onChanged: onChanged, 
          onSubmit: onSubmit,
          submitPin: submitPIN, 
          popScreen: popScreen
        ),
      )
    );
  }
}
