import 'package:Wallet_Apps/src/Graphql_Service/Mutation_Document.dart';
import 'package:Wallet_Apps/src/Provider/Reuse_Widget.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pinput/pin_put/pin_put.dart';

class SetConfirmPinWidget extends StatefulWidget{

  final String _pin;

  SetConfirmPinWidget(this._pin);
  @override
  State<StatefulWidget> createState() {
    return SetConfirmPinState();
  }
}

class SetConfirmPinState extends State<SetConfirmPinWidget> {

  String _confirmPin;
  bool disableButton = true, isProgress = false;
  Map<String, dynamic> popData;

  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(document: getWallet),
      builder: (RunMutation runMutation, QueryResult result){
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
                    child: Text("Confirm"),
                    onPressed: () {
                      /* Loading */
                      dialogLoading(context);
                      if (_confirmPin == widget._pin){
                        runMutation({
                          "pins": _confirmPin
                        });
                      } else if (_confirmPin != widget._pin){
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
      },
      update: (Cache cache, QueryResult result){
        if (result.data != null){
          Navigator.pop(context);
          popData = {
            "widget": "confirmPin",
            "compare": true,
            "confirmPin": _confirmPin,
            "_privateKey": result.data['createAccount']['message']
          };
          Navigator.pop(context, popData);
        }
      },
      onCompleted: (dynamic complete){

      },
    );
  }
}