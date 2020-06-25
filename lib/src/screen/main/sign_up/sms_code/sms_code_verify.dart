import 'package:wallet_apps/index.dart';

class SmsCodeVerify extends StatefulWidget{

  final ModelSignUp _modelSignUp;

  SmsCodeVerify(this._modelSignUp);
  @override
  State<StatefulWidget> createState() {
    return SmsCodeVerifyState();
  }
}

class SmsCodeVerifyState extends State<SmsCodeVerify>{

  @override
  void initState() {
    super.initState();
    focusOnPassword();
  }

  @override
  void dispose() {
    // widget._modelSignUp.nodeSmsCodeVerify.dispose();
    super.dispose();
  }

  void focusOnPassword() async {
    await Future.delayed(Duration(milliseconds: 100), (){
      FocusScope.of(context).requestFocus(widget._modelSignUp.nodeSmsCode);
    });
  }

  void checkInputAndValidate() async { /* Check Internet Before Validate And Finish Validate*/
    setState(() {widget._modelSignUp.isProgress = true;});  
    await Future.delayed(Duration(milliseconds: 100), (){
      // checkConnection(context).then((isConnect) {
      //   if ( isConnect == true ) {
      //     validatorLogin(context);
      //   } else {
      //     setState(() {
      //       widget._modelSignUp.isProgress = false;
      //       noInternet(context);
      //     });
      //   }
      // }); 
    });
  }

  void validatorLogin(BuildContext context) async{  /* Validator User Login After Check Internet */
    // dialogLoading(context); /* Show Loading Process */
    // await confirmAccount(widget._modelSignUp).then((_response) async { /* Response Result */
    //   Navigator.pop(context); /* Close Loading Process */
    //   if (!_response.containsKey("error")) { /* Successfully Confirm Account */ 
    //     await dialog(context, Text("${_response['message']}"), Icon(Icons.done_outline, color: getHexaColor(blueColor),)); /* Pop Successfully To Dialog */
    //     Navigator.push(context, MaterialPageRoute(builder: (context) => UserInfo())); /* Navigate To User Information */ 
    //   } else { /* Not Successfully Or Already Confirm Account */
    //     await dialog(context, Text("${_response['error']['message']}"), Icon(Icons.warning, color: Colors.yellow)); /* Pop Error To Dialog */
    //   }
    // }).catchError((onError){
    // });
  }

  void onChanged(String valueChanged) {
  }

  Widget build(BuildContext context){
    return Scaffold(
      body: scaffoldBGDecoration(
        child: smsCodeVerifyBody(context, widget._modelSignUp, onChanged, validatorLogin)
      )
    );
  }
}

