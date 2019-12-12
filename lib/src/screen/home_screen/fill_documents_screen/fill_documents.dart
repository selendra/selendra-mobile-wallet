import 'dart:async';
import 'dart:io';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:wallet_apps/src/screen/home_screen/fill_documents_screen/take_selfie_screen/take_selfie.dart';
import 'package:wallet_apps/src/screen/home_screen/fill_documents_screen/upload_documents_screen/upload_documents.dart';
import 'package:wallet_apps/src/store_small_data/data_store.dart';
import 'package:flutter/material.dart';
import 'package:wallet_apps/src/graphql/services/query_document.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/graphql/services/mutation_document.dart';
import 'package:wallet_apps/src/model/model_document.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/profile_user.dart';
import 'package:intl/intl.dart';
import './fill_documents_body.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AddDocuments extends StatefulWidget{

  
  @override
  State<StatefulWidget> createState() {
    return AddDocumentsState();
  }
}

class AddDocumentsState extends State<AddDocuments> {

  ModelDocument _modelDocument = ModelDocument();

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
    _modelDocument.fetchEmail = data['queryUserById'];
    setState(() {});
  }

  void pushReplace() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileUserWidget()));
  }

  void triggerDate(String labelText) {
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
  void resetDate(DateTime date, String label) {
    setState(() {
      if (label == "Issue Date") _modelDocument.labelIssueDate = DateFormat('yyyy-MM-dd').format(date);
      else _modelDocument.labeExpiredDate = DateFormat('yyyy-MM-dd').format(date);
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
        _modelDocument.defaultPassportImage = false;
        _modelDocument.isPassportImage = false;
      } else if (imageType == "selfieImage") {
        _modelDocument.defaultSelfieImage = false;
        _modelDocument.isSelfieImage = false;
      }
    });
    if (imageFile != null) {
      setState(() {
        /* Check Image Type */
        if (imageType == "passPortImage") {
          /* Set image for display on screen */
          _modelDocument.filePassport = imageFile;
        } else if (imageType == "selfieImage") {
          /* Set image for display on screen */
          _modelDocument.fileSelfie = imageFile;
        }
      });
    } else {
      setState(() {
        /* If User Not Take A Picture. Stay Default Image */
        if (imageType == "passPortImage" && _modelDocument.filePassport == null) {
          _modelDocument.defaultPassportImage = true;
        } else if (imageType == "selfieImage" && _modelDocument.fileSelfie == null) {
          _modelDocument.defaultSelfieImage = true;
        }
        /* If User Not Take A Picture But Have Already Take A Picture Last Time. Stay With Picture Last Time */
        if (imageType == "passPortImage" && _modelDocument.filePassport != null) {
          _modelDocument.isPassportImage = true;
        } else if (imageType == "selfieImage" && _modelDocument.fileSelfie != null) {
          _modelDocument.isSelfieImage = true;
        }
      });
    }
    return imageFile;
  }

  void resetImage(String imageNameToReset, String imageUrl){
    setState(() {
      if (imageNameToReset == "passPortImage") {
        _modelDocument.isPassportImage = true;
        _modelDocument.documentsUri = imageUrl;
      } else if (imageNameToReset == "selfieImage"){
        _modelDocument.isSelfieImage = true;
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
      'emails': _modelDocument.fetchEmail['email'] != null ? _modelDocument.fetchEmail['email'] : '',
      'document_noes': _modelDocument.documentNo,
      'documenttype_ids': _modelDocument.documentTypeId,
      'documents_uris': _modelDocument.documentsUri,
      'face_uris': _modelDocument.faceUri,
      'issue_dates': _modelDocument.issueDate.toString(),
      'expire_dates': _modelDocument.expireDate.toString()
    });
  }

  void textChanged(String label, String changed) {
    if (label == "Document type") _modelDocument.documentTypeId = changed;
    else _modelDocument.documentNo = changed;
  }

  void navigatePage(String label) {
    if ( label == "Upload documents" ) Navigator.push(context, MaterialPageRoute(builder: (context) => UploadDocuments(_modelDocument) ));
    else Navigator.push(context, MaterialPageRoute(builder: (context) => TakeSelfie(_modelDocument) ));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getHexaColor(backgroundColor),
      body: Query(
        options: QueryOptions(document: queryAllDocument),
        builder: (QueryResult result, {VoidCallback refetch}){
          if ( result.data != null) {
            _modelDocument.queryData = result.data['queryAllDocumentsType'];
          }
          /* Mutation */
          return Mutation(
            options: MutationOptions(document: addDocument),
            builder: (RunMutation runMutation, QueryResult result) {
              return Stack(
                children: <Widget>[
                  bodyWidget(
                    context,  
                    runMutation, 
                    _modelDocument, 
                    setDocumentName, 
                    triggerImage, validatorUser, pushReplace, popScreen, 
                    triggerDate, resetDate, clickSubmit, textChanged,
                    navigatePage
                  ),
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