import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      Clipboard.setData(ClipboardData(text: widget._message["seed"]));
    });
  }

  Widget build(BuildContext context){
    return AlertDialog(
      title: Align(alignment: Alignment.center, child: containerTitle("Private Key", 50.0, Colors.black, FontWeight.bold)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          !widget._message.containsKey("message") /* If Response Not Have Key Message */
          ? checkBoxContent(widget._message["seed"], isCheck, isCopy, userCheckBox) /* Display Private Key */
          : Text(widget._message['message']) /* Display Message */
        ],
      ),
      actions: /* Button */
      !widget._message.containsKey("message") /* If Response Not Have Key Message */
      ? listButton(context, widget._message["seed"],  isCopy, isCheck, userCopyKey) /* Display Many Button */
      : [
          CupertinoButton( /* Display Only Close Button */
          padding: EdgeInsets.only(top: 0, bottom: 0, left: 5.0, right: 5.0),
          child: Text('Close'),
          onPressed: () {
            Navigator.pop(context, null);
          },
        )
      ]
    );
  }
  //   AlertDialog(
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      // title: Align(alignment: Alignment.center, child: containerTitleAppBar("Private Key")),
  //     content: Container(
  //       width: 50.0,
  //       height: 50.0,
  //       child: Text("Hello"),
  //     )
  //     // Column(
  //     //   mainAxisSize: MainAxisSize.min,
  //     //   children: <Widget>[
  //     //     Text("Helllo world")
  //     //     // checkBoxContent(widget._message, isCheck, isCopy, userCheckBox),
  //     //   ],
  //     // ),
  //     // actions: listButton(context, widget._message,  isCopy, isCheck, userCopyKey)
  //   );
  // }
}

