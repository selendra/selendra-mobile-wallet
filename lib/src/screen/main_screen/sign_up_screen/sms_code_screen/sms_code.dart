import 'package:flutter/material.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:wallet_apps/src/model/model_signup.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/main_screen/sign_up_screen/sms_code_screen/sms_code_body.dart';
import 'package:wallet_apps/src/screen/main_screen/main_reuse_widget.dart';
import 'package:wallet_apps/src/provider/internet_connection.dart';
import 'package:wallet_apps/src/screen/main_screen/sign_up_screen/user_info_screen/user_info.dart';
import 'package:wallet_apps/src/store_small_data/data_store.dart';

class SmsCode extends StatefulWidget{

  final ModelSignUp _modelSignUp;

  SmsCode(this._modelSignUp);
  @override
  State<StatefulWidget> createState() {
    return SmsCodeState();
  }
}

class SmsCodeState extends State<SmsCode>{

  @override
  void initState() {
    super.initState();
    focusOnPassword();
  }

  @override
  void dispose() {
    // widget._modelSignUp.nodeSmsCode.dispose();
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
      checkConnection(context).then((isConnect) {
        if ( isConnect == true ) {
          validatorLogin(context);
        } else {
          setState(() {
            widget._modelSignUp.isProgress = false;
            noInternet(context);
          });
        }
      }); 
    });
  }

  void validatorLogin(BuildContext context) async{  /* Validator User Login After Check Internet */
    dialogLoading(context); /* Show Loading Process */
    await confirmAccount(widget._modelSignUp).then((_response) async { /* Response Result */
      Navigator.pop(context); /* Close Loading Process */
      if (!_response.containsKey("error")) { /* Successfully Confirm Account */ 
        await dialog(context, Text("${_response['message']}"), Icon(Icons.done_outline, color: getHexaColor(blueColor),)); /* Pop Successfully To Dialog */
        Navigator.push(context, MaterialPageRoute(builder: (context) => UserInfo(widget._modelSignUp))); /* Navigate To User Information */ 
      } else { /* Not Successfully Or Already Confirm Account */
        await dialog(context, Text("${_response['error']['message']}"), Icon(Icons.warning, color: Colors.yellow)); /* Pop Error To Dialog */
      }
    }).catchError((onError){
    });
  }

  void onChanged(String valueChanged) {
  }

  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        decoration: scaffoldBGColor(color1, color2),
        child: paddingScreenWidget(
          context, 
          smsCodeBodyWidget(context, widget._modelSignUp, onChanged, validatorLogin)
        ),
      ),
    );
  }
}

