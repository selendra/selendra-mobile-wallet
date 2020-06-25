import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallet_apps/index.dart';

class ZeeChart extends StatefulWidget {
  final ModelDashboard _modelDashboard;

  ZeeChart(this._modelDashboard);

  @override
  State<StatefulWidget> createState() {
    return ZeeChartState();
  }
}

class ZeeChartState extends State<ZeeChart> {

  RefreshController _refreshController = RefreshController();

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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>GetWallet(widget._modelDashboard.userData['wallet'])
      )
    );
  }

  void resetState(String barcodeValue, String executeName, ModelDashboard _model, Function toReceiveToken) {
    setState(() {
      if (executeName == "portfolio") {
        _model.portfolio = null;
        toReceiveToken();
      } else if (executeName == "barcode") _model.barcode = barcodeValue;
    });
  }

  void dispose() {
    super.dispose();
  }

  void fetchPortfolio() async { /* Fetch Portofolio */
    setState(() {
      widget._modelDashboard.portfolio = [];
    });
    await _getRequest.getPortfolio().then((_response) async {
      /* Get Response Data */
      if ((_response.runtimeType.toString()) != "List<dynamic>" &&
          _response.runtimeType.toString() != "_GrowableList<dynamic>") {
        /* If Response DataType Not List<dynamic> */
        if (_response.containsKey("error")) {
          await dialog(
              context,
              Text("${_response['error']['message']}"),
              warningTitleDialog());
          setState(() {
            widget._modelDashboard.portfolio =
                null; /* Set Portfolio Equal Null To Close Loading Process */
          });
        }
      } else {
        setState(() {
          widget._modelDashboard.portfolio = _response;
        });
        StorageServices.setData(widget._modelDashboard.portfolio, 'portfolio'); /* Set Portfolio To Local Storage */
      }
    });
  }

  void getUserData() async {
    /* Fetch User Data From Memory */
    widget._modelDashboard.userData = await _getRequest.getUserProfile();
  }

  _pullUpRefresh() async {
    /* Refech Data User And Portfolio */
    setState(() {
      widget._modelDashboard.portfolio = [];
    });
    fetchPortfolio();
    getUserData();
    _refreshController.refreshCompleted();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: scaffoldBGDecoration(/* Background Decoration */
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                containerAppBar( /* AppBar */
                  context,
                  Row( /* Sub AppBar */
                    children: <Widget>[
                      iconAppBar( /* Menu Button */
                        Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        Alignment.centerLeft,
                        EdgeInsets.all(0),
                        popScreen
                      ),
                      containerTitle("Zee Chart", double.infinity, Colors.white, FontWeight.normal), /* Title AppBar */
                      Expanded( child: Container(), ),
                      iconAppBar( /* Earth Icon */
                        Image.asset(
                          'assets/earthicon.png',
                          width: 20.0,
                          height: 20.0,
                          color: Colors.white,
                        ),
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
                    onRefresh: _pullUpRefresh,
                    child: zeeChartBody(
                      context,
                      widget._modelDashboard.portfolio,
                      widget._modelDashboard
                    ),
                  ),
                )
              ],
            )
          ],
        )
      ),
    );
  }
}
