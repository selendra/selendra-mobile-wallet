import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:wallet_apps/src/model/model_asset.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/private_key_dialog_screen/private_key_dialog_body.dart';

class PrivateKeyDialog extends StatefulWidget{

  final Map<String, dynamic> _message;

  PrivateKeyDialog(this._message);
  @override
  State<StatefulWidget> createState() {
    return PrivateKeyState();
  }
}

class PrivateKeyState extends State<PrivateKeyDialog>{

  bool isCheck = false, isSave = false, isCopy = false, disableButton = true;
  
  @override
  void initState() {
    super.initState();
  }

  void autoAddAsset() async { /* Add Asset */
    await Future.delayed(Duration(milliseconds: 4000), () async {
    });
  }

  void userCheckBox() {
    setState(() {
      if (isCheck == false) {
        isCheck = true;
      } else {
        isCheck = false;
      }
    });
  }

  /* Clip Private Key */
  void userCopyKey() {
    setState(() {
      isCopy = true;
      Clipboard.setData(ClipboardData(text: widget._message['message']["seed"]));
    });
  }

  Widget build(BuildContext context){
    return AlertDialog(
      title: Align(alignment: Alignment.center, child: containerTitle("Private Key", 50.0, Colors.black, FontWeight.bold)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          widget._message['message'][0] == null /* Index 0 Will Be Null If It Contains Key */
          ? checkBoxContent("${widget._message['message']["seed"]}", isCheck, isCopy, userCheckBox) /* Display Private Key */
          : Text(widget._message['message']) /* Display Message When Index 0 As A String */
        ],
      ),
      actions: /* Button */
      widget._message['message'][0] == null /* Index 0 Will Be Null If It Contains Key */
      ? listButton(context, widget._message['message']['seed'],  isCopy, isCheck, userCopyKey) /* Display Many Button */
      : [
          CupertinoButton( /* Display Only Close Button */
          padding: EdgeInsets.only(top: 0, bottom: 0, left: 5.0, right: 5.0),
          child: Text('Close', style: TextStyle(fontWeight: FontWeight.bold)),
          onPressed: () {
            Navigator.pop(context, null);
          },
        )
      ]
    );
  }
}

