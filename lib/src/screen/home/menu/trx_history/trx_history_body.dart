import 'package:wallet_apps/index.dart';

Widget trxHistoryBody(
  BuildContext _context,
  List<dynamic> _trxSend,
  List<dynamic> _trxHistory,
  List<dynamic> _trxReceived,
  InstanceTrxOrder _instanceTrxSendOrder,
  InstanceTrxOrder _instanceTrxAllOrder,
  InstanceTrxOrder _instanceTrxReceivedOrder,
  String _walletKey,
  Function popScreen
) {
  return Container(
    margin: EdgeInsets.all(16.0),
    child: Column(
      children: <Widget>[
        containerAppBar( /* AppBar */
          _context, 
          Row(
            children: <Widget>[
              iconAppBar( /* Arrow Back Button */
                Icon(Icons.arrow_back, color: Colors.white,),
                Alignment.centerLeft,
                EdgeInsets.all(0),
                popScreen,
              ),
              containerTitle("Transaction History", double.infinity, Colors.white, FontWeight.normal)
            ],
          )
        ),
        Container( /* Tab Bar View */
          margin: EdgeInsets.only(top: 5.0),
          child: TabBar(
            unselectedLabelColor: getHexaColor("#FFFFFF"),
            indicatorColor: getHexaColor(AppColors.greenColor),
            labelColor: getHexaColor(AppColors.greenColor),
            labelStyle: TextStyle(fontSize: 18.0),
            tabs: <Widget>[
              FittedBox(child: Tab(child: Text('Send'))),
              FittedBox(child: Tab(child: Text('All'))),
              FittedBox(child: Tab(child: Text('Received'))),
            ],
          ),
        ),
        Expanded( /* Tabbar body */
          child: TabBarView(
            children: <Widget>[

              Container(),
              
              // _trxHistory == null ? Container(
              //   child: Text("No transaction", style: TextStyle(fontSize: 18.0)), 
              //   alignment: Alignment.center,
              // ) /* Retreive Porfolio Null => Have No List */ 
              // : _trxHistory.length == 0 ? Padding( padding: EdgeInsets.all(10.0), child: loading()) /* Show Loading Process At Portfolio List When Requesting Data */
              // : sendBody(_trxSend, _walletKey, _instanceTrxSendOrder),
              
              _trxHistory == null ? Container(
                child: Text("No transaction", style: TextStyle(fontSize: 18.0)), 
                alignment: Alignment.center,
              ) /* Retreive Porfolio Null => Have No List */ 
              : _trxHistory.length == 0 ? Padding( padding: EdgeInsets.all(10.0), child: loading()) /* Show Loading Process At Portfolio List When Requesting Data */
              : allTrxBody(_trxHistory, _instanceTrxAllOrder),

              Container()
              
              // _trxHistory == null ? Container(
              //   child: Text("No transaction", style: TextStyle(fontSize: 18.0)), 
              //   alignment: Alignment.center,
              // ) /* Retreive Porfolio Null => Have No List */ 
              // : _trxHistory.length == 0 ? Padding( padding: EdgeInsets.all(10.0), child: loading()) /* Show Loading Process At Portfolio List When Requesting Data */
              // : receivedTrxBody(_trxReceived, _walletKey),
            ],
          )
        )
      ],
    ),
  );
}