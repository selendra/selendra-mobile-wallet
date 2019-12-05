import 'package:flutter/material.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';

Widget cardToken(
  String title, 
  String tokenAmount, 
  String rateColor , String greenColor,
  String rate, IconData rateIcon,
  double paddingeBottom6,
){
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        width: size1, 
        color: getHexaColor(borderColor)
      ),
      borderRadius: BorderRadius.circular(size5)
    ),
    child: Padding(
      padding: EdgeInsets.all(19.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: paddingeBottom6),
            child: Text("Most Active Token"),
          ),
          Container(
            margin: EdgeInsets.only(bottom: paddingeBottom6),
            child: Row(
              children: <Widget>[
                Container(
                  height: 38.0,
                  alignment: Alignment.center,
                  child: textDisplay( /* Token number */
                    tokenAmount,
                    TextStyle(
                      color: getHexaColor(lightBlueSky),
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0
                    ) 
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: paddingeBottom6, left: paddingeBottom6),
                  child: Text(
                    "Token",
                    style: TextStyle(color: getHexaColor(greenColor)),
                  ),
                )
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Icon(
                rateIcon,
                color: getHexaColor(rateColor),
                size: 17.0,
              ),
              Text(
                rate,
                style: TextStyle(color: getHexaColor(rateColor)),
              )
            ],
          )
        ],
      ),
    ),
  );
}

Widget textPortfolio(String text, String hexaColor){
  return Container(
    margin: EdgeInsets.only(top: 5.0),
    child: Text(text, style: TextStyle(color: getHexaColor(hexaColor)),),
  );
}