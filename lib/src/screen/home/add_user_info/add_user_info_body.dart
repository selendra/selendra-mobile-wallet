import 'package:wallet_apps/index.dart';

Widget addUserInfobody(
  ValidateMixin _validateInstance,
  BuildContext context, 
  List<String> genderList,
  ModelUserInfo _modelUserInfo,
  Function triggerImage,
  Function resetGender, Function validatorProfileUser, Function resetImage, 
  Function textChanged, Function clickNext, Function popScreen
  ) {
  return Column(
    children: <Widget>[
      // containerAppBar( /* AppBar */
      //   context, 
      //   Row(
      //     children: <Widget>[
      //       iconAppBar( /* Arrow Back Button */
      //         Icon(Icons.arrow_back, color: Colors.white,),
      //         Alignment.centerLeft,
      //         EdgeInsets.all(0),
      //         popScreen,
      //       ),
      //       containerTitle("Add Assets", double.infinity, Colors.white, FontWeight.normal)
      //     ],
      //   )
      // ),
      Expanded(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(bottom: 12.0, left: 27.0, right: 27.0, top: 27.0),
            child: Column(
              children: <Widget>[
                Container( /* Occupation Field */
                  margin: EdgeInsets.only(bottom: 12.0),
                  child: inputField(
                    context: context,
                    labelText: "Occupation", 
                    widgetName: "addUserInfoScreen",
                    textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                    controller: _modelUserInfo.controlOccupation,
                    focusNode: _modelUserInfo.nodeOccupatioin,
                    validateField: _validateInstance.validateOccupation,
                    onChanged: null, 
                    action: null
                  ),
                ),
                Container( /* Nationality Screen */
                  margin: EdgeInsets.only(bottom: 12.0),
                  child: inputField(
                    context: context,
                    labelText: "Nationality", 
                    widgetName: "addUserInfoScreen",
                    textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                    controller: _modelUserInfo.controlNationality,
                    focusNode: _modelUserInfo.nodeNationality,
                    validateField: _validateInstance.validateNationality,
                    onChanged: null, 
                    action: null,
                    inputAction: TextInputAction.done,
                  ),
                ),
                Container( /* Country */
                  margin: EdgeInsets.only(bottom: 12.0),
                  child: fieldPicker(context, "Country", "addUserInfoScreen", Icons.search, _modelUserInfo, null),
                ),
                Container( /* Upload porfile picture */
                  margin: EdgeInsets.only(bottom: 12.0),
                  child: fieldPicker(context, "Upload profile picture", "addUserInfoScreen", Icons.camera_alt, _modelUserInfo, triggerImage),
                ),
                _modelUserInfo.file != null ? Container( /* Image Display */
                  margin: EdgeInsets.only(bottom: 12.0),
                  child: Image.file(_modelUserInfo.file),
                ) : Container(),
                customFlatButton( /* Next Button */
                  context, 
                  "Next", "addUserInfoScreen", AppColors.blueColor,
                  FontWeight.normal,
                  size18,
                  EdgeInsets.only(top: 15.0),
                  EdgeInsets.only(top: size15, bottom: size15),
                  BoxShadow(
                    color: Color.fromRGBO(0,0,0,0.54),
                    blurRadius: 5.0
                  ),
                  null
                )
              ],
            ),
          ),
        ),
      )
    ],
  );
}