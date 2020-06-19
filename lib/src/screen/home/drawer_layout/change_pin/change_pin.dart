import 'package:wallet_apps/index.dart';

class ChangePin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChangePinState();
  }
}

class ChangePinState extends State<ChangePin> {
  
  ModelChangePin _modelChangePin = ModelChangePin();

  @override
  initState(){
    AppServices.noInternetConnection(_modelChangePin.globalKey);
    super.initState();
  }

  // Validator Field

  String validateOldPin(String value) {
    if (_modelChangePin.nodeOldPin.hasFocus) {
      _modelChangePin.responseOldPin = instanceValidate.validateChangePin(value);
      if (_modelChangePin.controllerOldPin.text.isEmpty) _modelChangePin.responseOldPin += "old pin";
      validateAllFieldNotEmpty(); /* Check All Field To Enable Button */
    }
    return _modelChangePin.responseOldPin;
  }

  String validateNewPin(String value) {
    if (_modelChangePin.nodeNewPin.hasFocus) {
      _modelChangePin.responseNewPin = instanceValidate.validateChangePin(value);
      if (_modelChangePin.controllerNewPin.text.isEmpty) _modelChangePin.responseNewPin += "new pin"; 
      else if ( _modelChangePin.responseNewPin == null ) { // check New And Confirm PIN Match Or Not
        _modelChangePin.responseConfirmPin = newPinIsMatch();
      }
      else if (_modelChangePin.responseConfirmPin == "Confirm PIN does not match"){
        _modelChangePin.responseConfirmPin = null;
      }
      validateAllFieldNotEmpty(); /* Check All Field To Enable Button */
    }
    return _modelChangePin.responseNewPin;
  }

  String validateConfirmPin(String value) {
    if (_modelChangePin.nodeConfirmPin.hasFocus) {
      _modelChangePin.responseConfirmPin = instanceValidate.validateChangePin(value);
      if (_modelChangePin.controllerConfirmPin.text.isEmpty) _modelChangePin.responseConfirmPin += "confirm pin";
      else if ( _modelChangePin.responseConfirmPin == null ) { // Check New And Confirm PIN Match Or Not
        _modelChangePin.responseConfirmPin = confirmPinIsMatch();
      }
      validateAllFieldNotEmpty(); /* Check All Field To Enable Button */
    }
    return _modelChangePin.responseConfirmPin;
  }

  void validateAllFieldNotEmpty() { /* Validate To Enable Button */
    if (
      _modelChangePin.controllerOldPin.text.length == 4 &&
      _modelChangePin.controllerNewPin.text.length == 4 &&
      _modelChangePin.controllerConfirmPin.text.length == 4
    ) validateAllFieldNoError();
    else if (_modelChangePin.enable == true) enableButton(false);
  }

  void validateAllFieldNoError(){
    if (
      _modelChangePin.responseOldPin == null &&
      _modelChangePin.responseNewPin == null &&
      _modelChangePin.responseConfirmPin == null
    ) enableButton(true);
    else if (_modelChangePin.enable == true) enableButton(false);
  }

  String newPinIsMatch(){ // Execute When Confirm New Pin Field Not Empty And No Error
    if (
      _modelChangePin.controllerConfirmPin.text.length == 4
    ){
      if (_modelChangePin.controllerNewPin.text == _modelChangePin.controllerConfirmPin.text){
        enableButton(true);
        _modelChangePin.responseConfirmPin = null;
      } else {
        if (_modelChangePin.enable) enableButton(false); // Once Disable When Button Enable
        _modelChangePin.responseConfirmPin = "Confirm PIN does not match";
      } 
    }
    return _modelChangePin.responseConfirmPin;
  }

  String confirmPinIsMatch(){ // Execute When New Pin Field Not Empty And No Error
    if ( _modelChangePin.controllerNewPin.text.length == 4) {
      if (_modelChangePin.controllerNewPin.text == _modelChangePin.controllerConfirmPin.text){
        enableButton(true);
        _modelChangePin.responseConfirmPin = null;
      } else {
        if (_modelChangePin.enable) enableButton(false); // Once Disable When Button Enable
        _modelChangePin.responseConfirmPin = "Confirm PIN does not match";
      }
    }
    return _modelChangePin.responseConfirmPin;
  }

  void enableButton(bool enable){
    setState(() => _modelChangePin.enable = enable);
  }

  // On Action

  void onSubmit(BuildContext context) async {
    if (_modelChangePin.nodeOldPin.hasFocus){
      _modelChangePin.nodeOldPin.unfocus();
      FocusScope.of(context).requestFocus(_modelChangePin.nodeNewPin);
    } else if (_modelChangePin.nodeNewPin.hasFocus){
      _modelChangePin.nodeNewPin.unfocus();
      FocusScope.of(context).requestFocus(_modelChangePin.nodeConfirmPin);
    } else if (_modelChangePin.enable == true) submitPIN(context);
  }

  void onChanged(String changed) {
    _modelChangePin.formStateChangePin.currentState.validate();
  }

  void submitPIN(BuildContext context) async { /* Submit Pin */
    removeAllFocus();
    dialogLoading(context); /* Show Loading Process */
    await changePIN(_modelChangePin).then((_response) async {
      Navigator.pop(context); /* Close Loading Process */
      if (!_response.containsKey("error")) { /* Check Response Not Error */
        await dialog(
          context, 
          Text("${_response['message']}"), 
          Icon(Icons.done_outline, color: getHexaColor(AppColors.greenColor),)
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
  }

  void removeAllFocus(){
    _modelChangePin.nodeOldPin.unfocus();
    _modelChangePin.nodeNewPin.unfocus();
    _modelChangePin.nodeConfirmPin.unfocus();
  }

  void popScreen() { /* Close Screen */
    Navigator.pop(context);
  }

  void dispose() {
    removeAllFocus();
    _modelChangePin.controllerOldPin.clear();
    _modelChangePin.controllerNewPin.clear();
    _modelChangePin.controllerConfirmPin.clear();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _modelChangePin.globalKey,
      body: scaffoldBGDecoration(
        child: changePinBody(
          context,
          _modelChangePin,
          validateOldPin, validateNewPin, validateConfirmPin,
          onChanged, onSubmit,
          submitPIN, popScreen
        ),
      )
    );
  }
}
