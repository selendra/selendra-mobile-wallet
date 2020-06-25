import 'package:wallet_apps/index.dart';

class ResetCode extends StatefulWidget{

  final ModelForgotPassword _modelForgotPassword;

  ResetCode(this._modelForgotPassword);

  @override
  State<StatefulWidget> createState() {
    throw ResetCodeState();
  }
}

class ResetCodeState extends State<ResetCode>{

  void onChanged(String value){
    widget._modelForgotPassword.formState.currentState.validate();
  }

  void onSubmit(BuildContext context){
    if (widget._modelForgotPassword.enable1 == true) {
      toResetPassword();
    }
  }

  void toResetPassword(){
    Navigator.push(context, transitionRoute(ResetPassword(widget._modelForgotPassword)));
  }

  String validateResetCode(String value){
    if (widget._modelForgotPassword.nodeResetCode.hasFocus){
      widget._modelForgotPassword.responseResetCode = instanceValidate.validateResetCode(value);
    }
    return widget._modelForgotPassword.responseResetCode;
  }

  void popScreen(){
    Navigator.pop(context);
  }

  Widget build(BuildContext context){
    return Scaffold(
      body: scaffoldBGDecoration(
        child: resetCodeBody(
          context, 
          widget._modelForgotPassword, 
          validateResetCode,
          onChanged, onSubmit,
          toResetPassword, 
          popScreen
        )
      ),
    );
  }
}