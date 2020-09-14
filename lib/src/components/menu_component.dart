/* The components file has custom widgets which are used by multiple different screens */

import 'package:wallet_apps/index.dart';

Widget customListTile(BuildContext context, IconData icon, String title, dynamic method,{bool maintenance = false}){
  return Container(
    padding: EdgeInsets.only(left: 19.0, right: 19.0),
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(
          width: 1, color: Colors.white.withOpacity(0.2)
        )
      )
    ),
    child: ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: Container(
        padding: EdgeInsets.all(0),
        // child: FaIcon(
        //   icon,
        //   color: Colors.white
        // ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          color: hexaCodeToColor("#EFF0F2")
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 10.0,
        color: Colors.white,
      ),
      onTap: !maintenance ? method : () async {
        await dialog(context, Text("Feature under maintenance", textAlign: TextAlign.center), Text("Message"));
      }
    ),
  );
}