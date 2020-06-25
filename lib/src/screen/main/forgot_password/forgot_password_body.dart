import 'package:wallet_apps/index.dart';

Widget forgetPasswordBody(
  BuildContext _context, 
  ModelForgotPassword _modelForgotPassword,
  Function tabBarSelectChanged, Function validatePhoneNumber, Function validateEmail,
  Function onChanged, Function onSubmit,
  Function popScreen, Function requestCode
) {
  return Container(
    child: Column(
      children: <Widget>[
        containerAppBar( /* AppBar */
          _context, 
          Row(
            children: <Widget>[
              iconAppBar( /* Arrow Back Button */
                Icon(Icons.arrow_back, color: Colors.white,),
                Alignment.centerLeft,
                EdgeInsets.all(0),
                popScreen,
              ),
              containerTitle("Forgot Password", double.infinity, Colors.white, FontWeight.normal)
            ],
          )
        ),
        Container(
          padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0),
          child: Column(
            children: <Widget>[
              Container( /* User Choice Log in */
                child: TabBar(
                  unselectedLabelColor: getHexaColor("#FFFFFF"),
                  indicatorColor: getHexaColor(AppColors.blueColor),
                  labelColor: getHexaColor(AppColors.blueColor),
                  // labelStyle: TextStyle(fontSize: 30.0),
                  tabs: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      width: double.infinity,
                      child: Icon(
                        OMIcons.phone,
                        size: 23.0,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      alignment: Alignment.center,
                      child: Icon(OMIcons.email, size: 23.0),
                    )
                  ],
                  onTap: tabBarSelectChanged,
                ),
              ),
              SizedBox( /* Body login */
                height: 120.0,
                child: Form(
                  key: _modelForgotPassword.formState,
                  child: TabBarView(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                        margin: EdgeInsets.only(bottom: 10),
                        child: inputField(
                          context: _context, 
                          labelText: "Phone number", 
                          prefixText: "${_modelForgotPassword.countryCode} ", 
                          widgetName: "forgotPasswordScreen",
                          textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                          inputType: TextInputType.number, 
                          inputAction: TextInputAction.done,
                          controller: _modelForgotPassword.controlPhoneNums, 
                          focusNode: _modelForgotPassword.nodePhoneNums, 
                          validateField: validatePhoneNumber, 
                          onChanged: onChanged, 
                          action: onSubmit,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: inputField(
                          context: _context, 
                          labelText: "Email",
                          widgetName: "forgotPasswordScreen",
                          textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                          inputType: TextInputType.emailAddress, 
                          inputAction: TextInputAction.done,
                          controller: _modelForgotPassword.controllerEmail, 
                          focusNode: _modelForgotPassword.nodeEmail, 
                          validateField: validateEmail, 
                          onChanged: onChanged, 
                          action: onSubmit
                        ),
                      ),
                    ],
                  )
                )
              ),
              customFlatButton(
                _context, 
                "Request Code", "forgotsScreen", AppColors.greenColor,                    
                FontWeight.normal,
                size18,
                EdgeInsets.only(top: 15.0),
                EdgeInsets.only(top: size15, bottom: size15),
                BoxShadow(
                  color: Color.fromRGBO(0,0,0,0.54),
                  blurRadius: 5.0
                ),
                _modelForgotPassword.enable1 ? requestCode : null
              )
            ],
          ),
        )
        // Expanded(
        //   child: Container(
        //     margin: EdgeInsets.only(left: 24.0, right: 24.0,top: 59.0),
        //     child: Column(
        //       children: <Widget>[
        //         Container( /* Phone number field */
        //           margin: EdgeInsets.only(bottom: 12.0),
        //           child: inputField(
        //             context: _context, 
        //             labelText: "Phone number", 
        //             prefixText: "${_modelForgotPassword.countryCode} ", 
        //             widgetName: "forgotsScreen",
        //             textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
        //             inputType: TextInputType.number, 
        //             inputAction: TextInputAction.done,
        //             controller: _modelForgotPassword.controlPhoneNums, 
        //             focusNode: _modelForgotPassword.nodePhoneNums, 
        //             validateField: instanceValidate.validatePhone, 
        //             onChanged: onChanged, 
        //             action: null
        //           ),
        //         ),
        //         customFlatButton(
        //           _context, 
        //           "Request Code", "forgotsScreen", greenColor,                    
        //           FontWeight.normal,
        //           size18,
        //           EdgeInsets.only(top: 15.0),
        //           EdgeInsets.only(top: size15, bottom: size15),
        //           BoxShadow(
        //             color: Color.fromRGBO(0,0,0,0.54),
        //             blurRadius: 5.0
        //           ),
        //           requestCode
        //         )
        //       ],
        //     )
        //   ),
        // ),
      ],
    ),
  );
}