import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet_apps/src/model/model_change_pin.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/bloc/validator_mixin.dart';

Widget changePinBodyWidget(
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
  return Container(
    padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
    width: double.infinity,
    height: double.infinity,
    child: Column(
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
                FontWeight.bold
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
                        _context,
                        "Old PIN", "", "changePinScreen",
                        true,
                        [LengthLimitingTextInputFormatter(4)],
                        TextInputType.number,
                        TextInputAction.next,
                        _modelChangePin.controllerOldPin,
                        _modelChangePin.nodeOldPin,
                        validateOldPin,
                        onChanged,
                        onSubmit
                      ),
                    ),
                    Container( /* New PIN */
                      margin: EdgeInsets.only(bottom: 12.0),
                      child: inputField(
                        _context,
                        "New PIN", "", "changePinScreen",
                        true,
                        [LengthLimitingTextInputFormatter(4)],
                        TextInputType.number,
                        TextInputAction.next,
                        _modelChangePin.controllerNewPin,
                        _modelChangePin.nodeNewPin,
                        validateNewPin,
                        onChanged,
                        onSubmit
                      ),
                    ),
                    Container( /* Old PIN */
                      margin: EdgeInsets.only(bottom: 12.0),
                      child: inputField(
                        _context,
                        "Confirm PIN", "", "changePinScreen",
                        true,
                        [LengthLimitingTextInputFormatter(4)],
                        TextInputType.number,
                        TextInputAction.done,
                        _modelChangePin.controllerConfirmPin,
                        _modelChangePin.nodeConfirmPin,
                        validateConfirmPin,
                        onChanged,
                        onSubmit
                      ),
                    ),
                    customFlatButton(
                      _context,
                      "Change Now", "changePinScreen", blueColor,
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
    ),
  );
}
