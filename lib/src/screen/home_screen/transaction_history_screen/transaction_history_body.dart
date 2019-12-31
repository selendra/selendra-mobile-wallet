import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:flutter/material.dart';
import 'package:wallet_apps/src/screen/home_screen/transaction_history_screen/tab_bars_list/all_transaction.dart';
import 'package:wallet_apps/src/screen/home_screen/transaction_history_screen/tab_bars_list/received_transaction.dart';
import 'package:wallet_apps/src/screen/home_screen/transaction_history_screen/tab_bars_list/send_transaction.dart';

Widget transactionBodyWidget(
  BuildContext context,
  List<Map<String, dynamic>> history, 
  Function popScreen
) {
  return Container(
    margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
    child: Column(
      children: <Widget>[
        containerAppBar( /* AppBar */
          context, 
          Row(
            children: <Widget>[
              iconAppBar( /* Arrow Back Button */
                Icon(Icons.arrow_back, color: Colors.white,),
                Alignment.centerLeft,
                EdgeInsets.all(0),
                popScreen,
              ),
              containerTitle("Transactin History", double.infinity, Colors.white, FontWeight.bold)
            ],
          )
        ),
        Container( /* Tab Bar View */
          margin: EdgeInsets.only(top: 5.0),
          child: TabBar(
            unselectedLabelColor: getHexaColor("#FFFFFF"),
            indicatorColor: getHexaColor(greenColor),
            labelColor: getHexaColor(greenColor),
            labelStyle: TextStyle(fontSize: 18.0),
            tabs: <Widget>[
              Tab(child: Text('All'),),
              Tab(child: Text('Received'),),
              Tab(child: Text('Send'),)
            ],
          ),
        ),
        Expanded( /* Tabbar body */
          child: TabBarView(
            children: <Widget>[
              allBodyWidget(),
              receivedBodyWidget(history),
              sendBodyWidget()
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
  //         child: history == null ? textNotification("No History", context) : bodyWidget(context, history, _containerKey, _containerSize, _height),
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
  //             itemCount: history.length,
  //             itemBuilder: (BuildContext context, int index) {
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
  //                         child: Text('${DateTime.parse(history[index]['trxat']).toLocal()}', style: TextStyle(color: Colors.white),),
  //                       ),
  //                       Text(history[index]['type'], style: TextStyle(color: Colors.white),)
  //                     ],
  //                   ),
  //                   onTap: () {
  //                     showDialog(
  //                       context: context,
  //                       builder: (BuildContext context){
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
  //                               Text("Type: ${history[index]['type']}"),
  //                               Text("Amount: ${history[index]['amount']}"),
  //                               Text("Asset: ${history[index]['asset']}"),
  //                               Text("From: ${history[index]['from']}"),
  //                               Text("To: ${history[index]['to']}"),
  //                               Text("Date: ${history[index]['trxat']}")
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