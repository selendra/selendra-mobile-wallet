import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

class FillPinWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return FillPinState();
  }
}

class FillPinState extends State<FillPinWidget> {
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Align(alignment: Alignment.center, child: Text('Fill PIN'),),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          PinPut(
            isTextObscure: true,
            fieldsCount: 4,
            onSubmit: (String dataSubmit){
              Navigator.pop(context, dataSubmit);
            },
            onClear: (String clear){

            },
          )
        ],
      ),
    );
  }
}