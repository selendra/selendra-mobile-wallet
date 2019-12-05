/* Flutter Package */
import 'package:wallet_apps/src/screen/home_screen/setting_screen/setting_body.dart';
import 'package:wallet_apps/src/service/services.dart';
import 'package:wallet_apps/src/store_small_data/data_store.dart';
import 'package:flutter/material.dart';
/* File Path */
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/drawer_widget.dart';

class SettingWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SettingState();
  }
}

class SettingState extends State<SettingWidget>{

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isProgress = false;
  TextEditingController fullNameControl,
  emailControl = TextEditingController(), 
  passwordControl = TextEditingController(text: "123456");
  Map<String, dynamic> userData;

  @override
  void initState() {
    super.initState();
    fetchUserDataLogin();
  }
  
  void fetchUserDataLogin() async {
    var response = await fetchData('userDataLogin');
    if(response != null) {
      setState(() {
        userData = response['queryUserById'];
        if (userData['first_name'] != null && userData['last_name'] != null ) fullNameControl = TextEditingController(text: userData['last_name']+" "+userData['first_name']); 
        emailControl = TextEditingController(text: userData['email']);
      });
    }
  } 

  /* Open Drawer Method */
  void openDrawer() => _scaffoldKey.currentState.openDrawer();

  /* Log Out Function */
  void logOut() async{
    /* Loading */
    dialogLoading(context);
    await Future.delayed(Duration(seconds: 2), () {
      clearStorage();
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  /* Trigger Snack Bar Function */
  void snackBar() {
    final snackbar = SnackBar(
      content: Text('Hello world'),
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appbarWidget(openDrawer, containerTitleAppBar('Settings'), snackBar),
      drawer: drawerOnly(context, "settingscreen", logOut),
      body: Stack(
        children: <Widget>[
          userData == null ? loading() : bodyWidget(context, userData, fullNameControl, emailControl, passwordControl)
        ],
      ),
    );
  }
  
}