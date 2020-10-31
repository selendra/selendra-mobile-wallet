import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallet_apps/index.dart';

class Home extends StatefulWidget {
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  
  MenuModel menuModel = MenuModel();

  HomeModel _homeM = HomeModel();
  
  PostRequest _postRequest = PostRequest();

  GetRequest _getRequest = GetRequest();

  Backend _backend = Backend();

  PackageInfo _packageInfo;

  PortfolioM _portfolio = PortfolioM();

  // FlareControls _flareControls = FlareControls();

  String action = "no_action";

  @override
  initState() { /* Initialize State */
    _homeM.portfolioList = null;
    if(mounted) {
      _homeM.result = {};
      _homeM.globalKey = GlobalKey<ScaffoldState>();
      _homeM.total = 0;
      _homeM.circularChart = [
        CircularSegmentEntry(_homeM.emptyChartData, hexaCodeToColor(AppColors.cardColor))
      ];
      AppServices.noInternetConnection(_homeM.globalKey);
      _homeM.userData = {};
      /* User Profile */
      // getUserData();
      // fetchPortfolio();
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
    _backend.response = await _postRequest.loginByPhone("15894139", "123456");

    _backend.mapData = json.decode(_backend.response.body);

    await StorageServices.setData(_backend.mapData, 'user_token');

    setState(() {
      
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

    _portfolio.list = [];
    
    await Future.delayed(Duration(milliseconds: 10),(){
      setState(() {
        _homeM.portfolioList = [];
      });
    });

    try {
      /* Get Response Data */
      _backend.response = await _getRequest.getPortfolio();

      /* Covert String To Objects */
      await _portfolio.extractData(_backend.response);
      print(_backend.response.runtimeType);
      
      // Error Handling
      if (_portfolio.list[0].containsKey('error')){
        throw AssertionError(_portfolio.list[0]['error']['message']);
      }

      setState(() {
        _homeM.portfolioList = _portfolio.list;
      });
      StorageServices.setData(_homeM.portfolioList, 'portfolio'); /* Set Portfolio To Local Storage */
      resetDataPieChart(_homeM.portfolioList); 
    } catch (e){
      await dialog(
        context, 
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: textAlignCenter(text: "${e.message}")
            ),
          ],
        ), 
        warningTitleDialog()
      );
      print("Null");
      setState(() {
        _homeM.portfolioList = null; /* Set Portfolio Equal Null To Close Loading Process */
      });
    }
  }

  /* ------------------------Method------------------------ */

  void resetDataPieChart(List<dynamic> portfolio){
    
    if (_homeM.portfolioList.length != 0){
      
      _homeM.total = 0.0;

      _homeM.circularChart.clear(); // Clear Pie Data

      for (int i = 0; i < _homeM.portfolioList.length; i++){
        // Add Total
        _homeM.total += json.decode(_homeM.portfolioList[i]['balance']);
        
        _homeM.circularChart.add( //Add More Data Follow Portfolio
          CircularSegmentEntry(
            json.decode(_homeM.portfolioList[i]['balance']),
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

      _homeM.chartKey.currentState.updateData([
        CircularStackEntry(_homeM.circularChart)
      ]);

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
    setState(() {
      _homeM.portfolioList = [];
    });
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
          child: HomeBody(
            bloc: bloc,
            chartKey: _homeM.chartKey,
            portfolioData: _homeM.portfolioList,
            getWallet: createPin,
            homeModel: _homeM,
            // getWallet: createPin,
          )
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
