/* The components file has custom widgets which are used by multiple different screens */

import 'package:wallet_apps/index.dart';

class MenuHeader extends StatelessWidget{
  Widget build(BuildContext context) {
    return SizedBox(
      height: 138,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 92,
              height: 92,
              decoration: BoxDecoration(
                color: hexaCodeToColor(AppColors.cardColor),
                borderRadius: BorderRadius.circular(60),
              ),
            )
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                text: 'User name'
              ),

              MyText(
                text: "username@gmail.com"
              ),
            ],
          )
        ],
      )
    );
  }
}

class MenuSubTitle extends StatelessWidget{
  
  final int index;

  MenuSubTitle({
    this.index
  });

  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(),
      padding: EdgeInsets.only(left: 16.0),
      color: hexaCodeToColor(AppColors.cardColor),
      height: 35,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: MyText(
        text: MenuModel.listTile[index]['title'],
        color: AppColors.secondary_text,
        textAlign: TextAlign.start,
      ),
    );
  }
}

class MyListTile extends StatelessWidget{

  final Function onTap;
  final int index; 
  final int subIndex;
  final Widget trailing;
  final bool enable;

  MyListTile({
    @required this.index,
    @required this.subIndex,
    this.enable = true,
    this.trailing,
    @required this.onTap
  });

  Widget build(BuildContext context) {
    return ListTile(
      enabled: enable,
      onTap: onTap,
      leading: Icon(
        MenuModel.listTile[index]['sub'][subIndex]['icon'], 
        color: Colors.white,
        size: 30,
      ),
      title: MyText(
        left: 17,
        text: MenuModel.listTile[index]['sub'][subIndex]['subTitle'],
        color: "#FFFFFF",
        textAlign: TextAlign.left,
      ),
      trailing: trailing,
    );
  }
}

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