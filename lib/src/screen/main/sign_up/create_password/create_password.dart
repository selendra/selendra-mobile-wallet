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
    AppServices.noInternetConnection(globalKey);
    super.initState();
  }
  
  @override
  void dispose() {
    widget._modelSignUp.controlPassword.clear();
    widget._modelSignUp.controlConfirmPassword.clear();
    widget._modelSignUp.isNotMatch = false;
    widget._modelSignUp.enable2 = false;
    widget._modelSignUp.responsePass1 = null;
    widget._modelSignUp.responsePass2 = null;
    super.dispose();
  }

  void onChanged(String changed) {
    widget._modelSignUp.formStatePassword.currentState.validate();
  }

  /* Validate Field */

  String validatePass1(String value){ /* Validate User Input And Enable Or Disable Button */
    if (widget._modelSignUp.nodePassword.hasFocus){
      if (widget._modelSignUp.isNotMatch == true){
        setState(() { /* Disable Not Match Text */
          widget._modelSignUp.isNotMatch = false;
        });
      }
      widget._modelSignUp.responsePass1 = instanceValidate.validatePassword(value);
      if (widget._modelSignUp.responsePass1 == null && widget._modelSignUp.responsePass2 == null ) enableButton();
      else if (widget._modelSignUp.enable2 == true) setState(() => widget._modelSignUp.enable2 = false); /* Among Both Field Error Disable Button */
    }
    return widget._modelSignUp.responsePass1;
  }

  String validatePass2(String value) {
    if (widget._modelSignUp.nodeConfirmPassword.hasFocus){
      if (widget._modelSignUp.isNotMatch == true){
        setState(() { /* Disable Not Match Text */
          widget._modelSignUp.isNotMatch= false;
        });
      }
      widget._modelSignUp.responsePass2 = instanceValidate.validatePassword(value);
      if (widget._modelSignUp.responsePass1 == null && widget._modelSignUp.responsePass2 == null ) enableButton();
      else if (widget._modelSignUp.enable2 == true) setState(() => widget._modelSignUp.enable2 = false); /* Among Both Field Error Disable Button */
    }
    return widget._modelSignUp.responsePass2;
  }

  void validateAllField(){
    if (widget._modelSignUp.controlConfirmPassword.text != "" &&
        widget._modelSignUp.controlPassword.text != "") { /* Password != Empty */
      if (widget._modelSignUp.controlConfirmPassword.text !=
          widget._modelSignUp.controlPassword.text) { /* If Not Match */
        setState(() {
          widget._modelSignUp.isNotMatch = true; /* Pop Not Match Text Below Confrim Password Field */
        });
      }
    }
  }

  /* Validate Button */
  void enableButton() {
    if (widget._modelSignUp.controlPassword.text != '' && widget._modelSignUp.controlConfirmPassword.text != '') setState(() => widget._modelSignUp.enable2 = true);
  }

  /* Send Message After Register */
  Future<http.Response> resendOtpCode() async {
    return await _postRequest.resendCode(widget._modelSignUp.controlPhoneNums.text);
  }

  /* Show And Hide Passwords */
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

  /* Submit From Keyboard */
  void onSubmit(BuildContext context) {
    if (widget._modelSignUp.nodePassword.hasFocus) {
      FocusScope.of(context).requestFocus(widget._modelSignUp.nodeConfirmPassword);
    } else { /* Prevent Submit On Smart Keyboard */ 
      if (widget._modelSignUp.enable2 == true) submitSignUp(context);
    }
  }

  /* -------------- Submit --------------- */

  void submitSignUp(BuildContext context) async { /* Navigate To Fill User Info */
    try{
      // await resendOtpCode().then((value) {
      //   if(value.statusCode == 200){
      //     // Close Loading
      //     Navigator.pop(context); 
      //     Future.delayed(Duration(milliseconds: 100), () {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => UserInfo(widget._modelSignUp.dataSignUp)
      //           // SmsCodeVerify(widget._modelSignUp, json.decode(value.body))
      //         )
      //       );
      //     });
      //   }
      // });
      if (widget._modelSignUp.label == "email") { /* Post Register By Email */
        print("email");
        registerByEmail();
      } else { /* Post Register By Phone Number */
        print("phone");
        registerByPhoneNumber();
      }
    } catch (e){
      print(e);
    }
  }

  void registerByEmail() async {
    dialogLoading(context);
    try{
      _backend.response = await _postRequest.registerByEmail(widget._modelSignUp.controlPhoneNums.text,  widget._modelSignUp.controlConfirmPassword.text);
  
      _backend.decode = json.decode(_backend.response.body);

      /* Close Loading */
      Navigator.pop(context);

      if (_backend.response.statusCode == 200){
        if (_backend.decode['message'] == "Successfully registered!"){
          await dialog(
            context,
            textAlignCenter(text: _backend.decode['message']),
            /* Sub Title */ /* Check For Change Icon On Alert */ /* Title */
            Icon(
              Icons.done_outline,
              color: getHexaColor(AppColors.greenColor),
            ) 
          );
        } else {
          await dialog(
            context,
            textAlignCenter(text: _backend.decode['message']),
            /* Sub Title */ /* Check For Change Icon On Alert */ /* Title */
            Text("Message") 
          );
        }
      }
    } catch (e){
      await dialog(context, textAlignCenter(text: 'Something goes wrong !'), warningTitleDialog());
    }
  }

  void registerByPhoneNumber() async {
    dialogLoading(context);
    try{
      // _backend.response = await _postRequest.registerByPhone(widget._modelSignUp.controlPhoneNums.text,  widget._modelSignUp.controlConfirmPassword.text);
  
      // _backend.decode = json.decode(_backend.response.body);

      // /* Close Loading */
      // Navigator.pop(context);

      // if (_backend.response.statusCode == 200){
      //   if (_backend.decode['message'] == "Successfully registered!"){
      //     await dialog(
      //       context,
      //       textAlignCenter(text: _backend.decode['message']),
      //       /* Sub Title */ /* Check For Change Icon On Alert */ /* Title */
      //       Icon(
      //         Icons.done_outline,
      //         color: getHexaColor(AppColors.greenColor),
      //       ) 
      //     );

      //     await resendOtpCode().then((value) {
      //       if(value.statusCode == 200){
      //         // Close Loading
      //         Navigator.pop(context); 
      //         Future.delayed(Duration(milliseconds: 100), () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => SmS(widget._modelSignUp)
      //               // SmsCodeVerify(widget._modelSignUp, json.decode(value.body))
      //             )
      //           );
      //         });
      //       }
      //     });
      //   } else {
      //     await dialog(
      //       context,
      //       textAlignCenter(text: _backend.decode['message']),
      //       /* Sub Title */ /* Check For Change Icon On Alert */ /* Title */
      //       Text("Message") 
      //     );
      //   }
      // }

      await resendOtpCode().then((value) {
        _backend.decode = json.decode(value.body);
            if(value.statusCode == 200){
              // Close Loading
              Navigator.pop(context); 
              Future.delayed(Duration(milliseconds: 100), () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SmsCodeVerify(widget._modelSignUp, _backend.decode)
                    // SmsCodeVerify(widget._modelSignUp, json.decode(value.body))
                  )
                );
              });
            }
          });

    } catch (e){
      await dialog(context, textAlignCenter(text: 'Something goes wrong !'), warningTitleDialog());
    }
  }
  
  void popScreen() { /* Close Current Screen */
    Navigator.pop(context);
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
