import 'package:http/http.dart' as _http;
import 'package:wallet_apps/index.dart';

class Portfolio{

  static List<Map<String, dynamic>> list;

  Portfolio.extractData(_http.Response data){
    dynamic decode = json.decode(data.body);
    print(decode.runtimeType);
    print(decode);
    print(data.runtimeType);
    if(decode.runtimeType.toString() == "List<dynamic>"){
      list = List<Map<String, dynamic>>.from(decode);
    } else {
      list = List<Map<String, dynamic>>.filled(1, decode);
    }
  }
}