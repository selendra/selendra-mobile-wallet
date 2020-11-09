import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/screen/home/menu/add_phone/verify_code/verify_code.dart';

class AddPhone extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AddPhoneState();
  }
}

class _AddPhoneState extends State<AddPhone>{

  AddPhoneModel _phoneM = AddPhoneModel();

  PostRequest _postRequest = PostRequest();

  Backend _backend = Backend();

  void popScreen(){
    Navigator.pop(context);
  }

  String validatePhone(String value){
    if (_phoneM.nodePhone.hasFocus) {
      /* If Phone Number Field Has Focus */
      _phoneM.validateResponse = instanceValidate.validatePhone(value);
      if (_phoneM.validateResponse == null)
        enableButton(true);
      else if (_phoneM.enable == true)
        enableButton(false);
    }
    return _phoneM.validateResponse;
  }

  void enableButton(bool enable){
    print(_phoneM.enable);
    setState(() {
      _phoneM.enable = enable;
    });
  }

  void onChanged(String value){
    _phoneM.formKey.currentState.validate();
  }

  void onSubmit(){
    submitAddPhone();
  }

  void submitAddPhone() async {

    dialogLoading(context);

    try{
      _backend.response = await _postRequest.addPhone(AppServices.removeZero(_phoneM.phone.text ));

      // Close Dialog
      Navigator.pop(context);

      _backend.mapData = json.decode(_backend.response.body);

      print(_backend.mapData);
      // Convert String To Obj From Add Phone
      if(_backend.response.statusCode == 200 && !_backend.mapData.containsKey('error')){
        await Future.delayed(Duration(milliseconds: 100), () async {
          // Go To SmsCode And Wait To Get Data Back
          _backend.mapData = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyCode(_phoneM.phone.text, _backend.mapData)
            )
          );
          Navigator.pop(context, _backend.mapData);
        });
      } 
      // Add Phone Number Error
      else {
        // Something went wrong on our end
        await dialog(context, Text(_backend.mapData['error']['message']), Text("Message"));
      }
    } on SocketException catch (e) {
      await dialog(context, Text("${e.message}"), Text("Message")); 
      snackBar(_phoneM.globalKey, e.message.toString());
    } catch (e) {
      await dialog(context, Text(e.message.toString()), Text("Message")); 
    }
  }

  Widget build(BuildContext context){
    return Scaffold(
      key: _phoneM.globalKey,
      body: BodyScaffold(
        height: MediaQuery.of(context).size.height,
        child: AddPhoneBody(
          phoneM: _phoneM, 
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