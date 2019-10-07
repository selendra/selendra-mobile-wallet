import 'package:Wallet_Apps/src/Provider/Hexa_Color_Convert.dart';
import 'package:Wallet_Apps/src/Provider/Reuse_Widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/* Check Button Row */
Widget checkBoxContent(String _privateKey, bool isCheck, bool isCopy, Function userCheckBox) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Container(
        padding: EdgeInsets.only(top: 5.0),
        child: Text(
          """Please keep your key secure. This secret key will only be showed to you once.\nZeetomic will not be able to help you recover it if lost."""
        ),
      ),
      /* User Key */
      Container(
        margin: EdgeInsets.only(top: 15.0, bottom: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Key: '),
                Expanded(
                  child: Text(_privateKey, style: TextStyle(color: Color(convertHexaColor(lightBlueSky))),),
                )
              ],
            )
          ],
        )
      ),
      /* Check Box */
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Checkbox(
            value: isCheck,
            onChanged: isCopy == false ? null : (data) {
              userCheckBox();
            }
          ),
          Text("Already saved")
        ],
      )
    ],
  );
}

/* Action Button */
List<Widget> listButton (BuildContext context, String _privateKey, bool isCopy, bool isCheck, Function userCopyKeys){
  return <Widget>[
    CupertinoButton(
      padding: EdgeInsets.only(top: 0, bottom: 0, left: 5.0, right: 5.0),
      child: isCopy == false ? Text('Copy') : Text('Copied'),
      onPressed: userCopyKeys,
    ),
    // CupertinoButton(
    //   padding: EdgeInsets.only(top: 0, bottom: 0, left: 5.0, right: 5.0),
    //   child: Text('Screen shot'),
    //   onPressed: () {
    //     setState(() {
    //       isSave = true; 
    //     });
    //   },
    // ),
    /* Close Button */
    CupertinoButton(
      padding: EdgeInsets.only(top: 0, bottom: 0, left: 5.0, right: 5.0),
      child: Text('Close'),
      onPressed: isCheck == true ? () {
        Map<String, dynamic> popData = {
          "widget": "dialogPrivateKey",
          "message": 'You saved key successfully'
        };
        Navigator.pop(context, popData);
      } : null,
    )
  ];
}