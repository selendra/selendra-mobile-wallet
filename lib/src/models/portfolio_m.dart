import 'package:http/http.dart' as _http;
import 'package:wallet_apps/index.dart';

class PortfolioM{

  List<Map<String, dynamic>> list = [];

  GlobalKey<AnimatedCircularChartState> chartKey = GlobalKey<AnimatedCircularChartState>();

  List<CircularSegmentEntry> circularChart;

  double total = 0;

  double remainDataChart = 100;

  Future<void> extractData(_http.Response data){
    dynamic decode = json.decode(data.body);

    if(decode.runtimeType.toString() == "_GrowableList<dynamic>" || decode.runtimeType.toString() == "List<dynamic>"){
      decode.forEach((element) {
        list.add(element);
      });
    } else {
      list.add(decode);
    }
  }
}