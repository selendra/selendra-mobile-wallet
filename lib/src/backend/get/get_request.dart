import 'package:wallet_apps/index.dart';
import 'package:http/http.dart' as _http;

class GetRequest{

  BackendComponent _backendComponent = BackendComponent();

  Future<Map<String, dynamic>> getUserProfile() async {
    /* Get User Profile */
    _backendComponent.token = await Provider.fetchToken();
    if (_backendComponent.token != null) {
      _backendComponent.response = await _http.get("${AppConfig.url}/userprofile",
        headers: _backendComponent.conceteHeader("authorization", "Bearer ${_backendComponent.token['token']}")
      );
      return json.decode(_backendComponent.response.body);
    }
    return null;
  }

  Future<int> checkExpiredToken() async { /* Expired Token In Welcome Screen */
    _backendComponent.token = await Provider.fetchToken();
    if (_backendComponent.token != null) {
      _backendComponent.response = await _http.get("${AppConfig.url}/userprofile", headers: _backendComponent.conceteHeader("authorization", "Bearer ${_backendComponent.token['token']}"));
      return _backendComponent.response.statusCode;
    }
    return null;
  }

  Future trxUserHistory() async {
    /* User History */
    _backendComponent.token = await Provider.fetchToken();
    if (_backendComponent.token != null) {
      _backendComponent.response = await _http.get("${AppConfig.url}/trx-history",
          headers: _backendComponent.conceteHeader("authorization", "Bearer ${_backendComponent.token['token']}"));
      return json.decode(_backendComponent.response.body);
    }
    return null;
  }

  Future getPortfolio() async { /* User Porfolio */
    _backendComponent.token = await Provider.fetchToken();
    if (_backendComponent.token != null) {
      _backendComponent.response = await _http.get("${AppConfig.url}/portforlio", headers: _backendComponent.conceteHeader("authorization", "Bearer ${_backendComponent.token['token']}"));
      return json.decode(_backendComponent.response.body);
    }
    return null;
  }

  Future getAllBranches() async {
    _backendComponent.token = await Provider.fetchToken();
    if (_backendComponent.token != null) {
      _backendComponent.response = await _http.get("${AppConfig.url}/get-all-branches",
          headers: _backendComponent.conceteHeader("authorization", "Bearer ${_backendComponent.token['token']}"));
      return json.decode(_backendComponent.response.body);
    }
    return null;
  }

  Future<dynamic> getReceipt() async {
    _backendComponent.token = await Provider.fetchToken();
    if (_backendComponent.token != null) {
      _backendComponent.response = await _http.get("${AppConfig.url}/get-receipt",
          headers: _backendComponent.conceteHeader("authorization", "Bearer ${_backendComponent.token['token']}"));
      return json.decode(_backendComponent.response.body);
    }
    return null;
  }
  /*--------------------------------Transaction--------------------------------*/

  /* List Branches */
  Future<List<dynamic>> listBranches() async {
    _backendComponent.token = await Provider.fetchToken();
    if (_backendComponent.token != null) {
      _backendComponent.response = await _http.get('${AppConfig.url}/listBranches', headers: {
        HttpHeaders.authorizationHeader: "Bearer ${_backendComponent.token['TOKEN']}"
      });
      _backendComponent.data = json.decode(_backendComponent.response.body);
      return _backendComponent.data['message'];
    }
    return null;
  }

  // Future<Map<String, dynamic>> submitInvoice(ModelInvoice _model) async { /* Confirm Receipt */
  //   _backendComponent.token = await Provider.fetchToken();
  //   if (_backendComponent.token != null){
  //     _backendComponent.response = await _http.post(
  //       "${AppConfig.url}/confirmreceipt",
  //       headers: {
  //         HttpHeaders.authorizationHeader: "Bearer ${_backendComponent.token['TOKEN']}"
  //       },
  //       body: _model.bodyReceipt(_model)
  //     );
  //     return json.decode(_backendComponent.response.body);
  //   }
  //   return null;
  // }
}