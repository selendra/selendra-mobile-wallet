/* Package of flutter */
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'package:image_cropper/image_cropper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
/* Directory of file */
import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:wallet_apps/src/model/model_dashboard.dart';
import 'package:wallet_apps/src/model/model_scan_invoice.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/dashboard_reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/get_wallet_screen/get_wallet.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/profile_user.dart';
import 'package:wallet_apps/src/service/services.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/store_small_data/data_store.dart';
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

  ModelScanInvoice _modelScanInvoice = ModelScanInvoice();

  @override
  initState() { /* Initialize State */
    super.initState();  
    fetchUserToken(); /* Query User Id After Login From Local Storage */ 
    // getUser(); 
    getUserData(); /* User Profile */
    fetchPortfolio();
    // fetchWallet();
  }

  /* ---------------------------Rest Api--------------------------- */
  void getUserData() async { /* Fetch User Data From Memory */
    _modelDashboard.userWallet = await getUserProfile();
    setData(_modelDashboard.userWallet, "user_profile");
    // Map<String, dynamic> data = await fetchData('userDataLogin');
    // if (data == null) {
    //   setState(() {
    //     _modelDashboard.userData = {
    //       "queryUserById": null
    //     };
    //   });
    // } else _modelDashboard.userData = data;
  }

  void getStatus() async {
    var status = await fetchData("userStatusAndWallet");
    if ( status != null ) setState(() {});
  }

  void fetchPortfolio() async { /* Fetch Portofolio */
    _modelDashboard.portfolio = await getPortfolio();
    setData(_modelDashboard.portfolio, 'portFolioData');
    setState(() {});
  }

  /* ------------------------Method------------------------ */

  /* Open Menu */
  void openMenu() => blurBackgroundDecoration(context, ProfileUser()); /* Navigate To Profile User */

  /* Log Out Method */
  void logOut(BuildContext context) async{
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

  /* ------------------------Fetch Local Data Method------------------------ */
  void fetchUserToken() async { /* Fetch User Token */
    final portfolio = await Provider.fetchToken();
    _modelDashboard.token = portfolio['token'];
    // setState(() {
    //   _modelDashboard.userId = Provider.id`sUser;
    // });
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

  void scanReceipt() async { /* Receipt Scan Pay Process */
    File cropimage = await cropImageCamera(context); /* Crop Image From Back Camera */
    if (cropimage != null){
      dialogLoading(context); /* Show Loading Process */
      StreamedResponse _streamedResponse = await upLoadImage(cropimage, "upload"); /* POST Image And Wait Response Back */
      _streamedResponse.stream.transform(utf8.decoder).listen((data) async {
        Navigator.pop(context); /* Close Loading Process */
        _modelScanInvoice.imageUri = json.decode(data); /* Convert Data From Json To Object */
        Navigator.of(context).push( /* Navigate To Invoice Fill Information */
          MaterialPageRoute(builder: (context) => InvoiceInfo(_modelScanInvoice))
        );
      });
    }
  }

  void resetState(String barcodeValue, String executeName, ModelDashboard _model, Function fetchPortfolio) {
    setState(() {
      if (executeName == "portfolio") {
        _model.portfolio= null; 
        fetchPortfolio();
      } else if (executeName == "barcode") _model.barcode = barcodeValue;
    });
  }
  
  void toReceiveToken(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => GetWallet(_modelDashboard.userWallet['wallet'])));
  }
  
  @override
  Widget build(BuildContext context) {
    final bloc = Bloc();
    return Scaffold(
      key: _modelDashboard.scaffoldKey,
      // drawer: drawerOnly(context, _modelDashboard, "dashboardScreen", toReceiveToken),
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
                        openMenu
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
                    ),
                    // _modelDashboard.userData == null ? loading() // Body Widget
                    //   : _modelDashboard.userData['queryUserById'] == null 
                    //   ? reQuery(loading(), queryUser(_modelDashboard.userId), "Home", getUserData) : ,
                    onRefresh: _pullUpRefresh,
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
 