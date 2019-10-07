/* Flutter Package */
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
/* Directory of file*/
import 'package:Wallet_Apps/src/Rest_Api/Rest_Api.dart';
import 'package:Wallet_Apps/src/Model/Model_Profile.dart';
import 'package:Wallet_Apps/src/Provider/Reuse_Widget.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

Widget bodyWidget(
  RunMutation runMutation, 
  List<String> genderList,
  Map<String, dynamic> fetchEmail, 
  ModelProfile modelProfile,
  File file,
  Function triggerImage,
  bool isImage, bool isUploading,
  Function resetGender, Function validatorProfileUser, 
  Function resetImage, textChanged, clickNext
  ) {
  return Center(
    child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        padding: EdgeInsets.all(margin4),
        child: Column(
          children: <Widget>[
            /* First Name Field */
            textFieldAddProfile("First name", textChanged, 20.0, 0),

            /* Mid Name Field */
            textFieldAddProfile("Mid name", textChanged, 20.0, 0),

            /* Last Name */
            textFieldAddProfile("Last name", textChanged, 20.0, 0),

            /* Description */
            textFieldAddProfile("Description", textChanged, 20.0, 0),

            /* Image Upload */
            Row(
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                /* Profile Image Column */
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(right: 5.0),
                    width: 240.0,
                    height: 180.0,
                    child: 
                    isUploading == false ? Image(image: AssetImage('assets/gallery.png')) :
                    isImage == false ? loading() :
                    Image.file(file)
                  ),
                ),
                Flexible(
                  flex: 0,
                  child: Container(
                    margin: EdgeInsets.only(left: 5.0),
                    child: RaisedButton(
                      child: Text("Image gallery"),
                      onPressed: () async {
                        /* image variable from rest_api file */
                        var images = await triggerImage();
                        if (images != null) {
                          Future.delayed(Duration(seconds: 1), () async {
                            http.StreamedResponse response = await upLoadImage(images);
                            /* Get Response After Upload Image */
                            response.stream.transform(utf8.decoder).listen((value) async{
                              Map<String, dynamic> decode = await json.decode(value);
                              resetImage(decode['url']);
                            });
                          });
                        }
                      }
                    ),
                  ),
                )
              ],
            ),

            /* Occupation N Gender Field */
            Container(margin: EdgeInsets.only(bottom: 20.0)),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                /* Occupation */
                Expanded(
                  child: textFieldAddProfile("Occupation", textChanged, 0, 0),
                ),
                /* Gender Column */
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: dropDown("Gender", genderList, null, modelProfile, null, resetGender, null)
                  ),  
                ),
              ],
            ),
            
            /* Nationality N Country */
            Container(margin: EdgeInsets.only(top: 20.0),),
            Row(
              children: <Widget>[
                Expanded( 
                  child: textFieldAddProfile("Nationality", textChanged, 0, 0),
                ),
                Expanded(
                  child: textFieldAddProfile("Country", textChanged, 0, 20.0),
                )
              ],
            ),
            
            /* City Field */
            Container(margin: EdgeInsets.only(top: 20.0),),
            textFieldAddProfile("City", textChanged, 20.0, 0),

            /* CountryCode And Phone Number Field */
            Row(
              children: <Widget>[
                Expanded(
                  child: textFieldAddProfile("CountryCode", textChanged, 0, 0)
                ),
                Expanded(
                  child: textFieldAddProfile("PhoneNumber", textChanged, 0, 20.0),
                )
              ],
            ),

            /* Address Field */
            Container(margin: EdgeInsets.only(top: 20.0),),
            textFieldAddProfile("Address", textChanged, 20.0, 0),

            /* Building Number N PostalCode */
            Row(
              children: <Widget>[
                Expanded( 
                  child: textFieldAddProfile("Building number", textChanged, 0, 0),
                ),
                Expanded(
                  child: textFieldAddProfile("Postal code", textChanged, 0.0, 20.0)
                )
              ],
            ),

            FutureBuilder(
              future: validatorProfileUser(),
              builder: (context, snapshot){
                return lightBlueButton(snapshot, clickNext, "Next", EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0), runMutation);
              },
            )
          ]
        ),
      ),
    )
  );
}