/* Flutter package */
import 'dart:async';
import 'dart:io';
import 'package:Wallet_Apps/src/Provider/Hexa_Color_Convert.dart';
import 'package:Wallet_Apps/src/Store_Small_Data/Data_Storage.dart';
import 'package:flutter/material.dart';
import 'package:Wallet_Apps/src/Graphql_Service/Query_Document.dart';
/* Directory of file */
import 'package:Wallet_Apps/src/Provider/Reuse_Widget.dart';
import 'package:Wallet_Apps/src/Graphql_Service/Mutation_Document.dart';
import 'package:Wallet_Apps/src/Model/Model_Document.dart';
import 'package:Wallet_Apps/src/Screen/HomeScreen/Profile/ProfileUserWidget.dart';
import 'package:intl/intl.dart';
import './AddDocumentBody.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AddDocumentWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AddDocumentState();
  }
}

class AddDocumentState extends State<AddDocumentWidget> {
  
  /* Variable */
  ModelDocument modelDocument = ModelDocument();
  List<dynamic> queryData = [];
  bool isPassportImage = false; bool isSelfieImage = false; bool isProgress = false;
  bool defaultPassportImage = true; bool defaultSelfieImage = true;
  File filePassport; File fileSelfie;
  Map<String, dynamic> fetchEmail;
  String issueDate = "DD-MM-YYYY", expiredDate = "DD-MM-YYYY";

  @override
  void initState() {
    fetchUser();
    super.initState();
  }

  /* Pop Screen in Drawer Widget*/
  void popScreen() => Navigator.of(context).pop();

  /* fetch data user login */
  fetchUser() async {
    Map<String, dynamic> data = await fetchData('userDataLogin');
    fetchEmail = data['queryUserById'];
    setState(() {});
  }

  void pushReplace() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileUserWidget()));
  }

  /* Reset Date For Display */
  void resetDate(DateTime date, String nameSpotPicker) {
    setState(() {
      if (nameSpotPicker == "Issue Date") issueDate = DateFormat('yyyy-MM-dd').format(date);
      else expiredDate = DateFormat('yyyy-MM-dd').format(date);
    });
  }

  /* Set Document Name */
  void setDocumentName(String id) {
    setState(() {
      modelDocument.documentTypeId = id;
    });
  }

  /* Trigger image */
  triggerImage(String imageType) async {
    var imageFile = await camera();
    setState(() {
      if (imageType == "passPortImage") {
        defaultPassportImage = false;
        isPassportImage = false;
      } else if (imageType == "selfieImage") {
        defaultSelfieImage = false;
        isSelfieImage = false;
      }
    });
    if (imageFile != null) {
      setState(() {
        /* Check Image Type */
        if (imageType == "passPortImage") {
          /* Set image for display on screen */
          filePassport = imageFile;
        } else if (imageType == "selfieImage") {
          /* Set image for display on screen */
          fileSelfie = imageFile;
        }
      });
    } else {
      setState(() {
        /* If User Not Take A Picture. Stay Default Image */
        if (imageType == "passPortImage" && filePassport == null) {
          defaultPassportImage = true;
        } else if (imageType == "selfieImage" && fileSelfie == null) {
          defaultSelfieImage = true;
        }
        /* If User Not Take A Picture But Have Already Take A Picture Last Time. Stay With Picture Last Time */
        if (imageType == "passPortImage" && filePassport != null) {
          isPassportImage = true;
        } else if (imageType == "selfieImage" && fileSelfie != null) {
          isSelfieImage = true;
        }
      });
    }
    return imageFile;
  }

  void resetImage(String imageNameToReset, String imageUrl){
    setState(() {
      if (imageNameToReset == "passPortImage") {
        isPassportImage = true;
        modelDocument.documentsUri = imageUrl;
      } else if (imageNameToReset == "selfieImage"){
        isSelfieImage = true;
        modelDocument.faceUri = imageUrl;
      }
    });
  }

  /* Verify or Validate User */
  Future<bool> validatorUser() async {
    bool isTrue;
    if ( 
      modelDocument.documentNo != null && modelDocument.documentNo != "" &&
      modelDocument.documentTypeId != null && modelDocument.documentTypeId != "" &&
      modelDocument.documentsUri != null && modelDocument.documentsUri != "" &&
      modelDocument.faceUri != null && modelDocument.faceUri != "" &&
      modelDocument.issueDate != null &&
      modelDocument.expireDate != null
    ){
      isTrue = true;
    } 
    return isTrue;
  }

  void clickSubmit(RunMutation runMutation) async {
    setState(() {
      isProgress = true;
    });
    runMutation({
      'emails': fetchEmail['email'] != null ? fetchEmail['email'] : '',
      'document_noes': modelDocument.documentNo,
      'documenttype_ids': modelDocument.documentTypeId,
      'documents_uris': modelDocument.documentsUri,
      'face_uris': modelDocument.faceUri,
      'issue_dates': modelDocument.issueDate.toString(),
      'expire_dates': modelDocument.expireDate.toString()
    });
  }

  void textChanged(String label, String changed) {
    modelDocument.documentNo = changed;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(convertHexaColor(backgroundColor)),
      body: Query(
        options: QueryOptions(document: queryAllDocument),
        builder: (QueryResult result, {VoidCallback refetch}){
          if ( result.data != null) {
            queryData = result.data['queryAllDocumentsType'];
          }
          /* Mutation */
          return Mutation(
            options: MutationOptions(document: addDocument),
            builder: (RunMutation runMutation, QueryResult result) {
              return Stack(
                children: <Widget>[
                  bodyWidget(context, fetchEmail, runMutation, queryData, modelDocument, setDocumentName, isPassportImage, defaultPassportImage , isSelfieImage , defaultSelfieImage, filePassport, fileSelfie, issueDate, expiredDate, triggerImage, validatorUser, pushReplace, popScreen, resetImage, resetDate, clickSubmit, textChanged),
                  isProgress == false ? Container() : loading()
                ],
              );
            },
            update: (Cache cache, QueryResult result) async {
              setState(() {
                isProgress = false;
              });
              if (result.data['addDocuments']['id'] != null) {
                await dialog(context, Text("You have successfully add document !"), Icon(Icons.done_outline));
                Navigator.pushNamed(context, '/profileScreen');
              }
              print(result.data);
            },
            onCompleted: (dynamic resultData) {
            },
          );
        },
      ),
    );
  }
}