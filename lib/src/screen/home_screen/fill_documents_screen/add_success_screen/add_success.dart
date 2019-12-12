import 'package:flutter/material.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';

class AddSuccess extends StatelessWidget{
  Widget build(BuildContext context) {
    return Scaffold(
      body: addSuccessBodyWidget(context),
    );
  } 
}

Widget addSuccessBodyWidget(BuildContext context) {

  Bloc _bloc = Bloc();

  return Container(
    padding: EdgeInsets.only(left: 43.0, right: 43.0, top: 16.0),
    width: MediaQuery.of(context).size.width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container( /* Icon Round Button */
          padding: EdgeInsets.all(20.0),
          margin: EdgeInsets.only(bottom: 12.0),
          decoration: BoxDecoration(
            color: getHexaColor(greenColor),
            borderRadius: BorderRadius.circular(60.0)
          ),
          child: Icon(Icons.done, size: 50.0, color: Colors.white,),
        ),
        Container( /* Congratulation Text */
          margin: EdgeInsets.only(bottom: 12.0),
          child: Text('Congratulation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 12.0),
          child: Text(
            "We will received your information with in 24 hours", 
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        blueButton(
          _bloc, context, "Done", "addSuccessScreen", 
          FontWeight.normal,
          size18,
          EdgeInsets.only(top: 15.0),
          EdgeInsets.only(top: size15, bottom: size15),
          BoxShadow(
            color: Color.fromRGBO(0,0,0,0.54),
            blurRadius: 5.0
          ),
          null
        )
      ],
    ),
  );
}