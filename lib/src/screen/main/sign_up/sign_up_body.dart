import 'package:wallet_apps/index.dart';

class SignUpBody extends StatelessWidget{

  final ModelSignUp modelSignUp;
  final Function validateInput;
  final Function validatePassword;
  final Function validateCfPassword;
  final Function onChanged;
  final Function tabBarSelectChanged;
  final Function showPassword;
  final Function onSubmit;
  final Function submit;

  SignUpBody({
    this.modelSignUp,
    this.validateInput,
    this.validatePassword,
    this.validateCfPassword,
    this.onChanged,
    this.tabBarSelectChanged,
    this.showPassword,
    this.onSubmit,
    this.submit
  });
  
  Widget build(BuildContext context) {

    // Initialize Text Input
    List<MyInputField> listInput = [

      MyInputField(
        labelText: "Phone",
        prefixText: "+855 ",
        textInputFormatter: [
          LengthLimitingTextInputFormatter(9),
          FilteringTextInputFormatter.digitsOnly
        ],
        inputType: TextInputType.phone,
        controller: modelSignUp.controlPhoneNums,
        focusNode: modelSignUp.nodePhoneNums,
        validateField: validateInput,
        onChanged: onChanged,
        onSubmit: onSubmit
      ),

      MyInputField(
        labelText: "Email",
        prefixText: null,
        textInputFormatter: [
          LengthLimitingTextInputFormatter(TextField.noMaxLength)
        ],
        inputType: TextInputType.emailAddress,
        controller: modelSignUp.controlEmails,
        focusNode: modelSignUp.nodeEmails,
        validateField: validateInput,
        onChanged: onChanged,
        onSubmit: onSubmit
      ),

      MyInputField(
        labelText: "Password",
        prefixText: null,
        textInputFormatter: [
          LengthLimitingTextInputFormatter(TextField.noMaxLength)
        ],
        inputType: TextInputType.text,
        controller: modelSignUp.controlPassword,
        focusNode: modelSignUp.nodePassword,
        validateField: validatePassword,
        obcureText: modelSignUp.hidePassword1,
        icon: IconButton(
          icon: Icon(modelSignUp.hidePassword1 == true ? Icons.visibility_off : Icons.visibility, color: hexaCodeToColor(AppColors.textColor)),
          onPressed: showPassword,
        ),
        onChanged: onChanged,
        onSubmit: onSubmit,
      ),

      MyInputField(
        labelText: "Confirm Password",
        prefixText: null,
        textInputFormatter: [
          LengthLimitingTextInputFormatter(TextField.noMaxLength)
        ],
        inputType: TextInputType.text,
        controller: modelSignUp.controlConfirmPassword,
        focusNode: modelSignUp.nodeConfirmPassword,
        validateField: validateCfPassword,
        obcureText: modelSignUp.hidePassword2,
        icon: IconButton(
          icon: Icon(modelSignUp.hidePassword2 == true ? Icons.visibility_off : Icons.visibility, color: hexaCodeToColor(AppColors.textColor)),
          onPressed: showPassword,
        ),
        onChanged: onChanged,
        onSubmit: submit,
      )
    ];
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        
        Container(
          margin: EdgeInsets.only(top: 93),
          child: Row(
            children: [
              MyLogo(
                left: 46.0, 
                logoPath: AppConfig.logoName,
              ),
              MyText(
                left: 16.0,
                text: "Sign up",
                color: '#FFFFFF',
                fontSize: 40,
              )
            ],
          ) 
        ),

        Align(
          alignment: Alignment.centerLeft,
          child: MyText(
            bottom: 49, top: 16,
            left: 46.0,
            text: "Please sign up to Continue",
          ),
        ),

        /* User Log In Choice */
        Align(
          alignment: Alignment.centerRight,
          child: Container( 
            margin: EdgeInsets.only(bottom: 16.0, right: 16.0),
            decoration: BoxDecoration(
              color: hexaCodeToColor(AppColors.cardColor),
              borderRadius: BorderRadius.circular(8)
            ),
            width: 125.0,
            height: 48,
            child: TabBar(
              unselectedLabelColor: hexaCodeToColor(AppColors.textColor),
              indicatorColor: hexaCodeToColor(AppColors.secondary_text),
              labelColor: hexaCodeToColor(AppColors.secondary_text),
              // labelStyle: TextStyle(fontSize: 30.0),
              tabs: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                  width: double.infinity,
                  child: Icon(LineAwesomeIcons.phone, size: 23.0,),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  alignment: Alignment.center,
                  child: Icon(LineAwesomeIcons.envelope, size: 23.0),
                )
              ],
              onTap: tabBarSelectChanged,
            ),
          )
        ),

        /* Email & Phone Number Input Field*/
        Form(
          key: modelSignUp.formState,
          child: Column(
            children: [
              SizedBox(
                height: 100.0,
                child: TabBarView(
                  children: [
                    listInput[0],
                    listInput[1]
                  ],
                ),
              ),
              SizedBox(
                height: 100.0,
                child: listInput[2]
              ),
              SizedBox(
                height: 100.0,
                child: listInput[3]
              )
            ],
          ),
        ),

        MyFlatButton(
          textButton: "Sign up",
          buttonColor: AppColors.secondary,
          fontWeight: FontWeight.bold,
          fontSize: size18,
          edgeMargin: EdgeInsets.only(top: 29, left: 66, right: 66),
          hasShadow: true,
          action: modelSignUp.enable == false ? null : submit 
        ),

        Container(
          constraints: BoxConstraints(
            minHeight: 150,
          ),
        ),

        Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyText(
                text: "Have an account?"
              ),
              
              InkWell(
                onTap: (){
                  Navigator.pushReplacement(
                    context, 
                    MaterialPageRoute(builder: (context) => Login())
                  );
                },
                child: MyText(
                  left: 5,
                  text: "Login",
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary_text,
                ),
              )
            ],
          )
        ),
        
      ],
    );
  }
}
