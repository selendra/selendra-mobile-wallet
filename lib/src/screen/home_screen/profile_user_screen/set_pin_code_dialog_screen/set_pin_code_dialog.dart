import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

class SetPinDialog extends StatefulWidget{

  final String showError;

  SetPinDialog(this.showError);

  @override
  State<StatefulWidget> createState() {
    return SetPinDialogState();
  }
}

class SetPinDialogState extends State<SetPinDialog> {

  bool disableButton = true;
  String _pin;
  String _showError;

  @override
  initState() {
    if (_pin != null) { /* If PIN Not Have Data Assign To Empty */
      _showError = '';
    } else _showError = widget.showError; /* If PIN Have Data */
    super.initState();
  }

  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      title: Align(alignment: Alignment.center, child: Text("Set PIN")),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _showError == '' ? Container() : Container(
            padding: EdgeInsets.all(10.0),
            child: Text(_showError, style: TextStyle(color: Colors.red),),
          ),
          PinPut(
            isTextObscure: true,
            fieldsCount: 4,
            onSubmit: (String pins) {
              setState(() {
                disableButton = false;
                _pin = pins;
              });
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