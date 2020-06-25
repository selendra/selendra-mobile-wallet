import 'package:flutter/cupertino.dart';
import 'package:wallet_apps/index.dart';

class SignUpFirst extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SignUpFirstState();
  }
}

class SignUpFirstState extends State<SignUpFirst> with SingleTickerProviderStateMixin{

  ModelSignUp _modelSignUp = ModelSignUp();

  @override
  void initState() {
    AppServices.noInternetConnection(_modelSignUp.globalKey);
    super.initState();
    _modelSignUp.tabController = new TabController(length: 2, vsync: this); /* Initialize Variable TabController */
  }

  void popScreen() { /* Pop Current Screen */
    Navigator.pop(context);
  }

  void navigatePage(BuildContext context) { /* Navigate To Second Sign Up */
    if (_modelSignUp.enable1 == true) /* Prevent Submit On Smart Keyboard */ 
      Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePassword(_modelSignUp)));
  }

  void onChanged(String label, String onchanged) { /* Input Field Value Change */
    _modelSignUp.formStateEmailPhone.currentState.validate();
    if (label == "Email") _modelSignUp.label = "email";
    else _modelSignUp.label = "phone";
  }

  String validateInput(String value){ /* Initial Validate */
    if (_modelSignUp.label == "email"){
      _modelSignUp.response = instanceValidate.validateEmails(value);
      setState(() {
        if (_modelSignUp.response == null) _modelSignUp.enable1 = true; 
        else _modelSignUp.enable1 = false;
      });
    } else {
      _modelSignUp.response = instanceValidate.validatePhone(value);
      setState(() {
        if (_modelSignUp.response == null) _modelSignUp.enable1 = true; 
        else _modelSignUp.enable1 = false;
      });
    }
    return _modelSignUp.response;
  }

  void tabBarSelectChanged(int index) {
    if ( index == 1 ){
      _modelSignUp.controlPhoneNums.clear();
      _modelSignUp.nodePhoneNums.unfocus();
      setState(() { /* Disable Button */
        _modelSignUp.enable1 = false;
      });
      _modelSignUp.label = "email";
    } else {
      _modelSignUp.controlEmails.clear();
      _modelSignUp.nodeEmails.unfocus();
      setState(() { /* Disable Button */
        _modelSignUp.enable1 = false;
      });
      _modelSignUp.label = "phone";
    }
    setState(() {});
  }
  
  Widget build(BuildContext context) { /* User Sign Up Build Widget */
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        key: _modelSignUp.globalKey,
        body: paddingScreenWidget( /* Padding Whole Screen */
          context, 
          signUpFirstBody( /* Body Widget */
            context, 
            _modelSignUp, 
            validateInput, onChanged, popScreen, navigatePage, tabBarSelectChanged, 
          )
        )
      ),
    );
  }

}

