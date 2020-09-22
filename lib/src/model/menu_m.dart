import 'package:wallet_apps/index.dart';

class MenuModel {

  bool switchBio = false;
  bool authenticated;

  static const List listTile = [
    {
      'title': "History",
      'sub': [
        {'icon': LineAwesomeIcons.history, 'subTitle': 'History'},
        {'icon': LineAwesomeIcons.history, 'subTitle': 'Activity'}
      ]
    },
    {
      'title': "Wallet",
      'sub': [
        {'icon': LineAwesomeIcons.history, 'subTitle': 'Wallet'},
        {'icon': LineAwesomeIcons.history, 'subTitle': 'Asset'}
      ]
    },
    {
      'title': "Security",
      'sub': [
        {'icon': LineAwesomeIcons.history, 'subTitle': 'PIN'},
        {'icon': LineAwesomeIcons.history, 'subTitle': 'Password'},
        {'icon': LineAwesomeIcons.history, 'subTitle': 'Finger print'}
      ]
    },
    {
      'title': "Account",
      'sub': [
        {'icon': LineAwesomeIcons.history, 'subTitle': 'Log out'},
      ]
    },
  ];
}