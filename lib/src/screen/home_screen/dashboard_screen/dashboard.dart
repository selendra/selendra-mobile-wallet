/* Package of flutter */
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
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
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/qr_scan_pay_screen/scan_pay.dart';
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

  bool isProgress = false, isQueried = false, loadingHome = true;
  final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();
  final RefreshController _refreshController = RefreshController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, dynamic> userData, userWallet;
  dynamic portfolioData;
  String userId; String barcode;
  
  List<Widget> listScreens; int tabIndex = 0;

  @override
  initState() {
    /* Init State */
    super.initState();  
    /* Query User Id After Login From Local Storage */
    fetChIds();
    /* Query All User Data From Local Storage */
    getUserData();
    fetchPortfolio();
    fetchWallet();
    /* Method Wait For Build COmplete */
    // WidgetsBinding.instance.addPostFrameCallback(_onBuildCompleted());
  }
  // _onBuildCompleted() {
  //   fetchPortfolio();
  //   setState(() {});
  //   // print('Hello world');
  // }

  /* Fetch User ID */
  void fetChIds() async {
    await Provider.fetchUserIds();
    setState(() {
      userId = Provider.idsUser;
    });
  }

  /* Fetch User Data From Memory */
  void getUserData() async {
    Map<String, dynamic> data = await fetchData('userDataLogin');
    if (data == null) {
      setState(() {
        userData = {
          "queryUserById": null
        };
      });
    } else userData = data;
  }

  void getStatus() async {
    var status = await fetchData("userStatusAndWallet");
    if ( status != null ) setState(() {});
  }

  /* Open Drawer Method */
  void openDrawer() => _scaffoldKey.currentState.openDrawer();

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
  void saveUserLogin(QueryResult result) {
    if (result.data != null) setData(result.data, 'userLogin');
  }

  /* Scan QR Code */
  Future scanQR() async {
    try {
      String barcode = await BarcodeScanner.scan();
      var response = await Navigator.push(context, MaterialPageRoute(builder: (context) => ScanPayWidget(barcode)));
      if (response == "succeed") {
        setState(() {portfolioData = null;});
        fetchPortfolio();
      }
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = "The user did not grant the camera permission!";
        });
      } else {
        setState(() {
          this.barcode = "Unknown error: $e";
        });
      }
    } on FormatException {
      setState(() {
        this.barcode = "null (User returned using the 'back' -button before scanning anything. Result)";
      });
    } catch (e){
      setState(() {
        this.barcode = "Unknown error: $e";
      });
    }
  }

  
  void fetchPortfolio() async { /* Fetch Portofolio */
    var response = await userPorfolio();
      setData(response, 'portFolioData');
      portfolioData = response;
      setState(() {});
  }

  
  void fetchWallet() async { /* Fetch Only User ID */
    userWallet = await fetchData("userStatusAndWallet");
    Future.delayed(Duration(seconds: 1), () {
      setState(() { });
    });
  }
  
  void snackBar() { /* Trigger Snackbar Function */
    final snackbar = SnackBar(
      content: Text('Hello world'),
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  _pullUpRefresh() async {
    setState(() {
      portfolioData = null;
      userData['queryUserById'] = null;
    });
    fetchPortfolio();
    _refreshController.refreshCompleted();
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
    //   StreamedResponse response = await upLoadImage(cropimage, "uploadreceipt");
    //   response.stream.transform(utf8.decoder).listen((data) async {
    //     Map<String, dynamic> result = await json.decode(data);result['uuid']
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ReceiptVerify("Hello")));
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
  
  @override
  /* Widget builder */
  Widget build(BuildContext context) {
    final bloc = Bloc();
    return Scaffold(
      key: _scaffoldKey,
      drawer: drawerOnly(context, "dashboardScreen", logOut),
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
                    controller: _refreshController,
                    child: userData == null ? loading() // Body Widget
                      : userData['queryUserById'] == null 
                      ? reQuery(loading(), queryUser(userId), "Home", getUserData) : dashboardBodyWidget(
                        bloc, _chartKey, portfolioData,
                      ),
                    onRefresh: _pullUpRefresh,
                  ),
                )
              ],
            ),
        //   ],
        // )
      ),
      /* Bottom Navigation Bar */
      bottomNavigationBar: bottomAppBar(context, userWallet, scanQR, scanReceipt)
    );
  }
}
 