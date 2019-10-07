import 'package:Wallet_Apps/src/Screen/HomeScreen/Profile/DialogPrivateKey/DialogPrivateKeyBody.dart';
import 'package:flutter/material.dart';
import 'package:clipboard_manager/clipboard_manager.dart';

class DialogPrivateKeyWidget extends StatefulWidget{

  final String _privateKey;

  DialogPrivateKeyWidget(this._privateKey);
  @override
  State<StatefulWidget> createState() {
    return DialogPrivateKeyState();
  }
}

class DialogPrivateKeyState extends State<DialogPrivateKeyWidget>{

  bool isCheck = false, isSave = false, isCopy = false, disableButton = true;

  userCheckBox() {
    setState(() {
      if (isCheck == false) {
        isCheck = true;
      } else {
        isCheck = false;
      }
    });
  }

  /* Clip Private Key */
  userCopyKey() {
    setState(() {
      isCopy = true;
      ClipboardManager.copyToClipBoard(widget._privateKey);
    });
  }

  Widget build(BuildContext context){
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      title: Align(alignment: Alignment.center, child: Text("Private Key")),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          checkBoxContent(widget._privateKey, isCheck, isCopy, userCheckBox),
        ],
      ),
      actions: listButton(context, widget._privateKey,  isCopy, isCheck, userCopyKey)
    );
  }
}

