import 'package:flutter/material.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/profile_user_screen/my_activity_screen/my_activity_details_screen/my_activity_details.dart';

Widget buildListBodyWidget(List<dynamic> list) {
  return list.length != 0 
  ? ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        // return list[index]["transaction_successful"] == true 
        // ? 
        return GestureDetector(
          onTap: () {
            blurBackgroundDecoration(context, MyActivityDetails(list[index]));
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
                        Text(list[index]['location']),
                        // list[index].containsKey("asset_code") 
                        //   ? Text(list[index]["asset_code"])
                        //   : Text("XLM"),
                        Container(
                          child: Text(list[index]['created_at']),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: Text(
                      list[index]['status'], 
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
  : Expanded(child: loading(),); /* Show Loading If History Length = 0 */
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
            Expanded(child: Container(),),
            Text("$_data", style: TextStyle(fontSize: 18.0,))  /* Subtitle */
          ],
        ),
      ),
      Divider(height: 1, color: Colors.white.withOpacity(0.1), thickness: 1.0,),
    ],
  );
}