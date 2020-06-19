import 'package:wallet_apps/index.dart';

Widget editProfileBodyWidget(
  BuildContext _context,
  ModelUserInfo _modelUserInfo,
  Function onSubmit,
  Function onChanged,
  Function changeGender,
  Function validateFirstName,
  Function validateMidName,
  Function validateLastName,
  Function submitProfile,
  Function popScreen,
  PopupMenuItem Function(Map<String, dynamic>) item,
) {
  return Column(
    children: <Widget>[
      containerAppBar( /* AppBar */
        _context,
        Row(
          children: <Widget>[
            iconAppBar( /* Arrow Back Button */
              Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              Alignment.centerLeft,
              EdgeInsets.all(0),
              popScreen,
            ),
            containerTitle(
              "User Information", 
              double.infinity,
              Colors.white, 
              FontWeight.normal
            )
          ],
        )
      ),
      Form(
        key: _modelUserInfo.formStateAddUserInfo,
        child: Expanded( /* Body Change Pin */
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              margin: EdgeInsets.only(left: 27.0, right: 27.0, top: 27.0),
              child: Column(
                children: <Widget>[
                  Container( /* First Name Field */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: inputField(
                      context: _context,
                      labelText: "First Name", 
                      widgetName: "userInfoScreen",
                      textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                      inputAction: TextInputAction.next,
                      controller: _modelUserInfo.controlFirstName,
                      focusNode: _modelUserInfo.nodeFirstName,
                      validateField: validateFirstName,
                      onChanged: onChanged,
                      action: onSubmit
                    ),
                  ),
                  Container( /* Mid Name Field */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: inputField(
                      context: _context,
                      labelText: "Mid Name", 
                      widgetName: "userInfoScreen",
                      textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                      controller: _modelUserInfo.controlMidName,
                      focusNode: _modelUserInfo.nodeMidName,
                      validateField: validateMidName,
                      onChanged: onChanged,
                      action: onSubmit
                    ),
                  ),
                  Container( /* Last Name Field */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: inputField(
                      context: _context,
                      labelText: "Last Name",
                      widgetName: "userInfoScreen",
                      textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                      inputAction: TextInputAction.done,
                      controller: _modelUserInfo.controlLastName,
                      focusNode: _modelUserInfo.nodeLastName,
                      validateField: validateLastName,
                      onChanged: onChanged,
                      action: onSubmit
                    ),
                  ),
                  Container( /* Gender Picker */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: customDropDown(
                      _modelUserInfo.genderLabel,
                      [
                        {"gender": "Male"},
                        {"gender": "Female"}
                      ],
                      _modelUserInfo,
                      changeGender,
                      item
                    ),
                  ),
                  customFlatButton(/* Submit Button */
                    _context,
                    "Submit",
                    "userInfoScreen",
                    AppColors.greenColor,
                    FontWeight.normal,
                    size18,
                    EdgeInsets.only(top: 15.0, bottom: size10),
                    EdgeInsets.only(top: size15, bottom: size15),
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.54),
                      blurRadius: 5.0
                    ),
                    _modelUserInfo.enable == false ? null : submitProfile
                  )
                ],
              ),
            ),
          ),
        ),
      )
    ],
  );
}
