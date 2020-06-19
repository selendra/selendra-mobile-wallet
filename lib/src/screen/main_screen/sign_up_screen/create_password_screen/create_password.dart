import 'package:wallet_apps/src/screen/main_screen/sign_up_screen/create_password_screen/create_password_body.dart';
import 'package:wallet_apps/index.dart';

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
  
  @override
  void initState() {
    AppServices.noInternetConnection(globalKey);
    super.initState();
  }

  void onChanged(String changed) {
    widget._modelSignUp.formStatePassword.currentState.validate();
  }

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

  void enableButton() { /* Validate Button */
    if (widget._modelSignUp.controlPassword.text != '' && widget._modelSignUp.controlConfirmPassword.text != '') setState(() => widget._modelSignUp.enable2 = true);
  }

  void submitSignUp(BuildContext context) async { /* Navigate To Fill User Info */
    if (widget._modelSignUp.controlConfirmPassword.text != "" &&
        widget._modelSignUp.controlPassword.text != "") { /* Password != Empty */
      if (widget._modelSignUp.controlConfirmPassword.text !=
          widget._modelSignUp.controlPassword.text) { /* If Not Match */
        setState(() {
          widget._modelSignUp.isNotMatch = true; /* Pop Not Match Text Below Confrim Password Field */
        });
      } else {
        dialogLoading(context);
        if (widget._modelSignUp.label == "email") { /* Post Register By Email */
          widget._modelSignUp.response = await widget._modelSignUp.bloc.registerMethod(
            context,
            widget._modelSignUp.controlEmails.text,
            widget._modelSignUp.controlPassword.text,
            "/registerbyemail",
            "email"
          );
          if (widget._modelSignUp.response == true) {
            widget._modelSignUp.userDataLogin = { /* Add Email Or Phone Number And Password And Pass To User Infos */ 
              "email_phone": widget._modelSignUp.controlEmails.text,
              "passwords": widget._modelSignUp.controlPassword.text,
              "label": widget._modelSignUp.label
            };
            Navigator.pop(context);
            Future.delayed(Duration(milliseconds: 100), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserInfo(widget._modelSignUp.userDataLogin)
                )
              );
            });
          } else Navigator.pop(context); /* Close Dialog Process */
        } else { /* Post Register By Phone Number */
          widget._modelSignUp.response = await widget._modelSignUp.bloc.registerMethod(
            context,
            "${widget._modelSignUp.countryCode}${widget._modelSignUp.controlPhoneNums.text}",
            widget._modelSignUp.controlConfirmPassword.text,
            "/registerbyphone",
            "phone"
          );
          if (widget._modelSignUp.response == true) { /* Change To True When your testing done */
            widget._modelSignUp.userDataLogin = { /* Add Email Or Phone Number And Password And Pass To User Infos */ 
              "email_phone": "${widget._modelSignUp.countryCode}${AppServices.removeZero(widget._modelSignUp.controlPhoneNums.text)}",
              "passwords": widget._modelSignUp.controlPassword.text,
              "label": widget._modelSignUp.label
            };
            Navigator.pop(context);
            Future.delayed(Duration(milliseconds: 100), () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserInfo(widget._modelSignUp.userDataLogin) )
              );
              // Navigator.push(context, MaterialPageRoute(builder: (context) => SmsCode(widget._modelSignUp)));
            });
          } else Navigator.pop(context); /* Close Dialog Process */
        }
      }
    }
  }

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

  void onSubmit(BuildContext context) {
    if (widget._modelSignUp.nodePassword.hasFocus) {
      FocusScope.of(context).requestFocus(widget._modelSignUp.nodeConfirmPassword);
    } else { /* Prevent Submit On Smart Keyboard */ 
      if (widget._modelSignUp.enable2 == true) submitSignUp(context);
    }
  }
  
  void popScreen() { /* Close Current Screen */
    Navigator.pop(context);
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

  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      body: scaffoldBGDecoration(
        child: createPasswordBodyWidget(
          context, 
          widget._modelSignUp, 
          validatePass1, validatePass2, onChanged,popScreen, showPassword,
          onSubmit, submitSignUp
        )
      )
    );
  }
}
