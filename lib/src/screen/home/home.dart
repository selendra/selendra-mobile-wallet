import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallet_apps/index.dart';
import 'package:fl_chart/fl_chart.dart';

class Home extends StatefulWidget {
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> with TickerProviderStateMixin {

  GlobalKey<AnimatedCircularChartState> chartKey = new GlobalKey<AnimatedCircularChartState>();
  
  MenuModel menuModel = MenuModel();

  HomeModel _homeM = HomeModel();
  
  PostRequest _postRequest = PostRequest();

  GetRequest _getRequest = GetRequest();

  Backend _backend = Backend();

  PackageInfo _packageInfo;

  PortfolioM _portfolioM = PortfolioM();

  // FlareControls _flareControls = FlareControls();

  String action = "no_action";

  @override
  initState() { /* Initialize State */
    _homeM.portfolioList = null;
    _portfolioM.list = [];
    if(mounted) {
      _homeM.result = {};
      _homeM.globalKey = GlobalKey<ScaffoldState>();
      _homeM.total = 0;
      _homeM.circularChart = [
        // CircularSegmentEntry(40, hexaCodeToColor(AppColors.secondary)),
        CircularSegmentEntry(_homeM.emptyChartData, hexaCodeToColor(AppColors.cardColor))
      ];
      // AppServices.noInternetConnection(_homeM.globalKey);
      _homeM.userData = {};
      /* User Profile */
      // getUserData();
      fetchPortfolio();
      triggerDeviceInfo();
      if (Platform.isAndroid) appPermission();
      // fabsAnimation();
    }

    menuModel.result.addAll({
      "pin": '',
      "confirm": '',
      "error": ''
    });

    super.initState();
  }

  void login() async {
    await _postRequest.loginByPhone('15894139', '123456').then((value) {
      _backend.mapData = json.decode(value.body);
      StorageServices.setData(_backend.mapData, 'user_token');
    }); 
  }

  // Initialize Fabs Animation
  void fabsAnimation(){ 
    _homeM.animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    _homeM.degOneTranslationAnimation = Tween(begin: 0.0, end: 1.0).animate(_homeM.animationController);
    setState((){});
    _homeM.animationController.addListener(() {
      setState(() {
        
      });
    });
  }

  void opacityController(bool visible){
    setState(() {
      if (visible){ 
        _homeM.visible = false;
      } else  if (visible == false) {
        _homeM.visible = true;
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
  Future<void> getUserData() async { /* Fetch User Data From Memory */
    await _getRequest.getUserProfile().then((data) {
      setState(() {
        if (data == null)
          _homeM.userData = {};
        else
          _homeM.userData = data;
      });
    });
  }

  void triggerDeviceInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();
    setState(() {});
  }

  /* Fetch Portofolio */
  Future<void> fetchPortfolio() async { 
    
    await Future.delayed(Duration(milliseconds: 10),(){
      setState(() {
        _homeM.portfolioList = [];
        _portfolioM.list = [];
      });
    });

    await Future.delayed(Duration(seconds: 2), (){});

    try {
      /* Get Response Data */
      // _backend.response = await _getRequest.getPortfolio();
      
      _backend.response = await _getRequest.getPortfolio();

      _backend.mapData = json.decode(_backend.response.body);

      print(_backend.response);
      
      if (_backend.response != null) {
        _backend.mapData = json.decode(_backend.response.body);

        setState(() {
          _portfolioM.list.add(_backend.mapData);
        });

        StorageServices.setData(_portfolioM.list, 'portfolio'); /* Set Portfolio To Local Storage */
        await resetDataPieChart(_portfolioM.list); 
      }

    //   /* Covert String To Objects */
    //   await _portfolioM.extractData(_backend.response);
    //   print(_backend.response.runtimeType);
      
    //   // Error Handling
    //   if (_portfolioM.list[0].containsKey('error')){
    //     throw AssertionError(_portfolioM.list[0]['error']['message']);
    //   }

      // setState(() {
      //   _homeM.portfolioList = _portfolioM.list;
      // });
    } catch (e){
      print(e);
      await dialog(
        context, 
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: textAlignCenter(text: "{e.message}")
            ),
          ],
        ), 
        warningTitleDialog()
      );
      setState(() {
        _portfolioM.list = null; /* Set Portfolio Equal Null To Close Loading Process */
      });
    }
  }

  /* ------------------------Method------------------------ */

  Future<void> resetDataPieChart(List<dynamic> portfolio){
    
    if (portfolio.length != 0){
      
      _homeM.total = 0.0;

      _homeM.circularChart.clear(); // Clear Pie Data

      for (int i = 0; i < portfolio.length; i++){
        print(portfolio[i]['data']['balance']);
        // Add Totalportfolio
        _homeM.total += json.decode(portfolio[i]['data']['balance']);
        
        _homeM.circularChart.add( //Add More Data Follow Portfolio
          CircularSegmentEntry(
            json.decode(portfolio[i]['data']['balance']),
            hexaCodeToColor(AppColors.secondary)
          )
        );
      }
      _homeM.emptyChartData -= _homeM.total;
      _homeM.circularChart.add( // Add Remain Empty Data
        CircularSegmentEntry(
          _homeM.emptyChartData,
          hexaCodeToColor(AppColors.cardColor)
        )
      );

      // Await Around 500 Millisecond 
      Timer(Duration(seconds: 1), (){
        chartKey.currentState.updateData([
          CircularStackEntry(_homeM.circularChart)
        ]);
      });

      _homeM.emptyChartData = 100.0; // Reset Remain Pie Data
    }
  }
  
  void menuCallBack(Map<String, dynamic> result) async {

    if (result != null){
      
      _backend.mapData = await StorageServices.fetchData("getWallet");

      if (result.isNotEmpty){
        // Log Out
        if (result.containsKey('log_out')){
          Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Welcome()), 
          );
        }
        else if (result['dialog_name'] == "addAssetScreen") {
          await fetchPortfolio();
        }
        else if (result['dialog_name'] == 'edit_profile') {
          await getUserData();
        }
      }

      // If Get Wallet
      if (_backend.mapData != null ){
        await fetchPortfolio();
        await StorageServices.removeKey("getWallet");
      }
    }
  }

  /* ------------------------Fetch Local Data Method------------------------ */
  
  // Refech Data User And Portfolio
  _pullUpRefresh() async { 
    _portfolioM.list = [];
    fetchPortfolio();
    getUserData();
    _homeM.refreshController.refreshCompleted();
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
      var _barcode = await BarcodeScanner.scan();
      dialogLoading(context); /* Enable Loading Process */
      await _postRequest.getReward(_barcode.rawContent).then((onValue) async {
        if (onValue.containsKey('message'))
          await dialog(
            context,
            Text(onValue['message']),
            Icon(
              Icons.done_outline,
              color: hexaCodeToColor(AppColors.lightBlueSky,)
            )
          );
          else await dialog(context, Text(onValue['error']['message']), warningTitleDialog());
          // Disable Loading Process
          Navigator.pop(context); 
          if (onValue.containsKey('message')) fetchPortfolio();
        }
      );
    } catch (e) {
      await Future.delayed(Duration(milliseconds: 300), () { });
      AppServices.openSnackBar(_homeM.globalKey, e.message);
    }
  }

  Future<void> createPin() async { /* Set PIN Dialog */
    _homeM.result = await Navigator.push(
      context, MaterialPageRoute(
        builder: (context) => Pin()
      )
    );

    if (_homeM.result != null){
      snackBar(_homeM.globalKey, "Successfully copy!Please keep your private key to safe place");
    }
  }

  void resetState(String barcodeValue, String executeName) { /* Request Portfolio After Trx QR Success */
    setState(() {
      _homeM.portfolioList = [];
    });
    fetchPortfolio();
    getUserData();
  }

  void toReceiveToken() async { /* Navigate Receive Token */
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ReceiveWallet(homeM: _homeM)
      )
    );
    if(Platform.isAndroid) await AndroidPlatform.resetBrightness();
    else await IOSPlatform.resetBrightness(IOSPlatform.defaultBrightnessLvl);
  }

  void openMyDrawer(){
    _homeM.globalKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    
    final bloc = Bloc();

    return Scaffold(
      key: _homeM.globalKey,
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent
        ),
        child: Menu(_homeM.userData, _packageInfo, menuCallBack),
      ),
      body: SmartRefresher(
        physics: BouncingScrollPhysics(),
        controller: _homeM.refreshController,
        child: BodyScaffold(
          height: MediaQuery.of(context).size.height,
          child: 
          Column(
      children: [

        MyHomeAppBar(
          title: "SELENDRA", 
          action: () {
            MyBottomSheet().notification(context: context);
          },
        ),

        Expanded(
          child: Stack(
            children: [

              if (_portfolioM.list == null) Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/no_data.svg', width: 200, height: 200),
                          
                          MyFlatButton(
                            edgeMargin: EdgeInsets.only(top: 50),
                            width: 200,
                            textButton: "Get wallet",
                            action: createPin,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              

              // else 

              // Container(child: Text("Helo world", style: TextStyle(color: Colors.red))), 
              Opacity(
                opacity: _portfolioM.list != null && _portfolioM.list.length != 0 ? 1 : 0,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      MyCircularChart(
                        amount: "${_homeM.total}",
                        chartKey: chartKey, 
                        listChart: _homeM.circularChart,
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                        padding: EdgeInsets.all(16.0),
                        width: double.infinity,
                        height: 222,
                        decoration: BoxDecoration(
                          color: hexaCodeToColor(AppColors.cardColor),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: LineChart(
                          mainData(),
                          swapAnimationDuration: Duration(seconds: 1),
                        ),
                      ),

                      Container( /* Portfolio Title */
                        alignment: Alignment.centerLeft,
                        child: MyText(
                          bottom: 26,
                          left: 16,
                          text: "Portfolioes",
                          fontSize: 20,
                          color: "#FFFFFF",
                        )
                      ),

                      MyRowHeader(),

                      Container(
                        constraints: BoxConstraints(
                          minHeight: 70,
                          maxHeight: 300
                        ),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context, 
                              MaterialPageRoute(
                                builder: (context) => Portfolio(listData: _portfolioM.list, listChart: _homeM.circularChart),
                              )
                            );
                          },
                          child: buildRowList(_portfolioM.list)
                        ),
                      )
                    ],
                  ),
                ),
              ),

              if (_portfolioM.list != null) 
                if (_portfolioM.list.length == 0) loading(),
            ],
          ),
        )
      ],
    ),
    //       HomeBody(
    //         bloc: bloc,
    //         chartKey: chartKey,
    //         portfolioData: _homeM.portfolioList,
    //         _portfolioM: _portfolioM,
    //         getWallet: createPin,
    //         _homeM: _homeM,
    //         // getWallet: createPin,
    //       )
        ),
        onRefresh: _pullUpRefresh,
      ),

      floatingActionButton: SizedBox(
        width: 64, height: 64,
        child: FloatingActionButton(
          backgroundColor: hexaCodeToColor(AppColors.secondary),
          child: SvgPicture.asset('assets/sld_qr.svg', width: 30, height: 30),
          onPressed: () async {
            await TrxOptionMethod.scanQR(context, _homeM.portfolioList, resetState);
          },
        )
      ),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: MyBottomAppBar( /* Bottom Navigation Bar */
        model: _homeM,
        postRequest: _postRequest,
        scanReceipt: null, // Bottom Center Button
        resetDbdState: resetState,
        toReceiveToken: toReceiveToken,
        opacityController: opacityController,
        openDrawer: openMyDrawer,
      )
    );
  }
}
