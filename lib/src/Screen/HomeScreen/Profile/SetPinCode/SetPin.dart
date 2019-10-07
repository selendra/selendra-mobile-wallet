import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

class SetPinWidget extends StatefulWidget{

  String showError;

  SetPinWidget(this.showError);

  @override
  State<StatefulWidget> createState() {
    return SetPinState();
  }
}

class SetPinState extends State<SetPinWidget> {

  bool disableButton = true;
  String _pin;

  Widget build(BuildContext context) {
    if (_pin != null) {
      widget.showError = '';
    }
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      title: Align(alignment: Alignment.center, child: Text("Set PIN")),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          widget.showError == '' ? Container() : Container(
            padding: EdgeInsets.all(10.0),
            child: Text(widget.showError, style: TextStyle(color: Colors.red),),
          ),
          PinPut(
            isTextObscure: true,
            fieldsCount: 4,
            onSubmit: (String pins) {
              disableButton = false;
              _pin = pins;
            },
            onClear: (clear) {
              _pin = null;
              disableButton = true;
            },
          ),
          RaisedButton(
            child: Text('Next'),
            onPressed: disableButton == true ? null : () {
              Map<String, dynamic> popData = {
                "widget": "Pin",
                "pin": _pin
              };
              Navigator.pop(context, popData);
            },
          )
        ],
      )
    );
  }
}