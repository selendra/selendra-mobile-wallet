import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;
import 'package:wallet_apps/index.dart';

/* -----------------------------------Variable--------------------------------------------------- */
/* Size */
const double size1 = 1.0;
const double size2 = 2.0;
const double size4 = 4.0;
const double size5 = 5.0;
const double size10 = 10.0;
const double size17 = 17.0;
const double size34 = 34.0;
const double size15 = 15.0;
const double size18 = 18.0;
const double size28 = 28.0;
const double size50 = 50.0;
const double size80 = 80.0;

/* Background Left & Right Size */
const double leftRight40 = 40.0;

/* -----------------------------------Box Border and Shadow Style--------------------------------------------------- */
Color getHexaColor(String hexaCode) {
  return Color(AppUtils.convertHexaColor(hexaCode));
}

/* Transition Animation Fade Up And Down */
Route transitionRoute(Widget child, {offsetLeft: 0.0, offsetRight: 0.25, sigmaX: 10.0, sigmaY: 10.0}) {
  return PageRouteBuilder(
    opaque: false,
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(offsetLeft, offsetRight);
      var end = Offset.zero;
      var curve = Curves.fastOutSlowIn;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: FadeTransition(
          opacity: animation,
          child: Material(
            color: Colors.white.withOpacity(0.1),
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(
                sigmaX: sigmaX,
                sigmaY: sigmaY,
              ),
              child: child,
            ),
          ),
        )
      );
    }
  );
}

/* User Input Text */
TextField userTextField(
  TextEditingController inputEditor,
  FocusNode node,
  Function sink,
  AsyncSnapshot snapshot,
  bool showInput,
  TextInputType inputType,
  TextInputAction inputAction
) {
  return TextField(
    controller: inputEditor,
    style: TextStyle(color: Colors.white),
    focusNode: node,
    obscureText: showInput,
    onChanged: sink,
    keyboardType: inputType,
    textInputAction: inputAction,
    decoration: InputDecoration(
      fillColor: Colors.black38,
      filled: true,
      contentPadding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: size10),
      labelStyle: TextStyle(color: Colors.white),
      /* Border side */
      border: errorOutline(),
      enabledBorder: outlineInput(getHexaColor(AppColors.borderColor)),
      focusedBorder: outlineInput(getHexaColor(AppColors.lightBlueSky)),
      /* Error Handler */
      focusedErrorBorder: errorOutline(),
      errorText: snapshot.hasError ? snapshot.error : null,
    ),
  );
}

/* ------------------Input Decoration--------------------- */

/* User input Outline Border */
OutlineInputBorder outlineInput(Color borderColor) {
  return OutlineInputBorder(
      borderSide: BorderSide(color: borderColor, width: size1),
      borderRadius: BorderRadius.circular(size5));
}

OutlineInputBorder errorOutline() {
  /* User Error Input Outline Border */
  return OutlineInputBorder(borderSide: BorderSide(color: Colors.red));
}

/* Button shadow */
BoxShadow shadow(Color hexaCode, double blurRadius, double spreadRadius) {
  return BoxShadow(
      color: hexaCode,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      offset: Offset(0, 0));
}

Widget customFlatButton(
  BuildContext context,
  String textButton,
  String widgetName,
  String buttonColor,
  FontWeight fontWeight,
  double fontSize,
  EdgeInsetsGeometry edgeMargin,
  EdgeInsetsGeometry edgePadding,
  BoxShadow boxShadow,
  Function action
){
  return Container(
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
      onPressed: action == null ? null : 
      (){
        action(context);
      }
    ),
  );
}

/* Border and Border Radius Chart Card */
BoxDecoration borderAndBorderRadius() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(5.0),
    border: Border.all(width: 2.0, color: getHexaColor("#5F5F69")),
  );
}

/* -----------------------------------Background Color Style--------------------------------------------------- */

/* Scaffold Background Color */
BoxDecoration scaffoldBGColor(String color1, String color2) {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [getHexaColor(color1), getHexaColor(color1)]
    )
  );
}

Widget scaffoldBGDecoration({
  double top = 16.0,
  double right: 16.0,
  bottom: 16.0,
  double left: 16.0,
  Widget child
}) {
  return Container(
    width: double.infinity,
    height: double.infinity,
    padding: EdgeInsets.only(top: top, right: right, bottom: bottom, left: left),
    decoration: scaffoldBGColor(AppColors.bgdColor, AppColors.bgdColor),
    child: SafeArea(
      child: child,
    ),
  );
}

/* Title gradient color */
final Shader linearGradient = LinearGradient(colors: [getHexaColor(AppColors.lightBlueSky), getHexaColor(AppColors.greenColor)]).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

BoxDecoration signOutColor() {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        getHexaColor("#1D0837"),
        getHexaColor("#0F0F11"),
      ]
    )
  );
}

/* -----------------------------------Dialog Result--------------------------------------------------- */

/* Dialog of response from server */
Future dialog(
  BuildContext context, 
  var text, 
  var title,
  {FlatButton action, Color bgColor}
) async {
  var result = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        title: Align(
          alignment: Alignment.center,
          child: title,
        ),
        content: Padding(
          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: text,
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Close'),
            onPressed: () => Navigator.of(context).pop(text),
          ), 
          action
        ],
      );
    }
  );
  return result;
}

Widget textMessage({String text: "Message", fontSize: 20.0}){
  return FittedBox(
    child: Text(text, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600)),
  );
}

Widget textAlignCenter({String text: ""}){
  return Text(text, textAlign: TextAlign.center);
}

/* Check for internet connection */
void noInternet(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text('No internet'),
        content: Text("You're not connect to network"),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Close'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ]
      );
    }
  );
}

blurBackgroundDecoration(BuildContext context, dynamic screen) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Material(
        color: Colors.white.withOpacity(0.1),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(
            sigmaX: 20.0,
            sigmaY: 20.0,
          ),
          child: screen,
        ),
      );
    }
  );
}

/* ----------------------------------- Bottom App Bar ----------------------------------- */

/* Loading Progress */
Widget loading() {
  return Center(
    child: CircularProgressIndicator(
      backgroundColor: Colors.transparent,
      valueColor: AlwaysStoppedAnimation(getHexaColor(AppColors.lightBlueSky))
    ),
  );
}

/* Progress */
Widget progress({String content}) {
  return Material(
    color: Colors.transparent,
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircularProgressIndicator(
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation(getHexaColor(AppColors.lightBlueSky))
            ),
            content == null 
            ? Container() 
            : Padding(
              child: textScale(
                text: content,
                hexaColor: "#FFFFFF"
              ),
              padding: EdgeInsets.only(bottom: 10.0, top: 10.0)
            ),
          ],
        )
      ],
    ),
  );
}

void dialogLoading(BuildContext context, {String content}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return progress(content: content);
    });
}

/* -----------------------------------App Bar--------------------------------------------------- */

Widget containerAppBar(BuildContext context, Widget subAppBar, {left: 16.0, right: 16.0}) {
  return Container(
    padding: EdgeInsets.only(left: left, right: right),
    height: 41.0, 
    width: MediaQuery.of(context).size.width, 
    child: FittedBox(
      alignment: Alignment.centerLeft,
      child: subAppBar
    )
  );
}

Widget iconAppBar(Widget icon, Alignment alignment,EdgeInsetsGeometry edgePadding, Function action, {BuildContext context}) {
  return IconButton(
    /* Menu Icon */
    alignment: alignment,
    padding: edgePadding,
    iconSize: 40.0,
    icon: icon,
    onPressed: action,
  );
}

Widget containerTitle( String title, dynamic _height, dynamic textColor, FontWeight _fontWeight, {double fontSize = 25.0}) {
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.only(left: 8.0),
    child: Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        color: textColor,
        fontWeight: _fontWeight,
      ),
      textAlign: TextAlign.center,
    )
  );
}

Widget logoSize(String logoName, double width, double height,) {
  return Image.asset(logoName, width: width, height: height, color: Colors.white);
}

/* -----------------------------------Text Style--------------------------------------------------- */

/* Label User Input */
Widget labelUserInput(String text, String colorHexa) {
  return Text(
    text,
    style: TextStyle(
      color: getHexaColor(colorHexa),
      fontSize: 12.0,
      fontWeight: FontWeight.bold
    ),
  );
}

Widget textDisplay(String text, TextStyle textStyle) {
  return Text(
    text,
    style: textStyle,
  );
}

/* ---------------------------------Camera and Gallery------------------------------------------------ */

/* Trigger image from gallery */
Future<File> gallery() async {
  var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  return image;
}

/* Trigger image from gallery */
Future<File> camera() async {
  var image = await ImagePicker.pickImage(
      source: ImageSource.camera, imageQuality: 100);
  return image;
}

/* QR Code Generate Function */
Widget qrCodeGenerator(String _walletCode, String logoName, GlobalKey _keyQrShare){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(bottom: 36.0),
        child: Text('Wallet',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          )
        )
      ),
      Container(
        width: 200.0,
        height: 200.0,
        child: RepaintBoundary(
          key: _keyQrShare,
          child: new QrImage(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            embeddedImage: AssetImage('${AppConfig.logoQrEmbedded}'),
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size(40, 40),
            ),
            // version: QrVersions.auto,
            data: _walletCode,
          ),
        )
      ),
    ],
  );
}

Widget textNotification(String text, BuildContext context) {
  return Align(
    alignment: Alignment.center,
    child: Text(text,
        style: TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w300)),
  );
}

/*----------------------------------------------- Field Icons trigger Widget ----------------------------------------------------- */
Widget fieldPicker(BuildContext context, String labelText, String widgetName, IconData icons, dynamic _model, dynamic method) {
  return Container(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      InkWell(
        /* Text Field*/
        child: Container(
          padding:
              EdgeInsets.only(top: 23.0, bottom: 23.0, left: 26.0, right: 26.0),
          decoration: BoxDecoration(
              color: getHexaColor("#FFFFFF").withOpacity(0.1),
              borderRadius: BorderRadius.circular(size5)),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  labelText,
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
              Icon(
                icons,
                color: Colors.white,
              )
            ],
          ),
        ),
        onTap: () {
          if (widgetName == "fillDocsScreen")
            method(labelText);
          else
            method();
        },
      )
    ],
  ));
}

Widget inputField({/* User Input Field */
  Key key,
  BuildContext context,
  String labelText,
  String prefixText,
  String widgetName,
  bool obcureText = false,
  bool enableInput = true,
  List<TextInputFormatter> textInputFormatter,
  TextInputType inputType = TextInputType.text,
  TextInputAction inputAction = TextInputAction.next,
  TextEditingController controller,
  FocusNode focusNode,
  IconButton icon,
  Function validateField,
  Function onChanged,
  Function action
}) {
  return TextFormField(
    key: key,
    enabled: enableInput,
    focusNode: focusNode,
    keyboardType: inputType,
    obscureText: obcureText,
    controller: controller,
    textInputAction: inputAction,
    style: TextStyle(color: getHexaColor("#ffffff"), fontSize: 18.0),
    validator: validateField,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
          fontSize: 18.0,
          color: focusNode.hasFocus || controller.text != ""
              ? getHexaColor("#FFFFF").withOpacity(0.3)
              : getHexaColor("#ffffff")),
      prefixText: prefixText,
      prefixStyle: TextStyle(color: Colors.white, fontSize: 18.0),
      /* Prefix Text */
      filled: true, fillColor: getHexaColor("#FFFFFF").withOpacity(0.1),
      enabledBorder: outlineInput(controller.text != ""
          ? getHexaColor("#FFFFFF").withOpacity(0.3)
          : Colors.transparent),
      /* Enable Border But Not Show Error */
      border: errorOutline(),
      /* Show Error And Red Border */
      focusedBorder: outlineInput(getHexaColor("#FFFFFF").withOpacity(0.3)),
      /* Default Focuse Border Color*/
      focusColor: getHexaColor("#ffffff"),
      /* Border Color When Focusing */
      contentPadding: EdgeInsets.all(23), // No Content Padding = -10.0 px
      suffixIcon: icon
    ),
    inputFormatters: textInputFormatter,
    /* Limit Length Of Text Input */
    onChanged: (valueChange) {
      if (widgetName == "loginSecondScreen" ||
          widgetName == "signUpFirstScreen")
        onChanged(labelText, valueChange);
      else
        onChanged(valueChange);
    },
    onFieldSubmitted: (value) {
      action(context);
    },
  );
}

Widget customDropDown(String label, List list, dynamic _model,
    Function changeValue, PopupMenuItem Function(Map<String, dynamic>) item) {
  /* Custom DropDown */
  return Container(
    padding: EdgeInsets.only(top: 11.0, bottom: 11.0, left: 26.0, right: 14.0),
    decoration: BoxDecoration(
        color: getHexaColor("#FFFFFF").withOpacity(0.1),
        borderRadius: BorderRadius.circular(size5),
        border: Border.all(
            width: 1,
            color: label == "Gender"
                ? Colors.transparent
                : getHexaColor("#FFFFFF")
                    .withOpacity(0.3)) /* Control Border Gender Color */
        ),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
        ),
        Theme(
          data:
              ThemeData(canvasColor: getHexaColor("#FFFFFF").withOpacity(0.1)),
          child: PopupMenuButton(
            offset: Offset.zero,
            padding: EdgeInsets.all(12),
            onSelected: (index) {
              changeValue(index);
            },
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
            itemBuilder: (BuildContext context) {
              return list.map((list) {
                return item(list);
              }).toList();
            },
          ),
        )
      ],
    ),
  );
  // Column(
  //   crossAxisAlignment: CrossAxisAlignment.start,
  //   children: <Widget>[
  //     /* Text Field */
  //     Container(
  //       padding: EdgeInsets.only(top: 23.0, bottom: 23.0, left: 26.0, right: 26.0),
  //       width: double.infinity,
  //       decoration: BoxDecoration(
  //         border: Border.all(width: size1, color: getHexaColor(AppColors.borderColor)),
  //         borderRadius: BorderRadius.circular(size5),
  //         color: black38
  //       ),
  //       child: Theme(
  //         data: ThemeData(canvasColor: getHexaColor(lightGreyColor)),
  //         child:
  //         // DropdownButtonHideUnderline(
  //         //   child: DropdownButton(
  //         //     isExpanded: false,
  //         //     icon: Align( /* Arrow Down Icon */
  //         //       alignment: Alignment.centerRight,
  //         //       child: Icon(Icons.keyboard_arrow_down),
  //         //     ),
  //         //     style: TextStyle(color: Colors.white),
  //         //     items: list.map((text){
  //         //       return DropdownMenuItem(
  //         //         value: text,
  //         //         child: textDropDown(text),
  //         //       );
  //         //     }).toList(),
  //         //     // /* If Gender */
  //         //     // label == "Gender"
  //         //     //   ? genderList.map((text) {
  //         //     //     return DropdownMenuItem(
  //         //     //       value: text,
  //         //     //       child: textDropDown(text),
  //         //     //     );
  //         //     //   }).toList()
  //         //     // /* If Document Type Id */
  //         //     //   : documentIdList.map((mapData) {
  //         //     //     return DropdownMenuItem(
  //         //     //       value: mapData['id'],
  //         //     //       child: Text(mapData['document_name']),
  //         //     //     );
  //         //     //   }).toList(),
  //         //     // value: label == "Gender" ? _model.gender : _modelDocument.documentTypeId,
  //         //     onChanged: (changed) {
  //         //       // if (label == "Gender") {
  //         //       //   setGender(changed);
  //         //       // } else if ( label == "Document Type") {
  //         //       //   setDocumentName(changed);
  //         //       // }
  //         //     },
  //         //   ),
  //         // ),
  //       )
  //     )
  //   ],
  // );
}

Widget textButton({
  BuildContext context,
  String textColor,
  String text,
  EdgeInsets padding = const EdgeInsets.all(13),
  Function onTap,
  double fontSize = 18.0,
  FontWeight fontWeight = FontWeight.w400}
) {
  return InkWell(
    child: Padding(
      padding: padding,
      child: textScale(
          text: text,
          hexaColor: textColor,
          fontSize: fontSize,
          underline: TextDecoration.none,
          fit: BoxFit.fill,
          fontWeight: fontWeight),
    ),
    onTap: onTap,
  );
}

Widget textScale({
  String text,
  double fontSize = 18.0,
  String hexaColor = "#1BD2FA",
  TextDecoration underline,
  BoxFit fit = BoxFit.contain,
  FontWeight fontWeight}
) {
  return FittedBox(
    fit: fit,
    child: Text(
      text,
      style: TextStyle(
        color: getHexaColor(hexaColor),
        decoration: underline,
        fontSize: fontSize,
        fontWeight: fontWeight
      ),
    ),
  );
}

Widget textDropDown(String text) {
  /* List Drop Down Text */
  return Align(alignment: Alignment.center, child: Text(text));
}

Widget drawerText(String text, Color colors, double fontSize) {
  /* Drawer Text */
  return Text(text,
      style: TextStyle(
          color: colors, fontSize: fontSize, fontWeight: FontWeight.bold));
}

Widget warningTitleDialog() {
  return Text(
    'Oops...',
    style: TextStyle(fontWeight: FontWeight.bold),
  );
}

Widget disableNativePopBackButton(Widget child) {
  return WillPopScope(
    onWillPop: () => Future(() => false),
    child: child,
  );
}

