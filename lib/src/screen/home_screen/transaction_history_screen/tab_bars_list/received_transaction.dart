import 'package:flutter/material.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/service/services.dart';

Widget receivedBodyWidget(List<dynamic> list) {
  return list == null ? Container(
      child: Text("No transaction", style: TextStyle(fontSize: 18.0)), 
      alignment: Alignment.center,
    ) /* Retreive Porfolio Null => Have No List */ 
    : list.length == 0 ? Padding( padding: EdgeInsets.all(10.0), child: loading()) /* Show Loading Process At Portfolio List When Requesting Data */
    : ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return list[index]["transaction_successful"] == true 
        ? Container(
          margin: EdgeInsets.only(bottom: 10.5),
          child: Container(
            margin: EdgeInsets.only(left: 4.0),
            padding: EdgeInsets.only(top: 20.38, bottom: 16.62),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.1), width: 1.5))
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /* Asset Icons */
                Container(
                  margin: EdgeInsets.only(right: 9.5),
                  width: 31.0, 
                  height: 31.0,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/zeeicon_on_screen.png',
                    )
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column( /* Asset name and date time */
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      list[index].containsKey("asset_code") 
                        ? Text(list[index]["asset_code"])
                        : Text("XLM"),
                      Container(
                        child: Text(timeStampToDateTime(list[index]['created_at'])),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Text(
                    "Completed", 
                    style: TextStyle(color: getHexaColor(greenColor)),
                  ),
                )
              ],
            ),
          )
        )
        : Container();
      },
    );
}