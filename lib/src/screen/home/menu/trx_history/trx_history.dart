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

  List<dynamic> _trxHistory = [];
  List<dynamic> _trxSend = [];
  List<dynamic> _trxReceived = [];

  GetRequest _getRequest = GetRequest();

  PostRequest _postRequest = PostRequest();
  Backend _backend = Backend();

  InstanceTrxOrder _instanceTrxAllOrder;
  InstanceTrxOrder _instanceTrxSendOrder;
  InstanceTrxOrder _instanceTrxReceivedOrder;

  @override
  void initState() {
    login();
    _instanceTrxAllOrder = InstanceTrxOrder();
    _instanceTrxSendOrder = InstanceTrxOrder();
    _instanceTrxReceivedOrder = InstanceTrxOrder();
    AppServices.noInternetConnection(_globalKey);
    fetchHistoryUser();
    super.initState();
  }
  
  void login() async {
    _backend.response = await _postRequest.loginByPhone("15894139", "123456");

    _backend.mapData = json.decode(_backend.response.body);

    await StorageServices.setData(_backend.mapData, 'user_token');
  }

  void fetchHistoryUser() async { /* Request Transaction History */
    try {
      await _getRequest.trxUserHistory().then((_response) async { /* Get Response Data */
        if ( (_response.runtimeType.toString()) != "List<dynamic>" && (_response.runtimeType.toString()) != "_GrowableList<dynamic>" ){ /* If Response DataType Not List<dynamic> */ 
          if (_response.containsKey("error")){
            if (this.mounted){ /* Prevent Future SetState */
              setState(() {
                _trxHistory = null; /* Set Portfolio Equal Null To Close Loading Process */
              });
            }
          }
        } else {
          if (this.mounted) { /* Prevent Future SetState */
            collectByTrxType(_response);
            setState(() {
              _trxHistory = _response;
            });
          }
        } 
      });
    } catch (e) {
      await dialog(context, Text("${e.message}"), Text("Message"));
    }
  }

  void collectByTrxType(List _trxHistory){ // Collect Transaction By Type "Send", And Received
    _trxHistory.forEach((element) {
      if (element.containsKey('from') && widget._walletKey == element['from']){
        _trxSend.add(element);
      } else if (widget._walletKey != element['from'] && element['type'] != "manage_offer") { /* Send Trx If Source Account Address Not Equal Wallet Adddress */ 
        _trxReceived.add(element);
      }
    });
    sortByDate(_trxSend, "Send");
    sortByDate(_trxHistory, "All");
    sortByDate(_trxReceived, "Received");
  }

  void sortByDate(List _trxHistory, String tab){
    if (tab == "Send") {
      _instanceTrxSendOrder = AppUtils.trxMonthOrder(_trxHistory);
    } else if (tab == "All") {
      _instanceTrxAllOrder = AppUtils.trxMonthOrder(_trxHistory);
    } else if ( tab == "Received") {
      _instanceTrxReceivedOrder = AppUtils.trxMonthOrder(_trxHistory);
    }
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
        body: BodyScaffold(
          height: MediaQuery.of(context).size.height,
          child: TrxHistoryBody(
            trxSend: _trxSend,
            trxHistory: _trxHistory,
            trxReceived: _trxReceived,
            instanceTrxSendOrder: _instanceTrxSendOrder,
            instanceTrxAllOrder: _instanceTrxAllOrder,
            instanceTrxReceivedOrder: _instanceTrxReceivedOrder,
            walletKey: widget._walletKey, 
            popScreen: popScreen
          ),
        ),
      ),
    );
  }
}
