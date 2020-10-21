import 'package:wallet_apps/index.dart';

class ForgetPasswordBody extends StatelessWidget{

  final ForgetModel forgetM;
  final Function tabBarSelectChanged; 
  final Function validatePhoneNumber; 
  final Function validateEmail;
  final Function onChanged; 
  final Function onSubmit;
  final Function popScreen; 
  final Function requestCode;

  ForgetPasswordBody({
    this.forgetM,
    this.tabBarSelectChanged,
    this.validatePhoneNumber,
    this.validateEmail,
    this.onChanged,
    this.onSubmit,
    this.popScreen,
    this.requestCode
  });
  
  Widget build(BuildContext context){

    List<MyInputField> listInput = [
      MyInputField(
        labelText: "Phone",
        prefixText: "+855 ",
        textInputFormatter: [
          LengthLimitingTextInputFormatter(9),
          FilteringTextInputFormatter.digitsOnly
        ],
        inputType: TextInputType.phone,
        controller: forgetM.controlPhoneNums,
        focusNode: forgetM.nodePhoneNums,
        validateField: validatePhoneNumber,
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
        controller: forgetM.controllerEmail,
        focusNode: forgetM.nodeEmail,
        validateField: validateEmail,
        onChanged: onChanged,
        onSubmit: onSubmit
      ),
    ];

    return Column(
      children: <Widget>[

        MyAppBar(
          title: "Forgot password",
          onPressed: (){
            popScreen(context);
          },
        ),

        Expanded(
          child: SvgPicture.asset('assets/forgot_password.svg', width: 300, height: 300),
        ),

        Expanded(
          child: Column(
            children: [
              MyTabBar(
                listWidget: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    width: double.infinity,
                    child: Icon(
                      Icons.phone,
                      size: 23.0,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    alignment: Alignment.center,
                    child: Icon(Icons.email, size: 23.0),
                  )
                ],
                onTap: tabBarSelectChanged,
              ),

              SizedBox(
                height: 90,
                child: Form(
                  key: forgetM.formState,
                  child: TabBarView(
                    children: <Widget>[
                      listInput[0],
                      listInput[1],
                    ],
                  ),
                )
              ),
              
              MyFlatButton(
                textButton: "Request code",
                buttonColor: AppColors.secondary,
                fontWeight: FontWeight.bold,
                fontSize: size18,
                edgeMargin: EdgeInsets.only(top: 40, left: 66, right: 66),
                hasShadow: true,
                action: forgetM.enable1 ? requestCode : null
              ),
            ],
          ),
        )
      ],
    );
  }
}