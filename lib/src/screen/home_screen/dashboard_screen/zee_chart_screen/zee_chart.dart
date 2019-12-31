import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:wallet_apps/src/model/model_dashboard.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/dashboard_reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/invoice_screen/invoice_info_screen/invoice_info.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/zee_chart_screen/zee_chart_body.dart';
import 'package:wallet_apps/src/store_small_data/data_store.dart';

class ZeeChart extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ZeeChartState();
  }
}

class ZeeChartState extends State<ZeeChart>{

  ModelDashboard _modelDashboard = ModelDashboard();

  RefreshController _refreshController = RefreshController();

  Map<String, dynamic> portfolioData;

  void popScreen() {
    Navigator.pop(context);
  }

  void fetchWallet() async { /* Fetch Only User ID */
    _modelDashboard.userWallet = await fetchData("userStatusAndWallet");
    Future.delayed(Duration(seconds: 1), () {
      setState(() { });
    });
  }

  void fetchPortfolio() async { /* Fetch Portofolio */
    var response = await userPorfolio();
    setData(response, 'portFolioData');
    portfolioData = response;
    setState(() {});
  }

  void resetState(String barcodeValue, String executeName, ModelDashboard _model, Function fetchPortfolio) {
    setState(() {
      if (executeName == "portfolio") {
        _model.portfolioData = null; 
        fetchPortfolio();
      } else if (executeName == "barcode") _model.barcode = barcodeValue;
    });
  }
  
  void scanReceipt() async {
  // File cropimage = await cropImageCamera(context);
  // if (cropimage != null){
  //   dialogLoading(context);
  //   StreamedResponse response = await upLoadImage(cropimage, "upload");
  //   response.stream.transform(utf8.decoder).listen((data) async {
  //     Map<String, dynamic> result = await json.decode(data);result['uuid']
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => InvoiceInfo("Hello")));
      // var result = await json.decode(data);
      // setState(() {
      //   _image = result['url'];
      // });
      // Map<String, dynamic> result = await json.decode(data);
      // await ocrImage(result['url']);
      // Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptVerify()));
    // });
    // }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: scaffoldBGDecoration( /* Background Decoration */
        16.0, 16.0, 16.0, 0, 
        color1, color2, 
        Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                containerAppBar( /* AppBar */
                  context, 
                  Row( /* Sub AppBar */
                    children: <Widget>[
                      iconAppBar( /* Menu Button */
                        Icon(Icons.arrow_back, color: Colors.white,),
                        Alignment.centerLeft,
                        EdgeInsets.all(0),
                        popScreen
                      ),
                      containerTitle("Zee Chart", double.infinity, Colors.white, FontWeight.bold), /* Title AppBar */
                      Expanded(
                        child: Container(),
                      ),
                      iconAppBar( /* Earth Icon */
                        Image.asset('assets/earthicon.png',width: 20.0, height: 20.0, color: Colors.white,),
                        Alignment.centerRight,
                        EdgeInsets.only(right: 11, left: 0, top: 0, bottom: 0),
                        null
                      ),
                    ],
                  )  
                ),
                Expanded(
                  child: SmartRefresher(
                    controller: _refreshController,
                    onRefresh: () {

                    },
                    child: zeeChartBodyWidget(context, portfolioData),
                  ),
                )
              ],
            )
          ],
        )
      ),
      /* Bottom Navigation Bar */
      bottomNavigationBar: bottomAppBar(
        context, 
        _modelDashboard, 
        scanQR, 
        scanReceipt,
        resetState,
        fetchPortfolio
      )
    );
  }
}