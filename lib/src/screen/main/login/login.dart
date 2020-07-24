import 'package:wallet_apps/index.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> with WidgetsBindingObserver {
  
  ModelLogin _modelLogin = ModelLogin();

  PostRequest _postRequest = PostRequest();

  Backend _backend = Backend();

  @override
  void initState() {
    AppServices.noInternetConnection(_modelLogin.globalKey);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state){

  }

  void onChanged(String label, String valueChanged) {
    _modelLogin.formState2.currentState.validate(); /* Trigger Global Key To Call Function Validate */
  }

  String validateInput(String value) { /* Initial Validate */
    if (_modelLogin.label == "email") {
      if (_modelLogin.nodeEmails.hasFocus) {
        /* If Email Field Has Focus */
        _modelLogin.responseEmailPhone = instanceValidate.validateEmails(value);
        if (_modelLogin.responseEmailPhone == null && _modelLogin.responsePassword == null)
          enableButton();
        else if (_modelLogin.enable == true)
          setState(() => _modelLogin.enable = false);
      }
    } else {
      if (_modelLogin.nodePhoneNums.hasFocus) {
        /* If Phone Number Field Has Focus */
        _modelLogin.responseEmailPhone = instanceValidate.validatePhone(value);
        if (_modelLogin.responseEmailPhone == null && _modelLogin.responsePassword == null)
          enableButton();
        else if (_modelLogin.enable == true)
          setState(() => _modelLogin.enable = false);
      }
    }
    return _modelLogin.responseEmailPhone;
  }

  String validatePassword(String value) { /* Validate User Password Input */
    if (_modelLogin.nodePasswords.hasFocus) {
      _modelLogin.responsePassword = instanceValidate.validatePassword(value);
      if (
        _modelLogin.responseEmailPhone == null &&
        _modelLogin.responsePassword == null
      ) enableButton();
      else if (_modelLogin.enable == true) setState(() => _modelLogin.enable = false);
    }
    return _modelLogin.responsePassword;
  }

  void enableButton() { /* Validate Button */
    if (_modelLogin.label == 'email') {
      if (_modelLogin.controlEmails.text != '' &&
          _modelLogin.controlPasswords.text != '')
        setState(() => _modelLogin.enable = true);
    } else {
      if (_modelLogin.controlPhoneNums.text != '' &&
          _modelLogin.controlPasswords.text != '')
        setState(() => _modelLogin.enable = true);
    }
  }

  void showPassword(bool securePassword){
    setState(() {
      _modelLogin.securePassword = securePassword;
    });
  }

  void tabBarSelectChanged(int index) { /* Tab Bar Select Change Label */
    if (index == 1) { /* Tab On Email */
      _modelLogin.controlPhoneNums.clear(); /* Make Emtpy Field */
      _modelLogin.nodePhoneNums.unfocus();

      _modelLogin.controlPasswords.clear();
      _modelLogin.nodePasswords.unfocus();

      setState(() {
        _modelLogin.enable = false;
      });
      _modelLogin.label = "email";
    } else {
      _modelLogin.controlEmails.clear();
      _modelLogin.nodeEmails.unfocus();

      _modelLogin.controlPasswords.clear(); // Make Emtpy Field
      _modelLogin.nodePasswords.unfocus();

      setState(() {
        _modelLogin.enable = false;
      });
      _modelLogin.label = "phone";
    }
    setState(() {});
  }

  void focusRequest(){
    if (_modelLogin.nodeEmails.hasFocus || _modelLogin.nodePhoneNums.hasFocus) {
      FocusScope.of(context).requestFocus(_modelLogin.nodePasswords);
    } else if (_modelLogin.enable) {
      submitLogin(context);
    }
  }

  /* -----------------------Login Method-------------------- */

  // Check Internet Before Validate And Finish Validate
  void submitLogin(BuildContext context) async { 
    dialogLoading(context);
    var response;
    try {
      if (_modelLogin.label == "email") {
        response = await _modelLogin.bloc.loginMethod(
          context,
          _modelLogin.controlEmails.text,
          _modelLogin.controlPasswords.text,
          "/loginbyemail",
          "email"
        );
      } else {
        loginByPhone();
      }
    } on SocketException catch (e) {
      await Future.delayed(Duration(milliseconds: 300), () {
        setState(() {});
      });
      Navigator.pop(context);
      AppServices.mySnackBar(_modelLogin.globalKey, AppText.contentConnection);
    } catch (e) {}

    if (response == true) {
      // AppServices.appLifeCycle(timer);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
        ModalRoute.withName('/')
      );
    }
  }
  
  void loginByPhone() async {

    _backend.response = await _postRequest.loginByPhone(_modelLogin.controlPhoneNums.text, _modelLogin.controlPasswords.text);

    _backend.decode = json.decode(_backend.response.body);

    if (_backend.response.statusCode != 502) {
      // Close Loading
      Navigator.pop(context);
      if (_backend.decode.containsKey("error")) {
        await dialog( context, textAlignCenter(text: _backend.decode['error']["message"]), textMessage());
      } else { 
        // If Successfully
        if (_backend.decode.containsKey("token")) {
          _backend.decode.addAll({
            "isLoggedIn": true
          });
          await StorageServices.setData(_backend.data, 'user_token');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Dashboard())
          );
        } else { 
          // If Incorrect Email
          await dialog( context, textAlignCenter(text: _backend.data["message"]), textMessage());
        }
      }
    } else {
      await dialog(context, textAlignCenter(text: "Something gone wrong !"), textMessage());
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _modelLogin.globalKey,
      body: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: paddingScreenWidget( /* Body Widget */
          context,
          SafeArea(
            child: loginBody(
              context,
              _modelLogin,
              validateInput,
              validatePassword,
              onChanged,
              tabBarSelectChanged,
              showPassword,
              submitLogin,
            ),
          )
        ),
      )
    );
  }
}
