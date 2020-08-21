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

class CustomFlatButton extends StatelessWidget{
  final String textButton;
  final String widgetName;
  final String buttonColor;
  final FontWeight fontWeight;
  final double fontSize;
  final EdgeInsetsGeometry edgeMargin;
  final EdgeInsetsGeometry edgePadding;
  final BoxShadow boxShadow;
  final Function action;

  CustomFlatButton({this.textButton, this.widgetName, this.buttonColor, this.fontWeight, this.fontSize, this.edgeMargin, this.edgePadding, this.boxShadow, this.action});

  Widget build(BuildContext context) {
    return  Container(
      margin: edgeMargin,
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(size5), boxShadow: [boxShadow]),
      child: FlatButton(
        color: getHexaColor(buttonColor),
        disabledTextColor: Colors.black54,
        disabledColor: Colors.grey[700],
        focusColor: getHexaColor("#83B6BD"),
        textColor: Colors.white,
        child: Text(
          textButton,
          style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(size5)),
        onPressed: action == null ? null : (){
          action(context);
        }
      ),
    );
  }
}