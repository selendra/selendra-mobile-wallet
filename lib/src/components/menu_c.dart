/* The components file has custom widgets which are used by multiple different screens */

import 'package:wallet_apps/index.dart';

class MenuHeader extends StatelessWidget{
  Widget build(BuildContext context) {
    return Stack(
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

        Align(
          alignment: Alignment.topCenter,
          child: GestureDetector(
            onTap: (){
            },
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: hexaCodeToColor(AppColors.secondary),
                borderRadius: BorderRadius.circular(40)
              ),
              child: Icon(LineAwesomeIcons.edit, color: Colors.white),
            ),
          )
        ),
      ],
    );
  }
}

class MenuSubTitle extends StatelessWidget{

  // final String title;
  // final String subTitle;
  // final IconData icon;
  final int index;

  MenuSubTitle({
    // this.title,
    // this.subTitle,
    // this.icon
    this.index
  });

  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: hexaCodeToColor(AppColors.textColor),
        ),
        MyText(
          text: MenuModel.listTile[index]['title'],
          color: AppColors.secondary_text,
        ),
      ],
    );
  }
}

class MyListTile extends StatelessWidget{

  Function onTap;
  final int index; final int subIndex;

  MyListTile({
    @required this.index,
    @required this.subIndex,
    @required this.onTap
  });

  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        MenuModel.listTile[index]['sub'][subIndex]['icon'], 
        color: Colors.white,
        size: 30,
      ),
      title: MyText(
        left: 17,
        text: MenuModel.listTile[index]['sub'][subIndex]['subTitle'],
        color: "#FFFFFF"
      ),
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