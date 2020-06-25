import 'package:wallet_apps/index.dart';

Widget changePinBody(
  BuildContext _context,
  ModelChangePin _modelChangePin,
  Function validateOldPin,
  Function validateNewPin,
  Function validateConfirmPin,
  Function onChanged,
  Function onSubmit,
  Function submitPin,
  Function popScreen
){
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
              "Change PIN", 
              double.infinity, 
              Colors.white, 
              FontWeight.normal
            )
          ],
        )
      ),
      Form( /* Body Change Pin */
        key: _modelChangePin.formStateChangePin,
        child: Expanded(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              margin: EdgeInsets.only(left: 27.0, right: 27.0, top: 27.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container( /* Old PIN */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: inputField(
                      context: _context,
                      labelText: "Old PIN", 
                      prefixText: "", 
                      widgetName: "changePinScreen",
                      obcureText: true,
                      textInputFormatter: [LengthLimitingTextInputFormatter(4)],
                      inputType: TextInputType.number,
                      controller: _modelChangePin.controllerOldPin,
                      focusNode: _modelChangePin.nodeOldPin,
                      validateField: validateOldPin,
                      onChanged: onChanged,
                      action: onSubmit
                    ),
                  ),
                  Container( /* New PIN */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: inputField(
                      context: _context,
                      labelText: "New PIN", 
                      prefixText: "", 
                      widgetName: "changePinScreen",
                      obcureText: true,
                      textInputFormatter: [LengthLimitingTextInputFormatter(4)],
                      inputType: TextInputType.number,
                      controller: _modelChangePin.controllerNewPin,
                      focusNode: _modelChangePin.nodeNewPin,
                      validateField: validateNewPin,
                      onChanged: onChanged,
                      action: onSubmit
                    ),
                  ),
                  Container( /* Old PIN */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: inputField(
                      context: _context,
                      labelText: "Confirm PIN", 
                      prefixText: "", 
                      widgetName: "changePinScreen",
                      obcureText: true,
                      textInputFormatter: [LengthLimitingTextInputFormatter(4)],
                      inputType: TextInputType.number,
                      inputAction: TextInputAction.done,
                      controller: _modelChangePin.controllerConfirmPin,
                      focusNode: _modelChangePin.nodeConfirmPin,
                      validateField: validateConfirmPin,
                      onChanged: onChanged,
                      action: onSubmit
                    ),
                  ),
                  customFlatButton(
                    _context,
                    "Change Now", "changePinScreen", AppColors.blueColor,
                    FontWeight.normal,
                    size18,
                    EdgeInsets.only(top: 15.0),
                    EdgeInsets.only(top: size15, bottom: size15),
                    BoxShadow(
                      color: Color.fromRGBO(
                        0, 0, 0, _modelChangePin.enable == false ? 0 : 0.54
                      ),
                      blurRadius: 5.0),
                    _modelChangePin.enable == false ? null : submitPin
                  )
                ],
              ),
            ),
          )
        ),
      )
    ],
  );
}
