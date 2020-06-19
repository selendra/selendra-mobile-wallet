import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallet_apps/index.dart';

class TransactionHistory extends StatefulWidget{

  final String _walletKey;

  TransactionHistory(this._walletKey);

  @override
  State<StatefulWidget> createState() {
    return TracsactionHistoryState();
  }
}

class TracsactionHistoryState extends State<TransactionHistory>{

  final RefreshController _refreshController = RefreshController();

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  bool isProgress = true; bool isLogout = false;

  List<dynamic> _history = [];

  @override
  void initState() {
    AppServices.noInternetConnection(_globalKey);
    fetchHistoryUser();
    super.initState();
  }

  void fetchHistoryUser() async { /* Request Transaction History */
    await trxUserHistory().then((_response) async { /* Get Response Data */
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
          setState(() {
            _history = _response;
          });
        }
      } 
    });
  }

  /* Scroll Refresh */
  void _reFresh() {
    setState(() {
      isProgress = true;
    });
    fetchHistoryUser();
    _refreshController.refreshCompleted();
  }

  void popScreen() {
    print("Pop");
    Navigator.pop(context, {});
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        key: _globalKey,
        body: SafeArea(
          child: transactionHistoryBody(context, _history, widget._walletKey, popScreen),
        ),
      ),
    );
  }
}
