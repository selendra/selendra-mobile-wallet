import 'package:flutter/cupertino.dart';
import 'package:wallet_apps/index.dart';

Widget checkBoxContent(String _privateKey, bool isCheck, bool isCopy, Function userCheckBox) { /* Check Button Row */
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Container(
        padding: EdgeInsets.only(top: 5.0),
        child: Text(
          """Please keep your key secure. This secret key will only be showed to you once.\nSelendra will not be able to help you recover it if lost.""",
        ),
      ),
      /* User Private Key */
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
                  child: Text(_privateKey, style: TextStyle(color: hexaCodeToColor(AppColors.greenColor))),
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
          Text("Already copy")
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
      child: Text('Close', style: TextStyle(fontWeight: FontWeight.bold)),
      onPressed: isCheck == true ? () async {
        Map<String, dynamic> popData = {
          "widget": "dialogPrivateKey",
          "message": 'You saved key successfully',
          "isSuccess": true,
        };
        // Set Data To Storage
        await StorageServices.setData({"get_wallet": true}, "getWallet");
        Navigator.pop(context, popData);
      } : null,
    )
  ];
}