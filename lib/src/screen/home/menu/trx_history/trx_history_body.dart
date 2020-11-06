import 'package:wallet_apps/index.dart';

class TrxHistoryBody extends StatelessWidget{

  final List<dynamic> trxSend;
  final List<dynamic> trxHistory;
  final List<dynamic> trxReceived;
  final InstanceTrxOrder instanceTrxSendOrder;
  final InstanceTrxOrder instanceTrxAllOrder;
  final InstanceTrxOrder instanceTrxReceivedOrder;
  final String walletKey;
  final Function popScreen;

  TrxHistoryBody({
    this.trxSend,
    this.trxHistory,
    this.trxReceived,
    this.instanceTrxSendOrder,
    this.instanceTrxAllOrder,
    this.instanceTrxReceivedOrder,
    this.walletKey,
    this.popScreen,
  });

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        
        MyAppBar(
          title: "Transaction history",
          onPressed: popScreen,
        ),
        
        Container( /* Tab Bar View */
          padding: EdgeInsets.only(top: 5.0, bottom: 20.0),
          child: TabBar(
            unselectedLabelColor: hexaCodeToColor(AppColors.textColor),
            indicatorColor: hexaCodeToColor(AppColors.secondary_text),
            labelColor: hexaCodeToColor(AppColors.secondary_text),
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
              
              trxHistory == null ? Container(
                child: Text("No transaction", style: TextStyle(fontSize: 18.0)), 
                alignment: Alignment.center,
              ) /* Retreive Porfolio Null => Have No List */ 
              : trxHistory.length == 0 ? Padding( padding: EdgeInsets.all(10.0), child: loading()) /* Show Loading Process At Portfolio List When Requesting Data */
              : sendBody(trxSend, walletKey, instanceTrxSendOrder),
              
              // trxHistory == null ? Container(
              //   child: Text("No transaction", style: TextStyle(fontSize: 18.0)), 
              //   alignment: Alignment.center,
              // ) /* Retreive Porfolio Null => Have No List */ 
              // : trxHistory.length == 0 ? Padding( padding: EdgeInsets.all(10.0), child: loading()) /* Show Loading Process At Portfolio List When Requesting Data */
              // : 
              allTrxBody(trxHistory, instanceTrxAllOrder),

              trxHistory == null ? Container(
                child: Text("No transaction", style: TextStyle(fontSize: 18.0)), 
                alignment: Alignment.center,
              ) /* Retreive Porfolio Null => Have No List */ 
              : trxHistory.length == 0 ? Padding( padding: EdgeInsets.all(10.0), child: loading()) /* Show Loading Process At Portfolio List When Requesting Data */
              : receivedTrxBody(trxReceived, walletKey, instanceTrxReceivedOrder),

            ],
          )
        )
      ],
    );
  }
}