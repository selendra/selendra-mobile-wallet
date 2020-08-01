import 'package:wallet_apps/index.dart';

class AddPhone extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AddPhoneState();
  }
}

class _AddPhoneState extends State<AddPhone>{

  AddPhoneModel _phoneModel = AddPhoneModel();

  PostRequest _postRequest = PostRequest();

  Backend _backend = Backend();

  void popScreen(){
    Navigator.pop(context);
  }

  String validatePhone(String value){
    print(value);
    if (_phoneModel.phoneNode.hasFocus) {
      /* If Phone Number Field Has Focus */
      _phoneModel.validateResponse = instanceValidate.validatePhone(value);
      if (_phoneModel.validateResponse == null)
        enableButton(true);
      else if (_phoneModel.enable == true)
        enableButton(false);
      print(_phoneModel.validateResponse);
      print(_phoneModel.enable);
    }
    return _phoneModel.validateResponse;
  }

  void enableButton(bool enable){
    setState(() {
      _phoneModel.enable = enable;
    });
  }

  void onChanged(String value){
    print(value);
    _phoneModel.formKey.currentState.validate();
  }

  void onSubmit(){
    submitAddPhone(context);
  }

  void submitAddPhone(BuildContext context) async {
    try{
      await _postRequest.resendCode(_phoneModel.phone.text).then((value) {
        _backend.decode = json.decode(value.body);
        if(value.statusCode == 200){
          // Close Loading
          Navigator.pop(context); 
          Future.delayed(Duration(milliseconds: 100), () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SmsCodeVerify(_phoneModel.phone.text, null, _backend.decode)
                // SmsCodeVerify(widget._modelSignUp, json.decode(value.body))
              )
            );
          });
        }
      });
    } catch (e){
      
    }
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