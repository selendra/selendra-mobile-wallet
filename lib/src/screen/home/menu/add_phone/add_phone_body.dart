import 'package:wallet_apps/index.dart';

class AddPhoneBody extends StatelessWidget{

  final AddPhoneModel phoneModel;
  final Function validatePhone;
  final Function onChanged;
  final Function onSubmit;
  final Function submitAddPhone;
  final Function popScreen;

  AddPhoneBody({
    this.phoneModel,
    this.validatePhone,
    this.onChanged,
    this.onSubmit,
    this.submitAddPhone,
    this.popScreen,
  });
  
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        
        MyAppBar(
          title: "Add phone",
          onPressed: (){
            Navigator.pop(context);
          },
        ),

        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Expanded(
                child: SvgPicture.asset('assets/insert.svg', width: 293, height: 216),
              ),

              Expanded(
                child: Column(
                  children: [
                    MyInputField(
                      pBottom: 29,
                      labelText: "Phone ",
                      prefixText: "${phoneModel.countryCode}",
                      textInputFormatter: [
                        LengthLimitingTextInputFormatter(TextField.noMaxLength)
                      ],
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.done,
                      controller: phoneModel.phone,
                      focusNode: phoneModel.nodePhone,
                      validateField: validatePhone,
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
                      action: phoneModel.enable ? submitAddPhone : null 
                    )
                  ],
                ),
              )
            ],
          )
        )
      ],
    );
  }
}