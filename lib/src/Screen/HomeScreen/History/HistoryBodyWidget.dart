import 'package:Wallet_Apps/src/Provider/Hexa_Color_Convert.dart';
import 'package:Wallet_Apps/src/Provider/Reuse_Widget.dart';
import 'package:flutter/material.dart';

Widget bodyWidget(
  BuildContext context,
  var history,
  GlobalKey _globalKey,
  Size _containerSize,
  double _height
) {
  return Container(
      // decoration: borderAndBorderRadius(),
      // margin: EdgeInsets.only(left: margin4, right: m argin4),
      child: Padding(
        padding: EdgeInsets.only(top: 20.0,),
        child: Column(
          children: <Widget>[
            /* Title */
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text('Transaction', style: TextStyle(color: Colors.white),),
            ),
            /* List History */
            Expanded(
              child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: history.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.all(0.0),
                  margin: EdgeInsets.only(top: margin4),
                  decoration: BoxDecoration(
                    border: Border.all(width: defaultBorderWidth, color: Color(convertHexaColor(borderColor))),
                    color: Color(convertHexaColor(highThenBackgroundColor)),
                    // ("#4F4E55")),
                    borderRadius: BorderRadius.circular(defaultBorderRadius)
                  ),
                  child: ListTile(
                    title: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text('${DateTime.parse(history[index]['trxat']).toLocal()}', style: TextStyle(color: Colors.white),),
                        ),
                        Text(history[index]['type'], style: TextStyle(color: Colors.white),)
                      ],
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: defaultBorderWidth, color: Color(convertHexaColor(borderColor))),
                              borderRadius: BorderRadius.circular(defaultBorderRadius)
                            ),
                            title: Align(
                              alignment: Alignment.center,
                              child: Text('Payment History'),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Type: ${history[index]['type']}"),
                                Text("Amount: ${history[index]['amount']}"),
                                Text("Asset: ${history[index]['asset']}"),
                                Text("From: ${history[index]['from']}"),
                                Text("To: ${history[index]['to']}"),
                                Text("Date: ${history[index]['trxat']}")
                              ],
                            ),
                          );
                        }
                      );
                    },
                  ),
                );
              },
            ),
          )
          ],
        ),
      )
    );
  // Card(
  //   margin: EdgeInsets.all(0.0),
  //   child: 
  // );
}