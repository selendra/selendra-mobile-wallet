import 'package:wallet_apps/index.dart';
import 'package:http/http.dart' as _http;

class PostRequest {

  Map<String, dynamic> _token; 
  String _bodyEncode;
  var _response;

  Map<String, String> _conceteHeader(String _key, String _value) { /* Concete More Content Of Header */
    return _key != null 
    ? { /* if Parameter != Null = Concete Header With  */
      "Content-Type": "application/json; charset=utf-8", 
      _key: _value
    }
    : { /* if Parameter Null = Don't integrate */
      "Content-Type": "application/json; charset=utf-8"
    };
  }

  Future<dynamic> inviteFriend(String phoneNumber) async {
    _token = await Provider.fetchToken();
    _bodyEncode = json.encode({"phone": phoneNumber});
    if (_token != null) {
      _response = await _http.post(
        "${AppConfig.url}/invite-phonenumber",
        headers: _conceteHeader("authorization", "Bearer ${_token["token"]}"),
        body: _bodyEncode
      );
    }
    print("response ${_response.body}");
    return json.decode(_response.body);
  }
}