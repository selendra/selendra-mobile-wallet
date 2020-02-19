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
    getUserData(); /* User Profile */
    fetchPortfolio();
    super.initState();
  }

  /* ---------------------------Rest Api--------------------------- */
  void getUserData() async { /* Fetch User Data From Memory */
    _modelDashboard.userData = await getUserProfile();
  }

  void fetchPortfolio() async { /* Fetch Portofolio */
    setState(() {
      _modelDashboard.portfolio = [];
    });
    await getPortfolio().then((_response) async { /* Get Response Data */
      if ( (_response.runtimeType.toString()) != "List<dynamic>" && _response.runtimeType.toString() != "_GrowableList<dynamic>"){ /* If Response DataType Not List<dynamic> */ 
        if (_response.containsKey("error")){
          await dialog(context, Text("${_response['error']['message']}"), Icon(Icons.warning, color: Colors.yellow,));
          setState(() {
            _modelDashboard.portfolio = null; /* Set Portfolio Equal Null To Close Loading Process */
          });
        }
      } else {
        setState(() {
          _modelDashboard.portfolio = _response;
        });
        setData(_modelDashboard.portfolio, 'portfolio'); /* Set Portfolio To Local Storage */
      }
    });
    print(_modelDashboard.portfolio);
  }

  /* ------------------------Method------------------------ */
  /* Open Menu */
  void openMenu() async { /* Navigate To Profile User */
    var _result = await Navigator.of(context).push(transitionRoute(ProfileUser(_modelDashboard.userData)));
    if (_result != "") fetchPortfolio();
  }

  /* Log Out Method */
  void logOut(BuildContext context) async{
    dialogLoading(context); /* Loading */
    clearStorage();
    await Future.delayed(Duration(seconds: 1), () {
      Navigator.pop(context);
      Navigator.of(context, rootNavigator: true).popAndPushNamed('/');
    });
  }

  /* ------------------------Fetch Local Data Method------------------------ */
  void snackBar() { /* Trigger Snackbar Function */
    final snackbar = SnackBar(
      content: Text('Hello world'),
    );
    _modelDashboard.scaffoldKey.currentState.showSnackBar(snackbar);
  }

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
    await cropImageCamera(context).then((_response) async { /* Crop Image From Back Camera */
      if (_response != null){
        _modelScanInvoice.imageCapture = _response;
        dialogLoading(context); /* Show Loading Process */
        StreamedResponse _streamedResponse = await upLoadImage(_modelScanInvoice.imageCapture, "upload"); /* POST Image And Wait Response Back */
        _streamedResponse.stream.transform(utf8.decoder).listen((data) async {
          Navigator.pop(context); /* Close Loading Process */
          _modelScanInvoice.imageUri = json.decode(data); /* Convert Data From Json To Object */
          Navigator.of(context).push( /* Navigate To Invoice Fill Information */
            MaterialPageRoute(builder: (context) => InvoiceInfo(_modelScanInvoice))
          );
        });
      }
    }); 
  }

  void _resetState(String barcodeValue, String executeName, ModelDashboard _model) { /* Request Portfolio After Trx QR Success */
    setState(() {
      _modelDashboard.portfolio = [];
    });
    fetchPortfolio();
    getUserData(); 
  }
  
  void toReceiveToken(BuildContext context) { /* Navigate Receive Token */
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => GetWallet(_modelDashboard.userData['wallet'])));
  }
  
  @override
  Widget build(BuildContext context) {
    final bloc = Bloc();
    return Scaffold(
      key: _modelDashboard.scaffoldKey,
      body: scaffoldBGDecoration(
        16, 16, 16, 0,
        color2, color1,
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
                  Padding(
                    padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset("assets/${_modelDashboard.titleAppBar}", height: 25.0, color: Colors.white,),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 5.0),
                          child: Text(
                            "YINKOK",
                            style: TextStyle(
                              fontSize: 28.0
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
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
                  context, bloc, _modelDashboard.chartKey, _modelDashboard.portfolio, _modelDashboard
                ),
                onRefresh: _pullUpRefresh,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: bottomAppBar( /* Bottom Navigation Bar */
              context, 
              _modelDashboard, 
              _modelDashboard.portfolio == null ? null : scanQR, 
              _modelDashboard.portfolio == null ? null : scanReceipt, _resetState, toReceiveToken
            ),
          )
        ],
      )
    );
  }
}
 