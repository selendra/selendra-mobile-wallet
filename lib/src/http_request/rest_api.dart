import 'dart:io';
import 'package:wallet_apps/src/model/model_invoice.dart';
import 'package:wallet_apps/src/bloc/bloc_provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

/* Zeetomic api user data*/
final _url = "https://testnet-api.zeetomic.com";

/* Zeetomic api image upload */
final _urlPostImage = "https://s3.zeetomic.com";

/* Zeetomic OCR */
final _urlOCR = "https://zocr.zeetomic.com/pushimage";

Map<String, String> headers = {"Content-Type": "application/json; charset=utf-8"};

/* User Login */
Future<Map<String, dynamic>> userLogin(String byEmailOrPhoneNums, String passwords, String endpoints) async {
  String encode = json.encode( /* Convert to Json Data ( String ) */
    {
      "email": byEmailOrPhoneNums, 
      "password": passwords
    }
  );
  final response = await http.post(
    '$_url/pub/v1/$endpoints', 
    headers: {"Content-Type": "application/json; charset=utf-8"},
    body: encode
  );
  return json.decode(response.body);
}

/* User Regiser */
Future<Map<String, dynamic>> userRegister(String byEmailOrPhoneNums, String passwords, String endpoints) async {
  String encode = json.encode( /* Convert to Json Data ( String ) */
    {
      "email": byEmailOrPhoneNums, 
      "password": passwords
    }
  );
  final response = await http.post(
    '$_url/pub/v1/$endpoints', 
    headers: {"Content-Type": "application/json; charset=utf-8"},
    body: encode
  );
  print(response.body);
  return json.decode(response.body);
}

/* User History */
Future<Map<String, dynamic>> userHistory() async {
  var token = await Provider.fetchToken();
  if (token != null){
    final response = await http.post("$_url/trxhistoryuri", headers: {HttpHeaders.authorizationHeader: "Bearer ${token['TOKEN']}"});
    return json.decode(response.body);
  }
  return null;
}

/* User Porfolio */
Future<Map<String, dynamic>> userPorfolio() async {
  var token = await Provider.fetchToken();
  if (token != null){
    final response = await http.post("$_url/portforliouri", headers: {HttpHeaders.authorizationHeader: "Bearer ${token['TOKEN']}"});
    return json.decode(response.body);
  }
  return null;
}

/*--------------------------------Receipt Transaction--------------------------------*/

/* List Branches */
Future<List<dynamic>> listBranches() async {
  var token = await Provider.fetchToken();
  if (token != null) {
    final response = await http.get('$_url/listBranches', headers: {HttpHeaders.authorizationHeader: "Bearer ${token['TOKEN']}"});
    var data = json.decode(response.body);
    return data['message'];
  }
  return null;
}

/* Confirm Receipt */
Future<Map<String, dynamic>> submitInvoice(ModelInvoice modelReceipt) async {
  var token = await Provider.fetchToken();
  if (token != null){
    final response = await http.post(
      "$_url/confirmreceipt",
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${token['TOKEN']}"
      },
      body: modelReceipt.bodyReceipt(modelReceipt)
    );
    Map<String, dynamic> convert = json.decode(response.body);
    return convert;
    // if (response.body != null ) {
    // }
    // return null;
  }
  return null;
}


/* Upload image to server by use multi part form*/

Future<http.StreamedResponse> upLoadImage(File image, String endpoint) async {

  var token = await Provider.fetchToken();
  Map<String, String> headers = {
    'Authorization': 'Bearer ${token['TOKEN']}',
  };
  /* Compress image file */
  List<int> compressImage = await FlutterImageCompress.compressWithFile(
    image.path,
    minHeight: 1300,
    minWidth: 1000,
    quality: 100,
  );
  /* Make request */
  var request = new http.MultipartRequest('POST', Uri.parse('$_urlPostImage/$endpoint'));
  /* Make Form of Multipart */
  var multipartFile = new http.MultipartFile.fromBytes(
    'file',
    compressImage,
    filename: 'image_picker.jpg',
    contentType: MediaType.parse('image/jpeg'),
  );
  /* Concate Token With Header */
  request.headers.addAll(headers);
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
  final response = await http.post(_urlOCR, body: bodys);
  print(response.body);
}

