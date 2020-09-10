import 'package:wallet_apps/index.dart';

Widget signUpBody(
  BuildContext context,
  ModelSignUp _modelSignUp,
  Function validateInput, Function onChanged,
  Function popScreen, Function navigatePage, Function tabBarSelectChanged,
){
  return Column(
    // mainAxisAlignment: MainAxisAlignment.center,
    // crossAxisAlignment: CrossAxisAlignment.center, /* Stretch is fill cros axis */
    children: <Widget>[
      logoSize(AppConfig.logoName, 80.0, 80.0),
      Container(
        margin: EdgeInsets.only(top: 20.0),
        child: textDisplay(
          "Sign Up", 
          TextStyle(
            color: hexaCodeToColor("#FFFFFF"),
            fontSize: 30.0,
            fontWeight: FontWeight.w400
          )
        ),
      ),
      Container( /* User Choice Sign Up */
        margin: EdgeInsets.only(top: 20.0, bottom: 30.0),
        child: TabBar(
          controller: _modelSignUp.tabController,
          unselectedLabelColor: hexaCodeToColor("#FFFFFF"),
          indicatorColor: hexaCodeToColor(AppColors.greenColor),
          labelColor: hexaCodeToColor(AppColors.greenColor),
          tabs: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              width: double.infinity,
              // child: Icon(LineIcons.phone, size: 23.0,),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              alignment: Alignment.center,
              // child: Icon(LineIcons.envelope, size: 23.0,),
            )
          ],
          onTap: tabBarSelectChanged,
        ),
      ),
      Form( /* Form Control User Field */
        key: _modelSignUp.formStateEmailPhone,
        child: Container( /* User Sign Up Choice Body */
          height: 100.0,
          child: TabBarView( /* Body Sign Up */
            controller: _modelSignUp.tabController,
            children: <Widget>[
              Container( /* Sign By Phone Number Field */
                padding: EdgeInsets.only(top: 9.0),
                child: inputField(
                  context: context,
                  labelText: "Phone number", 
                  prefixText: "${_modelSignUp.countryCode} ", 
                  widgetName: "signUpFirstScreen",
                  textInputFormatter: [LengthLimitingTextInputFormatter(9), WhitelistingTextInputFormatter.digitsOnly],
                  inputType: TextInputType.phone, 
                  inputAction: TextInputAction.done,
                  controller: _modelSignUp.controlPhoneNums,
                  focusNode: _modelSignUp.nodePhoneNums,
                  validateField: validateInput, 
                  onChanged: onChanged, 
                  action: navigatePage
                )
              ),
              Container( /* Login By Email Field */
                padding: EdgeInsets.only(top: 9.0),
                child: inputField(
                  context: context,
                  labelText: "Email", 
                  widgetName: "signUpFirstScreen",
                  textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                  inputAction: TextInputAction.done,
                  controller: _modelSignUp.controlEmails,
                  focusNode: _modelSignUp.nodeEmails,
                  validateField: validateInput, 
                  onChanged: onChanged, 
                  action: navigatePage
                )
              ),
            ],
          ),
        ),
      ),
      customFlatButton( /* Button Request Code */
        context,
        "Sign up", 
        "signUpFirstScreen", AppColors.greenColor,
        FontWeight.normal,
        size18,
        EdgeInsets.only(top: size10, bottom: size10),
        EdgeInsets.only(top: size15, bottom: size15),
        BoxShadow(
          color: Colors.black54.withOpacity(_modelSignUp.enable1 == false ? 0 : 0.3), 
          blurRadius: 10.0, 
          spreadRadius: 2.0, 
          offset: Offset(2.0, 5.0),
        ),
        _modelSignUp.enable1 == false ? null : navigatePage
      ),
      toLogin(context)
    ],
  );
}