import 'package:flare_flutter/flare_controls.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/model/portfolio.dart';

class Dashboard extends StatefulWidget {
  State<StatefulWidget> createState() {
    return DashboardState();
  }
}

class DashboardState extends State<Dashboard> with TickerProviderStateMixin {

  ModelDashboard _modelDashboard = ModelDashboard();
  
  PostRequest _postRequest = PostRequest();

  GetRequest _getRequest = GetRequest();

  Backend _backend = Backend();

  PackageInfo _packageInfo;

  // FlareControls _flareControls = FlareControls();

  String action = "no_action";

  @override
  initState() { /* Initialize State */
    _modelDashboard.result = {};
    _modelDashboard.scaffoldKey = GlobalKey<ScaffoldState>();
    _modelDashboard.total = 0;
    _modelDashboard.circularChart = [
      CircularSegmentEntry(_modelDashboard.remainDataChart, getHexaColor("#4B525E"))
    ];
    AppServices.noInternetConnection(_modelDashboard.scaffoldKey);
    _modelDashboard.userData = {};
    /* User Profile */
    getUserData(); 
    fetchPortfolio();
    triggerDeviceInfo();
    if (Platform.isAndroid) appPermission();
    // fabsAnimation();
    
    super.initState();
  }

  // Initialize Fabs Animation
  void fabsAnimation(){ 
    _modelDashboard.animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    _modelDashboard.degOneTranslationAnimation = Tween(begin: 0.0, end: 1.0).animate(_modelDashboard.animationController);
    setState((){});
    _modelDashboard.animationController.addListener(() {
      setState(() {
        
      });
    });
  }

  void opacityController(bool visible){
    setState(() {
      if (visible){ 
        _modelDashboard.visible = false;
      } else  if (visible == false) {
        _modelDashboard.visible = true;
      }
    });
  }

  Future<void> appPermission() async { 
    await AndroidPlatform.checkPermission().then((value) async {
      if (value == false){
        await Component.messagePermission(
          context: context,
          content: "We suggest you to enable permission on apps",
          method: () async {
            await AndroidPlatform.writePermission();
            Navigator.pop(context);
          }
        );
      }
    });
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

  /* Fetch Portofolio */
  void fetchPortfolio() async { 
    await Future.delayed(Duration(milliseconds: 10),(){
      setState(() {
        _modelDashboard.portfolioList = [];
      });
    });
    
    /* Get Response Data */
    _backend.response = await _getRequest.getPortfolio();
    print("Portfolio ${_backend.response}");
    
    /* Covert String To Objects */
    Portfolio.extractData(_backend.response);

    if (Portfolio.list[0].containsKey('error')){
      await dialog(
        context, 
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: textAlignCenter(text: "${Portfolio.list[0]['error']['message']}")
            ),
          ],
        ), 
        warningTitleDialog()
      );
      setState(() {
        _modelDashboard.portfolioList = null; /* Set Portfolio Equal Null To Close Loading Process */
      });
    }  else {
      setState(() {
        _modelDashboard.portfolioList = Portfolio.list;
      });
      StorageServices.setData(_modelDashboard.portfolioList, 'portfolio'); /* Set Portfolio To Local Storage */
      resetDataPieChart(_modelDashboard.portfolioList); 
    }
  }

  /* ------------------------Method------------------------ */

  void resetDataPieChart(List<dynamic> portfolio){
    
    if (_modelDashboard.portfolioList.length != 0){
      
      _modelDashboard.total = 0.0;

      _modelDashboard.circularChart.clear(); // Clear Pie Data

      for (int i = 0; i < _modelDashboard.portfolioList.length; i++){
        // Add Total
        _modelDashboard.total += json.decode(_modelDashboard.portfolioList[i]['balance']);
        
        _modelDashboard.circularChart.add( //Add More Data Follow Portfolio
          CircularSegmentEntry(
            json.decode(_modelDashboard.portfolioList[i]['balance']),
            getHexaColor(AppColors.greenColor)
          )
        );
      }
      _modelDashboard.remainDataChart -= _modelDashboard.total;
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
  
  void menuCallBack(dynamic result){

    if (result != null){
      // Log Out
      if (result == 'log_out'){
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Welcome()), 
          // ModalRoute.withName('/')
        );
      }
      // If Get Wallet
      else {
        _modelDashboard.result = result;
        if (_modelDashboard.result.length != 0) { // If Not Empty Excecute Statement
          if (
            _modelDashboard.result.containsValue("dialogPrivateKey") ||
            _modelDashboard.result.containsValue("addAssetScreen") 
          ) {
            _modelDashboard.result = {};
            fetchPortfolio();
          }
          getUserData();
        }
      }
    }
  }

  /* ------------------------Fetch Local Data Method------------------------ */
  
  _pullUpRefresh() async { /* Refech Data User And Portfolio */
    setState(() {
      _modelDashboard.portfolioList = [];
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
      _modelDashboard.portfolioList = [];
    });
    fetchPortfolio();
    getUserData();
  }

  void toReceiveToken(BuildContext context) async { /* Navigate Receive Token */
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GetWallet(
        _modelDashboard.userData.containsKey('wallet')
          ? _modelDashboard.userData['wallet']
          : null
        )
      )
    );
    if(Platform.isAndroid) await AndroidPlatform.resetBrightness();
    else await IOSPlatform.resetBrightness(IOSPlatform.defaultBrightnessLvl);
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
        child: DrawerLayout(_modelDashboard.userData, _packageInfo, menuCallBack),
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
                    // Trigger To Open Drawer
                    (){ 
                      _modelDashboard.scaffoldKey.currentState.openDrawer();
                    }
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        FittedBox(
                          fit: BoxFit.contain,
                          child: Text("SELENDRA", style: TextStyle(fontSize: 18.0),)
                        )
                        // Image.asset(
                        //   AppConfig.logoAppBar,
                        //   height: 25.0,
                        //   color: Colors.white,
                        // ),
                      ],
                    ),
                  ),
                ],
              )
            ),
            /* Body Widget */
            Expanded(
              child: SmartRefresher(
                physics: BouncingScrollPhysics(),
                controller: _modelDashboard.refreshController,
                child: dashboardBody(
                  context,
                  bloc,
                  _modelDashboard.chartKey,
                  _modelDashboard.portfolioList,
                  _modelDashboard
                ),
                onRefresh: _pullUpRefresh,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: getHexaColor("#8CC361"),
        child: Image.asset(
          AppConfig.logoBottomAppBar,
          color: Colors.white, width: 30.0, height: 30.0
        ),
        onPressed: () async {
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: bottomAppBar( /* Bottom Navigation Bar */
        context,
        _modelDashboard,
        _postRequest,
        null, // Bottom Center Button
        resetState,
        toReceiveToken,
        opacityController: opacityController,
      )
    );
  }
}
