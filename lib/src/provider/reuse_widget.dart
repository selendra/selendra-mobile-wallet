/* Package of flutter */
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:wallet_apps/src/model/model_dashboard.dart';
import 'package:wallet_apps/src/model/model_document.dart';
import 'package:wallet_apps/src/model/model_user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
/* Path of file */
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/get_wallet_screen/get_wallet.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/profile_user.dart';
import 'package:wallet_apps/src/service/services.dart';
import 'package:wallet_apps/src/bloc/validator_mixin.dart';
import 'dart:ui' as ui;

/* -----------------------------------Variable--------------------------------------------------- */

const String darkGreyBlue = "#242426";

/* Grey color code */
const String greyCode = "#818181";
const String darkGrey = "#302f34";

/* Background Color */
const String backgroundColor = "#12151E";

/* High Then Background Color */
const String highThenBackgroundColor = "#1F2833";//"#191F30";

/* Color Black 38 */
const Color black38 = Colors.black38;

/* White Color */
const String whiteColorHexa = "#FFFFFF";
const whiteNormalColor = Colors.white;
const String appBarTextColor = "#EFF0F2";

/* Black Color */
const String blackColor = "#000000";

/* Light Blue Sky Color & Green Color*/
const String lightBlueSky = "#54ffe2", greenColor = "#8CC561";

/* Blue Color */
const String blueColor = "#23b9da";

/* PortFolio List Color */
const String lightGreyColor = "#36363B";

/* Card Color */
const String cardColor = "#4B535F";
const String borderColor = "#363c4e";

/* Color fade Grey */
const String textColor = "#EFF0F2";

/* Background Color */
String color1 = "#344051", color2 = "#222834";

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
  return Color(convertHexaColor(hexaCode));
}

Route transitionRoute(Widget child) {
  return PageRouteBuilder(
    opaque: false,
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child){
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.easeOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: Material(
          color: Colors.white.withOpacity(0.1),
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(
              sigmaX: 20.0,
              sigmaY: 20.0,
            ),
            child: child,
          ),
        )
      );
    }
  );
}

/* User Input Text */
TextField userTextField(TextEditingController inputEditor, FocusNode node, Function sink, AsyncSnapshot snapshot, bool showInput, TextInputType inputType, TextInputAction inputAction) {
  return TextField(
    controller: inputEditor,
    style: TextStyle(color: Colors.white),
    focusNode: node,
    obscureText: showInput,
    onChanged: sink,
    keyboardType: inputType,
    textInputAction: inputAction,
    decoration: InputDecoration(
      fillColor: Colors.black38, filled: true,
      contentPadding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: size10),
      labelStyle: TextStyle(color: Colors.white),
      /* Border side */
      border: errorOutline(),
      enabledBorder: outlineInput(getHexaColor(borderColor)),
      focusedBorder: outlineInput(getHexaColor(lightBlueSky)),
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
    borderRadius: BorderRadius.circular(size5)
  );
}

OutlineInputBorder errorOutline() { /* User Error Input Outline Border */
  return OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red)
  );
}

/* Button shadow */
BoxShadow shadow(Color hexaCode, double blurRadius, double spreadRadius) {
  return BoxShadow(
    color: hexaCode,
    blurRadius: blurRadius,
    spreadRadius: spreadRadius,
    offset: Offset(
      0,
      0
    )
  );
}

/* -------------------------------------- Raised Button -----------------------------------------*/
Widget lightBlueButton(BuildContext _context, AsyncSnapshot snapshot, Function action, String textButton, EdgeInsetsGeometry edgeMargin) {
  return Container(
    margin: edgeMargin,
    width: double.infinity,
    height: 50.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: FlatButton(
      color: getHexaColor("#2BB9CD"),
      disabledTextColor: Colors.black54,
      disabledColor: Colors.grey[700],
      focusColor: getHexaColor("#55D8EB"),
      padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
      textColor: Colors.white,
      child: Text(
        textButton,
        style: TextStyle(fontSize: 17.0),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)),
      onPressed: snapshot.data == null ? null : () {
        action(_context);
      }
    ),
  );
}

Widget customFlatButton(
  BuildContext context,
  String textButton, String widgetName, String buttonColor,
  FontWeight fontWeight, 
  double fontSize, 
  EdgeInsetsGeometry edgeMargin, EdgeInsetsGeometry edgePadding, 
  BoxShadow boxShadow,
  dynamic action
) {
  return Container(
    margin: edgeMargin,
    width: double.infinity,
    height: 50.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(size5),
      boxShadow: [
        boxShadow
      ]
    ),
    child: FlatButton(
      color: getHexaColor(buttonColor),
      disabledTextColor: Colors.black54,
      disabledColor: Colors.grey[700],
      focusColor: getHexaColor("#83B6BD"),
      textColor: Colors.white,
      child: Text(
        textButton,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(size5)),
      onPressed: action == null ? null : () {
        if (widgetName == "invoiceInfoScreen") action(); 
        else action(context);
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
      colors: [
        getHexaColor(color1),
        getHexaColor(color2)
      ]
    )
  );
}

Widget scaffoldBGDecoration(double paddingLeft, double paddingRight, double paddingTop, double paddingBottom, String color1, String color2, Widget body) {
  return Container(
    width: double.infinity,
    height: double.infinity,
    padding: EdgeInsets.only(left: paddingLeft, right: paddingRight, top: paddingTop, bottom: paddingBottom),
    decoration: scaffoldBGColor(color1, color2),
    child: body,
  );
}

/* Title gradient color */
final Shader linearGradient = LinearGradient(
  colors: [
    getHexaColor(lightBlueSky),
    getHexaColor(greenColor)
  ]
).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

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
Future dialog(BuildContext context, var text, var title) async {
  var result = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: title,
        content: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: text,
            ),
          ],
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text('Close'),
            onPressed: () => Navigator.of(context).pop(text),
          )
        ],
      );
    }
  );
  return result;
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
    // barrierDismissible: false,
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
Widget bottomAppBar(
  BuildContext _context, 
  ModelDashboard _modelDashboard, 
  Function _scanQR, Function _scanReceipt, Function _resetState, Function _toReceiveToken){
  return Stack(
    children: <Widget>[
      Container(
        decoration: BoxDecoration(
          color: getHexaColor(color2),
          boxShadow: [
            shadow(getHexaColor("#000000").withOpacity(0.5), 5.0, 3.0)
          ]
        ),
        child: BottomAppBar(
          elevation: 10.0,
          shape: CircularNotchedRectangle(),
          child: Container(
            height: 83.0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 36.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 70.0,
                        child: IconButton(
                          padding: EdgeInsets.all(0),
                          color: Colors.white,
                          iconSize: 30.0,
                          // padding: EdgeInsets.only(left: 28.0),
                          icon: Icon(OMIcons.arrowUpward, color: Colors.white,),
                          onPressed: () async {
                            await _scanQR(_context, _modelDashboard, _resetState);
                          }
                        ),
                      ),
                      Text("Send Token", style: TextStyle(color: getHexaColor("#97AAC3"), fontSize: 10.0))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 36.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 70.0,
                        child: IconButton(
                          padding: EdgeInsets.all(0),
                          color: Colors.white,
                          iconSize: 30.0,
                          icon: Icon(OMIcons.arrowDownward),
                          onPressed: () => _toReceiveToken(_context)
                        ),
                      ),
                      Text("Receive Token", style: TextStyle(color: getHexaColor("#97AAC3"), fontSize: 10.0))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      /* Logo Z Button */
      Positioned(
        left: (MediaQuery.of(_context).size.width/2-30),
        child: FractionalTranslation(
          translation: Offset(0.0, -0.18),
          child: Container(
            width: 60, height: 60,
            child: FittedBox(
              child: FloatingActionButton(
                backgroundColor: getHexaColor("#8CC361"),
                child: Image.asset('assets/zeeicon_button.png', width: 22.02, height: 23.29),
                onPressed: () async {
                  _scanReceipt();
                },
              ),
            ),
          ),
        ),
      )
    ],
  );
}

/* Loading Progress */
Widget loading() {
  return Center(
    child: CircularProgressIndicator(
      backgroundColor: getHexaColor(lightBlueSky),
      valueColor: AlwaysStoppedAnimation(getHexaColor(textColor))
    ),
  );
}

/* Progress */
Widget progress() {
  return Material(
    color: Colors.transparent,
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        CircularProgressIndicator(
          backgroundColor: getHexaColor(lightBlueSky),
          valueColor: AlwaysStoppedAnimation(Colors.white)
        )
      ],
    ),
  );
}

void dialogLoading(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return progress();
    }
  );
}

/* -----------------------------------App Bar--------------------------------------------------- */

Widget containerAppBar(BuildContext context, Widget subAppBar) {
  return Container(
    margin: EdgeInsets.only(top: 52.0),
    height: 41.0,
    width: MediaQuery.of(context).size.width,
    child: subAppBar
  );
}

Widget iconAppBar(Widget icon, Alignment alignment, EdgeInsetsGeometry edgePadding, dynamic action) {
  return IconButton( /* Menu Icon */
    alignment: alignment,
    padding: edgePadding,
    iconSize: 40.0,
    icon: icon,
    onPressed: action,
  );
}

Widget containerTitle(String title, dynamic _height, dynamic textColor, FontWeight _fontWeight) {
  return Container( 
    height: _height,
    alignment: Alignment.center,
    margin: EdgeInsets.only(left: 8.0),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 25.0,
        color: textColor,
        fontWeight: _fontWeight
      )
    ),
  );
}

Widget logoWelcomeScreen(String logoName, double width, double height) {
  return Image.asset("assets/$logoName", width: width, height: height);
}

/* -----------------------------------Text Style--------------------------------------------------- */

/* Label User Input */
Widget labelUserInput(String text, String colorHexa) {
  return Text(text, style: TextStyle(color: getHexaColor(colorHexa), fontSize: 12.0, fontWeight: FontWeight.bold),);
}

Widget textDisplay(String text, TextStyle textStyle) {
  return Text(text, 
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
  var image = await ImagePicker.pickImage(source: ImageSource.camera, imageQuality: 100);
  return image;
}

Widget qrCodeGenerate(String _walletCode, String logoName) { /* QR Code Generate Function */
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(bottom: 36.0),
        child: Text('Wallet', style: TextStyle(fontSize: 17.0, color: getHexaColor("#959CA7"),))
      ),
      Container(
        width: 200.0,
        height: 200.0,
        child: RepaintBoundary(
          child: new QrImage(
          foregroundColor: getHexaColor("#EEF0F2"),
          embeddedImage: AssetImage('assets/${logoName}'),
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size(40, 40),
            ),
            // version: 6,
            data: _walletCode,
            gapless: true,
          ), 
        )
      ),
    ],
  );
}

Widget textNotification(String text, BuildContext context) {
  return Align(alignment: Alignment.center, child: Text(text, style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w300)),);
}

/*----------------------------------------------- Field Icons trigger Widget ----------------------------------------------------- */
Widget fieldPicker(BuildContext context, String labelText, String widgetName, IconData icons, dynamic _model,  dynamic method) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InkWell( /* Text Field*/
          child: Container(
            padding: EdgeInsets.only(top: 23.0, bottom: 23.0, left: 26.0, right: 26.0),
            decoration: BoxDecoration(
              color: getHexaColor("#FFFFFF").withOpacity(0.1),
              borderRadius: BorderRadius.circular(size5)
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(labelText, style: TextStyle(color: Colors.white, fontSize: 18.0),),
                ),
                Icon(icons, color: Colors.white,)
              ],
            ),
          ),
          onTap: () {
            if (widgetName == "fillDocsScreen") method(labelText);
            else method();
          },
        )
      ],
    )
  );
}

Widget inputField( /* User Input Field */
  BuildContext context,
  String labelText, String prefixText, String widgetName,
  bool obcureText,
  List<TextInputFormatter> textInputFormatter,
  TextInputType inputType, TextInputAction inputAction, TextEditingController controller,
  FocusNode _focusNode,
  Function validateField, Function onChanged, Function action
  ) {
  return TextFormField(
    focusNode: _focusNode, 
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
        color: _focusNode.hasFocus || controller.text != "" ? getHexaColor("#FFFFF").withOpacity(0.3) : getHexaColor("#ffffff")
      ),
      prefixText: prefixText, prefixStyle: TextStyle(color: Colors.white, fontSize: 18.0), /* Prefix Text */
      filled: true, fillColor: getHexaColor("#FFFFFF").withOpacity(0.1),
      enabledBorder: outlineInput(controller.text != "" ? getHexaColor("#FFFFFF").withOpacity(0.3) : Colors.transparent), /* Enable Border But Not Show Error */
      border: errorOutline(), /* Show Error And Red Border */
      focusedBorder: outlineInput(getHexaColor("#FFFFFF").withOpacity(0.3)), /* Default Focuse Border Color*/
      focusColor: getHexaColor("#ffffff"), /* Border Color When Focusing */
      contentPadding: EdgeInsets.only(top: 23.0, bottom: 23.0, left: 26.0), // No Content Padding = -10.0 px
    ),
    inputFormatters: textInputFormatter, /* Limit Length Of Text Input */
    onChanged: (valueChange) {
      if (
        widgetName == "invoiceInfoScreen" || 
        widgetName == "addAssetScreen" || 
        widgetName == "loginFirstScreen" ||
        widgetName == "loginSecondScreen" ||
        widgetName == "signUpFirstScreen" 
      ) onChanged(labelText, valueChange);
      else onChanged(valueChange);
    },
    onFieldSubmitted: (value) {
      action(context);
    },
    // onFieldSubmitted: (value) {
    //       firstNode.unfocus();
    //       FocusScope.of(context).requestFocus(secondNode);
    // }
  );
}

Widget customDropDown(String label, List list, dynamic _model ,Function changeValue) { /* Custom DropDown */
  return Container(
    padding: EdgeInsets.only(top: 11.0, bottom: 11.0, left: 26.0, right: 14.0),
    decoration: BoxDecoration(
      color: getHexaColor("#FFFFFF").withOpacity(0.1),
      borderRadius: BorderRadius.circular(size5)
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Text(label, style: TextStyle(color: Colors.white, fontSize: 18.0),),
        ),
        Theme(
          data: ThemeData(canvasColor: getHexaColor("#FFFFFF").withOpacity(0.1)),
          child: PopupMenuButton(
            offset: Offset.zero,
            padding: EdgeInsets.all(12),
            onSelected: (index) {
              changeValue(index);
            },
            icon: Icon(Icons.keyboard_arrow_down, color: Colors.white,),
            itemBuilder: (BuildContext context) {
              return list.map((text){
                return PopupMenuItem(
                  value: text,
                  child: Text(text),
                );
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
  //         border: Border.all(width: size1, color: getHexaColor(borderColor)),
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

Widget textDropDown(String text) { /* List Drop Down Text */
  return Align(alignment: Alignment.center,child: Text(text));
}

Widget drawerText(String text, Color colors, double fontSize) { /* Drawer Text */
  return Text(text, style: TextStyle(color: colors, fontSize: fontSize, fontWeight: FontWeight.bold));
}