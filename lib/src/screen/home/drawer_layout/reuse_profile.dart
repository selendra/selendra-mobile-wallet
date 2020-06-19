import 'package:wallet_apps/index.dart';

Widget customListTile(BuildContext context, IconData icon, String title, dynamic method){
  return Container(
    padding: EdgeInsets.only(left: 19.0, right: 19.0),
    decoration: BoxDecoration(
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
        // decoration: title == "Edit Profile" ? 
        // BoxDecoration( /* Add Border Only For First ListTile */
        //   color: getHexaColor("#EFF0F2"),
        //   borderRadius: BorderRadius.circular(2.0)
        // ) : null,
        child: Icon(
          icon,
          color: Colors.white 
          // title == "Edit Profile" 
          // ? getHexaColor("#000000") 
          // : Colors.white,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          color: getHexaColor("#EFF0F2")
        ),
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