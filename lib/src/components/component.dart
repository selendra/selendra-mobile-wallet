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

class MyFlatButton extends StatelessWidget{

  final String textButton;
  final String buttonColor;
  final FontWeight fontWeight;
  final double fontSize;
  final EdgeInsetsGeometry edgeMargin;
  final EdgeInsetsGeometry edgePadding;
  final bool hasShadow;
  final Function action;

  MyFlatButton({
    this.textButton, 
    this.buttonColor, 
    this.fontWeight, 
    this.fontSize, 
    this.edgeMargin, 
    this.edgePadding, 
    this.hasShadow, 
    @required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: edgePadding,
      margin: edgeMargin,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size5), 
        boxShadow: [
          if (hasShadow) BoxShadow(
            color: Colors.black54.withOpacity(0.3),
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 5.0),
          )
        ]
      ),
      child: FlatButton(
        color: hexaCodeToColor(buttonColor),
        disabledColor: Colors.grey[700],
        focusColor: hexaCodeToColor(AppColors.secondary),
        child: MyText(
          // left: 117, right: 116,
          top: 20, bottom: 20,
          text: textButton,
          color: action != null ? '#FFFFFF' : AppColors.textBtnColor,
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: 
        action == null ? null : 
        (){
          action(context);
        }
      ),
    );
  }
}

class MyText extends StatelessWidget{

  final String text; final String color; final double fontSize; final FontWeight fontWeight;
  final double top; final double right; final double bottom; final double left;
  final double width; final double height; final BoxFit fit;

  MyText({
    this.text, this.color = AppColors.textColor, this.fontSize = 18, this.fontWeight = FontWeight.normal,
    this.top = 0, this.right = 0, this.bottom = 0, this.left = 0,
    this.width, this.height, this.fit = BoxFit.contain
  });
  
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.fromLTRB(this.left, this.top, this.right, this.bottom),
      child: SizedBox(
        width: this.width,
        height: this.height,
        child: FittedBox(
          fit: this.fit,
          child: Text(
            this.text,
            style: TextStyle(
              fontWeight: this.fontWeight,
              color: Color(AppUtils.convertHexaColor(this.color)),
              fontSize: this.fontSize
            ),
            textAlign: TextAlign.center,
          ),
        )
      ),
    );
  }
}

class MyLogo extends StatelessWidget{

  final String logoPath; final String color; final double width; final double height;
  final double top; final double right; final double bottom; final double left;

  MyLogo({
    @required this.logoPath, 
    this.color = "#FFFFFF", 
    this.width, 
    this.height,
    this.top = 0, this.right = 0, this.bottom = 0, this.left = 0
  });

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(this.left, this.top, this.right, this.bottom),
      child: Image.asset(logoPath, width: 60, height: 60, color: hexaCodeToColor(this.color))
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
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 20,
          color: Color(AppUtils.convertHexaColor(AppColors.bgdColor)),
          child: this.child
        )
      )
    );
  }
}
