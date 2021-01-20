// import 'package:pull_to_refresh/pull_to_refresh.dart';
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

  // final RefreshController _refreshController = RefreshController();

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  bool isProgress = true; bool isLogout = false;

  List<dynamic> _trxHistoryData;
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
    _instanceTrxAllOrder = InstanceTrxOrder();
    _instanceTrxSendOrder = InstanceTrxOrder();
    _instanceTrxReceivedOrder = InstanceTrxOrder();
    AppServices.noInternetConnection(_globalKey);
    fetchHistory();
    super.initState();
  }
  
  void login() async {
    _backend.response = await _postRequest.loginByPhone("15894139", "123456");

    _backend.mapData = json.decode(_backend.response.body);

    await StorageServices.setData(_backend.mapData, 'user_token');
  }

  void fetchHistory() async { /* Request Transaction History */
    if (mounted){
      try {
        _backend.response = await _getRequest.trxHistory();

        _backend.listData = json.decode(_backend.response.body);
  
        setState(() {
          _trxHistoryData = _backend.listData;
          collectByTrxType(_trxHistoryData);
        });

        // if (_backend.listData.isNotEmpty){
        // } else {
        //   print("Empty boy");
        // }

        // .then((_response) async {
          
          // if ( (_response.runtimeType.toString()) != "List<dynamic>" && (_response.runtimeType.toString()) != "_GrowableList<dynamic>" ){ /* If Response DataType Not List<dynamic> */ 
          //   if (_response.containsKey("error")){
          //     if (this.mounted){ /* Prevent Future SetState */
          //       setState(() {
          //         _trxHistoryData = null; /* Set Portfolio Equal Null To Close Loading Process */
          //       });
          //     }
          //   }
          // } else {
          //   if (this.mounted) { /* Prevent Future SetState */
          //     collectByTrxType(_response);
          //   }
          // } 
        // });
      } on SocketException catch (e) {
        await dialog(context, Text("${e.message}"), Text("Message")); 
        snackBar(_globalKey, e.message.toString());
      } catch (e) {
        print("Error $e");
        await dialog(context, Text(e.message.toString()), Text("Message")); 
      }
    }
  }

  void collectByTrxType(List _trxHistoryData){ // Collect Transaction By Type "Send", And Received
    _trxHistoryData.forEach((element) {
      if (widget._walletKey == element['sender']){
        print("$element\n");
        _trxSend.add(element);
      } else if (widget._walletKey != element['sender']) { /* Send Trx If Source Account Address Not Equal Wallet Adddress */ 
        _trxReceived.add(element);
      }
    });
    sortByDate(_trxSend, "Send");
    sortByDate(_trxHistoryData, "All");
    sortByDate(_trxReceived, "Received");
  }

  void sortByDate(List _trxHistoryData, String tab){
    if (tab == "Send") {
      _instanceTrxSendOrder = AppUtils.trxMonthOrder(_trxHistoryData);
    } else if (tab == "All") {
      _instanceTrxAllOrder = AppUtils.trxMonthOrder(_trxHistoryData);
    } else if ( tab == "Received") {
      _instanceTrxReceivedOrder = AppUtils.trxMonthOrder(_trxHistoryData);
    }
  }

  /* Scroll Refresh */
  void reFresh() {
    setState(() {
      isProgress = true;
    });
    fetchHistory();
    // _refreshController.refreshCompleted();
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
            trxHistory: _trxHistoryData,
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
