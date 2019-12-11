import 'dart:io';

class ModelDocument{

  List<dynamic> queryData = [];
  bool isPassportImage = false; bool isSelfieImage = false; bool isProgress = false;
  bool defaultPassportImage = true; bool defaultSelfieImage = true;
  File filePassport; File fileSelfie;
  Map<String, dynamic> fetchEmail;
  String labelIssueDate = "Issue Date", labeExpiredDate = "Expired Date";
  
  String documentTypeId;
  String documentNo;
  String documentsUri;
  String faceUri;
  int issueDate;
  int expireDate;
}