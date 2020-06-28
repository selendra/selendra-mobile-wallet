import 'package:wallet_apps/index.dart';

Widget allTrxBody(List<dynamic> _trxHistory, InstanceTrxOrder _instanceTrxOrder) {
  print(_trxHistory);
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m12, "All"),
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m11, "All"),
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m10, "All"),
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m9, "All"),
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m8, "All"),
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m7, "All"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m6, "All"),
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m5, "All"),
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m4, "All"),
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m3, "All"),
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m2, "All"),
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m1, "All")
      ],
    )
  );
  // ListView.builder(
  //   physics: BouncingScrollPhysics(),
  //   itemCount: _trxHistory.length,
  //   itemBuilder: (BuildContext context, int index) {
  //     return _trxHistory[index]["transaction_successful"] == true 
  //     ? GestureDetector(
  //       onTap: () {
  //         Navigator.push(context, transitionRoute(TrxHistoryDetails(_trxHistory[index], "All")));
  //       },
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
  //             children: <Widget>[
  //               /* Asset Icons */
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
  //                       : Text("XLM"),
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