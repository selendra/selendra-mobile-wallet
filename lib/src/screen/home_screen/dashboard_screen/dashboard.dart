/* Package of flutter */
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
/* Directory of file */
import 'package:wallet_apps/src/graphql/services/query_document.dart';
import 'package:wallet_apps/src/graphql/services/requery_graphql_widget.dart';
import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:wallet_apps/src/model/model_dashboard.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/dashboard_reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/qr_scan_pay_screen/scan_pay.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/profile_user.dart';
import 'package:wallet_apps/src/service/services.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/store_small_data/data_store.dart';
import '../drawer_widget.dart';
import 'package:wallet_apps/src/bloc/bloc_provider.dart';
import './dashboard_body.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/invoice_screen/invoice_info_screen/invoice_info.dart';

class HomeWidget extends StatefulWidget {

  State<StatefulWidget> createState() {
    return HomeWidgetState();
  }
}

class HomeWidgetState extends State<HomeWidget> {
  
  ModelDashboard _modelDashboard = ModelDashboard();

  @override
  initState() { /* Initialize State */
    super.initState();  
    fetChIds(); /* Query User Id After Login From Local Storage */  
    getUserData(); /* Query All User Data From Local Storage */
    fetchPortfolio();
    fetchWallet();
  }

  void fetChIds() async { /* Fetch User Token */
    final token = await Provider.fetchToken();
    print(token);
    // setState(() {
    //   _modelDashboard.userId = Provider.idsUser;
    // });
  }

  /* Fetch User Data From Memory */
  void getUserData() async {
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
    var response = await userPorfolio();
      setData(response, 'portFolioData');
      _modelDashboard.portfolioData = response;
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
      _modelDashboard.portfolioData = null;
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

  void resetState(String barcodeValue, String executeName, ModelDashboard _model, Function fetchPortfolio) {
    setState(() {
      if (executeName == "portfolio") {
        _model.portfolioData = null; 
        fetchPortfolio();
      } else if (executeName == "barcode") _model.barcode = barcodeValue;
    });
  }
  
  void pushProfile() {
    Future.delayed(Duration(milliseconds: 300), () {
      Navigator.of(context).push(BlurBackground(child: ProfileUserWidget()));
    });
  }
  
  @override
  /* Widget builder */
  Widget build(BuildContext context) {
    final bloc = Bloc();
    return Scaffold(
      key: _modelDashboard.scaffoldKey,
      drawer: drawerOnly(context, "dashboardScreen", pushProfile),
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
                      containerTitleAppBar("Dashboard"), /* Title AppBar */
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
                        bloc, _modelDashboard.chartKey, _modelDashboard.portfolioData,
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
      /* Bottom Navigation Bar */
      bottomNavigationBar: bottomAppBar(
        context, 
        _modelDashboard, 
        scanQR, scanReceipt, resetState, fetchPortfolio
      )
    );
  }
}
 