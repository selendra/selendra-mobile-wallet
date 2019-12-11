import 'dart:async';
import 'dart:io';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:wallet_apps/src/store_small_data/data_store.dart';
import 'package:flutter/material.dart';
import 'package:wallet_apps/src/graphql/services/query_document.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/graphql/services/mutation_document.dart';
import 'package:wallet_apps/src/model/model_document.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/profile_user.dart';
import 'package:intl/intl.dart';
import './add_document_body.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AddDocument extends StatefulWidget{

  
  @override
  State<StatefulWidget> createState() {
    return AddDocumentState();
  }
}

class AddDocumentState extends State<AddDocument> {
  
  /* Variable */
  ModelDocument _modelDocument = ModelDocument();
  List<dynamic> queryData = [];
  bool isPassportImage = false; bool isSelfieImage = false; bool isProgress = false;
  bool defaultPassportImage = true; bool defaultSelfieImage = true;
  File filePassport; File fileSelfie;
  Map<String, dynamic> fetchEmail;
  String issueDate = "Issue Date", expiredDate = "Expired Date";

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

  void trickerDate(String labelText) {
    DatePicker.showDatePicker(
      context, 
      showTitleActions: true,
      minTime: DateTime(2000, 1, 1),
      maxTime: DateTime(2050, 1, 1),
      onChanged: (date){ },
      onConfirm: (data){
        resetDate(data, labelText);
        if (labelText == "Issue Date") _modelDocument.issueDate = data.millisecondsSinceEpoch;
        else _modelDocument.expireDate = data.millisecondsSinceEpoch;
      }
    );
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
      _modelDocument.documentTypeId = id;
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
        _modelDocument.documentsUri = imageUrl;
      } else if (imageNameToReset == "selfieImage"){
        isSelfieImage = true;
        _modelDocument.faceUri = imageUrl;
      }
    });
  }

  /* Verify or Validate User */
  Future<bool> validatorUser() async {
    bool isTrue;
    if ( 
      _modelDocument.documentNo != null && _modelDocument.documentNo != "" &&
      _modelDocument.documentTypeId != null && _modelDocument.documentTypeId != "" &&
      _modelDocument.documentsUri != null && _modelDocument.documentsUri != "" &&
      _modelDocument.faceUri != null && _modelDocument.faceUri != "" &&
      _modelDocument.issueDate != null &&
      _modelDocument.expireDate != null
    ){
      isTrue = true;
    } 
    return isTrue;
  }

  void clickSubmit(RunMutation runMutation) async {
    /* Loading */
    dialogLoading(context);
    runMutation({
      'emails': fetchEmail['email'] != null ? fetchEmail['email'] : '',
      'document_noes': _modelDocument.documentNo,
      'documenttype_ids': _modelDocument.documentTypeId,
      'documents_uris': _modelDocument.documentsUri,
      'face_uris': _modelDocument.faceUri,
      'issue_dates': _modelDocument.issueDate.toString(),
      'expire_dates': _modelDocument.expireDate.toString()
    });
  }

  void textChanged(String label, String changed) {
    _modelDocument.documentNo = changed;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getHexaColor(backgroundColor),
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
                  bodyWidget(context, fetchEmail, runMutation, queryData, _modelDocument, setDocumentName, isPassportImage, defaultPassportImage , isSelfieImage , defaultSelfieImage, filePassport, fileSelfie, issueDate, expiredDate, triggerImage, validatorUser, pushReplace, popScreen, resetImage, resetDate, clickSubmit, textChanged),
                ],
              );
            },
            update: (Cache cache, QueryResult result) async {
              /* Pop Loading */
              await Future.delayed(Duration(milliseconds: 800), () => Navigator.pop(context));
              /* Push Profile Screen */
              if (result.data['addDocuments']['id'] != null) {
                await dialog(context, Text("You have successfully add document !"), Icon(Icons.done_outline));
                Navigator.pushNamed(context, '/profileScreen');
              }
            },
            onCompleted: (dynamic resultData) {
            },
          );
        },
      ),
    );
  }
}