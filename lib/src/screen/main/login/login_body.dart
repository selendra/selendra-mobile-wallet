import 'package:wallet_apps/index.dart';

class LoginBody extends StatelessWidget{

  final ModelLogin modelLogin;
  final Function validateInput;
  final Function validatePassword;
  final Function onChanged;
  final Function onSubmit;
  final Function tabBarSelectChanged;
  final Function showPassword;
  final Function submitLogin;

  LoginBody({
    this.modelLogin,
    this.validateInput,
    this.validatePassword,
    this.onChanged,
    this.onSubmit,
    this.tabBarSelectChanged,
    this.showPassword,
    this.submitLogin,

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
        controller: modelLogin.controlPhoneNums,
        focusNode: modelLogin.nodePhoneNums,
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
        controller: modelLogin.controlEmails,
        focusNode: modelLogin.nodeEmails,
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
        controller: modelLogin.controlPasswords,
        focusNode: modelLogin.nodePasswords,
        validateField: validatePassword,
        obcureText: modelLogin.hidePassword,
        icon: IconButton(
          icon: Icon(modelLogin.hidePassword == true ? Icons.visibility_off : Icons.visibility, color: hexaCodeToColor(AppColors.textColor)),
          onPressed: showPassword,
        ),
        onChanged: onChanged,
        onSubmit: onSubmit,
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
                text: "Login",
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
            text: "Please sign in to Continue",
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
          key: modelLogin.formState,
          child: Column(
            children: [
              SizedBox(
                height: 100.0,
                child: 
                TabBarView(
                  children: [
                    listInput[0],
                    listInput[1]
                  ],
                ),
              ),
              listInput[2]
            ],
          ),
        ),

        MyFlatButton(
          textButton: "Login",
          buttonColor: AppColors.secondary,
          fontWeight: FontWeight.bold,
          fontSize: size18,
          edgeMargin: EdgeInsets.only(top: 40, left: 66, right: 66, bottom: 16),
          hasShadow: true,
          action: modelLogin.enable == false ? null : submitLogin 
        ),

        InkWell(
          onTap: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => ForgetPassword())
            );
          },
          child: MyText(
            top: 23,
            text: "Forgot password?",
            color: AppColors.secondary_text,
          )
        ),

        Expanded(
          child: Container(
            constraints: BoxConstraints(
              minHeight: 150,
              maxHeight: 150
            ),
          ),
        ),

        Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyText(
                text: "Don't have an account?"
              ),
              InkWell(
                onTap: (){
                  Navigator.pushReplacement(
                    context, 
                    MaterialPageRoute(builder: (context) => SignUp())
                  );
                },
                child: MyText(
                  left: 5,
                  text: "Sign up",
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