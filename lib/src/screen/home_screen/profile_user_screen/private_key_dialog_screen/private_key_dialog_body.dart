import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


Widget checkBoxContent(String _privateKey, bool isCheck, bool isCopy, Function userCheckBox) { /* Check Button Row */
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
      Container( /* User Key */
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
                  child: Text(_privateKey, style: TextStyle(color: getHexaColor(greenColor))),
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
      child: Text(isCopy == false ? 'Copy' : 'Copied', style: TextStyle(fontWeight: FontWeight.bold)),
      onPressed: userCopyKeys,
    ),
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