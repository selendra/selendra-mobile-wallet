/* Package of flutter */
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:image_cropper/image_cropper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
/* Directory of file */
import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:wallet_apps/src/model/model_dashboard.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/dashboard_reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/get_wallet_screen/get_wallet.dart';
import 'package:wallet_apps/src/service/services.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/store_small_data/data_store.dart';
import '../drawer_widget.dart';
import 'package:wallet_apps/src/bloc/bloc_provider.dart';
import './dashboard_body.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/invoice_screen/invoice_info_screen/invoice_info.dart';

class Dashboard extends StatefulWidget {

  State<StatefulWidget> createState() {
    return DashboardState();
  }
}

class DashboardState extends State<Dashboard> {
  
  ModelDashboard _modelDashboard = ModelDashboard();

  @override
  initState() { /* Initialize State */
    super.initState();  
    fetchUserToken(); /* Query User Id After Login From Local Storage */ 
    // getUser(); 
    getUserProfile();
    // getUserData(); /* Query All User Data From Local Storage */
    fetchPortfolio();
    // fetchWallet();
  }

  void fetchUserToken() async { /* Fetch User Token */
    final portfolio = await Provider.fetchToken();
    _modelDashboard.token = portfolio['token'];
    // setState(() {
    //   _modelDashboard.userId = Provider.id`sUser;
    // });
  }

  void getUserData() async { /* Fetch User Data From Memory */
    Map<String, dynamic> data = await fetchData('userDataLogin');
    if (data == null) {
      setState(() {
        _modelDashboard.userData = {
          "queryUserById": null
        };
      });
    } else _modelDashboard.userData = data;
  }

  void getStatus() async {
    var status = await fetchData("userStatusAndWallet");
    if ( status != null ) setState(() {});
  }

  /* Open Drawer Method */
  void openDrawer() => _modelDashboard.scaffoldKey.currentState.openDrawer();

  /* Log Out Method */
  void logOut() async{
    /* Loading */
    dialogLoading(context);
    clearStorage();
    await Future.delayed(Duration(seconds: 1), () {
      Navigator.pop(context);
      Navigator.of(context, rootNavigator: true).popAndPushNamed('/');
    });
  }

  /* Save User Login */
  void saveUserLogin() {
    // if (result.data != null) setData(result.data, 'userLogin');
  }

  void fetchPortfolio() async { /* Fetch Portofolio */
    _modelDashboard.portfolio = await getPortfolio();
    setData(_modelDashboard.portfolio, 'portFolioData');
    setState(() {});
  }

  void fetchWallet() async { /* Fetch Only User ID */
    _modelDashboard.userWallet = await fetchData("userStatusAndWallet");
    Future.delayed(Duration(seconds: 1), () {
      setState(() { });
    });
  }
  
  void snackBar() { /* Trigger Snackbar Function */
    final snackbar = SnackBar(
      content: Text('Hello world'),
    );
    _modelDashboard.scaffoldKey.currentState.showSnackBar(snackbar);
  }

  _pullUpRefresh() async {
    setState(() {
      _modelDashboard.portfolio = null;
      _modelDashboard.userData['queryUserById'] = null;
    });
    fetchPortfolio();
    _modelDashboard.refreshController.refreshCompleted();
  }

  Future<dynamic> cropImageCamera(BuildContext context) async {
    File image = await camera();
    dialogLoading(context);
    if (image != null) {
      Navigator.pop(context);
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
    Navigator.pop(context);
    return null;
  }

  void scanReceipt() async {
    // File cropimage = await cropImageCamera(context);
    // if (cropimage != null){
    //   dialogLoading(context);
    //   StreamedResponse portfolio = await upLoadImage(cropimage, "upload");
    //   portfolio.stream.transform(utf8.decoder).listen((data) async {
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

  void resetState(String barcodeValue, String executeName, ModelDashboard _model, Function fetchPortfolio) {
    setState(() {
      if (executeName == "portfolio") {
        _model.portfolio= null; 
        fetchPortfolio();
      } else if (executeName == "barcode") _model.barcode = barcodeValue;
    });
  }
  
  void toReceiveToken() {
    Navigator.of(context).push(BlurBackground(child: GetWallet(_modelDashboard.token)));
  }
  
  @override
  /* Widget builder */
  Widget build(BuildContext context) {
    final bloc = Bloc();
    return Scaffold(
      key: _modelDashboard.scaffoldKey,
      drawer: drawerOnly(context, _modelDashboard, "dashboardScreen", toReceiveToken),
      body: scaffoldBGDecoration(
        16, 16, 16, 0,
        color2, color1,
        // Stack(
        //   children: <Widget>[
            Column(
              children: <Widget>[
                containerAppBar( /* AppBar */
                  context, 
                  Row( /* Sub AppBar */
                    children: <Widget>[
                      iconAppBar( /* Menu Button */
                        Icon(Icons.sort, color: Colors.white,),
                        Alignment.centerLeft,
                        EdgeInsets.all(0),
                        openDrawer
                      ),
                      containerTitle("Dashboard", double.infinity, Colors.white, FontWeight.bold), /* Title AppBar */
                      Expanded(
                        child: Container(),
                      ),
                      iconAppBar( /* Earth Icon */
                        Image.asset('assets/earthicon.png',width: 20.0, height: 20.0, color: Colors.white,),
                        Alignment.centerRight,
                        EdgeInsets.only(right: 11, left: 0, top: 0, bottom: 0),
                        null
                      )
                    ],
                  )  
                ),    
                Expanded( /* Body Widget */
                  child: SmartRefresher(
                    physics: BouncingScrollPhysics(),
                    controller: _modelDashboard.refreshController,
                    child: dashboardBodyWidget(
                      context, bloc, _modelDashboard.chartKey, _modelDashboard.portfolio,
                    )
                    // _modelDashboard.userData == null ? loading() // Body Widget
                    //   : _modelDashboard.userData['queryUserById'] == null 
                    //   ? reQuery(loading(), queryUser(_modelDashboard.userId), "Home", getUserData) : ,
                    // onRefresh: _pullUpRefresh,
                  ),
                )
              ],
            ),
        //   ],
        // )
      ),
      bottomNavigationBar: bottomAppBar( /* Bottom Navigation Bar */
        context, 
        _modelDashboard, 
        scanQR, scanReceipt, resetState, toReceiveToken
      )
    );
  }
}
 