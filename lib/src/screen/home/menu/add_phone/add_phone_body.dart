import 'package:wallet_apps/index.dart';

class AddPhoneBody extends StatelessWidget{

  final AddPhoneModel phoneM;
  final Function validatePhone;
  final Function onChanged;
  final Function onSubmit;
  final Function submitAddPhone;
  final Function popScreen;

  AddPhoneBody({
    this.phoneM,
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
                    Form(
                      key: phoneM.formKey,
                      child: MyInputField(
                        pBottom: 29,
                        labelText: "Phone",
                        prefixText: "${phoneM.countryCode} ",
                        textInputFormatter: [
                          LengthLimitingTextInputFormatter(9)
                        ],
                        inputType: TextInputType.phone,
                        inputAction: TextInputAction.done,
                        controller: phoneM.phone,
                        focusNode: phoneM.nodePhone,
                        validateField: validatePhone,
                        onChanged: onChanged,
                        onSubmit: onSubmit,
                      ),
                    ),

                    MyFlatButton(
                      textButton: "Submit",
                      buttonColor: AppColors.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: size18,
                      edgeMargin: EdgeInsets.only(left: 66, right: 66),
                      hasShadow: true,
                      action: phoneM.enable ? submitAddPhone : null 
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