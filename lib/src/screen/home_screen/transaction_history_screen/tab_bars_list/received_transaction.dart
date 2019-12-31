import 'package:flutter/material.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';

Widget receivedBodyWidget(List<dynamic> _receivedHistory) {
  return _receivedHistory.length != 0 
  ? ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: _receivedHistory.length,
      itemBuilder: (BuildContext context, int index) {
        return _receivedHistory[index]["transaction_successful"] == true 
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
                      _receivedHistory[index].containsKey("asset_code") 
                        ? Text(_receivedHistory[index]["asset_code"])
                        : Text("XLM"),
                      Container(
                        child: Text("14-10-2019 12:00"),
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
    ) 
  : loading(); /* Show Loading If History Length = 0 */
}