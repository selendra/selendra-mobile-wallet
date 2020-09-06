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

class CustomText extends StatelessWidget{

  final String text; final String color; final double fontSize; final FontWeight fontWeight;
  final double top; final double right; final double bottom; final double left;

  CustomText({
    this.text, this.color = AppColors.textColor, this.fontSize = 18, this.fontWeight = FontWeight.normal,
    this.top = 0, this.right = 0, this.bottom = 0, this.left = 0
  });
  
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.fromLTRB(this.left, this.top, this.right, this.bottom),
      child: Text(
        this.text,
        style: TextStyle(
          fontWeight: this.fontWeight,
          color: Color(AppUtils.convertHexaColor(this.color)),
          fontSize: this.fontSize
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class BodyScaffold extends StatelessWidget{

  final Widget child;

  BodyScaffold({
    this.child,
    Widget floatingActionButton,
    FloatingActionButtonLocation floatingActionButtonLocation,
    FloatingActionButtonAnimator floatingActionButtonAnimator
  });
  
  Widget build(BuildContext context){
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Color(AppUtils.convertHexaColor(AppColors.bgdColor)),
              child: this.child
            )
          ],
        )
      )
    );
  }
}
