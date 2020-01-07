import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:wallet_apps/src/http_request/rest_api.dart';

class SetConfirmPin extends StatefulWidget{

  final String _pin;

  SetConfirmPin(this._pin);
  @override
  State<StatefulWidget> createState() {
    return SetConfirmPinState();
  }
}

class SetConfirmPinState extends State<SetConfirmPin> {

  String _confirmPin;
  bool disableButton = true, isProgress = false;
  Map<String, dynamic> popData;

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          title: Align(
            alignment: Alignment.center,
            child: Text("Confirm PIN"),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              PinPut(
                isTextObscure: true,
                fieldsCount: 4,
                onSubmit: (String pins) {
                  _confirmPin = pins;
                  disableButton = false;
                },
                onClear: (clear) {
                  _confirmPin = null;
                  disableButton = true;
                },
              ),
              RaisedButton(
                child: Text("Confirm", style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () async {
                  /* Loading */
                  dialogLoading(context);
                  if (_confirmPin == widget._pin){ /* If PIN Equal Confirm PIN */
                    popData = {
                      "widget": "confirmPin",
                      "confirm_pin": _confirmPin,
                      "compare": true
                    };
                    Map<String, dynamic> _response = await retreiveWallet(_confirmPin); /* Request Wallet */
                    _response.addAll(popData);
                    Navigator.pop(context); /* Close Cicular Loading */
                    Navigator.pop(context, _response); /* Close Dialog And Push Back Data */
                  } else if (_confirmPin != widget._pin){ /* If PIN Not Equal Confirm PIN */
                    Navigator.pop(context);
                    popData = {
                      "widget": "confirmPin",
                      "compare": false
                    };
                    Navigator.pop(context, popData);
                  }
                },
              )
            ],
          ),
        ),

        // isProgress == true ? AlertDialog(
        //   elevation: 0,
        //   backgroundColor: Colors.transparent,
        //   content: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     children: <Widget>[
        //       loading()
        //     ],
        //   )
        // ) : Container()
      ]
    );
  }
}