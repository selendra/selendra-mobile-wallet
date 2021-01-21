/* The components file has custom widgets which are used by multiple different screens */

import 'package:wallet_apps/index.dart';

class MenuHeader extends StatelessWidget{

  final Map<String, dynamic> userInfo;

  MenuHeader({
    this.userInfo
  });

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16),
      child: SizedBox(
        height: 138,
        child: Row(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 60,
                height: 60,
                margin: EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
                  color: hexaCodeToColor(AppColors.cardColor),
                  borderRadius: BorderRadius.circular(60),
                ),
                child: SvgPicture.asset('assets/male_avatar.svg'),
              )
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText(
                  text: userInfo['first_name'] == '' && userInfo['mid_name'] == '' && userInfo['last_name'] == ''
                  ? 'User name'
                  : "${userInfo['first_name']} ${userInfo['mid_name']} ${userInfo['last_name']}",
                  color: "#FFFFFF",
                  fontSize: 16,
                ),
              ],
            )
          ],
        )
      ),
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
      padding: EdgeInsets.only(left: 16.0, top: 8, bottom: 8),
      color: hexaCodeToColor(AppColors.cardColor),
      height: 35,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: MyText(
        fontSize: 16,
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
      contentPadding: EdgeInsets.only(left: 30),
      enabled: enable,
      onTap: onTap,
      leading: SvgPicture.asset(
        MenuModel.listTile[index]['sub'][subIndex]['icon'], 
        color: Colors.white,
        width: 30, height: 30
      ),
      title: MyText(
        text: MenuModel.listTile[index]['sub'][subIndex]['subTitle'],
        color: "#FFFFFF",
        textAlign: TextAlign.left,
        fontSize: 16,
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