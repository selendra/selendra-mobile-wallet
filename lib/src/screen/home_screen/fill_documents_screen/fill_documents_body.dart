/* Flutter Package */
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:wallet_apps/src/model/model_document.dart';
import 'package:flutter/material.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/http_request/rest_api.dart';

Widget bodyWidget(
  BuildContext context,
  // RunMutation runMutation,
  ModelDocument _modelDocument,
  Function setDocumentName,
  Function triggerImage, Function validatorUser, Function pushReplace, Function popScreen, 
  Function resetImage, Function triggerDate, Function clickSubmit, Function textChanged, Function navigatePage
) {
  return Container(
    margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
    child: Column(
      children: <Widget>[
        containerAppBar( /* AppBar */
          context, 
          Row(
            children: <Widget>[
              iconAppBar( /* Arrow Back Button */
                Icon(Icons.arrow_back, color: Colors.white,),
                Alignment.centerLeft,
                EdgeInsets.all(0),
                popScreen,
              ),
              containerTitle("Fill Documents", double.infinity, Colors.white, FontWeight.bold)
            ],
          )
        ),
        Expanded( /* Field User Input */
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              margin: EdgeInsets.only(bottom: 12.0, left: 27.0, right: 27.0, top: 27.0),
              child: Column(
                children: <Widget>[
                  Container( /* Document Type */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: inputField( 
                      _modelDocument.bloc, 
                      context, 
                      "Document type", null, 'fillDocsScreen', 
                      false, 
                      TextInputType.text, TextInputAction.next, 
                      _modelDocument.controllerDocsType, 
                      _modelDocument.nodeDocsType, 
                      textChanged, null
                    ),
                  ),
                  Container( /* Document Number */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: inputField( 
                      _modelDocument.bloc, 
                      context, 
                      "Document number", null, 'fillDocsScreen', 
                      false, 
                      TextInputType.text, TextInputAction.next, 
                      _modelDocument.controllerDocsNumber, 
                      _modelDocument.nodeDocsNumber, 
                      textChanged, null
                    ),
                  ),
                  Container( /* Issue Date */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: fieldPicker( 
                      context, 
                      "Issue date", "fillDocsScreen",
                      Icons.calendar_today, 
                      _modelDocument, 
                      triggerDate
                    ),
                  ),
                  Container( /* Expired Date */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: fieldPicker( 
                      context, 
                      "Expired date", "fillDocsScreen", 
                      Icons.calendar_today, 
                      _modelDocument, 
                      triggerDate
                    ),
                  ),
                  Container( /* Upload documents */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: fieldPicker(
                      context, 
                      "Upload documents", "fillDocsScreen", 
                      Icons.camera_alt, 
                      _modelDocument, 
                      navigatePage
                    ),
                  ),
                  Container( /* Take selfie */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: fieldPicker(
                      context, 
                      "Take selfie", "fillDocsScreen", 
                      Icons.camera_alt, 
                      _modelDocument, 
                      navigatePage
                    ),
                  ),
                  FutureBuilder( /* Submit button */
                    future: validatorUser(),
                    builder: (context, snapshot){
                      return Container(
                        margin: EdgeInsets.only(bottom: 12.0),
                        child: customFlatButton(
                          _modelDocument.bloc, 
                          context, 
                          "Submit", "fillDocsScreen", blueColor,                 
                          FontWeight.normal,
                          size18,
                          EdgeInsets.only(top: 15.0),
                          EdgeInsets.only(top: size15, bottom: size15),
                          BoxShadow(
                            color: Color.fromRGBO(0,0,0,0.54),
                            blurRadius: 5.0
                          ), 
                          snapshot.hasData ? clickSubmit : null
                        ),
                      );
                    },
                  ),
                  // Container(
                  //   padding: EdgeInsets.all(size4),
                  //   child: Column(
                  //     children: <Widget>[
                  //       Row(
                  //         crossAxisAlignment: CrossAxisAlignment.end,
                  //         children: <Widget>[
                  //           Flexible( /* Document No or Number */
                  //             child: textFieldUserInput("Document No.", "#ffffff", Colors.black54, TextInputType.text, textChanged, 0.0, 0.0)
                  //           ),
                  //           Expanded( /* Document Type */ 
                  //             child: Container(
                  //               margin: EdgeInsets.only(left: 20.0),
                  //               child: dropDown("Document Type", null, _modelDocument.queryData, null, _modelDocument, null, setDocumentName),
                  //             )
                  //           )
                  //         ],
                  //       ),
                  //       Container(margin: EdgeInsets.only(bottom: 20.0)),
                  //       Container( /* User take a picture */
                  //         padding: EdgeInsets.all(size4),
                  //         decoration: BoxDecoration(
                  //           color: black38,
                  //           border: Border.all(width: size1, color: getHexaColor(borderColor)),
                  //           borderRadius: BorderRadius.circular(size5)
                  //         ),
                  //         child: Row(
                  //           verticalDirection: VerticalDirection.down,
                  //           children: <Widget>[
                  //             /* Display Image On Screen */
                  //             Flexible(
                  //               child: Container(
                  //                 width: 240.0,
                  //                 height: 180.0,
                  //                 child: 
                  //                 _modelDocument.defaultPassportImage == true ? Image(image: AssetImage('assets/passport.png'),)
                  //                 : _modelDocument.isPassportImage == false ? loading() : Image.file(_modelDocument.filePassport)
                  //               ),
                  //             ),
                  //             /* Trigger Image */
                  //             Flexible(
                  //               flex: 0,
                  //               child: Container(
                  //                 margin: EdgeInsets.only(left: 5.0),
                  //                 child: RaisedButton(
                  //                   child: Row(
                  //                     children: <Widget>[
                  //                       Icon(Icons.camera_alt),
                  //                       Container(margin: EdgeInsets.only(left: 5.0, right: 5.0)),
                  //                       Text("Camera")
                  //                     ],
                  //                   ),
                  //                   onPressed: () async {
                  //                     var imageFile = await triggerImage('passPortImage');
                  //                     if (imageFile != null ) {
                  //                       await Future.delayed(Duration(seconds: 1), () async {
                  //                         http.StreamedResponse response = await upLoadImage(imageFile, "upload");
                  //                         /* Get Value Response And Convert */
                  //                         response.stream.transform(utf8.decoder).listen((value) async {
                  //                           Map<String, dynamic> decode = await json.decode(value);
                  //                           resetImage('passPortImage', decode['url']);
                  //                         });
                  //                       });
                  //                     }
                  //                   }
                  //                 ),
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //       ),

                  //       /* User selfies */
                  //       Container(margin: EdgeInsets.only(bottom: 20.0)),
                  //       Container(
                  //         decoration: BoxDecoration(
                  //           color: black38,
                  //           border: Border.all(width: size1, color: getHexaColor(borderColor)),
                  //           borderRadius: BorderRadius.circular(size5)
                  //         ),
                  //         child: Row(
                  //           verticalDirection: VerticalDirection.down,
                  //           children: <Widget>[
                  //             /* Profile Image Column */
                  //             Flexible(
                  //               child: Container(
                  //                 margin: EdgeInsets.only(right: 5.0),
                  //                 width: 240.0,
                  //                 height: 180.0,
                  //                 child: 
                  //                 _modelDocument.defaultSelfieImage == true ? Image(image: AssetImage('assets/passport_zuman.png'), color: Colors.white,) :
                  //                 _modelDocument.isSelfieImage == false ? loading() : Image.file(_modelDocument.fileSelfie)
                  //               ),
                  //             ),
                  //             Flexible(
                  //               flex: 0,
                  //               child: Container(
                  //                 margin: EdgeInsets.only(left: 5.0),
                  //                 child: RaisedButton(
                  //                   disabledTextColor: Colors.black54, disabledColor: Colors.grey[700],
                  //                   child: Row(
                  //                     children: <Widget>[
                  //                       Icon(Icons.camera_alt),
                  //                       Container(margin: EdgeInsets.only(left: 5.0, right: 5.0)),
                  //                       Text("Selfie")
                  //                     ],
                  //                   ),
                  //                   onPressed: _modelDocument.documentsUri == null ? null :
                  //                   () async {
                  //                     var imageFile = await triggerImage('selfieImage');
                  //                     if (imageFile != null) {
                  //                       Future.delayed(Duration(seconds: 1), () async {
                  //                         /* Get Value Response And Convert */
                  //                         http.StreamedResponse response = await upLoadImage(imageFile, "upload");
                  //                         response.stream.transform(utf8.decoder).listen((value){
                  //                           resetImage("selfieImage", value);
                  //                         });
                  //                       });
                  //                     }                  
                  //                   }
                  //                 ),
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                        
                  //       /* Issue Date */
                  //       fieldPicker(context, _modelDocument.labelIssueDate, Icons.calendar_today, _modelDocument, triggerDate),

                  //       /* Expire Date */
                  //       fieldPicker(context, _modelDocument.labeExpiredDate, Icons.calendar_today, _modelDocument, triggerDate)
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            )
          ),
        )
      ],
    ),
  );
}
