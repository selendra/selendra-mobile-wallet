import 'package:wallet_apps/index.dart';

class ResetPasswordBody extends StatelessWidget{
  
  final ForgetModel forgetM;
  final Function validatePhoneNumber;
  final Function validateEmail;
  final Function validateNewPassword;
  final Function validateConfirmPassword;
  final Function validateResetCode;
  final Function onChanged;
  final Function onSubmit;
  final Function submitResetPassword;
  final Function popScreen;

  ResetPasswordBody({
    this.forgetM,
    this.validatePhoneNumber,
    this.validateEmail,
    this.validateNewPassword,
    this.validateConfirmPassword,
    this.validateResetCode,
    this.onChanged,
    this.onSubmit,
    this.submitResetPassword,
    this.popScreen,
  });

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          MyAppBar(
            title: "Change password",
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          
          Expanded(/* Body */
            child: Form(
              key: forgetM.formStateResetPass,
              child: Container(
                padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 59.0),
                child: Column(
                  children: <Widget>[
                    forgetM.key == "phone" 
                    ? MyInputField(
                      pBottom: 16,
                      labelText: "Phone",
                      prefixText: "${forgetM.countryCode} ",
                      textInputFormatter: [
                        LengthLimitingTextInputFormatter(9),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      inputType: TextInputType.number,
                      inputAction: TextInputAction.next,
                      controller: forgetM.controlPhoneNums,
                      focusNode: forgetM.nodePhoneNums,
                      validateField: validatePhoneNumber, 
                      onChanged: onChanged,
                      onSubmit: onSubmit
                    )
                    /* Email field */
                    : MyInputField(
                      pBottom: 16,
                      labelText: "Email",
                      prefixText: null,
                      textInputFormatter: [
                        LengthLimitingTextInputFormatter(TextField.noMaxLength)
                      ],
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                      controller: forgetM.controllerEmail,
                      focusNode: forgetM.nodePhoneNums,
                      validateField: validateEmail, 
                      onChanged: onChanged,
                      onSubmit: onSubmit
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
                      controller: forgetM.controlNewPasswords,
                      focusNode: forgetM.nodePasswords,
                      validateField: validateNewPassword,
                      onChanged: onChanged,
                      onSubmit: onSubmit
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
                      controller: forgetM.controlConfirmPasswords,
                      focusNode: forgetM.nodeConfirmPasswords,
                      validateField: validateConfirmPassword,
                      onChanged: onChanged,
                      onSubmit: onSubmit
                    ),

                    MyInputField(
                      pBottom: 29,
                      labelText: "Submit",
                      prefixText: null,
                      textInputFormatter: [
                        LengthLimitingTextInputFormatter(6),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      inputAction: TextInputAction.next,
                      inputType: TextInputType.number,
                      controller: forgetM.controlResetCode,
                      focusNode: forgetM.nodeResetCode,
                      validateField: validateResetCode, 
                      onChanged: onChanged,
                      onSubmit: onSubmit
                    ),

                    MyFlatButton(
                      textButton: "Request code",
                      buttonColor: AppColors.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: size18,
                      edgeMargin: EdgeInsets.only(left: 66, right: 66),
                      hasShadow: true,
                      action: forgetM.enable2 == false ? null : submitResetPassword
                    )
                  ],
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
