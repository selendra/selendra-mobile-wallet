import 'package:wallet_apps/index.dart';

class ChangePasswordBody extends StatelessWidget{

  final ModelChangePassword model;
  final Function validateOldPass; 
  final Function validateNewPass; 
  final Function validateConfirmPass;
  final Function onSubmitted; 
  final Function onChanged; 
  final Function submitPassword; 
  final Function popScreen;

  ChangePasswordBody({
    this.model,
    this.validateOldPass,
    this.validateNewPass,
    this.validateConfirmPass,
    this.onSubmitted,
    this.onChanged,
    this.submitPassword,
    this.popScreen,
  });
  
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        
        MyAppBar(
          title: "Change password",
          onPressed: (){
            Navigator.pop(context);
          },
        ),

        Form( /* Body Change Password */
          key: model.formStateChangePassword,
          child: Expanded( 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: SvgPicture.asset('assets/password.svg', width: 450, height: 316)
                ),

                MyInputField(
                  pBottom: 16,
                  labelText: "Old password",
                  prefixText: null,
                  textInputFormatter: [
                    LengthLimitingTextInputFormatter(TextField.noMaxLength)
                  ],
                  inputType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  controller: model.controlOldPassword,
                  focusNode: model.nodeOldPassword,
                  validateField: validateOldPass,
                  onChanged: onChanged,
                  onSubmit: onSubmitted,
                ),

                MyInputField(
                  pBottom: 16,
                  labelText: "New password",
                  prefixText: null,
                  textInputFormatter: [
                    LengthLimitingTextInputFormatter(TextField.noMaxLength)
                  ],
                  inputType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  controller: model.controlNewPassword,
                  focusNode: model.nodeNewPassword,
                  validateField: validateNewPass,
                  onChanged: onChanged,
                  onSubmit: onSubmitted,
                ),
                
                MyInputField(
                  pBottom: 29,
                  labelText: "Confrim password",
                  prefixText: null,
                  textInputFormatter: [
                    LengthLimitingTextInputFormatter(TextField.noMaxLength)
                  ],
                  inputType: TextInputType.text,
                  inputAction: TextInputAction.done,
                  controller: model.controlConfirmPassword,
                  focusNode: model.nodeConfirmPassword,
                  validateField: validateConfirmPass,
                  onChanged: onChanged,
                  onSubmit: onSubmitted,
                ),

                MyFlatButton(
                  textButton: "Submit",
                  buttonColor: AppColors.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: size18,
                  edgeMargin: EdgeInsets.only(left: 66, right: 66),
                  hasShadow: true,
                  action: model.enable == false ? null : submitPassword
                )

              ],
            )
          ),
        )
      ],
    );
  }
}
