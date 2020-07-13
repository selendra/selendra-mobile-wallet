import 'package:wallet_apps/index.dart';

class Component {
  static void popScreen(BuildContext context) {
    Navigator.pop(context);
  }

  static Future messagePermission({BuildContext context, String content, Function method}) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Align(
            alignment: Alignment.center,
            child: Text("Message"),
          ),
          content: Padding(
            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Text("$content", textAlign: TextAlign.center),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Setting'),
              onPressed: method,
            ),
          ],
        );
      }
    );
  }
}