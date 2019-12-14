import 'package:flutter/material.dart';
import 'package:wallet_apps/src/model/model_change_pin.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';

Widget changePinBodyWidget(
  BuildContext context, 
  ModelChangePin _modelChangePin, 
  Function popScreen, Function onChanged, Function submitPin
) {
  return Container(
    padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
    width: double.infinity, height: double.infinity,
    child: Column(
      children: <Widget>[
        containerAppBar( /* AppBar */
          context, 
          Row(
            children: <Widget>[
              iconAppBar( /* Arrow Back Button */
                Icon(Icons.arrow_back, color: Colors.white,),
                Alignment.centerLeft,
                EdgeInsets.all(0),
                popScreen,
              ),
              containerTitleAppBar("Change PIN")
            ],
          )
        ),
        Expanded( /* Body Change Pin */
          child: Container(
            margin: EdgeInsets.only(left: 27.0, right: 27.0, top: 27.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container( /* Old PIN */
                  margin: EdgeInsets.only(bottom: 12.0),
                  child:inputField(
                    _modelChangePin.bloc, 
                    context, 
                    "Old PIN", null, "changePinScreen", 
                    true, 
                    TextInputType.number, 
                    _modelChangePin.controllerOldPin, 
                    _modelChangePin.nodeOldPin, 
                    onChanged, 
                    null
                  ),
                ),
                Container( /* New PIN */
                  margin: EdgeInsets.only(bottom: 12.0),
                  child: inputField(
                    _modelChangePin.bloc, 
                    context, 
                    "New PIN", null, "changePinScreen", 
                    true, 
                    TextInputType.number, 
                    _modelChangePin.controllerOldPin, 
                    _modelChangePin.nodeOldPin, 
                    onChanged, 
                    null
                  ),
                ),
                Container( /* Old PIN */
                  margin: EdgeInsets.only(bottom: 12.0),
                  child: inputField(
                    _modelChangePin.bloc, 
                    context, 
                    "Confirm PIN", null, "changePinScreen", 
                    true, 
                    TextInputType.number, 
                    _modelChangePin.controllerOldPin, 
                    _modelChangePin.nodeOldPin, 
                    onChanged, 
                    null
                  ),
                ),
                blueButton(
                  _modelChangePin.bloc, 
                  context, 
                  "Change Now", "changePinScreen", blueColor,
                  FontWeight.normal, 
                  size18,
                  EdgeInsets.only(top: 15.0),
                  EdgeInsets.only(top: size15, bottom: size15),
                  BoxShadow(
                    color: Color.fromRGBO(0,0,0,0.54),
                    blurRadius: 5.0
                  ),
                  submitPin
                )
              ],
            ),
          )
        )
      ],
    ),
  );
}