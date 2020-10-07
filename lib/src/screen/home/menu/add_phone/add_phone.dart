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
    if (_phoneModel.nodePhone.hasFocus) {
      /* If Phone Number Field Has Focus */
      _phoneModel.validateResponse = instanceValidate.validatePhone(value);
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
    _phoneModel.formKey.currentState.validate();
  }

  void onSubmit(){
    submitAddPhone(context);
  }

  void submitAddPhone(BuildContext context) async {
    try{
      // Post Add Phone
      _backend.response = await _postRequest.addPhone(_phoneModel.phone.text);
      _backend.mapData = json.decode(_backend.response.body);
      // Convert String To Obj From Add Phone
      if(_backend.response.statusCode == 200 && !_backend.mapData.containsKey('error')){
        await Future.delayed(Duration(milliseconds: 100), () async {
          // Go To SmsCode And Wait To Get Data Back
          _backend.mapData = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SmsCodeVerify(_phoneModel.phone.text, null, _backend.mapData)
            )
          );
          Navigator.pop(context, _backend.mapData);
        });
      } 
      // Add Phone Number Error
      else {
        await dialog(context, Text(_backend.mapData['error']['message']), Text("Message"));
      }
    } catch (e){
      
    }
  }

  Widget build(BuildContext context){
    return Scaffold(
      body: BodyScaffold(
        height: MediaQuery.of(context).size.height,
        child: AddPhoneBody(
          phoneModel: _phoneModel, 
          validatePhone: validatePhone,
          onChanged: onChanged,
          onSubmit: onSubmit,
          submitAddPhone: submitAddPhone,
          popScreen: popScreen
        )
      ),
    );
  }
}