import 'package:wallet_apps/index.dart';

class PortfolioRateModel {

  double currentData = 0;
  double comingData = 0;
  int totalRate = 0;

  Future<int> valueRate(Map<String, dynamic> data, double current) async{
    // print("Portolio $data");
    comingData = double.parse(data['balance']);
    print("Current $current");
    print("Coming $comingData");
    if (current != comingData){
      totalRate = (comingData.round()-current.round());
      await StorageServices.setData(comingData, 'current_amount');
      await StorageServices.setData(totalRate, 'total_rate');
    } else {
      totalRate = await getCurrentTotalRate();
    }
    return totalRate;
  }

  Future<double> getCurrentData() async {
    await StorageServices.fetchData('current_amount').then((value) {
      currentData = value;
    });
    return currentData == null ? 0 : currentData;
  }
  
  Future<int> getCurrentTotalRate() async {
    await StorageServices.fetchData('total_rate').then((value) {
      totalRate = value;
    });
    return totalRate == null ? 0 : totalRate;
  }
}