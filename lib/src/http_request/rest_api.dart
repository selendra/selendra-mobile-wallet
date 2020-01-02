import 'dart:io';
import 'package:wallet_apps/src/model/model_invoice.dart';
import 'package:wallet_apps/src/bloc/bloc_provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as _http;
import 'dart:convert';
import 'dart:async';

import 'package:wallet_apps/src/model/model_scan_invoice.dart';

/* Zeetomic api user data*/
final _url = "https://testnet-api.zeetomic.com/pub/v1";

/* Zeetomic api image upload */
final _urlPostImage = "https://s3.zeetomic.com";

/* Zeetomic OCR */
final _urlOCR = "https://zocr.zeetomic.com/pushimage";

Map<String, String> _conceteHeader(String _key, String _value) { /* Concete More Content Of Header */
  return _key != null ? 
    {"Content-Type": "application/json; charset=utf-8", _key: _value} : /* if Parameter != Null = Concete Header With  */
    {"Content-Type": "application/json; charset=utf-8"} ; /* if Parameter Null = Don't integrate */
}

/* Rest Api Property */
Map<String, dynamic> _token;
_http.Response _response; 
String _bodyEncode;

/* --------------------------------Post Request-------------------------------- */

Future<Map<String, dynamic>> userLogin(String _byEmailOrPhoneNums, String _passwords, String _endpoints, String _schema) async { /* User Login */
  _bodyEncode = json.encode( /* Convert to Json String */
    {
      _schema: _byEmailOrPhoneNums, 
      "password": _passwords
    }
  );
  _response = await _http.post(
    '$_url$_endpoints', 
    headers: _conceteHeader(null, null),
    body: _bodyEncode
  );
  return json.decode(_response.body);
}

/* User Regiser */
Future<Map<String, dynamic>> userRegister(String _byEmailOrPhoneNums, String _passwords, String _endpoints, String _schema) async {
  _bodyEncode = json.encode( /* Convert to Json Data ( String ) */
    {
      _schema: _byEmailOrPhoneNums, 
      "password": _passwords
    }
  );
  _response = await _http.post(
    '$_url$_endpoints', 
    headers: _conceteHeader(null, null),
    body: _bodyEncode
  );
  return json.decode(_response.body);
}

Future<Map<String, dynamic>> uploadUserProfile(dynamic _model, String _endpoints) async { /* Post User Information */
  _token = await Provider.fetchToken();
  _bodyEncode = json.encode({
    "first-name": _model.controlFirstName.text,
    "mid-name": _model.controlMidName.text,
    "last-name": _model.controlLastName.text,
    "gender": _model.gender
  });
  if (_token != null){
    _response = await _http.post(
      "$_url/userprofile",
      headers: _conceteHeader("authorization", "Bearer ${_token["token"]}"),
      body: _bodyEncode
    );
    return json.decode(_response.body);
  }
  return null;
}

Future<Map<String, dynamic>> retrieveWallet(String _pins) async { /* Post Get Wallet */
  _token = await Provider.fetchToken();
  _bodyEncode = json.encode({
    "pin": _pins
  });
  if (_token != null){
    _response = await _http.post(
      "$_url/getwallet",
      headers: _conceteHeader("authorization", "Bearer ${_token["token"]}"),
      body: _bodyEncode
    );
    return json.decode(_response.body);
  }
  return null;
}

Future<Map<String, dynamic>> addAsset(dynamic _model) async { /* Add New Asset */
  _token = await Provider.fetchToken();
  _bodyEncode = json.encode({
    "asset-code": _model.controlAssetCode.text,
    "asset-ssuer": _model.controlAssetIssuer.text
  });
  if (_token != null){
    _response = await _http.post(
      "$_url/userprofile",
      headers: _conceteHeader("authorization", "Bearer ${_token['token']}"),
      body: _bodyEncode
    );
    return json.decode(_response.body);
  }
  return null;
}

Future<Map<String, dynamic>> sendPayment(dynamic _model) async { /* QR Code Send Request */
  _token = await Provider.fetchToken();
  _bodyEncode = json.encode({
    "asset-code": _model.controlAssetCode.text,
    "destination": _model.controlDestination.text,
    "amount": _model.controlAmount.text,
    "memo": _model.controlMemo.text
  });
  if (_token != null){
    _response = await _http.post(
      "$_url/sendpayment",
      headers: _conceteHeader("authorization", "Bearer ${_token['token']}"),
      body: _bodyEncode
    );
    return json.decode(_response.body);
  }
  return null;
}

Future<Map<String, dynamic>> addMerchant(dynamic _model) async { /* Add New Merchant */
  _token = await Provider.fetchToken();
  _bodyEncode = json.encode({
    "asset-code": _model.controlAssetCode.text,
    "destination": _model.controlDestination.text,
    "amount": _model.controlAmount.text,
    "memo": _model.controlMemo.text
  });
  if (_token != null){
    _response = await _http.post(
      "$_url/sendpayment",
      headers: _conceteHeader("authorization", "Bearer ${_token['token']}"),
      body: _bodyEncode
    );
    return json.decode(_response.body);
  }
  return null;
}

Future<Map<String, dynamic>> addReceipt(ModelScanInvoice _modelScanInvoice) async {
  _bodyEncode = json.encode({
    "receipt_no": _modelScanInvoice.controlBillNO.text,
    "amount": _modelScanInvoice.controlAmount.text,
    "location": _modelScanInvoice.controlLocation.text,
    "approval_code": _modelScanInvoice.controlApproveCode.text
  });
  _token = await Provider.fetchToken();
  if (_token != null) {
    _response = await _http.post(
      "$_url/addreceipt",
      headers: _conceteHeader("authorization", "Bearer ${_token['token']}"),
      body: _bodyEncode
    );
    print(_response.body);
    return json.decode(_response.body);
  }
  return null;
}

/* --------------------------------Get Request------------------------------------ */

Future<Map<String, dynamic>> getUserProfile() async { /* Get User Profile */
  _token = await Provider.fetchToken();
  if (_token != null){
    _response = await _http.get(
      "$_url/userprofile",
      headers: _conceteHeader("authorization", "Bearer ${_token['token']}")
    );
    return json.decode(_response.body);
  }
  return null;
}

Future<int> checkExpiredToken() async {
  _token = await Provider.fetchToken();
  if (_token != null){
    _response = await _http.get(
      "$_url/userprofile",
      headers: _conceteHeader("authorization", "Bearer ${_token['token']}")
    );
    print(_response.statusCode);
    return _response.statusCode;
  }
  return null;
}

Future<Map<String, dynamic>> accountConfirmation(dynamic _model) async { /* Add New Asset */
  // _token = await Provider.fetchToken();
  // _bodyEncode = json.encode({
  //   "asset-code": _model.controlAssetCode.text,
  //   "asset-ssuer": _model.controlAssetIssuer.text
  // });
  // if (_token != null){
  //   _response = await _http.post(
  //     "$_url/userprofile",
  //     headers: _conceteHeader("authorization", "Bearer ${_token['_token']}"),
  //     body: _bodyEncode
  //   );
  //   return json.decode(_response.body);
  // }
  // return null;
}

/* User History */
Future trxUserHistory() async {
  _token = await Provider.fetchToken();
  if (_token != null){
    _response = await _http.get(
      "$_url/trx-history", 
      headers: _conceteHeader("authorization", "Bearer ${_token['token']}")
    );
    return json.decode(_response.body);
  }
  return null;
}

Future getPortfolio() async { /* User Porfolio */
  _token = await Provider.fetchToken();
  if (_token != null){
    _response = await _http.get(
      "$_url/portforlio", 
      headers: _conceteHeader("authorization", "Bearer ${_token['token']}")
    );
    return json.decode(_response.body);
  }
  return null;
}

Future getAllBranches() async {
  _token = await Provider.fetchToken();
  if (_token != null) {
    _response = await _http.get(
      "$_url/get-all-branches",
      headers: _conceteHeader("authorization", "Bearer ${_token['token']}")
    );
    return json.decode(_response.body);
  }
  return null;
}
/*--------------------------------Receipt Transaction--------------------------------*/

/* List Branches */
Future<List<dynamic>> listBranches() async {
  _token = await Provider.fetchToken();
  if (_token != null) {
    _response = await _http.get('$_url/listBranches', headers: {HttpHeaders.authorizationHeader: "Bearer ${_token['TOKEN']}"});
    var data = json.decode(_response.body);
    return data['message'];
  }
  return null;
}

// Future<Map<String, dynamic>> submitInvoice(ModelInvoice _model) async { /* Confirm Receipt */
//   _token = await Provider.fetchToken();
//   if (_token != null){
//     _response = await _http.post(
//       "$_url/confirmreceipt",
//       headers: {
//         HttpHeaders.authorizationHeader: "Bearer ${_token['TOKEN']}"
//       },
//       body: _model.bodyReceipt(_model)
//     );
//     return json.decode(_response.body);
//   }
//   return null;
// }

Future<_http.StreamedResponse> upLoadImage(File image, String endpoint) async { /* Upload image to server by use multi part form*/
  _token = await Provider.fetchToken();
  /* Compress image file */
  List<int> compressImage = await FlutterImageCompress.compressWithFile(
    image.path,
    minHeight: 1300,
    minWidth: 1000,
    quality: 100,
  );
  /* Make request */
  var request = new _http.MultipartRequest('POST', Uri.parse('$_urlPostImage/$endpoint'));
  /* Make Form of Multipart */
  var multipartFile = new _http.MultipartFile.fromBytes(
    'file',
    compressImage,
    filename: 'image_picker.jpg',
    contentType: MediaType.parse('image/jpeg'),
  );
  /* Concate Token With Header */
  request.headers.addAll(_conceteHeader("Authorization", "Bearer ${_token['TOKEN']}"));
  request.files.add(multipartFile);
  /* Start send to server */
  var response = await request.send();
  /* Getting response */
  // response.stream.transform(utf8.decoder).listen((data){
  //   print(data);
  // });
  return response;
}

/* OCR Image */
Future ocrImage (String imageuri) async {
  // "https://i.ibb.co/r69pMmx/ocr.png"
  Map<String, dynamic> bodys = {
    "imguri": imageuri,
    "amount":"Grand Total(\$)", 
    "trxdate":"Bill Date"
  };
  final response = await _http.post(_urlOCR, body: bodys);
}

