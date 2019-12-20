/* Flutter Package */
import 'dart:io';
import 'package:flutter/material.dart';
/* Directory of file*/
import 'package:wallet_apps/src/model/model_user_info.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';

Widget addUserInfobodyWidget(
  BuildContext context, 
  List<String> genderList,
  ModelUserInfo _modelUserInfo,
  Function triggerImage,
  Function resetGender, Function validatorProfileUser, 
  Function resetImage, Function textChanged, Function clickNext, Function popScreen
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
              containerTitleAppBar("Add Assets")
            ],
          )
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(bottom: 12.0, left: 27.0, right: 27.0, top: 27.0),
              child: Column(
                children: <Widget>[
                  Container( /* Occupation Field */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: inputField(
                      _modelUserInfo.bloc, 
                      context,
                      "Occupation", null, "addUserInfoScreen",
                      false, 
                      TextInputType.text, TextInputAction.next,
                      _modelUserInfo.controlOccupation,
                      _modelUserInfo.nodeOccupatioin,
                      null, null
                    ),
                  ),
                  Container( /* Nationality Screen */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: inputField(
                      _modelUserInfo.bloc, 
                      context,
                      "Nationality", null, "addUserInfoScreen",
                      false, 
                      TextInputType.text, TextInputAction.done,
                      _modelUserInfo.controlNationality,
                      _modelUserInfo.nodeNationality,
                      null, null
                    ),
                  ),
                  Container( /* Country */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: fieldPicker(context, "Country", "addUserInfoScreen", Icons.search, _modelUserInfo, null),
                  ),
                  Container( /* Upload porfile picture */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: fieldPicker(context, "Upload profile picture", "addUserInfoScreen", Icons.camera_alt, _modelUserInfo, triggerImage),
                  ),
                  _modelUserInfo.file != null ? Container( /* Image Display */
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: Image.file(_modelUserInfo.file),
                  ) : Container(),
                  flatCustomButton( /* Next Button */
                    _modelUserInfo.bloc, 
                    context, 
                    "Next", "addUserInfoScreen", blueColor,
                    FontWeight.normal,
                    size18,
                    EdgeInsets.only(top: 15.0),
                    EdgeInsets.only(top: size15, bottom: size15),
                    BoxShadow(
                      color: Color.fromRGBO(0,0,0,0.54),
                      blurRadius: 5.0
                    ),
                    null
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
  // Center(
  //   child: SingleChildScrollView(
  //     physics: BouncingScrollPhysics(),
  //     child: Container(
  //       padding: EdgeInsets.all(size4),
  //       child: Column(
  //         children: <Widget>[
  //           /* First Name Field */
  //           textFieldUserInput("First name", "#ffffff", Colors.black54, TextInputType.text, textChanged, 20.0, 0),

  //           /* Mid Name Field */
  //           textFieldUserInput("Mid name", "#ffffff", Colors.black54, TextInputType.text, textChanged, 20.0, 0),

  //           /* Last Name */
  //           textFieldUserInput("Last name", "#ffffff", Colors.black54, TextInputType.text, textChanged, 20.0, 0),

  //           /* Description */
  //           textFieldUserInput("Description", "#ffffff", Colors.black54, TextInputType.text, textChanged, 20.0, 0),

  //           /* Image Upload */
  //           Row(
  //             verticalDirection: VerticalDirection.down,
  //             children: <Widget>[
  //               /* Profile Image Column */
  //               Flexible(
  //                 child: Container(
  //                   margin: EdgeInsets.only(right: 5.0),
  //                   width: 240.0,
  //                   height: 180.0,
  //                   child: 
  //                   isUploading == false ? Image(image: AssetImage('assets/gallery.png')) :
  //                   isImage == false ? loading() :
  //                   Image.file(file)
  //                 ),
  //               ),
  //               Flexible(
  //                 flex: 0,
  //                 child: Container(
  //                   margin: EdgeInsets.only(left: 5.0),
  //                   child: RaisedButton(
  //                     child: Text("Image gallery"),
  //                     onPressed: () async {
  //                       /* image variable from rest_api file */
  //                       var images = await triggerImage();
  //                       if (images != null) {
  //                         Future.delayed(Duration(seconds: 1), () async {
  //                           http.StreamedResponse response = await upLoadImage(images, "upload");
  //                           /* Get Response After Upload Image */
  //                           response.stream.transform(utf8.decoder).listen((value) async{
  //                             Map<String, dynamic> decode = await json.decode(value);
  //                             resetImage(decode['url']);
  //                           });
  //                         });
  //                       }
  //                     }
  //                   ),
  //                 ),
  //               )
  //             ],
  //           ),

  //           /* Occupation N Gender Field */
  //           Container(margin: EdgeInsets.only(bottom: 20.0)),
  //           Row(
  //             mainAxisSize: MainAxisSize.max,
  //             children: <Widget>[
  //               /* Occupation */
  //               Expanded(
  //                 child: textFieldUserInput("Occupation", "#ffffff", Colors.black54, TextInputType.text, textChanged, 0, 0),
  //               ),
  //               /* Gender Column */
  //               Expanded(
  //                 child: Container(
  //                   margin: EdgeInsets.only(left: 20.0),
  //                   child: dropDown("Gender", genderList, null, modelProfile, null, resetGender, null)
  //                 ),  
  //               ),
  //             ],
  //           ),
            
  //           /* Nationality N Country */
  //           Container(margin: EdgeInsets.only(top: 20.0),),
  //           Row(
  //             children: <Widget>[
  //               Expanded( 
  //                 child: textFieldUserInput("Nationality", "#ffffff", Colors.black54, TextInputType.text, textChanged, 0, 0),
  //               ),
  //               Expanded(
  //                 child: textFieldUserInput("Country", "#ffffff", Colors.black54, TextInputType.text, textChanged, 0, 20.0),
  //               )
  //             ],
  //           ),
            
  //           /* City Field */
  //           Container(margin: EdgeInsets.only(top: 20.0),),
  //           textFieldUserInput("City", "#ffffff", Colors.black54, TextInputType.text, textChanged, 20.0, 0),

  //           /* CountryCode And Phone Number Field */
  //           Row(
  //             children: <Widget>[
  //               Expanded(
  //                 child: textFieldUserInput("CountryCode", "#ffffff", Colors.black54, TextInputType.number, textChanged, 0, 0)
  //               ),
  //               Expanded(
  //                 child: textFieldUserInput("PhoneNumber", "#ffffff", Colors.black54, TextInputType.number, textChanged, 0, 20.0),
  //               )
  //             ],
  //           ),

  //           /* Address Field */
  //           Container(margin: EdgeInsets.only(top: 20.0),),
  //           textFieldUserInput("Address", "#ffffff", Colors.black54, TextInputType.text, textChanged, 20.0, 0),

  //           /* Building Number N PostalCode */
  //           Row(
  //             children: <Widget>[
  //               Expanded( 
  //                 child: textFieldUserInput("Building number", "#ffffff", Colors.black54, TextInputType.number, textChanged, 0, 0),
  //               ),
  //               Expanded(
  //                 child: textFieldUserInput("Postal code", "#ffffff", Colors.black54, TextInputType.number, textChanged, 0.0, 20.0)
  //               )
  //             ],
  //           ),

  //           FutureBuilder(
  //             future: validatorProfileUser(),
  //             builder: (context, snapshot){
  //               return lightBlueButton(snapshot, clickNext, "Next", EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0), runMutation);
  //             },
  //           )
  //         ]
  //       ),
  //     ),
  //   )
  // );
}