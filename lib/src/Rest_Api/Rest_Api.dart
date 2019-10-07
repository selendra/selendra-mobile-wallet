import 'dart:io';
import 'package:Wallet_Apps/src/Provider/Provider_General.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:image/image.dart' as img;

/* Zeetomic api user data*/
final _url = "https://api.zeetomic.com";

/* Zeetomic api image upload */
final _urlPostImage = "https://s3.zeetomic.com";

/* User Login */
Future<Map<String, dynamic>> userLogin(String email, String passwords) async {
  final response = await http.post('$_url/loginuri', body: {"email": email, "passwords": passwords});
  return json.decode(response.body);
}

/* User Regiser */
Future<Map<String, dynamic>> userRegister(String email, String passwords) async {
  final response = await http.post('$_url/registeruri', body: {"email": "$email", "passwords": "$passwords"});
  return json.decode(response.body);
}

/* User History */
Future<Map<String, dynamic>> userHistory() async {
  var token = await Provider.fetchToken();
  if (token != null){
    final response = await http.post("$_url/trxhistoryuri", headers: {HttpHeaders.authorizationHeader: "Basic ${token['TOKEN']}"});
    return json.decode(response.body);
  }
  return null;
}

/* User Porfolio */
Future<Map<String, dynamic>> userPorfolio() async {
  var token = await Provider.fetchToken();
  if (token != null){
    final response = await http.post("$_url/portforliouri", headers: {HttpHeaders.authorizationHeader: "Basic ${token['TOKEN']}"});
    return json.decode(response.body);
  }
  return null;
}

/* Upload image to server by use multi part form*/

Future<http.StreamedResponse> upLoadImage(File image) async {

  var token = await Provider.fetchToken();
  Map<String, String> headers = {
    'Authorization': 'Bearer ${token['TOKEN']}',
  };
  /* Resize image file */
  img.Image imageTemp = img.decodeImage(image.readAsBytesSync());
  img.Image resizedImg = img.copyResize(imageTemp, width: 800); 
  /* Make request */
  var request = new http.MultipartRequest('POST', Uri.parse('$_urlPostImage/uploadoc'));
  /* Make Form of Multipart */
  var multipartFile = new http.MultipartFile.fromBytes(
    'file',
    img.encodeJpg(resizedImg),
    filename: 'image_picker.jpg',
    contentType: MediaType.parse('image/jpeg'),
  );
  /* Concate Token With Header */
  request.headers.addAll(headers);
  request.files.add(multipartFile);
  /* Start send to server */
  var response = await request.send();
  /* Getting response */
  return response;
}

