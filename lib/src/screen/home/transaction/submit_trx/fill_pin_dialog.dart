import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

class FillPin extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return FillPinState();
  }
}

class FillPinState extends State<FillPin> {

  Widget build(BuildContext context) {
    return SafeArea(
      child: AlertDialog(
        title: Align(alignment: Alignment.center, child: Text('Fill PIN'),),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            PinPut(
              // isTextObscure: true,
              // fieldsCount: 4,
              // onSubmit: (String dataSubmit){
              //   Navigator.pop(context, dataSubmit);
              // },
              // onClear: (String clear){

              // },
            )
          ],
        ),
      ),
    );
  }
}