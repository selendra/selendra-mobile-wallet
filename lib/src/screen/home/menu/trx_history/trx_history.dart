import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallet_apps/index.dart';

class TrxHistory extends StatefulWidget{

  final String _walletKey;

  TrxHistory(this._walletKey);

  @override
  State<StatefulWidget> createState() {
    return TrxHistoryState();
  }
}

class TrxHistoryState extends State<TrxHistory>{

  final RefreshController _refreshController = RefreshController();

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  bool isProgress = true; bool isLogout = false;

  List<dynamic> _history = [];

  GetRequest _getRequest = GetRequest();

  @override
  void initState() {
    AppServices.noInternetConnection(_globalKey);
    fetchHistoryUser();
    super.initState();
  }

  void fetchHistoryUser() async { /* Request Transaction History */
    await _getRequest.trxUserHistory().then((_response) async { /* Get Response Data */
      if ( (_response.runtimeType.toString()) != "List<dynamic>" && (_response.runtimeType.toString()) != "_GrowableList<dynamic>" ){ /* If Response DataType Not List<dynamic> */ 
        if (_response.containsKey("error")){
          if (this.mounted){ /* Prevent Future SetState */
            setState(() {
              _history = null; /* Set Portfolio Equal Null To Close Loading Process */
            });
          }
        }
      } else {
        if (this.mounted) { /* Prevent Future SetState */
          sortByDate(_response);
          setState(() {
            _history = _response;
          });
        }
      } 
    });
  }

  void sortByDate(List _trxHistory){
    InstanceTrxOrder _instanceTrxOrder = AppUtils.trxMonthOrder(_trxHistory);
    _instanceTrxOrder.m6.forEach((element) {
      print(element['created_at']);
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

  void popScreen() {
    Navigator.pop(context, {});
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        key: _globalKey,
        body: SafeArea(
          child: trxHistoryBody(context, _history, widget._walletKey, popScreen),
        ),
      ),
    );
  }
}
