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
              
              if (trxHistory == null) loading()
              else trxHistory.isNotEmpty ? sendBody(trxSend, walletKey, instanceTrxSendOrder) : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/no_data.svg', height: 200),

                  MyText(
                    text: "There are no history found"
                  )
                ],
              ),

              if (trxHistory == null) loading()
              else trxHistory.isNotEmpty ? allTrxBody(trxHistory, instanceTrxAllOrder) : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/no_data.svg', height: 200),

                  MyText(
                    text: "There are no history found"
                  )
                ],
              ),

              if (trxHistory == null) loading()
              else trxHistory.isNotEmpty ? receivedTrxBody(trxReceived, walletKey, instanceTrxReceivedOrder) : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/no_data.svg', height: 200),

                  MyText(
                    text: "There are no history found"
                  )
                ],
              ),

            ],
          )
        )
      ],
    );
  }
}