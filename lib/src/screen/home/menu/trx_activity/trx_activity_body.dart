import 'package:wallet_apps/index.dart';

class TrxActivityBody extends StatelessWidget{

  final List<dynamic> activityList;
  final Function popScreen;

  TrxActivityBody({
    this.activityList,
    this.popScreen
  });

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MyAppBar(
          title: "My activity",
          onPressed: popScreen,
        ),
        Expanded(
          child: buildListBody(activityList),
        )
      ],
    );
  }

}