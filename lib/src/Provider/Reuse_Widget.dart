/* Package of flutter */
import 'dart:io';
import 'package:Wallet_Apps/src/Model/Model_Document.dart';
import 'package:Wallet_Apps/src/Model/Model_Profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
/* Path of file */
import 'package:qr_flutter/qr_flutter.dart';
import './Hexa_Color_Convert.dart';

/* -----------------------------------Variable--------------------------------------------------- */

String darkGreyBlue = "#242426";
/* Grey color code */
String greyCode = "#818181";
/* Dark Grey Color Code */
String darkGrey = "#302f34";
/* Background Color */
String backgroundColor = "#131722";
/* High Then Background Color */
String highThenBackgroundColor = "#191F30";
/* Color Black 38 */
Color black38 = Colors.black38;
/* White Color */
String whiteColor = "#FFFFFF";
/* Black Color */
String blackColor = "#000000";
/* Light Blue Sky Color & Green Color*/
String lightBlueSky = "#54ffe2", lightGreenColor = "#92FB85";
/* PortFolio List Color */
String lightGreyColor = "#36363B";
/* Card Color */
String cardColor = "#131722";
String borderColor = "#363c4e";
/* Default Margin */
final double margin4 = 4.0;
final double margin10 = 15.0;
/* Width Of Border */
double defaultBorderWidth = 1.0;
/* Size Of Border Radius */
double defaultBorderRadius = 5.0;

/* -----------------------------------Box Border and Shadow Style--------------------------------------------------- */

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
      contentPadding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: margin10),
      labelStyle: TextStyle(color: Colors.white),
      /* Border side */
      border: errorOutline(),
      enabledBorder: outlineInput(Color(convertHexaColor(lightBlueSky))),
      focusedBorder: outlineInput(Color(convertHexaColor(lightBlueSky))),
      /* Error Handler */
      focusedErrorBorder: errorOutline(),
      errorText: snapshot.hasError ? snapshot.error : null,
    ),
  );
}

/* User input Outline Border */
OutlineInputBorder outlineInput(Color borderColor) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: borderColor, width: defaultBorderWidth),
    borderRadius: BorderRadius.circular(defaultBorderRadius)
  );
}

/* User error Outline Border */
OutlineInputBorder errorOutline() {
  return OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red)
  );
}

/* Button shadow */
BoxShadow shadow(String hexaCode) {
  return BoxShadow(
    color: Color(convertHexaColor(hexaCode)),
    blurRadius: 5.0,
    spreadRadius: -3.0,
    offset: Offset(
      0,
      0
    )
  );
}

/* -------------------------------------- Blue Color Button -----------------------------------------*/
Widget lightBlueButton(AsyncSnapshot snapshot, Function method, String textButton, EdgeInsetsGeometry edgeMargin, RunMutation runMutation) {
  return Container(
    margin: edgeMargin,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: FlatButton(
      color: Color(convertHexaColor("#2BB9CD")),
      disabledTextColor: Colors.black54,
      disabledColor: Colors.grey[700],
      focusColor: Color(convertHexaColor("#55D8EB")),
      padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
      textColor: Colors.white,
      child: Text(
        textButton,
        style: TextStyle(fontSize: 17.0),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)),
      onPressed: snapshot.data == null ? null : () {
        method(runMutation);
      }
      // }
    ),
  );
}


/* Border and Border Radius Chart Card */
BoxDecoration borderAndBorderRadius() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(5.0),
    border: Border.all(width: 2.0, color: Color(convertHexaColor("#5F5F69"))),
  );
}

/* -----------------------------------Background Color Style--------------------------------------------------- */

/* Title gradient color */
final Shader linearGradient = LinearGradient(
  colors: [
    Color(convertHexaColor(lightBlueSky)),
    Color(convertHexaColor(lightGreenColor))
  ]
).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

BoxDecoration signOutColor() {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(convertHexaColor("#1D0837")),
        Color(convertHexaColor("#0F0F11")),
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

/* Loading */
Widget loading() {
  return Center(
    child: CircularProgressIndicator(
      backgroundColor: Color(convertHexaColor(lightBlueSky)),
      valueColor: AlwaysStoppedAnimation(Colors.white)
    ),
  );
}

/* -----------------------------------App Bar--------------------------------------------------- */

/* Appbar with menu and notification */
Widget appbarWidget(Function openMyDrawer, Widget title, Function snackBar) {
  return AppBar(
    centerTitle: true,
    title: title,
    elevation: 10.0,
    backgroundColor: Color(convertHexaColor(highThenBackgroundColor)),
    automaticallyImplyLeading: false,
    leading: Container(
      margin: EdgeInsets.only(left: 5.0),
      child: IconButton(
        color: Colors.white,
        iconSize: 40.0,
        icon: Icon(Icons.sort),
        onPressed: () {
          openMyDrawer();
        },
      ),
    ),
    actions: <Widget>[
      IconButton(
        color: Colors.white,
        icon: Icon(OMIcons.notifications),
        onPressed: () {},
      )
    ],
  );
}

/* Title App Bar */
Widget titleAppBar(String title) {
  return Text(title);
}

/* Trasparent AppBar have only back arrow button */
Widget appBar(String title, Function pop, Color color) {
  return AppBar(
    centerTitle: true,
    title: Text(title, style: TextStyle(color: color),),
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    iconTheme: IconThemeData(color: color),
    leading: IconButton(
      color: color,
      icon: Icon(Icons.arrow_back_ios),
      onPressed: pop,
    ),
  );
}

/* Zeetomic logo */
Widget zeetomicLogoTitle() {
  return Image.asset(
    'assets/zeetomic-logo-header.png',
    width: 100.0,
    height: 100.0,
  );
}

/* -----------------------------------Text Style--------------------------------------------------- */

/* Label User Input */
Widget labelUserInput(String text, String colorHexa) {
  return Text(text, style: TextStyle(color: Color(convertHexaColor(colorHexa)), fontSize: 12.0, fontWeight: FontWeight.bold),);
}

/* ---------------------------------Camera and Gallery------------------------------------------------ */

/* Trigger image from gallery */
Future<File> gallery() async {
  var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  return image;
}

/* Trigger image from gallery */
Future<File> camera() async {
  var image = await ImagePicker.pickImage(source: ImageSource.camera);
  return image;
}

/* QR Code Generate Function */
Widget qrCodeGenerate(String _walletCode) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        width: 200.0,
        height: 200.0,
        margin: EdgeInsets.only(bottom: 10.0),
        child: RepaintBoundary(
          child: new QrImage(
          foregroundColor: Colors.white,
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
Widget textFieldDisplay(bool enableInput, TextEditingController textController,bool isObscureText, String labelText, ModelDocument model) {
  return Container(
    margin: EdgeInsets.only(top: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /* Email label */
        Container(child: labelUserInput(labelText, whiteColor),),
        /* Text Field*/
        TextField(
          controller: textController,
          style: TextStyle(color: Color(convertHexaColor(lightBlueSky)), fontWeight: FontWeight.w300),
          obscureText: isObscureText,
          enabled: enableInput,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 20.0, top: 20.0),
            hasFloatingPlaceholder: false,
            enabled: true,
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(convertHexaColor(borderColor)))
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(convertHexaColor(borderColor)))
            )
          ),
          onChanged: (data) {
            model.documentNo = data;
          },
        )
      ],
    )
  );
}

Widget textNotification(String text, BuildContext context) {
  return Align(alignment: Alignment.center, child: Text(text, style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w300)),);
}

/*----------------------------------------------- Add Document Widget ----------------------------------------------------- */
Widget datePickerNDisplay(BuildContext context, String issueDate, String labelName, Function resetDate, ModelDocument modelDocument) {
  return Container(
    margin: EdgeInsets.only(top: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /* Email label */
        Container(child: labelUserInput(labelName, "#ffffff"), margin: EdgeInsets.only(bottom: margin4),),
        /* Text Field*/
        InkWell(
          child: Container(
            padding: EdgeInsets.all(margin10),
            decoration: BoxDecoration(
              color: black38,
              border: Border.fromBorderSide(
                BorderSide(color: Color(convertHexaColor(lightBlueSky)))
              ),
              borderRadius: BorderRadius.circular(defaultBorderRadius)
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(issueDate, style: TextStyle(color: Colors.white),),
                ),
                Icon(Icons.calendar_today, color: Colors.white)
              ],
            ),
          ),
          onTap: () {
            DatePicker.showDatePicker(
              context, 
              showTitleActions: true,
              minTime: DateTime(2000, 1, 1),
              maxTime: DateTime(2050, 1, 1),
              onChanged: (date){ },
              onConfirm: (data){
                resetDate(data, labelName);
                if (labelName == "Issue Date")modelDocument.issueDate = data.millisecondsSinceEpoch;
                else modelDocument.expireDate = data.millisecondsSinceEpoch;
              }
            );
          },
        )
      ],
    )
  );
}

/* Add Profile */
Widget textFieldAddProfile(String label, Function textChanged, double marginBottom, double marginLeft) {
  return Container(
    margin: EdgeInsets.only(bottom: marginBottom, left: marginLeft),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /* Label Text */
        Container(margin: EdgeInsets.only(bottom: 5.0), child: labelUserInput(label, "#ffffff")),
        /* User Input Field */
        TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            fillColor: Colors.black54, filled: true,
            contentPadding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: margin10),
            labelStyle: TextStyle(color: Colors.white),
            /* Border side */
            enabledBorder: outlineInput(Color(convertHexaColor(borderColor))),
            focusedBorder: outlineInput(Color(convertHexaColor(borderColor))),
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

Widget dropDown(String label, List genderList, List documentIdList, ModelProfile modelProfile, ModelDocument modelDocument ,Function setGender, Function setDocumentName) {
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
          border: Border.all(width: defaultBorderWidth, color: Color(convertHexaColor(borderColor))),
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          color: black38
        ),
        child: Theme(
          data: ThemeData(canvasColor: Color(convertHexaColor(lightGreyColor))),
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
              value: label == "Gender" ? modelProfile.gender : modelDocument.documentTypeId,
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