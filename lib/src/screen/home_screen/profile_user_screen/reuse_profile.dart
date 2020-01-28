import 'package:flutter/material.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';

Widget customListTile(BuildContext context, IconData icon, String title, dynamic method){
  return Container(
    padding: EdgeInsets.only(left: 19.0, right: 19.0),
    decoration: BoxDecoration(
      color: getHexaColor("#222834"),
      border: Border(
        top: BorderSide(
          width: 1, color: Colors.white.withOpacity(0.1)
        )
      )
    ),
    child: ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: Container(
        padding: EdgeInsets.all(0),
        decoration: title == "Edit Profile" ? 
        BoxDecoration( /* Add Border Only For First ListTile */
          color: getHexaColor("#EFF0F2"),
          borderRadius: BorderRadius.circular(2.0)
        ) : null,
        child: Icon(
          icon,
          color: title == "Edit Profile" ? getHexaColor("#000000") : Colors.white, //"#000000"
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
        fontWeight: FontWeight.bold,
        color: getHexaColor("#EFF0F2")),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 10.0,
        color: Colors.white,
      ),
      onTap: method,
    ),
  );
}