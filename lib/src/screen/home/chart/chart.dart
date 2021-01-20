// import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallet_apps/index.dart';

class SelendraChart extends StatefulWidget {
  final HomeModel _modelDashboard;

  SelendraChart(this._modelDashboard);

  @override
  State<StatefulWidget> createState() {
    return SelendraChartState();
  }
}

class SelendraChartState extends State<SelendraChart> {

  // RefreshController _refreshController = RefreshController();

  GetRequest _getRequest = GetRequest();

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    AppServices.noInternetConnection(_globalKey);
    super.initState();
  }

  void popScreen() {
    Navigator.pop(context);
  }

  void toReceiveToken(BuildContext context) async {/* Fetch Portofolio */
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) =>GetWallet(widget._modelDashboard.userData['wallet'], )
    //   )
    // );
  }

  void resetState(String barcodeValue, String executeName, HomeModel _model, Function toReceiveToken) {
    setState(() {
      if (executeName == "portfolio") {
        _model.portfolioList = null;
        toReceiveToken();
      } else if (executeName == "barcode") _model.barcode = barcodeValue;
    });
  }

  void fetchPortfolio() async { /* Fetch Portofolio */
    setState(() {
      widget._modelDashboard.portfolioList = [];
    });
    // await _getRequest.getPortfolio().then((_response) async {
    //   /* Get Response Data */
    //   if ((_response.runtimeType.toString()) != "List<dynamic>" &&
    //       _response.runtimeType.toString() != "_GrowableList<dynamic>") {
    //     /* If Response DataType Not List<dynamic> */
    //     if (_response.containsKey("error")) {
    //       await dialog(
    //           context,
    //           Text("${_response['error']['message']}"),
    //           warningTitleDialog());
    //       setState(() {
    //         widget._modelDashboard.portfolioList =
    //             null; /* Set Portfolio Equal Null To Close Loading Process */
    //       });
    //     }
    //   } else {
    //     setState(() {
    //       widget._modelDashboard.portfolioList = _response;
    //     });
    //     StorageServices.setData(widget._modelDashboard.portfolioList, 'portfolio'); /* Set Portfolio To Local Storage */
    //   }
    // });
  }

  void getUserData() async {
    /* Fetch User Data From Memory */
    // widget._modelDashboard.userData = await _getRequest.getUserProfile();
  }

  _pullUpRefresh() async {
    /* Refech Data User And Portfolio */
    setState(() {
      widget._modelDashboard.portfolioList = [];
    });
    fetchPortfolio();
    getUserData();
    // _refreshController.refreshCompleted();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: scaffoldBGDecoration(/* Background Decoration */
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                MyAppBar(
                  title: "Selendra chart"
                ),
                // Expanded(
                //   child: SmartRefresher(
                //     controller: _refreshController,
                //     onRefresh: _pullUpRefresh,
                //     child: zeeChartBody(
                //       context,
                //       widget._modelDashboard.portfolioList,
                //       widget._modelDashboard
                //     ),
                //   ),
                // )
              ],
            )
          ],
        )
      ),
    );
  }
}
