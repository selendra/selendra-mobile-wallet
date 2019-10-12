/* Package of flutter */
import 'package:Wallet_Apps/src/Bloc/Bloc.dart';
import 'package:Wallet_Apps/src/Graphql_Service/Query_Document.dart';
import 'package:Wallet_Apps/src/Graphql_Service/ReQueryGraphQL.dart';
import 'package:Wallet_Apps/src/Rest_Api/Rest_Api.dart';
import 'package:Wallet_Apps/src/Screen/HomeScreen/Home/ScanPay/ScanPayWidget.dart';
import 'package:Wallet_Apps/src/Services/Remove_All_Data.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter/services.dart';
/* Directory of file */
import 'package:Wallet_Apps/src/Provider/Reuse_Widget.dart';
import 'package:Wallet_Apps/src/Store_Small_Data/Data_Storage.dart';
import '../../../Provider/Hexa_Color_Convert.dart';
import '../Drawer.dart';
import '../../../Provider/Provider_General.dart';
import './HomeBodyWidget.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class HomeWidget extends StatefulWidget {

  State<StatefulWidget> createState() {
    return HomeWidgetState();
  }
}

class HomeWidgetState extends State<HomeWidget> {

  bool isProgress = false, isQueried = false, loadingHome = true;
  final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  Map<String, dynamic> userData;
  dynamic portfolioData;
  String userId;

  String barcode;

  @override
  initState() {
    /* Init State */
    super.initState();
    /* Query User Id After Login From Local Storage */
    fetChIds();
    /* Query All User Data From Local Storage */
    getUserData();
    fetchPortfolio();
    /* Method Wait For Build COmplete */
    // WidgetsBinding.instance.addPostFrameCallback(_onBuildCompleted());
  }
  // _onBuildCompleted() {
  //   fetchPortfolio();
  //   setState(() {});
  //   // print('Hello world');
  // }

  /* Fetch User Data From Memory */
  getUserData() async {
    Map<String, dynamic> data = await fetchData('userDataLogin');
    if (data == null) {
      setState(() {
        userData = {
          "queryUserById": null
        };
      });
    } else {
      userData = data;
    }
  }

  getStatus() async {
    var status = await fetchData("userStatusAndWallet");
    if ( status != null ) setState(() {});
  }

  void fetChIds() async {
    await Provider.fetchUserIds();
    setState(() {
      userId = Provider.idsUser;
    });
  }

  /* Open Drawer Method */
  void openDrawer() => _scaffoldKey.currentState.openDrawer();

  /* Log Out Method */
  void logOut() async{
    /* Loading */
    dialogLoading(context);
    await clearStorage();
    await Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  /* Save User Login */
  void saveUserLogin(QueryResult result) {
    if (result.data != null) setData(result.data, 'userLogin');
  }

  /* Scan QR Code */
  Future scan() async {
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

  void fetchPortfolio() async {
    var response = await userPorfolio();
    setData(response, 'portFolioData');
    portfolioData = response;
    setState(() {});
  }
  
  /* Trigger Snackbar Function */
  void snackBar() {
    final snackbar = SnackBar(
      content: Text('Hello world'),
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }
  Future<Null> _pullUpRefresh() async {
    fetchPortfolio();
    setState(() { });
    // await Future.delayed(const Duration(seconds: 1), (){
    //   setState(() {
    //     userData['queryUserById'] = null;
    //   });
    // });
    return null;
  }
  
  @override
  /* Widget builder */
  Widget build(BuildContext context) {
    final bloc = Bloc();
    return Scaffold(
      key: _scaffoldKey, 
      appBar: appbarWidget(openDrawer, zeetomicLogoTitle(), snackBar),
      drawer: drawerOnly(context, logOut),
      body: RefreshIndicator(
        color: Color(convertHexaColor(lightBlueSky)),
        backgroundColor: Colors.white,
        child: Stack(
          children: <Widget>[
            userData == null ? loading() 
            : userData['queryUserById'] == null 
            ? reQuery(bodyWidget(bloc, _chartKey, portfolioData), queryUser(userId), "Home", null) : bodyWidget(bloc, _chartKey, portfolioData),
          ],
        ),
        onRefresh: _pullUpRefresh,
      ),
      /* Bottom Navigation Bar */
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10.0,
        onTap: (index) async {
          if ( index == 0) scan();
          else if ( index == 1) {
            Navigator.pushReplacementNamed(context, '/profileScreen');
          }
          else if (index == 2) Navigator.pushNamed(context, '/getWalletScreen');
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(OMIcons.send),
            title: Text('Send')
          ),
          BottomNavigationBarItem(
            icon: Icon(OMIcons.accountCircle),
            title: Text('Me')
          ),
          BottomNavigationBarItem(
            icon: Icon(OMIcons.getApp),
            title: Text('Receive')
          ),
        ],
      ),
    );
  }
}
 