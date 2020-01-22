import 'package:flutter/material.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/activity_screen/activity_details_screen/activity_details.dart';
import 'package:wallet_apps/src/service/services.dart';

Widget buildListBodyWidget(List<dynamic> _activity) {
  return _activity != null ?
    _activity.length != 0 
    ? ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: _activity.length,
        itemBuilder: (BuildContext context, int index) {
          // return _activity[index]["transaction_successful"] == true 
          // ? 
          return GestureDetector(
            onTap: () {
              Navigator.push(context, transitonRoute(MyActivityDetails(_activity[index])));
            },
            child: Container(
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
                          Text(_activity[index]['location']),
                          // _activity[index].containsKey("asset_code") 
                          //   ? Text(_activity[index]["asset_code"])
                          //   : Text("XLM"),
                          Container(
                            child: Text(timeStampToDateTime(_activity[index]['created_at'])),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Text(
                        _activity[index]['status'], 
                        style: TextStyle(color: getHexaColor(greenColor)),
                      ),
                    )
                  ],
                ),
              )
            ),
          );
          // : Container();
        },
      ) 
    : loading()  /* Show Loading If History Length = 0 */
  : Align(
    alignment: Alignment.center,
    child: Text("No activity", style: TextStyle(fontSize: 18.0),),
  ); /* Show Text (No activity) If Respoonse Length = 0 */
}

Widget rowInformation(String title, dynamic _data) { /* Display Information By Row */
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text("$title", style: TextStyle(fontSize: 18.0,)), /* Title */
            Expanded(
              child: Text("$_data", style: TextStyle(fontSize: 18.0,), overflow: TextOverflow.ellipsis,textAlign: TextAlign.right,),
            )  /* Subtitle */
          ],
        ),
      ),
      Divider(height: 1, color: Colors.white.withOpacity(0.1), thickness: 1.0,),
    ],
  );
}