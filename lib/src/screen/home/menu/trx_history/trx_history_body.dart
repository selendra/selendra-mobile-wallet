import 'package:wallet_apps/index.dart';

Widget trxHistoryBody(
  BuildContext _context,
  List<dynamic> _trxHistory, 
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
              sendBody(_trxHistory, _walletKey),
              allTrxBody(_trxHistory),
              receivedTrxBody(_trxHistory, _walletKey),
            ],
          )
        )
      ],
    ),
  );
  // SmartRefresher(
  //       physics: BouncingScrollPhysics(),
  //       controller: _refreshController,
  //       child: isProgress == false ? Container(
  //         margin: EdgeInsets.all(size4),
  //         child: _trxHistory == null ? textNotification("No History", _context) : bodyWidget(_context, _trxHistory, _containerKey, _containerSize, _height),
  //       ) : loading(),
  //       onRefresh: _reFresh,
  //     )
  // SingleChildScrollView(
  //   child: Container(
  //     child: Padding(
  //       padding: EdgeInsets.only(top: 20.0,),
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: <Widget>[
  //           /* Title */
  //           Container(
  //             alignment: Alignment.centerLeft,
  //             padding: EdgeInsets.only(bottom: 10.0),
  //             child: Text('Transaction', style: TextStyle(color: Colors.white),),
  //           ),
  //           /* List History */
  //           ListView.builder(
  //             primary: false,
  //             shrinkWrap: true,
  //             itemCount: _trxHistory.length,
  //             itemBuilder: (BuildContext _context, int index) {
  //               return Container(
  //                 padding: EdgeInsets.all(0.0),
  //                 margin: EdgeInsets.only(top: size4),
  //                 decoration: BoxDecoration(
  //                   border: Border.all(width: size1, color: getHexaColor(borderColor)),
  //                   color: getHexaColor(highThenBackgroundColor),
  //                   borderRadius: BorderRadius.circular(size5)
  //                 ),
  //                 child: ListTile(
  //                   title: Row(
  //                     children: <Widget>[
  //                       Expanded(
  //                         child: Text('${DateTime.parse(_trxHistory[index]['trxat']).toLocal()}', style: TextStyle(color: Colors.white),),
  //                       ),
  //                       Text(_trxHistory[index]['type'], style: TextStyle(color: Colors.white),)
  //                     ],
  //                   ),
  //                   onTap: () {
  //                     showDialog(
  //                       _context: _context,
  //                       builder: (BuildContext _context){
  //                         return AlertDialog(
  //                           shape: RoundedRectangleBorder(
  //                             side: BorderSide(width: size1, color: getHexaColor(borderColor)),
  //                             borderRadius: BorderRadius.circular(size5)
  //                           ),
  //                           title: Align(
  //                             alignment: Alignment.center,
  //                             child: Text('Payment History'),
  //                           ),
  //                           content: Column(
  //                             mainAxisSize: MainAxisSize.min,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: <Widget>[
  //                               Text("Type: ${_trxHistory[index]['type']}"),
  //                               Text("Amount: ${_trxHistory[index]['amount']}"),
  //                               Text("Asset: ${_trxHistory[index]['asset']}"),
  //                               Text("From: ${_trxHistory[index]['from']}"),
  //                               Text("To: ${_trxHistory[index]['to']}"),
  //                               Text("Date: ${_trxHistory[index]['trxat']}")
  //                             ],
  //                           ),
  //                         );
  //                       }
  //                     );
  //                   },
  //                 ),
  //               );
  //             },
  //           )
  //           // Expanded(
  //           //   child: ,
  //           // )
  //         ],
  //       ),
  //     )
  //   ),
  // );
}