import 'package:wallet_apps/index.dart';

Widget sendBody(List<dynamic> _trx, String _walletKey, InstanceTrxOrder _instanceTrxOrder) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m12, "Send"),
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m11, "Send"),
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m10, "Send"),
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m9, "Send"),
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m8, "Send"),
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m7, "Send"),
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m6, "Send"),
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m5, "Send"),
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m4, "Send"),
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m3, "Send"),
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m2, "Send"),
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m1, "Send")
      ],
    )
  );
  // ListView.builder(
  //   physics: BouncingScrollPhysics(),
  //   itemCount: _trxHistory.length,
  //   itemBuilder: (BuildContext context, int index) {
  //     /* Send Trx If Source Account Address Equal Wallet Adddress */
  //     return _trxHistory[index].containsKey('from') && _walletKey == _trxHistory[index]['from'] 
  //     ? GestureDetector(
  //       onTap: () => Navigator.push(context, transitionRoute(TrxHistoryDetails(_trxHistory[index], "Send"))),
  //       child: Container(
  //         margin: EdgeInsets.only(bottom: 10.5),
  //         child: Container(
  //           margin: EdgeInsets.only(left: 4.0),
  //           padding: EdgeInsets.only(top: 20.38, bottom: 16.62),
  //           decoration: BoxDecoration(
  //             border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.1), width: 1.5))
  //           ),
  //           child: Row(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: <Widget>[ /* Asset Icons */
  //               Container(
  //                 margin: EdgeInsets.only(right: 9.5),
  //                 width: 31.0, 
  //                 height: 31.0,
  //                 child: CircleAvatar(
  //                   backgroundImage: AssetImage(AppConfig.logoTrxHistroy)
  //                 ),
  //               ),
  //               Expanded(
  //                 flex: 2,
  //                 child: Column( /* Asset name and date time */
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: <Widget>[
  //                     _trxHistory[index].containsKey("asset_code") 
  //                       ? Text(_trxHistory[index]["asset_code"])
  //                       : Text("XLM"),/*  */
  //                     Container(
  //                       child: Text(AppUtils.timeStampToDateTime(_trxHistory[index]['created_at'])),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //               Expanded(
  //                 flex: 0,
  //                 child: Text(
  //                   "Completed", 
  //                   style: TextStyle(color: getHexaColor(AppColors.greenColor)),
  //                 ),
  //               )
  //             ],
  //           ),
  //         )
  //       ),
  //     )
  //     : Container();
  //   },
  // );
}