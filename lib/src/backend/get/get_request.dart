import 'package:wallet_apps/index.dart';
import 'package:http/http.dart' as _http;

class GetRequest{

  SelendraApi _sldApi = SelendraApi();

  Backend _backend = Backend();

  Future<Map<String, dynamic>> getUserProfile() async {
    /* Get User Profile */
    _backend.token = await Provider.fetchToken();
    if (_backend.token != null) {
      _backend.response = await _http.get("${_sldApi.api}/userprofile",
        headers: _backend.conceteHeader("authorization", "Bearer ${_backend.token['token']}")
      );
      return json.decode(_backend.response.body);
    }
    return null;
  }

  Future<_http.Response> checkExpiredToken() async { /* Expired Token In Welcome Screen */
    _backend.token = await Provider.fetchToken();
    print('fetching ${_backend.token['token']}');
    print(_sldApi.api);
    if (_backend.token != null) {
      print("hello");
      _backend.response = await _http.get("${_sldApi.api}/userprofile", headers: _backend.conceteHeader("authorization", "Bearer ${_backend.token['token']}"));
      print("Request ${_backend.response.body}");
      return _backend.response;
    }
    return null;
  }

  Future trxUserHistory() async {
    /* User History */
    _backend.token = await Provider.fetchToken();
    if (_backend.token != null) {
      _backend.response = await _http.get("${_sldApi.api}/trx-history",
          headers: _backend.conceteHeader("authorization", "Bearer ${_backend.token['token']}"));
      return json.decode(_backend.response.body);
    }
    return null;
  }

  Future<_http.Response> getPortfolio() async { /* User Porfolio */
    _backend.token = await Provider.fetchToken();
    if (_backend.token != null) {
      _backend.response = await _http.get("${_sldApi.api}/portforlio", headers: _backend.conceteHeader("authorization", "Bearer ${_backend.token['token']}"));
      return _backend.response;
    }
    return null;
  }

  Future getAllBranches() async {
    _backend.token = await Provider.fetchToken();
    if (_backend.token != null) {
      _backend.response = await _http.get("${_sldApi.api}/get-all-branches",
          headers: _backend.conceteHeader("authorization", "Bearer ${_backend.token['token']}"));
      return json.decode(_backend.response.body);
    }
    return null;
  }

  Future<dynamic> getReceipt() async {
    _backend.token = await Provider.fetchToken();
    if (_backend.token != null) {
      _backend.response = await _http.get("${_sldApi.api}/get-receipt",
          headers: _backend.conceteHeader("authorization", "Bearer ${_backend.token['token']}"));
      return json.decode(_backend.response.body);
    }
    return null;
  }
  /*--------------------------------Transaction--------------------------------*/

  /* List Branches */
  Future<List<dynamic>> listBranches() async {
    _backend.token = await Provider.fetchToken();
    if (_backend.token != null) {
      _backend.response = await _http.get('${_sldApi.api}/listBranches', headers: {
        HttpHeaders.authorizationHeader: "Bearer ${_backend.token['TOKEN']}"
      });
      _backend.data = json.decode(_backend.response.body);
      return _backend.data['message'];
    }
    return null;
  }

  // Future<Map<String, dynamic>> submitInvoice(ModelInvoice _model) async { /* Confirm Receipt */
  //   _backend.token = await Provider.fetchToken();
  //   if (_backend.token != null){
  //     _backend.response = await _http.post(
  //       "${_sldApi.api}/confirmreceipt",
  //       headers: {
  //         HttpHeaders.authorizationHeader: "Bearer ${_backend.token['TOKEN']}"
  //       },
  //       body: _model.bodyReceipt(_model)
  //     );
  //     return json.decode(_backend.response.body);
  //   }
  //   return null;
  // }
}