import 'package:wallet_apps/index.dart';

class ModelDocument{
  
  final formStateDocument = GlobalKey<FormState>();

  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  List<dynamic> queryData = [];
  bool isPassportImage = false; bool isSelfieImage = false; bool isProgress = false;
  bool defaultPassportImage = true; bool defaultSelfieImage = true;
  File filePassport; File fileSelfie;
  Map<String, dynamic> fetchEmail; Map<String, dynamic> userInfo;
  String labelIssueDate = "Issue Date", labeExpiredDate = "Expired Date";
  
  TextEditingController controllerDocsType = TextEditingController(text: "");
  TextEditingController controllerDocsNumber = TextEditingController(text: "");
  
  FocusNode nodeDocsType = FocusNode();
  FocusNode nodeDocsNumber = FocusNode();

  String documentTypeId;
  String documentNo;
  String documentsUri;
  String faceUri;
  int issueDate;
  int expireDate;
}