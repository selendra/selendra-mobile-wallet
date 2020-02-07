import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:wallet_apps/src/model/model_dashboard.dart';
import 'package:wallet_apps/src/model/model_scan_invoice.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/dashboard_reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/get_wallet_screen/get_wallet.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/invoice_screen/invoice_info_screen/invoice_info.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/zee_chart_screen/zee_chart_body.dart';
import 'package:wallet_apps/src/store_small_data/data_store.dart';

class ZeeChart extends StatefulWidget {
  final ModelDashboard _modelDashboard;

  ZeeChart(this._modelDashboard);

  @override
  State<StatefulWidget> createState() {
    return ZeeChartState();
  }
}

class ZeeChartState extends State<ZeeChart> {
  ModelScanInvoice _modelScanInvoice = ModelScanInvoice();

  RefreshController _refreshController = RefreshController();

  void popScreen() {
    Navigator.pop(context);
  }

  void toReceiveToken(BuildContext context) async {
    /* Fetch Portofolio */
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                GetWallet(widget._modelDashboard.userData['wallet'])));
  }

  void resetState(String barcodeValue, String executeName,
      ModelDashboard _model, Function toReceiveToken) {
    setState(() {
      if (executeName == "portfolio") {
        _model.portfolio = null;
        toReceiveToken();
      } else if (executeName == "barcode") _model.barcode = barcodeValue;
    });
  }

  void dispose() {
    _modelScanInvoice.controlAmount.clear();
    _modelScanInvoice.controlBillNO.clear();
    _modelScanInvoice.controlLocation.clear();
    super.dispose();
  }

  Future<dynamic> cropImageCamera(BuildContext context) async {
    File image = await camera(); /* Trigger Behind Camera */
    dialogLoading(context); /* Show Loading Process */
    if (image != null) {
      await Future.delayed(
          Duration(milliseconds: 300),
          () => Navigator.pop(
              context)); /* Wait 300 Millisecond And Close Loading Process */
      File cropImage = await ImageCropper.cropImage(
          // maxHeight: 4096,
          // maxWidth: 1024,
          sourcePath: image.path,
          androidUiSettings: AndroidUiSettings(
            backgroundColor: Colors.black,
            // lockAspectRatio: false
          ));
      return cropImage;
    }
    await Future.delayed(
        Duration(milliseconds: 100),
        () => Navigator.pop(
            context)); /* Wait 300 Millisecond And Close Loading Process */
    return null;
  }

  void fetchPortfolio() async {
    /* Fetch Portofolio */
    setState(() {
      widget._modelDashboard.portfolio = [];
    });
    await getPortfolio().then((_response) async {
      /* Get Response Data */
      if ((_response.runtimeType.toString()) != "List<dynamic>" &&
          _response.runtimeType.toString() != "_GrowableList<dynamic>") {
        /* If Response DataType Not List<dynamic> */
        if (_response.containsKey("error")) {
          await dialog(
              context,
              Text("${_response['error']['message']}"),
              Icon(
                Icons.warning,
                color: Colors.yellow,
              ));
          setState(() {
            widget._modelDashboard.portfolio =
                null; /* Set Portfolio Equal Null To Close Loading Process */
          });
        }
      } else {
        setState(() {
          widget._modelDashboard.portfolio = _response;
        });
        setData(widget._modelDashboard.portfolio,
            'portfolio'); /* Set Portfolio To Local Storage */
      }
    });
  }

  void getUserData() async {
    /* Fetch User Data From Memory */
    widget._modelDashboard.userData = await getUserProfile();
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

  void scanReceipt() async {
    await cropImageCamera(context).then((_response) async {
      if (_response != null) {
        _modelScanInvoice.imageCapture = _response;
        /* Crop Image From Back Camera */
        if (_modelScanInvoice.imageCapture != null) {
          dialogLoading(context); /* Show Loading Process */
          StreamedResponse _streamedResponse = await upLoadImage(
              _modelScanInvoice.imageCapture,
              "upload"); /* POST Image And Wait Response Back */
          Navigator.pop(context); /* Close Loading Process */
          _streamedResponse.stream.transform(utf8.decoder).listen((data) async {
            _modelScanInvoice.imageUri =
                json.decode(data); /* Convert Data From Json To Object */
            Navigator.of(context).push(
                /* Navigate To Invoice Fill Information */
                MaterialPageRoute(
                    builder: (context) => InvoiceInfo(_modelScanInvoice)));
          });
        }
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: scaffoldBGDecoration(
            /* Background Decoration */
            16.0,
            16.0,
            16.0,
            0,
            color1,
            color2,
            Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    containerAppBar(
                        /* AppBar */
                        context,
                        Row(
                          /* Sub AppBar */
                          children: <Widget>[
                            iconAppBar(
                                /* Menu Button */
                                Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                Alignment.centerLeft,
                                EdgeInsets.all(0),
                                popScreen),
                            containerTitle("Zee Chart", double.infinity,
                                Colors.white, FontWeight.bold),
                            /* Title AppBar */
                            Expanded(
                              child: Container(),
                            ),
                            iconAppBar(
                                /* Earth Icon */
                                Image.asset(
                                  'assets/earthicon.png',
                                  width: 20.0,
                                  height: 20.0,
                                  color: Colors.white,
                                ),
                                Alignment.centerRight,
                                EdgeInsets.only(
                                    right: 11, left: 0, top: 0, bottom: 0),
                                null),
                          ],
                        )),
                    Expanded(
                      child: SmartRefresher(
                        controller: _refreshController,
                        onRefresh: _pullUpRefresh,
                        child: zeeChartBodyWidget(
                            context,
                            widget._modelDashboard.portfolio,
                            widget._modelDashboard),
                      ),
                    )
                  ],
                )
              ],
            )),
        /* Bottom Navigation Bar */
        bottomNavigationBar: bottomAppBar(
            context,
            widget._modelDashboard,
            widget._modelDashboard.portfolio == null ? null : scanQR,
            widget._modelDashboard.portfolio == null ? null : scanReceipt,
            resetState,
            toReceiveToken));
  }
}
