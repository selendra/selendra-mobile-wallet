import 'package:wallet_apps/index.dart';

class AddPhone extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AddPhoneState();
  }
}

class _AddPhoneState extends State<AddPhone>{

  AddPhoneModel _phoneModel = AddPhoneModel();

  void popScreen(){
    Navigator.pop(context);
  }

  String validatePhone(String value){
    if (_phoneModel.phoneNode.hasFocus) {
        /* If Phone Number Field Has Focus */
      _phoneModel.validateResponse= instanceValidate.validatePhone(value);
      if (_phoneModel.validateResponse == null)
        enableButton(true);
      else if (_phoneModel.enable == true)
        enableButton(false);
    }
    return _phoneModel.validateResponse;
  }

  void enableButton(bool enable){
    setState(() {
      _phoneModel.enable = enable;
    });
  }

  void onChanged(String value){
  }

  void onSubmit(){
  }

  void submitAddPhone(BuildContext context){
    
  }

  Widget build(BuildContext context){
    return Scaffold(
      body: scaffoldBGDecoration(
        child: addPhoneBody(
          context, 
          _phoneModel, 
          validatePhone,
          onChanged,
          onSubmit,
          submitAddPhone,
          popScreen
        )
      ),
    );
  }
}