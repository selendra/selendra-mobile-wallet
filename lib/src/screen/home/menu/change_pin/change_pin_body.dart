import 'package:wallet_apps/index.dart';

class ChangePinBody extends StatelessWidget{

  final ModelChangePin modelChangePin;
  final Function validateOldPin;
  final Function validateNewPin;
  final Function validateConfirmPin;
  final Function onChanged;
  final Function onSubmit;
  final Function submitPin;
  final Function popScreen;

  ChangePinBody({
    this.modelChangePin,
    this.validateOldPin,
    this.validateNewPin,
    this.validateConfirmPin,
    this.onChanged,
    this.onSubmit,
    this.submitPin,
    this.popScreen,
  });
  
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        
        MyAppBar(
          title: "Change pin",
          onPressed: (){
            Navigator.pop(context);
          },
        ),

        Form( /* Body Change Pin */
          key: modelChangePin.formStateChangePin,
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: SvgPicture.asset('assets/password.svg', width: 300, height: 300)
                ),

                MyInputField(
                  pBottom: 16,
                  labelText: "Old pin", 
                  prefixText: null, 
                  textInputFormatter: [
                    LengthLimitingTextInputFormatter(TextField.noMaxLength)
                  ],
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.number,
                  controller: modelChangePin.controllerOldPin,
                  focusNode: modelChangePin.nodeOldPin,
                  validateField: validateOldPin,
                  onChanged: onChanged,
                  onSubmit: onSubmit,
                ),

                MyInputField(
                  pBottom: 16,
                  labelText: "New pin",
                  prefixText: null,
                  textInputFormatter: [
                    LengthLimitingTextInputFormatter(TextField.noMaxLength)
                  ],
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.number,
                  controller: modelChangePin.controllerNewPin,
                  focusNode: modelChangePin.nodeNewPin,
                  validateField: validateNewPin,
                  onChanged: onChanged,
                  onSubmit: onSubmit,
                ),
                
                MyInputField(
                  pBottom: 29,
                  labelText: "Confrim password",
                  prefixText: null,
                  textInputFormatter: [
                    LengthLimitingTextInputFormatter(TextField.noMaxLength)
                  ],
                  inputType: TextInputType.number,
                  inputAction: TextInputAction.done,
                  controller: modelChangePin.controllerConfirmPin,
                  focusNode: modelChangePin.nodeConfirmPin,
                  validateField: validateConfirmPin,
                  onChanged: onChanged,
                  onSubmit: onSubmit,
                ),

                MyFlatButton(
                  textButton: "Submit",
                  buttonColor: AppColors.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: size18,
                  edgeMargin: EdgeInsets.only(left: 66, right: 66),
                  hasShadow: true,
                  action: modelChangePin.enable == false ? null : submitPin
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
