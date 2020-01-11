import 'package:flutter/material.dart';
import 'package:wallet_apps/src/model/model_signup.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';

Widget changePinBodyWidget(BuildContext _context, ModelSignUp _model,
    Function popScreen, Function onChanged, Function submitPin) {
  return Container(
    padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
    width: double.infinity,
    height: double.infinity,
    child: Column(
      children: <Widget>[
        containerAppBar(
            /* AppBar */
            _context,
            Row(
              children: <Widget>[
                iconAppBar(
                  /* Arrow Back Button */
                  Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  Alignment.centerLeft,
                  EdgeInsets.all(0),
                  popScreen,
                ),
                containerTitle("Change PIN", double.infinity, Colors.white,
                    FontWeight.bold)
              ],
            )),
        Expanded(
            /* Body Change Pin */
            child: Container(
          margin: EdgeInsets.only(left: 27.0, right: 27.0, top: 27.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                /* Old PIN */
                margin: EdgeInsets.only(bottom: 12.0),
                child: inputField(
                    _model.bloc,
                    _context,
                    "Old PIN",
                    "",
                    "changePinScreen",
                    true,
                    4,
                    TextInputType.number,
                    TextInputAction.next,
                    _model.controlOldSecureNumber,
                    _model.nodeOldSecureNumber,
                    onChanged,
                    null),
              ),
              Container(
                /* New PIN */
                margin: EdgeInsets.only(bottom: 12.0),
                child: inputField(
                    _model.bloc,
                    _context,
                    "New PIN",
                    "",
                    "changePinScreen",
                    true,
                    4,
                    TextInputType.number,
                    TextInputAction.next,
                    _model.controlSecureNumber,
                    _model.nodeSecureNumber,
                    onChanged,
                    null),
              ),
              Container(
                /* Old PIN */
                margin: EdgeInsets.only(bottom: 12.0),
                child: inputField(
                    _model.bloc,
                    _context,
                    "Confirm PIN",
                    "",
                    "changePinScreen",
                    true,
                    4,
                    TextInputType.number,
                    TextInputAction.done,
                    _model.controlConfirmSecureNumber,
                    _model.nodeConfirmSecureNumber,
                    onChanged,
                    null),
              ),
              customFlatButton(
                  _model.bloc,
                  _context,
                  "Change Now",
                  "changePinScreen",
                  blueColor,
                  FontWeight.normal,
                  size18,
                  EdgeInsets.only(top: 15.0),
                  EdgeInsets.only(top: size15, bottom: size15),
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.54), blurRadius: 5.0),
                  submitPin)
            ],
          ),
        ))
      ],
    ),
  );
}
