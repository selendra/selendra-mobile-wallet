// import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallet_apps/index.dart';

class TrxActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TrxActivityState();
  }
}

class TrxActivityState extends State<TrxActivity> {

  // final RefreshController _refreshController = RefreshController();

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  bool isProgress = true;
  bool isLogout = false;

  List<dynamic> _activity = [];

  GetRequest _getRequest = GetRequest();

  InstanceTrxOrder _instanceTrxOrder;

  @override
  void initState() {
    _instanceTrxOrder = InstanceTrxOrder();
    AppServices.noInternetConnection(_globalKey);
    fetchHistoryUser();
    super.initState();
  }

  void fetchHistoryUser() async { /* Request Transaction History */
    try {
      await _getRequest.getReceipt().then((_response) {
        if (List<dynamic>.from(_response).length == 0)
          _activity = null; /* Assign TransactionActivity Variable With NUll If Reponse Empty Data */
        else
          _activity = _response;
      });
      if (!mounted) return; /* Prevent SetState After Dispose */
      setState(() {});
    } on SocketException catch (e) {
      await dialog(context, Text("${e.message}"), Text("Message")); 
      snackBar(_globalKey, e.message.toString());
    } catch (e) {
      await dialog(context, Text(e.message.toString()), Text("Message")); 
    }
  }

  void sortByDate(List _trxHistory){
    _instanceTrxOrder = AppUtils.trxMonthOrder(_trxHistory);
  }

  /* Log Out Method */
  void logOut() { /* Loading */
    dialogLoading(context);
    AppServices.clearStorage();
    Timer(Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  /* Scroll Refresh */
  void reFresh() {
    setState(() {
      isProgress = true;
    });
    fetchHistoryUser();
    // _refreshController.refreshCompleted();
  }

  void popScreen() => Navigator.pop(context);

  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: BodyScaffold(
        height: MediaQuery.of(context).size.height,
        child: TrxActivityBody(
          activityList: _activity, 
          popScreen: popScreen
        ),
      )
    );
  }
}
