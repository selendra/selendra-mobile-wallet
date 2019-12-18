/* Package of flutter */
import 'dart:io';
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

class BlurBackground extends ModalRoute<void> {

  final Widget child;

  @required
  BlurBackground({Key key, this.child});

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;
  
  @override 
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation){
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Colors.white.withOpacity(0.15),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(
            sigmaX: 20.0,
            sigmaY: 20.0,
          ),
          child: child,
        ),
      ),
    );
  }
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

/* User input Outline Border */
OutlineInputBorder outlineInput(Color borderColor) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: borderColor, width: size1),
    borderRadius: BorderRadius.circular(size5)
  );
}

/* User error Outline Border */
OutlineInputBorder errorOutline() {
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
Widget lightBlueButton(AsyncSnapshot snapshot, Function action, String textButton, EdgeInsetsGeometry edgeMargin) {
  return Container(
    margin: edgeMargin,
    width: double.infinity,
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
        action();
      }
    ),
  );
}

Widget flatCustomButton(
  Bloc bloc,
  BuildContext context,
  String textButton, String widgetName, String buttonColor,
  FontWeight fontWeight, 
  double fontSize, 
  EdgeInsetsGeometry edgeMargin, EdgeInsetsGeometry edgePadding, 
  BoxShadow boxShadow,
  Function action
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
      onPressed: () {
        if (widgetName == "loginSecondScreen") action(bloc, context);
        else if (widgetName == "invoiceInfoScreen") action(); 
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
            // Row(children: <Widget>[
            //   Text("Note: ", style: TextStyle(fontWeight: FontWeight.bold),),
            //   Text("Please copy your key before close !", style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),)
            // ],)
          ],
        ),
        actions: <Widget>[
          // CupertinoDialogAction(
          //   child: Text('Close'),
          //   onPressed: () => Navigator.of(context).pop(null),
          // ),
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
  return showCupertinoDialog(
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
  BuildContext context, 
  ModelDashboard _modelDashboard, 
  Function scanQR, Function scanReceipt, Function resetState, Function fetchPortfolio){
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
                            await scanQR(context, _modelDashboard, resetState, fetchPortfolio);
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
                          onPressed: () {
                            Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (context) => GetWalletWidget(_modelDashboard.userWallet))
                            );
                          } 
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
        left: (MediaQuery.of(context).size.width/2-30),
        child: FractionalTranslation(
          translation: Offset(0.0, -0.18),
          child: Container(
            width: 60, height: 60,
            child: FittedBox(
              child: FloatingActionButton(
                backgroundColor: getHexaColor("#8CC361"),
                child: Image.asset('assets/z_white_logo.png', width: 22.02, height: 23.29),
                onPressed: () async {
                  scanReceipt();
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

Widget containerTitleAppBar(String title) {
  return Container( 
    height: double.infinity,
    alignment: Alignment.center,
    margin: EdgeInsets.only(left: 8.0),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 25.0,
        color: Colors.white,
        fontWeight: FontWeight.bold
      )
    ),
  );
}

Widget zeeLogo(double width, double height) {
  return Image.asset("assets/zeelogo.png", height: height, width: width);
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

/* QR Code Generate Function */
Widget qrCodeGenerate(String _walletCode) {
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
          embeddedImage: AssetImage('assets/zee_for_qr.png'),
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size(50, 50),
            ),
            version: 6,
            data: _walletCode,
            gapless: true,
          ), 
        )
      ),
    ],
  );
}

/* ---------------------------------- Setting ----------------------------------*/
Widget textFieldDisplay(bool enableInput, TextEditingController textController,bool isObscureText, String labelText, ModelDocument _modelDocument) {
  return Container(
    margin: EdgeInsets.only(top: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /* Email label */
        Container(child: labelUserInput(labelText, whiteColorHexa),),
        /* Text Field*/
        TextField(
          controller: textController,
          style: TextStyle(color: getHexaColor(lightBlueSky), fontWeight: FontWeight.w300),
          obscureText: isObscureText,
          enabled: enableInput,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 20.0, top: 20.0),
            hasFloatingPlaceholder: false,
            enabled: true,
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: getHexaColor(borderColor))
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: getHexaColor(borderColor))
            )
          ),
          onChanged: (data) {
            _modelDocument.documentNo = data;
          },
        )
      ],
    )
  );
}

Widget textNotification(String text, BuildContext context) {
  return Align(alignment: Alignment.center, child: Text(text, style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w300)),);
}

/*----------------------------------------------- Field Icons trigger Widget ----------------------------------------------------- */
Widget fieldPicker(BuildContext context, String labelText, String widgetName, IconData icons, dynamic _model,  Function method) {
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
            if (widgetName == "addDocumentScreen") method(labelText);
            else method();
          },
        )
      ],
    )
  );
}

/* User Input Field */
Widget inputField(
  Bloc bloc,
  BuildContext context,
  String labelText, String prefixText, String widgetName,
  bool obcureText,
  TextInputType inputType, TextEditingController controller,
  FocusNode _focusNode,
  Function onChanged, Function action
  ) {
  return TextFormField(
    focusNode: _focusNode, 
    keyboardType: inputType,
    obscureText: obcureText,
    controller: controller,
    style: TextStyle(color: getHexaColor("#ffffff")),
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: controller.text != "" ? getHexaColor("#FFFFFF").withOpacity(0.3) : Colors.transparent, 
          width: 1.0
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: getHexaColor("#FFFFFF").withOpacity(0.3), width: 1.0),
      ),
      prefixText: prefixText, prefixStyle: TextStyle(color: Colors.white),
      filled: true, fillColor: getHexaColor("#FFFFFF").withOpacity(0.1),
      labelText: labelText,
      labelStyle: TextStyle(
        fontSize: 18.0,
        color: _focusNode.hasFocus || controller.text != "" ? getHexaColor("#FFFFF").withOpacity(0.3) : getHexaColor("#ffffff")
      ),
      focusColor: getHexaColor("#ffffff"),
      contentPadding: EdgeInsets.only(top: 23.0, bottom: 23.0, left: 26.0), // No Content Padding = -10.0 px
    ),
    onChanged: (valueChange) {
      if (
        widgetName == "invoiceInfoScreen" || 
        widgetName == "addAssetScreen" || 
        widgetName == "loginFirstScreen" ||
        widgetName == "loginSecondScreen"
      ) 
        onChanged(labelText, valueChange);
      else onChanged(valueChange);
    },
    onFieldSubmitted: (value) {
      if (widgetName == "BothScreen" || widgetName == "invoiceInfoScreen") action(bloc, context);
      else action(context, value);
    },
    // onFieldSubmitted: (value) {
    //       firstNode.unfocus();
    //       FocusScope.of(context).requestFocus(secondNode);
//         }
  );
}

Widget textFieldUserInput(String label, String colorLabel, Color fieldColor, TextInputType textInputType,Function textChanged, double marginBottom, double marginLeft) {
  return Container(
    margin: EdgeInsets.only(bottom: marginBottom, left: marginLeft),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /* Label Text */
        Container(margin: EdgeInsets.only(bottom: 5.0), child: labelUserInput(label, colorLabel)),
        /* User Input Field */
        TextField(
          style: TextStyle(color: Colors.white),
          keyboardType: textInputType,
          decoration: InputDecoration(
            fillColor: fieldColor, filled: true,
            contentPadding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: size10),
            labelStyle: TextStyle(color: Colors.white),
            /* Border side */
            enabledBorder: outlineInput(getHexaColor(borderColor)),
            focusedBorder: outlineInput(getHexaColor(borderColor)),
            /* Error Handler */
            border: errorOutline(),
            focusedErrorBorder: errorOutline(),
          ),
          onChanged: (changed) {
            textChanged(label, changed);
          },
        )
      ],
    ),
  );
}

Widget dropDown(String label, List genderList, List documentIdList, ModelUserInfo _modelUserInfo, ModelDocument _modelDocument ,Function setGender, Function setDocumentName) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      /* Label Gender */
      Container(margin: EdgeInsets.only(bottom: 5.0), child: labelUserInput(label, "#ffffff")),
      /* Text Field */
      Container(
        padding: EdgeInsets.only(left: 10.0, right: 5.0),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(width: size1, color: getHexaColor(borderColor)),
          borderRadius: BorderRadius.circular(size5),
          color: black38
        ),
        child: Theme(
          data: ThemeData(canvasColor: getHexaColor(lightGreyColor)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.arrow_drop_down),
              ),
              style: TextStyle(color: Colors.white),
              items: 
              /* If Gender */
              label == "Gender" 
                ? genderList.map((text) {
                  return DropdownMenuItem(
                    value: text,
                    child: textDropDown(text),
                  );
                }).toList()
              /* If Document Type Id */
                : documentIdList.map((mapData) {
                  return DropdownMenuItem(
                    value: mapData['id'],
                    child: Text(mapData['document_name']),
                  );
                }).toList(),
              value: label == "Gender" ? _modelUserInfo.gender : _modelDocument.documentTypeId,
              onChanged: (changed) {
                if (label == "Gender") {
                  setGender(changed);
                } else if ( label == "Document Type") {
                  setDocumentName(changed);
                }
              },
            ),
          ),
        )
      )
    ],
  );
}

/* Drop Down Text */
Widget textDropDown(String text) {
  return Align(alignment: Alignment.center,child: Text(text));
}

/* Drawer Text */
Widget drawerText(String text, Color colors, double fontSize) {
  return Text(text, style: TextStyle(color: colors, fontSize: fontSize, fontWeight: FontWeight.bold));
}