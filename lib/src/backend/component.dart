class BackendComponent{

  Map<String, dynamic> token = {}; 
  String bodyEncode = "";
  var response;

  dynamic data;

  Map<String, String> conceteHeader(String _key, String _value) { /* Concete More Content Of Header */
    return _key != null 
    ? { /* if Parameter != Null = Concete Header With  */
      "Content-Type": "application/json; charset=utf-8", 
      _key: _value
    }
    : { /* if Parameter Null = Don't integrate */
      "Content-Type": "application/json; charset=utf-8"
    };
  }
}