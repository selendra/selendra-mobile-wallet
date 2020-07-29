import 'package:wallet_apps/index.dart';
import 'package:http/http.dart' as http;

class PostRequest {

  AppApi _appApi = AppApi();

  Backend _backend = Backend();

  Future<dynamic> inviteFriend(String phoneNumber) async {
    _backend.token = await Provider.fetchToken();
    _backend.bodyEncode = json.encode({"phone": phoneNumber});
    if (_backend.token != null) {
      _backend.response = await http.post(
        "${AppConfig.url}/invite-phonenumber",
        headers: _backend.conceteHeader("authorization", "Bearer ${_backend.token["token"]}"),
        body: _backend.bodyEncode
      );
    }
    return json.decode(_backend.response.body);
  }

  /* ------------------User Login-------------- */

  Future<http.Response> loginByPhone(String phone, String passwords) async {
    _backend.bodyEncode = json.encode({ /* Convert to Json String */
      "phone": "+855$phone",
      "password": passwords
    });
    _backend.response = await http.post('${AppConfig.url}/loginbyphone', headers: _backend.conceteHeader(null, null), body: _backend.bodyEncode);
    return _backend.response;
  }

  Future<http.Response> loginByEmail(String email, String passwords) async {
    /* User Login */
    _backend.bodyEncode = json.encode({ /* Convert to Json String */
      "email": email,
      "password": passwords
    });
    _backend.response = await http.post('${AppConfig.url}/loginbyemail', headers: _backend.conceteHeader(null, null), body: _backend.bodyEncode);
    return _backend.response;
  }

  /* -----------------User Regiser-------------- */
  
  Future<http.Response> registerByPhone(String _phone, String passwords) async {
    _backend.bodyEncode = json.encode(/* Convert to Json Data ( String ) */
      {"phone": "+855$_phone", "password": passwords}
    );
    _backend.response = await http.post('${AppConfig.url}/registerbyphone', headers: _backend.conceteHeader(null, null), body: _backend.bodyEncode);
    return _backend.response;
  }

  Future<http.Response> registerByEmail(String email, String passwords) async {
    _backend.bodyEncode = json.encode(/* Convert to Json Data ( String ) */
      {"email": email, "password": passwords}
    );
    _backend.response = await http.post('${AppConfig.url}/registerbyemail', headers: _backend.conceteHeader(null, null), body: _backend.bodyEncode);
    return _backend.response;
  }

  /* Post User Information */
  Future<http.Response> uploadProfile(ModelUserInfo _model, String _endpoints) async {
    _backend.token = await Provider.fetchToken();
    _backend.bodyEncode = json.encode({
      "first_name": _model.controlFirstName.text,
      "mid_name": _model.controlMidName.text,
      "last_name": _model.controlLastName.text,
      "gender": _model.gender
    });
    if (_backend.token != null) {
      _backend.response = await http.post(
        "${AppConfig.url}/userprofile",
        headers: _backend.conceteHeader("authorization", "Bearer ${_backend.token["token"]}"),
        body: _backend.bodyEncode
      );
      return _backend.response;
    }
    return null;
  }

  /* Post Get Wallet */
  Future<Map<String, dynamic>> retreiveWallet(String _pins) async {
    _backend.token = await Provider.fetchToken();
    print(_backend.token);
    _backend.bodyEncode = json.encode({"pin": _pins});
    if (_backend.token != null) {
      _backend.response = await http.post(
        "${AppConfig.url}/getwallet",
        headers: _backend.conceteHeader("authorization", "Bearer ${_backend.token["token"]}"),
        body: _backend.bodyEncode
      );
      return json.decode(_backend.response.body);
    }
    return null;
  }

  Future<Map<String, dynamic>> addAsset(ModelAsset _model) async { /* Add New Asset */
    _backend.token = await Provider.fetchToken();
    _backend.bodyEncode = json.encode({
      "asset_code": _model.controllerAssetCode.text,
      "asset_issuer": _model.controllerIssuer.text
    });
    if (_backend.token != null) {
      _backend.response = await http.post(
        "${AppConfig.url}/addasset",
        headers: _backend.conceteHeader("authorization", "Bearer ${_backend.token['token']}"),
        body: _backend.bodyEncode
      );
      return json.decode(_backend.response.body);
    }
    return null;
  }

  Future<Map<String, dynamic>> sendPayment(ModelScanPay _model) async { /* QR Code Send Request */
    _backend.token = await Provider.fetchToken();
    _backend.bodyEncode = json.encode({
      "pin": _model.pin,
      "asset_code": _model.asset,
      "destination": _model.controlReceiverAddress.text,
      "amount": _model.controlAmount.text,
      "memo": _model.controlMemo.text
    });
    if (_backend.token != null) {
      _backend.response = await http.post(
        "${AppConfig.url}/sendpayment",
        headers: _backend.conceteHeader("authorization", "Bearer ${_backend.token["token"]}"),
        body: _backend.bodyEncode
      );
      Map<String, dynamic> _decode = json.decode(_backend.response.body);
      _decode.addAll({"status_code": _backend.response.statusCode});
      return _decode;
    }
    return null;
  }

  Future<Map<String, dynamic>> addMerchant(dynamic _model) async { /* Add New Merchant */
    _backend.token = await Provider.fetchToken();
    _backend.bodyEncode = json.encode({
      "asset-code": _model.controlAssetCode.text,
      "destination": _model.controlDestination.text,
      "amount": _model.controlAmount.text,
      "memo": _model.controlMemo.text
    });
    if (_backend.token != null) {
      _backend.response = await http.post(
        "${AppConfig.url}/sendpayment",
        headers: _backend.conceteHeader("authorization", "Bearer ${_backend.token['token']}"),
        body: _backend.bodyEncode
      );
      return json.decode(_backend.response.body);
    }
    return null;
  }

  Future<Map<String, dynamic>> addReceipt(ModelScanInvoice _modelScanInvoice) async { /* Scan Receipt */
    _backend.bodyEncode = json.encode({
      "receipt_no": _modelScanInvoice.controlBillNO.text,
      "amount": _modelScanInvoice.controlAmount.text,
      "location": _modelScanInvoice.controlLocation.text,
      "image_uri": _modelScanInvoice.imageUri['uri'],
      "approval_code": _modelScanInvoice.controlApproveCode.text
    });
    _backend.token = await Provider.fetchToken();
    if (_backend.token != null) {
      _backend.response = await http.post(
        "${AppConfig.url}/addreceipt",
        headers: _backend.conceteHeader("authorization", "Bearer ${_backend.token['token']}"),
        body: _backend.bodyEncode
      );
      return json.decode(_backend.response.body);
    }
    return null;
  }

  /* Sign Up & Verification */

  Future<http.Response> resendCode(String phoneNumber) async {
    print(phoneNumber);
    _backend.bodyEncode = json.encode({
      "phone": "+855$phoneNumber",
    });
    _backend.response = await http.post(
      "${AppConfig.url}/resend-code",
      headers: _backend.conceteHeader(null, null),
      body: _backend.bodyEncode
    );
    return _backend.response;
  }

  // Confirm User Account By Phone Number
  Future<http.Response> confirmAccount(ModelSignUp _model) async {
    print("${_model.countryCode}${_model.controlPhoneNums.text}");
    print(_model.code);
    _backend.bodyEncode = json.encode({
      "phone": "${_model.countryCode}${_model.controlPhoneNums.text}",
      "verification_code": _model.code
    });
    _backend.response = await http.post(
      "${AppConfig.url}/account-confirmation",
      headers: _backend.conceteHeader(null, null), body: _backend.bodyEncode
    );
    print(_backend.response.body);
    return _backend.response;
  }

  Future<Map<String, dynamic>> forgetPassword(ModelForgotPassword _modelForgot, String value) async { /* Confirm User Account By Phone Number */
    // print(_modelForgot.controllerEmail.text);
    // print(_modelForgot.co)
    _backend.bodyEncode = json.encode({
      _modelForgot.key: value,
    });
    _backend.response = await http.post(
      "${AppConfig.url}/${_modelForgot.endpoint}",
      headers: _backend.conceteHeader(null, null), 
      body: _backend.bodyEncode
    );
    return json.decode(_backend.response.body);
  }

  Future<Map<String, dynamic>> resetPass(ModelForgotPassword _modelForgot, String value, String endpoint) async { /* Confirm User Account By Phone Number */
    _backend.bodyEncode = json.encode({
      "temp_code": _modelForgot.controlResetCode.text,
      _modelForgot.key: value,
      "password": _modelForgot.controlConfirmPasswords.text
    });
    _backend.response = await http.post(
      "${AppConfig.url}/$endpoint",
      headers: _backend.conceteHeader(null, null), 
      body: _backend.bodyEncode
    );
    return json.decode(_backend.response.body);
  }

  Future<Map<String, dynamic>> changePIN(ModelChangePin _model) async {
    _backend.token = await Provider.fetchToken();
    _backend.bodyEncode = json.encode({
      "current_pin": _model.controllerOldPin.text,
      "new_pin": _model.controllerConfirmPin.text,
    });
    if (_backend.token != null) {
      _backend.response = await http.post(
        "${AppConfig.url}/change-pin",
        headers: _backend.conceteHeader("authorization", "Bearer ${_backend.token['token']}"),
        body: _backend.bodyEncode
      );
      return json.decode(_backend.response.body);
    }
    return null;
  }

  Future<Map<String, dynamic>> changePassword(ModelChangePassword _model) async {
    _backend.token = await Provider.fetchToken();
    _backend.bodyEncode = json.encode({
      "current_password": _model.controlOldPassword.text,
      "new_password": _model.controlConfirmPassword.text,
    });
    if (_backend.token != null) {
      _backend.response = await http.post("${AppConfig.url}/change-password",
        headers: _backend.conceteHeader("authorization", "Bearer ${_backend.token['token']}"),
        body: _backend.bodyEncode
      );
      return json.decode(_backend.response.body);
    }
    return null;
  }

  Future<Map<String, dynamic>> getReward(String hashs) async {
    _backend.token = await Provider.fetchToken();
    _backend.bodyEncode = json.encode({"hashs": hashs});
    if (_backend.token != null) {
      _backend.response = await http.post("${AppConfig.url}/get-rewards",
        headers: _backend.conceteHeader("authorization", "Bearer ${_backend.token['token']}"),
        body: _backend.bodyEncode
      );
      return json.decode(_backend.response.body);
    }
    return null;
  }


  /* Post To Get Wallet Form Contact */
  Future<Map<String, dynamic>> getWalletFromContact(String contact) async {
    _backend.token = await Provider.fetchToken();
    _backend.bodyEncode = json.encode({
      "phone": contact
    });
    if (_backend.token != null) {
      _backend.response = await http.post(
        '${AppConfig.url}/wallet-lookup', 
        headers: _backend.conceteHeader("authorization", "Bearer ${_backend.token['token']}"),
        body: _backend.bodyEncode
      );
      _backend.data = json.decode(_backend.response.body);
      _backend.data.addAll({
        "status_code": _backend.response.statusCode
      });
      return _backend.data;
    }
    return null;
  }

  /* OCR Image */
  Future ocrImage(String imageuri) async {
    // "https://i.ibb.co/r69pMmx/ocr.png"
    Map<String, dynamic> bodys = {
      "imguri": imageuri,
      "amount": "Grand Total(\$)",
      "trxdate": "Bill Date"
    };
    final response = await http.post(_appApi.urlOCR, body: bodys);
  }

  Future<http.StreamedResponse> upLoadImage(File _image, String endpoint) async {
    /* Upload image to server by use multi part form*/
    _backend.token = await Provider.fetchToken();
    /* Compress image file */
    List<int> compressImage = await FlutterImageCompress.compressWithFile(
      _image.path,
      minHeight: 1300,
      minWidth: 1000,
      quality: 100,
    );
    /* Make request */
    var request =
        new http.MultipartRequest('POST', Uri.parse('${_appApi.apiPostImage}/$endpoint'));
    /* Make Form of Multipart */
    var multipartFile = new http.MultipartFile.fromBytes(
      'file',
      compressImage,
      filename: 'image_picker.jpg',
      contentType: MediaType .parse('image/jpeg'),
    );
    /* Concate Token With Header */
    request.headers.addAll(_backend.conceteHeader("Authorization", "Bearer ${_backend.token['TOKEN']}"));
    request.files.add(multipartFile);
    /* Start send to server */
    var response = await request.send();
    /* Getting response */
    // response.stream.transform(utf8.decoder).listen((data){
    // });
    return response;
  }
}