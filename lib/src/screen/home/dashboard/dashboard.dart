import 'package:flare_flutter/flare_controls.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallet_apps/index.dart';
import 'package:screen/screen.dart';

class Dashboard extends StatefulWidget {
  State<StatefulWidget> createState() {
    return DashboardState();
  }
}

class DashboardState extends State<Dashboard> {

  ModelDashboard _modelDashboard = ModelDashboard();
  
  PostRequest _postRequest = PostRequest();

  GetRequest _getRequest = GetRequest();

  PackageInfo _packageInfo;

  FlareControls _flareControls = FlareControls();

  String action = "no_action";

  @override
  initState() { /* Initialize State */
    _modelDashboard.result = {};
    _modelDashboard.scaffoldKey = GlobalKey<ScaffoldState>();
    _modelDashboard.circularChart = [
      CircularSegmentEntry(_modelDashboard.remainDataChart, getHexaColor("#4B525E"))
    ];
    AppServices.noInternetConnection(_modelDashboard.scaffoldKey);
    _modelDashboard.userData = {};
    getUserData(); /* User Profile */
    fetchPortfolio();
    triggerDeviceInfo();
    super.initState();
  }

  /* ---------------------------Rest Api--------------------------- */
  void getUserData() async { /* Fetch User Data From Memory */
    await _getRequest.getUserProfile().then((data) {
      if (data == null)
        _modelDashboard.userData = {};
      else
        _modelDashboard.userData = data;
    });
  }

  void triggerDeviceInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();
    setState(() {});
  }

  void fetchPortfolio() async { /* Fetch Portofolio */
    await Future.delayed(Duration(milliseconds: 10),(){
      setState(() {
        _modelDashboard.portfolio = [];
      });
    });
    if (_modelDashboard.result.containsValue("dialogPrivateKey")){
      _modelDashboard.result = {}; /* Reset Result Data To Default */
    } else { /* Initstate & Pull Refresh To Get Portfolio */
      await _getRequest.getPortfolio().then((_response) async { /* Get Response Data */
        _modelDashboard.portFolioResponse = _response;
        if (_response != null) {
          if ((_response.runtimeType.toString()) != "List<dynamic>" && _response.runtimeType.toString() != "_GrowableList<dynamic>") {
            /* If Response DataType Not List<dynamic> */
            if (_response.containsKey("error")) {
              await dialog(
                context, 
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: textAlignCenter(text: "${_response['error']['message']}")
                    ),
                    Container(
                      child: textAlignCenter(text: "Please go to menu to get wallet!")
                    ),
                  ],
                ), 
                warningTitleDialog()
              );
              setState(() {
                _modelDashboard.portfolio = null; /* Set Portfolio Equal Null To Close Loading Process */
              });
            }
          } else {
            setState(() {
              _modelDashboard.portfolio = _response;
            });
            StorageServices.setData(_modelDashboard.portfolio, 'portfolio'); /* Set Portfolio To Local Storage */
            resetDataPieChart(_modelDashboard.portfolio); 
          }
        } else if (_response == null) {
          setState(() {
            _modelDashboard.portfolio = null; /* Set Portfolio Equal Null To Close Loading Process */
          });
        }
      });
    }
  }

  /* ------------------------Method------------------------ */

  void resetDataPieChart(List<dynamic> portfolio){
    if (_modelDashboard.portfolio.length != 0){

      _modelDashboard.circularChart.clear(); // Clear Pie Data

      for (int i = 0; i < _modelDashboard.portfolio.length; i++){
        _modelDashboard.remainDataChart -= json.decode(_modelDashboard.portfolio[i]['balance']); //Decode Data And Subtract
        _modelDashboard.circularChart.add( //Add More Data Follow Portfolio
          CircularSegmentEntry(
            json.decode(_modelDashboard.portfolio[i]['balance']),
            getHexaColor(AppColors.greenColor)
          )
        );
      }
      _modelDashboard.circularChart.add( // Add Remain Empty Data
        CircularSegmentEntry(
          _modelDashboard.remainDataChart,
          getHexaColor("#4B525E")
        )
      );

      _modelDashboard.chartKey.currentState.updateData([
        CircularStackEntry(_modelDashboard.circularChart
        )
      ]);

      _modelDashboard.remainDataChart = 100.0; // Reset Remain Pie Data
    }
  }
  
  void drawerCallBack(dynamic result){
    _modelDashboard.result = result;
    if (_modelDashboard.result.length != 0) { // If Not Empty Excecute Statement
      if (
        _modelDashboard.result.containsValue("dialogPrivateKey") ||
        _modelDashboard.result.containsValue("addAssetScreen") 
      ) 
      fetchPortfolio();
      getUserData();
    }
  }

  /* ------------------------Fetch Local Data Method------------------------ */
  
  _pullUpRefresh() async { /* Refech Data User And Portfolio */
    setState(() {
      _modelDashboard.portfolio = [];
    });
    fetchPortfolio();
    getUserData();
    _modelDashboard.refreshController.refreshCompleted();
  }

  Future<dynamic> cropImageCamera(BuildContext context) async {
    File image = await camera();
    dialogLoading(context);
    if (image != null) {
      await Future.delayed(Duration(milliseconds: 300), () => Navigator.pop(context)); /* Wait 300 Millisecond And Close Loading Process */
      File cropImage = await ImageCropper.cropImage(
        // maxHeight: 4096,
        // maxWidth: 1024,
        sourcePath: image.path,
        androidUiSettings: AndroidUiSettings(
          backgroundColor: Colors.black,
          // lockAspectRatio: false
        )
      );
      return cropImage;
    }
    await Future.delayed(Duration(milliseconds: 100), () => Navigator.pop(context)); /* Wait 300 Millisecond And Close Loading Process */
    return null;
  }

  void scanReceipt() async { /* Receipt Scan Pay Process */
    // await cropImageCamera(context).then((_response) async { /* Crop Image From Back Camera */
    //   if (_response != null){
    //     _modelScanInvoice.imageCapture = _response;
    //     dialogLoading(context); /* Show Loading Process */
    //     StreamedResponse _streamedResponse = await upLoadImage(_modelScanInvoice.imageCapture, "upload"); /* POST Image And Wait Response Back */
    //     _streamedResponse.stream.transform(utf8.decoder).listen((data) async {
    //       Navigator.pop(context); /* Close Loading Process */
    //       _modelScanInvoice.imageUri = json.decode(data); /* Convert Data From Json To Object */
    //       Navigator.of(context).push( /* Navigate To Invoice Fill Information */
    //         MaterialPageRoute(builder: (context) => InvoiceInfo(_modelScanInvoice))
    //       );
    //     });
    //   }
    // });
    try {
      String _barcode = await BarcodeScanner.scan();
      dialogLoading(context); /* Enable Loading Process */
      await _postRequest.getReward(_barcode).then((onValue) async {
        if (onValue.containsKey('message'))
          await dialog(
            context,
            Text(onValue['message']),
            Icon(
              Icons.done_outline,
              color: getHexaColor(AppColors.lightBlueSky,)
            )
          );
          else await dialog(context, Text(onValue['error']['message']), warningTitleDialog());
          Navigator.pop(context); /* Disable Loading Process */
          if (onValue.containsKey('message')) fetchPortfolio();
        }
      );
    } on PlatformException catch (e) {} on FormatException {} catch (e) {}
  }

  void resetState(String barcodeValue, String executeName) { /* Request Portfolio After Trx QR Success */
    setState(() {
      _modelDashboard.portfolio = [];
    });
    fetchPortfolio();
    getUserData();
  }

  void toReceiveToken(BuildContext context) { /* Navigate Receive Token */
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GetWallet(
        _modelDashboard.userData.containsKey('wallet')
          ? _modelDashboard.userData['wallet']
          : null
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Bloc();
    return Scaffold(
      key: _modelDashboard.scaffoldKey,
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent
        ),
        child: DrawerLayout(_modelDashboard.userData, _packageInfo, drawerCallBack),
      ),
      body: scaffoldBGDecoration(
        left: 0.0, right: 0.0,
        child: Column(
          children: <Widget>[
            containerAppBar( /* AppBar */
              context,
              Row( /* Sub AppBar */
                children: <Widget>[
                  iconAppBar( /* Menu Button */
                    Icon(
                      Icons.sort,
                      color: Colors.white,
                    ),
                    Alignment.centerLeft,
                    EdgeInsets.all(0),
                    (){ // Trigger To Open Drawer
                      _modelDashboard.scaffoldKey.currentState.openDrawer();
                    }
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset(
                          AppConfig.logoAppBar,
                          height: 25.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ),
            Expanded( /* Body Widget */
              child: SmartRefresher(
                physics: BouncingScrollPhysics(),
                controller: _modelDashboard.refreshController,
                child: dashboardBody(
                  context,
                  bloc,
                  _modelDashboard.chartKey,
                  _modelDashboard.portfolio,
                  _modelDashboard
                ),
                onRefresh: _pullUpRefresh,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          double brightness = await Screen.brightness;
          print(brightness);
          Screen.setBrightness(100.0);
        },
        child: Text("Hello")
      ),
      // SizedBox(
      //   width: 150.0,
      //   height: 150.0,
      //   child: GestureDetector(
      //     child: CustomAnimation.flareAnimation(_flareControls, "assets/animation/fabs.flr", action),
      //     onTap: (){
      //       setState((){
      //         if (action == "active") action = "deactive";
      //         else action = "active";
      //       });
      //     },
      //   )
      // ),
      // bottomNavigationBar: 
      // // BottomAppBar(
      // // )
      // Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: <Widget>[
      //     Flexible(
      //       child: bottomAppBar( /* Bottom Navigation Bar */
      //         context,
      //         _modelDashboard,
      //         _modelDashboard.portfolio == null /* Error Dialog */
      //         ? () async {
      //           await dialog(
      //             context,
      //             Text("${_modelDashboard.portFolioResponse['error']['message']}"),
      //             warningTitleDialog()
      //           );
      //         }
      //         : () { /* Lamda Expression Or Annanymous Function Of Option Send Wallet */
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => SendWalletOption(
      //                 _modelDashboard.portfolio, resetState)
      //               )
      //             );
      //           // _modelDashboard.portfolio == null ? null : scanQR
      //         },
      //         (){}, // Bottom Center Button
      //         // _modelDashboard.portfolio == null
      //         // ? () async {
      //         //   await dialog(
      //         //     context,
      //         //     Text("${_modelDashboard.portFolioResponse['error']['message']}"),
      //         //     warningTitleDialog()
      //         //   );
      //         // }
      //         // : (scanReceipt),
      //         resetState,
      //         toReceiveToken
      //       ),
      //     )
      //   ],
      // )
    );
  }
}
