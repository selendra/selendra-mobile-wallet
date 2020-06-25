import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallet_apps/index.dart';

class TransactionActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TransactionActivityState();
  }
}

class TransactionActivityState extends State<TransactionActivity> {

  final RefreshController _refreshController = RefreshController();

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  bool isProgress = true;
  bool isLogout = false;

  List<dynamic> _activity = [];

  GetRequest _getRequest = GetRequest();

  @override
  void initState() {
    AppServices.noInternetConnection(_globalKey);
    fetchHistoryUser();
    super.initState();
  }

  void fetchHistoryUser() async { /* Request Transaction History */
    await _getRequest.getReceipt().then((_response) {
      if (List<dynamic>.from(_response).length == 0)
        _activity = null; /* Assign TransactionActivity Variable With NUll If Reponse Empty Data */
      else
        _activity = _response;
    });
    if (!mounted) return; /* Prevent SetState After Dispose */
    setState(() {});
  }

  /* Log Out Method */
  void logOut() {
    /* Loading */
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
    _refreshController.refreshCompleted();
  }

  void popScreen() => Navigator.pop(context);

  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: SafeArea(
        child: transactionActivityBody(context, _activity, popScreen),
      )
    );
  }
}
