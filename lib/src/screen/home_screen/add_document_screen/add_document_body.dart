/* Flutter Package */
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:wallet_apps/src/model/model_document.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/http_request/rest_api.dart';

Widget bodyWidget(
  BuildContext context,
  Map<String, dynamic> fetchEmail,
  RunMutation runMutation,
  List<dynamic> queryData,
  ModelDocument modelDocument,
  Function setDocumentName,
  bool isPassportImage, bool defaultPassportImage,
  bool isSelfieImage, bool defaultSelfieImage,
  File filePassport,
  File fileSelfie,
  String issueDate, String expiredDate,
  Function triggerImage, Function validatorUser, Function pushReplace, Function popScreen, Function resetImage, Function resetDate,
  Function clickSubmit, Function textChanged
) {
  return Column(
    children: <Widget>[
      /* App Bar */ 
      appBar('Fill Document', popScreen),
      /* Field User Input */
      Expanded(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(size4),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        /* Document No or Number */
                        Flexible(
                          child: textFieldUserInput("Document No.", "#ffffff", Colors.black54, TextInputType.text, textChanged, 0.0, 0.0)
                        ),

                        /* Document Type */ 
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 20.0),
                            child: dropDown("Document Type", null, queryData, null, modelDocument, null, setDocumentName),
                          )
                        )
                      ],
                    ),

                    /* User take a picture */
                    Container(margin: EdgeInsets.only(bottom: 20.0)),
                    Container(
                      padding: EdgeInsets.all(size4),
                      decoration: BoxDecoration(
                        color: black38,
                        border: Border.all(width: size1, color: getHexaColor(borderColor)),
                        borderRadius: BorderRadius.circular(size5)
                      ),
                      child: Row(
                        verticalDirection: VerticalDirection.down,
                        children: <Widget>[
                          /* Display Image On Screen */
                          Flexible(
                            child: Container(
                              width: 240.0,
                              height: 180.0,
                              child: 
                              defaultPassportImage == true ? Image(image: AssetImage('assets/passport.png'),)
                              : isPassportImage == false ? loading() : Image.file(filePassport)
                            ),
                          ),
                          /* Trigger Image */
                          Flexible(
                            flex: 0,
                            child: Container(
                              margin: EdgeInsets.only(left: 5.0),
                              child: RaisedButton(
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.camera_alt),
                                    Container(margin: EdgeInsets.only(left: 5.0, right: 5.0)),
                                    Text("Camera")
                                  ],
                                ),
                                onPressed: () async {
                                  var imageFile = await triggerImage('passPortImage');
                                  if (imageFile != null ) {
                                    await Future.delayed(Duration(seconds: 1), () async {
                                      http.StreamedResponse response = await upLoadImage(imageFile, "uploadoc");
                                      /* Get Value Response And Convert */
                                      response.stream.transform(utf8.decoder).listen((value) async {
                                        Map<String, dynamic> decode = await json.decode(value);
                                        resetImage('passPortImage', decode['url']);
                                      });
                                    });
                                  }
                                }
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    /* User selfies */
                    Container(margin: EdgeInsets.only(bottom: 20.0)),
                    Container(
                      decoration: BoxDecoration(
                        color: black38,
                        border: Border.all(width: size1, color: getHexaColor(borderColor)),
                        borderRadius: BorderRadius.circular(size5)
                      ),
                      child: Row(
                        verticalDirection: VerticalDirection.down,
                        children: <Widget>[
                          /* Profile Image Column */
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(right: 5.0),
                              width: 240.0,
                              height: 180.0,
                              child: 
                              defaultSelfieImage == true ? Image(image: AssetImage('assets/passport_zuman.png'), color: Colors.white,) :
                              isSelfieImage == false ? loading() : Image.file(fileSelfie)
                            ),
                          ),
                          Flexible(
                            flex: 0,
                            child: Container(
                              margin: EdgeInsets.only(left: 5.0),
                              child: RaisedButton(
                                disabledTextColor: Colors.black54, disabledColor: Colors.grey[700],
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.camera_alt),
                                    Container(margin: EdgeInsets.only(left: 5.0, right: 5.0)),
                                    Text("Selfie")
                                  ],
                                ),
                                onPressed: modelDocument.documentsUri == null ? null :
                                () async {
                                  var imageFile = await triggerImage('selfieImage');
                                  if (imageFile != null) {
                                    Future.delayed(Duration(seconds: 1), () async {
                                      /* Get Value Response And Convert */
                                      http.StreamedResponse response = await upLoadImage(imageFile, "uploadoc");
                                      response.stream.transform(utf8.decoder).listen((value){
                                        resetImage("selfieImage", value);
                                      });
                                    });
                                  }                  
                                }
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    
                    /* Issue Date */
                    datePickerNDisplay(context, issueDate, "Issue Date", resetDate, modelDocument),

                    /* Expire Date */
                    datePickerNDisplay(context, expiredDate, "Expired Date", resetDate, modelDocument)
                  ],
                ),
              ),
              /* Submit button */
              FutureBuilder(
                future: validatorUser(),
                builder: (context, snapshot){
                  return lightBlueButton(snapshot, clickSubmit, "Submit", EdgeInsets.only(top: 30.0, right: 20.0, left: 20.0), runMutation);
                },
              )
            ],
          )
        ),
      )
    ],
  );
}
