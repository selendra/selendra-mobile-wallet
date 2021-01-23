import 'package:wallet_apps/index.dart';

class MenuModel {
  bool switchBio = false;
  bool authenticated;

  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  Map result = Map();

  static const List listTile = [
    {
      'title': "History",
      'sub': [
        {'icon': "assets/icons/history.svg", 'subTitle': 'History'},
        {'icon': "assets/icons/history.svg", 'subTitle': 'Activity'}
      ]
    },
    {
      'title': "Wallet",
      'sub': [
        {'icon': "assets/icons/wallet.svg", 'subTitle': 'Wallet'},
        {'icon': "assets/icons/plus.svg", 'subTitle': 'Asset'}
      ]
    },
    {
      'title': "Security",
      'sub': [
        {'icon': "assets/icons/pin_code.svg", 'subTitle': 'PIN'},
        {'icon': "assets/icons/password.svg", 'subTitle': 'Password'},
        {'icon': "assets/icons/finger_print.svg", 'subTitle': 'Finger print'}
      ]
    },
    {
      'title': "Account",
      'sub': [
        {'icon': "assets/icons/edit_user.svg", 'subTitle': 'Account'},
      ]
    },
  ];
}
